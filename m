Return-Path: <linux-kernel+bounces-83561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 75362869B85
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 17:04:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C0E2B302EF
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 16:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BCAE146E82;
	Tue, 27 Feb 2024 16:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="ubQN3Jar"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A609145B0C;
	Tue, 27 Feb 2024 16:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709049640; cv=none; b=JbWSHp+jpE+OAxnwC7OZawqJNv5m8H8JXuQAuGMR5o892/vwWxxLY9nK/k16duyNJeci5GLRtSuEMsA3xkRbTfTfSvpPUIk9IJz9EuRihVMtQ89PNUYFIUfHegzz/zkoGML3cGiQqi7wvNL7GafJm5jgQbwdALf50Rn66dLlU0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709049640; c=relaxed/simple;
	bh=eiMVjMY2eJZ0WHua7P/FmW7E68ijkTKDc8/jZWDrrtQ=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=b9OBsVOqBHAjLy/Pk4OToYs0EKZDFPP62GVqyZ+gaBSFQYDlY6G42jFxmFLcrdqbfWQUifCRX7GtpouCIWfeJgnL7hJqb50I2UA73AATpEy+JUXbu92cfc6uQHX6xs9xlpmRcpgf8ZC+egx+WtxSIgwjKnE1d55ADS5LyMxLD4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=ubQN3Jar; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1709049634;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S0ScTYlEOMm7KmQCkQkjYPl7d36pL1WA+3JbO05QOqI=;
	b=ubQN3Jar96vFnIYInc7ImePz/0CkVCFsr74WzTjjQdPtwsi60iNnB6cRKzrHdG1qgUwYp7
	+HHx/D9waAvr2uAC/VMpdmpH3hEWLK5qN8ycT6DLK11gHLgxDnTad92LiZ6CdNZE5q+sjS
	Now4X4w1N+hgQmQ1GEZ/85EHSfPI3kXOS6OAGpeg5AgUf5RQp1zPDH8ikupOF3HM1b1TOa
	m6QfN2IpgGTWpwLotmL/uhQgQLjGex3j6LnA2XzNbqfS+BZ68s8dGYG7ZcF1iyle+QpvDp
	5OMHpDbdXhv/o+20dnda6iO1DfNY4J2Do0+4v41OaHbBh/yghGugRNUeFYMBwg==
Date: Tue, 27 Feb 2024 17:00:31 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Christopher Obbard <chris.obbard@collabora.com>
Cc: Folker Schwesinger <dev@folker-schwesinger.de>, Alban Browaeys
 <alban.browaeys@gmail.com>, Doug Anderson <dianders@chromium.org>, Jensen
 Huang <jensenhuang@friendlyarm.com>, =?UTF-8?Q?Heiko_St=C3=BCbner?=
 <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Vinod Koul <vkoul@kernel.org>, Chris
 Ruehl <chris.ruehl@gtsys.com.hk>, Brian Norris <briannorris@chromium.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Linux ARM
 <linux-arm-kernel@lists.infradead.org>, "open list:ARM/Rockchip SoC..."
 <linux-rockchip@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>
Subject: Re: [PATCH] arm64: dts: rockchip: add enable-strobe-pulldown to emmc
 phy on rk3399
In-Reply-To: <eafd8d8c0cbcaca1b190f84ec17a1dcd7aec0306.camel@collabora.com>
References: <20220822074139.3810-1-jensenhuang@friendlyarm.com>
 <23552842.6Emhk5qWAg@diego>
 <CAD=FV=W-ajJDfYcP3P8Jyk_KgsUAbdTtmwiNXqJ=Ab2ojgrUGw@mail.gmail.com>
 <CAMpZ1qEe7xFr+XaXsS_hWDLnGGA8PfzQiToOjY1N_1ctyQ+KxA@mail.gmail.com>
 <CAD=FV=U-=2GpQTb0N1p3Qe2TAb=JhyZJw2V8T-qbLs5TYhW7qA@mail.gmail.com>
 <7873090c4aad382813a65e35157d8684e8842974.camel@gmail.com>
 <CZFS45VOLIKW.2VS3M3VOMBT8V@folker-schwesinger.de>
 <eafd8d8c0cbcaca1b190f84ec17a1dcd7aec0306.camel@collabora.com>
