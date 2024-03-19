Return-Path: <linux-kernel+bounces-106852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 973B187F482
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 01:25:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A60EC1C216DF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 00:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 108447FE;
	Tue, 19 Mar 2024 00:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RL82XMzK"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62281DFCF;
	Tue, 19 Mar 2024 00:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710807935; cv=none; b=mJCcPS3BKP+hYP/VCI+02g50aQuHX2VBu7Hmp520wB2jAbr1kYcvlSk8IJRGgFEIFXrzrLKD2YTioCELsjsPC3+Z3v2YFiWf5f5W/qp93g9B8Gh6kpV9t0fWJuqjlrh2rnMaD3EjfgY4R3VqawUxkbRx5p9QHfj8KyA16CyPL+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710807935; c=relaxed/simple;
	bh=y9OoKQkdtsqhHZhsT5BO11MePnTE8wEc5wrDHe5ADBQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t4wyRF+HPVYTk2mxSVz7qpyserao6R7ibKtcd6nahipAAwKBwhjLqhh09rbiiyWCHycdyxiRDFBaiHjkGuSS8mkWprstfDx1Szqw5HsNLy3aesD2aFu5drkhKcRA2Ake2ihk9diwNs/tdWyQ0kJ9Vd90De7S4mi4EDwJO9JIjsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RL82XMzK; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a46c2f29325so187557666b.1;
        Mon, 18 Mar 2024 17:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710807931; x=1711412731; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zX6SCuD8zleaXW8sFOZi9h0t7nk2lsXfq4E6FRpb9t8=;
        b=RL82XMzKRLlxDNnRc6jaxRZoU2wwod+gkxZvQt4WM0lTgJP5+fxsvnNVsoQHDda748
         2rWDliu8zV0CJaLA7OaTr7UrWmKjk4oTCcnLAHs31F39oAMX6yLp+WxNLxfJcWUuq9QG
         V+wtw6Ndl1HB6aXViczVSDb3OkT9HIbCZjR9GACtU9wXzlOdNTsDMcju+NJ2clqIq63T
         sU2UsN/xkOR0oLHikZWZk2BzOfmt3r7EWAraksc+9AQch4+JSVp+AiwsoVskfXItBfNj
         QYokQum3psfCmk8mGLBLZyhO+CSg9csczeqFXJoPwAg01rvBvZjOSpXdOk950F6awX86
         luqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710807931; x=1711412731;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zX6SCuD8zleaXW8sFOZi9h0t7nk2lsXfq4E6FRpb9t8=;
        b=Gi9yxSJswE7YYQIclZKO5qlRmbluQbFgvCALV5uB128TnP1fkxXZ+Qv6DO1Dadm6/s
         LfVoz2lAonZxkvUyjKtiT68ht5sb5HI8CFTOomEk+WYfVeX+m8Me0EuicWR+8D7WNChG
         GavBHK+up8dYDH2NvFZ6eAiyGqHpmKGaQqF0WpZ+Z6UbhoUDTf6oRL9yI1ItnNY/tWL/
         WKW0y9ABY28PrL0ExoMOSga58Jw9AXHByPnQtXFUcWywZ5rZvETNQxSKdmrSxF9JIoiC
         YJ+HemQkeLfTUWvE0zjo71WHbBbJK5X/TIofbWkxd9N0nc/UXP5NRgtB+c95gHABh6I3
         xPqQ==
X-Forwarded-Encrypted: i=1; AJvYcCVeALUIR5MQC28RL72MUCXYJlUgQToGg0gngtduR8LWCeexc6SPvbP1+t2Ehj2GNV2fXfjKyfj7ZYF9tnlO6FVxzwSqDc8YQrBzPJAEcXQYy1SMMUysr2DqSyuP/YEyx9+KkRwoZS9t/A==
X-Gm-Message-State: AOJu0YxFBnYZgRzmSoEv6vZ9Bjb19EkcvoRBysrH1/Bh7akEjScEIg8C
	BeEUd3CExnRhQc30kyym450XKK1OeRfhRc1yIKh9+WxdMsVUIv7jf4/UxAhlcG8phQ==
