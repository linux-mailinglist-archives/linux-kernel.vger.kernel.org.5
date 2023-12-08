Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D871680AB2D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 18:52:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574511AbjLHRwf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 12:52:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233802AbjLHRwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 12:52:33 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEDCC198D
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 09:52:37 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-a1d450d5c11so305941566b.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 09:52:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702057956; x=1702662756; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xkhmRAvfj7JG1PYVYwn3xPw0RGuzqBpzvxVYSfgiaFU=;
        b=niO11TFjeMjKb34ChizWVszeEqJdev+njoZ2At0m1cgBSI1ryyU+pbeVF4+GLj9ozs
         IAJd5HvqysXzpJ9DZyUAcm0WKlhYGQu1bqwc40n0LZw0of7Qkv+FHUAgMEtB3AhXuQR6
         KgYLHXety9vNPiPqk5Wyszjkzr5BAgM1xodMVMx95Xhxsz+6fcab7GVrIYr9HJ2RjJyc
         Gl4HNMyOXk8AkoQTXCPjphi6EtIdXG0+upmOEP6RPAXPhXJmd308fdojRJQiF8mnL2hL
         KxIquwDpv9Bq4QklmPTM+b83ZpwMIqstDhj8WvrDmivkjv6Rjvb2VNFlYeHEdLHVU+gS
         edNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702057956; x=1702662756;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xkhmRAvfj7JG1PYVYwn3xPw0RGuzqBpzvxVYSfgiaFU=;
        b=xB+r8EWrjlkSil6fvWLvGVTliH2/SkRYOlX79ZsfYn4JPonGedAgQqYp6m1KZH/SX1
         pBhLlvjm/AzW7ZUVUqShlrjp/JfaMjuYkxI/b3Xi08xDEPEpaFK/7fKy16kIY4CKAZF/
         OuqeU7mOCpRH93YrHyYRtUghcrp83Bgs6NjgJ7il/u9gaHOWZI6GEJ+b7GPDyJzRzIn7
         bfUJN8XJzaEOXl/W25kyNbppls+J0lddko+kDkXgQ8Q5aCHheqv7yxLhicgbwsf2sSxZ
         x+mRICFLYDyqKrGt8Kw1JrYjqpHpXZJdFOqdPIR1R8oQ6FHa+LLxKsMBmcfWsFAgJYTk
         NHWg==
X-Gm-Message-State: AOJu0YxqdaJEBGJIuQ2xrv9giacHAAba73CQ3FmMbtI/2G5QiLLB6Y3L
        h+CoEuA2L9uGW7o+ca3MVTziBw==
X-Google-Smtp-Source: AGHT+IFZRw+6ipWfmU4/QV9prwwth2dduKWLodo8shrbb7og17aCelwekR0lM0ONyzliuZFvR1M39w==
X-Received: by 2002:a17:906:c20e:b0:9e6:38f2:8439 with SMTP id d14-20020a170906c20e00b009e638f28439mr162651ejz.60.1702057956400;
        Fri, 08 Dec 2023 09:52:36 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id rf19-20020a1709076a1300b00a1f75d21bf3sm498896ejc.6.2023.12.08.09.52.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Dec 2023 09:52:35 -0800 (PST)
Message-ID: <1ebb4733-0f1d-46ea-b399-34af7df088ac@linaro.org>
Date:   Fri, 8 Dec 2023 18:52:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 05/16] dt-bindings: clock: Add StarFive JH8100 System
 clock and reset generator
Content-Language: en-US
To:     Sia Jee Heng <jeeheng.sia@starfivetech.com>, kernel@esmil.dk,
        conor@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, mturquette@baylibre.com,
        sboyd@kernel.org, p.zabel@pengutronix.de,
        emil.renner.berthing@canonical.com, hal.feng@starfivetech.com,
        xingyu.wu@starfivetech.com
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        leyfoon.tan@starfivetech.com
References: <20231206115000.295825-1-jeeheng.sia@starfivetech.com>
 <20231206115000.295825-6-jeeheng.sia@starfivetech.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20231206115000.295825-6-jeeheng.sia@starfivetech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/12/2023 12:49, Sia Jee Heng wrote:
> Add bindings for the System clocks and reset generator
> (SYSCRG) on JH8100 SoC.
> 
> Signed-off-by: Sia Jee Heng <jeeheng.sia@starfivetech.com>
> Reviewed-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>
> ---

...

> +  clocks:
> +    items:
> +      - description: Main Oscillator (24 MHz)
> +      - description: External I2S Rx BCLK clock
> +      - description: External I2S Rx LRCK clock
> +      - description: External MCLK clock
> +
> +  clock-names:
> +    items:
> +      - const: clk_osc
> +      - const: clk_i2srx_bclk_ext
> +      - const: clk_i2srx_lrck_ext
> +      - const: clk_mclk_ext

Drop clk_ prefixes everywhere.

> +
> +  '#clock-cells':
> +    const: 1
> +    description:
> +      See <dt-bindings/clock/starfive,jh8100-crg.h> for valid indices.
> +
> +  '#reset-cells':
> +    const: 1
> +    description:
> +      See <dt-bindings/reset/starfive-jh8100-crg.h> for valid indices.
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - '#clock-cells'
> +  - '#reset-cells'
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/starfive,jh8100-crg.h>
> +
> +    clock-controller@126d0000 {
> +            compatible = "starfive,jh8100-syscrg";

Use 4 spaces for example indentation.

> +            reg = <0x126d0000 0x10000>;
> +            clocks = <&clk_osc>, <&clk_i2srx_bclk_ext>,
> +                     <&clk_i2srx_lrck_ext>, <&clk_mclk_ext>;
> +            clock-names = "clk_osc", "clk_i2srx_bclk_ext",
> +                          "clk_i2srx_lrck_ext", "clk_mclk_ext";
> +            #clock-cells = <1>;
> +            #reset-cells = <1>;
> +    };
> diff --git a/include/dt-bindings/clock/starfive,jh8100-crg.h b/include/dt-bindings/clock/starfive,jh8100-crg.h
> new file mode 100644
> index 000000000000..e5bb588ce798
> --- /dev/null
> +++ b/include/dt-bindings/clock/starfive,jh8100-crg.h
> @@ -0,0 +1,123 @@
> +/* SPDX-License-Identifier: GPL-2.0 OR MIT */

How about keeping the same license as binding?

> +/*
> + * Copyright (C) 2023 StarFive Technology Co., Ltd.
> + * Sia Jee Heng <jeeheng.sia@starfivetech.com>
> + *
> + */
> +

...

> +#define SYSCRG_CLK_NNE_ICG_EN						108
> +
> +#define SYSCRG_CLK_END							109

Drop from binding header.

> +#endif /* __DT_BINDINGS_CLOCK_STARFIVE_JH8100_H__ */

...

> + */
> +#define SYSCRG_RSTN_SYS_SYSCON					0
> +#define SYSCRG_RSTN_CLK_MOD					1
> +#define SYSCRG_RSTN_GPU						2
> +#define SYSCRG_RSTN_GPU_SPU					3
> +#define SYSCRG_RSTN_GPU_TVSENSOR				4
> +#define SYSCRG_RSTN_PPU_OP_NORET_GPU_RESET			5
> +#define SYSCRG_RSTN_NNE						6
> +#define SYSCRG_RSTN_HD_AUDIO					7
> +
> +#define SYSCRG_RESET_NR_RESETS					8

Drop from binding header.

> +
> +#endif /* __DT_BINDINGS_RESET_STARFIVE_JH8100_H__ */

Best regards,
Krzysztof

