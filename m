Return-Path: <linux-kernel+bounces-83034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F865868D93
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 11:29:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB0D21F21711
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 10:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 071D21384B3;
	Tue, 27 Feb 2024 10:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=folker-schwesinger.de header.i=@folker-schwesinger.de header.b="HkhlJ2wu"
Received: from www522.your-server.de (www522.your-server.de [195.201.215.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5ADF1386B8;
	Tue, 27 Feb 2024 10:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.201.215.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709029738; cv=none; b=DDv9Ab7bCf41i6pmYbitNpt3Iorj9SgqkaXHJ2GV4y/9jBl4iMSj+NtlawQ0T8/twziUI0QelX2MdRkWIFE3De+tz8Gl2vqJqWfsZBdp/p1xg+RTfgr+EYt1jz5/XP6XFg89ulvbrKWq5btQsO2OjLj2vPT8kwPlaVOEU+3jXQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709029738; c=relaxed/simple;
	bh=o8YIeJU+n/G7IXYLjmkc4hcOPkZILpLoQGQUS0tBt1M=;
	h=Content-Type:Date:Message-Id:Subject:Cc:From:To:Mime-Version:
	 References:In-Reply-To; b=R3Za22wi2BcFaHyyq+5zntHv0OWNME6jRKh5CTYwgmLiStcVgk+vlJad7eMHCjh/4jb8OjHSPOTzoNCL3pNrob4FGf30RDYBDl0qXSiNgA1uY3pD03bjIZvqtdSqBX8k3aijG1rkNBJ5wDyKZt2Og1lgeUQ3liKO3jPqjeohsMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=folker-schwesinger.de; spf=pass smtp.mailfrom=folker-schwesinger.de; dkim=pass (2048-bit key) header.d=folker-schwesinger.de header.i=@folker-schwesinger.de header.b=HkhlJ2wu; arc=none smtp.client-ip=195.201.215.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=folker-schwesinger.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=folker-schwesinger.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=folker-schwesinger.de; s=default2212; h=In-Reply-To:References:
	Content-Transfer-Encoding:Mime-Version:To:From:Cc:Subject:Message-Id:Date:
	Content-Type:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=DV0hhtLlv0q18AeIA77X31I3Oe8+chKq2Az9f3uPrR0=; b=HkhlJ2wuYDyg2CmhZG0ynsdxcv
	Tcr467UnQkXegZVcKUIRvP3xlNfPEkXJqA7G+B5Nem70WrbOgI+opbkavcPe9/HFq7lJaO5CmYATj
	ijcc8i/cBK8tJ12CnyGw76pSrf7MTWqnHyW67GhBhSUUCjLJMv3G0f4OmJ5WsqwQy3S/XMN2yPbBe
	zZVMH8uDn3eugUI7Gaiw88vzrxhs/xwaipch6C4oBurPivAZYuCn1L9GBqe+/GMTYUclt2l3l8Bg7
	maqZ2PRku/CRmR30wJ5gZnz3jyYP3Lr5+E8IaPZ7iK8EYw2aJGwkNMLfxvv2ssrqmx2NjHTjDRVlI
	7LLrhbdg==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
	by www522.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <dev@folker-schwesinger.de>)
	id 1reuRH-0004q3-AJ; Tue, 27 Feb 2024 11:11:55 +0100
Received: from [141.24.82.26] (helo=localhost)
	by sslproxy02.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <dev@folker-schwesinger.de>)
	id 1reuRA-00EtiY-1v;
	Tue, 27 Feb 2024 11:11:54 +0100
Content-Type: multipart/signed;
 boundary=fb2c8dd55ef9719f9d11be5e04c0ac8d4ca5dd24af240fce5463600e99f0;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Tue, 27 Feb 2024 10:11:48 +0000
Message-Id: <CZFS45VOLIKW.2VS3M3VOMBT8V@folker-schwesinger.de>
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
 <kishon@kernel.org>, "Christopher Obbard" <chris.obbard@collabora.com>
From: "Folker Schwesinger" <dev@folker-schwesinger.de>
To: "Alban Browaeys" <alban.browaeys@gmail.com>, "Doug Anderson"
 <dianders@chromium.org>, "Jensen Huang" <jensenhuang@friendlyarm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: aerc 0.17.0-67-g66bbc5303578
