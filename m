Return-Path: <linux-kernel+bounces-70683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDDF2859B1E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 04:44:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EBF11F220BD
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 03:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F243546B3;
	Mon, 19 Feb 2024 03:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="GRNN1dyc"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B4D4405;
	Mon, 19 Feb 2024 03:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708314269; cv=none; b=Fn7WKA+z/31+kYxcxcZF8otRomDBAsAzo0zzhM8JUpYWmve3IXBIvz+JGPc7e5hKPdR790QsegyVXyRc2mdkya8awgrVqsnBstmgRehaBU+F1WFYcMr5OtehrcEzi3Rm28Ld4Nx17+kXuVt06hKrpLs38KSese9j5TlEN7KG+40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708314269; c=relaxed/simple;
	bh=XDDPkOc4JUM/9hqklG4JbKrMtBikDhra6T+KBoQ8t3U=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=FiB7WQhILB7HtrY4O0FfImbJgWNcvizdwKlyb3y8KQsF0eMtyTTpNaCg2h7QW4c84XIP8BesxO2F0G+NkbguZVcYUaN9+KszFs6UBfsDOUbsg/Z5JmPiuugM0e7u9TALM1Emr0M90i0P+DEowfml4BxOAOWgMks0C8QGNh8azzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=GRNN1dyc; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1708314265;
	bh=96l6UOsMkarkXDh/DNyDt/zjIlA9wUHgWmS9lK4mCYQ=;
	h=Date:From:To:Cc:Subject:From;
	b=GRNN1dyccv4Jrvfd1Imk9vq8w7P49Zp/MN+Qtv+f5kd9DMs4CGRHEr51qneq4B52Y
	 VdJKl/SJ7sRLo5bfK3sGBi21HFRgJQd8OiVi4Tx+mmJIdUQBno8F30kkkWDRH62EwP
	 ktFReM1JdcNwd5SX1rUL66DoN9i7Q9RmmIO6uFkAa/pNj/cbR020eq6qAeXJ+ZROB+
	 APz2O4iMJhOVWvw3OdxuXH4Gm7l0nWO0IQOr85L2Pfo6O1yaZ56/Fyo/ADzq2jxCJg
	 h7KLCW8sa6/lF2vHUwmXmMTLZEnZO2btjCPpedmS+X5jtQQ2KIgofIcwY8I1CsQfQC
	 LX9nB1wxRO8qA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TdT1P1tscz4wc4;
	Mon, 19 Feb 2024 14:44:25 +1100 (AEDT)
Date: Mon, 19 Feb 2024 14:44:23 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Kishon Vijay Abraham I <kishon@kernel.org>, Vinod Koul
 <vkoul@kernel.org>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Linux Kernel Mailing
 List <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the phy-next tree with the phy tree
Message-ID: <20240219144423.16a76202@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/zo_fj8Be1knf8PlJvILEXaw";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/zo_fj8Be1knf8PlJvILEXaw
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the phy-next tree got a conflict in:

  drivers/phy/qualcomm/phy-qcom-qmp-usb.c

between commit:

  d4c08d8b23b2 ("phy: qcom-qmp-usb: fix v3 offsets data")

from the phy tree and commit:

  52cfdc9c6c33 ("phy: qcom: qmp-usb: drop dual-lane handling")

from the phy-next tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/phy/qualcomm/phy-qcom-qmp-usb.c
index 5c003988c35d,6b6994cb77d7..000000000000
--- a/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
@@@ -1621,27 -1328,7 +1336,25 @@@ static const struct qmp_usb_offsets qmp
  	.rx		=3D 0x1000,
  };
 =20
 +static const struct qmp_phy_cfg ipq6018_usb3phy_cfg =3D {
 +	.lanes			=3D 1,
 +
 +	.offsets		=3D &qmp_usb_offsets_v3,
 +
 +	.serdes_tbl		=3D ipq9574_usb3_serdes_tbl,
 +	.serdes_tbl_num		=3D ARRAY_SIZE(ipq9574_usb3_serdes_tbl),
 +	.tx_tbl			=3D msm8996_usb3_tx_tbl,
 +	.tx_tbl_num		=3D ARRAY_SIZE(msm8996_usb3_tx_tbl),
 +	.rx_tbl			=3D ipq8074_usb3_rx_tbl,
 +	.rx_tbl_num		=3D ARRAY_SIZE(ipq8074_usb3_rx_tbl),
 +	.pcs_tbl		=3D ipq8074_usb3_pcs_tbl,
 +	.pcs_tbl_num		=3D ARRAY_SIZE(ipq8074_usb3_pcs_tbl),
 +	.vreg_list		=3D qmp_phy_vreg_l,
 +	.num_vregs		=3D ARRAY_SIZE(qmp_phy_vreg_l),
 +	.regs			=3D qmp_v3_usb3phy_regs_layout,
 +};
 +
  static const struct qmp_phy_cfg ipq8074_usb3phy_cfg =3D {
- 	.lanes			=3D 1,
-=20
  	.offsets		=3D &qmp_usb_offsets_v3,
 =20
  	.serdes_tbl		=3D ipq8074_usb3_serdes_tbl,
@@@ -1676,9 -1361,7 +1387,7 @@@ static const struct qmp_phy_cfg ipq9574
  };
 =20
  static const struct qmp_phy_cfg msm8996_usb3phy_cfg =3D {
- 	.lanes			=3D 1,
-=20
 -	.offsets		=3D &qmp_usb_offsets_v3,
 +	.offsets		=3D &qmp_usb_offsets_v3_msm8996,
 =20
  	.serdes_tbl		=3D msm8996_usb3_serdes_tbl,
  	.serdes_tbl_num		=3D ARRAY_SIZE(msm8996_usb3_serdes_tbl),

--Sig_/zo_fj8Be1knf8PlJvILEXaw
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXSzpcACgkQAVBC80lX
0Gw34wf/dYysyPBru8cCNQcdncCwaGDbAxI4AgvxLNDyXtOS+LR1xlWsbPW7eTxq
8dF6rN6krlnXEOQaPAgISF3+4iyZtdOMjRP3IG5tGecV+kkURizBFAFbOjEhNBum
L2fPrt7dkqCRqTEShDPzyAYFZEkMYOAcrZn7tFzOU15cSgcl4CuA/jIzn3SIHIKb
kKuM2vt90NJKApPzpvxR6EwMdU3lq9PWU5aB0wm9P8ADa2emW9CBTU4zVEQfBjGp
+L3dtPUUQcxAIUwXwXr98FCgEwO6NOiLrdQTi+VJpvOXOqaSkIXtqwlzaYY9DKRD
OTha/mlAlSneDMJz6glhqwKUIWkMCg==
=ZLOF
-----END PGP SIGNATURE-----

--Sig_/zo_fj8Be1knf8PlJvILEXaw--

