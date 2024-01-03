Return-Path: <linux-kernel+bounces-15561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 84D71822E26
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 14:22:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA6FA1F23C4B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 13:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4B8219472;
	Wed,  3 Jan 2024 13:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mecka.net header.i=@mecka.net header.b="gigy8Xom"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mecka.net (mecka.net [159.69.159.214])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A37321947C;
	Wed,  3 Jan 2024 13:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mecka.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mecka.net
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mecka.net; s=2016.11;
	t=1704288144; bh=jI38MkiHkb6c5DZuzb+pvbd/Eze9cPlo8CmwRLCLqrM=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=gigy8Xom3an2US+AIMPH7e3W5YVhBtfs9THOE0aly9+wfI62SaVJ/wqj88fR9XBIS
	 0Tmb/JrVpNW5zAvnZueh63ddNOkl++BCDUX1C+l061pFLEoWCfxyxhdxTaf8pqwtJ6
	 m1nqm3jdt40GudCzGaJzCX/Re2J1mxAT8MaMEETwqzYULuld4MXtwNJKEw3a4l4ris
	 +kgWAqHTOO+0MJeWAPqDdFoDEfHD8uxDsfzSXdxHAsscBJytq/omZpuKWmREZAwmrK
	 Q+F2BhPk1xxBGFd1Yp1fAwnMYQDUoqZkWxudCse8wVFY3Eng2DG1uoOaTL3ePJ0PhE
	 1Kq1COlzWtPJA==
Received: from mecka.net (unknown [185.147.11.134])
	by mecka.net (Postfix) with ESMTPSA id 6F475379CE7;
	Wed,  3 Jan 2024 14:22:23 +0100 (CET)
Date: Wed, 3 Jan 2024 14:22:22 +0100
From: Manuel Traut <manut@mecka.net>
To: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>, Sandy Huang <hjc@rock-chips.com>,
	Mark Yao <markyao0591@gmail.com>,
	Diederik de Haas <didi.debian@cknow.org>,
	Segfault <awarnecke002@hotmail.com>,
	Arnaud Ferraris <aferraris@debian.org>,
	Danct12 <danct12@riseup.net>, dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v3 4/4] arm64: dts: rockchip: Add devicetree for Pine64
 PineTab2
Message-ID: <ZZVfjpOqcoM3U5b3@mecka.net>
References: <20240102-pinetab2-v3-0-cb1aa69f8c30@mecka.net>
 <20240102-pinetab2-v3-4-cb1aa69f8c30@mecka.net>
 <775vjfucu2g2s6zzeutj7f7tapx3q2geccpxvv4ppcms4hxbq7@cbrdmlu2ryzp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <775vjfucu2g2s6zzeutj7f7tapx3q2geccpxvv4ppcms4hxbq7@cbrdmlu2ryzp>

On Tue, Jan 02, 2024 at 07:07:56PM +0100, Ondřej Jirman wrote:
> Hello Manuel,

Hello Ondřej,

