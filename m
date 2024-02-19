Return-Path: <linux-kernel+bounces-71409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98D7685A4BA
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 14:35:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51D46281151
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 13:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE4D1364A8;
	Mon, 19 Feb 2024 13:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="3mGxzeMt"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2480836137;
	Mon, 19 Feb 2024 13:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708349731; cv=none; b=E3Al2Oxo7l+6PsgPIon3KsJ6vn83hBjM5vSdeHu3UdI/dFSGvA86K6nBhtsJn9bzo3Nr1jJRpAnMYCzlmcQFPtzr2ROsukS5Ndepm6ZWUHPXoRL1RjnDwQyCAu1+SwFwe1y//r+sRuD6MHqGsJWDwwWxsF9CByqKkcDA8qKePZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708349731; c=relaxed/simple;
	bh=H+UegT4BE+l/Z0xlxbb/7nPi5qpmwmDLNcLFfpCwUQg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oBpgagErjgaLOnV6mN31pW8nlDF5Stn/U7Jw4J2DtlzDk0WzlU4DPCV6sTzQ/THdj/02K61pnEJTDUjboJ4zRNlYh3Uk58BzMAAI+NUckBLFuxoHfARAqIAVbQNlVoJQ2JYChiKVZc2H1+P6Hubv9A4Y2OBC6fCh6U0CLMmOq9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=3mGxzeMt; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1708349728;
	bh=H+UegT4BE+l/Z0xlxbb/7nPi5qpmwmDLNcLFfpCwUQg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=3mGxzeMtAtJnOMk/f0rnl5QqoOUEOpXpEQaxNMOK7/4eAuCPchAACkvTY7gIPgb0s
	 +hp6Ku/nzt5szkdIZBqexS32JKrzx5my+G7WCwZ4d3x6s8stLbEuVcpqO7+l1u4v+l
	 LsjH5Ka+K+sBUGvQCA9deontJ75oV/y+zQK1HsuH9IHZXSEG0gfqOP5DhJvUolMAu6
	 8KYZbPb6QTG6VXcvGxUA7CRh7ZBIacEwZqmEKaLitkPxv8C3v9JQiNKyPECnoI9VgO
	 wFIJFHNKKIEZsjWvGHVQdTIX9qYSfaI2Wj0ZMhMagAfNJMi2YNMSs+5fBEUDz/qSjd
	 FPrJbhiGlWxzA==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 86C053780C22;
	Mon, 19 Feb 2024 13:35:27 +0000 (UTC)
Message-ID: <b50d49fd-2976-46fc-9f35-354fb39720ad@collabora.com>
Date: Mon, 19 Feb 2024 14:35:26 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] arm64: dts: mediatek: add Kontron 3.5"-SBC-i1200
Content-Language: en-US
To: Michael Walle <mwalle@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: devicetree@vger.kernel.org, Sean Wang <sean.wang@mediatek.com>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20240219084456.1075445-1-mwalle@kernel.org>
 <20240219084456.1075445-2-mwalle@kernel.org>
 <2ad6bda8-a457-421b-b35d-dc005fb00ae9@collabora.com>
 <CZ92W3VSYV1A.1693O76GY1XDP@kernel.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <CZ92W3VSYV1A.1693O76GY1XDP@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 19/02/24 14:09, Michael Walle ha scritto:
