Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7553179363B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 09:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232757AbjIFH1R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 03:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231147AbjIFH1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 03:27:15 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F60392
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 00:27:11 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-52e297c7c39so3956854a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 00:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693985229; x=1694590029; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K/D3S02pV0j69DWmyqjSauKntrk3YcPUrV89cnyW/2M=;
        b=sYtcyiEL1JTuSC/ZCEWrORbeFahq2hS2aAgAC8pcC7yxeMqbNOXRuq/17L6tiMdDd9
         gg0iImVO2zUEaglC0X+HC0rbCRr9gfH8LI/CvGYFQF4qvCgRCyBjRt8Kf/FgExAhT9ap
         XMhLvQGTPgGLF1GOJV1SqMZoIaNaiAML8DM/nxBt6MBD7PXMrdjuzYzTWxnSNq8OKZ2l
         F1+28c6RlPsdIVlbgFQ4rTx3cAuDhmVlc2TMxVm+XdpCAEQ2FZJZUrSheraZJVjb7X6m
         PSD+EdJ2q0UIgTm5N6pYSoaletpBRxmGxulmofi8AtS1I6jkEfpcmntIlBZMQNigetzQ
         TlPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693985229; x=1694590029;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K/D3S02pV0j69DWmyqjSauKntrk3YcPUrV89cnyW/2M=;
        b=MKIZk/qnK/oTlAq3ny6ukwPJLmMXtSuotde3GFmUDMLXk8zzFB3FhXk6uwMNa7Gg4N
         aNZcDSJHUCRK+vQ05t0OHdEewQvyilSZLWl4kkfhXnflP5M6spxcKP8V5Zn7V7UKKaoh
         3Vg91gLRMtcCIuHKcWq1rr6QQPNsWHhgSmoFgGCpBNjFOXcxqASxDz2NuIMSo5zkmLmk
         OqMktTB8fs5l0DiBNw+/trAkC+FscZ5WpHTNcxSm2XpkvTS+VYmRQmhF3G5C6SLtARA0
         qOn7T615zrLIqxpX88L/OoPyg0KuS2/+/Wuvza6lZcV/errmwRuK3ILLYtzaRTus2t2v
         aZZg==
X-Gm-Message-State: AOJu0YxpJ7kaab+db0t9hWmzNkH+zsF4VeOejg/VcMUmAUSB4dR395ml
        PClqkFdU9wua04Dn6sS+lNFNoA==
X-Google-Smtp-Source: AGHT+IFSivZXNYKgOoZ31LkGFVLn7z0ozLSMGOS34alVtKgZpxs2nm8bdPv5Y8/tJvhmbBZRQfgz0Q==
X-Received: by 2002:a17:907:724b:b0:9a1:d5de:5e3 with SMTP id ds11-20020a170907724b00b009a1d5de05e3mr1621628ejc.54.1693985229558;
        Wed, 06 Sep 2023 00:27:09 -0700 (PDT)
Received: from [192.168.0.22] (77-252-46-238.static.ip.netia.com.pl. [77.252.46.238])
        by smtp.gmail.com with ESMTPSA id qc8-20020a170906d8a800b0099275c59bc9sm8561948ejb.33.2023.09.06.00.27.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Sep 2023 00:27:09 -0700 (PDT)
Message-ID: <502fc7b1-a32d-6901-3a45-d2aa0e0c3849@linaro.org>
Date:   Wed, 6 Sep 2023 09:27:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 3/3] arm64: dts: mediatek: mt8365-pumpkin: Add overlays
 for thp7312 cameras
Content-Language: en-US
To:     Paul Elder <paul.elder@ideasonboard.com>,
        linux-media@vger.kernel.org
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20230905233118.183140-1-paul.elder@ideasonboard.com>
 <20230905233118.183140-4-paul.elder@ideasonboard.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230905233118.183140-4-paul.elder@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/09/2023 01:31, Paul Elder wrote:
