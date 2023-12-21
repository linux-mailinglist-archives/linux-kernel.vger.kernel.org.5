Return-Path: <linux-kernel+bounces-7676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F7F681AB81
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 01:01:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BF3F1C24203
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 00:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B827716401;
	Thu, 21 Dec 2023 00:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="KJ30+E3X"
X-Original-To: linux-kernel@vger.kernel.org
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0883FDC;
	Thu, 21 Dec 2023 00:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1703116817;
	bh=bpzC8D+KLpxF9XeakBLRcW6+dvOr86hJcQ6jC6JNzZw=;
	h=Date:From:To:Cc:Subject:From;
	b=KJ30+E3X6muJtAwswqJHu5c9dwkMSWsdlx5yurwssXsZX5neiYnnZ0+o1roKkFGOX
	 jcpSUt9J4llDxO/6R0fjIydwAoi5Z0ANTvHWg+03YfY1zvGMp6w2RGbZIsVne+D/k2
	 SpeY8PHspQCKEFBGUlx7WXl54wfv3GrqSUrVuU7VMpgxDS3FfkI1+pkvCr1XH930xD
	 84iOKvHi4ETpng/X/CIV580cdTPDIpfBCKs0cQX72NCIkz7U/JLWZdqabPapOH7AS9
	 wCaknaBLgdgRqEr+sl9YzcunYl2cDTiZHnWRsau2/xhlzszWN8ArbWUdsgCWHUbxcf
	 JSDFKnh60XBZA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4SwVtT2RZ5z4wd4;
	Thu, 21 Dec 2023 11:00:17 +1100 (AEDT)
Date: Thu, 21 Dec 2023 11:00:16 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Christian Brauner <brauner@kernel.org>, David Howells
 <dhowells@redhat.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patches in the vfs-brauner tree
Message-ID: <20231221110016.21168260@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ca=k/4zVqJp3_XEr/RZHzWd";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/ca=k/4zVqJp3_XEr/RZHzWd
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commits are also in the afs tree as different commits
(but the same patches):

  a6654861bcd3 ("afs: Automatically generate trace tag enums")
  66ea28c510d7 ("afs: Remove whitespace before most ')' from the trace head=
er")

these are commits

  88dc7a203f2b ("afs: Automatically generate trace tag enums")
  96a98801cbf3 ("afs: Remove whitespace before most ')' from the trace head=
er")

in the afs tree.

It looks like the afs tree has been rebased since (part of) it was merged
into the vfs-brauner tree. :-(

--=20
Cheers,
Stephen Rothwell

--Sig_/ca=k/4zVqJp3_XEr/RZHzWd
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmWDgBAACgkQAVBC80lX
0GxrIgf/dz3MDki83fc6mAHgfChbqpZDBpE79icbb6mYWdk9Wlbt96RUd9WCBwzI
fk3fwINmMKHap+V2kb8KdGeMrjm2m0GtrQ6z+keGcaX11TiL9OzwPYYkndIwTzOb
MEL93C6RHLIobihH/4yCt3WaY8VYcagMCi0q0G2LpFLCv2VFIPCRJXDjngJSKK+W
MzUBq6U4goFa4a1J3wnD6xgUgKrzDWuSGJccyjeK8bg0xcHwnmjkqeDV0JCtQcXE
i3pTOzZD5kCObpX46GqiuHvRIcOJOSm9YXrjjBKrfPDNx6HBqJPdPgtriL+1eIIA
QMAxu6lSzDWolc3+XwufrYyu5Jw57A==
=llwN
-----END PGP SIGNATURE-----

--Sig_/ca=k/4zVqJp3_XEr/RZHzWd--

