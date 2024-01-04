Return-Path: <linux-kernel+bounces-16223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB01E823B00
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 04:11:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 268AA288440
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 03:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44E38525D;
	Thu,  4 Jan 2024 03:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="ttiwR0w6"
X-Original-To: linux-kernel@vger.kernel.org
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 301B15223;
	Thu,  4 Jan 2024 03:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1704337881;
	bh=9g4Tr4INbzmrWdVTUlA2qZox3cTiBSg1jgQ1KlUSeBg=;
	h=Date:From:To:Cc:Subject:From;
	b=ttiwR0w6lkSFErfYr6hke7NMBVqPn5RMYw9lLFcHRNarygpw9nwa+VCVaZLWC9h12
	 L4SqpwYmUZiQrsL1YWKmI8fWHbzVdJAop/YCT9k+ubjF36n+lgbsfaYwqDpK6vd66C
	 bu3x9uYqSaqAT4BUt5heeCUNhPWeb6NQDBtNioisIt5IrdcsGKG7Z9qG3rnLycmf7u
	 lAVKfQqP52ogZR2qcSfQjUPAF2S3omW4Mhe888v1BGAxZ1E4cQhlQcXFp35wcVxBf8
	 UFwB04/ErsrkSUxWzJUFJf5UO8FPTEXJeMdQjX+DW7/TiZkpfASQGAQXSHRRNR6+Du
	 UtpBeK9tPOhhA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4T5BST3HNTz4wcd;
	Thu,  4 Jan 2024 14:11:21 +1100 (AEDT)
Date: Thu, 4 Jan 2024 14:11:19 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the sound-asoc tree
Message-ID: <20240104141119.205ed261@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/9Y1BO=p_h3YeyzwubdY6VN7";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/9Y1BO=p_h3YeyzwubdY6VN7
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit is also in the sound-current tree as a different
commit (but the same patch):

  ce17aa4cf2db ("ASoC: SOF: Intel: hda-codec: Delay the codec device regist=
ration")

This is commit

  c344ef36dbc2 ("ASoC: SOF: Intel: hda-codec: Delay the codec device regist=
ration")

in the sound-current tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/9Y1BO=p_h3YeyzwubdY6VN7
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmWWIdcACgkQAVBC80lX
0Gwz7QgAnsfz+LgdknbgXsLbF96MIC2couRCodtaDCZvTifLSm9oLccT4BHbX40Z
bGCVZLMp+enxWeDboCx2bclfPisDhvDpyq4vmFLbtBWpKD9qXrwg1vYkNHpGDK90
TAsVUuIwuwAhMqceFGEiJRFAy9EbOHexHB+5p26uwOvHqk2nxv2eIrfR1bymjdCq
u2C2Fnijnwo3pm346XLPzeY+/+ENJWBFHhX7TZ6YxNWtPZrhCW8HRxm6qzAC64FB
ftYAU4KkAArMI0lFvyMmzlhLqUM+iD7xi3jh2PGZCDt96JIAximDqERgE+VmdSpL
fvVD+SJ1oCazn1PfLREZOaXJmUKCgA==
=FkF7
-----END PGP SIGNATURE-----

--Sig_/9Y1BO=p_h3YeyzwubdY6VN7--