Message-ID: <ca5b7cad01f645c7c559ab26a8db8085@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello,

On 2024-02-27 11:38, Christopher Obbard wrote:
> On Tue, 2024-02-27 at 10:11 +0000, Folker Schwesinger wrote:
>> On Tue Feb 27, 2024 at 3:05 AM CET, Alban Browaeys wrote:
>> > Le mercredi 24 août 2022 à 07:57 -0700, Doug Anderson a écrit :
>> > > On Tue, Aug 23, 2022 at 8:11 PM Jensen Huang
>> > > <jensenhuang@friendlyarm.com> wrote:
>> > > > I realized that only some devices may be affected, so I considered
>> > > > modifying rk3399-nanopi4.dtsi only,
>> > > > but other boards without external pull-down should still need this
>> > > > patch.
>> > >
>> > > I guess the other alternative would be to change how the dt property
>> > > works. You could say:
>> > >
>> > > 1. If `enable-strobe-pulldown` is set then enable the strobe
>> > > pulldown.
>> > >
>> > > 2. If `enable-strobe-pulldown` is not set then don't touch the pin in
>> > > the kernel.
>> > >
>> > > 3. If someone later needs to explicitly disable the strobe pulldown
>> > > they could add a new property like `disable-strobe-pulldown`.
>> > >
>> > >
>> > > Obviously there are tradeoffs between that and what you've done and
>> > > I'm happy to let others make the call of which they'd prefer.
>> > >
>> >
>> > Christopher could you try "ROCK Pi 4" and "ROCK Pi 4+" with
>> > "enable-strobe-pulldown" instead of disabling HS400 as you did in July
>> > 2023?
>> >
>> 
>> with the following applied, the EMMC related errors are gone. dmesg 
>> only
>> shows "Purging ... bytes" during my tests:
>> 
>> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi
>> b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi
>> index f2279aa6ca9e..ae0fb87e1a8b 100644
>> --- a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi
>> +++ b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi
>> @@ -647,8 +647,10 @@ &saradc {
>>  &sdhci {
>>         max-frequency = <150000000>;
>>         bus-width = <8>;
>> -       mmc-hs200-1_8v;
>> +       mmc-hs400-1_8v;
>> +       mmc-hs400-enhanced-strobe;
>>         non-removable;
>> +       rockchip,enable-strobe-pulldown;
>>         status = "okay";
>>  };
>> 
>> For testing I ran dd three times in a row:
>> 
>> dd if=/dev/zero of=./zero.bin bs=1M count=5000
>> 
>> I tested this on both a Rock 4SE board and a Rock Pi 4B+ board with 
>> the
>> same results.
> 
> Just for the record, all Rock 4 board schematics have no external 
> strobe
> pulldown resistor on the board, so we should be good to enable this.
> 
> I wonder what other boards this could be enabled for ?
> 
> It seemed to be the case on some eMMC it would work, others it 
> wouldn't.
> 
> I haven't yet tested the above diff here as yet, but I can do that this 
> week
> on multiple boards & eMMC combos.
> 
> The diff above is also missing a fixes tag (and also be fixed for 
> rk3399-rock-
> 4c-plus.dts).

When it comes to HS400 support on the RockPro64 and the Pinebook Pro,
they're unfortunately miswired in a hopeless way, causing the DATA
STROBE signal from the eMMC chip (i.e. the eMMC module) not to even
reach the right ball on the RK3399 SoC.

Here are a few screenshots from the schematics that illustrate this
issue (the first one is from the eMMC module schematic, the remaining
two are from the RockPro64 schematic, which are pretty much exactly
the same in the Pinebook Pro schematic):

- https://i.imgur.com/MqD7rcG.png
- https://i.imgur.com/hrlQBck.png
- https://i.imgur.com/mtYvc9s.png

There have been some Pine64 community attempts to have this fixed in
new RockPro64 and Pinebook Pro hardware revisions, but such attempts
unfortunately failed. :/

Thus, we'll unfortunately have to deal with the whole thing on the
board level, instead of making changes on the SoC level.

