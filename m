Return-Path: <linux-kernel+bounces-148592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC5998A84D7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 15:37:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FA4C2826C6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 13:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0788013F433;
	Wed, 17 Apr 2024 13:37:19 +0000 (UTC)
Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83BD063A;
	Wed, 17 Apr 2024 13:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713361038; cv=none; b=NT9rnhONRtjgvuo3LjXvW+d7ld3ovVyMQr+nFd/Z/Xa8Hh9yOd+HrlI04apUOCcCeADHanSFxDM7/Y9gpEheQMjO365VZahIVfAisLrMy28rwOGRmzZZbyEZs7TSPCcxcHwOM1kceArgeBExKC61KZOz+fjvMgQEcRgPEd9LxrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713361038; c=relaxed/simple;
	bh=ov8GKYua+MoHO12lS96j2dho16PVFKKVsev2w6hYUdg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QAQmeg2snOuHkOddXYm8HK+YfI2etMfVUHF+lfKHt6jfMEFikzGWRNO4vVQEO/gOYSI7FHmrRNIe1fUJu8ppWGnQanuFPeXvGhx4tIamQ/4gJVHh9d7sV3uREZI7eSW/zZqJjaByPMmezM+HIMqlOf4+/dV6aXIIqZHVEvneGTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from amadeus-Vostro-3710.lan (unknown [58.61.140.80])
	by smtp.qiye.163.com (Hmail) with ESMTPA id F21EA7E0125;
	Wed, 17 Apr 2024 21:30:20 +0800 (CST)
From: Chukun Pan <amadeus@jmu.edu.cn>
To: jonas@kwiboo.se
Cc: amadeus@jmu.edu.cn,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	heiko@sntech.de,
	krzk+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	robh@kernel.org
Subject: Re: [PATCH 2/2] arm64: dts: rockchip: Add Radxa ROCK3 Model C
Date: Wed, 17 Apr 2024 21:30:16 +0800
Message-Id: <20240417133016.62753-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <d7de2213-8dd2-42ec-9a30-a569ac71be3e@kwiboo.se>
References: <d7de2213-8dd2-42ec-9a30-a569ac71be3e@kwiboo.se>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZH09NVklOSBgZGEofQhoYTVUTARMWGhIXJBQOD1
	lXWRgSC1lBWU5DVU1KVUpPS1VDS1lXWRYaDxIVHRRZQVlPS0hVSkpLSEpDVUpLS1VLWQY+
X-HM-Tid: 0a8eec404ea403a2kunmf21ea7e0125
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6KzY6KTo4QzMQFQFWPjwCCC46
	SyJPCShVSlVKTEpISE1LTUlKTUJLVTMWGhIXVRoWGh8eDgg7ERYOVR4fDlUYFUVZV1kSC1lBWU5D
	VU1KVUpPS1VDS1lXWQgBWUFPT0xINwY+

Hi Jonas,
>> +	model = "Radxa ROCK3 Model C";
>
> The marketing name seems to be "Radxa ROCK 3C" according to the product
> page at [1].
>
> [1] https://radxa.com/products/rock3/3c

According to https://wiki.radxa.com/Rock3/3c , it should be called
"Radxa ROCK 3 Model C". I copied rock3a here without paying attention.

>> +	compatible = "radxa,rock3c", "rockchip,rk3566";
>
> A personal preference would be to match the product name and the dtb
> filename, e.g. "radxa,rock-3c".

I thought so too, here is also copied from rock3a.
I think rock3a needs fixing too?

>> +		led_user: led-0 {
> This is called user_led2 in the schematic, in case we want the symbol
> to match the schematic.

>> +		regulator-name = "vcc5v0_usb_host";
> This regulator is named vcc5v0_usb30_host in schematic.

Thanks, I will fix it.

>> +		#clock-cells = <1>;
>> +		clock-names = "mclk";
>> +		clocks = <&cru I2S1_MCLKOUT_TX>;
>
> I think clock-output-names may be missing? Something like:
>
>  clock-output-names = "rk809-clkout1", "rk809-clkout2";

Thanks, I'll add it in the next patch.

>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&pmic_int_l>, <&i2s1m0_mclk>;
>> +		rockchip,system-power-controller;

> I think this prop is deprecated and system-power-controller
> should be used instead.

>> +				regulator-state-mem {
>> +					regulator-on-in-suspend;
>> +					regulator-suspend-microvolt = <900000>;

> Not sure we need this in suspend to ram and this can probably use:
>
>  regulator-off-in-suspend
>
> That is also what vendor kernel does.

Will be corrected in the next patch.

>> +			vcc3v3_sd: SWITCH_REG2 {
>> +				regulator-name = "vcc3v3_sd";
>> +				regulator-always-on;
>> +				regulator-boot-on;
>
> If I am reading the schematic correctly this is not connected.

Yes, I didn't notice it was NC, thanks.

>> +&sdhci {
>> +	bus-width = <8>;
>> +	max-frequency = <200000000>;
> This board support HS200, please add:
>
>  mmc-hs200-1_8v

Will be added in the next patch.

>> +&sdmmc0 {
>> +	bus-width = <4>;
>> +	cap-sd-highspeed;
>> +	cd-gpios = <&gpio0 RK_PA4 GPIO_ACTIVE_LOW>;
>
> Please drop the cd-gpios prop, sdmmc0_det is used below and
> works fine on this board.

Do other rk356x boards also need this change?

>> +	sd-uhs-sdr50;
>
> Why limit to sdr50? and not use sd-uhs-sdr104?

The sdr104 mode is not stable on the rk356x platform.
This problem has been reported on both rock3a and e25 boards.

>> +	vmmc-supply = <&vcc3v3_sd>;
>
> If I read the scematics correctly this is using the
> vcc3v3_sys regulator and not the vcc3v3_sd.

Yes, you are right. I didn't notice it, thanks.

>> +&sfc {
>
> This is missing pinctrl:
>
>  pinctrl-names = "default";
>  pinctrl-0 = <&fspi_pins>;

This is already defined on rk356x.dtsi:

	sfc: spi@fe300000 {
		compatible = "rockchip,sfc";
		......
		pinctrl-0 = <&fspi_pins>;
		pinctrl-names = "default";
		status = "disabled";
	};

>> +		spi-max-frequency = <104000000>;
>
> My board is using a GD25LQ128EWIGR same as mentioned in the schematic,
> and datasheet for this flash chip menion 120 mhz and not 104 mhz.

Will be corrected in the next patch, thanks.

Thanks,
Chukun

