Return-Path: <linux-kernel+bounces-51867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DB13849041
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 21:02:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D21651F21BEF
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 20:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 386F925564;
	Sun,  4 Feb 2024 20:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="hXSuCVq2"
Received: from mail-m17207.xmail.ntesmail.com (mail-m17207.xmail.ntesmail.com [45.195.17.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3FF62555B;
	Sun,  4 Feb 2024 20:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.195.17.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707076944; cv=none; b=rAlXUSxvIqD/F9RXr1jbDSzpzEgkqj9CQ3/vZccbC8CJukXf0t6ScxmNZpfCszP+oApef7svqt0SnUNVlD8XJoI6SjjE2q8qEN0vKyS1YXpmUFDSlhAgPlUuB2OzqGd3S5D1eTQ/cyeGwca6qK5/5ZDWqQM8CiG1OjWwuZGPQxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707076944; c=relaxed/simple;
	bh=Hx5T6jiL5JDohIoeQQYX6s2r6lgspe5rrFcW3TlWnfE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=DfjeNEZ85qwxP8Gkg4BbT40V3MzOEVDTsJ8RZHdYwkdTMZm1jdXiYbXhWUnzjSMHuDq1ksKR2YiaM+vze8oK+1bGElp8Bcfl6MlTvkcRq6T9Lcj2ZCSRzbcRML9hePv5jkFtDxx97TBN4B2hmPoezy7XAAYBM5CzL9f2/CN4gv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=hXSuCVq2; arc=none smtp.client-ip=45.195.17.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
DKIM-Signature: a=rsa-sha256;
	b=hXSuCVq2LKTILSa4M3DYwHpUWtWrO2+lc94QcnrtRZhcYoiQ0+fwbTvSFL9OmF9EPfgXfnX+W9L1zUOG6jfj3kTKGktV1278LF6y/U0KRXCUIvuhpQ898iSg0Q4t76QTcPM+nS2hLT1rhPLoKv4ufoIHlJNOSb3e7E14H06gAYc=;
	c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=JNfM+7oms0dEDMBQD4/1F/HmMJB11Kg5/MrVVOISNs8=;
	h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.93] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTPA id A32209001BC;
	Sun,  4 Feb 2024 17:56:34 +0800 (CST)
Message-ID: <546543ec-7817-4422-8717-82aaf46f2a3b@rock-chips.com>
Date: Sun, 4 Feb 2024 17:56:34 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Kever Yang <kever.yang@rock-chips.com>
Subject: Re: [PATCH] arm64: dts: rockchip: rk3588: remove redundant cd-gpios
 in sdmmc node
To: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
 Ondrej Jirman <megi@xff.cz>
Cc: linux-rockchip@lists.infradead.org,
 Christopher Obbard <chris.obbard@collabora.com>,
 Conor Dooley <conor+dt@kernel.org>,
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
 Dragan Simic <dsimic@manjaro.org>, FUKAUMI Naoki <naoki@radxa.com>,
 Jagan Teki <jagan@edgeble.ai>, John Clark <inindev@gmail.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Rob Herring <robh+dt@kernel.org>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Shreeya Patel <shreeya.patel@collabora.com>,
 =?UTF-8?B?VGFtw6FzIFN6xbFjcw==?= <tszucs@protonmail.ch>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, quentin.schulz@theobroma-systems.com
References: <20240201034621.1970279-1-kever.yang@rock-chips.com>
 <4514845.zXnORWrf4K@diego>
Content-Language: en-US
In-Reply-To: <4514845.zXnORWrf4K@diego>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGhpDSVZJTE8ZS08ZT0xLH09VEwETFh
	oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSUxOVUpLS1VKQk
	tLWQY+
X-HM-Tid: 0a8d738c5eb003a9kunma32209001bc
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NiI6Ezo4TzMIDz42LwlPTi4M
	Hy8KCR5VSlVKTEtMS09LTkJNSkxDVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
	EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFDSUpPNwY+

Hi Heiko,

On 2024/2/1 16:41, Heiko Stübner wrote:
> Hi Kever,
>
> Am Donnerstag, 1. Februar 2024, 04:46:21 CET schrieb Kever Yang:
>> The sdmmc node already have a "&sdmmc_det" for pinctrl which switch the
>> GPIO0A4 to sdmmc detect function, no need to define a separate "cd-gpios".
> just to make sure, did you test this on actual hardware?
> Because there might be differences in behaviour.

We use this feature in vendor kernel for many boards.

For mainline support, there are 15 rk3588/rk3588 boards available, and 
10 of them

enable sdmmc node in dts, and 4 boards define "cd-gpios" while the 
hardware do use GPIO0A4,

and 1 board(rk3588-jaguar) using "broken-cd", and the other 5 boards are 
using default "&sdmmc_det"

  with the same hardware design.

If the hardware is using GPIO0A4(SDMMC_DET function IO) for sdmmc 
detect, then no need to define "cd-gpios";

if the hardware is not using GPIO0A4 for sdmmc detect, then the 
"cd-gpios" or "broken-cd" is needed.

So this patch is to sync up to use the "&sdmmc_det" when the IO is using 
the one has SDMMC_DET function.

>> RK3588 has force_jtage feature which is enable JTAG function via sdmmc
>> pins automatically when there is no SD card insert, this feature will
>> need the GPIO0A4 works in sdmmc_det function like other mmc signal instead
>> of GPIO function, or else the force_jtag can not auto be disabled when
>> SD card insert.
> We disable the jtag switching by default [0] ;-) .
> And there are very good reasons for it too:

