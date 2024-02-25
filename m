Return-Path: <linux-kernel+bounces-80301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A9866862D16
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 22:11:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD113B2110C
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 21:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F7441BC36;
	Sun, 25 Feb 2024 21:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="XgwhQ4D0"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2AD16419;
	Sun, 25 Feb 2024 21:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708895442; cv=none; b=W0+ubpDZ4Qw80pVAsNZmKEl6YzpejyEWuoIgGhAXKZ2hVZBrYdwYlLowQ8PlM3bnyIJWnkHyOWfjVEs23nMhB9kMXIyJcJbZ9oMp/eLed202pOTfDEnX0APlq0zQHK/ZaGBHcOR5p/N7CrzN1DU04M6QBFeTpP0E1ozOTGojjNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708895442; c=relaxed/simple;
	bh=a7tRdO/9yiHdSWBHV0X+bWvjxM8vvUwK2b9u1/WLCIE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=QjWIPF2VjwgP1ajDTMg9OYUqVDAx9d/vhKPb+dHEq0Gzh+Rj1TS8Pm04CPeuqcxxF+fH9+tX5LLOy2OSIT5BlgZr59LoSSmpxDS05Wi9BnLP0FblbPWS5q1n9UqF7gaZv3rP0oTYIFPOeZmG/S16QpHTdjGnnpZKBZjKVsj/mzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=XgwhQ4D0; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1708895438;
	bh=I5XBZ5mgeRYO6WOXx2VTV8dKiTSr0WKSAmrGJ6K24zM=;
	h=Date:From:To:Cc:Subject:From;
	b=XgwhQ4D0NZsVZYvYP4a8JA7/MMRqrUlqPj5ELlLC9jUk9zQoJGY2gq9rgWcF/yfGG
	 WQUPD5F9XRzZ2Vf8WKJhjMHTBpD/iwUzwdpKtbKR4oY7kaeZhR4hjnIxofjQ9ToCPK
	 OTNUdbJe0r7ZCzpY6eAIQ67ezHXlr8Dzv/ZPtSlLkRhI9GHbRGGe19ty/fk4CV4AzN
	 h8z8CpBzz1/aFjb6Qo/llJ0BMoQZi53QmwiuIyjYp+37lUls0GZqt4pvsHFSf3bJH3
	 j+kQ1jM7bLAkjAJtssDrYV6jg6cwVvakjdryuyxWUH4xBxFD1n3sKqNsmoSdjZhP0j
	 cw1xuQkvThIew==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Tjbxn21gkz4wby;
	Mon, 26 Feb 2024 08:10:37 +1100 (AEDT)
Date: Mon, 26 Feb 2024 08:10:36 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andi Shyti <andi.shyti@kernel.org>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Linux Kernel Mailing
 List <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the i2c-host-fixes tree
Message-ID: <20240226081036.0a24b5a9@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/kczoh9O.lBiFVGP.ld7yEv9";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/kczoh9O.lBiFVGP.ld7yEv9
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit is also in Linus Torvalds' tree as a different commit
(but the same patch):

  cf8281b1aeab ("i2c: imx: when being a target, mark the last read as proce=
ssed")

This is commit

  87aec499368d ("i2c: imx: when being a target, mark the last read as proce=
ssed")

in Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/kczoh9O.lBiFVGP.ld7yEv9
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXbrMwACgkQAVBC80lX
0Gy44Af/a8n9tMFjoFGBbzhV6FSrUTZbYdta8LH24Pp2S1mzr4YCjlDQJNWot/fo
sX08K1/uIEVYncnjfzObKxeRBn6dXjBRRWIAbhj0Bw9i97XP3HgmorSLZVXYJohk
WMju8WsjC5mteZgeTPsCgLw2nx6bj2KhlN/GLcEf/3rHVott+uo9Cm8YUanhyVdZ
Ry5QlETd7Ac8dyhbHZj4zwmlPo/qUvnJT7fWh9fYbT1QzDfQCb+nglqHNHYm04WW
mElOKAXY6pBhOIQx/QHEI3r0XaorctIEHgQImfZcEISH05X3MlywP4pi+pNIKXNx
gQeR0laPrU1PWVd23AwUv6K02IDYrQ==
=2Cyj
-----END PGP SIGNATURE-----

--Sig_/kczoh9O.lBiFVGP.ld7yEv9--

