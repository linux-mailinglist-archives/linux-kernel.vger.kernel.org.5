Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8E4378CB36
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 19:26:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbjH2R0G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 13:26:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237897AbjH2RZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 13:25:44 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DA0CE46
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 10:25:12 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-99c1c66876aso601165266b.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 10:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693329864; x=1693934664;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lwYxLCmq4WNewekZRDSH3zyJGGPJlZo2Lv6o2KdH/x4=;
        b=XR/x7QreIC9a3vw0Fm8SBKNI34BtJGrwGND3E56garHi/QNkLSQw4vKa7pSvrQyZgR
         6XjRTbwimbqxMQ48SvZI3SklfZW6A8sMVSaiEf1mqEy9ANYBIFrn6R7zoySFzESBYAUV
         QCELFjd+xWi4UmBJjNWRD4vjlwCek5R/7SOs3TJevBENMj2odwf+tGnuuEOML9nJxusf
         WCWi9STezp4UP1rjM6w0bubynUs0dJkTpQIIhEgqvp6DrtssTg4dIZ1tCPPbe1FIL/QJ
         orrc5VqwiQxgr/gjwAV/tqVz91+lwyJmO4UbNlnWLMYFRBiE0qLQDPv0xj2h3tzgkMI4
         +QWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693329864; x=1693934664;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lwYxLCmq4WNewekZRDSH3zyJGGPJlZo2Lv6o2KdH/x4=;
        b=KqUbPAlIVBXl9Qhirj0AQr7zM8FxQDh7RA+brTvtiNk/k1QIwHQQdiP68vLwWnJiz2
         TrQJ9t1554+5fE2a2aRpd0w6yhFNkDuJtMueRErcdZVM4prPW6tQoe+NkZcLWaot4Mkd
         U0WQoXK4uZzxiVWiG4mKSHKh2TISplpsoSH5J63Z32YN3yNC+njVaerABVzHxxh3H6kt
         AdLgG5IUaTbJIksVg8U6zhsefm/4rhtMPWy7ubQyP5Uv19n75qJkWmPUGnirhHnazs0O
         bqLNCMzsjc+WYMFaYbD8Dsqn0qOsnkvSeKibK2+8pZ37HF9K60OC+o1lM8D5Zmukk/sq
         V4ig==
X-Gm-Message-State: AOJu0Yz8leCdk8EUuxo4SqzwXL7lPXbd4nyynrwiU4oPPI3IU9Kc2z8B
        wJb1wxqQ81sXjxBAua94M6ZjgQ==
X-Google-Smtp-Source: AGHT+IEM0PsjzjMAivcpu6BoCzHNvy2N09Jh9i35jA0fAreHjTJNVGm2qi/an6qJc1fpcsGWEgWCZA==
X-Received: by 2002:a17:906:5346:b0:9a2:1ce5:1243 with SMTP id j6-20020a170906534600b009a21ce51243mr12610741ejo.60.1693329864004;
        Tue, 29 Aug 2023 10:24:24 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.196])
        by smtp.gmail.com with ESMTPSA id rh22-20020a17090720f600b0099bc80d5575sm6132481ejb.200.2023.08.29.10.24.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Aug 2023 10:24:23 -0700 (PDT)
Message-ID: <89955853-c38a-cabc-e5dd-8582487b8fc9@linaro.org>
Date:   Tue, 29 Aug 2023 19:24:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 15/31] ARM: dts: rockchip: Split RK3128 devictree for
 RK312x SoC family
Content-Language: en-US
To:     Alex Bee <knaerzche@gmail.com>, Heiko Stuebner <heiko@sntech.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Lee Jones <lee@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>
Cc:     Elaine Zhang <zhangqing@rock-chips.com>,
        Johan Jonker <jbx6244@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, alsa-devel@alsa-project.org,
        linux-clk@vger.kernel.org, linux-phy@lists.infradead.org
References: <20230829171647.187787-1-knaerzche@gmail.com>
 <20230829171647.187787-16-knaerzche@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230829171647.187787-16-knaerzche@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/08/2023 19:16, Alex Bee wrote:
