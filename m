Return-Path: <linux-kernel+bounces-83348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C29D869423
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 14:51:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FA3E1C2513B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 13:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAF90143C48;
	Tue, 27 Feb 2024 13:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=folker-schwesinger.de header.i=@folker-schwesinger.de header.b="GpCOX4CV"
Received: from www522.your-server.de (www522.your-server.de [195.201.215.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880C51419B5;
	Tue, 27 Feb 2024 13:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.201.215.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709041812; cv=none; b=oJkDOLE2RPZS9r4D3Vp2dpB4Nc62LsIaRG9OMcBLX7VflVOZo7vC1osIvk0kb45mwzqSyXgpdDTSjsstNfh13PnC4h0DhHMi6z2XWsENfoA3cN/5LbkMnHhn3ZMa7B6ry3M85hpz2MjpeqLcCSYmSpGHI7MMSgFyUe0/F5oPpEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709041812; c=relaxed/simple;
	bh=q4u13XzA9qJ66uV6VD7ZUVjIF0Fb1JW0HbjOY6Qq9oc=;
	h=Content-Type:Mime-Version:Date:Message-Id:From:To:Subject:Cc:
	 References:In-Reply-To; b=MUObk6pa35rBz7Ap4ikOWCneHT9LcKRxnn0vU+UjCOrkT7hArFV/K82UafiFzgjEeyjFSSZRl3jUgYzYsu265EXwOqQEb3TflNuj+/dLIknbQ2fEYJp+fRbeghs+oQCCmC22P5T6VEwxMZ2bZIdknodBIGNY1Dc10+D4ntvrY98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=folker-schwesinger.de; spf=pass smtp.mailfrom=folker-schwesinger.de; dkim=pass (2048-bit key) header.d=folker-schwesinger.de header.i=@folker-schwesinger.de header.b=GpCOX4CV; arc=none smtp.client-ip=195.201.215.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=folker-schwesinger.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=folker-schwesinger.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=folker-schwesinger.de; s=default2212; h=In-Reply-To:References:Cc:Subject:
	To:From:Message-Id:Date:Mime-Version:Content-Type:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=ZoFnwyyqpkmN7wUmnVL2jSnmFU13TXHhzttEWLx+f0M=; b=GpCOX4CVHDOxu3YkAuOsGmybfJ
	421lBNcWs93BImwW0rXQecFJ9A773Ui4NZny+VLTjmXcXd+9yvBN7QZPe98ZqNgD6TGT7BQ8khqow
	Vt7P55+IJ++ptEnOU/NqqqsI7QojnlY6W9YQiNx/Wbaaux26K3d4TsVXH8lkO9b2aDHPDleHVPTUD
	h4rhW+/Acqmil4R1EJooHKNp8VV6OfrOtHmFmmF9RADBgtX+I/MW5NYaXCtXOPCKhE7OmxwPPZ5Uo
	hDiittfMfECihXnbDfoZfPPOk5a+NSO7gxy0PqhgKn11gca9oa174PQmd+L3d2feKgFaxf09foK0y
	pUdBw5Cg==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
	by www522.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <dev@folker-schwesinger.de>)
	id 1rexqN-000NE3-DM; Tue, 27 Feb 2024 14:50:03 +0100
Received: from [141.24.82.26] (helo=localhost)
	by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <dev@folker-schwesinger.de>)
	id 1rexqG-000ARa-Dr; Tue, 27 Feb 2024 14:50:02 +0100
Content-Type: multipart/signed;
 boundary=a28cd9b61c5d2d4fe176afa94e55817a89ff6f22a51f0e36bb0d0210ba45;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Tue, 27 Feb 2024 13:49:56 +0000
Message-Id: <CZFWR6D40B2F.V7QM56KOG2R6@folker-schwesinger.de>
From: "Folker Schwesinger" <dev@folker-schwesinger.de>
To: "Christopher Obbard" <chris.obbard@collabora.com>, "Alban Browaeys"
 <alban.browaeys@gmail.com>, "Doug Anderson" <dianders@chromium.org>,
 "Jensen Huang" <jensenhuang@friendlyarm.com>
Subject: Re: [PATCH] arm64: dts: rockchip: add enable-strobe-pulldown to
 emmc phy on rk3399
