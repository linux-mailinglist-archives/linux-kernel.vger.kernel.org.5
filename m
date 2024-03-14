Return-Path: <linux-kernel+bounces-102739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E5CE87B6BE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 04:13:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CAD52B22C41
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 03:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A67548BF0;
	Thu, 14 Mar 2024 03:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="QJKclvAK"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4839B610B;
	Thu, 14 Mar 2024 03:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710385999; cv=none; b=lxD8zD5SVr1wiM9g7HPMubgqAojD4/WYbey6RwqmsZPmp7jpcPXV4gEI8iAUcC+PAdNUzBMUV3/LctTOQd4MtbGP8p03Z7+J5EPnF9TUHwtkdMwARnGvRTed38WLHaYZMFHx3f9S+uItvvottYdFipqH7W1nvua0rwzm9kwnwog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710385999; c=relaxed/simple;
	bh=NflLt6tKf4JApDvVn8J3pIjaZ2HjTe+epmzhwM87VjY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=o5so3Yr29Na0PwdiyLV/5XXNgagyHT6enTgd6ekqWTaH8qgwUi9SiPXR6l44NUqxo3sz1qiXE3XbcuIstMQnl6WVF2OgY3I1GXqasbkBl6jg6OFyx6REG1mR+r3IgW7ehGBRY2w+kZ3quwa1p/FJgmbOp3yOcUOGIUdb6D6LdwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=QJKclvAK; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1710385995;
	bh=SccatQXnV3M4Xu804DKsyt80xuaizav53tleZ0A96O0=;
	h=Date:From:To:Cc:Subject:From;
	b=QJKclvAK2VjJiO08KUgGnACq4EZUNw66Gju6ncEh8bMkF3kPIgQXv68n2fPaJKwQa
	 whBSrvwkYeA2MR4vRjZFHGLyKSkggk+XMX5xeMl18eo67O5teO8mbNvEvcZO1TJJmF
	 lhypgwK7fFU6qG+C5dAsxssqBfnHYeN9LyYjlX4ENqS0iLeUyzlNvAWf1yZvo5N7Tv
	 08CDqls7P/fmdPVueHRF80mi+GUC3Yg1p27Su3sn+xrdpTeKwk9/qf1LpsNS1FEWw0
	 QwIttIZNViKVnnaaJR6kQyeAYGNkQdA5uA79xfJGuJb/tZQW5bXWVy1rtdUcU2tX+T
	 L4y/5wLHN73YA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TwCBL5zBjz4wcQ;
	Thu, 14 Mar 2024 14:13:14 +1100 (AEDT)
Date: Thu, 14 Mar 2024 14:13:13 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Ben Cheatham <Benjamin.Cheatham@amd.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the cxl tree
Message-ID: <20240314141313.7ba04aff@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/RxOGXE_pkpbXcT=dc2AX_PY";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/RxOGXE_pkpbXcT=dc2AX_PY
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the cxl tree, today's linux-next build (htmldocs) produced
this warning:

Documentation/ABI/testing/debugfs-cxl:38: ERROR: Unexpected indentation.

Introduced by commit

  8039804cfa73 ("cxl/core: Add CXL EINJ debugfs files")

--=20
Cheers,
Stephen Rothwell

--Sig_/RxOGXE_pkpbXcT=dc2AX_PY
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXya0kACgkQAVBC80lX
0Gwp9Qf+M7S91REgb8U9ffJIKIhDoAd3QWd/5GxvUuNvPoPNXmIy6zcXnsmAeRar
hZ5hhWOinRsKJ+2nn1qUBE6Gu3QTTG+oCKTkpbxNsO8cmmKlCpQe02z+4vb6Mv2t
smPQd45IBpZdYgOhkCmXqRqIEfq6CRvaIlf9WPv0ubUTPVgSdrSsOxzdDxKStdIf
/lfDU/WyzU/9Y8wy7yem/mKXdWD20BSWNBLH6hQpYpxTT7P1mjXl7+iSIyJZNg5p
bVYT6DuvApXVu5Pidgt8UykpwIyhdk0JNwAj8l3E1iHM/EZ5MZUKGLFv+ysnytVi
cvDgxGATckgoErtRvprY73e+NTfa2w==
=FhJe
-----END PGP SIGNATURE-----

--Sig_/RxOGXE_pkpbXcT=dc2AX_PY--

