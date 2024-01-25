Return-Path: <linux-kernel+bounces-37853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB95583B691
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 02:33:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 853CF1F22D49
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 01:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCD181860;
	Thu, 25 Jan 2024 01:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="HwXyssm6"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE0AEA9;
	Thu, 25 Jan 2024 01:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706146416; cv=none; b=Pq28U947J4osuKfhlbf4nEdqY7wDQfzvwtYbzqoI8yBiweGC8JGVPfC61zFKh0o5++K5lWyKwzLToAd16qPcZV34ISJAPBKrA0I8ruH52I2W2l0ae0VdYjUKGg2AZPSe1RGbnlGfA113s3ATY5RqGM5I0Qxm4KWyQ8st/3tfdnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706146416; c=relaxed/simple;
	bh=jU/2S0TPmYwsFAEcLm1nhe1J12jMGQjYbEw/4xSLtXY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=BS+MopigDWEwPnwsCLnIQ0EfBU+zlRw3xdPx9TzXPuSDy/mnT2GsMbuly+HrHnMZVYb+Cr6MKPMl9eCaJLAfUhl7Zu/kmzuxEKgy72GaY+11Bc/fLEzFRXSO5TNg3h9qt9NxxKwHKUdoRnZAcEqMPqRzEDNhkVazKNIiadcdVFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=HwXyssm6; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1706146411;
	bh=OMpz/Ji0fdOajaSAOBxQ3VgIldu0JQQGzsMSMM/0E3E=;
	h=Date:From:To:Cc:Subject:From;
	b=HwXyssm6v0JDKe7PoaSDeqQFetH7S+3t4YlnxNCkg6vs6JwK71kXPwRlWjLp+B+DS
	 wXtum/h1A1VvR5Cakqtudn0Ay9g2o63PanmNFtTd56q98JuNAbpHu/vOx+lz6KC+CU
	 V7+YYaAWWfkeWi/DZKDzeYT2+HzT3tpZCnEo4eVoR/ilCMquczSuA67d2x07AIry+m
	 XlATYHNsYP5K2kxWMB4tYmQlghh1RVjxhUAHaZ8WzM9vxMfthRRQMTRj3ughhM6dfX
	 /kHQijwmlvMULyeJTV1FW3dKFgY62obiFS16IGDZoe6iTawu1AwcgNNHSBoVkIeCTJ
	 peCsVZTG+iZbA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TL3Ht63XHz4wcg;
	Thu, 25 Jan 2024 12:33:30 +1100 (AEDT)
Date: Thu, 25 Jan 2024 12:33:27 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Kishon Vijay Abraham I <kishon@kernel.org>, Vinod Koul
 <vkoul@kernel.org>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Linux Kernel Mailing
 List <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>, Mantas Pucka <mantas@8devices.com>
Subject: linux-next: manual merge of the phy-next tree with the phy tree
Message-ID: <20240125123327.4e2825ab@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/P.9/+PAaV=dIUGYBEyvUrXX";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/P.9/+PAaV=dIUGYBEyvUrXX
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the phy-next tree got a conflict in:

  drivers/phy/qualcomm/phy-qcom-qmp-usb.c

between commit:

  f74c35b630d4 ("phy: qcom-qmp-usb: fix register offsets for ipq8074/ipq601=
8")

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
index 6621246e4ddf,e62539ce99a6..25d8d881b2f3
--- a/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
@@@ -1621,28 -1385,8 +1393,24 @@@ static const struct qmp_usb_offsets qmp
  	.rx		=3D 0x1000,
  };
 =20
 +static const struct qmp_phy_cfg ipq6018_usb3phy_cfg =3D {
- 	.lanes			=3D 1,
-=20
 +	.offsets		=3D &qmp_usb_offsets_ipq8074,
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
 -	.offsets		=3D &qmp_usb_offsets_v3,
 +	.offsets		=3D &qmp_usb_offsets_ipq8074,
 =20
  	.serdes_tbl		=3D ipq8074_usb3_serdes_tbl,
  	.serdes_tbl_num		=3D ARRAY_SIZE(ipq8074_usb3_serdes_tbl),

--Sig_/P.9/+PAaV=dIUGYBEyvUrXX
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmWxumcACgkQAVBC80lX
0GyAxQf/b9N4//QzimAOUh3oYTiKCCjP6pgi7X8jxOIr6+9zMlfQMNjOnGSlLUb5
5M7dk5m/II92euWE2sfxnmyaRuCJDsW1Y+nzCMUg73ClZb5kcx+hdYOx1xNkb97q
Lkj7wCg6rvJDJZvtA6y30l4l8L1CYW8QBsEXpn21GezNaCYvGkkjpnvgYaWc/2jX
t0W9RMpQNeNTI97sWRSWLq4ZdW2lYNmpg7xRBwYI/3KvmlPT4Dih9pV/nV+gM6uM
nrjC4+kZ/dFHYSd5pnYL4X/xaPoAmPDxWE0M7bcO4UUdOCNqMFktkdhtDoOxbFDS
uVzAoqQu4skcPV25x0zqE/nJhPXt0Q==
=xuwC
-----END PGP SIGNATURE-----

--Sig_/P.9/+PAaV=dIUGYBEyvUrXX--

