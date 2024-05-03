Return-Path: <linux-kernel+bounces-167204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 989AD8BA58E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 05:07:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5435E28194B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 03:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF1FC1C6A7;
	Fri,  3 May 2024 03:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="sHYypycA"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC971B94F;
	Fri,  3 May 2024 03:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714705650; cv=none; b=Xxlc/UB+cSIKcQ0zBHAsflmwANUh6Qj4XQapGrTzGwNIIskOMxkgsUqzJc2KGNfnpTnwNswJC/WbYsI6cuB/OmW3gQ6sYyO5Iq+hjaSLniLfxF/drTAfNzL6TiqgFXdiUChK7GJLE3rZNxnT6UycEPu/FcPwyAdBBc9Qdl1G5yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714705650; c=relaxed/simple;
	bh=1ovSMFPjVf4rAtNZlU7k9MxEOjjoTfdNVJR0BZDvZfo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=gCtqJP4qKqQl/SVsXwzzQN+NOfDJHjzECUFtxO9yQN3kVz9oA6qHi2Wb41OlvwO36zCzDWW9/S3cD4K9lea6UV81FdJ+9luJHSpCgmFqxzRuhmXT40wupEaeD6ONzYLtbfl5mqno3U+9p/pcl60zRKkZQ0FfVyzF5zGNnpLz9uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=sHYypycA; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1714705644;
	bh=KUL3yRs/PDKjGG2sJfomvJoG1R3xnVVXhftZbRvV2Yg=;
	h=Date:From:To:Cc:Subject:From;
	b=sHYypycAuEqpd9QGK/QqVh3cEqdUW7Yjbou6NnbS+3I3NvRv7XS3M+UCGbp1du5ac
	 Qg2Y7Yp3pimUQt2zpY0xspzsen4UnH0IcwzseweGUJT+qqrhXHZZ9G4kyVqhoC75sr
	 Kbgz4XajsUzbjbbZJg1FCAPSBeGY9JLR6HoVKOLxb3uEOwsSHmOw+rk74dl6GQilJs
	 hkL8SzfMJJJzASCOrBNU0CYmdoW0XQSnR6WcrfoYwMgUxhLesXj5uzd0poZ/7FjWna
	 d5oEJ44gb6ST2AIzoatFeo2IjyDo3J34aWKhvlA26NBknR7hqqBSt5kCfRxtLxJiFv
	 /8bXDCaToUpMA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VVwhX0c2Kz4wxf;
	Fri,  3 May 2024 13:07:23 +1000 (AEST)
Date: Fri, 3 May 2024 13:07:22 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg
 <johan.hedberg@gmail.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the bluetooth tree
Message-ID: <20240503130722.2390748f@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/iJo6q8CI4=aa4111X7mn/q7";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/iJo6q8CI4=aa4111X7mn/q7
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit is also in the mediatek tree as a different commit
(but the same patch):

  f90ac18d01cd ("arm64: dts: mediatek: mt8183-pico6: Fix bluetooth node")

This is commit

  7c9faab9d28f ("arm64: dts: mediatek: mt8183-pico6: Fix bluetooth node")

in the mediatek tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/iJo6q8CI4=aa4111X7mn/q7
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmY0VOoACgkQAVBC80lX
0GzNRgf+IoITW/T4PBpHgwBb/NTLzjSuDjg1toSBmQB8AQchEl2Y6CXj+551IDQT
ExYvWsjWysOkuiU3KyIpfgDZ6cJA4r0lhXVnQQ3rOpNKK9QDK60xQ3wMprfrb9oJ
iwCHmnNzJAZePgOhwYsRr5R5kVKyELkI3Ve88eyl5e3j9Pjj1i6GfcYtbaOHaw4e
Xlgozb8RgqzJ7G9gPC3sHHJRI4l8AHLjFWWmh/PcxgLzK9d42PymZCrnx3kGOpoR
x+WQon9vprFkKnOKk/21ohqe0OiG4YaJlrsudgYIhqQs0bD+3SjfpH48+An57d6Q
zNSB03oXvS+z8EjbqzfMe/0/4DV/Vg==
=7AYI
-----END PGP SIGNATURE-----

--Sig_/iJo6q8CI4=aa4111X7mn/q7--

