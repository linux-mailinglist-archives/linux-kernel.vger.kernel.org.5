Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE4817FEBD9
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 10:29:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231929AbjK3J3G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 04:29:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjK3J3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 04:29:04 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C557DC
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 01:29:10 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-a00f67f120aso93405866b.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 01:29:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701336548; x=1701941348; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HlPaWYhCGlwV4il3F6O0Kb9pqVQr1UFc369PfCtXOW0=;
        b=BDsgNmm47QF1Cd+h+1+YjQfV+nqwCCiSdduZYCXPojlJmx4qU1TXGspURklVY0bd1B
         pinxOs5rEdKv4tmW1YP2ZI4ofESmJzthfpglJIUH+16SrDl9gvQy8sTxQqZb9xGDU5EM
         YfOndHEN7efBY2LJTDPuKkDiumQREK94C534cW4zJCNxJ+TE+ZysH/blsfP55t0W0RJL
         mMheUgOP9wEHmTKPQcQxPGWydWhn9FgEi8eTly7vLJv5OrxMg5A++DURYo9Zuzv/Y1jn
         VnJdfB1Kwwmuxla+F6JYfjXq1m6jqN7IAnLpBSj8ykeUab1FnQHvjpElPGM5IFuUBNO/
         U4Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701336548; x=1701941348;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HlPaWYhCGlwV4il3F6O0Kb9pqVQr1UFc369PfCtXOW0=;
        b=U150fTJkSWLmUdyg0iC4BR51U0VAFbv7FCDmp4+Vwd4UwEwQyi7RsSXetV8xZiV8N5
         2HXRdXzHActf0jmopp+wUOCP0cNDfZfig/gKaNR0+b0YNu+YzAMMZ2srOB693PE5GD96
         CLtG94HApbycWzwQ7zktewkjxGc7djb+8+XeculY8Tl8Ge4re45Nrj/HPNTCXhJfFbhS
         +8fOiO/KqboAtMIDXhC/IoHlKMM8vcAElz7DamQxqx7Zj19UGJJgH7XGjuxtxIAnVEuQ
         RXBWNsOQwswYsAVprrxEnbxJQD1cPXA8LBoXEetZIWv3J1b9/ebxKNTovHMSVnXoWJ8e
         vHrA==
X-Gm-Message-State: AOJu0Yy+CpUXTxo7NxNW9gneAfU5paPYeS2dViGJjADBVwGZyX4zl/oE
        syFu93VRrPU0hWW6sFzmvTaH5y8PMkOlExG+9Ys=
X-Google-Smtp-Source: AGHT+IHVyMDTzQbcNrjN3KNPhQHI/Ps6tJWGHf/S35CIaJS0yKsbZAZTRs+KvEDb7O0mfnkNHhiTbQ==
X-Received: by 2002:a17:906:5349:b0:9be:481c:60bf with SMTP id j9-20020a170906534900b009be481c60bfmr15874693ejo.55.1701336548485;
        Thu, 30 Nov 2023 01:29:08 -0800 (PST)
Received: from [192.168.1.20] ([178.197.223.109])
        by smtp.gmail.com with ESMTPSA id dx9-20020a170906a84900b009fbc655335dsm472465ejb.27.2023.11.30.01.29.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Nov 2023 01:29:08 -0800 (PST)
Message-ID: <79f65b96-9015-41c4-b4ee-a82526c9eefc@linaro.org>
Date:   Thu, 30 Nov 2023 10:29:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: zynqmp: Add missing destination mailbox compatible
Content-Language: en-US
To:     Michal Simek <michal.simek@amd.com>, linux-kernel@vger.kernel.org,
        monstr@monstr.eu, michal.simek@xilinx.com, git@xilinx.com
Cc:     Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        Parth Gajjar <parth.gajjar@amd.com>,
        Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>,
        Varalaxmi Bingi <varalaxmi.bingi@amd.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <96460adbb99ea829a2a95c72a40118f81946a559.1701335951.git.michal.simek@amd.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <96460adbb99ea829a2a95c72a40118f81946a559.1701335951.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/11/2023 10:19, Michal Simek wrote:
> The commit 81186dc16101 ("dt-bindings: zynqmp: add destination mailbox
> compatible") make compatible string for child nodes mandatory that's why
> add it.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>  arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> index f5e1eb8cb3b7..eaba466804bc 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> @@ -141,6 +141,7 @@ zynqmp_ipi: zynqmp-ipi {
>  
>  		ipi_mailbox_pmu1: mailbox@ff9905c0 {
>  			bootph-all;
> +			compatible = "xlnx,zynqmp-ipi-dest-mailbox";

Probably you want it as first property. Although then reg is also placed
odd, but it's all because bootph-all was put at the beginning.

Best regards,
Krzysztof

