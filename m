Return-Path: <linux-kernel+bounces-98271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FAEA8777AF
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 18:06:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D01EC1F21965
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 17:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48F34381B9;
	Sun, 10 Mar 2024 17:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AU9jDPBY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F40C1D6BD
	for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2024 17:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710090393; cv=none; b=tGUTjiUwOgWHFWfGMa+wDWXNtcR7M1MKB5DEsfZNu2n2CXBZv+15RlyexobCvF0cqjdF0W4C5d76Wf8BIvFV+nXAnsijA3ek/pv7UwjRrDJfpu3nms39Rils58K3AlvDLe9UnC8A+XkKFBVFmRaC1k52GuAyludGP0Lx2s3IU4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710090393; c=relaxed/simple;
	bh=hZNW8IxLh80QkFa8j9FkpxrhA1XGfVP7w1PTFU82GXc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=mFJ51Nfx/0aWwfrsxNNZ9HnGiAWf+orgIgC89x3B08mPaLWUoPOA+jFs/u7xxvmyP6/CvxB5dPmdPGhn7Sige9b9YSXgefUlGsUUFxMHC19Nq84f0U+B+PuiQlKPT1pCB5xJQt+jdo/DM6Oe9dxoKvHa7/hePCCdrgjlHW7xjkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AU9jDPBY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FBBCC433C7;
	Sun, 10 Mar 2024 17:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710090393;
	bh=hZNW8IxLh80QkFa8j9FkpxrhA1XGfVP7w1PTFU82GXc=;
	h=Date:From:To:Cc:Subject:From;
	b=AU9jDPBYEx5MY4FjfrcRmiA942SUID4PExiBaKpow8WAlSLuSB7UcAoMzjZ5IKTDU
	 2zIxCIJG0mfV0KpvmnBvjt6n498NuLMADE+cNTy8yvp6DWRRK2uB3Nl+ggcQbU1RhD
	 xjHIiTJDQDeTRGIFmBYLBRHFzcyvafGCoE50WsM+yhnh6U9F5/loRSniM1RC9N/8OP
	 uiJUjmTRDxEnNqy7OhDivRrCNgmM4cjL/ATPRtpokU9CKRddnGy2EDf3cOGca4I95E
	 V0i1GXeYLX8f22So+BYHXcMwpbxQXouR+8SMhTZs/LFLJqQKfEbpNhzyWBvZcv9MfU
	 d+zK54MrIUNXw==
Date: Sun, 10 Mar 2024 22:36:28 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL]: Generic phy fixes for v6.8
Message-ID: <Ze3olI5SfqS-1RJ0@matsya>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Rwkr5RC2FO1XHBk+"
Content-Disposition: inline


--Rwkr5RC2FO1XHBk+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Linus,

Please pull this late fix for Generic phy subsystem to fix the
regression on X13s laptop displays.

The following changes since commit 90d35da658da8cff0d4ecbb5113f5fac9d00eb72:

  Linux 6.8-rc7 (2024-03-03 13:02:52 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git tags/phy-=
fixes3-6.8

for you to fetch changes up to 47b412c1ea77112f1148b4edd71700a388c7c80f:

  phy: qcom-qmp-combo: fix type-c switch registration (2024-03-06 20:37:37 =
+0530)

----------------------------------------------------------------
phy third set of fixes for 6.8

 - fixes for Qualcomm qmp-combo driver for ordering of drm and type-c
   switch registartion due to drivers might not probe defer
   after having registered child devices to avoid triggering a probe
   deferral loop. This fixes internal display on Lenovo ThinkPad X13s

----------------------------------------------------------------
Johan Hovold (2):
      phy: qcom-qmp-combo: fix drm bridge registration
      phy: qcom-qmp-combo: fix type-c switch registration

 drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

=20
--=20
~Vinod

--Rwkr5RC2FO1XHBk+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+vs47OPLdNbVcHzyfBQHDyUjg0cFAmXt6JMACgkQfBQHDyUj
g0defxAAlTvjND1AhM7bN5ZyhZJ+bTwFSovO3jw7Hyn25+Y2Gz6EGx+35xJ/pDjN
UW4pm2pNVwKMm/X2MVvB2dCLNpP/iebu8s37qHXMXRdmkc77thBjTPwZXyRJdMLf
suarQLgwggNsAsh+UaI9h4gyzAGXB/EGJcdxpT9mXOEUx1ga1tiIYLXcOHvUxUbh
HL7YA+VyzJIbCbMSgXSYPypdFP9MuWbydgWsUtoJ1YX3oKOkTlwt+m0u96nLbSaC
HwUwE3EAbZOE6E2P7f+RHNjs5usRcLefR8TgLD6iL2W7DK/RVy3juda2q1aNMvsw
KKJUIC9m+4N11gNHz67yanOiGWD1dWsP4V4OL7X3Wtimide/xZnB4scOQDFB6bzs
J8smB+bQZZqLJB24+sa7fJqgaydffG7HnpZq3mvMguH4WHNkHnZpbQjMlTHKHvsV
T8i3BP9M10NE1ZfPrylrIw7386bXuLHLKoCA4DZ0gt5CN2lGhQqfrkAJbgVDEY0V
MrAGiDRyGGHk9Ih080K8EQWfVqLmFgTc/DkhZcQi27voqnA+mGy9M2c/uVQ0KwP0
hPNoLhA94AJU+A1E/vg1fQKZGJIMWbunRDnt4fGUMTLyeWFlIG/dpft17SF9RZpv
YxasYrk9FkqBTIUdvHN71pSCTTsN+4J1DHbOI+spVCCA9SHcQRA=
=zdeA
-----END PGP SIGNATURE-----

--Rwkr5RC2FO1XHBk+--