> Currently there is only a SoC devicetree for RK3128 although RK312x
> SoC family consits of (at least) RK3126(C) and RK3128.
> 
> This splits up the currently existing rk3128.dtsi in rk312x.dtsi which
> contains the common definitions for both SoCs and rk3128.dtsi, rk3126.dtsi
> respectivly.

typos here and before

> 
> The differentiation between rk3126/rk3128 is already taken into account
> in the clock driver and they have their own compatibles.
> uart0 and i2c3 exist only in rk3128 SoC, thus they are moved to the new
> rk3128.dtsi.
> 
> Signed-off-by: Alex Bee <knaerzche@gmail.com>
> ---
>  arch/arm/boot/dts/rockchip/rk3126.dtsi |   9 +
>  arch/arm/boot/dts/rockchip/rk3128.dtsi | 894 +------------------------
>  arch/arm/boot/dts/rockchip/rk312x.dtsi | 893 ++++++++++++++++++++++++

Please generate your patches with proper -M/-B/-C arguments to detect
the rename/copy.

>  3 files changed, 909 insertions(+), 887 deletions(-)
>  create mode 100644 arch/arm/boot/dts/rockchip/rk3126.dtsi
>  create mode 100644 arch/arm/boot/dts/rockchip/rk312x.dtsi
> 
> diff --git a/arch/arm/boot/dts/rockchip/rk3126.dtsi b/arch/arm/boot/dts/rockchip/rk3126.dtsi
> new file mode 100644
> index 000000000000..7345bd95d29d
> --- /dev/null
> +++ b/arch/arm/boot/dts/rockchip/rk3126.dtsi
> @@ -0,0 +1,9 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +
> +/dts-v1/;
> +
> +#include "rk312x.dtsi"
> +
> +/ {
> +	compatible = "rockchip,rk3126";
> +};
> diff --git a/arch/arm/boot/dts/rockchip/rk3128.dtsi b/arch/arm/boot/dts/rockchip/rk3128.dtsi
> index f3f0788195d2..4c5c9728179e 100644
> --- a/arch/arm/boot/dts/rockchip/rk3128.dtsi
> +++ b/arch/arm/boot/dts/rockchip/rk3128.dtsi
> @@ -1,360 +1,11 @@
> -// SPDX-License-Identifier: GPL-2.0+
> -/*
> - * (C) Copyright 2017 Rockchip Electronics Co., Ltd
> - */
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)

This looks like relicensing, so without proper diff (see comment before)
it is a no-go.

>  
> -#include <dt-bindings/clock/rk3128-cru.h>
> -#include <dt-bindings/gpio/gpio.h>
> -#include <dt-bindings/interrupt-controller/arm-gic.h>
> -#include <dt-bindings/interrupt-controller/irq.h>
> -#include <dt-bindings/pinctrl/rockchip.h>
> +/dts-v1/;
> +
> +#include "rk312x.dtsi"
>  
>  / {
>  	compatible = "rockchip,rk3128";
> -	interrupt-parent = <&gic>;
> -	#address-cells = <1>;
> -	#size-cells = <1>;
> -
> -	arm-pmu {
> -		compatible = "arm,cortex-a7-pmu";
> -		interrupts = <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>,
> -			     <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>,
> -			     <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>,
> -			     <GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>;
> -		interrupt-affinity = <&cpu0>, <&cpu1>, <&cpu2>, <&cpu3>;
> -	};
> -
> -	cpus {
> -		#address-cells = <1>;
> -		#size-cells = <0>;
> -
> -		cpu0: cpu@f00 {
> -			device_type = "cpu";
> -			compatible = "arm,cortex-a7";
> -			reg = <0xf00>;
> -			clock-latency = <40000>;
> -			clocks = <&cru ARMCLK>;
> -			operating-points = <
> -				/* KHz    uV */
> -				 816000 1000000
> -			>;
> -			#cooling-cells = <2>; /* min followed by max */
> -		};

All this patch is absolutely unreadable and unreviewable. Sorry, use the
tools to make review possible.



Best regards,
Krzysztof