I know you have disable the force_jtag by default, and I didn't want to 
change this.

As you have said we may need to enable it for debug, we suppose to only 
have to revert

the disable force_jtag patch and then it works without affect the 
default sdmmc function.

The sdmmc function is broken if we enable force_jtag for debug, and this 
patch can fix it.

> (1) JTAG is very much a debug feature, that the normal user will not need.
> Especially not in a finished product. If a developer is debugging _that_
> deep and needs jtag, they can enable it in their debug build.
>
>
> (2) Randomly enabling features that may compromise security.
> Why go through all the hoops of doing things like secure boot, signed
> images and everything, just to have the kernel then export direct access
> to the hardware on sd-card pins. If one wants to expose JTAG somewhere
> this should be conscious choice and devs should not need to fork their
> kernel just to shut down unwanted security-critical functionality.
>
>
> (3) It affects board layouts _not following_ the standard layout.
> Nobody is forcing board-designers to use Rockchip's desired pin
> for card-detection. Some designer may just select a different pin
> or a board could go without card-detect at all - see rk3588-jaguar.

You are right, "cd-gpios" and "broken-cd" are available for boards have 
different design,

and this patch is for the boards with SDMMC_DET(GPIO0A4) as sdmmc 
detect, they should go to

the default "&sdmmc_det" in sdmmc node.


Thanks,

- Kever

> These are both valid use-cases that need to be supported.
>
>
> Heiko
>
>
> [0]https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=6f6878ec6faf16a5f36761c93da6ea9cf09adb33
>
>
>> ---
>>
>>   arch/arm64/boot/dts/rockchip/rk3588-orangepi-5-plus.dts | 1 -
>>   arch/arm64/boot/dts/rockchip/rk3588-quartzpro64.dts     | 1 -
>>   arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts         | 1 -
>>   arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts        | 1 -
>>   4 files changed, 4 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/rockchip/rk3588-orangepi-5-plus.dts b/arch/arm64/boot/dts/rockchip/rk3588-orangepi-5-plus.dts
>> index 3e660ff6cd5ff..1b606ea5b6cf2 100644
>> --- a/arch/arm64/boot/dts/rockchip/rk3588-orangepi-5-plus.dts
>> +++ b/arch/arm64/boot/dts/rockchip/rk3588-orangepi-5-plus.dts
>> @@ -444,7 +444,6 @@ &sdhci {
>>   &sdmmc {
>>   	bus-width = <4>;
>>   	cap-sd-highspeed;
>> -	cd-gpios = <&gpio0 RK_PA4 GPIO_ACTIVE_LOW>;
>>   	disable-wp;
>>   	max-frequency = <150000000>;
>>   	no-sdio;
>> diff --git a/arch/arm64/boot/dts/rockchip/rk3588-quartzpro64.dts b/arch/arm64/boot/dts/rockchip/rk3588-quartzpro64.dts
>> index 87a0abf95f7d4..67414d72e2b6e 100644
>> --- a/arch/arm64/boot/dts/rockchip/rk3588-quartzpro64.dts
>> +++ b/arch/arm64/boot/dts/rockchip/rk3588-quartzpro64.dts
>> @@ -429,7 +429,6 @@ &sdhci {
>>   &sdmmc {
>>   	bus-width = <4>;
>>   	cap-sd-highspeed;
>> -	cd-gpios = <&gpio0 RK_PA4 GPIO_ACTIVE_LOW>;
>>   	disable-wp;
>>   	max-frequency = <150000000>;
>>   	no-sdio;
>> diff --git a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
>> index a0e303c3a1dc6..25a82008e4f76 100644
>> --- a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
>> +++ b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
>> @@ -371,7 +371,6 @@ &sdmmc {
>>   	bus-width = <4>;
>>   	cap-mmc-highspeed;
>>   	cap-sd-highspeed;
>> -	cd-gpios = <&gpio0 RK_PA4 GPIO_ACTIVE_LOW>;
>>   	disable-wp;
>>   	sd-uhs-sdr104;
>>   	vmmc-supply = <&vcc_3v3_s3>;
>> diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts b/arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts
>> index 2002fd0221fa3..00afb90d4eb10 100644
>> --- a/arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts
>> +++ b/arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts
>> @@ -366,7 +366,6 @@ &sdmmc {
>>   	bus-width = <4>;
>>   	cap-mmc-highspeed;
>>   	cap-sd-highspeed;
>> -	cd-gpios = <&gpio0 RK_PA4 GPIO_ACTIVE_LOW>;
>>   	disable-wp;
>>   	max-frequency = <150000000>;
>>   	no-sdio;
>>
>

