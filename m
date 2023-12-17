Return-Path: <linux-kernel+bounces-2691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7B41816098
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 18:00:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E0E01F22BC5
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 17:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8A1245BF2;
	Sun, 17 Dec 2023 17:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ust00oYs"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0872A44C88
	for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 17:00:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDD0BC433C7;
	Sun, 17 Dec 2023 17:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702832424;
	bh=GogW5D6Y+SD+UASLvms8cf2y1R4KcoAWaiuqM0Z6DwI=;
	h=Date:From:To:Cc:Subject:From;
	b=Ust00oYs0gcEWXRpCp8L/UvCrPYnBgp83scsvKpRMBzytnlO+De4AxL114308f6bb
	 RSezZYWrEuSk748m5deLa/vIDdxjvY8VqPh7afReAvxBoFJQqpIaNGZUw/ITSiOzDl
	 CYIJAryeVFzHGwJti5CnxLKfMpJAa/E8bw2wO/ZVBHnLrNqyri+oR48EgIX/kUXSQO
	 ZQdFG24LChVRYyvo/qllL7Q7jmdMMYWNS6Gs/uXsm/ZHCynsZTBQLTOnHcef/JEged
	 53qyPJiyqgKO+U9qQUTNOJ/DsjiipASUdCyGVaTrFvWlb8jmM+0UdsDzWSL3eGhvpu
	 Oebaka17540AA==
Date: Sun, 17 Dec 2023 22:30:19 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL]: soundwire fixes for v6.7
Message-ID: <ZX8pI+hOq9Tg5H2A@matsya>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="B0p2wfdWhnStDON3"
Content-Disposition: inline


--B0p2wfdWhnStDON3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Linus,

Please pull to receive the soundwire subsystem fix for 6.7 containing
intel driver fix and a core fix in case of multi-link.

The following changes since commit b85ea95d086471afb4ad062012a4d73cd328fa86:

  Linux 6.7-rc1 (2023-11-12 16:19:07 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire.git tags/so=
undwire-6.7-fixes

for you to fetch changes up to 393cae5f32d640b9798903702018a48c7a45e59f:

  soundwire: intel_ace2x: fix AC timing setting for ACE2.x (2023-11-28 15:2=
7:27 +0530)

----------------------------------------------------------------
soundwire fixes for 6.7

 - Null pointer dereference for mult link in core
 - AC timing fix in intel driver

----------------------------------------------------------------
Chao Song (1):
      soundwire: intel_ace2x: fix AC timing setting for ACE2.x

Krzysztof Kozlowski (1):
      soundwire: stream: fix NULL pointer dereference for multi_link

 drivers/soundwire/intel_ace2x.c | 3 ++-
 drivers/soundwire/stream.c      | 7 ++++---
 2 files changed, 6 insertions(+), 4 deletions(-)

--=20
~Vinod

--B0p2wfdWhnStDON3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+vs47OPLdNbVcHzyfBQHDyUjg0cFAmV/KSMACgkQfBQHDyUj
g0fNMhAAvGCRHgz8S/KSCIYDwqRBo8LeZCGWKR9oiVlCPC3lZ1u762OZDhXhc0c4
ZcMYc0pyQqQdYVpqqUOV/5AAAz3bADcIeI4L0Lw/kA/WNseaSHf2gpY0xXvRfvBK
3xRsvDjZz+WShoTbQwcC9ykThL3xNlg0awto9Kz/aF+jQkAwA+sY6w5Qrwglel8x
znWHzFz1W/nBh3Ozn0k6dG+8mOX032du0Agj+selkWgCCtuUQxaeVZMmfu/ZmTdX
qMPjI6ij5e9tCajrLb1/KtThPsKZC+p8wLylln74x2YgXRCKkYUb+39FOdXQ21s0
eIqkJO1LU2cyAfk8/ZF+QuysCZYqomR+kvyMxTZBT2rU+EexjowCnKyITB1Rgzzr
Ox362ZzlaOABbz4j68gecq9u3xDn20AvrKpc7Pt9Y6AYKEnvbnlHODLljqSQnxfb
4YeaIEzwCGwcqzl2BJwAMPPr4gAeuHtxMigtX+5fQpPNIRsnBYpzzxbRw3nqlgrU
RGVG8J8WLvYr3rNArYxWyapIr4m3RrgVkTe/5W4ua/03Q+mV+pFEfh6g5pi+l6VE
wBs1LJVz0N0XQmsnFJQhEjMc7ZNQu47TTleoHwgPrxX3266KGhuMFpSMNF1IblyW
Cba3AEslmifL4i73JbP1Z133RUs9O2HZE1uOefrgY4zshMWAETo=
=WkZf
-----END PGP SIGNATURE-----

--B0p2wfdWhnStDON3--

