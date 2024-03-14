Return-Path: <linux-kernel+bounces-103690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 514D087C306
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 19:49:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC11FB20DDF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 18:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC4DF74E31;
	Thu, 14 Mar 2024 18:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b="wpH0i9Qe";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b="xb0EFS+e"
Received: from fallback1.i.mail.ru (fallback1.i.mail.ru [79.137.243.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC50F71750;
	Thu, 14 Mar 2024 18:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.137.243.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710442186; cv=none; b=RMmh7PGOjz1lMl/lZimjtBYRD9wRObaMfHp0KRvRkSdKRLC3607Wr+9VIbB0BU4vb/gf0AqI2CAH3zEAWOC0ArguoiIaveo5BkbPoRh6+19bLXKV8IwXwRSM7NkCjN0yC2rlxrVOST6fdlw6HQ8YY1+WR1KWpD3JJVYPnG7Prlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710442186; c=relaxed/simple;
	bh=IAV7rpUM97kMXb5C7uqxBjIAe6R0RLMke7xSVvVwIls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=exoCByqD5ITRPJ1tbrkXDkd+3TXIBQa4MOsiowrfwFhrs+uu9U1Asm9IkBi/u4EbnoKLwPqdqBpwdx238hiLKkyFOiMsdM1VyJD7ejism+bRJKuXFpF53nL86+71BeZrZt28izN/r8evHI3/yMFYr+ZLWxTwT+pO1NTF02XR+vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mail.ru; spf=pass smtp.mailfrom=mail.ru; dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b=wpH0i9Qe; dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b=xb0EFS+e; arc=none smtp.client-ip=79.137.243.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mail.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ru
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru; s=mail4;
	h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=v9UQDTZUAZxTFVcnHlHqxxMkddPkMhuh8ohutTgh44E=;
	t=1710442182;x=1710532182; 
	b=wpH0i9QeCPOQV4jtdsYLXSCS61R2sQuNAV1vBM3kICsjPRHSIP+F8273OUqApmSHlCTyOuGRDypApyqofaCdUwNMOpYkSOzfpHcTPHmNUTyvqAHcZ+WjKUmIGT6k9m53IlZ2xWdkYLo2kw9RNgF/ROc50l6TvVCeMu5kanaauAZOs48hl8kHc83fGNt0DMKRQBMbUV3u8RB77rYfmYXs+c7vpldCOs0xMukTl1RkIQ7QKAGJhvj41vwucDtZCrTqPamzp/guD3odp8zUFZRLCo/nibyJPz0kmpAgPcO+KW/eSDFfXN5eCWPaT6tK5b+OHYmXVVrPSWfpgGBRW1WFGw==;
Received: from [10.12.4.26] (port=58914 helo=smtp50.i.mail.ru)
	by fallback1.i.mail.ru with esmtp (envelope-from <hitechshell@mail.ru>)
	id 1rkpg7-006WLJ-Cg; Thu, 14 Mar 2024 21:19:43 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru;
	s=mail4; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:To:Cc:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
	List-Archive:X-Cloud-Ids:Disposition-Notification-To;
	bh=v9UQDTZUAZxTFVcnHlHqxxMkddPkMhuh8ohutTgh44E=; t=1710440383; x=1710530383; 
	b=xb0EFS+ekTu3Q24eXPlFcbu8JmnJ5V07YJR9h2inHwLYF0PxNrt57FyEoGiO5MBzLIlscLlB62l
	ODj1K9jL3UuxhGHRrRIAjsiIl4/eImorwEitaAj5kL+TdHzYGQbTRvAWG8cQdPxm79o1XVEsHyYue
	h7mGOQ3IloGT29ZctvAU0GcUnh69Fc5WQNmS/zGmI9bzPOjfpRVi+VUpPJ23d5R4LV4/GYrMywjmG
	bt91eWXNLm8Iup18XyHyqJ7scFpG8a+X2HsKNN7DsIDKzJmJW4UiTFKcKvtJKR56bClPmimEi/IOm
	X5rweZMhnzPngPcH8oESvnJPnowrNJdXeQWQ==;
Received: by smtp50.i.mail.ru with esmtpa (envelope-from <hitechshell@mail.ru>)
	id 1rkpfr-00000002Ah8-44TH; Thu, 14 Mar 2024 21:19:28 +0300
Date: Thu, 14 Mar 2024 23:18:58 +0500
From: hitechshell@mail.ru
To: Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Samuel Holland <samuel@sholland.org>,
	Maxime Ripard <mripard@kernel.org>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] ARM: dts: sun5i: Add PocketBook 614 Plus support
Message-ID: <20240314181858.2mhw62qfiie6mqg5@hitech>
References: <20240314155306.11521-1-hitechshell@mail.ru>
 <20240314155306.11521-2-hitechshell@mail.ru>
 <2451572.jE0xQCEvom@jernej-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2451572.jE0xQCEvom@jernej-laptop>
X-Mailru-Src: smtp
X-4EC0790: 10
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD987C0EE6E7F0A597DF2E6F6001F0923FF54E1DF110EA51DBE182A05F538085040D8A9A1003A731B3EF378A8CA21F699D69AB52EFE781839F6F93A083641A4090F049A14F81E47D748
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7AE8B5BEC11030C2FEA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F790063719899BAB9B61B3948638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D83992F180575BF1A2052DF408D43937DF0E46E929C49A4F6D20879F7C8C5043D14489FFFB0AA5F4BF176DF2183F8FC7C068077CCD40B79AC98941B15DA834481FA18204E546F3947C989FD0BDF65E50FBF6B57BC7E64490618DEB871D839B7333395957E7521B51C2DFABB839C843B9C08941B15DA834481F8AA50765F7900637D0FEED2715E18529389733CBF5DBD5E9B5C8C57E37DE458BD9DD9810294C998ED8FC6C240DEA76428AA50765F79006375C50346D84131645D32BA5DBAC0009BE395957E7521B51C2330BD67F2E7D9AF1090A508E0FED62991661749BA6B977351421F57CABF51D54B3661434B16C20ACC84D3B47A649675FE827F84554CEF5019E625A9149C048EE33AC447995A7AD187441229DB5CFFAA63A03B725D353964B0B7D0EA88DDEDAC722CA9DD8327EE49322A4E020D69BCAC1F43AACC0BCEB2632C4224003CC83647689D4C264860C145E
X-C1DE0DAB: 0D63561A33F958A5C109FA423330CAE65002B1117B3ED696098EA29B494A442DC638DF663A625AFA823CB91A9FED034534781492E4B8EEAD0D89974173551D4FBDAD6C7F3747799A
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF3FED46C3ACD6F73ED3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CF1E0038058B198F18E05D68A8F7A012DE3F951EED774ACD1BA747D9B5201067D880BEFAEC9D2720087C77D8D956826D33FAC03D15251961073BCDA2BAE809A37CFB4217C025BE7155AF108DC32EA72A8402C26D483E81D6BEAB6E9BFA52983102758FA77D78A604EFC3981EEBE9DB10F943082AE146A756F3
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojXiTM5LlaqzInJFJdxx9yMw==
X-Mailru-Sender: 7219FA8B682B638D379344632618B47AC0933AD50F40A523C23DFC7D03CD5B00FD7A2C60D32BC2ADDD7143E30D734E3D46315093CA775BF3554C0F224C5326CDBE1FA5EEA7DC04A0851DE5097B8401C6C89D8AF824B716EB5DB38D7CCF7198FF1D0BEC28C16373053DDE9B364B0DF289AE208404248635DF
X-Mras: Ok
X-7564579A: 646B95376F6C166E
X-77F55803: 6242723A09DB00B485448333635D8AFAF2FD4A3C9FF394F50FA50637E8B29678049FFFDB7839CE9E436D59F16A22D11080DC9103707CA6D92B83ECE94A1AA8E4A72856222B1BBA24
X-7FA49CB5: 0D63561A33F958A589916FFCD62DB37F99125139983B077C4B811F7B1FEFB100CACD7DF95DA8FC8BD5E8D9A59859A8B63CA5754E60C5D220CC7F00164DA146DAFE8445B8C89999728AA50765F790063735D2385A5E2B3AC3389733CBF5DBD5E9C8A9BA7A39EFB766F5D81C698A659EA7CC7F00164DA146DA9985D098DBDEAEC80CABCCA60F52D7EBF6B57BC7E6449061A352F6E88A58FB86F5D81C698A659EA775ECD9A6C639B01B78DA827A17800CE7630B063D451B3F78731C566533BA786AA5CC5B56E945C8DA
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojXiTM5LlaqzKqj4tZLZ3z4w==
X-Mailru-MI: 8000000000000800
X-Mras: Ok

On Thu, Mar 14, 2024 at 06:14:48PM +0100, Jernej Škrabec wrote:
> Hi Denis!
> 
> Dne četrtek, 14. marec 2024 ob 16:53:06 CET je Denis Burkov napisal(a):
> > What works:
> > 
> > - Serial console
> > - mmc0, mmc2 (both microSD card slots on the board)
> > - All buttons (gpio and lradc based)
> > - Power LED
> > - PMIC
> > - RTC
> > - USB OTG/gadgets mode
> > 
> > Signed-off-by: Denis Burkov <hitechshell@mail.ru>
> > ---
> >  arch/arm/boot/dts/allwinner/Makefile          |   2 +
> >  .../sun5i-a13-pocketbook-614-plus.dts         | 254 ++++++++++++++++++
> >  2 files changed, 256 insertions(+)
> >  create mode 100644 arch/arm/boot/dts/allwinner/sun5i-a13-pocketbook-614-plus.dts
> > 
> > diff --git a/arch/arm/boot/dts/allwinner/Makefile b/arch/arm/boot/dts/allwinner/Makefile
> > index 2d26c3397f14..fe321865beed 100644
> > --- a/arch/arm/boot/dts/allwinner/Makefile
> > +++ b/arch/arm/boot/dts/allwinner/Makefile
> > @@ -61,6 +61,7 @@ dtb-$(CONFIG_MACH_SUN5I) += \
> >  	sun5i-a13-olinuxino.dtb \
> >  	sun5i-a13-olinuxino-micro.dtb \
> >  	sun5i-a13-pocketbook-touch-lux-3.dtb \
> > +	sun5i-a13-pocketbook-614-plus.dtb \
> >  	sun5i-a13-q8-tablet.dtb \
> >  	sun5i-a13-utoo-p66.dtb \
> >  	sun5i-gr8-chip-pro.dtb \
> > @@ -82,6 +83,7 @@ dtb-$(CONFIG_MACH_SUN5I) += \
> >  	sun5i-a13-olinuxino.dtb \
> >  	sun5i-a13-olinuxino-micro.dtb \
> >  	sun5i-a13-pocketbook-touch-lux-3.dtb \
> > +	sun5i-a13-pocketbook-614-plus.dtb \
> >  	sun5i-a13-q8-tablet.dtb \
> >  	sun5i-a13-utoo-p66.dtb \
> >  	sun5i-gr8-chip-pro.dtb \
> 
> This merge artefact. Can you add patch before this one and remove duplicate definitions?
> 
Sorry, I didn't quite understand. Should I remove the duplicate block in a separate commit? or enable this one?
> > diff --git a/arch/arm/boot/dts/allwinner/sun5i-a13-pocketbook-614-plus.dts b/arch/arm/boot/dts/allwinner/sun5i-a13-pocketbook-614-plus.dts
> > new file mode 100644
> > index 000000000000..89898fa16ff7
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/allwinner/sun5i-a13-pocketbook-614-plus.dts
> > @@ -0,0 +1,254 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * Copyright 2024 Denis Burkov <hitechshell@mail.ru>
> > + */
> > +
> > +/dts-v1/;
> > +#include "sun5i-a13.dtsi"
> > +#include "sunxi-common-regulators.dtsi"
> 
> Extra empty line here.
> 
> > +#include <dt-bindings/gpio/gpio.h>
> > +#include <dt-bindings/input/input.h>
> > +#include <dt-bindings/interrupt-controller/irq.h>
> > +
> > +/ {
> > +	model = "PocketBook 614 Plus";
> > +	compatible = "pocketbook,614-plus", "allwinner,sun5i-a13";
> > +
> > +	aliases {
> > +		serial0 = &uart1;
> > +		i2c0 = &i2c0;
> > +		i2c1 = &i2c1;
> > +		i2c2 = &i2c2;
> > +		rtc0 = &pcf8563;
> 
> Please drop aliases except serial0.
> 
> > +	};
> > +
> > +	chosen {
> > +		stdout-path = "serial0:115200n8";
> > +	};
> > +
> > +	leds {
> > +		compatible = "gpio-leds";
> > +		pinctrl-names = "default";
> > +		pinctrl-0 = <&led_pins_pocketbook>;
> 
> Drop pinctrl nodes. GPIOs don't need them.
> 
> > +
> > +		led {
> > +			gpios = <&pio 4 8 GPIO_ACTIVE_LOW>; /* PE8 */
> > +			default-state = "on";
> 
> Add additional properties, like function and color.
> 
> > +		};
> > +	};
> > +
> > +	gpio-keys {
> > +		compatible = "gpio-keys";
> > +		autorepeat;
> 
> Why is autorepeat needed?
> 
> > +		label = "GPIO Keys";
> 
> I guess label is self evident and not needed?
> 
> > +		pinctrl-names = "default";
> > +		pinctrl-0 = <&pocketbook_btn_pins>;
> 
> Again, GPIOs don't need pinctrl nodes. I know that you specified pull up, but
> please try without. Other boards have same design and it's not needed.
> 
> > +
> > +		key-right {
> > +			label = "Right";
> > +			linux,code = <KEY_NEXT>;
> > +			gpios = <&pio 6 9 GPIO_ACTIVE_LOW>; /* PG9 */
> > +		};
> > +
> > +		key-left {
> > +			label = "Left";
> > +			linux,code = <KEY_PREVIOUS>;
> > +			gpios = <&pio 6 10 GPIO_ACTIVE_LOW>; /* PG10 */
> > +		};
> > +	};
> > +
> > +	reg_3v3_mmc0: regulator-mmc0 {
> > +		compatible = "regulator-fixed";
> > +		regulator-name = "vdd-mmc0";
> > +		regulator-min-microvolt = <3300000>;
> > +		regulator-max-microvolt = <3300000>;
> > +		pinctrl-names = "default";
> > +		pinctrl-0 = <&pocketbook_reg_mmc0_pins>;
> 
> again, pinctrl not needed.
> 
> > +		gpio = <&pio 4 4 GPIO_ACTIVE_LOW>; /* PE4 */
> > +		vin-supply = <&reg_vcc3v3>;
> > +	};
> > +};
> > +
> > +&cpu0 {
> > +	cpu-supply = <&reg_dcdc2>;
> > +};
> > +
> > +&ehci0 {
> > +	status = "okay";
> > +};
> > +
> > +&i2c0 {
> > +	status = "okay";
> > +
> > +	axp209: pmic@34 {
> > +		compatible = "x-powers,axp209";
> > +		reg = <0x34>;
> > +		interrupts = <0>;
> > +	};
> > +};
> > +
> > +#include "axp209.dtsi"
> > +
> > +&i2c1 {
> > +	status = "okay";
> > +
> > +	pcf8563: rtc@51 {
> > +		compatible = "nxp,pcf8563";
> > +		reg = <0x51>;
> > +		#clock-cells = <0>;
> > +	};
> > +};
> > +
> > +&i2c2 {
> > +	status = "okay";
> > +
> > +	/* Touchpanel is connected here. */
> 
> Any reason why don't you specify touch panel device here?
> 
My mistake, I copied this node from another device. This device does not have a touchpanel at all.
> > +};
> > +
> > +&lradc {
> > +	vref-supply = <&reg_ldo2>;
> > +	status = "okay";
> > +
> > +	button-300 {
> > +		label = "Down";
> > +		linux,code = <KEY_DOWN>;
> > +		channel = <0>;
> > +		voltage = <300000>;
> > +	};
> > +
> > +	button-700 {
> > +		label = "Up";
> > +		linux,code = <KEY_UP>;
> > +		channel = <0>;
> > +		voltage = <700000>;
> > +	};
> > +
> > +	button-1000 {
> > +		label = "Left";
> > +		linux,code = <KEY_LEFT>;
> > +		channel = <0>;
> > +		voltage = <1000000>;
> > +	};
> > +
> > +	button-1200 {
> > +		label = "Menu";
> > +		linux,code = <KEY_MENU>;
> > +		channel = <0>;
> > +		voltage = <1200000>;
> > +	};
> > +
> > +	button-1500 {
> > +		label = "Right";
> > +		linux,code = <KEY_RIGHT>;
> > +		channel = <0>;
> > +		voltage = <1500000>;
> > +	};
> > +};
> > +
> > +&mmc0 {
> > +	vmmc-supply = <&reg_3v3_mmc0>;
> > +	bus-width = <4>;
> > +	cd-gpios = <&pio 6 0 GPIO_ACTIVE_LOW>; /* PG0 */
> > +	status = "okay";
> > +};
> > +
> > +&mmc2 {
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&mmc2_4bit_pc_pins>;
> > +	vmmc-supply = <&reg_vcc3v3>;
> > +	bus-width = <4>;
> > +	non-removable;
> > +	status = "okay";
> > +};
> > +
> > +&ohci0 {
> > +	status = "okay";
> > +};
> > +
> > +&otg_sram {
> > +	status = "okay";
> > +};
> > +
> > +&pio {
> > +	led_pins_pocketbook: led-pin {
> > +		pins = "PE8";
> > +		function = "gpio_out";
> > +	};
> > +	pocketbook_btn_pins: btn-pins {
> > +		pins = "PG9", "PG10";
> > +		function = "gpio_in";
> > +		bias-pull-up;
> > +	};
> > +	pocketbook_reg_mmc0_pins: reg-mmc0-pins {
> > +		pins = "PE4";
> > +		function = "gpio_out";
> > +	};
> > +};
> 
> Whole PIO node can be dropped.
> 
> Best regards,
> Jernej
> 
> > +
> > +&reg_dcdc2 {
> > +	regulator-always-on;
> > +	regulator-min-microvolt = <1000000>;
> > +	regulator-max-microvolt = <1500000>;
> > +	regulator-name = "vdd-cpu";
> > +};
> > +
> > +&reg_dcdc3 {
> > +	regulator-always-on;
> > +	regulator-min-microvolt = <1000000>;
> > +	regulator-max-microvolt = <1400000>;
> > +	regulator-name = "vdd-int-dll";
> > +};
> > +
> > +&reg_ldo1 {
> > +	regulator-name = "vdd-rtc";
> > +};
> > +
> > +&reg_ldo2 {
> > +	regulator-always-on;
> > +	regulator-min-microvolt = <3000000>;
> > +	regulator-max-microvolt = <3000000>;
> > +	regulator-name = "avcc";
> > +};
> > +
> > +&reg_ldo3 {
> > +	regulator-min-microvolt = <3300000>;
> > +	regulator-max-microvolt = <3300000>;
> > +	regulator-name = "vcc-wifi";
> > +};
> > +
> > +&reg_usb0_vbus {
> > +	status = "okay";
> > +	gpio = <&pio 6 12 GPIO_ACTIVE_HIGH>; /* PG12 */
> > +};
> > +
> > +&reg_usb1_vbus {
> > +	gpio = <&pio 6 11 GPIO_ACTIVE_HIGH>; /* PG11 */
> > +	status = "okay";
> > +};
> > +
> > +&uart1 {
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&uart1_pg_pins>;
> > +	status = "okay";
> > +};
> > +
> > +&usb_otg {
> > +	dr_mode = "otg";
> > +	status = "okay";
> > +};
> > +
> > +&usb_power_supply {
> > +	status = "okay";
> > +};
> > +
> > +&battery_power_supply {
> > +	status = "okay";
> > +};
> > +
> > +&usbphy {
> > +	usb0_id_det-gpios = <&pio 6 2 (GPIO_ACTIVE_HIGH | GPIO_PULL_UP)>; /* PG2 */
> > +	usb0_vbus_det-gpios = <&axp_gpio 1 GPIO_ACTIVE_HIGH>;
> > +	usb0_vbus-supply = <&reg_usb0_vbus>;
> > +	usb1_vbus-supply = <&reg_usb1_vbus>;
> > +	status = "okay";
> > +};
> > 
> 
> 
> 
> 
Yes, everything works without pincrtl. One guy told me that I need to specify pinctrl for each pin used.
Thanks for the review.
Best regards,
Denis

