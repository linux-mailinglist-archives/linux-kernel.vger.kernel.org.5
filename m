Return-Path: <linux-kernel+bounces-164939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E48668B8544
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 07:17:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75370284603
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 05:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8576A44361;
	Wed,  1 May 2024 05:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="OT71XiCW"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20871D68F;
	Wed,  1 May 2024 05:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714540614; cv=none; b=iNNBkkUZv6DAKz3MjLFaIeanyXLR8u/56wUtfJAfChWSxCcQU+Xo6MdlN57kv31d8x+9sEQv7LUnerwDrH0vCUB8Jwfm8UNkfG2dWNSOj6sD3cY4c9u9wsRpfqxkPAoVh12A0ArboQlToG99/WjNq2osJGHs/2rh6tKkdHodXtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714540614; c=relaxed/simple;
	bh=7A6sJY/a61zFk3jw04VSruoJTX3tq1XA9gEuQpzPB5U=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=YETKIp7pPrCG+iDpJIisySFNPl4R1qSc/JPdWa2lwyICQ5iwqKVzMYY5YA0Anzg92/C5pixKHj+pAPVIku0reGd/NB1zHG2UGRGJfWwJt/c9sBDBJdCjDAkYGnI6VGDiokRiqSH2XrA0bNKvc6nTm5Iowl3iHaw+XUkbXOBabLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=OT71XiCW; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1714540607;
	bh=FJFn14SYejNiIAAK7ADw8KLEx9XqaTWenC4rhDOfxOQ=;
	h=Date:From:To:Cc:Subject:From;
	b=OT71XiCWZ74NvtkVpUFELtQCFwyCNAyXMI+0HtX4uFryeofrBr/WK0r2wZ01Ep2Fr
	 HYYENNGgKwgMVY6lsjKPCGBNB0D2Nqdz679RYFOtaXE4TLXMe+R8KQLcZDvCksQVZi
	 322ccksfp5t70MAHmVOjZO7UD/BE+Wak+ZUat0cBqiUPNCzq217qAz+zBuVOv3o8TL
	 IQ9OZFdURLK9QtiTeTdJoX835V910m9XRiFB5cZDmy6jC5zikhg4TcBY93MsZmBRMl
	 LzZ1WniB3A3dmtejQ62aQbFVWLlJgD8+z4j793ipE/wNlACddDTLMC5+Vy6bnRCutj
	 o5zYWQwipSkdw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VTlfl4rzlz4wxf;
	Wed,  1 May 2024 15:16:47 +1000 (AEST)
Date: Wed, 1 May 2024 15:16:45 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the bcachefs tree
Message-ID: <20240501151645.281f1b07@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/LM8eP+xGV/iJMurorRt9V+U";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/LM8eP+xGV/iJMurorRt9V+U
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the bcachefs tree, today's linux-next build (htmldocs)
produced this warning:

Documentation/filesystems/bcachefs/index.rst:7: WARNING: toctree contains r=
eference to document 'filesystems/bcachefs/CodingStyle' that doesn't have a=
 title: no link will be generated

Introduced by commit

  78b8f7949d02 ("bcachefs: CodingStyle")

--=20
Cheers,
Stephen Rothwell

--Sig_/LM8eP+xGV/iJMurorRt9V+U
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYx0D0ACgkQAVBC80lX
0GzNCgf/XyS/OLHMf1rrgvWSiw4J3cD7vEbaqmz/R/8f6oGgZC1sfzt/XFMp+4jD
BqIsz2RVORIz7JS+6d5PGKOOxelyj5CPK+u13WNB83KhuDglNCocFyJ+TQ4PpnEW
r5XBxy+mAVka5kAsWMBvgiZCA27LrsTZ4vSkIt33KV8cjB1ftMNn/zxXC1nsd0ow
j4+DUDpaZvKgqxDFy+Zh4V/0EnENQLhniAdIRdIenMmi0xEJox5zhAL/crac4Q6E
FGwzjf12w0wQ4MyU68/Vq1BGtm/sFrW/QOBa5ISfQsB9pawUzNZ79kVJ7iDzsfAV
uD2JWIFsUNe8h7bp/ERn/6+/u1DyfA==
=Ealc
-----END PGP SIGNATURE-----

--Sig_/LM8eP+xGV/iJMurorRt9V+U--

