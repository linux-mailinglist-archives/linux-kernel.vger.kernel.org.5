Return-Path: <linux-kernel+bounces-102646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0872587B546
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 00:38:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 097501C2139B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 23:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 810385D731;
	Wed, 13 Mar 2024 23:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="KSKiIkAa"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9396A1E480;
	Wed, 13 Mar 2024 23:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710373078; cv=none; b=r2FeGZ2ifpEKSt2i3xbz5iz3MJx1OIG+ekjJSVzk3cvg+hPaMh/cgScarDGm+pjN0Zfzf2Z6QziRQbZV8W2FOMPuZrtd6N1nUmxFOnG+t3HBeiqgJi/RVNku9RU3Pv+bWA26dp0rDnXmjT4euYK1tz5Td0KK0HBBrBRvLS6Qkas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710373078; c=relaxed/simple;
	bh=+bkfoNAkgZ6jyylxB1xAXhcc82JKDIJesN0p6UfiLz8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VQdvUx0D2sF1FR3EZ4fp+BFAQ0bXyo5bQXgo5ekPtPjTiGSDVKIOaQzlQ0p5iQALUOQcL5zWlrVfSJE04BS30m4+A4KCntHztlxS0lq8sbvm0lQGoYaCYk2zSBmrButcXPI+jxyv49bwxIfWh2nZPy8WH1PTitsYUtuzVqQWKJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=KSKiIkAa; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1710373071;
	bh=fz7c6SVBLf9u41mOXR60va1RqoUP3ryGdzeWAEzQd4E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KSKiIkAaSk/1dxxI9YEIPMAWEIKKSktkPUWE3vEZ/L8odiV/syb87A84NoLeB1IZP
	 ZyxB7QIQvx06XlWyHf93/QONq4dveXPlirJtTb0E2CXIHe9hHdCU8eNMuKto/M6BJM
	 UjcL84d7dEI9+LQmppZKwoDhXGJDZu++AVcUmQ8iWYJPTli2XsVbtnXf2ta7umyTtX
	 bc62LwImasLMsqAoQRHLvOLlsG25Aff/ovZEkc0AIhHmLErIJb9JBW/H8MQjh3O8W2
	 VHsO3Qgl4aKdOplCrVdTkAH0GEbcEFU/mbmpqT3tWdMxsX6czvP4Ew8j/gjngLVhvB
	 J9PHmZOVoCmhg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Tw6Pp6Mkbz4wcK;
	Thu, 14 Mar 2024 10:37:50 +1100 (AEDT)
Date: Thu, 14 Mar 2024 10:37:49 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Kees Cook <keescook@chromium.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the kspp tree with the bcachefs
 tree
Message-ID: <20240314103749.69a36bc6@canb.auug.org.au>
In-Reply-To: <20240301154351.1d097566@canb.auug.org.au>
References: <20240301154351.1d097566@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/748TZZ/RMYp2vSns5JMPamk";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/748TZZ/RMYp2vSns5JMPamk
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Fri, 1 Mar 2024 15:43:51 +1100 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>
> Today's linux-next merge of the kspp tree got a conflict in:
>=20
>   lib/Makefile
>=20
> between commit:
>=20
>   f6099c0b0300 ("darray: lift from bcachefs")
>=20
> from the bcachefs tree and commit:
>=20
>   257e66e5800a ("string: Convert selftest to KUnit")
>=20
> from the kspp tree.
>=20
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>=20
> diff --cc lib/Makefile
> index ec3d915e7889,97c42e38046f..000000000000
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@@ -48,10 -48,10 +48,10 @@@ obj-y +=3D bcd.o sort.o parser.o debug_lo
>   	 bsearch.o find_bit.o llist.o lwq.o memweight.o kfifo.o \
>   	 percpu-refcount.o rhashtable.o base64.o \
>   	 once.o refcount.o rcuref.o usercopy.o errseq.o bucket_locks.o \
>  -	 generic-radix-tree.o bitmap-str.o
>  +	 generic-radix-tree.o bitmap-str.o darray.o
> - obj-$(CONFIG_STRING_SELFTEST) +=3D test_string.o
> + obj-$(CONFIG_STRING_KUNIT_TEST) +=3D string_kunit.o
>   obj-y +=3D string_helpers.o
> - obj-$(CONFIG_TEST_STRING_HELPERS) +=3D test-string_helpers.o
> + obj-$(CONFIG_STRING_HELPERS_KUNIT_TEST) +=3D string_helpers_kunit.o
>   obj-y +=3D hexdump.o
>   obj-$(CONFIG_TEST_HEXDUMP) +=3D test_hexdump.o
>   obj-y +=3D kstrtox.o

This is now a conflict between the bcachefs tree and Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/748TZZ/RMYp2vSns5JMPamk
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXyOM0ACgkQAVBC80lX
0Gy9Fgf8CeAUQiJrjeVvCvUngC80JaYcx7zugfv6S6Lt2u829zCZfvsNHahkd5mR
G4IUqoRteOK/jXU4YhXpRC7DbiRElLZ8MCfwfPhSjK6MKQN17WBOMPw2woH81DNe
/rAIyM71XlIbgs+j1xMUryFxSpJXciOO4fI1eYBT/+cjPzVPODTPlwCR3yW4OjFm
odptPL+VzkAdA8sxsk242maXfjhotra/aS/8xN0dycwyPPSLKA4PrdtqgtjoLE/d
YlgSQzGAQ0WpqmKknP7bo0wcF/mZI93InTa8MZZ2Zl+P32oNK/ONzdsvCoKPMZnG
OpfEKtMOOqPblQinmkrsLybbkb/fyw==
=Kq6H
-----END PGP SIGNATURE-----

--Sig_/748TZZ/RMYp2vSns5JMPamk--

