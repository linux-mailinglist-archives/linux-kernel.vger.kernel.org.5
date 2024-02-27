Return-Path: <linux-kernel+bounces-83053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F131B868DD6
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 11:40:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A84F7283617
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 10:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49FCF13A27E;
	Tue, 27 Feb 2024 10:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="S3FYNcLf"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD4213A24D;
	Tue, 27 Feb 2024 10:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709030322; cv=none; b=BIn834Qj58D6C/aBJeqH6hF/eZ4XUrTMSeP6r0Ki9PudKdNRu3MS1dI5iDCkrhJn9BSc+/L5g+MLBpgz4P/Zr+bnYaKQwMIBDcdqoMVzUSP7KGOSDMuKnaKfqEWp4qpAt+QDRIP6Rd/LB9iWyqsQVU8mq47252JlZ75M0sdOfOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709030322; c=relaxed/simple;
	bh=jQ6aIa/bdEyqLnpCv5v+FggzUAIluKX2p4TGCXGciYQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nQZ3LadQM7Royb3pzSn/VtnPXcog5hCin17DcDwZKFRTSCGj5+08y6hYPi2BPU3WeSH/qDb356qIxenoty1T2W+AVcItfYaKB1YN0e+xoecMWxjMp5yCw/wamQssRnXHHNx94Ij9jTtYmoICYDQKVobaPBtv2Q0xVCjUq1wGxpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=S3FYNcLf; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709030318;
	bh=jQ6aIa/bdEyqLnpCv5v+FggzUAIluKX2p4TGCXGciYQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=S3FYNcLfXj9ZlUtMRMHlJ+inxWUUd0h/IRSlDZ/RtapaCJFW6CRnUuFrlfOfdGliY
	 fFQ5KzhOg9dM1eOeW1S+zPTl1TlYywEz+Qpsugt9xZfLpViZ/ie4i0uGNNCpUXuEmN
	 JlzzraK3y5weH7XIGFzja8C2ldhvvKlvMiM8nbkfG/MiPFNhbkcgt1LUpzXEm/49tg
	 0AWMFXSftrLgNgcGsUtDPVK+EFDOiYANM6VS2mlqX/E5Kx6rofiNNSoKwPU/ZdnSBc
	 GopeNGbRfGPv4aDZzYHUPzUsCbkJpTg3GTnz53D2xTs4CegAjTkxHgrnsxVoGENTbD
	 kXrehVflEmiXg==
Received: from [100.77.12.232] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: obbardc)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id D38F6378207B;
	Tue, 27 Feb 2024 10:38:37 +0000 (UTC)
Message-ID: <eafd8d8c0cbcaca1b190f84ec17a1dcd7aec0306.camel@collabora.com>
Subject: Re: [PATCH] arm64: dts: rockchip: add enable-strobe-pulldown to
 emmc phy on rk3399
From: Christopher Obbard <chris.obbard@collabora.com>
To: Folker Schwesinger <dev@folker-schwesinger.de>, Alban Browaeys
 <alban.browaeys@gmail.com>, Doug Anderson <dianders@chromium.org>, Jensen
 Huang <jensenhuang@friendlyarm.com>
Cc: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>, Rob Herring
 <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>,  Vinod Koul <vkoul@kernel.org>, Chris
 Ruehl <chris.ruehl@gtsys.com.hk>, Brian Norris <briannorris@chromium.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Linux ARM
 <linux-arm-kernel@lists.infradead.org>, "open list:ARM/Rockchip SoC..."
 <linux-rockchip@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>
Date: Tue, 27 Feb 2024 10:38:22 +0000
In-Reply-To: <CZFS45VOLIKW.2VS3M3VOMBT8V@folker-schwesinger.de>
References: <20220822074139.3810-1-jensenhuang@friendlyarm.com>
	 <23552842.6Emhk5qWAg@diego>
	 <CAD=FV=W-ajJDfYcP3P8Jyk_KgsUAbdTtmwiNXqJ=Ab2ojgrUGw@mail.gmail.com>
	 <CAMpZ1qEe7xFr+XaXsS_hWDLnGGA8PfzQiToOjY1N_1ctyQ+KxA@mail.gmail.com>
	 <CAD=FV=U-=2GpQTb0N1p3Qe2TAb=JhyZJw2V8T-qbLs5TYhW7qA@mail.gmail.com>
	 <7873090c4aad382813a65e35157d8684e8842974.camel@gmail.com>
	 <CZFS45VOLIKW.2VS3M3VOMBT8V@folker-schwesinger.de>
