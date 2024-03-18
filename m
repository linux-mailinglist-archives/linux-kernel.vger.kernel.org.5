Return-Path: <linux-kernel+bounces-106757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71BFD87F329
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 23:36:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2D581C21520
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 22:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 669935B5C1;
	Mon, 18 Mar 2024 22:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="TVoMtnT/"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F175B5AC;
	Mon, 18 Mar 2024 22:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710801383; cv=none; b=R+FQbrAXB8XgUD9n92SqBIs3+mTidNi8CEFegBw2bePH1XZtGGqwD2UnJx4nsKSImdy3Ww4aLJb5xKCJ3WxCd8M5V3CvfzFWjhTR7O/wyja29S0U8pMeKTajMhRkrnLLL77bTl8GRvOc8zfW9CptGNu3FMzbmh5DGfY8rIiqLcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710801383; c=relaxed/simple;
	bh=wBJlp6WpiSjRbKQmWgBNu5HldpZlCqNkAYv2AfNBrzs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=Oly0E4VVxp8HOsVytcpCA0g9GTecpZjWAg13+oL+nkoxjD51ILixaKGGDTWd+PYj9KldDrNIeABgE8xktAe/x9XQSc4VBiiVUlNFeqGL/5MXGULPVwcJy1STVfzy4DPwvwU3GxBfNtMgJpoPqfxodzzA4RZIyNQ5Beox+uyRdKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=TVoMtnT/; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1710801376;
	bh=wBJlp6WpiSjRbKQmWgBNu5HldpZlCqNkAYv2AfNBrzs=;
	h=Date:From:To:Cc:Subject:From;
	b=TVoMtnT/1jv2Eo+WDC+8pCjmQB63kg6lHjeV2FSJoqjarJHbRPNXL7JXiZCyt1A8X
	 WNPnLmjqCxSRKDzVoRHrJsav/VvTpoYkeGUUuFSe6r7lfN8Z9jShSprTBJlbIoDqqu
	 c+1BXgpxiGLBdyLZzlvc1iqlDRmuLWAhHSIRA25LvBi84ZJOV8blqAL9XjGcsTqErj
	 4ptSBYeXV90ZLjMgQ6cVJCrwgzxUOnpYonWMx2dA+r7VXxL2X/24Uqh7VXBlHBmf+z
	 NbQTSezWhwWQ8gJZN+5gqWaMEAgEx6LCRw6GbVu3QiMsvbGh8yJvaIeXShgv7Q2W2N
	 hp+74aq+jWXUg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Tz8pS0QTdz4wc9;
	Tue, 19 Mar 2024 09:36:15 +1100 (AEDT)
Date: Tue, 19 Mar 2024 09:36:14 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: error fetching the clockevents tree
Message-ID: <20240319093614.16d6eb11@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/_EAaU7R4ChHel9j__5dWCut";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/_EAaU7R4ChHel9j__5dWCut
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Fetching the clockevents tree produces this error:

fatal: unable to connect to git.linaro.org:
git.linaro.org[0: 54.152.253.35]: errno=3DConnection refused

--=20
Cheers,
Stephen Rothwell

--Sig_/_EAaU7R4ChHel9j__5dWCut
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmX4wd4ACgkQAVBC80lX
0GyrCggAj+y3FNY+X0oyRpmEoWlNVf2qrRj8Mem7Ntd3wPoZq0HpQvumoun7CEqh
HFWRvuYvA54j/f1Oyd8jJ9CpMeUabndiSkJGYmUNEvpSKQJI/I5ZlAMKc7Fk64vK
gdh+c3pQsu+h7Qis57ONamRJ9BhV3K8EBrL46y/cGHg3xInsuq/2RqsjxHul/vwD
kE5AZ47ucwflaAXA5or+oId6+PqRwfYdrjJ6dJNkBacAcwLTtw/1UjQE/MEmUoh8
K9LW8TfhsZmrxhbUncGrSsbx/Edo82M+1Vww2n5XfzPIw8ZUJTIkSRapw3IgkzNL
6yo/pGT4j5JiG7Cjbez5E5QN9QZ4NA==
=agrh
-----END PGP SIGNATURE-----

--Sig_/_EAaU7R4ChHel9j__5dWCut--