> On Tue, Jan 02, 2024 at 05:15:47PM +0100, Manuel Traut wrote:
> > From: Alexander Warnecke <awarnecke002@hotmail.com>
> > 
> > [...]
> >
> > +
> > +	backlight: backlight {
> > +		compatible = "pwm-backlight";
> > +		pwms = <&pwm4 0 25000 0>;
> > +		brightness-levels = <20 220>;
> > +		num-interpolated-steps = <200>;
> 
> Does this linear brightness -> PWM duty cycle mapping lead to linear
> relationship between brighntess level and subjective brightness on this HW?
> 
> I doubt it a bit...

I tested it with the brightness slider in phosh, for me it looks good.

> > +
> > +	hdmi-con {
> 
> hdmi-connector

ack, changed for v4

> > +		compatible = "hdmi-connector";
> > +		type = "d";
> > +
> > +		port {
> > +			hdmi_con_in: endpoint {
> > +				remote-endpoint = <&hdmi_out_con>;
> > +			};
> > +		};
> > +	};
> > +
> > +	leds {
> > +		compatible = "gpio-leds";
> > +
> 
> Spurious newline ^

ack, changed for v4

> > +	vcc_3v3: vcc-3v3 {
> 
> Regulator node names shoule end with -regulator suffix. The same applies for
> all of the below nodes.

ack, changed for v4

> > +		compatible = "regulator-fixed";
> > +		regulator-name = "vcc_3v3";
> > +		regulator-always-on;
> > +		regulator-boot-on;
> > +		regulator-min-microvolt = <3300000>;
> > +		regulator-max-microvolt = <3300000>;
> > +		vin-supply = <&vcc3v3_sys>;
> > +	};
> > +
> > +	vdd1v2_dvp: vdd1v2-dvp {
> > +		compatible = "regulator-fixed";
> > +		regulator-name = "vdd1v2_dvp";
> > +		regulator-min-microvolt = <1200000>;
> > +		regulator-max-microvolt = <1200000>;
> > +		vin-supply = <&vcc_3v3>;
> > +		/*enable-supply = <&vcc2v8_dvp>;*/
> 
> There's no such property. Delete this commented out line.

ack, changed for v4

> > +	lcd: panel@0 {
> > +		compatible = "boe,th101mb31ig002-28a";
> > +		reg = <0>;
> > +		backlight = <&backlight>;
> > +		enable-gpios = <&gpio0 RK_PC7 GPIO_ACTIVE_HIGH>;
> > +		pinctrl-names = "default";
> > +		pinctrl-0 = <&lcd_pwren_h &lcd0_rst_l>;
> 
> Re lcd0_rst_l:
> 
> It's a bit weird conceptually to reference from dtsi something that's only 
> declared in dts that includes the dtsi. Maybe move pinctrl-* properties
> to dts &lcd, too...

Will be better I guess, changed for v4.

> > +			vcc5v_midu: BOOST {
> > +				regulator-always-on;
> > +				regulator-boot-on;
> > +				regulator-min-microvolt = <5000000>;
> > +				regulator-max-microvolt = <5000000>;
> > +				regulator-name = "boost";
> > +				regulator-state-mem {
> > +					regulator-off-in-suspend;
> 
> I guess this prevents remote USB wakeup by USB devices. Like wakeup via USB
> keyboard. Probably not a bad thing, though.

That is true. After 'echo mem > /sys/power/state' It is not possible to wakeup
the device with a USB Keyboard or mouse. However if the surface like keyboard
is used that is shipped with the device, wakeup works if the keyboard/tablet
gets unfold. For me this behaviour is fine. Other opinions?

> > +&pcie2x1 {
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&pcie_reset_h>;
> > +	reset-gpios = <&gpio1 RK_PB2 GPIO_ACTIVE_HIGH>;
> > +	vpcie3v3-supply = <&vcc3v3_minipcie>;
> > +	status = "okay";
> > +};
> 
> Does it make sense to enable this HW block by default, when it isn't used on
> actual HW?

There is a flat ribbon connector, if someone wants to build sth. it might be
helpful. However I am also fine with removing it for now.

> > +&pinctrl {
> > +	bt {
> > +		bt_wake_host_h: bt-wake-host-h {
> > +			rockchip,pins = <0 RK_PB5 RK_FUNC_GPIO &pcfg_pull_down>;
> > +		};
> > +	};
> 
> ^^^ unused

I do not bother to removing unused pinctrls, however even if there is no user at
the moment, if we look at a dtb as a machine parseable device description it
is probably ok, that it is there?

> > +
> > +	camerab {
> > +		camerab_pdn_l: camerab-pdn-l {
> > +			rockchip,pins = <4 RK_PB3 RK_FUNC_GPIO &pcfg_pull_none>;
> > +		};
> > +
> > +		camerab_rst_l: camerab-rst-l {
> > +			rockchip,pins = <4 RK_PB1 RK_FUNC_GPIO &pcfg_pull_none>;
> > +		};
> > +	};
> > +
> > +	cameraf {
> > +		cameraf_pdn_l: cameraf-pdn-l {
> > +			rockchip,pins = <4 RK_PB2 RK_FUNC_GPIO &pcfg_pull_none>;
> > +		};
> > +
> > +		cameraf_rst_l: cameraf-rst-l {
> > +			rockchip,pins = <4 RK_PB0 RK_FUNC_GPIO &pcfg_pull_none>;
> > +		};
> > +	};
> 
> ^^^ unused
> 
> > +	usb {
> > +		usbcc_int_l: usbcc-int-l {
> > +			rockchip,pins = <0 RK_PC5 RK_FUNC_GPIO &pcfg_pull_none>;
> > +		};
> 
> ^^^ unused
> 
> > +	wifi {
> > +		host_wake_wl: host-wake-wl {
> > +			rockchip,pins = <0 RK_PB7 RK_FUNC_GPIO &pcfg_pull_none>;
> > +		};
> > +
> > +		wifi_pwren: wifi-pwren {
> > +			rockchip,pins = <0 RK_PA0 RK_FUNC_GPIO &pcfg_pull_none>;
> > +		};
> > +
> > +		wifi_wake_host_h: wifi-wake-host-h {
> > +			rockchip,pins = <0 RK_PC4 RK_FUNC_GPIO &pcfg_pull_down>;
> > +		};
> > +	};
> 
> ^^^ all of this wifi stuff is unused
> 
> Also wifi_pwren is not really useful on actual HW. W_VBAT is routed directly
> to wifi chip, with wifi_pwren_h signal having no effect: (short via R9664)
> 
>    https://megous.com/dl/tmp/b499859c1012f969.png

ack, removed for v4

> > +&uart1 {
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&uart1m0_xfer
> > +		     &uart1m0_ctsn
> > +		     &uart1m0_rtsn>;
> > +	status = "okay";
> > +	uart-has-rtscts;
> > +};
> 
> Not sure about enabling UART for bluetooth, without having the bluetooth driver
> hooked in, somehow. UART will by default pull TX signal high, which may cause
> current leakage into gpio/uart pin of the bluetooth chip, if it's not powered up.
> 
> Maybe just remove this, until bluetooth is figured out...

Makes sense, removed for v4.

Thanks for your feedback,

Manuel

