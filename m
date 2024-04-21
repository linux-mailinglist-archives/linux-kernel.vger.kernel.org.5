Return-Path: <linux-kernel+bounces-152622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 366078AC1A0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 00:16:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4D4A1F21016
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 22:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B20B4596D;
	Sun, 21 Apr 2024 22:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="gXD5d1uI"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4AFD2FF;
	Sun, 21 Apr 2024 22:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713737753; cv=none; b=AeHaVAFOLoeDb7scP6RrTj/O0AhJLat04Lmi79kHCma5ZDT5ipzcZCrAG3q1a6hE5aBLE9xKUPTMBYXvvlJmJKLtfzAzP6OcmbLvsjFOyQz1Ay+5pNJFxgzjjiUEud7aANoPl2OqWwsO/NVXkkErNKY4xWHJJsY0N/aD4Lqfkh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713737753; c=relaxed/simple;
	bh=mYlmLNyveG/Do2ZS5uksv7Q8izHLPftbzuOH78VrTaw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=fp7yzTDIpxwIqCqSDg9NTn1MoLgdYBeKyxXMEUDGpfPE1pdwLa3C30nVRbYbodFVjvT9eYefEJh/ODENzK+JTqdFcLnqIuz8YYi5DktLF22oEwrXgS8I/bkxMwg/iBWKLxNp6zasc94wLvGYXGr89QdHngIMZ5zCRc2IbSo4XwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=gXD5d1uI; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1713737749;
	bh=grY1S+GV4/5fiQPSI4/qdwzePb6mjgb9APw3uUOlPGo=;
	h=Date:From:To:Cc:Subject:From;
	b=gXD5d1uIUK2ltvQLY5c0BRQEcsh1LYmdsMkEZVHyMHWpk1vMESobNQXXzdZHuRvqF
	 FjxdjRfi0ROJg0omWcZByGv0DQuyRAcD1PMRPBG+OegWA4bQsMnDDC7zG2pDehSf28
	 i7IKBysrj+zdbgBAdtsBkeOcgsoiif/lTFZeD+VKp7ne2Md6f5wr7/fK7zb+Jw8Stf
	 9/lrWSR/GCVvoRgfvSJ1VQwFN1t4Hckyv6DenYD23ACPHCgzpYIxEE4jqCwAmvqA2v
	 y+xik9fObUlLsd9QaaajlNsPfeetnwMlVihUfkBV7de4i0EYfjMuOoPy+ooHCRHrKy
	 b/nzDX46U5uJg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VN2l86ZxQz4wc5;
	Mon, 22 Apr 2024 08:15:48 +1000 (AEST)
Date: Mon, 22 Apr 2024 08:15:47 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the pm tree
Message-ID: <20240422081547.7d75d471@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/2mWov6L/1T3YTV5TB80hoeT";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/2mWov6L/1T3YTV5TB80hoeT
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit is also in Linus Torvalds' tree as a different
commit (but the same patch):

  6711564863de ("thermal/debugfs: Add missing count increment to thermal_de=
bug_tz_trip_up()")

This is commit

  b552f63cd437 ("thermal/debugfs: Add missing count increment to thermal_de=
bug_tz_trip_up()")

in Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/2mWov6L/1T3YTV5TB80hoeT
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYlkBMACgkQAVBC80lX
0GyHfgf/fcggeuvS9JD3kHCJqONOrgXsuaystiFYAcR+bn2avE84a+17ZqKAS6nk
NKg1UbEk0ajhawnIQevVlqJ+fmlp34SwRxC77smD+AQ4CiJX/4tbuB0YGPZM0N3v
UuYnGUv5UJ1FIscfxKqdoyu/+CUqoxX1tNEFRfR+P3bpmw35zxwIrJQuGJSgQWi8
gCQd0e6HUzYWamF3cofvriTtb9l9G/G2T29CB4I6RlD0od6Bl0J6iDNCjOgUxlJq
2wv7dcvqFQI3CBb1tgNNtJ15fa539vRkYpAcZsj8gZC+DOeNw8pBaH+ESCOE7rPY
Ml+kn+tqGEU5i+UmoEW5pRVEm6iIpg==
=od87
-----END PGP SIGNATURE-----

--Sig_/2mWov6L/1T3YTV5TB80hoeT--

