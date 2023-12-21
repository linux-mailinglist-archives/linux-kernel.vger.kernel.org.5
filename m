Return-Path: <linux-kernel+bounces-9099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D58D81C070
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 22:48:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F2541C2202B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 21:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADE847764A;
	Thu, 21 Dec 2023 21:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="r1sNB2RK"
X-Original-To: linux-kernel@vger.kernel.org
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA4255E59;
	Thu, 21 Dec 2023 21:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1703195269;
	bh=QW6K9I5GRmra/INHSX8phU1RLjZ/aDqVjMaB4iNs/S4=;
	h=Date:From:To:Cc:Subject:From;
	b=r1sNB2RK43ZlkFUSLckaBMxvimCo6iyMRTUZToMEmeMHOesBHk6hSjvJxsQaMH3KY
	 JA1MupjJ9JcWhta2NH0pUh+tOoiFdePGWPh0Wt0rnY5iGW9jVWJ5HeAa6lGVD0GBNt
	 23X25Bc9Kvd0ZLWWYK8Vi7dGz4gQhzhbBm6A4sfl1d/iHoYP5cy3rTS3YV8VnqxYX+
	 kPWn1C4FovwArKRnivn22PeztMwYhtsm29cXLYyObQ7qxieYT9QQIc/UoxO7PxscDv
	 lGffG2nZ9xLRr+gETRozdBdeIhQx4JVprpeweuHlQ1w2tnIqVwSFZHmN9CuDv0fvMq
	 bK3pSP9hJuqDg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Sx3v92Bcmz4xNG;
	Fri, 22 Dec 2023 08:47:48 +1100 (AEDT)
Date: Fri, 22 Dec 2023 08:47:46 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Peter Rosin <peda@axentia.se>
Cc: Vinod Koul <vkoul@kernel.org>, Jan Kuliga <jankul@alatek.krakow.pl>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the mux tree
Message-ID: <20231222084746.3d9dcb90@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Eg0eMuR4EWDkVHafv_4CPkE";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/Eg0eMuR4EWDkVHafv_4CPkE
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  2e142cebb164 ("dmaengine: xilinx: xdma: Rework xdma_terminate_all()")

Fixes tag

  Fixes: 49a701d8dc1e ("dmaengine: xilinx: xdma: Add terminate_all/synchron=
ize callbacks")

has these problem(s):

  - Target SHA1 does not exist

Maybe you meant

Fixes: 5c392d106e7 ("dmaengine: xilinx: xdma: Add terminate_all/synchronize=
 callbacks")

Also, please keep all the commit message tags together at the end of
the commit message.

--=20
Cheers,
Stephen Rothwell

--Sig_/Eg0eMuR4EWDkVHafv_4CPkE
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmWEsoIACgkQAVBC80lX
0GxGuwf+M9wWUbB3i0dhU1FyEWeparAwkQdoSIKgTFY3+TQtIq8WhGV2Me9GQ5Fv
Yoxbic1ZwhivGgSwFBxZzf9x0iI0IYZCk7F//BGXweAIv3gsvBDTkmjp8w7jwE7+
5HXQ98H9XS9CPV2KLamgZX5DRAX4t/sMaGtK7VPqcm2JcbHhJwC7isWHiAYIVG5T
saY0W/h74XWQKNEaNECJg7+sl/tA0fxaTqjWLyaiKsOkzVzDAEqD0HARLaYjCUNW
lXWaIySKbEB1g0NkSN9q7w1H+9u7b7tnl3BoBEgOdY+Z3dAAEnvtrRF0TLf5cXGE
/2KYa8Y9ccDAhJH5iEcL98lqCSg6RQ==
=eNz2
-----END PGP SIGNATURE-----

--Sig_/Eg0eMuR4EWDkVHafv_4CPkE--

