Return-Path: <linux-kernel+bounces-102584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 124BF87B441
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 23:12:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 427EC1C20B17
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 22:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF67659B4E;
	Wed, 13 Mar 2024 22:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BlXdhDD3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20AB359B44
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 22:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710367940; cv=none; b=RMLwp/ho0yYUPJZNyGZK0Z7tGBCm7C+Es+esS6MZbfncH/2GUG1lIUkNxiUBFj13QL8as6WSxPtxzqzMUJ2QS847scFLqfGSLSi4jwhR8o9WbdmSRgebic9bEPY68X9PM3NapPP/w6vNUX/fH96n2VuG4tOncVaO4viXcS7rlns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710367940; c=relaxed/simple;
	bh=v0NYQJnm+0oPrrxJx2uQC72EnGbS1DFxIMODtPfQOTU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ArjQwiLA3W+QJYS/yWXszCXwNyHag1NqtWy6TySL+DyJcV+VShLdQSrZaTr+6ZuD5HuetX1+1vCBGKRHUUZf7ftNna27XbEpT+EXVuWEwANWWEudeFpIha5I4UD7uTsTuLnstbTkN9IvlHoQ/BHlrRjN2CxXFB7g8DWZi6ZMPn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BlXdhDD3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76FE5C433F1;
	Wed, 13 Mar 2024 22:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710367939;
	bh=v0NYQJnm+0oPrrxJx2uQC72EnGbS1DFxIMODtPfQOTU=;
	h=Date:From:To:Cc:Subject:From;
	b=BlXdhDD3PPIIA/ofOSBE9bH90AeexC+g1lLsJ0QBrJqmwOs4SPCtgBozY39KJeF7p
	 dvFtXGv4LkOWq/kpVQtmF1h4spvM/dmiwWiFlHwxVlqkW1cfmFNxGoXP8efEXsDOF+
	 xmWsafsKJJ9Bph6W8H/jEzwM5ybJd7XYZ/WFlBGuKPjM6mO8EfZSRCgaEIbV1agWhw
	 db6hr2GCuDa5Vi5jCLIjEg/H2RN97N9pHtgMbd1j2vsx+aoMUdVW8hEwVJT/Vq5x3D
	 jOtN6x/kqDj1Csm64t1JLvogcSo7wFoCL9yL15evecJY8LdIuZFe1mwckD695Fx/KN
	 bqsiTYkGpWQng==
Received: by mercury (Postfix, from userid 1000)
	id 2133F1061C36; Wed, 13 Mar 2024 23:12:12 +0100 (CET)
Date: Wed, 13 Mar 2024 23:12:12 +0100
From: Sebastian Reichel <sre@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org
Subject: [GIT PULL] hsi changes for hsi-6.9
Message-ID: <jp7jclyag7qcknwl3zryrerud2dlrcssh3o6oqexs6oe2z27np@g4aahpksii7x>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qvkdgkeszeuphbmn"
Content-Disposition: inline


--qvkdgkeszeuphbmn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit 6613476e225e090cc9aad49be7fa504e290dd33d:

  Linux 6.8-rc1 (2024-01-21 14:11:32 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-hsi.git tags/hsi-for-6.9

for you to fetch changes up to 3693760295e8c8a1a88cb3da5b178959b3cc7c75:

  HSI: ssi_protocol: fix struct members kernel-doc warnings (2024-02-25 19:05:45 +0100)

----------------------------------------------------------------
HSI changes for the 6.9 series

 * fix kernel-doc warning
 * make hsi_bus_type const

----------------------------------------------------------------
Randy Dunlap (1):
      HSI: ssi_protocol: fix struct members kernel-doc warnings

Ricardo B. Marliere (1):
      hsi: hsi_core: make hsi_bus_type const

 drivers/hsi/clients/ssi_protocol.c | 3 ++-
 drivers/hsi/hsi_core.c             | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

--qvkdgkeszeuphbmn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmXyJLsACgkQ2O7X88g7
+po4CRAAg3K0dgjj2KqGfCB83OjO0LG1iePBjOdEa1wQ9/sjlpvGY7eof540nRHw
9zz2Y4zkRqr3aBwFF4no28Ck0R1Rb7Q9idyXxcOi3rXxw53qxDc+PbrP4o7TX0NX
nN9X0IKz6w9cNk1A4cee8J4N6Rllac/1ENOE74VWwI3Zh76JB47Nh0viTAsJ3M8N
Q6K4mREfmoIcS+1P2Pprh46Xs/LGRb3oy5PHnVcoewL9drWMsR5Prf5No1YqCiPY
BfpCqCC5S6QlY3400fQ/l0+aR/na1fhQaepxHK9mBGSz8Lm6KaOXBYNjbaaCqJSG
tv6hF0wLhETMWLBwQ+V/5YgG5ihVTHPWXITp4/Abnre9OJqn8ei7qApj35PsNcuO
M+Lwnmgr+UGPoGP8Pn+IdHGvLKShLZnNffV/nsEBqJbQ31Re+jC2oZ+6LjBiSIhj
2g7NSnc3KUYFXYcLa3Hwnqhj6A57YFWehwtsI/KB34Me3J7Cy3l05PmVAfSjKdYR
ifIBSmD8SI6yJUvzYGUY3su2a+MKGEOKa/vP5zGtAojfOzjFVaYbsFsHcmRYv7pc
iSyQPfT4xdxuGBxvnbHR7M3gEd0s/wsTqC3xuOr2Cj2tyK1Y+ieWzh5c+kHRz3ID
39waJ4YpA9iSWnXcqZUF4pjYKMC9mGORzDe2V4uhupr+/OysH8s=
=P+X4
-----END PGP SIGNATURE-----

--qvkdgkeszeuphbmn--

