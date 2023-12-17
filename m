Return-Path: <linux-kernel+bounces-2688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF341816093
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 17:57:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E15A61C21D7C
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 16:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26FA546420;
	Sun, 17 Dec 2023 16:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AWILDCWw"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757B545C0C
	for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 16:54:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72709C433C7;
	Sun, 17 Dec 2023 16:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702832081;
	bh=5SDSUqA4sWBpJqXyAxE7PEJTGVF/ONPQ+mNuFcZUc40=;
	h=Date:From:To:Cc:Subject:From;
	b=AWILDCWwDXywmhMF9c9+XdUABeru72WaizqppAQxj+a7SoVS47LTWF+GdM9N7wvH8
	 evcIiBu5Tu4EcA8sVG4MvzxPLLY3FBRCZ1tt552OwGSlt72yxf8XO97YW9QZo4hl+s
	 pwZ1WGcUXVnOA1wVQgHu0jQtgyVjDH1JcxxA3rxgXyNE6y57ZBQmqz95kA0hW+/XkQ
	 2+6rqwdY4Yza82Wy/GNIfUZbe2GG3aE87vZKIXKMq00zdidofxtP36xfzyYa+UMhpR
	 BbZ9jNWdru27ienREzdY1nV/LMIaQgL6EoZMc2QCrOmdE/n+6bzjteaEYe282/xfuY
	 W4jwXnkV9xicg==
Date: Sun, 17 Dec 2023 22:24:36 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL]: Generic phy fixes for v6.7
Message-ID: <ZX8nzO8SuXpTV1dQ@matsya>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="IrbnQdy30S3CXtQI"
Content-Disposition: inline


--IrbnQdy30S3CXtQI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Linus,

Please pull to receive generic phy susbystem fixes.

The following changes since commit b85ea95d086471afb4ad062012a4d73cd328fa86:

  Linux 6.7-rc1 (2023-11-12 16:19:07 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git tags/phy-=
fixes-6.7

for you to fetch changes up to 2a9c713825b3127ece11984abf973672c9779518:

  phy: sunplus: return negative error code in sp_usb_phy_probe (2023-11-27 =
18:39:18 +0530)

----------------------------------------------------------------
phy fixes for 6.7

 - Driver fixes for
   - register offset fix for TI driver
   - mediatek driver minimal supported frequency fix
   - negative error code in probe fix for sunplus driver

----------------------------------------------------------------
Andrew Davis (1):
      phy: ti: gmii-sel: Fix register offset when parent is not a syscon no=
de

Michael Walle (1):
      phy: mediatek: mipi: mt8183: fix minimal supported frequency

Su Hui (1):
      phy: sunplus: return negative error code in sp_usb_phy_probe

 drivers/phy/mediatek/phy-mtk-mipi-dsi-mt8183.c | 2 +-
 drivers/phy/sunplus/phy-sunplus-usb2.c         | 2 +-
 drivers/phy/ti/phy-gmii-sel.c                  | 5 ++++-
 3 files changed, 6 insertions(+), 3 deletions(-)

--=20
~Vinod

--IrbnQdy30S3CXtQI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+vs47OPLdNbVcHzyfBQHDyUjg0cFAmV/J8wACgkQfBQHDyUj
g0cTuhAAhuTNFPx0vJ242csKQvQMNl6HfWMblVQDHQWAkfKJQb4erSb8MYa8Tuf2
JNV48WsTWNxBBL9lNLKgiWhk8teCFkSFX9EgV7xPYieTU7xEsjOqN6nZYYUqHXww
R9ZxKEvEh6bah2/PdHWCKrl4+zwHQORyqH+wE1hM7MahGmnKXTe0CzvmAN9P4b9K
j+NJwTZNGW7bYI8r2IlokT6wq/h9jkagO5AvLpqS89ZQVnNNwoVgBOqb+VPw83sm
EJjsMbV8z0iEGV+NaIUZKSuIpWfS6tRIsbjRldhvROxjap6NoTw5I5zBwbNBV+az
syoz8AgikhLpLvGBVP6oEnpIpCOLeRB2eSkez99RlBNlNBevmaMUTRNNJspG0XY/
wUf55NILhYl+ndhSPos0NgCg1Qp49ScIKEUIv/+6j5sAND/rnLcfDNbO4DRBVKyQ
+nQI4DSNfj/74Sq9V8IvZ5AfcG5EeppuZKum/JxlOLnmDv8N3uXeNk/POH69HLwH
tII8CCl/EsB/0J84na1uKyVxetcy9pPS70QaqNZnrLXjGtq2jCKZOgn4Q5tvRfIN
e6jsalXFm5k0WldDDvX+xx7anZoWRZhSnr1mUZ8dctaaSb7D2S3GuOlBlnAAu/wW
BZNCevL2TR/2h2WhCnxw2eKoLGPf9qfnP+kzwAYkBWL45jdUWLo=
=V3/2
-----END PGP SIGNATURE-----

--IrbnQdy30S3CXtQI--

