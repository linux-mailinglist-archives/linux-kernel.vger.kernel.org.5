Return-Path: <linux-kernel+bounces-159929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CDEC8B3666
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 13:13:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11696B234C4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 11:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B7C9144D3A;
	Fri, 26 Apr 2024 11:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YnwYei7b"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85AFA1448DA
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 11:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714129994; cv=none; b=VfpzOMM3VAOuvg+lIjQU1leRTZCAxiWx+4Z0nchCyheZmHiXQ9+hcSb6N62wFpoDW8m/7D3gyheeYEs6Sl/oYftTL+ws1vtTfR5TKyFjv84Uqm6m8YP1Ua930WfTMhp5uU4KjvDKgjZ0g5CblQ33xntpeRAzHkfF0MsgJr6u998=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714129994; c=relaxed/simple;
	bh=0pitW7XJdmkFZV5CJLn4eg+wD1SkdByMnN3HAUH+cOg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p72DKj1VVXoXq3SjP2YlT/fURDtV3aOAhOvwh1tGFuRPBxJTl0ARs2XBGlCYvmvx83kDc4PbZMt7yYT1twm5L3b6ULWabCBnqALLE8qdUaQ6eejohQxthWZYuIrIZamd43J2dDg5b0T3GXhxANxU5cwNjhSdIHVOvyVtU2x/+vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YnwYei7b; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-51abd9fcbf6so3453180e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 04:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714129990; x=1714734790; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Vi9MLf28C7+A8iBBhB9wpzzNgii+jssqWQYQxvHBEJY=;
        b=YnwYei7bDUVj0aciUGfFGL0WebMfU9TBeUCwVUJYs+RzWdi3XB583t/y2WZT9wfAlU
         49uQ8fWFlJ00J+BZDnafmju56qs7qsvSFdZ3psKNNdgLtRZEHZVQrPmRWsjWPx+ZX+mI
         H77IdV/bMGALLqaVDv83zr/8jHWQryqxso6ezWpAkoUNti8VRbDcwmtBnBTXvtUPinHE
         GhMNTo71+Jli+FyyB9ablGSrrudrPw99mrlBPJNH+Pwd5Q948m1VaEYiJS83ZmoRseq9
         0uBQI60I1hFbsOJ+P4rYR3SZpdkea0ipYPntl407MU652yN8FF6FmIvVGihhVii9BzM9
         oASg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714129990; x=1714734790;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vi9MLf28C7+A8iBBhB9wpzzNgii+jssqWQYQxvHBEJY=;
        b=cHvU/iGMg/ec7OIlvxxtdgOZH/oMRygGGSHFD/faPIAb67kDr04GW3MXr8uysyGX7n
         xM+7x2nChP93kVLWvqysJJsXGv+M4fAg42U7unEZUtKCRu95rTVJpTKlFoUhdoygqfMl
         zkMfxrsAd3jg5a+r0SolfAeOJGZhkpJ/Oi/aFnJluP1ASlIF0wFmTiTO3slpFG4yYC43
         qB4fMm1U+1vuzRWpgDRwUjw96asd4pJ8+aV+VcaOQ0Aqgz1vY0cfQTtNxU6PJB7vGs2H
         2yUE5+bcwnoboPGrk99MsLY2PHaxoQ5rWL3StkUnJEfyLnWxXE9mGjsZ4t8XH65q1pBL
         Neqg==
X-Forwarded-Encrypted: i=1; AJvYcCVd94sMwKyx3ljhhxgmF+PJDQHRStcmWM2279nTU92k5idM6twXD6GKYIe1L/pDRfChH6ypTuxLn5zZYkvpjgNKlknf1WHNJp88fxAD
X-Gm-Message-State: AOJu0YwoZyxihvLGKy6jz+1poRcrZeNP/Ets/IimEfjq/1WduG7HG9AD
	MRyGhFuJwPI8hVFKbx5mdb6tkAVVqGmcwM88C67jjtta5DaThZgYayk99QexVg4=
X-Google-Smtp-Source: AGHT+IEDx0ddglqd+bHQM4VUo9JoVlEbIWE4k2hm7wiYSSudxW8tjxth4ub78z5NNegqMJr2Ck38aQ==
X-Received: by 2002:ac2:421a:0:b0:51a:e2a2:7262 with SMTP id y26-20020ac2421a000000b0051ae2a27262mr1807372lfh.8.1714129989537;
        Fri, 26 Apr 2024 04:13:09 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id hy25-20020a1709068a7900b00a4e03c28fd5sm10535298ejc.43.2024.04.26.04.13.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Apr 2024 04:13:09 -0700 (PDT)
