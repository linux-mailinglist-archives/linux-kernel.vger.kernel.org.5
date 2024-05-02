Return-Path: <linux-kernel+bounces-166467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9ED08B9B0E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 14:45:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6136E281CC0
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 12:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44D7F84A24;
	Thu,  2 May 2024 12:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="wMrBMkJ9"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85EAA824A7
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 12:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.215.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714653935; cv=none; b=HTanFasUu6ZYSyPyhHRRBcGSwNIqd3/7wM50CU8Bjy75r4V4oXUTWJ1I79ZrJyXVZOqj+8Cket+WhsvBF5NlIRPqhokkKD1/CmaSGoRmL4dx/bqx/yH7gaLj3H7bKWBXflzY6nP47o8EdabhXXODexSK8qk6AxZrY+BJQRexdDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714653935; c=relaxed/simple;
	bh=HlRU/S53OsVGNsZ6HdhynXOg2P6j3cdsqc8eUFn4GlE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O/A3a+AMBjTFf7XuwAB38gfq5vSzMe9B52TLzQPhwOiWGOgH6nwM5bDMgmY+pkUky1wVDPlHqYPqxA20+Hh+pYbOWM63xoICoVIBFheSf/fQNR23AKg7XBO29pD3z0cHmiCe/fwr3tWZGf1cUnpYmdhWzdfoXvubDDUgeAWUh3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=wMrBMkJ9; arc=none smtp.client-ip=149.28.215.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1714653926;
 bh=ZheNXb4kFiyFslkWqYIOhADWuSoeRFTlaYHNccaMueg=;
 b=wMrBMkJ9lJBfl54R4lrLd2v/2j09mpaZkQjAhRJz30pHfiuoNe+nfoz2MHJRuMxBdo4SFCu3e
 GcVk+CLOmBgYte94F6IX2DFCk5pMHfQFC6w4E23XlGjDln6ubyqEpixz4Plfh75uSy3XjgAnvxV
 GBQGfFByYhjIfCsGqy5Xi+eBWDH6/RezvKFYEJ5Kb0QDfz+WcBC5667KDimZ/Xyn5Fcd1f6+sDO
 jzlXMfR6FBkk8qiBPVoceGFmFWFS0RfYIAj517+tYUIzV2WmD5lwfouJ+TmqP+jyrS4k6GrG73R
 aWTnMfPsBaW/SMQeuIYkb38EJDsEPA31e3Vc9qJdL5VQ==
Message-ID: <75cc31d9-beb2-456b-a9e8-8f7ec4711029@kwiboo.se>
Date: Thu, 2 May 2024 14:45:21 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: dts: rockchip: Add Radxa ROCK3 Model C
To: Chukun Pan <amadeus@jmu.edu.cn>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, heiko@sntech.de,
 krzk+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
 robh@kernel.org
References: <d7de2213-8dd2-42ec-9a30-a569ac71be3e@kwiboo.se>
 <20240417133016.62753-1-amadeus@jmu.edu.cn>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20240417133016.62753-1-amadeus@jmu.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 66338ae5f48eecfc8b9e844c

Hi Chukun,

Sorry for late reply, I will test and review your v2 later today :-)