X-Google-Smtp-Source: AGHT+IG2OPJnnIPrX6zYUv0r+FSw1D0BjyWnRckE8SWb30WU6BjUB6W/+LSgzTgYRF3ysty8emJemw==
X-Received: by 2002:a17:906:c144:b0:a46:9395:818e with SMTP id dp4-20020a170906c14400b00a469395818emr7576856ejc.68.1710807931054;
        Mon, 18 Mar 2024 17:25:31 -0700 (PDT)
Received: from [192.168.100.117] (89-76-44-138.dynamic.chello.pl. [89.76.44.138])
        by smtp.gmail.com with ESMTPSA id ld8-20020a170906f94800b00a46754900a4sm5091525ejb.33.2024.03.18.17.25.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Mar 2024 17:25:30 -0700 (PDT)
Message-ID: <4c318c9c-5560-430d-943c-c201f97bd6a6@gmail.com>
Date: Tue, 19 Mar 2024 01:25:28 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] arm64: dts: allwinner: h616: add support for T95
 tv boxes
To: Andre Przywara <andre.przywara@arm.com>
Cc: Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>, Maxime Ripard <mripard@kernel.org>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
References: <20240317-add-t95-axp313-support-v3-0-0d63f7c23d37@gmail.com>
 <20240317-add-t95-axp313-support-v3-3-0d63f7c23d37@gmail.com>
 <20240318114257.46667aef@donnerap.manchester.arm.com>
 <6ed87122-22ff-4d71-a6e6-06b578212f00@gmail.com>
 <20240319000805.42ae84ac@minigeek.lan>
Content-Language: pl
From: Kamil Kasperski <ressetkk@gmail.com>
In-Reply-To: <20240319000805.42ae84ac@minigeek.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

