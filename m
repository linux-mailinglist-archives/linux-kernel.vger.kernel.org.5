Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6019179C7A4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 09:05:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbjILHF4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 03:05:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230306AbjILHFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 03:05:54 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5463E79
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 00:05:50 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3ff7d73a6feso55671355e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 00:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694502349; x=1695107149; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=abf20X51QpaxCmfFqohWdZjGU9OAwdJ8woGP6ojQAng=;
        b=pdvpJRRSYkEUWKfPcoUyIoTWGfmLtgiOeMcENcqhjCDkfLDz9bj9afKSwjvcuJGVxz
         0Q/ZCuZMPVsI64C77ovHqo5uyXe2B9VSogBkJTXYdIfpmQovLIrYJqQJpCmJc/QCZ5MR
         XLSOPzF/zPYpTqpnOyjl3eqq1a+Z9yojCrVdSBeb9Uwt2pl6NueBg4R/CHpSTxvLeMsd
         byAIRqFra/BDDQdAv6/h5YG0dPrwgFN9R5Lqk2ikQiY8AW6G6z0IITgJESdRy/cDuRIo
         kEr98g6R8gpaKObXPDphoIWgFSuBTFT1EVJ9sclqJQuzV5z/+ehDRiv9jwYI0wunCqSs
         WEig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694502349; x=1695107149;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=abf20X51QpaxCmfFqohWdZjGU9OAwdJ8woGP6ojQAng=;
        b=Ix7dKIpq5vvz4vtobqTkVTPL3X4l+HOQyC9hL8Iv5F5KAEX8X95Dzls1u79lFVLle/
         yXVZSrCo+ibycU2ulp3pHaj2zA8yyjz5JRw1Es69BcYmeYU1s9f8dRfPpJH0+F/04W/p
         xTumFrXrmocQ7Aef873eQEdOQd7iQ9FDos01AW4ucjjSNMaC/FX28mE+yr/jrlnURj7i
         jjhRozMF6UaEZLRIzVwRGvVZJiBuzIE210LSEiJVp6Gnn8+eqpxulnNiygtR9f1Oc+Ee
         ynI5NqoklTLipLacn3O83DTL/ddXQv2BZzMeRzsTkMFJD3FqGtf3GOeJXT1I+ZZRvUoV
         HVDA==
X-Gm-Message-State: AOJu0Yw13OKqXD8cfID37grrD7ldKzDZ++1CqniEwqgwqLRGY5X+A3Va
        264wux1HCpidg6Ih/iyQEJ9MOA==
X-Google-Smtp-Source: AGHT+IHsWhukm75MZJtf0oYf0IcV35LSdNy1YT4k1P9PQf5XKhHvKQh5+lOWfVKm+wu6gPF1yE6Ing==
X-Received: by 2002:a05:600c:1ca7:b0:403:855:d0d2 with SMTP id k39-20020a05600c1ca700b004030855d0d2mr6220135wms.41.1694502349187;
        Tue, 12 Sep 2023 00:05:49 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id p23-20020a05600c205700b003fe1fe56202sm11926563wmg.33.2023.09.12.00.05.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Sep 2023 00:05:48 -0700 (PDT)
Message-ID: <ee81ff75-c6db-9a1a-2bca-f509ab4499d8@linaro.org>
Date:   Tue, 12 Sep 2023 09:05:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 3/3] riscv: dts: Add th1520 reset device tree
Content-Language: en-US
To:     k.son@samsung.com, p.zabel@pengutronix.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        jszhang@kernel.org, guoren@kernel.org, wefu@redhat.com,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, inki.dae@samsung.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
References: <20230912024914.3769440-1-k.son@samsung.com>
 <CGME20230912024917epcas1p2076a3a0674ae94e8c8641cc9eb617eac@epcas1p2.samsung.com>
 <20230912024914.3769440-4-k.son@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230912024914.3769440-4-k.son@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/09/2023 04:49, k.son@samsung.com wrote:
> From: Kwanghoon Son <k.son@samsung.com>
> 
> Add reset device tree for th1520 SoC
> 
> Signed-off-by: Kwanghoon Son <k.son@samsung.com>
> ---
>  arch/riscv/boot/dts/thead/th1520.dtsi | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/riscv/boot/dts/thead/th1520.dtsi b/arch/riscv/boot/dts/thead/th1520.dtsi
> index ce708183b6f6..7e592449b5e4 100644
> --- a/arch/riscv/boot/dts/thead/th1520.dtsi
> +++ b/arch/riscv/boot/dts/thead/th1520.dtsi
> @@ -5,6 +5,7 @@
>   */
>  
>  #include <dt-bindings/interrupt-controller/irq.h>
> +#include <dt-bindings/reset/th1520-reset.h>
>  
>  / {
>  	compatible = "thead,th1520";
> @@ -418,5 +419,12 @@ portf: gpio-controller@0 {
>  				interrupts = <55 IRQ_TYPE_LEVEL_HIGH>;
>  			};
>  		};
> +
> +		rst: reset-controller@ffef014000 {
> +			compatible = "thead,th1520-reset", "syscon";
> +			reg = <0xff 0xef014000 0x0 0x1000>;
> +			#reset-cells = <1>;
> +			status = "okay";

Drop, it's by default. Look at the other nodes - they do not have it, so
neither this node should.

Best regards,
Krzysztof

