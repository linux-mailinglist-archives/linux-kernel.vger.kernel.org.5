Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21A0B75C078
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 09:54:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbjGUHyC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 03:54:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbjGUHyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 03:54:00 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E50FA2D7D
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 00:53:50 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-5216569f9e3so2315889a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 00:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689926029; x=1690530829;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tEygh4c+HqxN74BgXq8Y1kfIxuqyz4efWO8eqzPzYks=;
        b=fBac3ap+iIZ5MwFfu4qTR52LVb+3L+GbxZS0jhoKvit/O6n/nYU3TPOvCqdwNED9Wz
         gdAkwg2LmQnSVQ/QZpThBvWEUcXJIXRvino9kzIMnKUTiueyURedoc1fOHY3BO0w9IAe
         IpaMr5bpoAU7PHMsaotH6zob4ogrhipQ4eyWqSLFDzIZK4EIBor0eXOxyo6D+fjzu8s1
         PWdZhL2EVedkIxK/NXUc2JxvU4nGs09tjp8ZpJMeYdjGhgzq2ZyutKqp75UUIkm/lj0z
         yZo63VySV5QE0UyZXQCDcyshPMTMJOgSqesclet8ZKgwi2AhYAuPeEDo/ecwCEhjP83Q
         y9EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689926029; x=1690530829;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tEygh4c+HqxN74BgXq8Y1kfIxuqyz4efWO8eqzPzYks=;
        b=E64LhNzDYp0k+JU2VZ8H1qtc2mu3dyOTWDF/QTYRmeZQGcfu1mkuxcns+8Slv6eZ0b
         N8JpkJ65jCjsQ79gmHd6L+POiPEpkSn6/WwPtGOwu/Ydcqr406QjE4U0UPGsC6CXxJGa
         EMuq0nVEzcP1m0gvdjCMsnkAn2ivdzVHsD9016QihhJM1D+j/3gmZO+A9nhyEQOWXaHk
         IQov57QK2iKEohSE5YQgNZeyPaWp7XjvzxRK3pp4gm3sabXwmJxc3xyjeZH3S3qzEw8Z
         +gLvVnAlUiRCW6t0JF7qS6zZ2o9MloZnHCyHUwRLl18e18hrPjrC5dhC3kbNa/YXpmdl
         f/mw==
X-Gm-Message-State: ABy/qLbteXzfTFMuTclXEe2Lz1CrfetXVIMVzZ7UYNfLwy8ptKNuT7x2
        HigMnFoaJr4q0dZfbn2s78cHUg==
X-Google-Smtp-Source: APBJJlG70ubi7PfFJ83R0SjvKKHGbb3LLJDfj8I88GeD6ZT48ozVs6lSrCK3Pq8XKEvVEn6OlGguEA==
X-Received: by 2002:a05:6402:549:b0:51e:ebd:9f5b with SMTP id i9-20020a056402054900b0051e0ebd9f5bmr1000093edx.36.1689926028989;
        Fri, 21 Jul 2023 00:53:48 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id s11-20020aa7cb0b000000b0051def9be785sm1741132edt.85.2023.07.21.00.53.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jul 2023 00:53:48 -0700 (PDT)
Message-ID: <3b4eaf27-5e6e-f3d0-24fa-01d5c059c2f5@linaro.org>
Date:   Fri, 21 Jul 2023 09:53:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 4/4] ARM: dts: imx6q: Add Variscite MX6 Custom board
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
        =?UTF-8?B?TWljaGFsIFZva8OhxI0=?= <michal.vokac@ysoft.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        Li Yang <leoyang.li@nxp.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230721073626.3673429-1-james.hilliard1@gmail.com>
 <20230721073626.3673429-4-james.hilliard1@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230721073626.3673429-4-james.hilliard1@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/07/2023 09:36, James Hilliard wrote:
> This patch adds support for the Variscite MX6 SoM Carrier Board.
> 
> This Carrier-Board has the following :
> - LVDS interface for the VLCD-CAP-GLD-LVDS 7" LCD 800 x 480 touch display
> - HDMI Connector
> - USB Host + USB OTG Connector
> - 10/100/1000 Mbps Ethernet
> - miniPCI-Express slot
> - SD Card connector
> - Audio Headphone/Line In jack connectors
> - S-ATA
> - On-board DMIC
> - RS485 Header
> - CAN bus header
> - SPI header
> - Camera Interfaces header
> - OnBoard RTC with Coin Backup battery socket
> - RS232 Debug Header (IDC10)
> - RS232 DTE
> 
> Product Page : https://www.variscite.com/product/single-board-computers/var-mx6customboard
> 
> The dts file based on the ones provided by Variscite on their own
> kernel, but adapted for mainline.
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> ---
>  arch/arm/boot/dts/nxp/imx/Makefile            |   1 +
>  .../dts/nxp/imx/imx6q-var-mx6customboard.dts  | 280 ++++++++++++++++++
>  2 files changed, 281 insertions(+)
>  create mode 100644 arch/arm/boot/dts/nxp/imx/imx6q-var-mx6customboard.dts
> 
> diff --git a/arch/arm/boot/dts/nxp/imx/Makefile b/arch/arm/boot/dts/nxp/imx/Makefile
> index 3629e343d322..258ec0e5b712 100644
> --- a/arch/arm/boot/dts/nxp/imx/Makefile
> +++ b/arch/arm/boot/dts/nxp/imx/Makefile
> @@ -244,6 +244,7 @@ dtb-$(CONFIG_SOC_IMX6Q) += \
>  	imx6q-udoo.dtb \
>  	imx6q-utilite-pro.dtb \
>  	imx6q-var-dt6customboard.dtb \
> +	imx6q-var-mx6customboard.dtb \
>  	imx6q-vicut1.dtb \
>  	imx6q-wandboard.dtb \
>  	imx6q-wandboard-revb1.dtb \
> diff --git a/arch/arm/boot/dts/nxp/imx/imx6q-var-mx6customboard.dts b/arch/arm/boot/dts/nxp/imx/imx6q-var-mx6customboard.dts
> new file mode 100644
> index 000000000000..3ca3662fd0d3
> --- /dev/null
> +++ b/arch/arm/boot/dts/nxp/imx/imx6q-var-mx6customboard.dts
> @@ -0,0 +1,280 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Support for Variscite MX6 Carrier-board
> + *
> + * Copyright 2016 Variscite, Ltd. All Rights Reserved
> + * Copyright 2022 Bootlin
> + */
> +
> +/dts-v1/;
> +
> +#include "imx6qdl-var-som.dtsi"
> +#include <dt-bindings/pwm/pwm.h>
> +
> +/ {
> +	model = "Variscite i.MX6 QUAD/DUAL VAR-SOM-MX6 Custom Board";
> +	compatible = "variscite,mx6customboard", "variscite,var-som-imx6q", "fsl,imx6q";

This is not what you said in the bindings. And you did not test it.

It does not look like you tested the DTS against bindings. Please run
`make dtbs_check` (see
Documentation/devicetree/bindings/writing-schema.rst or
https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sources-with-the-devicetree-schema/
for instructions).

Best regards,
Krzysztof

