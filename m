Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 408EA757B0D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 13:58:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232035AbjGRL6f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 07:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232206AbjGRL6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 07:58:31 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F6E1171B
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 04:58:25 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4fb5bcb9a28so8907841e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 04:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689681503; x=1692273503;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RmzXJ/X/20IP2NA5ydey9UTdXMIFoNTFLzhDsg2LXMg=;
        b=nJFiW2ZbXNxGhKubnuOrt5ngvuDj0od2YfIxKpLcORLneePwIEoJcO2ELJPoPonRgu
         XIleKJxMvqwUVlgvq6anzdvNirAbHSEx8bzzPuvUzoUgVSowNzuA5/gPg6Aahw3b121I
         vbRWlVWZJ5muJ9Wu76Q7wSvxFBe7/CyOV2pXqFLGBF25w8IvkRDv99T7sqnWvNPvjsQA
         7Ds+nGGSDZXDZJYSrqf3Z4JzUyL6J1KZA5xWUlsO3WP4AyXj44QHam8A9Wte4cetKQvR
         p039qDr9OwjYkVOZUxvHIZdxcrQgDqPq/g719tv02B0XGjLm9VnsZZS3ri/U1fzTgnDh
         oeng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689681503; x=1692273503;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RmzXJ/X/20IP2NA5ydey9UTdXMIFoNTFLzhDsg2LXMg=;
        b=gykEAz4bCSCv0mOKLRM7mpeuM2B/fcm0hvw6Vu9ha5x2kFv5qiEVdFUrSZZo2XPESe
         8puvANj1UvSNB2bOrCCNNFoVYzw4bIyE5n+IHxh72s9ycaQq7Zp7OlaLsEtMoGe+1eHl
         G97zk8izPwhbASPSLgzQxsmXKoODH1IUIL0gEE2Jhd/RyFHn35pjU2ZCa/P65SrJr+cC
         CseedKqUzFoGWkbwcVMKHphaxKwY8cbbf/XkZwAgGaO/BqfwXHqlD8o2IEAPNaab+p5v
         ubkBROamWwjP7QJgJ3oGem7rfUP7/ZyivcQo07r88RB2aykEwlI5yfQFhtbzX+WbQe/M
         Miig==
X-Gm-Message-State: ABy/qLa11myL3nF+wggDOClARyazvHPfHZmEbkOKVyRgmoNMBax/YoZV
        iVGkNJtvdKrY2bjx+ZainYf8OA==
X-Google-Smtp-Source: APBJJlHEr/9/LyGDc4PQ9CWREuuL/dRt4KsNlQE2idmsGPnKHF4L0VIePfG0k40n+cMuFT5L1d6HTg==
X-Received: by 2002:ac2:5450:0:b0:4fb:8afa:4dc9 with SMTP id d16-20020ac25450000000b004fb8afa4dc9mr9666103lfn.49.1689681503490;
        Tue, 18 Jul 2023 04:58:23 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id w5-20020aa7dcc5000000b005217a24addbsm1129824edu.20.2023.07.18.04.58.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jul 2023 04:58:23 -0700 (PDT)
Message-ID: <e1cad60d-6db0-1820-0f2e-84fd36a46555@linaro.org>
Date:   Tue, 18 Jul 2023 13:58:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] arm64: dts: allwinner: h616: Add Mango Pi MQ-Quad DTS
Content-Language: en-US
To:     Matthew Croughan <matthew.croughan@nix.how>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20230718111908.1178727-1-matthew.croughan@nix.how>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230718111908.1178727-1-matthew.croughan@nix.how>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/07/2023 13:19, Matthew Croughan wrote:
> Mango Pi MQ Quad is a H616 based SBC, add basic support for the board
> and its peripherals
> ---
>  arch/arm64/boot/dts/allwinner/Makefile        |   1 +
>  .../allwinner/sun50i-h616-mangopi-mq-quad.dts | 183 ++++++++++++++++++
>  2 files changed, 184 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h616-mangopi-mq-quad.dts
> 
> diff --git a/arch/arm64/boot/dts/allwinner/Makefile b/arch/arm64/boot/dts/allwinner/Makefile
> index 6a96494a2e0a..fbc64885ef79 100644
> --- a/arch/arm64/boot/dts/allwinner/Makefile
> +++ b/arch/arm64/boot/dts/allwinner/Makefile
> @@ -40,3 +40,4 @@ dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-tanix-tx6.dtb
>  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-tanix-tx6-mini.dtb
>  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h616-orangepi-zero2.dtb
>  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h616-x96-mate.dtb
> +dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h616-mangopi-mq-quad.dtb

Keep alphabetical order.

> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h616-mangopi-mq-quad.dts b/arch/arm64/boot/dts/allwinner/sun50i-h616-mangopi-mq-quad.dts
> new file mode 100644
> index 000000000000..752e5296c4af
> --- /dev/null
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h616-mangopi-mq-quad.dts
> @@ -0,0 +1,183 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +// Copyright (C) 2020 Arm Ltd.
> +/*
> + * Copyright (C) 2023 Matthew Croughan <matthew.croughan@nix.how>
> + */
> +
> +/dts-v1/;
> +
> +#include "sun50i-h616.dtsi"
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/leds/common.h>
> +
> +/ {
> +	model = "MangoPi MQ-Quad";
> +	compatible = "allwinner,sun50i-h616";

Missing board compatible, missing bindings.

> +



Best regards,
Krzysztof

