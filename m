Return-Path: <linux-kernel+bounces-119830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AF64688CD70
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 20:46:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC4A2B247C9
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 19:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51C5313D25D;
	Tue, 26 Mar 2024 19:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g6x15P3T"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E381481A3;
	Tue, 26 Mar 2024 19:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711482369; cv=none; b=d6ScHGeQtmc+Gr2y0+W2fVyCsMjFCaOU0Q9A0AEgDlXHTbfSHyMZB8Q7psySx8V3Ozbl9avtSoYlw4ZLQnJIP05R9oU9/i1H9L/AM519Vnw6L8Llep0/zGfsIVF/dLVjKA9YOSxNhjqUrFAuuC1pf/EMurMWjizlDlqTCnjJiFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711482369; c=relaxed/simple;
	bh=06TMEEjhODfbSDjv9gFoX7ubkfnnvLL8Xxq82XPPGcI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UiwtlCmkKKrx1pbxSDQwCXb+S1q1+DWW7QEvbIsIg6Vr4YXZO6KaWefVsRSrTpIrSNkCuCeKbY0ASnXQyvbWSjmPhnXRSUfRq9roH8zv2z3bviJMfEIVtCHc1OY16GByZa8J4NcCsCH4ET9QMgHiA1Bi/1q58drCER4sevxgrk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g6x15P3T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A1A2C43390;
	Tue, 26 Mar 2024 19:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711482369;
	bh=06TMEEjhODfbSDjv9gFoX7ubkfnnvLL8Xxq82XPPGcI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g6x15P3T/1D5cok+wB8MT33wgFRF7mj3MaVE+NxPaxiptp+GDXhe0NySVkbdXvMuj
	 Nnetdt5zPMSGu27jzoTrcmqjvHcFMyam0f6IWtDW06MbdtPtxOU3T6syrf/EXAqtRb
	 wgnXiTgDv05AORB+BUBYkg4gkySnDZh9CTseRoQATOXjcYOi8ACqd2/WcCG2JgT3Sj
	 BcaY8o2uSLOxS/q9AEBUbDzJNd1ZStJzr+pr3TFo9oLuaqwwWIn1H1uQ9L+N4CxfP0
	 v5JOTyC2yW+rB6tzapYc3JdRwQwwxYT09dX2AR3l5G7eoaXoee2lzzu+4h390IcePs
	 07qP2iF5zKEpQ==
Date: Tue, 26 Mar 2024 19:46:03 +0000
From: Conor Dooley <conor@kernel.org>
To: dev@folker-schwesinger.de
Cc: Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Chris Ruehl <chris.ruehl@gtsys.com.hk>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Christopher Obbard <chris.obbard@collabora.com>,
	Alban Browaeys <alban.browaeys@gmail.com>,
	Doug Anderson <dianders@chromium.org>,
	Brian Norris <briannorris@chromium.org>,
	Jensen Huang <jensenhuang@friendlyarm.com>,
	linux-phy@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 1/3] phy: rockchip: emmc: Enable pulldown for strobe line
Message-ID: <20240326-tactical-onlooker-3df8d2352dc2@spud>
References: <20240326-rk-default-enable-strobe-pulldown-v1-0-f410c71605c0@folker-schwesinger.de>
 <20240326-rk-default-enable-strobe-pulldown-v1-1-f410c71605c0@folker-schwesinger.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="zYLJU3bUGFnj+RDa"
Content-Disposition: inline
In-Reply-To: <20240326-rk-default-enable-strobe-pulldown-v1-1-f410c71605c0@folker-schwesinger.de>


--zYLJU3bUGFnj+RDa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 26, 2024 at 07:54:35PM +0100, Folker Schwesinger via B4 Relay w=
rote:
> From: Folker Schwesinger <dev@folker-schwesinger.de>
>=20
> Restore the behavior of the Rockchip kernel that undconditionally
> enables the internal strobe pulldown.

What do you mean "restore the behaviour of the rockchip kernel"? Did
mainline behave the same as the rockchip kernel previously? If not,
using "restore" here is misleading. "Unconditionally" is also incorrect,
because you have a property that disables it.