Message-ID: <0b811850-14f5-4895-9614-cd61b697b8e0@linaro.org>
Date: Fri, 26 Apr 2024 13:13:07 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARM: dts: aspeed: sbp1: IBM sbp1 BMC board
To: Naresh Solanki <naresh.solanki@9elements.com>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
 Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: mazziesaccount@gmail.com, Patrick Rudolph
 <patrick.rudolph@9elements.com>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
References: <20240426100909.1351939-1-naresh.solanki@9elements.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240426100909.1351939-1-naresh.solanki@9elements.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/04/2024 12:09, Naresh Solanki wrote:
> From: Patrick Rudolph <patrick.rudolph@9elements.com>
> 
> Add a device tree for IBM sbp1 BMC board which is based on AST2600 SOC.
> 
> sbp1 baseboard has:
> - support for up to four Sapphire Rapids sockets having 16 DIMMS each.
>   - 240 core/480 threads at maximum
> - 32x CPU PCIe slots
> - 2x M.2 PCH PCIe slots
> - Dual 200Gbit/s NIC
> - SPI TPM
> 
> Added the following:
> - Indication LEDs
> - I2C mux & GPIO controller, pin assignments,
> - Thermister,
> - Voltage regulator
> - EEPROM/VPD
> 
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
> ---
>  arch/arm/boot/dts/aspeed/Makefile             |    1 +
>  .../boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dts   | 6224 +++++++++++++++++
>  2 files changed, 6225 insertions(+)
>  create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dts
> 
> diff --git a/arch/arm/boot/dts/aspeed/Makefile b/arch/arm/boot/dts/aspeed/Makefile
> index d3ac20e316d0..5fc9ed3f5150 100644
> --- a/arch/arm/boot/dts/aspeed/Makefile
> +++ b/arch/arm/boot/dts/aspeed/Makefile
> @@ -33,6 +33,7 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
>  	aspeed-bmc-ibm-rainier.dtb \
>  	aspeed-bmc-ibm-rainier-1s4u.dtb \
>  	aspeed-bmc-ibm-rainier-4u.dtb \
> +	aspeed-bmc-ibm-sbp1.dtb \
>  	aspeed-bmc-intel-s2600wf.dtb \
>  	aspeed-bmc-inspur-fp5280g2.dtb \
>  	aspeed-bmc-inspur-nf5280m6.dtb \
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dts
> new file mode 100644
> index 000000000000..5395295b677b
> --- /dev/null
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dts
> @@ -0,0 +1,6224 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +// Copyright 2024 IBM Corp.
> +/dts-v1/;
> +#include <dt-bindings/gpio/aspeed-gpio.h>
> +#include <dt-bindings/input/input.h>
> +#include <dt-bindings/interrupt-controller/irq.h>
> +#include <dt-bindings/leds/common.h>
> +#include <dt-bindings/i2c/i2c.h>
> +#include "aspeed-g6.dtsi"
> +
> +/ {
> +	model = "IBM SBP1";
> +	compatible = "ibm,sbp1-bmc", "aspeed,ast2600";

Please run scripts/checkpatch.pl and fix reported warnings. Then please
run `scripts/checkpatch.pl --strict` and (probably) fix more warnings.
Some warnings can be ignored, especially from --strict run, but the code
here looks like it needs a fix. Feel free to get in touch if the warning
is not clear.

> +
> +	chosen {
> +		stdout-path = &uart1;
> +		bootargs = "console=tty0 console=ttyS0,115200 earlycon";

Drop entire bootargs. That's debugging.


> +	};
> +
> +	memory@80000000 {
> +		reg = <0x80000000 0x20000000>;
> +		device_type = "memory";
> +	};
> +
> +	reserved-memory {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges;
> +
> +		gfx_memory: framebuffer {
> +			size = <0x01000000>;
> +			alignment = <0x01000000>;
> +			compatible = "shared-dma-pool";
> +			reusable;
> +		};
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +
> +		led-power {
> +			label = "LED_BMC_READY";
> +			gpios = <&gpio0 ASPEED_GPIO(H, 1) GPIO_ACTIVE_LOW>;
> +			color = <LED_COLOR_ID_GREEN>;
> +			default-state = "off";
> +			retain-state-suspended;
> +			panic-indicator;
> +		};
> +
> +		// Misc ID LEDs
> +		led-id_tpm {

No underscores in node names.

I am pretty sure you received from me before all three feedbacks above.


..


> +
> +	iio-hwmon {
> +		compatible = "iio-hwmon";
> +		// Voltage sensors top to down

Use consistent comment style.


> +		io-channels = <&p12v_vd 0>, <&p5v_aux_vd 0>, <&p5v_bmc_aux_vd 0>, <&p3v3_aux_vd 0>,
> +			<&p3v3_bmc_aux_vd 0>, <&p1v8_bmc_aux_vd 0>, <&adc1 4>, <&adc0 2>, <&adc1 0>,
> +			<&p2V5_aux_vd 0>, <&p3v3_rtc_vd 0>;
> +	};
> +
> +	p12v_vd: voltage_divider1 {

No underscores in node names.

> +		compatible = "voltage-divider";
> +		io-channels = <&adc1 3>;
> +		#io-channel-cells = <1>;
> +
> +		/* Scale the system voltage by 1127/127 to fit the ADC range.

This is not networking code. See Linux Coding style.



..

> +
> +	thermistor0: thermistor.0 {

? Neither dots. Do you see any code like this in Linux kernel?


..


regulator-boot-on;
> +	};
> +
> +	p12v_b_consumer {
> +		status = "okay";

Why? Who disabled it?


..


> +
> +	bmc_mux_nic: mux@77 { //  U61040
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		compatible = "maxim,max7357";

Compatible is always the first property. reg is second.

> +		reg = <0x77>;
> +
> +		reset-gpios = <&gpio0 ASPEED_GPIO(R, 3) (GPIO_ACTIVE_LOW | GPIO_OPEN_DRAIN)>; // BMC_MUX_NIC_RST_INT_N
> +		vdd-supply = <&p3v3_aux>;
> +
> +		i2c@0 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <0>;

reg is before address/size cells.

> +
> +			smb_pex_nic: pinctrl@20 { // U62160
> +				compatible = "cypress,cy8c9540";
> +				reg = <0x20>;
> +				gpio-controller;
> +				#gpio-cells = <2>;
> +				#interrupt-cells=<2>;
> +				interrupt-parent = <&smb_pex_vr_ctrl>;
> +				interrupts = <8 IRQ_TYPE_LEVEL_HIGH>; // SMB_PEX_NIC_INT
> +				interrupt-controller;
> +
> +				vdd-supply = <&p3v3_aux>;
> +				// Reset is PEX_NIC_RST
> +				reset-gpios = <&gpio0 ASPEED_GPIO(Q, 3) GPIO_ACTIVE_HIGH>;
> +
> +				gpio-reserved-ranges = <19 1>, <22 6>, <30 6>, <38 2>;
> +
> +				gpio-line-names =
> +				/* GPORT0 */
> +				"IRQ_NIC2_OVT_WRNG", "FM_NIC2_ALLSTANDBY_N", "IRQ_NIC2_OVT_SHTDN",
> +				"SMB_VR_PVCORE_NIC2_ALERT_N", "FM_NIC2_PERST1_N", "SMB_NIC2_ALERT_N",

Some random alignment.


..


> +			reg = <3>;
> +
> +			smb_m2_ssb_ssd1: regulator@3a {
> +				reg = <0x3a>;
> +				vss1-supply = <&p3v3_aux>;
> +				compatible = "maxim,max5978";
> +				interrupt-parent = <&smb_pex_vr_ctrl>;
> +				interrupts = <30 IRQ_TYPE_LEVEL_LOW>; // M2_SSD1_SSB_ALERT_N
> +					leds {

Broken indentation.

This DTS does not pass basic sanity checks. It's unreadable. Does not
follow coding style.

Do not upstream your downstream code directly, but clean it to match
upstream code quality.

I finished review here because it's absolutely huge, unmanageable patch
with trivial issues which should not be sent upstream in the first place.

All comments above apply to entire patchset and all your future
patchset. Please do not ask us to keep repeating obvious comments but
learn from them and improve your future submissions.

Best regards,
Krzysztof