References: <20220822074139.3810-1-jensenhuang@friendlyarm.com>
 <23552842.6Emhk5qWAg@diego>
 <CAD=FV=W-ajJDfYcP3P8Jyk_KgsUAbdTtmwiNXqJ=Ab2ojgrUGw@mail.gmail.com>
 <CAMpZ1qEe7xFr+XaXsS_hWDLnGGA8PfzQiToOjY1N_1ctyQ+KxA@mail.gmail.com>
 <CAD=FV=U-=2GpQTb0N1p3Qe2TAb=JhyZJw2V8T-qbLs5TYhW7qA@mail.gmail.com>
 <7873090c4aad382813a65e35157d8684e8842974.camel@gmail.com>
In-Reply-To: <7873090c4aad382813a65e35157d8684e8842974.camel@gmail.com>
X-Authenticated-Sender: dev@folker-schwesinger.de
X-Virus-Scanned: Clear (ClamAV 0.103.10/27197/Mon Feb 26 10:31:34 2024)

--fb2c8dd55ef9719f9d11be5e04c0ac8d4ca5dd24af240fce5463600e99f0
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi,

On Tue Feb 27, 2024 at 3:05 AM CET, Alban Browaeys wrote:
> Le mercredi 24 ao=C3=BBt 2022 =C3=A0 07:57 -0700, Doug Anderson a =C3=A9c=
rit=C2=A0:
> > On Tue, Aug 23, 2022 at 8:11 PM Jensen Huang
> > <jensenhuang@friendlyarm.com> wrote:
> > > I realized that only some devices may be affected, so I considered
> > > modifying rk3399-nanopi4.dtsi only,
> > > but other boards without external pull-down should still need this
> > > patch.
> >=20
> > I guess the other alternative would be to change how the dt property
> > works. You could say:
> >=20
> > 1. If `enable-strobe-pulldown` is set then enable the strobe
> > pulldown.
> >=20
> > 2. If `enable-strobe-pulldown` is not set then don't touch the pin in
> > the kernel.
> >=20
> > 3. If someone later needs to explicitly disable the strobe pulldown
> > they could add a new property like `disable-strobe-pulldown`.
> >=20
> >=20
> > Obviously there are tradeoffs between that and what you've done and
> > I'm happy to let others make the call of which they'd prefer.
> >=20
>
> Christopher could you try "ROCK Pi 4" and "ROCK Pi 4+" with=20
> "enable-strobe-pulldown" instead of disabling HS400 as you did in July
> 2023?
>

