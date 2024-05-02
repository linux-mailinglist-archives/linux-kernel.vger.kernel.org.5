Return-Path: <linux-kernel+bounces-167019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7278F8BA379
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 00:50:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9F45284ADC
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 22:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B03501BC57;
	Thu,  2 May 2024 22:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="DMka/n/c"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333631B947;
	Thu,  2 May 2024 22:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714690218; cv=none; b=npo9/xRnygNVteyK/tRPo6oKm60uGfhZuffmF6Jk0zy9Ic6XNrqEYLyKjAGzfo5WbUIN2y6g5TiH73Zma9CXIJpb+h/Sezr9e8bI1/bkZv8xkvPvjrkYiez7/qjjyA2SaHFpU3iPsA8/5fNmStEPq+Xs7XQ8YG656/xUAATecC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714690218; c=relaxed/simple;
	bh=pSM2vhex3VBgefl7WQTUvMktZ2mdr9pHWUp1yBiwejY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=t+Pjx1+EcFx+8h/0c+S4nFfdsMb/1Mfbs7Mh8EBnVFm/JeYPvJHBSkRPAyffOaur/DjxcBsMsYqiOV52UTL5WWQvyVxpbtjSr+TUiBFKw8NAG1WxcRD3nAbzSINUVjFIWeri/sSwIspjxvjRHZuwz814VrJ02cWhbjPWLe6njG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=DMka/n/c; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1714690213;
	bh=uI5hGZzVwSZENNno+sCdAGJoMSDIrNofVkrglPrzHVE=;
	h=Date:From:To:Cc:Subject:From;
	b=DMka/n/cv+gZXOT+WT6ZMYgCjoESv/fXNWk82LPZ5V/eOtfbHZPQ4AdL2JCVZCssP
	 4q+XXA25I7lySPDml83cXmfihghcBE0zPZMTw1G0wH6qbZEzEH9DEz2OuqyUlHTJJO
	 bBWBxf0cQMlx4cGMqSdXsSgx+1I3/apBFa/8v4d0/xitI56rwqtfzp3AowrUlhMv2Q
	 ZXgvjm4CvOnUF/xyACSpmDQz28vkvqymzf6yoCNIiPWdLcnfc5R0cjLaXKkjJrS0+b
	 JHo6bTenXw+TaazSOHZGvsxxT58hPtz0aRxQ3o+njGnwtxu+dzEK5JgD/3hSxb2i3V
	 4g3TIjLFvKetQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VVpzn4jFpz4wcr;
	Fri,  3 May 2024 08:50:13 +1000 (AEST)
Date: Fri, 3 May 2024 08:50:11 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Alex Hung <alex.hung@amd.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the amdgpu tree
Message-ID: <20240503085011.1a0cb036@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Pq.zhqxELbMZUKJUJo9fX_k";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/Pq.zhqxELbMZUKJUJo9fX_k
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  8891fd6cb2cf ("drm/amd/display: Assign disp_cfg_index_max when dml21")

Fixes tag

  Fixes: 03e611b7b65b ("drm/amd/display: Limit array index according to arc=
hitecture")

has these problem(s):

  - Target SHA1 does not exist

Maybe you meant

Fixes: 55ec7679e6a5 ("drm/amd/display: Limit array index according to archi=
tecture")

--=20
Cheers,
Stephen Rothwell

--Sig_/Pq.zhqxELbMZUKJUJo9fX_k
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmY0GKMACgkQAVBC80lX
0GxV3gf+LkGWYMBMHIhZA5r99WsPgMSJ8561orAd6F6gGTxZPFms+jwjrPWk959b
UTghOfet1YlGx7Ke3e5saQAm2i9WB4Knruyu6CJItKYC/0SPHGpAIxWYtLdLGQ+K
8NkdGhLrLqZrt+8twgSLkFx/JiVBwqLdytqbg5tnhWx3moIGRTavYRWyuw9gZd7F
oDD/NDtdNKh9iJBMdNjNjyF6GIluxe0WnNvWDVQ2FTG2wzrPVU9n9TblJZNAPlDE
etXowlpqMxIEN5IOMu3Bq2VtJIFqDb2o01UabUVRoMTYXrmZDw4agzHYlQ9zl1Uo
roO/hsaP70cnc9s7nFLSCGdsfDoO0A==
=rD0J
-----END PGP SIGNATURE-----

--Sig_/Pq.zhqxELbMZUKJUJo9fX_k--

