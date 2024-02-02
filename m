Return-Path: <linux-kernel+bounces-49173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DADA48466C8
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 05:08:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C362B23838
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 04:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAF2AE57A;
	Fri,  2 Feb 2024 04:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="IZLkoUir"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C48DF4C;
	Fri,  2 Feb 2024 04:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706846916; cv=none; b=XKJQPoDETOUa9HOq8OA4sq+G53pwnSslXQJUvQeQW/QBpMaZ8v88z3Pfl7h3y2ZVEwp0elYWbGJC/+rAX9/3j5wuwmN3LmLkiZVkB/MDiaBXFRFCDxBT1qw8IgYsZeEnPbKr0qO/ymkCicZE8mqcr/YaD2bZ8rHIxiHbxki7nQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706846916; c=relaxed/simple;
	bh=hnCqnMLbqTjgA3kzNKZYIDfPIzSBOakneymBT4d5+lw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=o8pvWfdZi1oRhfSgPadjB4GIW1So8fnS0iusbfvu77iXoP5AglILpHOybpBQvXVSusIbMnSfiNAkWZB2YMotJqjl1yFqmynGpeiENMrDmkBOPVIe3xjz1m1ZoBwmVrGmrfR/2aCCINLYcapZqhJh4+FFDddAPj5yNfpTfJ1B2S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=IZLkoUir; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1706846912;
	bh=WK+WQvIabrXOJxdOo+ANXO7ipDuidcSlXNRYXHPQ5U8=;
	h=Date:From:To:Cc:Subject:From;
	b=IZLkoUiryVLuEm97G4HJNK6b01UZJ3JxGl5GCZPL1971I4vPf5L8Txq6tHtB6YB66
	 sjKVAfpmLr38otPZR+wS6P4DUhWcAmbhZkOLrkega9NNRfyne6mjXZXCxKtCBWs7wA
	 SxozZXFyQyVXDHaOPuB+9LjAU6zN21KFMRI348jtEv2STFTlCriBn9otGJVvlYG1c0
	 Jj0K2VwNjAD75HNp6cgu0yMw92dmmnDa8YvJ1X/Tn+/dNCSxtJApf44o8C4YSR0PXv
	 dB8bbpBle8A0B89X28JUiyOzJ86B54pGVilygKuPO3m0v/M6HyJAJpNnnWTcWQSJjF
	 zIdTu/riUHYgA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TR2M432pbz4wbh;
	Fri,  2 Feb 2024 15:08:32 +1100 (AEDT)
Date: Fri, 2 Feb 2024 15:08:30 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the v4l-dvb-next tree
Message-ID: <20240202150830.628660c8@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/oi9IdmXH=C3EU0XTPUp1aqs";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/oi9IdmXH=C3EU0XTPUp1aqs
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit is also in v4l-dvb-fixes tree as a different commit
(but the same patch):

  592bb51d048c ("media: atomisp: Adjust for v4l2_subdev_state handling chan=
ges in 6.8")

This is commit

  f66556c1333b ("media: atomisp: Adjust for v4l2_subdev_state handling chan=
ges in 6.8")

in the v4l-dvb-fixes tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/oi9IdmXH=C3EU0XTPUp1aqs
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmW8ar4ACgkQAVBC80lX
0GwkfQf+NCYeEeae3ywRjcbryIwFT050K/QaqV4NwHGncWbsjpuDQ64TCgB3R/wD
fvacdc0cLXWX+NfO6AdwU/IbRfiC3WrIouhqV85fLP/TaGZ9bLrxlhQTOKBxA2Gz
a9P19xIIMHGU56JHr0TmVXhq7jY8wTHwUbbXZW0WMVzeBLbKNEnGc2E3EBqEiyp+
pjPjYmOHqz5KZd1gM29vcpzrwPY3uaOQKeoUwWoAIj1Q+1e6EsIyiqt3mzLDa8CY
PbooPW8IkZE/tTljWCqmX+33IDNsYctke+DzA9G2cSCmElvynTKl5pjknK2+5Sva
x5j7Nnf6e/MOZKwE8YUoSvmRDsahbQ==
=KJ1k
-----END PGP SIGNATURE-----

--Sig_/oi9IdmXH=C3EU0XTPUp1aqs--