Cc: =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, "Rob Herring"
 <robh+dt@kernel.org>, "Krzysztof Kozlowski"
 <krzysztof.kozlowski+dt@linaro.org>, "Vinod Koul" <vkoul@kernel.org>,
 "Chris Ruehl" <chris.ruehl@gtsys.com.hk>, "Brian Norris"
 <briannorris@chromium.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE
 TREE BINDINGS" <devicetree@vger.kernel.org>, "Linux ARM"
 <linux-arm-kernel@lists.infradead.org>, "open list:ARM/Rockchip SoC..."
 <linux-rockchip@lists.infradead.org>, "LKML"
 <linux-kernel@vger.kernel.org>, "Kishon Vijay Abraham I"
 <kishon@kernel.org>
X-Mailer: aerc 0.17.0-67-g66bbc5303578
References: <20220822074139.3810-1-jensenhuang@friendlyarm.com>
 <23552842.6Emhk5qWAg@diego>
 <CAD=FV=W-ajJDfYcP3P8Jyk_KgsUAbdTtmwiNXqJ=Ab2ojgrUGw@mail.gmail.com>
 <CAMpZ1qEe7xFr+XaXsS_hWDLnGGA8PfzQiToOjY1N_1ctyQ+KxA@mail.gmail.com>
 <CAD=FV=U-=2GpQTb0N1p3Qe2TAb=JhyZJw2V8T-qbLs5TYhW7qA@mail.gmail.com>
 <7873090c4aad382813a65e35157d8684e8842974.camel@gmail.com>
 <CZFS45VOLIKW.2VS3M3VOMBT8V@folker-schwesinger.de>
 <eafd8d8c0cbcaca1b190f84ec17a1dcd7aec0306.camel@collabora.com>
In-Reply-To: <eafd8d8c0cbcaca1b190f84ec17a1dcd7aec0306.camel@collabora.com>
X-Authenticated-Sender: dev@folker-schwesinger.de
X-Virus-Scanned: Clear (ClamAV 0.103.10/27198/Tue Feb 27 10:33:00 2024)

--a28cd9b61c5d2d4fe176afa94e55817a89ff6f22a51f0e36bb0d0210ba45
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi,

