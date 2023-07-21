Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EE1E75C4E9
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 12:43:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231199AbjGUKnb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 06:43:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231745AbjGUKnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 06:43:14 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6CF2171E
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 03:43:12 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-3110ab7110aso1506145f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 03:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689936191; x=1690540991;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=10U4fK1s3xSb0xE9SC0kNza6kl90rPnqzrVj/rW25sA=;
        b=ylegs2eQ1FV4JkZAMkdbyfVbgKsFznHRW3MP7u/ObABBMG1slmHz5LpzO78kVwHd9L
         wz2d1lIYpN082F74Q8YPFHg2fx9ArEKmSDGtp21GAr2QxymgetMUc+9yJT9Ejf0rPoJD
         Tr5YtbxYjEFoTqqhVwn9+SgorgrUlxAeeNx1PsT0eSDKNMi0mWj0B+NA6qEryk4DYep+
         Z/WKDzY+KRipQ3tpZ4g2X+3jTxW4CD2TiiOIpW3fekolkSg6vU6RYuZaUxjy5sfAOBKF
         3CGMZsChEQ971aHhLt1woOScZsSuXsyl9iVZhbNsxdEa4PmqgCXBMyti4midHNQty3uB
         ++VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689936191; x=1690540991;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=10U4fK1s3xSb0xE9SC0kNza6kl90rPnqzrVj/rW25sA=;
        b=CCqrRFvSAV4lLX5lKIKqBkclOmuVB0+ABiKOB6EUjsesfXNZe1dmIVxGFAb1ya0jzA
         DEtLjt4GukRBDfWpksncwGttGQJScVB4HF8LWFKoO8x5Ww4iaMwl0osuUu0r0DJd6A4+
         gGNFCTrqw7j90EgKYHBW3knW5Y+PUbCUr/vmqcDC/5m7YgQcBqLAkl8aPxN0lgJoOnv0
         qs/3w9uokTy5uZruMsx31nOU+iEHz3U4VU7YRQOV49gbWmxbcdVdjBRprcUoESC5WuwK
         bhuiC8lk9SWtRBB0M+A8qnjXgptBheyJiWIw/p2xm6VTyWEsVLt1crvm78uBSnpmV671
         lSBA==
X-Gm-Message-State: ABy/qLaLAWXCPzwpDhdzdbj/jHQeaWNx9pUetJp32MigrW2Tkqrc2A66
        JHubbWZ0/Lj7qN1x5aOMicJBFQ==
X-Google-Smtp-Source: APBJJlHtzj78AEfrCX5x9slxz9FuK7svnQZ70Nm2fRzgMaNUv6jWNt3kQ7ifiimBxePqGKVOpod34g==
X-Received: by 2002:a5d:6086:0:b0:314:39d0:26f6 with SMTP id w6-20020a5d6086000000b0031439d026f6mr1289165wrt.18.1689936191292;
        Fri, 21 Jul 2023 03:43:11 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id x13-20020a5d60cd000000b0030ada01ca78sm3843492wrt.10.2023.07.21.03.43.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jul 2023 03:43:10 -0700 (PDT)
Message-ID: <3492152a-d668-54ba-7cb4-4db8bfec6f03@linaro.org>
Date:   Fri, 21 Jul 2023 12:43:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v6 2/3] ARM: dts: imx6qdl: Add Variscite VAR-SOM-MX6 SoM
 support
Content-Language: en-US
To:     James Hilliard <james.hilliard1@gmail.com>,
        devicetree@vger.kernel.org
Cc:     Gregory CLEMENT <gregory.clement@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Marek Vasut <marex@denx.de>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Stefan Wahren <stefan.wahren@chargebyte.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Andreas Kemnade <andreas@kemnade.info>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        Li Yang <leoyang.li@nxp.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230721103350.3684483-1-james.hilliard1@gmail.com>
 <20230721103350.3684483-2-james.hilliard1@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230721103350.3684483-2-james.hilliard1@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/07/2023 12:33, James Hilliard wrote:
> This patch adds support for the Variscite VAR_SOM-MX6 SoM with :
> - i.MX6 Quad or Dual Lite SoC
> - 256 – 4096 MB DDR3
> - 4-64 GB eMMC
> - 128 – 1024 MB SLC NAND
> - Camera Interface
> - HDMI+CEC interface
> - LVDS / DSI / Parallel RGB interfaces
> - Ethernet RGMII interface
> - On-SoM Wi-Fi/Bluetooth with WiLink wl183x SDIO Module
> - SD/MMC/SDIO interface
> - USB Host + USB OTG interface
> - I2C interfaces
> - SPI interfaces
> - PCI-Express 2.0 interface
> - on-SoM Audio Codec with HP/Line-In interfaces + DMIC interface
> - Digital Audio interface
> - S/PDIF interface
> 
> Product website : https://www.variscite.com/product/system-on-module-som/cortex-a9/var-som-mx6-cpu-freescale-imx6/
> 
> Support is handled with a SoM-centric dtsi exporting the default interfaces
> along the default pinmuxing to be enabled by the board dts file.
> 
> This file is based on the one provided by Variscite on their own
> kernel, but adapted for mainline.
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> ---
>  .../arm/boot/dts/nxp/imx/imx6qdl-var-som.dtsi | 544 ++++++++++++++++++
>  1 file changed, 544 insertions(+)
>  create mode 100644 arch/arm/boot/dts/nxp/imx/imx6qdl-var-som.dtsi
> 
> diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-var-som.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-var-som.dtsi
> new file mode 100644
> index 000000000000..a7d2aecd83fe
> --- /dev/null
> +++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-var-som.dtsi
> @@ -0,0 +1,544 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Support for Variscite VAR-SOM-MX6 Module
> + *
> + * Copyright 2011 Linaro Ltd.
> + * Copyright 2012 Freescale Semiconductor, Inc.
> + * Copyright (C) 2014-2016 Variscite, Ltd.
> + * Author: Donio Ron <ron.d@variscite.com>
> + * Copyright 2022 Bootlin
> + */
> +
> +/dts-v1/;
> +
> +#include "imx6q.dtsi"
> +#include <dt-bindings/clock/imx6qdl-clock.h>
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/sound/fsl-imx-audmux.h>
> +
> +/ {
> +	model = "Variscite VAR-SOM-MX6 module";
> +	compatible = "variscite,var-som-imx6q", "fsl,imx6q";
> +
> +	chosen {
> +		stdout-path = &uart1;
> +	};
> +
> +	memory@10000000 {
> +		device_type = "memory";
> +		reg = <0x10000000 0x40000000>;
> +	};
> +
> +	reg_3p3v: regulator-3p3v {
> +		compatible = "regulator-fixed";
> +		regulator-name = "3P3V";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		regulator-always-on;
> +	};
> +
> +	reg_3v3_touch: reg-3v3-touch {

The prefix is still different than all others. You used "regulator" in
other places, but here it is "reg". Keep your code consistent.

> +		compatible = "regulator-fixed";
> +		regulator-name = "touch_3v3_supply";
> +		regulator-always-on;

Also, missing constraints.


Best regards,
Krzysztof