> Add overlays for the Pumpkin i350 to support THP7312 cameras.
> 
> Signed-off-by: Paul Elder <paul.elder@ideasonboard.com>
> ---
>  arch/arm64/boot/dts/mediatek/Makefile         |  4 +
>  .../mt8365-pumpkin-common-thp7312.dtsi        | 23 ++++++
>  .../mt8365-pumpkin-csi0-thp7312-imx258.dtso   | 73 +++++++++++++++++++
>  .../mt8365-pumpkin-csi1-thp7312-imx258.dtso   | 73 +++++++++++++++++++
>  4 files changed, 173 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8365-pumpkin-common-thp7312.dtsi
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8365-pumpkin-csi0-thp7312-imx258.dtso
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8365-pumpkin-csi1-thp7312-imx258.dtso
> 
> diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/mediatek/Makefile
> index 20570bc40de8..ceaf24105001 100644
> --- a/arch/arm64/boot/dts/mediatek/Makefile
> +++ b/arch/arm64/boot/dts/mediatek/Makefile
> @@ -56,4 +56,8 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += mt8365-evk.dtb
>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt8365-pumpkin.dtb
>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt8516-pumpkin.dtb
>  
> +mtk-mt8365-pumpkin-dtbs := mt8365-pumpkin.dtb mt8365-pumpkin-csi0-thp7312-imx258.dtbo
> +mtk-mt8365-pumpkin-dtbs := mt8365-pumpkin.dtb mt8365-pumpkin-csi1-thp7312-imx258.dtbo
>  mtk-mt8365-pumpkin-dtbs := mt8365-pumpkin.dtb mt8365-pumpkin-ethernet-usb.dtbo
> +
> +dtb-$(CONFIG_ARCH_MEDIATEK) += mtk-mt8365-pumpkin.dtb
> diff --git a/arch/arm64/boot/dts/mediatek/mt8365-pumpkin-common-thp7312.dtsi b/arch/arm64/boot/dts/mediatek/mt8365-pumpkin-common-thp7312.dtsi
> new file mode 100644
> index 000000000000..478697552617
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mediatek/mt8365-pumpkin-common-thp7312.dtsi
> @@ -0,0 +1,23 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2023 Ideas on Board
> + * Author: Paul Elder <paul.elder@ideasonboard.com>
> + */
> +
> +/dts-v1/;
> +/plugin/;
> +
> +&{/} {
> +	vsys_v4p2: regulator@0 {

Hm? Is this a bus?

> +		compatible = "regulator-fixed";
> +		regulator-name = "vsys-v4p2";
> +		regulator-min-microvolt = <4200000>;
> +		regulator-max-microvolt = <4200000>;
> +	};
> +
> +	camera61_clk: cam_clk24m {

And this is not on a bus? It's the same / node!

Please work on mainline, which means take mainline code and change it to
your needs. Do not take downstream poor code and change it...

No underscores in node names. Also generic node names, so at least with
generic prefix or suffix.


> +		compatible = "fixed-clock";
> +		clock-frequency = <24000000>;
> +		#clock-cells = <0>;
> +	};
> +};
> diff --git a/arch/arm64/boot/dts/mediatek/mt8365-pumpkin-csi0-thp7312-imx258.dtso b/arch/arm64/boot/dts/mediatek/mt8365-pumpkin-csi0-thp7312-imx258.dtso
> new file mode 100644
> index 000000000000..740d14a19d75
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mediatek/mt8365-pumpkin-csi0-thp7312-imx258.dtso
> @@ -0,0 +1,73 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2023 Ideas on Board
> + * Author: Paul Elder <paul.elder@ideasonboard.com>
> + */
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/pinctrl/mt8365-pinfunc.h>
> +#include "mt8365-pumpkin-common-thp7312.dtsi"
> +
> +&i2c3 {
> +	camera@61 {
> +		compatible = "thine,thp7312";
> +		reg = <0x61>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&cam0_pins_default>;
> +		reset-gpios = <&pio 118 GPIO_ACTIVE_LOW>;
> +		clocks = <&camera61_clk>;
> +
> +		vddcore-supply = <&vsys_v4p2>;
> +		vhtermrx-supply = <&vsys_v4p2>;
> +		vddtx-supply = <&vsys_v4p2>;
> +		vddhost-supply = <&vsys_v4p2>;
> +		vddcmos-supply = <&vsys_v4p2>;
> +		vddgpio_0-supply = <&vsys_v4p2>;
> +		vddgpio_1-supply = <&vsys_v4p2>;
> +		DOVDD-supply = <&vsys_v4p2>;
> +		AVDD-supply = <&vsys_v4p2>;
> +		DVDD-supply = <&vsys_v4p2>;
> +
> +		orientation = <0>;
> +		rotation = <0>;
> +
> +		thine,rx,data-lanes = <4 1 3 2>;

NAK for this property.


> +
> +		port {
> +			isp1_out: endpoint {
> +				remote-endpoint = <&seninf_in1>;
> +				data-lanes = <4 2 1 3>;
> +			};
> +		};
> +	};
> +};
> +
> +&pio {
> +	cam0_pins_default: cam0_pins_default {

No underscores in node names.

> +		pins_rst {

Ditto


Best regards,
Krzysztof

