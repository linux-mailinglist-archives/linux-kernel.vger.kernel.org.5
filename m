Return-Path: <linux-kernel+bounces-160908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 473698B4465
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 07:33:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8293C1C225F3
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 05:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADCAF3FE47;
	Sat, 27 Apr 2024 05:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="idHhLUX1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F338F2C6B0
	for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2024 05:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714195997; cv=none; b=N2D7qFv1FPfNT1nYXjKZGtIuCNjuEe1cxpPyBggigdtY8VYUZ1b8PiY5DJmQ1Z76H/8Fo4sqgdtorav1x1SPHM2iLnCX8srhDzhnqEa+RkUHod3vxJ7Qas/Z6nDlP6m0Tx8q6feXwEC3Hycu17CqCVLmUV7I7TeVcCAfFTeKl+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714195997; c=relaxed/simple;
	bh=PtWn2T87TDjw50sSHRibWsb5PeqZ6N2HovMCRtmiYnw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ojSekmKM7EHQHUX89XR1yVj/EGzyLLaIh65hdrcaDEuKXjJUNKHId4BKl1RZ1g20I905hEDKj0/SEgCbL+hRZ0uIU93760ESWwpFf0/XA9iDlWEQU5Eq+FvZakZZfPUXuk+1H+jK/tj9uij6Piw3407c6C77l5iXQQG4dSx63gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=idHhLUX1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EDA1C113CE;
	Sat, 27 Apr 2024 05:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714195996;
	bh=PtWn2T87TDjw50sSHRibWsb5PeqZ6N2HovMCRtmiYnw=;
	h=Date:From:To:Cc:Subject:From;
	b=idHhLUX1T6hMvGn2OCt+441tmM7UZJg8dWlfOxP6mFK9WNCZbrvPeSRi1Owv1CiP4
	 9Neq4p22pZlGuBr7YK4D5+BHuriEA2pZKgN9oeXBkBFf62EXl5xRspSAMmMyg+pPv0
	 0zwEmbtIzG4Vnt64ntD/4UfJ5os9PpK8Gz4rYhPNadHoPIyTth25SJ1BICti3MQF7y
	 iwzinHAkTyWK4e7KY7u6AE5QuYE73E26GbyilfJ2WJWnXI0q0ydVgM5mz2C7YgFcKN
	 aXTxER6ZmigJcMCSmEp/B07VXElXigDprgJYCOh3NWetdFidbO+dioKBpTezuC5g0k
	 FH7/1DYcy5Vog==
Date: Sat, 27 Apr 2024 11:03:12 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL]: soundwire fixes for v6.9
Message-ID: <ZiyOGDeHrj9d4r80@matsya>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="jtr/cWbaGGapRrIL"
Content-Disposition: inline


--jtr/cWbaGGapRrIL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Linus,

Please pull to receive single soundwire amd driver fix.

The following changes since commit 4cece764965020c22cff7665b18a012006359095:

  Linux 6.9-rc1 (2024-03-24 14:10:05 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire.git tags/so=
undwire-6.9-fixes

for you to fetch changes up to 63dc588e7af1392576071a1841298198c9cddee3:

  soundwire: amd: fix for wake interrupt handling for clockstop mode (2024-=
03-28 23:40:33 +0530)

----------------------------------------------------------------
soundwire fixes for 6.9

 - Single AMD driver fix for wake interrupt handling in clockstop mode

----------------------------------------------------------------
Vijendar Mukunda (1):
      soundwire: amd: fix for wake interrupt handling for clockstop mode

 drivers/soundwire/amd_manager.c | 15 +++++++++++++++
 drivers/soundwire/amd_manager.h |  3 ++-
 2 files changed, 17 insertions(+), 1 deletion(-)


--=20
~Vinod

--jtr/cWbaGGapRrIL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+vs47OPLdNbVcHzyfBQHDyUjg0cFAmYsjhgACgkQfBQHDyUj
g0cFYRAAjWa4C4pHNn/aiG23BkwiMlyytm0e8X7rGnjwhWmqcO9hggoD+6B+9K5/
FhaJTkAUoSqQ71XnRyNaMsUQd39Qu1pqYxCINJm3klEiQDD/apnlfMPGJDHpn5Dn
d8L8DeP8A+T43CCXDuVni2iffFE6uvRo6JWCuUaA7gAu7uA3Qb3On7YQtEZfZAoE
Jd46BpL/84aaLW2QgdpXPcDRZK5l4gKqP/+HnrJi4BP8dpZZ60ufNBQoPnnjdKJs
j4UiED770kuLtv1cDTf8uGvdKgJMN5o18VXtYZ3cHSxd7URPqEiO/la5nGdLH6u3
t7bHcMF8RKki7fOXiJ9xKKgurPWUoC+/aeuAQPq1qTM9HXpOTXHshh58g3SGLNqC
Si0zw6v8K13Ms19ZEhlQtmOvOszeNYFt2xMGM9IPdCft3WcWm1T+dMyHMPnIdBj1
XUP/w52+xV4vZ599bN4qiNMZkFBswikjdKzQeUE1rrPl+yw61shYJE0yLnyZoHj2
MHOw/+wUo+BVROyIvKq3nv0ePhZC3U3TFuQyBF+D0diqne0L2Jh60OTKjbGvGQJx
qYEJ5ogGP4+6FcDEJ81lS9YnkR515l3qwYdYaGWGL6M1l8BFfREDi110yfx/xJvg
OYH3sfvn3uuaQzRm75qdzafzmlo/q4IsY92b7LnmCaeGcyZ4mNI=
=QWvJ
-----END PGP SIGNATURE-----

--jtr/cWbaGGapRrIL--