> As the DT property rockchip,enable-strobe-pulldown is obsolete now,
> replace it with a property to disable the internal pulldown.
>=20
> This fixes I/O errors observed on various Rock Pi 4 and NanoPi4 series
> boards with some eMMC modules. Other boards may also be affected.
>=20
> An example of these errors is as follows:
>=20
> [  290.060817] mmc1: running CQE recovery
> [  290.061337] blk_update_request: I/O error, dev mmcblk1, sector 1411072=
 op 0x1:(WRITE) flags 0x800 phys_seg 36 prio class 0
> [  290.061370] EXT4-fs warning (device mmcblk1p1): ext4_end_bio:348: I/O =
error 10 writing to inode 29547 starting block 176466)
> [  290.061484] Buffer I/O error on device mmcblk1p1, logical block 172288
>=20
> Fixes: 8b5c2b45b8f0 ("phy: rockchip: set pulldown for strobe line in dts")
> Signed-off-by: Folker Schwesinger <dev@folker-schwesinger.de>
> ---
>  drivers/phy/rockchip/phy-rockchip-emmc.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/phy/rockchip/phy-rockchip-emmc.c b/drivers/phy/rockc=
hip/phy-rockchip-emmc.c
> index 20023f6eb994..6e637f3e1b19 100644
> --- a/drivers/phy/rockchip/phy-rockchip-emmc.c
> +++ b/drivers/phy/rockchip/phy-rockchip-emmc.c
> @@ -376,14 +376,14 @@ static int rockchip_emmc_phy_probe(struct platform_=
device *pdev)
>  	rk_phy->reg_offset =3D reg_offset;
>  	rk_phy->reg_base =3D grf;
>  	rk_phy->drive_impedance =3D PHYCTRL_DR_50OHM;
> -	rk_phy->enable_strobe_pulldown =3D PHYCTRL_REN_STRB_DISABLE;
> +	rk_phy->enable_strobe_pulldown =3D PHYCTRL_REN_STRB_ENABLE;
>  	rk_phy->output_tapdelay_select =3D PHYCTRL_OTAPDLYSEL_DEFAULT;
> =20
>  	if (!of_property_read_u32(dev->of_node, "drive-impedance-ohm", &val))
>  		rk_phy->drive_impedance =3D convert_drive_impedance_ohm(pdev, val);
> =20
> -	if (of_property_read_bool(dev->of_node, "rockchip,enable-strobe-pulldow=
n"))
> -		rk_phy->enable_strobe_pulldown =3D PHYCTRL_REN_STRB_ENABLE;
> +	if (of_property_read_bool(dev->of_node, "rockchip,disable-strobe-pulldo=
wn"))
> +		rk_phy->enable_strobe_pulldown =3D PHYCTRL_REN_STRB_DISABLE;

Unfortunately you cannot do this.
Previously no property at all meant disabled and a property was required
to enable it. With this change the absence of a property means that it
will be enabled.
An old devicetree is that wanted this to be disabled would have no
property and will now end up with it enabled. This is an ABI break and is
clearly not backwards compatible, that's a NAK unless it is demonstrable
that noone actually wants to disable it at all.

If this patch fixes a problem on a board that you have, I would suggest
that you add the property to enable it, as the binding tells you to.

Thanks,
Conor.

>  	if (!of_property_read_u32(dev->of_node, "rockchip,output-tapdelay-selec=
t", &val)) {
>  		if (val <=3D PHYCTRL_OTAPDLYSEL_MAXVALUE)
>=20
> --=20
> 2.44.0
>=20
>=20

--zYLJU3bUGFnj+RDa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZgMl+wAKCRB4tDGHoIJi
0hvVAP45y61fo87t2o+BbHPCKNKWjbNdW5YeWmPG1yoleN6xBAEA68Hda2BEZnjb
dTtJLh0pxzAEeDUfwrA4rNAjq5p49g8=
=CH3R
-----END PGP SIGNATURE-----

--zYLJU3bUGFnj+RDa--