Autocrypt: addr=chris.obbard@collabora.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3-1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

On Tue, 2024-02-27 at 10:11 +0000, Folker Schwesinger wrote:
> Hi,
>=20
> On Tue Feb 27, 2024 at 3:05 AM CET, Alban Browaeys wrote:
> > Le mercredi 24 ao=C3=BBt 2022 =C3=A0 07:57 -0700, Doug Anderson a =C3=
=A9crit=C2=A0:
> > > On Tue, Aug 23, 2022 at 8:11 PM Jensen Huang
> > > <jensenhuang@friendlyarm.com> wrote:
> > > > I realized that only some devices may be affected, so I considered
> > > > modifying rk3399-nanopi4.dtsi only,
> > > > but other boards without external pull-down should still need this
> > > > patch.
> > >=20
> > > I guess the other alternative would be to change how the dt property
> > > works. You could say:
> > >=20
> > > 1. If `enable-strobe-pulldown` is set then enable the strobe
> > > pulldown.
> > >=20
> > > 2. If `enable-strobe-pulldown` is not set then don't touch the pin in
> > > the kernel.
> > >=20
> > > 3. If someone later needs to explicitly disable the strobe pulldown
> > > they could add a new property like `disable-strobe-pulldown`.
> > >=20
> > >=20
> > > Obviously there are tradeoffs between that and what you've done and
> > > I'm happy to let others make the call of which they'd prefer.
> > >=20
> >=20
> > Christopher could you try "ROCK Pi 4" and "ROCK Pi 4+" with=20
> > "enable-strobe-pulldown" instead of disabling HS400 as you did in July
> > 2023?
> >=20
>=20
> with the following applied, the EMMC related errors are gone. dmesg only
> shows "Purging ... bytes" during my tests:
>=20
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi
> b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi
> index f2279aa6ca9e..ae0fb87e1a8b 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi
> @@ -647,8 +647,10 @@ &saradc {
> =C2=A0&sdhci {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 max-frequency =3D <150000000>;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bus-width =3D <8>;
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mmc-hs200-1_8v;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mmc-hs400-1_8v;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mmc-hs400-enhanced-strobe;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 non-removable;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rockchip,enable-strobe-pulldown;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 status =3D "okay";
> =C2=A0};
>=20
> For testing I ran dd three times in a row:
>=20
> dd if=3D/dev/zero of=3D./zero.bin bs=3D1M count=3D5000
>=20
> I tested this on both a Rock 4SE board and a Rock Pi 4B+ board with the
> same results.

Just for the record, all Rock 4 board schematics have no external strobe
pulldown resistor on the board, so we should be good to enable this.

I wonder what other boards this could be enabled for ?


It seemed to be the case on some eMMC it would work, others it wouldn't.

I haven't yet tested the above diff here as yet, but I can do that this wee=
k
on multiple boards & eMMC combos.

The diff above is also missing a fixes tag (and also be fixed for rk3399-ro=
ck-
4c-plus.dts).


>=20
> >=20
> > Could the behavior be reverted to let the vendor kernel default for the
> > default case (ie enable pulldown)?
> >=20
> >=20
> >=20
> >=20
> > I believe 99% of the boards are now broken with this new internal
> > pulldown behavior (all=C2=A0 these with internal pulldown). More on tha=
t
> > later but to sum up, nobody=C2=A0 complained because downstream kernels=
 like
> > Armbian all disabled HS400 for all boards, at least for rk3399.
> >=20
> >=20
> > Do we really want to ask 99% of the board dts to add this "enable-
> > strobe-pulldown" in their dts?
> > Chris, was your custom board not working with the vender kernel default
> > to enable unconditionaly?
> > What was the rationale to=C2=A0 choose the opposite default from the ve=
ndor
> > kernel one?
> >=20
> >=20
> > As told in the commit that introduced this new behavior the default for
> > the vendor kernel was the opposite of what was introduced in the Linux
> > kernel:
> > "
> > https://github.com/torvalds/linux/commit/8b5c2b45b8f0a11c9072da0f7baf9e=
e986d3151e
> >=20
> > commit 8b5c2b45b8f0a11c9072da0f7baf9ee986d3151e
> > Author: Chris Ruehl <chris.ruehl@gtsys.com.hk>
> > Date:=C2=A0=C2=A0 Sun Nov 29 13:44:14 2020 +0800
> >=20
> > phy: rockchip: set pulldown for strobe line in dts
> >=20
> > This patch add support to set the internal pulldown via dt property
> > and allow simplify the board design for the trace from emmc-phy to
> > the eMMC chipset.
> > Default to not set the pull-down.
> >=20
> > This patch was inspired from the 4.4 tree of the
> > Rockchip SDK, where it is enabled unconditional.
> > The patch had been tested with our rk3399 customized board.
> > "
> >=20
> >=20
> >=20
> > For RK3588 I see this commit which makes me believe the internal
> > pulldown case is the most common "
> > commit 37f3d6108730713c411827ab4af764909f4dfc78
> > Author: Sam Edwards <cfsworks@gmail.com>
> > Date:=C2=A0=C2=A0 Tue Dec 5 12:29:00 2023 -0800
> >=20
> >=20
> > arm64: dts: rockchip: Fix eMMC Data Strobe PD on rk3588
> >=20
> > JEDEC standard JESD84-B51 defines the eMMC Data Strobe line, which is
> > currently used only in HS400 mode, as a device->host clock signal that
> > "is used only in read operation. The Data Strobe is always High-Z (not
> > driven by the device and pulled down by RDS) or Driven Low in write
> > operation, except during CRC status response." RDS is a pull-down
> > resistor specified in the 10K-100K ohm range. Thus per the standard,
> > the
> > Data Strobe is always pulled to ground (by the eMMC and/or RDS) during
> > write operations.
> >=20
> > Evidently, the eMMC host controller in the RK3588 considers an active
> > voltage on the eMMC-DS line during a write to be an error.
> >=20
> > The default (i.e. hardware reset, and Rockchip BSP) behavior for the
> > RK3588 is to activate the eMMC-DS pin's builtin pull-down. As a result,
> > many RK3588 board designers do not bother adding a dedicated RDS
> > resistor, instead relying on the RK3588's internal bias. The current
> > devicetree, however, disables this bias (`pcfg_pull_none`), breaking
> > HS400-mode writes for boards without a dedicated RDS, but with an eMMC
> > chip that chooses to High-Z (instead of drive-low) the eMMC-DS line.
> > (The Turing RK1 is one such board.)
> >=20
> > Fix this by changing the bias in the (common) emmc_data_strobe case to
> > reflect the expected hardware/BSP behavior. This is unlikely to cause
> > regressions elsewhere: the pull-down is only relevant for High-Z eMMCs,
> > and if this is redundant with a (dedicated) RDS resistor, the effective
> > result is only a lower resistance to ground -- where the range of
> > tolerance is quite high. If it does, it's better fixed in the specific
> > devicetrees.
> > "
> >=20
> >=20
> >=20
> >=20
> >=20
> >=20
> > Lately two other upstream dts disabled HS400 due to this new behavior I
> > believe:
> > "
> > https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit=
/arch/arm64/boot/dts/rockchip?id=3D2bd1d2dd808c60532283e9cf05110bf1bf2f9079
> > author	Christopher Obbard <chris.obbard@collabora.com>	2023-
> > 07-05 15:42:55 +0100
> > committer	Heiko Stuebner <heiko@sntech.de>	2023-07-10
> > 15:43:24 +0200
> > commit	2bd1d2dd808c60532283e9cf05110bf1bf2f9079 (patch)
> > tree	57cbf7eaa91deb68f143577d5d1dbc0d9141480e
> > /arch/arm64/boot/dts/rockchip
> > parent	cee572756aa2cb46e959e9797ad4b730b78a050b (diff)
> > download	linux-2bd1d2dd808c60532283e9cf05110bf1bf2f9079.tar.gz
> > arm64: dts: rockchip: Disable HS400 for eMMC on ROCK 4C+
> >=20
> >=20
> > https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit=
/arch/arm64/boot/dts/rockchip?id=3Dcee572756aa2cb46e959e9797ad4b730b78a050b
> > author	Christopher Obbard <chris.obbard@collabora.com>	2023-
> > 07-05 15:42:54 +0100
> > committer	Heiko Stuebner <heiko@sntech.de>	2023-07-10
> > 15:43:24 +0200
> > commit	cee572756aa2cb46e959e9797ad4b730b78a050b (patch)
> > tree	cf3ed8ff6230cbde04353503417c1a75ba15c249
> > /arch/arm64/boot/dts/rockchip
> > parent	5ce6971e5279c569defc2f2ac800692049bbaa90 (diff)
> > download	linux-cee572756aa2cb46e959e9797ad4b730b78a050b.tar.gz
> > arm64: dts: rockchip: Disable HS400 for eMMC on ROCK Pi 4
> > "
> >=20
> >=20
> > All Armbian RK3399 boards, as far as I know, had to disable HS400, I
> > also believe due to this commit.
> >=20
> > You can also search google for "running cqe recovery rk3399 armbian".
> >=20
> >=20
> > This was never reported upstream though. But as HS400 is disabled
> > everywhere nobody notice the regression nowadays.
> >=20
> >=20
> > >=20
> > > > BR,
> > > > Jensen
> > > >=20
> > > > On Tue, Aug 23, 2022 at 10:13 PM Doug Anderson
> > > > <dianders@chromium.org> wrote:
> > > > >=20
> > > > > Hi,
> > > > >=20
> > > > > On Tue, Aug 23, 2022 at 4:53 AM Heiko St=C3=BCbner <heiko@sntech.=
de>
> > > > > wrote:
> > > > > >=20
> > > > > > Am Montag, 22. August 2022, 09:41:39 CEST schrieb Jensen Huang:
> > > > > > > Internal pull-down for strobe line (GRF_EMMCPHY_CON2[9]) was
> > > > > > > disabled
> > > > > > > by commit 8b5c2b45b8f0, which causes I/O error in HS400 mode.
> > > > > > >=20
> > > > > > > Tested on NanoPC-T4.
> > > > > > >=20
> > > > > > > Fixes: 8b5c2b45b8f0 ("phy: rockchip: set pulldown for strobe
> > > > > > > line in dts")
> > > > > > > Signed-off-by: Jensen Huang <jensenhuang@friendlyarm.com>
> > > > > >=20
> > > > > > ok, so this looks like it restores previous functionality.
> > > > > >=20
> > > > > > I'm just wondering as the "offending" patch is from 2020, why
> > > > > > this
> > > > > > only turns up now. Any ideas?
> > > > >=20
> >=20
> > Probbaly because the introduction of PROBE_DEFERRED in regulator core
> > before that (in 5.10.60) already broke at least my board HS400 due to
> > double init. Thus why it took me so long to see this new pulldown
> > behavior commit. I was testing every regulator core double init fixup
> > patchset while not understanding why reverting the PROBE_DEFERRED
> > commit on 5.10.60 worked but not on newer kernels (ie this new pulldown
> > behavior was introduced in 5.11...).
> >=20
> >=20
> >=20
> >=20
> > > > > Ah, I see. So before the offending patch we used to just leave
> > > > > the
> > > > > pull state at whatever the default was when the kernel was
> > > > > booted.
> > > > > After the offending patch we chose a default.
> > > > >=20
> > > > > On kevin I see an external pull down on this line. Enabling both
> > > > > the
> > > > > internal and external is probably not a huge deal, it'll just
> > > > > affect
> > > > > the strength of the pull.
> > > > >=20
> > > > > On bob I _think_ the external pull down is also stuffed.
> > > > >=20
> > > > > ...so I guess that would explain why it didn't cause a problem
> > > > > for at
> > > > > least those two boards?
> > > > >=20
> > > > > -Doug
> >=20
> >=20
> > In my opinion it is about these board already being broken by the
> > regulator core change, so nobody noticed the second regression. When
> > the first regression was fixed, it was very hard to correlate the still
> > broken behavior to the second regression.
> >=20
> >=20
> > I confirm that on Helios64, setting "enable-strobe-pulldown" fixes the
> > EMMC error I had when writing with HS400ES enabled:
> > mmc1: running CQE recovery=20
> > mmc1: cqhci: spurious TCN for tag 12
> >=20
> > It also took me so long to report upstream as my board code (rk3399-
> > kobol-helios64.dts) is not completely upstreamed yet so I use an
> > Armbian patched kernel.
> >=20
> >=20
> >=20
> > Alban
> >=20
> >=20
> >=20
> > _______________________________________________
> > Linux-rockchip mailing list
> > Linux-rockchip@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-rockchip
>=20