> Hi,
> 
> thanks for the extensive review!
> 
> On Mon Feb 19, 2024 at 11:00 AM CET, AngeloGioacchino Del Regno wrote:
> 
>>> +&eth {
>>> +	phy-mode ="rgmii-id";
>>> +	phy-handle = <&ethernet_phy0>;
>>> +	snps,reset-gpio = <&pio 93 GPIO_ACTIVE_HIGH>;
>>> +	snps,reset-delays-us = <0 10000 80000>;
>>
>> snps,reset-delays-us and snps,reset-gpio are deprecated.
>>
>>> +	pinctrl-names = "default", "sleep";
>>> +	pinctrl-0 = <&eth_default_pins>;
>>> +	pinctrl-1 = <&eth_sleep_pins>;
>>> +	status = "okay";
>>> +
>>> +	mdio {
>>> +		ethernet_phy0: ethernet-phy@1 {
>>
>> compatible = "is there any applicable compatible?"
>> P.S.: if you've got the usual rtl8211f, should be "ethernet-phy-id001c.c916"
> 
> I'd rather not have a compatible here. First, it's auto discoverable
> and IIRC it's frowned upon adding any compatible if you ask the PHY
> maintainers. And second, if we change the PHY (maybe due to a second
> chip shortage or whatever), there is a chance you don't have to
> update this in the DT.
> 

Okay then, I'm fine with leaving the compatible out.

>> reg = <0x1>;
>> interrupts-extended = <&pio 94 IRQ_TYPE_LEVEL_LOW>;
>> reset-assert-us = <10000>;
>> reset-deassert-us = <80000>;
>> reset-gpios = <&pio 93 GPIO_ACTIVE_HIGH>;
>>
>>
>>> +			reg = <0x1>;
>>> +			interrupts-extended = <&pio 94 IRQ_TYPE_LEVEL_LOW>;
>>> +		};
>>> +	};
>>> +};
>>> +
>>> +&gpu {
>>> +	status = "okay";
>>> +	mali-supply = <&mt6315_7_vbuck1>;
>>> +};
>>> +
>>> +&i2c2 {
>>> +	pinctrl-names = "default";
>>> +	pinctrl-0 = <&i2c2_pins>;
>>> +	clock-frequency = <400000>;
>>> +	status = "okay";
>>
>> Are i2c2,3,4 exposed as pins somewhere? If they are, can you please put a
>> comment saying so?
> 
> This is only a basic device tree. On one i2c controller, there is
> the LVDS bridge for example. My plan is to get the support for this
> bridge upstream first and then adding the appropriate device nodes
> here.
> 
> That being said, some are exposed to connectors. I'll add a comment
> then.

In that case, could be nice to read something like

&i2c(x) {
	properties
	blahblah
	status

	/* (model, if available) LVDS bridge at 0x10 */
}

it's again not mandatory, but I like seeing clear messages implying "this should be
there" as those implicitly mean "...yeah but it's not supported yet for reasons".

It's down to preferences though, and this is not a *strong* opinion, nor a strong
suggestion - your call here.

> 
>>> +&mmc1 {
>>> +	pinctrl-names = "default", "state_uhs";
>>> +	pinctrl-0 = <&mmc1_default_pins>;
>>> +	pinctrl-1 = <&mmc1_uhs_pins>;
>>> +	cd-gpios = <&pio 129 GPIO_ACTIVE_LOW>;
>>> +	bus-width = <4>;
>>> +	max-frequency = <200000000>;
>>> +	cap-sd-highspeed;
>>> +	sd-uhs-sdr50;
>>> +	sd-uhs-sdr104;
>>> +	vmmc-supply = <&mt6360_ldo5>;
>>> +	vqmmc-supply = <&mt6360_ldo3>;
>>
>> Does mmc1 support eMMC and SDIO?
> 
> No eMMC, but I'd guess it will support SDIO as in you can just plug
> an SDIO card in the SD slot, right? Oh, it's a micro SD socket. So
> uhm, I'm not sure if we should restrict it, though. Someone might
> come up with a microsd to sd card adapter. I have one right in front
> of me ;)
> 

Honestly ... I even forgot the existance of those adapters!!!
In that case, yes, since the controller should support SDIO on that slot, and since
there effectively are ways to add a SDIO card on there, obviously no-sdio shall be
omitted.

I agree.

>> If not, no-mmc; no-sdio;
> 
> So no-mmc;

Yes, agreed.

> 
>>> +			drive-strength = <MTK_DRIVE_8mA>;
>>
>> s/MTK_DRIVE//g
>> s/mA//g
>>
>> drive-strength = <8>;
>>
>> Please, here and everywhere else, for all values - let's stop using those
>> MTK_DRIVE_(x)mA definitions, they're just defined as (x), where anyway
>> the drive-strength property is in milliamps by default.
>>
>> We don't need these definitions.
> 
> Sure, the mt8195-demo was the blueprint for this. So maybe you should
> get rid of it there to prevent any copying ;) (btw the same goes for
> the regulator-compatible property).
> 

Yeah, that's right. You can imagine that my backlog is rather huge... :-)

> Speaking of pinctrl, I find the R0R1 bias-pull-down values really

If it was only pull-down it would be one problem, but it's also pull-up so
we can sum that up to *two* problems :-P

> hard to grasp. The DT binding documentation didn't really help here.
> What is R0 and R1, I presume some resistors which can be enabled.

You got it right

> Also are they in parallel or in series. I'd have assumed, the DT

I'm not sure, and it depends on the SoC most probably... but does that really
matter?

I mean, on the practical side, imo, it doesn't, but I am also a curious person
so I can understand why you're eager to know :-)

> binding should have hid this by giving the user a choice for the
> resistance instead. Also I had a quick search in the RM and
> couldn't find anything, I probably looked at the wrong place ;)
> 

I'm not sure you looked at mediatek,mt8195-pinctrl.yaml, but anyway, as you
can read in there, we're deprecating the MTK_PULL_SET_RSEL_xxx in favor of...

... the right thing to do :-)

