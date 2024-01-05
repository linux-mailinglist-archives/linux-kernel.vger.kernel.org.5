Return-Path: <linux-kernel+bounces-18082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 738B9825892
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 17:47:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E4D4B22B43
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 16:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9A302E85B;
	Fri,  5 Jan 2024 16:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mecka.net header.i=@mecka.net header.b="l2Xg7rXV"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mecka.net (mecka.net [159.69.159.214])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3133B24B2A;
	Fri,  5 Jan 2024 16:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mecka.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mecka.net
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mecka.net; s=2016.11;
	t=1704473206; bh=dHnrrrn6vo3WQZOIjrjrAbt6U0ZZNfLqqP84NXJM+E0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l2Xg7rXV0Z61wO3d803JrtBJ3v49QkhSEPGZxFHws7PbldB7B/h3vsctcA1fImG54
	 9dR9aNu1baqmk/xRTAqluLBLsu0k5FrRL8svHlvvEKOV4KIv7t3AlvnfSpxl+lB7pg
	 R1exJRstdITouVpfids2D5FVbdEmro4YL4+Z/IHSA+1/K59zTj6BIlFHK/nspq+nUP
	 MuYpzyCJEtiQrgaszQOssz88oikViG0TVsPVyajqOQnAZOwS59dMIbZy8WoVQe93kz
	 PPmXv+x1e0/32zBNGDrPFMGHsMaXc+/9Yfl9d619SlzrIZPPL8OJt53VXtjGACbmSI
	 z7khgi0JbGTPg==
Received: from mecka.net (unknown [185.147.11.134])
	by mecka.net (Postfix) with ESMTPSA id 16F2037C392;
	Fri,  5 Jan 2024 17:46:46 +0100 (CET)
Date: Fri, 5 Jan 2024 17:46:40 +0100
From: Manuel Traut <manut@mecka.net>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>,
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
Message-ID: <ZZgycP5YKBam2p6W@mecka.net>
References: <20240102-pinetab2-v3-0-cb1aa69f8c30@mecka.net>
 <20240102-pinetab2-v3-4-cb1aa69f8c30@mecka.net>
 <775vjfucu2g2s6zzeutj7f7tapx3q2geccpxvv4ppcms4hxbq7@cbrdmlu2ryzp>
 <903e9d0c-a00c-4214-9f0e-dd676b13b428@kwiboo.se>
 <ZZVjzwgANJMdHnuo@mecka.net>
 <6efe305c-4ab4-43c1-ab6d-64bdf1d81a2f@kwiboo.se>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6efe305c-4ab4-43c1-ab6d-64bdf1d81a2f@kwiboo.se>

Hi Jonas,

On Wed, Jan 03, 2024 at 03:19:25PM +0100, Jonas Karlman wrote:
> Hi Manuel,
> 
> On 2024-01-03 14:40, Manuel Traut wrote:
> > Hi Jonas and Ondřej,
> > 
> >>>> +&sfc {
> >>>> +	pinctrl-names = "default";
> >>>> +	pinctrl-0 = <&fspi_dual_io_pins>;
> >>>> +	status = "okay";
> >>>> +	#address-cells = <1>;
> >>>> +	#size-cells = <0>;
> >>>> +
> >>>> +	flash@0 {
> >>>> +		compatible = "jedec,spi-nor";
> >>>> +		reg = <0>;
> >>>> +		spi-max-frequency = <24000000>;
> >>>
> >>> That's a bit on the low side. The flash chip should work for all commands up to
> >>> 80MHz https://megous.com/dl/tmp/b428ad9b85ac4633.png and SGM3157YC6 switch
> >>> for the FSPI-CLK should have high enough bandwidth, too.
> >>
> >> I agree that this is a little bit on the low side, it was a safe rate
> >> that I used for U-Boot. U-Boot required an exact rate of the supported
> >> sfc clk rates: 24, 50, 75, 100, 125 or 150 MHz.
> >>
> >> Please also note that the SPI NOR flash chip used in PineTab2 is not a
> >> GigaDevice GD25LQ128E, it should be a SiliconKaiser SK25LP128, same as
> >> found in the Pine64 PinePhone Pro.
> > 
> > The schematics for v2.0 reference a GD25LQ128EWIGR. I never checked the jedec
> > id. How did you retrieve this information, or is it maybe a difference in v0.1
> > and 2.0?
> 
> This was when working on mainline U-Boot for the PineTab2 (and other
> rk356x devices). See [1] for a pending U-Boot patch that is waiting on a
> proper mainline linux devicetree for the PT2.
> 
> The JEDEC ID is reported as 0x257018 on my v2.0 production unit, and
> does not match the JEDEC ID for GD25LQ128E (0xc86018) referenced in
> the schematics.
> 
> I found that the JEDEC ID 0x257018 was referenced in prior patches
> related to the SK25LP128 SPI NOR flash chip used in Pine64 PinePhone Pro.
> 
> I have only ever tested the 24 MHz rate, but I am expecting that e.g.
> 100 MHz also should work. Will not be able to test on my PT2 until at
> earliest next week.
> 
> [1] https://github.com/Kwiboo/u-boot-rockchip/commit/66562d6eaf2c11a9f97fcdba379d3ceda8aa70ef

Thanks for the information.

My v2.0 device also reports JEDEC ID 0x257018. I increased the clock-rate
to 100 MHz and it is at least still detected.

I will find out how to test more, currently hexdump /dev/mtd0 just reports
0xff on the hole flash, I expected to see u-boot there..

Regards
Manuel

> >>>> +		spi-rx-bus-width = <2>;
> >>>
> >>> GD25LQ128E supports quad I/O. Maybe try 4 if it will work.
> >>
> >> The schematic only shows fspi D0 and D1 connected, and use the D2 line
> >> for eMMC_RSTn, so spi-rx-bus-width = <2> should be correct.
> > 
> > ack
> > 
> > Since it is only needed for bootloader updates and environment its maybe better
> > to stay on the safe side?
> > 
> > But I can test faster frequency if you want me to do..
> > 
> > Regards
> > Manuel
> 

