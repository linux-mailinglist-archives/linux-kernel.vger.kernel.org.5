Return-Path: <linux-kernel+bounces-101091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1028287A231
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 05:07:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE2DC28373C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 04:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C2B110A11;
	Wed, 13 Mar 2024 04:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="oFZCSi7S"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58ECF10A1F;
	Wed, 13 Mar 2024 04:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710302853; cv=none; b=i+o12XBNn/KjBM3BOWyg0F3AgH/SV5XgNTx7svSqjeC4yM2nhF+Jw4EUAvmny5buXIgjWxF+K+G+Q2HXHA+62lZK/MDlKkb0Le5u+k1kGBcKqr6ZplA076t4rXrREoGBca1fe6r4lShDhfFhQ2y+Ffcwn6d/FKFIGEP6mQPvB78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710302853; c=relaxed/simple;
	bh=eR+u3WiJSTaqYpllIKGbZK9TXwNYZu7Ollyr0+t9nwY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=u/MU3Y1V7VKcmqSGs/djZY7uLqBrOsC3nIHNasPIV0Bj45AM03QFMedJNlN9DvNc6Wrkg6kpuACIxiQJrCoGhs3NtKxMGkH9A/p8/O/YVr11qiosHYj9hx1JO/mkWy0+750DL2aKsFPxZA/jojU7sDZxAtDMTsxH6nCa4Ar/Ulc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=oFZCSi7S; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1710302849;
	bh=TQfXrE67AYoyoOWHoSzbnAPW29vQGENLKopiqPI7h0Y=;
	h=Date:From:To:Cc:Subject:From;
	b=oFZCSi7S+PQzioGAIYkOEIyLCI2XrDJ+yyfpZ+UliC7sib3G7LAn33WZtqS70B2M2
	 MuXvyEPgtMzE6V3KMxxVQHCltUV65vAGnAHeCS/3Stw53AUipFjG2U/mX2niPpayqb
	 nMT6BG4WLiRvuN9KbSI12jn82JVKKaQq9Y79rq4cJTIavaHVb8vDKySn0KtcMvR0w6
	 Jzut0EkM0xv3NJNjrcBOVaP7mOcfIcLlzepsVmAZ38IfZ/MMMSzLTsUcu94ttDCH3E
	 6m7X965lp7Z+wZ51c3iMFdRXfUOaE7LUQP3Xqr87oclKgC3l7qUGgT8l1EmtBYhQlC
	 4mzSsn5WK1stA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TvcRN6hh0z4wqM;
	Wed, 13 Mar 2024 15:07:28 +1100 (AEDT)
Date: Wed, 13 Mar 2024 15:07:28 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@pengutronix.de>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the mm tree
Message-ID: <20240313150728.12e20208@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/L9YhH_rc0xitjpvrOh62PNT";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/L9YhH_rc0xitjpvrOh62PNT
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the mm tree, today's linux-next build (powerpc allyesconfig)
produced this warning:

Use of uninitialized value $ENV{"abs_srctree"} in concatenation (.) or stri=
ng at /home/sfr/next/next/lib/build_OID_registry line 38.

Introduced by commit

  325f7b0aaea6 ("lib/build_OID_registry: Don't mention the full path of the=
 script in output")

from the mm-nonmm-unstable branch of the mm tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/L9YhH_rc0xitjpvrOh62PNT
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXxJoAACgkQAVBC80lX
0GzoNQf/fFHhU+BVd1zRiuswMb8yvPaYJpnrXgR3jKXwKoBO4MpFn+X3s9ZhdGWQ
XEo5BIYvtL5QBC2OQ732JATvkXUh8aHRcfd9kYJHZz2KYZxa/EtgaJ+lz9tNkCxL
CqRtVZYaaug917Q1y+OxKjzS8+CNaBQI/372fw5vgszzWdaINeoJ9ox5O95z4IQh
iR7cW/YFZugTdB7vnZ1QTNnVZ3UZmOFjqGcoNBcDXkh5JfkUfMKsU4u9eiaZlZZl
+6sC6eIRrq1sO14w2n/he8A4MGfMR1RU12TVbtxggu/tjSt5vTFp6wERJi38r0oP
ObbFeBx7fmVOLcfOPZ3N08MEAcGtBg==
=ZNZm
-----END PGP SIGNATURE-----

--Sig_/L9YhH_rc0xitjpvrOh62PNT--