Look for "mediatek,rsel-resistance-in-si-unit": that'll allow you to specify
the PU/PD values in ohms, and that's what should be used.

Those RSEL definitions in the devicetree should disappear. Forever.

>>> +	uart1_pins: uart1-pins {
>>> +		pins_rx {
>>> +			pinmux = <PINMUX_GPIO103__FUNC_URXD1>;
>>> +			input-enable;
>>> +			bias-pull-up;
>>> +		};
>>> +
>>> +		pins_tx {
>>> +			pinmux = <PINMUX_GPIO102__FUNC_UTXD1>;
>>> +		};
>>> +
>>> +		pins_rts {
>>> +			pinmux = <PINMUX_GPIO100__FUNC_URTS1>;
>>> +			output-enable;
>>
>> Are you really sure that you need output-enable here?!
>> RTS is not an output buffer....
>>
>> I don't think you do. Please double check.
> 
> Ahh, good catch, it's a leftover from mt8183-kukui.dts. There is
> probably wrong, too.
> 

Probably. I don't really know either.

>>> +		};
>>> +
>>> +		pins_cts {
>>> +			pinmux = <PINMUX_GPIO101__FUNC_UCTS1>;
>>> +			input-enable;
>>> +		};
>>> +	};
>>> +
> 
> 
>>> +/* USB3 front port */
>>> +&xhci0 {
>>
>> It's not gonna work like this. I recently fixed the USB nodes in MT8195 by adding
>> MTU3 where necessary...
> 
> Uhm, seems like I've missed that.
> 

No worries!

>> Check mt8195.dtsi - only one XHCI controller isn't placed behind MTU3, and that is
>> XHCI1 (11290000), while the others are MTU3.
>>
>> As far as I can see from this DT, it should now instead look like..
>>
>> &ssusb0 {
>> 	dr_mode = "host";
>> 	vusb33-supply = <&mt6359_vusb_ldo_reg>;
>> 	status = "okay";
>> };
>>
>> &ssusb2 {
>> 	dr_mode = "host";
>> 	vusb33-supply = <&mt6359_vusb_ldo_reg>;
>> 	status = "okay";
>> };
>>
>> &ssusb3 {
>> 	dr_mode = "host";
>> 	vusb33-supply = <&mt6359_vusb_ldo_reg>;
>> 	status = "okay";
>> };
>>
>> &xhci0 {
>> 	vbus-supply = <&otg_vbus_regulator>;
>> 	status = "okay";
>> };
>>
>> &xhci1 {
>> 	vusb33-supply = <&mt6359_vusb_ldo_reg>;
>>
>> vbus is always supplied by something, as otherwise USB won't work - whether this
>> is an always-on regulator or a passthrough from external supply this doesn't really
>> matter - you should model a regulator-fixed that provides the 5V VBUS line.
> 
> I don't think this is correct, though. Think of an on-board USB
> hub. There only D+/D- are connected (and maybe the USB3.2 SerDes
> lanes). Or have a look at the M.2 pinout. There is no Vbus.
> 

Yes but the MediaTek MTU3 and/or controllers do have it ;-)

> Also it seems I need the "mediatek,u3p-dis-msk = <0x01>;". At least
> the last time I've tested it. I'll test it again, with and without.
> The SerDes Line of the corresponding USB3.2 port is used for PCIe in
> this case.
> 

Have I missed it in my example? If I missed it, that was unintentional.

Anyway, for the u3p-dis-msk, I'll spare you the time to check:
  - If the controller lies behind MTU3, that property goes to &ssusb(x)
  - If it is a standalone XHCI controller, it goes to &xhci(x)
    - The property never goes to both, and always goes to the *outer* node
      (this is why it goes to mtu3 if there's a mtu3 behind).

>> For example:
>> 	vbus_fixed: regulator-vbus {
>> 		compatible = "regulator-fixed";
>> 		regulator-name = "usb-vbus";
>> 		regulator-always-on;
>> 		regulator-boot-on;
>> 		regulator-min-microvolt = <5000000>;
>> 		regulator-max-microvolt = <5000000>;
>> 	};
> 
> As mentioned above, I don't think this will make sense in my case.
>  >> P.S.: If the rail has a different name, please use that different name. Obviously
>> that requires you to have schematics at hand, and I don't know if you do: if you
>> don't, then that regulator-vbus name is just fine.
> 
> I do have the schematics.

In that case, you should model the power tree with the fixed power lines,
check mt8195-cherry (and/or cherry-tomato) and radxa-nio-12l; even though
those are technically "doing nothing", this is device tree, so it should
provide a description of the hardware ... and the board does have fixed
power lines.
It has at least one: DC-IN (typec, barrel jack or whatever, the board needs
power, doesn't it?!).

Cheers,
Angelo



