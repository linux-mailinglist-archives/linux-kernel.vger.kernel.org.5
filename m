Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82D5378D951
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:33:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235783AbjH3Scs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243338AbjH3KpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 06:45:23 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62D2FCC9
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 03:45:19 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-500aed06ffcso6908558e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 03:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693392317; x=1693997117; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yXrmFSc5DvtKQwplkdMyHW9pMnpsWmyWrqSLE5MlrIE=;
        b=UXawE5igQfDnP9Kg2O1Y9MNow2oAyrd+dCUx+bDlftaExBOzl+mIoVzGsMTd+miBJ+
         TCT8nkj//Xdk1TvwcHks1PpJFUMPoh9PakzV6CUjPkOjO3hF7zpkypMAa+ANLj45cp6e
         jvXfovC0xuwD446pzBFtESyjQn/rvXS7Kd7M8Kr43nOwsM09b3N4jUpKJLeA/cIA8BUY
         BksF/mvNADzsgeMK6V15/zc6T0Iahu+4JzSmpvdUhVjk4fiYjgMpiP2eHebE6HXwD8Et
         VnpfkLGjP0l+2lzshc03rZyyvm7k9F8gU6mlt701W3XOgvxfPT9GR9hbpgf5jCi3sriv
         FOUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693392317; x=1693997117;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yXrmFSc5DvtKQwplkdMyHW9pMnpsWmyWrqSLE5MlrIE=;
        b=OKSlSqjI1ID5A30stxDlnl3i+QtsuGbpgEF/3Kp0/YpLvHIonQspK2cTq9MK359/Kp
         G5w+Asx0q/vCI9wYBN9LrnxFEBjqbDgrtBG+tHrxkE2e1AjZIRf/3WG8WecrLZBkh/nP
         HqoX5X0Rno3DmqKrCLHj3dvVYU0IVko/f+n2tIPnzFwVCTytao1vFivPk7Vn1UDx4kd/
         1y2dou+SWKuvANeCJY1ROQocbbkTLHMHkWFioY5fPUvb7mIapcbQaVykebCCPnEKC1lb
         g7Eh0C7EwvK2LIIm7HzsgjGOxvcJ3/kfmEwibcleiJhCLs8pB9p4Ig03iLnfbz1xapWY
         9IkQ==
X-Gm-Message-State: AOJu0Yy2fVw3aTGJVbu4gURLru7l6y/by5uTp5actfvx5BIytJfNI0lD
        TthjKgunLnNxXQV8QnR5hNZdbw==
X-Google-Smtp-Source: AGHT+IEIBTX67B4U3Kx8acXRvk5tJixSnsBIFI4vYjn84H8gWbTM8Nf/ZI8sQkkfwDxkK91FgFiYSA==
X-Received: by 2002:a05:6512:ba4:b0:500:9031:bb1b with SMTP id b36-20020a0565120ba400b005009031bb1bmr1361380lfv.41.1693392317539;
        Wed, 30 Aug 2023 03:45:17 -0700 (PDT)
Received: from [192.168.1.101] (abyl195.neoplus.adsl.tpnet.pl. [83.9.31.195])
        by smtp.gmail.com with ESMTPSA id j17-20020a19f511000000b004ff6fa3f038sm2316808lfb.144.2023.08.30.03.45.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Aug 2023 03:45:17 -0700 (PDT)
Message-ID: <72c2fd33-613b-49be-b394-0663f459f0c5@linaro.org>
Date:   Wed, 30 Aug 2023 12:45:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/11] arm64: dts: qcom: qcm6490: Add device-tree for
 Fairphone 5
Content-Language: en-US
To:     Luca Weiss <luca.weiss@fairphone.com>,
        cros-qcom-dts-watchers@chromium.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20230830-fp5-initial-v1-0-5a954519bbad@fairphone.com>
 <20230830-fp5-initial-v1-11-5a954519bbad@fairphone.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20230830-fp5-initial-v1-11-5a954519bbad@fairphone.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30.08.2023 11:58, Luca Weiss wrote:
