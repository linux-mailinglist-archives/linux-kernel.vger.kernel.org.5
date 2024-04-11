Return-Path: <linux-kernel+bounces-141675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A6698A21DE
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 00:43:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE00D285D51
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 22:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E51F46551;
	Thu, 11 Apr 2024 22:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="jW2k2sHO"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1105205E00;
	Thu, 11 Apr 2024 22:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712875398; cv=none; b=qwsW9KfHSfvuWSjPgR6xQjF06Jrz3hFL7C04HAubksLPqcLIsTkvf58n4yeel0RgVPerRrklgAWEeRx7HIgSsxNR3Oi/jxmp/tY9USVHZDVyqTBPDFwh1kRT9tRMJsN6CNmIjZkkR6GRZ/WvPnMPBvFUzCtJDXSkfFyhCRIwF1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712875398; c=relaxed/simple;
	bh=PHbwqL/xBBdf0TLYMzxV5KdO4qLjMBjbSpfOHVL6tLA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=qEiTNgBQEYPbf9wkHdhKfLHJdOwvedApRpB+sAqc9V5MnhkbYaIJKkDDGyM8opjn2E0AUEbportH5na8jQ/APqeBdPnTk+/AYfi78JBEvngnkTiwg7+pbJehnBlOnTzooU9bl+pQzyIxd7KlJlaN//WW9FDhRG4tyvE/dE+u+2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=jW2k2sHO; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1712875392;
	bh=l6sGqsLkE9VvY8OPheWWPPl3KOp7bzJWio9ew4U591c=;
	h=Date:From:To:Cc:Subject:From;
	b=jW2k2sHORZZPkeGuVaDC2srfWSaAWGtAIWexg9Os3WXMombNRfGC2NscXnZzhZMub
	 8gky0KjFPHkffaD5m1rPm7cW0jR3pZOY6FgtAjbZ8TGSbzURADViNg2mS+k2Ig3uLQ
	 SsDjMktXxzg99SPmWJhsd6ETIi8DKkFANaS13wgCMt2M60yoIqWuaQVw2uaUaQnBp+
	 N8XJ1Z/cl7mtAW6uKKFxFuatA8GJNYp1FNJdwQxZWYiSyZGslfMmLnSC17+FJ0vgVS
	 srEqnGfX+RDmH9+D8Ul7Rkcr6s2n+DDTAlYbS4alexWdjkDWnRA84btp7sOclyJjpX
	 tlkNQDKcyek4A==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VFvqN3Xr9z4wcb;
	Fri, 12 Apr 2024 08:43:12 +1000 (AEST)
Date: Fri, 12 Apr 2024 08:43:10 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Greg KH <greg@kroah.com>, Michael Ellerman <mpe@ellerman.id.au>
Cc: PowerPC <linuxppc-dev@lists.ozlabs.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the driver-core.current tree
Message-ID: <20240412084310.035f018d@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Pbd5qS_hA7P5TURchJeP+18";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/Pbd5qS_hA7P5TURchJeP+18
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit is also in the powerpc-fixes tree as a different
commit (but the same patch):

  156539fd6501 ("Documentation: embargoed-hardware-issues.rst: Add myself f=
or Power")

This is commit

  36627111b568 ("Documentation: embargoed-hardware-issues.rst: Add myself f=
or Power")

in the powerpc-fixes tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/Pbd5qS_hA7P5TURchJeP+18
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYYZ34ACgkQAVBC80lX
0Gw6eggAkf8O7uzCnhPw8CaP0yOZTph3HcrxefYLKfeFEmQU5VAow3gd61FRh0IE
5qz+8neJuwW9Wac0qgvgilJTD6Gj17250gkg/c8AEqCXWcCST2AvNIdGSLJKs9Hx
hIfIgr4LdbElWdKQzmbP1np2H2Ya1RROD8go5U/KHkRcEQRXge9GoOWsHWYqbCpk
hgcP+bmvmFXvqHGDephq2Tk91QaZz8zdk1PbWxZNyorb+DG3ZhbuwTDEV47SLwsP
sAib5wWi/JzdNKtcyaqxWuKJ9EL27TWdI3gU8D7fH1ZgFbkf9OhKZ8TwxtRriSrx
H/YR7H3IXoK2GGYXwNhZH+8aRPPgLQ==
=bYQM
-----END PGP SIGNATURE-----

--Sig_/Pbd5qS_hA7P5TURchJeP+18--