On 2024-04-17 15:30, Chukun Pan wrote:
> Hi Jonas,
>>> +	model = "Radxa ROCK3 Model C";
>>
>> The marketing name seems to be "Radxa ROCK 3C" according to the product
>> page at [1].
>>
>> [1] https://radxa.com/products/rock3/3c
> 
> According to https://wiki.radxa.com/Rock3/3c , it should be called
> "Radxa ROCK 3 Model C". I copied rock3a here without paying attention.
> 
>>> +	compatible = "radxa,rock3c", "rockchip,rk3566";
>>
>> A personal preference would be to match the product name and the dtb
>> filename, e.g. "radxa,rock-3c".
> 
> I thought so too, here is also copied from rock3a.
> I think rock3a needs fixing too?
> 
>>> +		led_user: led-0 {
>> This is called user_led2 in the schematic, in case we want the symbol
>> to match the schematic.
> 
>>> +		regulator-name = "vcc5v0_usb_host";
>> This regulator is named vcc5v0_usb30_host in schematic.
> 
> Thanks, I will fix it.
> 
>>> +		#clock-cells = <1>;
>>> +		clock-names = "mclk";
>>> +		clocks = <&cru I2S1_MCLKOUT_TX>;
>>
>> I think clock-output-names may be missing? Something like:
>>
>>  clock-output-names = "rk809-clkout1", "rk809-clkout2";
> 
> Thanks, I'll add it in the next patch.
> 
>>> +		pinctrl-names = "default";
>>> +		pinctrl-0 = <&pmic_int_l>, <&i2s1m0_mclk>;
>>> +		rockchip,system-power-controller;
> 
>> I think this prop is deprecated and system-power-controller
>> should be used instead.
> 
>>> +				regulator-state-mem {
>>> +					regulator-on-in-suspend;
>>> +					regulator-suspend-microvolt = <900000>;
> 
>> Not sure we need this in suspend to ram and this can probably use:
>>
>>  regulator-off-in-suspend
>>
>> That is also what vendor kernel does.
> 
> Will be corrected in the next patch.
> 
>>> +			vcc3v3_sd: SWITCH_REG2 {
>>> +				regulator-name = "vcc3v3_sd";
>>> +				regulator-always-on;
>>> +				regulator-boot-on;
>>
>> If I am reading the schematic correctly this is not connected.
> 
> Yes, I didn't notice it was NC, thanks.
> 
>>> +&sdhci {
>>> +	bus-width = <8>;
>>> +	max-frequency = <200000000>;
>> This board support HS200, please add:
>>
>>  mmc-hs200-1_8v
> 
> Will be added in the next patch.
> 
>>> +&sdmmc0 {
>>> +	bus-width = <4>;
>>> +	cap-sd-highspeed;
>>> +	cd-gpios = <&gpio0 RK_PA4 GPIO_ACTIVE_LOW>;
>>
>> Please drop the cd-gpios prop, sdmmc0_det is used below and
>> works fine on this board.
> 
> Do other rk356x boards also need this change?

Yes, I think in general on Rockchip platform it is preferred to
configure the pin for sd-card detect function instead of using the
cd-gpios prop (pin configured to use gpio function) when the default
pin is used and correctly wired to sd-slot.

The RK3566 HW design guide also mention following:

"""
RK3566 reuses JTAG function and SDMMC function together to reduce IO pin
count and take into account the convenience of the complete machine
debugging. The SDMMC0_DET pin is used to switch the output function.
Therefore, this pin must be configured before power-on. Otherwise, the
debugging during the boot period will be affected if JTAG has no output,
and SDMMC0 has no output will affects SDMMC boot.
- SDMMC0_DET pin detects that the level is high, the IO switches to the
  JTAG function;
- SDMMC0_DET detects that the level is low (normal state of SD card
  insertion, and the PIN is pulled down by SD card slot), the IO
  function is switched to SDMMC;
"""

And similar was changed on RK3588 boards in:

arm64: dts: rockchip: rk3588: remove redundant cd-gpios in sdmmc node
https://lore.kernel.org/linux-rockchip/20240201034621.1970279-1-kever.yang@rock-chips.com/

> 
>>> +	sd-uhs-sdr50;
>>
>> Why limit to sdr50? and not use sd-uhs-sdr104?
> 
> The sdr104 mode is not stable on the rk356x platform.
> This problem has been reported on both rock3a and e25 boards.

Do you have any references for these issues?

When I tested on Radxa ZERO 3W/3E there was an issue executing tuning
that resulted in a not working sdr104 mode. However, after the card is
removed and re-inserted the tuning works and the card can use sdr104
mode.

That issue seems to be related to the io-domain driver not being notified
about the voltage change when mmc driver is probed during boot. When the
card is removed and re-inserted the io-domain driver gets notified and
re-configure the io-domain.

Testing on a RK3328 board (Rock64) the io-domain driver gets notified
about the voltage change during boot and the tuning is successful for
sdr104 mode.

Will re-run tests on my ROCK 3C boards to validate is that is the same
issue, guessing it may affect multiple RK356x boards.

Regards,
Jonas

> 
>>> +	vmmc-supply = <&vcc3v3_sd>;
>>
>> If I read the scematics correctly this is using the
>> vcc3v3_sys regulator and not the vcc3v3_sd.
> 
> Yes, you are right. I didn't notice it, thanks.
> 
>>> +&sfc {
>>
>> This is missing pinctrl:
>>
>>  pinctrl-names = "default";
>>  pinctrl-0 = <&fspi_pins>;
> 
> This is already defined on rk356x.dtsi:
> 
> 	sfc: spi@fe300000 {
> 		compatible = "rockchip,sfc";
> 		......
> 		pinctrl-0 = <&fspi_pins>;
> 		pinctrl-names = "default";
> 		status = "disabled";
> 	};
> 
>>> +		spi-max-frequency = <104000000>;
>>
>> My board is using a GD25LQ128EWIGR same as mentioned in the schematic,
>> and datasheet for this flash chip menion 120 mhz and not 104 mhz.
> 
> Will be corrected in the next patch, thanks.
> 
> Thanks,
> Chukun