> Add device tree for the Fairphone 5 smartphone which is based on
> the QCM6490 SoC.
> 
> Supported features are, as of now:
> * Bluetooth
> * Debug UART
> * Display via simplefb
> * Flash/torch LED
> * Flip cover sensor
> * Power & volume buttons
> * RTC
> * SD card
> * USB
> * Various plumbing like regulators, i2c, spi, etc
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>  arch/arm64/boot/dts/qcom/Makefile                  |   1 +
>  arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts | 659 +++++++++++++++++++++
>  2 files changed, 660 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index 2cca20563a1d..73c3be0f8872 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -81,6 +81,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= msm8998-sony-xperia-yoshino-lilac.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8998-sony-xperia-yoshino-maple.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8998-sony-xperia-yoshino-poplar.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8998-xiaomi-sagit.dtb
> +dtb-$(CONFIG_ARCH_QCOM)	+= qcm6490-fairphone-fp5.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= qcs404-evb-1000.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= qcs404-evb-4000.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= qdu1000-idp.dtb
> diff --git a/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts b/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
> new file mode 100644
> index 000000000000..572b254d3af2
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
> @@ -0,0 +1,659 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Copyright (c) 2023, Luca Weiss <luca.weiss@fairphone.com>
> + */
> +
> +/dts-v1/;
> +
> +/* PM7250B is configured to use SID8/9 instead of SID2/3 */
> +#define PM7250B_SID 8
> +#define PM7250B_SID1 9
> +
> +#include <dt-bindings/arm/qcom,ids.h>
> +#include <dt-bindings/leds/common.h>
> +#include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
> +#include <dt-bindings/regulator/qcom,rpmh-regulator.h>
> +#include "sc7280.dtsi"
> +#include "pm7250b.dtsi"
> +#include "pm7325.dtsi"
> +#include "pm8350c.dtsi" /* PM7350C */
> +#include "pmk8350.dtsi" /* PMK7325 */
> +
> +/ {
> +	model = "Fairphone 5";
> +	compatible = "fairphone,fp5", "qcom,qcm6490";
> +	chassis-type = "handset";
> +
> +	/* required for bootloader to select correct board */
> +	qcom,msm-id = <QCOM_ID_QCM6490 0x10000>;
> +	qcom,board-id = <34 0>;
Try [1], it worked for me on a picky device.

> +
> +	aliases {
> +		serial0 = &uart5;
> +		serial1 = &uart7;
> +	};
> +
> +	chosen {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		framebuffer0: framebuffer@a000000 {
> +			compatible = "simple-framebuffer";
> +			reg = <0 0xe1000000 0 (2700 * 1224 * 4)>;
0x0?

> +			width = <1224>;
> +			height = <2700>;
> +			stride = <(1224 * 4)>;
> +			format = "a8r8g8b8";
> +			panel = <&panel>;
> +			clocks = <&gcc GCC_DISP_HF_AXI_CLK>;
> +		};
> +	};
> +
> +	gpio-keys {
> +		compatible = "gpio-keys";
> +
> +		pinctrl-0 = <&volume_down_default>, <&hall_sensor_default>;
> +		pinctrl-names = "default";
> +
> +		key-volume-up {
> +			label = "Volume up";
> +			gpios = <&pm7325_gpios 6 GPIO_ACTIVE_LOW>;
> +			linux,code = <KEY_VOLUMEUP>;
> +		};
> +
> +		/* Hall sensor uses vreg_l8c as VDD, it's being enabled using
> +		 * always-on on the regulator
> +		 */
/* Powered by the always-on vreg_l8c */ - fits in a single line

> +		event-hall-sensor {
> +			label = "Hall Effect Sensor";
> +			gpios = <&tlmm 155 GPIO_ACTIVE_LOW>;
> +			linux,input-type = <EV_SW>;
> +			linux,code = <SW_LID>;
> +			linux,can-disable;
> +			wakeup-source;
> +		};
> +	};
> +
> +	panel: panel {
> +		compatible = "boe,rm692e5";
Undocumented compatbile

> +
> +		width-mm = <68>;
> +		height-mm = <150>;
> +	};
> +
> +	reserved-memory {
> +		cont_splash_mem: cont-splash@e1000000 {
> +			reg = <0 0xe1000000 0 0x2300000>;
0x0

[...]

> +		vreg_s1b: smps1 {
> +			regulator-min-microvolt = <1840000>;
> +			regulator-max-microvolt = <2040000>;
No regulator-initial-mode on this pmic?

[...]

> +
> +	/* PM8008 PMIC @ 8 and 9 */
> +	/* Pixelworks @ 26 */
> +	/* FSA4480 USB audio switch @ 42 */
There's a driver for the fsa4480, you may wanna include a node here

> +	/* AW86927FCR haptics @ 5a */
> +};
[...]

> +
> +	led-0 {
> +		function = LED_FUNCTION_FLASH;
No dual-tone stuff?

> +		color = <LED_COLOR_ID_WHITE>;
> +		led-sources = <1>, <4>;
> +		led-max-microamp = <500000>;
> +		flash-max-microamp = <1500000>;
> +		flash-max-timeout-us = <1280000>;
> +	};
> +};
> +
> +&pmk8350_rtc {
> +	status = "okay";
> +};
> +
> +&pon_pwrkey {
> +	status = "okay";
> +};
> +
> +&pon_resin {
> +	status = "okay";
> +	linux,code = <KEY_VOLUMEDOWN>;
status last

[...]

> +&rmtfs_mem {
> +	qcom,vmid = <QCOM_SCM_VMID_MSS_MSA>, <QCOM_SCM_VMID_NAV>;
> +	reg = <0x0 0xf8500000 0x0 0x600000>;
> +};
/delete-node/ + redefinition would probably be cleaner-looking

[...]

> +&uart7 {
> +	/delete-property/interrupts;
> +	interrupts-extended = <&intc GIC_SPI 608 IRQ_TYPE_LEVEL_HIGH>,
> +			      <&tlmm 31 IRQ_TYPE_EDGE_FALLING>;
> +
> +	pinctrl-names = "default", "sleep";
> +	pinctrl-1 = <&qup_uart7_sleep_cts>, <&qup_uart7_sleep_rts>, <&qup_uart7_sleep_tx>, <&qup_uart7_sleep_rx>;
property-n
property-names

> +
> +	status = "okay";
> +
> +	bluetooth: bluetooth {
> +		compatible = "qcom,wcn6750-bt";
> +
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&bluetooth_enable_default>, <&sw_ctrl_default>;
property-n
property-names

Konrad

[1] https://lore.kernel.org/linux-arm-msm/9db02015-2c41-40d6-bf35-69ef277e9ce4@linaro.org/
