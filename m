Return-Path: <linux-kernel+bounces-161579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D0378B4DF2
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 23:41:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E5FA1C208A7
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 21:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65831B667;
	Sun, 28 Apr 2024 21:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="j8ZumEVd"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7021A9476;
	Sun, 28 Apr 2024 21:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714340480; cv=none; b=M+mlg5YRoNk4I7T3F9j4AE8nabH3CijcbDOzRF83n8A/iEc2gS0Wz+mHAZrXUAsybcocx4I+knwbnlHBIoALg9EkAfsquVkDbwgmEjhce+HyCI6jrkseIAuXFFIiN4dZI2yLp3K/K1/2SpVamN4JydcAldBeekiXgbqpr+1n37U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714340480; c=relaxed/simple;
	bh=PcxmL3KNM+v+ems9N+o+Y3KaeYWXEzsU+RP6vNtpFQw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=Ux5/nuk/sgXssVVuL6ow7pRoe/0X7ffzn2Drrj77HQEet1OSrkWR3KiGk8uB53R1YFZdDTkpDIq/3UIRjO277WcSvdAourqcGeQtX6S79RhVLbhd4MpiGSAqli/Lugn8597s84OVeEbdbpQRBYxOJpa1yw0bM+wsXfED1I+0leQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=j8ZumEVd; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1714340474;
	bh=keH76kS6wEpyAHjKQwpvTh600H1c2QVVTFMnA/98kvE=;
	h=Date:From:To:Cc:Subject:From;
	b=j8ZumEVdza6dv9XKgJfIcZpFsIKZ6S66uFYrR4OMxsvneEOx9lG/M/Ky7KxKz4CiE
	 TVL6cffIARyBmTORUTXYayS6XdHVI//vl0Tyn+7rmP7E23QpuYEQD27tMettYYzwM7
	 F3yBK4jnicSWZB5ipAKByWNCP7Jqt1vOPU5ZfG3YBFqZ4EeLe4UNyz9mCiTBeSKoh4
	 VTg1XkWfEc7MnXMh+dlpYKXdltw2G6PgVLi3O5qTBRg47MF9DvJEtA6QwJ9pR3/KDm
	 PRvLSuJ9VoVVX++uJ3SUJiWQ20VyltKGlcVyvtcioKrjiJgth9nTdRrhZS/aEBB2pm
	 AvcFQo3vZ48SQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VSKf260sQz4wcR;
	Mon, 29 Apr 2024 07:41:14 +1000 (AEST)
Date: Mon, 29 Apr 2024 07:41:13 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the landlock tree
Message-ID: <20240429074113.2aa1322a@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/1VzHZMPfBBTBqkt.XG2nwB8";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/1VzHZMPfBBTBqkt.XG2nwB8
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit is also in Linus Torvalds' tree as a different commit
(but the same patch):

  5b5c05340e67 ("fs: Return ENOTTY if FS_IOC_GETUUID or FS_IOC_GETFSSYSFSPA=
TH fail")

This is commit

  abe6acfa7d7b ("fs: Return ENOTTY directly if FS_IOC_GETUUID or FS_IOC_GET=
FSSYSFSPATH fail")

in Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/1VzHZMPfBBTBqkt.XG2nwB8
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYuwnkACgkQAVBC80lX
0Gx2hwf9EEtrd5VCMIqyOYssQwufLZeCciDFkNLNUx9lhH/IZTK6mi2YL9fzbonw
RZVqNySa/ugIRTe06jcgo8cjppUiTZ4lL3Nb6BPZLuUa30eCKwlbDVP7mkXc+WFS
wpY6wpJUk0Dnf0AMUMji/3nHAiWBMA2mOWhoTG/Vlncj3c9MtC1fmVDAT8zi/XqC
n/Vwxr24mIqYePH95ra58VfzSkGpf6OLtC2ezubKRawCZQ8NPvtGFY7HuYqhQV0t
QgaAFl8GePOT2dwOJNBEVcNEM+awVNoeqvcVKbFModEyMBxdBntyO5ve1UFABLQC
gwkudqK2mRRCZgJn5aYnX/r+/ldf/w==
=2hgL
-----END PGP SIGNATURE-----

--Sig_/1VzHZMPfBBTBqkt.XG2nwB8--