W dniu 19.03.2024 o 01:08, Andre Przywara pisze:
> On Tue, 19 Mar 2024 00:28:43 +0100
> Kamil Kasperski <ressetkk@gmail.com> wrote:
>
> Hi Kamil,
>
>> W dniu 18.03.2024 o 12:42, Andre Przywara pisze:
>>> On Sun, 17 Mar 2024 20:44:51 +0100
>>> Kamil Kasperski <ressetkk@gmail.com> wrote:
>>>
>>> Hi Kamil,
>>>
>>> thanks a lot for putting together those patches and sending them
>>> for upstream inclusion!
>>>  
>>>> Add dtsi file for T95 tv boxes and add initial support for T95 5G AXP313A
>>>> variant with a board name H616-T95MAX-AXP313A-v3.0 Internal storage is not
>>>> accessible due to lack of support for H616 NAND controller.  
>>> Them using raw NAND is really unfortunate. I think the original T95 box
>>> used eMMC?  
>> I'm not sure. I don't have access to the other revision of this box.
> That's alright, I was just curious. I think Jernej has such an early
> box, and IIRC he used mostly the X96 Mate DT with it, so I was assuming
> it has eMMC.
>  
>>>  
>>>> Signed-off-by: Kamil Kasperski <ressetkk@gmail.com>
>>>> ---
>>>>  arch/arm64/boot/dts/allwinner/Makefile             |   1 +
>>>>  arch/arm64/boot/dts/allwinner/sun50i-h616-t95.dtsi | 109 +++++++++++++++++++++
>>>>  .../dts/allwinner/sun50i-h616-t95max-axp313.dts    |  85 ++++++++++++++++
>>>>  3 files changed, 195 insertions(+)
>>>>
>>>> diff --git a/arch/arm64/boot/dts/allwinner/Makefile b/arch/arm64/boot/dts/allwinner/Makefile
>>>> index 21149b346a60..294921f12b73 100644
>>>> --- a/arch/arm64/boot/dts/allwinner/Makefile
>>>> +++ b/arch/arm64/boot/dts/allwinner/Makefile
>>>> @@ -42,6 +42,7 @@ dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-tanix-tx6-mini.dtb
>>>>  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h616-bigtreetech-cb1-manta.dtb
>>>>  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h616-bigtreetech-pi.dtb
>>>>  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h616-orangepi-zero2.dtb
>>>> +dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h616-t95max-axp313.dtb
>>>>  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h616-x96-mate.dtb
>>>>  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h618-longanpi-3h.dtb
>>>>  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h618-orangepi-zero2w.dtb
>>>> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h616-t95.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h616-t95.dtsi
>>>> new file mode 100644
>>>> index 000000000000..815cf2dac24b
>>>> --- /dev/null
>>>> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h616-t95.dtsi
>>>> @@ -0,0 +1,109 @@
>>>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>>>> +/*
>>>> + * Copyright (C) 2024 Kamil Kasperski <ressetkk@gmail.com>
>>>> + *
>>>> + * Common DT nodes for H616-based T95 TV boxes
>>>> + * There are two versions reported with different PMIC variants.
>>>> + */
>>>> +
>>>> +#include "sun50i-h616.dtsi"
>>>> +
>>>> +#include <dt-bindings/gpio/gpio.h>
>>>> +#include <dt-bindings/interrupt-controller/arm-gic.h>
>>>> +
>>>> +/ {
>>>> +	aliases {
>>>> +		ethernet1 = &sdio_wifi;
>>>> +		serial0 = &uart0;
>>>> +	};
>>>> +
>>>> +	chosen {
>>>> +		stdout-path = "serial0:115200n8";
>>>> +	};
>>>> +
>>>> +	reg_vcc5v: vcc5v {
>>>> +		/* board wide 5V supply directly from the DC input */
>>>> +		compatible = "regulator-fixed";
>>>> +		regulator-name = "vcc-5v";
>>>> +		regulator-min-microvolt = <5000000>;
>>>> +		regulator-max-microvolt = <5000000>;
>>>> +		regulator-always-on;
>>>> +	};
>>>> +
>>>> +	reg_vcc3v3: vcc3v3 {
>>>> +		/* discrete 3.3V regulator */
>>>> +		compatible = "regulator-fixed";
>>>> +		regulator-name = "vcc-3v3";
>>>> +		regulator-min-microvolt = <3300000>;
>>>> +		regulator-max-microvolt = <3300000>;
>>>> +		regulator-always-on;
>>>> +	};
>>>> +
>>>> +	wifi_pwrseq: wifi-pwrseq {  
>>> Krzysztof recently sent a patch to just use "pwrseq" as the node name,
>>> so can you do the same here?
>>>
>>> https://lore.kernel.org/linux-sunxi/20240317184130.157695-2-krzysztof.kozlowski@linaro.org/T/#u  
>> Sure. I'll send v4.
>>
>>>  
>>>> +		compatible = "mmc-pwrseq-simple";
>>>> +		clocks = <&rtc CLK_OSC32K_FANOUT>;
>>>> +		clock-names = "ext_clock";
>>>> +		pinctrl-0 = <&x32clk_fanout_pin>;
>>>> +		pinctrl-names = "default";
>>>> +		reset-gpios = <&pio 6 18 GPIO_ACTIVE_LOW>; /* PG18 */
>>>> +	};
>>>> +};
>>>> +
>>>> +&ehci0 {
>>>> +	status = "okay";
>>>> +};
>>>> +
>>>> +&ehci2 {
>>>> +	status = "okay";
>>>> +};
>>>> +
>>>> +&ir {
>>>> +	status = "okay";
>>>> +};
>>>> +
>>>> +&mmc0 {
>>>> +	cd-gpios = <&pio 8 16 GPIO_ACTIVE_LOW>;	/* PI16 */
>>>> +	bus-width = <4>;
>>>> +	status = "okay";
>>>> +};
>>>> +
>>>> +&mmc1 {
>>>> +	mmc-pwrseq = <&wifi_pwrseq>;
>>>> +	bus-width = <4>;
>>>> +	non-removable;
>>>> +	status = "okay";
>>>> +
>>>> +	sdio_wifi: wifi@1 {
>>>> +		reg = <1>;
>>>> +	};  
>>> So does the WiFi work with mainline drivers? IIUC the BCM43342 is not
>>> supported by the existing Broadcom drivers?  
>> It's actually BCM43342/1 It System doesn't detect this chip by default.
>> The most relevant message from dmesg is:
>> [   14.042035] kernel: brcmfmac: brcmf_fw_alloc_request: Unknown chip BCM43342/1
>> I believe that it's only a matter of missing module. I don't think it is
>> supported in mainline ATM. I left it to have a wi-fi node accessible
>> and detectable by kernel. If you think that it's better to remove the
>> node if it's not supported I can do it.
> No, that's fine, I was just curious. But another thing to consider are
> any GPIOs connected to the module, for reset and wakeup. Do you have a
> dump of the vendor firmware DT somewhere? At least this information in
> there seems reliable.
> You should be able to access the loaded DTB via /sys/firmware/fdt, then
> can decompile that with dtc. Look for properties ending in -gpios,
> related to WiFi/WLAN.

Yep, I do. I also have gpio dump from /sys/kernel/debug/gpio and some of
the pins are present there

 gpio-207 (                    |wlan_hostwake       ) in  lo
 gpio-208 (                    |bt_hostwake            ) in  hi
 gpio-209 (                    |bt_wake                    ) out hi
 gpio-210 (                    |wlan_regon              ) out lo
 gpio-211 (                    |bt_rst                         ) out lo

DTS doesn't contain any additional information apart from the string that
defines hostwake and regon.
            wlan_hostwake = <0x53 0x06 0x0f 0x06 0xffffffff 0xffffffff 0x00>;
            wlan_regon = <0x53 0x06 0x12 0x01 0xffffffff 0xffffffff 0x00>;

The only -gpios properties are for the sdcard. It's already included in dts.

There are quite more pins allocated in /sys/kernel/debug/gpio but they
are not labeled, or not relevant for this device.

>> Somebody actually extracted modified precompiled module from custom
>> 5.15.16 rockchip kernel, which implements support for this card. There's no
>> patch for it that could be submitted to mainline unfortunately ATM.
>>
>> I've found a patch that adds chip id strings to brcmfmac, but I would like to
>> test it beforehand.
> Sure, using the SDIO ID it should autodetect it, and mainline Linux not
> (yet) supporting it is strictly speaking not a reason to not describe
> it in the DT - only that we would like to test it somehow, of course.
> So if in doubt leave it as it is, that should not hurt in any case.

Let's leave it. Right now I can pin-point that there is missing firmware blob.
The firmware and patch for WIFI and BT is floating on the net, but it's not
mainlined in firmware repo (yet, hopefully).

Cheers,
Kamil

>>>> +};
>>>> +
>>>> +&ohci0 {
>>>> +	status = "okay";
>>>> +};
>>>> +
>>>> +&ohci2 {
>>>> +	status = "okay";
>>>> +};
>>>> +
>>>> +&uart0 {
>>>> +	pinctrl-names = "default";
>>>> +	pinctrl-0 = <&uart0_ph_pins>;
>>>> +	status = "okay";
>>>> +};
>>>> +
>>>> +&uart1 {
>>>> +	pinctrl-names = "default";
>>>> +	pinctrl-0 = <&uart1_pins>, <&uart1_rts_cts_pins>;
>>>> +	uart-has-rtscts;
>>>> +	status = "okay";  
>>> Similar question here, what is the Bluetooth situation in mainline? I
>>> guess it's not supported, since you didn't put a BT node in here?  
>> I haven't tested that yet. It's partially due to lack of experience with
>> DTS. I would like to figure out mainline support eventually, but for now
>> I would like to just have a working foundation for these TVB.
>>
>> If that's also not really a wanted option to leave those nodes, I can
>> remove them for now.
> No, again that's fine from a pure DT perspective. The information above
> seems accurate. But again there might be GPIOs at play here, something
> to look out for in the vendor DT.
> In my experience the BT seem to be easier to support. Even for combined
> modules you might have luck and see BT working, even when WiFi does not.
> But again, just leave it as it is now, we can always add that later,
> that should not block the submission.
>
>>>> +};
>>>> +
>>>> +&usbotg {
>>>> +	dr_mode = "host";	/* USB A type receptable */
>>>> +	status = "okay";
>>>> +};
>>>> +
>>>> +&usbphy {
>>>> +	status = "okay";
>>>> +};
>>>> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h616-t95max-axp313.dts b/arch/arm64/boot/dts/allwinner/sun50i-h616-t95max-axp313.dts
>>>> new file mode 100644
>>>> index 000000000000..c8650aca2407
>>>> --- /dev/null
>>>> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h616-t95max-axp313.dts
>>>> @@ -0,0 +1,85 @@
>>>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>>>> +/*
>>>> + * Copyright (C) 2024 Kamil Kasperski <ressetkk@gmail.com>
>>>> + *
>>>> + * Configuration for T95 TV box with board label H616-T95MAX-AXP313A-v3.0
>>>> + */
>>>> +
>>>> +/dts-v1/;
>>>> +
>>>> +#include "sun50i-h616-t95.dtsi"
>>>> +
>>>> +/ {
>>>> +	model = "T95 5G (AXP313)";
>>>> +	compatible = "t95,t95max-axp313", "allwinner,sun50i-h616";
>>>> +};
>>>> +
>>>> +&mmc0 {
>>>> +	vmmc-supply = <&reg_dldo1>;
>>>> +};
>>>> +
>>>> +&mmc1 {
>>>> +	vmmc-supply = <&reg_dldo1>;
>>>> +	vqmmc-supply = <&reg_aldo1>;
>>>> +};
>>>> +
>>>> +&r_i2c {
>>>> +	status = "okay";
>>>> +
>>>> +	axp313: pmic@36 {
>>>> +		compatible = "x-powers,axp313a";
>>>> +		reg = <0x36>;
>>>> +		#interrupt-cells = <1>;
>>>> +		interrupt-controller;
>>>> +		interrupt-parent = <&pio>;  
>>> I don't think you need interrupt-parent unless you also actually specify
>>> an interrupt line.
>>> (But please keep #interrupt-cells and interrupt-controller.)  
>> I think you may be right. I based this part off of OPiZ3 dts, rather than
>> transpeed. Will update in the v4.
> Thanks!
>
> Cheers,
> Andre
>   
>>>> +
>>>> +		vin1-supply = <&reg_vcc5v>;
>>>> +		vin2-supply = <&reg_vcc5v>;
>>>> +		vin3-supply = <&reg_vcc5v>;
>>>> +
>>>> +		regulators {
>>>> +			reg_aldo1: aldo1 {
>>>> +				regulator-always-on;
>>>> +				regulator-min-microvolt = <1800000>;
>>>> +				regulator-max-microvolt = <1800000>;
>>>> +				regulator-name = "vcc1v8";
>>>> +			};
>>>> +
>>>> +			reg_dldo1: dldo1 {
>>>> +				regulator-always-on;
>>>> +				regulator-min-microvolt = <3300000>;
>>>> +				regulator-max-microvolt = <3300000>;
>>>> +				regulator-name = "vcc3v3";
>>>> +			};
>>>> +
>>>> +			reg_dcdc1: dcdc1 {
>>>> +				regulator-always-on;
>>>> +				regulator-min-microvolt = <810000>;
>>>> +				regulator-max-microvolt = <990000>;
>>>> +				regulator-name = "vdd-gpu-sys";
>>>> +			};
>>>> +
>>>> +			reg_dcdc2: dcdc2 {
>>>> +				regulator-always-on;
>>>> +				regulator-min-microvolt = <810000>;
>>>> +				regulator-max-microvolt = <1100000>;
>>>> +				regulator-name = "vdd-cpu";
>>>> +			};
>>>> +
>>>> +			reg_dcdc3: dcdc3 {
>>>> +				regulator-always-on;
>>>> +				regulator-min-microvolt = <1500000>;
>>>> +				regulator-max-microvolt = <1500000>;
>>>> +				regulator-name = "vdd-dram";
>>>> +			};
>>>> +		};
>>>> +	};
>>>> +};
>>>> +
>>>> +&pio {
>>>> +	vcc-pc-supply = <&reg_aldo1>;
>>>> +	vcc-pf-supply = <&reg_dldo1>;
>>>> +	vcc-pg-supply = <&reg_dldo1>;  
>>> So if vqmmc-supply for MMC1 is at the 1.8V from ALDO1, that must mean that
>>> the whole of PortG is at 1.8V, right? So I think this would need to be
>>> reg_aldo1 here.
>>>
>>> Apart from those minor things it looks good to me.
>>>
>>> Cheers,
>>> Andre  
>> Good catch. Will update in v4.
>>
>> Cheers,
>> Kamil
>>
>>>> +	vcc-ph-supply = <&reg_dldo1>;
>>>> +	vcc-pi-supply = <&reg_dldo1>;
>>>> +};
>>>>  
>>