with the following applied, the EMMC related errors are gone. dmesg only
shows "Purging ... bytes" during my tests:

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi b/arch/arm6=
4/boot/dts/rockchip/rk3399-rock-pi-4.dtsi
index f2279aa6ca9e..ae0fb87e1a8b 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi
@@ -647,8 +647,10 @@ &saradc {
 &sdhci {
        max-frequency =3D <150000000>;
        bus-width =3D <8>;
-       mmc-hs200-1_8v;
+       mmc-hs400-1_8v;
+       mmc-hs400-enhanced-strobe;
        non-removable;
+       rockchip,enable-strobe-pulldown;
        status =3D "okay";
 };

For testing I ran dd three times in a row:

dd if=3D/dev/zero of=3D./zero.bin bs=3D1M count=3D5000

I tested this on both a Rock 4SE board and a Rock Pi 4B+ board with the
same results.

>
> Could the behavior be reverted to let the vendor kernel default for the
> default case (ie enable pulldown)?
>
>
>
>
> I believe 99% of the boards are now broken with this new internal
> pulldown behavior (all  these with internal pulldown). More on that
> later but to sum up, nobody  complained because downstream kernels like
> Armbian all disabled HS400 for all boards, at least for rk3399.
>
>
> Do we really want to ask 99% of the board dts to add this "enable-
> strobe-pulldown" in their dts?
> Chris, was your custom board not working with the vender kernel default
> to enable unconditionaly?
> What was the rationale to  choose the opposite default from the vendor
> kernel one?
>
>
> As told in the commit that introduced this new behavior the default for
> the vendor kernel was the opposite of what was introduced in the Linux
> kernel:
> "
> https://github.com/torvalds/linux/commit/8b5c2b45b8f0a11c9072da0f7baf9ee9=
86d3151e
>
> commit 8b5c2b45b8f0a11c9072da0f7baf9ee986d3151e
> Author: Chris Ruehl <chris.ruehl@gtsys.com.hk>
> Date:   Sun Nov 29 13:44:14 2020 +0800
>
> phy: rockchip: set pulldown for strobe line in dts
>
> This patch add support to set the internal pulldown via dt property
> and allow simplify the board design for the trace from emmc-phy to
> the eMMC chipset.
> Default to not set the pull-down.
>
> This patch was inspired from the 4.4 tree of the
> Rockchip SDK, where it is enabled unconditional.
> The patch had been tested with our rk3399 customized board.
> "
>
>
>
> For RK3588 I see this commit which makes me believe the internal
> pulldown case is the most common "
> commit 37f3d6108730713c411827ab4af764909f4dfc78
> Author: Sam Edwards <cfsworks@gmail.com>
> Date:   Tue Dec 5 12:29:00 2023 -0800
>
>
> arm64: dts: rockchip: Fix eMMC Data Strobe PD on rk3588
>
> JEDEC standard JESD84-B51 defines the eMMC Data Strobe line, which is
> currently used only in HS400 mode, as a device->host clock signal that
> "is used only in read operation. The Data Strobe is always High-Z (not
> driven by the device and pulled down by RDS) or Driven Low in write
> operation, except during CRC status response." RDS is a pull-down
> resistor specified in the 10K-100K ohm range. Thus per the standard,
> the
> Data Strobe is always pulled to ground (by the eMMC and/or RDS) during
> write operations.
>
> Evidently, the eMMC host controller in the RK3588 considers an active
> voltage on the eMMC-DS line during a write to be an error.
>
> The default (i.e. hardware reset, and Rockchip BSP) behavior for the
> RK3588 is to activate the eMMC-DS pin's builtin pull-down. As a result,
> many RK3588 board designers do not bother adding a dedicated RDS
> resistor, instead relying on the RK3588's internal bias. The current
> devicetree, however, disables this bias (`pcfg_pull_none`), breaking
> HS400-mode writes for boards without a dedicated RDS, but with an eMMC
> chip that chooses to High-Z (instead of drive-low) the eMMC-DS line.
> (The Turing RK1 is one such board.)
>
> Fix this by changing the bias in the (common) emmc_data_strobe case to
> reflect the expected hardware/BSP behavior. This is unlikely to cause
> regressions elsewhere: the pull-down is only relevant for High-Z eMMCs,
> and if this is redundant with a (dedicated) RDS resistor, the effective
> result is only a lower resistance to ground -- where the range of
> tolerance is quite high. If it does, it's better fixed in the specific
> devicetrees.
> "
>
>
>
>
>
>
> Lately two other upstream dts disabled HS400 due to this new behavior I
> believe:
> "
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/a=
rch/arm64/boot/dts/rockchip?id=3D2bd1d2dd808c60532283e9cf05110bf1bf2f9079
> author	Christopher Obbard <chris.obbard@collabora.com>	2023-
> 07-05 15:42:55 +0100
> committer	Heiko Stuebner <heiko@sntech.de>	2023-07-10
> 15:43:24 +0200
> commit	2bd1d2dd808c60532283e9cf05110bf1bf2f9079 (patch)
> tree	57cbf7eaa91deb68f143577d5d1dbc0d9141480e
> /arch/arm64/boot/dts/rockchip
> parent	cee572756aa2cb46e959e9797ad4b730b78a050b (diff)
> download	linux-2bd1d2dd808c60532283e9cf05110bf1bf2f9079.tar.gz
> arm64: dts: rockchip: Disable HS400 for eMMC on ROCK 4C+
>
>
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/a=
rch/arm64/boot/dts/rockchip?id=3Dcee572756aa2cb46e959e9797ad4b730b78a050b
> author	Christopher Obbard <chris.obbard@collabora.com>	2023-
> 07-05 15:42:54 +0100
> committer	Heiko Stuebner <heiko@sntech.de>	2023-07-10
> 15:43:24 +0200
> commit	cee572756aa2cb46e959e9797ad4b730b78a050b (patch)
> tree	cf3ed8ff6230cbde04353503417c1a75ba15c249
> /arch/arm64/boot/dts/rockchip
> parent	5ce6971e5279c569defc2f2ac800692049bbaa90 (diff)
> download	linux-cee572756aa2cb46e959e9797ad4b730b78a050b.tar.gz
> arm64: dts: rockchip: Disable HS400 for eMMC on ROCK Pi 4
> "
>
>
> All Armbian RK3399 boards, as far as I know, had to disable HS400, I
> also believe due to this commit.
>
> You can also search google for "running cqe recovery rk3399 armbian".
>
>
> This was never reported upstream though. But as HS400 is disabled
> everywhere nobody notice the regression nowadays.
>
>
> >=20
> > > BR,
> > > Jensen
> > >=20
> > > On Tue, Aug 23, 2022 at 10:13 PM Doug Anderson
> > > <dianders@chromium.org> wrote:
> > > >=20
> > > > Hi,
> > > >=20
> > > > On Tue, Aug 23, 2022 at 4:53 AM Heiko St=C3=BCbner <heiko@sntech.de=
>
> > > > wrote:
> > > > >=20
> > > > > Am Montag, 22. August 2022, 09:41:39 CEST schrieb Jensen Huang:
> > > > > > Internal pull-down for strobe line (GRF_EMMCPHY_CON2[9]) was
> > > > > > disabled
> > > > > > by commit 8b5c2b45b8f0, which causes I/O error in HS400 mode.
> > > > > >=20
> > > > > > Tested on NanoPC-T4.
> > > > > >=20
> > > > > > Fixes: 8b5c2b45b8f0 ("phy: rockchip: set pulldown for strobe
> > > > > > line in dts")
> > > > > > Signed-off-by: Jensen Huang <jensenhuang@friendlyarm.com>
> > > > >=20
> > > > > ok, so this looks like it restores previous functionality.
> > > > >=20
> > > > > I'm just wondering as the "offending" patch is from 2020, why
> > > > > this
> > > > > only turns up now. Any ideas?
> > > >=20
>
> Probbaly because the introduction of PROBE_DEFERRED in regulator core
> before that (in 5.10.60) already broke at least my board HS400 due to
> double init. Thus why it took me so long to see this new pulldown
> behavior commit. I was testing every regulator core double init fixup
> patchset while not understanding why reverting the PROBE_DEFERRED
> commit on 5.10.60 worked but not on newer kernels (ie this new pulldown
> behavior was introduced in 5.11...).
>
>
>
>
> > > > Ah, I see. So before the offending patch we used to just leave
> > > > the
> > > > pull state at whatever the default was when the kernel was
> > > > booted.
> > > > After the offending patch we chose a default.
> > > >=20
> > > > On kevin I see an external pull down on this line. Enabling both
> > > > the
> > > > internal and external is probably not a huge deal, it'll just
> > > > affect
> > > > the strength of the pull.
> > > >=20
> > > > On bob I _think_ the external pull down is also stuffed.
> > > >=20
> > > > ...so I guess that would explain why it didn't cause a problem
> > > > for at
> > > > least those two boards?
> > > >=20
> > > > -Doug
>
>
> In my opinion it is about these board already being broken by the
> regulator core change, so nobody noticed the second regression. When
> the first regression was fixed, it was very hard to correlate the still
> broken behavior to the second regression.
>
>
> I confirm that on Helios64, setting "enable-strobe-pulldown" fixes the
> EMMC error I had when writing with HS400ES enabled:
> mmc1: running CQE recovery=20
> mmc1: cqhci: spurious TCN for tag 12
>
> It also took me so long to report upstream as my board code (rk3399-
> kobol-helios64.dts) is not completely upstreamed yet so I use an
> Armbian patched kernel.
>
>
>
> Alban
>
>
>
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip


--fb2c8dd55ef9719f9d11be5e04c0ac8d4ca5dd24af240fce5463600e99f0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJAEABYKADgWIQQFbmi0A2l3pTuK+esCQHEyPYq7fQUCZd21ZBocZGV2QGZvbGtl
ci1zY2h3ZXNpbmdlci5kZQAKCRACQHEyPYq7ffAYAP468MofYR9FFvB2pB7XR7Fh
73JXWpLb04W35HufTd50+gEArlC52Kj/w0WATTmOjmJN37mBeTIsw6b1ypE3dkFj
KAU=
=cvJ2
-----END PGP SIGNATURE-----

--fb2c8dd55ef9719f9d11be5e04c0ac8d4ca5dd24af240fce5463600e99f0--

