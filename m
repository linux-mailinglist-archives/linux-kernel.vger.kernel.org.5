Return-Path: <linux-kernel+bounces-31992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9390A835501
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 10:31:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 483C9281E72
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 09:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AB83364B7;
	Sun, 21 Jan 2024 09:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="H/4rsipT"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95CCA1368;
	Sun, 21 Jan 2024 09:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705829488; cv=none; b=NL9IcxrRhzcplxqHKJoUy4+VoeTkGrg/OfCgZer14HbIdf8NbMXQQKi/YfN4kCwvenbiIl9pS/tX+2ORf8n/cx9y+lxbuXgNrMNxkl65Y959kkM0WoCV3iaNX5OCZg3+pqGoLEYCVTq9Xww9kzNJDtxtumiULf8plOiIE+FflKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705829488; c=relaxed/simple;
	bh=VY3OyMNDNsHZf3p9P9MUDJwwCT50XksAKmNfRoKhrmk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=cpZy6C9JyuVEtzypE/frInwcrogZU3Xk/be0CL9eiRATXeueVMbM4gipcUvDAT/Xrd85py+2a4B28t9G33KY4LZH2iAq4lKTluPlvBhW3nvdosjP4TdUnSFJKZMXr1ArBkwqr8zAEQAeEATRw1E0gTFa9zk77IFCP3gn4pOEszA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=H/4rsipT; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1705829482;
	bh=b+/JzsWBY+5zAsUW3xzD2Rp6+iWECq6eJUjIfK8w1T8=;
	h=Date:From:To:Cc:Subject:From;
	b=H/4rsipTEJapQSvIRnjkhQgU73NyzXVZCJz4sRTkYzR9/mGiL5f/cHH6ZOAy76Ucs
	 bqmQngMGWzlhESBN9Ffg6jeTfeaclSebFmZOhKCKr77UdXwGsCTCxluiZbzVSidUk1
	 zrA2RUWzWZjg73fUBCsaWUNVEogIhhN2J++U2Dz85raBxDGES4sLTw4+g7nKk0uuJz
	 bQ6ERVxkNEVpvvAxwEQF4ct/vuhG3iKFhXKQwyJ1FxNeRMbXpbJqblvVNBK1FjYQIf
	 pnCM0uITnI2JLo1FVK4d/msMhTsKBWSRXgYg1wfiu0MHeTDN3h7+oCKDR7M/pHZ6Rw
	 XrwyNqqVYU55Q==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4THp562ptKz4wd5;
	Sun, 21 Jan 2024 20:31:21 +1100 (AEDT)
Date: Sun, 21 Jan 2024 20:31:21 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patches in the at24 tree
Message-ID: <20240121203121.78bc19f7@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/wm6OHxuk71osJq.rPDPufxL";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/wm6OHxuk71osJq.rPDPufxL
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commits are also in Linus Torvalds' tree as different
commits (but the same patches):

  c692086d74a0 ("dt-bindings: at24: add ROHM BR24G04")
  ec74a1dfcdd1 ("eeprom: at24: use of_match_ptr()")

These are commits

  614ef4d30fe7 ("dt-bindings: at24: add ROHM BR24G04")
  2b0eee4f6add ("eeprom: at24: use of_match_ptr()")

in Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/wm6OHxuk71osJq.rPDPufxL
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmWs5GkACgkQAVBC80lX
0Gwe9QgAmC6HpySK8gts7wv8+oy5TPcwpTA0I1gZr3oHdcnRpXIg7UkJC+Jf2zYn
Qiu1gMyQagBplc1dQZ/Dn4qY1yNfCcwTrZzwdO9dE5SrRFbeiiMPmQVVQbB2u37z
kER/S+ev2UBAoPaU8rfPNxI4IyhPo9AbN0gTrKzIkNv/JWziIPRF5bVWOEISk0g1
+GB9wG9M1YzBlYJfP8IY1EvwGUZj/3PgtFJPkLEZh5B0KRJBmJUXPqMDm6UUSu5d
rWWGPw4qs+31VBuplmGECzGrtextosH/hXpgJ99JGTO9jo1oPzgDQ40FM3o7VkPP
tko3Bvtj9qsOVoODF9NZZdTe5bjs+A==
=PI7N
-----END PGP SIGNATURE-----

--Sig_/wm6OHxuk71osJq.rPDPufxL--