On Tue Feb 27, 2024 at 11:38 AM CET, Christopher Obbard wrote:
> Hi,
>
> On Tue, 2024-02-27 at 10:11 +0000, Folker Schwesinger wrote:
> > Hi,
> >=20
> > On Tue Feb 27, 2024 at 3:05 AM CET, Alban Browaeys wrote:
> > > Le mercredi 24 ao=C3=BBt 2022 =C3=A0 07:57 -0700, Doug Anderson a =C3=
=A9crit=C2=A0:
> > > > On Tue, Aug 23, 2022 at 8:11 PM Jensen Huang
> > > > <jensenhuang@friendlyarm.com> wrote:
> > > > > I realized that only some devices may be affected, so I considere=
d
> > > > > modifying rk3399-nanopi4.dtsi only,
> > > > > but other boards without external pull-down should still need thi=
s
> > > > > patch.
> > > >=20
> > > > I guess the other alternative would be to change how the dt propert=
y
> > > > works. You could say:
> > > >=20
> > > > 1. If `enable-strobe-pulldown` is set then enable the strobe
> > > > pulldown.
> > > >=20
> > > > 2. If `enable-strobe-pulldown` is not set then don't touch the pin =
in
> > > > the kernel.
> > > >=20
> > > > 3. If someone later needs to explicitly disable the strobe pulldown
> > > > they could add a new property like `disable-strobe-pulldown`.
> > > >=20
> > > >=20
> > > > Obviously there are tradeoffs between that and what you've done and
> > > > I'm happy to let others make the call of which they'd prefer.
> > > >=20
> > >=20
> > > Christopher could you try "ROCK Pi 4" and "ROCK Pi 4+" with=20
> > > "enable-strobe-pulldown" instead of disabling HS400 as you did in Jul=
y
> > > 2023?
> > >=20
> >=20
> > with the following applied, the EMMC related errors are gone. dmesg onl=
y
> > shows "Purging ... bytes" during my tests:
> >=20
> > diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi
> > b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi
> > index f2279aa6ca9e..ae0fb87e1a8b 100644
> > --- a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi
> > +++ b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi
> > @@ -647,8 +647,10 @@ &saradc {
> > =C2=A0&sdhci {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 max-frequency =3D <150000000=
>;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bus-width =3D <8>;
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mmc-hs200-1_8v;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mmc-hs400-1_8v;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mmc-hs400-enhanced-strobe;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 non-removable;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rockchip,enable-strobe-pulldown;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 status =3D "okay";
> > =C2=A0};
> >=20
> > For testing I ran dd three times in a row:
> >=20
> > dd if=3D/dev/zero of=3D./zero.bin bs=3D1M count=3D5000
> >=20
> > I tested this on both a Rock 4SE board and a Rock Pi 4B+ board with the
> > same results.
>
> Just for the record, all Rock 4 board schematics have no external strobe
> pulldown resistor on the board, so we should be good to enable this.
>
> I wonder what other boards this could be enabled for ?
>
>
> It seemed to be the case on some eMMC it would work, others it wouldn't.

I remember the different reports from the Radxa forums. Personally, I
did test different eMMCs (3 Foresee, 1 Samsung) last year and all
those did not work.
https://lists.infradead.org/pipermail/linux-rockchip/2023-July/039567.html

The enable-strobe-pulldown test above was done using one of the Foresee
modules and with the on-board eMMC of the 4B+.
Unfortunately, I don't have all the eMMCs from last year any more.
However, I could test with another Foresee, in case this is regarded a
valuable data point.

> I haven't yet tested the above diff here as yet, but I can do that this w=
eek
> on multiple boards & eMMC combos.
>
> The diff above is also missing a fixes tag (and also be fixed for rk3399-=
rock-
> 4c-plus.dts).

I only included the diff to explicitly show what I did for testing. It
was not meant to be a patch for inclusion as the below question still
remains:
=20
> > > Could the behavior be reverted to let the vendor kernel default for t=
he
> > > default case (ie enable pulldown)?

If there's consensus on whether to enable the pulldown by default in the
driver or in all the respective DTS, I'd be happy to offer a proper patch.

> > >=20
> > > I believe 99% of the boards are now broken with this new internal
> > > pulldown behavior (all=C2=A0 these with internal pulldown). More on t=
hat
> > > later but to sum up, nobody=C2=A0 complained because downstream kerne=
ls like
> > > Armbian all disabled HS400 for all boards, at least for rk3399.
> > >=20
> > >=20
> > > Do we really want to ask 99% of the board dts to add this "enable-
> > > strobe-pulldown" in their dts?
> > > Chris, was your custom board not working with the vender kernel defau=
lt
> > > to enable unconditionaly?
> > > What was the rationale to=C2=A0 choose the opposite default from the =
vendor
> > > kernel one?
> > >=20
> > >=20
> > > As told in the commit that introduced this new behavior the default f=
or
> > > the vendor kernel was the opposite of what was introduced in the Linu=
x
> > > kernel:
> > > "
> > > https://github.com/torvalds/linux/commit/8b5c2b45b8f0a11c9072da0f7baf=
9ee986d3151e
> > >=20
> > > commit 8b5c2b45b8f0a11c9072da0f7baf9ee986d3151e
> > > Author: Chris Ruehl <chris.ruehl@gtsys.com.hk>
> > > Date:=C2=A0=C2=A0 Sun Nov 29 13:44:14 2020 +0800
> > >=20
> > > phy: rockchip: set pulldown for strobe line in dts
> > >=20
> > > This patch add support to set the internal pulldown via dt property
> > > and allow simplify the board design for the trace from emmc-phy to
> > > the eMMC chipset.
> > > Default to not set the pull-down.
> > >=20
> > > This patch was inspired from the 4.4 tree of the
> > > Rockchip SDK, where it is enabled unconditional.
> > > The patch had been tested with our rk3399 customized board.
> > > "
> > >=20
> > >=20
> > >=20
> > > For RK3588 I see this commit which makes me believe the internal
> > > pulldown case is the most common "
> > > commit 37f3d6108730713c411827ab4af764909f4dfc78
> > > Author: Sam Edwards <cfsworks@gmail.com>
> > > Date:=C2=A0=C2=A0 Tue Dec 5 12:29:00 2023 -0800
> > >=20
> > >=20
> > > arm64: dts: rockchip: Fix eMMC Data Strobe PD on rk3588
> > >=20
> > > JEDEC standard JESD84-B51 defines the eMMC Data Strobe line, which is
> > > currently used only in HS400 mode, as a device->host clock signal tha=
t
> > > "is used only in read operation. The Data Strobe is always High-Z (no=
t
> > > driven by the device and pulled down by RDS) or Driven Low in write
> > > operation, except during CRC status response." RDS is a pull-down
> > > resistor specified in the 10K-100K ohm range. Thus per the standard,
> > > the
> > > Data Strobe is always pulled to ground (by the eMMC and/or RDS) durin=
g
> > > write operations.
> > >=20
> > > Evidently, the eMMC host controller in the RK3588 considers an active
> > > voltage on the eMMC-DS line during a write to be an error.
> > >=20
> > > The default (i.e. hardware reset, and Rockchip BSP) behavior for the
> > > RK3588 is to activate the eMMC-DS pin's builtin pull-down. As a resul=
t,
> > > many RK3588 board designers do not bother adding a dedicated RDS
> > > resistor, instead relying on the RK3588's internal bias. The current
> > > devicetree, however, disables this bias (`pcfg_pull_none`), breaking
> > > HS400-mode writes for boards without a dedicated RDS, but with an eMM=
C
> > > chip that chooses to High-Z (instead of drive-low) the eMMC-DS line.
> > > (The Turing RK1 is one such board.)
> > >=20
> > > Fix this by changing the bias in the (common) emmc_data_strobe case t=
o
> > > reflect the expected hardware/BSP behavior. This is unlikely to cause
> > > regressions elsewhere: the pull-down is only relevant for High-Z eMMC=
s,
> > > and if this is redundant with a (dedicated) RDS resistor, the effecti=
ve
> > > result is only a lower resistance to ground -- where the range of
> > > tolerance is quite high. If it does, it's better fixed in the specifi=
c
> > > devicetrees.
> > > "
> > >=20
> > >=20
> > >=20
> > >=20
> > >=20
> > >=20
> > > Lately two other upstream dts disabled HS400 due to this new behavior=
 I
