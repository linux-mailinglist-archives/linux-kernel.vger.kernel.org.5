Return-Path: <linux-kernel+bounces-15338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58754822A5D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 10:43:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53BCE1C231E0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 09:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30B3818622;
	Wed,  3 Jan 2024 09:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b="DWllvzcs"
X-Original-To: linux-kernel@vger.kernel.org
Received: from vps.xff.cz (vps.xff.cz [195.181.215.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF505182A4;
	Wed,  3 Jan 2024 09:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xff.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xff.cz; s=mail;
	t=1704274974; bh=+FuXJj2iKg82sXCjmgWQQwQpfkrjPVRuS95BkQPHOsw=;
	h=Date:From:To:Cc:Subject:X-My-GPG-KeyId:References:From;
	b=DWllvzcsi439e2+YBGopYhr7/9P4TW/n11basEqxa5WmGOsOuP9HnwC1kXB4B2o1+
	 SbiCHP4a0BGb1mZFtaJjf3sSm54STGsn0NSLu5ZpzdrxDb3+tuGLSgdyPZpmbBYqrL
	 7VHgotempQviHZ7yLqhZT+zg9JoMETqwqz2oaZt8=
Date: Wed, 3 Jan 2024 10:42:54 +0100
From: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>
To: Manuel Traut <manut@mecka.net>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
	Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, Sandy Huang <hjc@rock-chips.com>, 
	Mark Yao <markyao0591@gmail.com>, Diederik de Haas <didi.debian@cknow.org>, 
	Segfault <awarnecke002@hotmail.com>, Arnaud Ferraris <aferraris@debian.org>, 
	Danct12 <danct12@riseup.net>, dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v3 4/4] arm64: dts: rockchip: Add devicetree for Pine64
 PineTab2
Message-ID: <vj3elmkt6czisvwqouv2hhvut2va5jw6bbj5kjyxawvrnrdfwm@tlpo3dp3qcyb>
Mail-Followup-To: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>, 
	Manuel Traut <manut@mecka.net>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, Sandy Huang <hjc@rock-chips.com>, 
	Mark Yao <markyao0591@gmail.com>, Diederik de Haas <didi.debian@cknow.org>, 
	Segfault <awarnecke002@hotmail.com>, Arnaud Ferraris <aferraris@debian.org>, 
	Danct12 <danct12@riseup.net>, dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
References: <20240102-pinetab2-v3-0-cb1aa69f8c30@mecka.net>
 <20240102-pinetab2-v3-4-cb1aa69f8c30@mecka.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240102-pinetab2-v3-4-cb1aa69f8c30@mecka.net>

Hello Manuel,

a few more things I noticed:

On Tue, Jan 02, 2024 at 05:15:47PM +0100, Manuel Traut wrote:
> From: Alexander Warnecke <awarnecke002@hotmail.com>
> 
> +	leds {
> +		compatible = "gpio-leds";
> +
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&flash_led_en_h>;
> +
> +		led-0 {
> +			gpios = <&gpio4 RK_PA5 GPIO_ACTIVE_HIGH>;
> +			color = <LED_COLOR_ID_WHITE>;
> +			function = LED_FUNCTION_FLASH;
> +		};

This LED is supplied by VCC5V_MIDU, so maybe this should be a regulator-led
supplied by gpio (FLASH_LED_EN_H) controlled regulator-fixed named f_led which
is in turn supplied by VCC5V_MIDU.

https://megous.com/dl/tmp/9bf0d85d78946b5e.png

> +	};
> +
> [...]
>
> +
> +	speaker_amp: speaker-amplifier {
> +		compatible = "simple-audio-amplifier";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&spk_ctl>;
> +		enable-gpios = <&gpio4 RK_PC2 GPIO_ACTIVE_HIGH>;
> +		sound-name-prefix = "Speaker Amplifier";
> +		VCC-supply = <&vcc_bat>;
> +	};
> +
> +	vcc_3v3: vcc-3v3 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc_3v3";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		vin-supply = <&vcc3v3_sys>;
> +	};
> +
> +	vcc3v3_minipcie: vcc3v3-minipcie {
> +		compatible = "regulator-fixed";
> +		enable-active-high;
> +		gpio = <&gpio4 RK_PC3 GPIO_ACTIVE_HIGH>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pcie_pwren_h>;
> +		regulator-name = "vcc3v3_minipcie";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		vin-supply = <&vcc_sys>;

This regulator is supplied by vcc_bat: https://megous.com/dl/tmp/4ec71a4a2aea9498.png

> +	};
> +
> +	vcc3v3_sd: vcc3v3-sd {
> +		compatible = "regulator-fixed";
> +		gpio = <&gpio0 RK_PA5 GPIO_ACTIVE_HIGH>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&sdmmc_pwren_l>;
> +		regulator-name = "vcc3v3_sd";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		vin-supply = <&vcc3v3_sys>;
> +	};
> +
> +	vcc5v0_usb_host0: vcc5v0-usb-host0 {
> +		compatible = "regulator-fixed";
> +		enable-active-high;
> +		gpio = <&gpio4 RK_PC4 GPIO_ACTIVE_HIGH>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&usb_host_pwren1_h>;
> +		regulator-name = "vcc5v0_usb_host0";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		vin-supply = <&vcc5v_midu>;
> +	};
> +
> +	vcc5v0_usb_host2: vcc5v0-usb-host2 {
> +		compatible = "regulator-fixed";
> +		enable-active-high;
> +		gpio = <&gpio4 RK_PC5 GPIO_ACTIVE_HIGH>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&usb_host_pwren2_h>;
> +		regulator-name = "vcc5v0_usb_host2";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		vin-supply = <&vcc5v_midu>;
> +	};
> +
> +	vcc_bat: vcc-bat {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc_bat";
> +		regulator-always-on;
> +		regulator-boot-on;
> +	};
> +
> +	vcc_sys: vcc-sys {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc_sys";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		vin-supply = <&vcc_bat>;
> +	};
> +
> +	vdd1v2_dvp: vdd1v2-dvp {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vdd1v2_dvp";
> +		regulator-min-microvolt = <1200000>;
> +		regulator-max-microvolt = <1200000>;
> +		vin-supply = <&vcc_3v3>;
> +		/*enable-supply = <&vcc2v8_dvp>;*/
> +	};

There's no vdd1v2_dvp in the schematic on the camera sensor connector, or elsewhere:

  https://megous.com/dl/tmp/fd95f003d8f3fbfb.png

So I guess, you can drop this, entirely. Maybe it's VDD1V5_DVP but I don't think
it needs to be described in DT, since it's pretty local to this camera sensor,
and nothing else uses it.

  https://megous.com/dl/tmp/7fc384e196c5428f.png

regards,
	o.

