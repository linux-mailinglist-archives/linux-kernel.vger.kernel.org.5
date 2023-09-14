Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37C5979FBE2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 08:27:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232862AbjING1l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 02:27:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjING1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 02:27:40 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5D66F9
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 23:27:35 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-9a648f9d8e3so79828666b.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 23:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694672854; x=1695277654; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SvJPiborPazhY3z/eKkSPzi9+TFXrHaaVb21iB43NoQ=;
        b=Kt5Tw5KR9yw442FFTMzUcHXDs7uzfWT+mNEtIECVVpNzH8SFpWcs09yMVwD7e6tp34
         ptKbVPIEBSAtR85/HXRaw+s4MsR6KRJ8V1eXou9qz0HJiGEgiPgXU1r2+OIwShuLLAa3
         zqZqmU13K2FUsIo57K0W11N1R7sEQgsyNyw1zO7EYOOZG5BWI0xFdaKmwYzZgtOIZaPZ
         o5hPfPnTpHVDvZDl/N2DQkLBb9PYAen1/KnlABwl7R3JmEmINJseHxUyq51MUTapAN8B
         kfrSz9RBwzF6uPGabJXVmSZss5paewZ3WAwKEEogqHSBmMilR6rVi+TH2Zmrb3R6KFW6
         7mog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694672854; x=1695277654;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SvJPiborPazhY3z/eKkSPzi9+TFXrHaaVb21iB43NoQ=;
        b=PFQ69Pk32hzZUkd/WLFdbE+ROEPoG4p+Hl7n3RAVZhylczpSxor7q36/gEzXHWg+h6
         HfP7TiKQBYPEdW5Zvz+kc6cBnjygJI6vtOUJcXtEF4iJFBKrpKo4jotQ6od/UuVlTm3q
         DW/ynFA829DeTUAE9LHRr7pALW4i1HHNRgEWaV5gEiTMZdmJbhSUd00fwcwGMiV5wjPz
         4z8PdMBT9lUQvmzr2THbLcEdWBqy1tG8ZkBZoqO4or+DHeWl7LRxkcEuciD5V827dY49
         H5J5O39zsLSAisOmhYjAwHxw+z138aQPUX/KQMSXxHA85Bc+0gCGPqaCdKqlZp8G5Rkj
         IHiA==
X-Gm-Message-State: AOJu0Yx4y7dsFGGnfJt5iBSKBV8sZV91hJnVgx8ELX3VvvstGqThq87Q
        +3TgtBCZ9k0j/FhQ2O+8vrFnuQ==
X-Google-Smtp-Source: AGHT+IGPactfC2yeS6QW7dJXDUIVllwKVb9ZV2x84EqGoOiQTTqwSd/i3KRUMgYtnIcrqxiZZV4dKA==
X-Received: by 2002:a17:906:3091:b0:9a5:c944:8e71 with SMTP id 17-20020a170906309100b009a5c9448e71mr3578755ejv.60.1694672854226;
        Wed, 13 Sep 2023 23:27:34 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id mh25-20020a170906eb9900b0099297782aa9sm517731ejb.49.2023.09.13.23.27.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Sep 2023 23:27:33 -0700 (PDT)
Message-ID: <32c82fa2-f8b9-d22d-f0ac-f8d6e48df39d@linaro.org>
Date:   Thu, 14 Sep 2023 08:27:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 1/3] arm64: dts: ti: Add GPMC NAND support
Content-Language: en-US
To:     Nitin Yadav <n-yadav@ti.com>, nm@ti.com, vigneshr@ti.com,
        rogerq@ti.com
Cc:     kristo@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230913114711.2937844-1-n-yadav@ti.com>
 <20230913114711.2937844-2-n-yadav@ti.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230913114711.2937844-2-n-yadav@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/09/2023 13:47, Nitin Yadav wrote:
> Add support for AM62Q NAND card: X8 NAND EXPANSION
> BOARD card (PROC143E1) for AM62x LP SK board.
> 
> Signed-off-by: Nitin Yadav <n-yadav@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-am62-main.dtsi | 29 ++++++++++++++++++++++++
>  arch/arm64/boot/dts/ti/k3-am62.dtsi      |  2 ++
>  2 files changed, 31 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
> index 284b90c94da8..e93e79d8083f 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
> @@ -955,4 +955,33 @@ mcasp2: audio-controller@2b20000 {
>  		power-domains = <&k3_pds 192 TI_SCI_PD_EXCLUSIVE>;
>  		status = "disabled";
>  	};
> +	gpmc0: memory-controller@3b000000 {
> +		status = "disabled";

status is never first in DTSI. Really, where did you see such code?

> +		compatible = "ti,am64-gpmc";
> +		power-domains = <&k3_pds 80 TI_SCI_PD_EXCLUSIVE>;

First is compatible, second is reg/reg-names/ranges.


Best regards,
Krzysztof