> > > believe:
> > > "
> > > https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/comm=
it/arch/arm64/boot/dts/rockchip?id=3D2bd1d2dd808c60532283e9cf05110bf1bf2f90=
79
> > > author	Christopher Obbard <chris.obbard@collabora.com>	2023-
> > > 07-05 15:42:55 +0100
> > > committer	Heiko Stuebner <heiko@sntech.de>	2023-07-10
> > > 15:43:24 +0200
> > > commit	2bd1d2dd808c60532283e9cf05110bf1bf2f9079 (patch)
> > > tree	57cbf7eaa91deb68f143577d5d1dbc0d9141480e
> > > /arch/arm64/boot/dts/rockchip
> > > parent	cee572756aa2cb46e959e9797ad4b730b78a050b (diff)
> > > download	linux-2bd1d2dd808c60532283e9cf05110bf1bf2f9079.tar.gz
> > > arm64: dts: rockchip: Disable HS400 for eMMC on ROCK 4C+
> > >=20
> > >=20
> > > https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/comm=
it/arch/arm64/boot/dts/rockchip?id=3Dcee572756aa2cb46e959e9797ad4b730b78a05=
0b
> > > author	Christopher Obbard <chris.obbard@collabora.com>	2023-
> > > 07-05 15:42:54 +0100
> > > committer	Heiko Stuebner <heiko@sntech.de>	2023-07-10
> > > 15:43:24 +0200
> > > commit	cee572756aa2cb46e959e9797ad4b730b78a050b (patch)
> > > tree	cf3ed8ff6230cbde04353503417c1a75ba15c249
> > > /arch/arm64/boot/dts/rockchip
> > > parent	5ce6971e5279c569defc2f2ac800692049bbaa90 (diff)
> > > download	linux-cee572756aa2cb46e959e9797ad4b730b78a050b.tar.gz
> > > arm64: dts: rockchip: Disable HS400 for eMMC on ROCK Pi 4
> > > "
> > >=20
> > >=20
> > > All Armbian RK3399 boards, as far as I know, had to disable HS400, I
> > > also believe due to this commit.
> > >=20
> > > You can also search google for "running cqe recovery rk3399 armbian".
> > >=20
> > >=20
> > > This was never reported upstream though. But as HS400 is disabled
> > > everywhere nobody notice the regression nowadays.
> > >=20
> > >=20
> > > >=20
> > > > > BR,
> > > > > Jensen
> > > > >=20
> > > > > On Tue, Aug 23, 2022 at 10:13 PM Doug Anderson
> > > > > <dianders@chromium.org> wrote:
> > > > > >=20
> > > > > > Hi,
> > > > > >=20
> > > > > > On Tue, Aug 23, 2022 at 4:53 AM Heiko St=C3=BCbner <heiko@sntec=
h.de>
> > > > > > wrote:
> > > > > > >=20
> > > > > > > Am Montag, 22. August 2022, 09:41:39 CEST schrieb Jensen Huan=
g:
> > > > > > > > Internal pull-down for strobe line (GRF_EMMCPHY_CON2[9]) wa=
s
> > > > > > > > disabled
> > > > > > > > by commit 8b5c2b45b8f0, which causes I/O error in HS400 mod=
e.
> > > > > > > >=20
> > > > > > > > Tested on NanoPC-T4.
> > > > > > > >=20
> > > > > > > > Fixes: 8b5c2b45b8f0 ("phy: rockchip: set pulldown for strob=
e
> > > > > > > > line in dts")
> > > > > > > > Signed-off-by: Jensen Huang <jensenhuang@friendlyarm.com>
> > > > > > >=20
> > > > > > > ok, so this looks like it restores previous functionality.
> > > > > > >=20
> > > > > > > I'm just wondering as the "offending" patch is from 2020, why
> > > > > > > this
> > > > > > > only turns up now. Any ideas?
> > > > > >=20
> > >=20
> > > Probbaly because the introduction of PROBE_DEFERRED in regulator core
> > > before that (in 5.10.60) already broke at least my board HS400 due to
> > > double init. Thus why it took me so long to see this new pulldown
> > > behavior commit. I was testing every regulator core double init fixup
> > > patchset while not understanding why reverting the PROBE_DEFERRED
> > > commit on 5.10.60 worked but not on newer kernels (ie this new pulldo=
wn
> > > behavior was introduced in 5.11...).
> > >=20
> > >=20
> > >=20
> > >=20
> > > > > > Ah, I see. So before the offending patch we used to just leave
> > > > > > the
> > > > > > pull state at whatever the default was when the kernel was
> > > > > > booted.
> > > > > > After the offending patch we chose a default.
> > > > > >=20
> > > > > > On kevin I see an external pull down on this line. Enabling bot=
h
> > > > > > the
> > > > > > internal and external is probably not a huge deal, it'll just
> > > > > > affect
> > > > > > the strength of the pull.
> > > > > >=20
> > > > > > On bob I _think_ the external pull down is also stuffed.
> > > > > >=20
> > > > > > ...so I guess that would explain why it didn't cause a problem
> > > > > > for at
> > > > > > least those two boards?
> > > > > >=20
> > > > > > -Doug
> > >=20
> > >=20
> > > In my opinion it is about these board already being broken by the
> > > regulator core change, so nobody noticed the second regression. When
> > > the first regression was fixed, it was very hard to correlate the sti=
ll
> > > broken behavior to the second regression.
> > >=20
> > >=20
> > > I confirm that on Helios64, setting "enable-strobe-pulldown" fixes th=
e
> > > EMMC error I had when writing with HS400ES enabled:
> > > mmc1: running CQE recovery=20
> > > mmc1: cqhci: spurious TCN for tag 12
> > >=20
> > > It also took me so long to report upstream as my board code (rk3399-
> > > kobol-helios64.dts) is not completely upstreamed yet so I use an
> > > Armbian patched kernel.
> > >=20
> > >=20
> > >=20
> > > Alban
> > >=20
> > >=20
> > >=20
> > > _______________________________________________
> > > Linux-rockchip mailing list
> > > Linux-rockchip@lists.infradead.org
> > > http://lists.infradead.org/mailman/listinfo/linux-rockchip
> >=20
>
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip


--a28cd9b61c5d2d4fe176afa94e55817a89ff6f22a51f0e36bb0d0210ba45
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJAEABYKADgWIQQFbmi0A2l3pTuK+esCQHEyPYq7fQUCZd3ohBocZGV2QGZvbGtl
ci1zY2h3ZXNpbmdlci5kZQAKCRACQHEyPYq7fQz5AP9/BGNF0GahmiwOo8OWC1SI
6cti0mJ/Fp2RM2aJDm9m3AEA64Jy7P72DwSuv4Qagg9IeAHiRehuFqEq1Calmk89
WwY=
=fX3i
-----END PGP SIGNATURE-----

--a28cd9b61c5d2d4fe176afa94e55817a89ff6f22a51f0e36bb0d0210ba45--

