Return-Path: <linux-kernel+bounces-89838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E02C86F64E
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 18:00:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33D401F23D9E
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 17:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1632745CD;
	Sun,  3 Mar 2024 17:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HCrmz+Bu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E286BFB5
	for <linux-kernel@vger.kernel.org>; Sun,  3 Mar 2024 17:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709485248; cv=none; b=AsXGBfB1u3V87HmYleQJAq1JP6R3BfrUF3n8Ned9DevAK0jBAME/gvF1BMXsRb8MrgwkHBOcGWTu6Ky6oy5A6qYDxJEGm+PKkD4ZFWlWVz1ivM9nbEs0EemA+qo3AOsmF1s8PStuBZgrplIIQfiOda8xyOe/cE552LDNcb8y+40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709485248; c=relaxed/simple;
	bh=xRdrA+dLwU8ThANiwvOBO5GZ92pgX0eBuydraP1Jm9g=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ut8TSFdvCumlb7p6yRxSMC70AzUklpJDctvz7qE1A/C8PNLW4u95l9MKWe65bt5nn5gYUwOyqXUgwA3AL8A0Bn+1btioi6f6JYC5tDJmqrsmMQZtc5pjlM0RRnHGVfa+ejt8EqlDl3puy9/avXlzABQlq2oV9ivfBAJTNan8Jv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HCrmz+Bu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1334C433C7;
	Sun,  3 Mar 2024 17:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709485247;
	bh=xRdrA+dLwU8ThANiwvOBO5GZ92pgX0eBuydraP1Jm9g=;
	h=Date:From:To:Cc:Subject:From;
	b=HCrmz+BuvZOj73b35bPRCaRioVmLazUXA+n0F4pz8L/sWHFgqP3cKZVFUficBQTTD
	 IhDECtNkogzST3XFSiYRJSbgR6X4xjc8gqN4Zpla8YDJdiNUY2bvh4JPUjrGNod2Uw
	 6fAOojirK0TnhATTsve9d6Ih7Ihi/TnvW4zLJ49Pz/PV7yc0HioPqYzLnN6+KidVib
	 uwJFF0KALGJ8Df4eRKf5Z6Hm06CY6c0EmhTQ7O18iBXJ3dsD0ICmXFHcKeZYvCzz4h
	 4VfeyDYc4qQg714EpzIugDKESgcO4Wok+nG26B/LO12VmVi+RfghO1DLzadkghEIY2
	 fv/vbHYPcE/lw==
Date: Sun, 3 Mar 2024 22:30:43 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL]: Generic phy fixes for v6.8
Message-ID: <ZeSsuy_-5k7ibvgI@matsya>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="fI//072zvwAiaE8K"
Content-Disposition: inline


--fI//072zvwAiaE8K
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Linus,

Please consider the couple of changes for Generic phy second set of
fixes for v6.8

The following changes since commit 54be6c6c5ae8e0d93a6c4641cb7528eb0b6ba478:

  Linux 6.8-rc3 (2024-02-04 12:20:36 +0000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git tags/phy-=
fixes2-6.8

for you to fetch changes up to d4c08d8b23b22807c712208cd05cb047e92e7672:

  phy: qcom-qmp-usb: fix v3 offsets data (2024-02-16 17:05:48 +0530)

----------------------------------------------------------------
phy second set of fixes for 6.8

 - Driver fixes for
   - qcom: m31 pointer err fix, eusb2 fix redundant zero-out loop and v3
     offset fix on qmp-usb
   - freescale: fix for dphy alias

----------------------------------------------------------------
Abel Vesa (1):
      phy: qualcomm: eusb2-repeater: Rework init to drop redundant zero-out=
 loop

Alexander Stein (1):
      phy: freescale: phy-fsl-imx8-mipi-dphy: Fix alias name to use dashes

Dmitry Baryshkov (1):
      phy: qcom-qmp-usb: fix v3 offsets data

Yang Yingliang (1):
      phy: qcom: phy-qcom-m31: fix wrong pointer pass to PTR_ERR()

 drivers/phy/freescale/phy-fsl-imx8-mipi-dphy.c |   2 +-
 drivers/phy/qualcomm/phy-qcom-eusb2-repeater.c | 160 +++++++++------------=
----
 drivers/phy/qualcomm/phy-qcom-m31.c            |   2 +-
 drivers/phy/qualcomm/phy-qcom-qmp-usb.c        |  10 +-
 4 files changed, 66 insertions(+), 108 deletions(-)

--=20
~Vinod

--fI//072zvwAiaE8K
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+vs47OPLdNbVcHzyfBQHDyUjg0cFAmXkrLoACgkQfBQHDyUj
g0fKHA/9FyMg0Jbg5MbqifFrpzJCel3pVbeNpkYPFjpq+7JW62dUkd82UddhRggX
PQ8naNichMamILdgNwmhrQbpmxmQ4nkJLS+Iif3fZ+y/OkZyMLkTXQ8cFFtI53wa
EHcWJsAwKkYd8lAs6KEmk8KGyaLdVXa+Ya9yK4q5c1mmHCaUF7bf6dJVCvvBlEty
UpJDwCsWx74UgdUruCkyS3iY7zy9vl5jafXnAjARQuDHkxQiJNXBF1bt/qWOUpAs
kv73hcOktqQWXeEUL6og1NJUFiZeMzERaAim/nj7Y5CY3T1BHbl3giPtZdzHqYaG
VLBteN2SCYlrWNLTQrFiIi1F74jcdFoD41FuofcdfD8VtqCgLcJJmS8ycAmNUYAV
Sz1MLGACQUaxqfyMyV8MA/0w4y+eNxNNVa+yq/CXgnNzRHVDqQzvyXF/fDvkB+hZ
ixdpcH7lFPO6TeJmXXUS2aoHfK0BdFsiSPzZ1VQC21pHY+ZCdlGyBnX7AFphNwXC
k93u4YibcpTnLQJ7gWdQChS6YYJP9q9bbqRyr/5iWhGpdfZ+GffIm/rKCi6GTeSZ
yTmwoJC8f7GAMMHaeX1w++Qn2+8PvA2UQHIUi+p/5I7wgdVwCEY2NuqHBBdduKED
hRWJfg4rs3PI17ZAhCUOC+vH55rYDehwFkues4B1aGws5LUIKic=
=nQ+K
-----END PGP SIGNATURE-----

--fI//072zvwAiaE8K--

