Return-Path: <linux-kernel+bounces-91438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07DBD87117D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 01:16:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B79FC284B74
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 00:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 827BA20EB;
	Tue,  5 Mar 2024 00:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="b71JBGCz"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6F010E4;
	Tue,  5 Mar 2024 00:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709597799; cv=none; b=siwnRhe8WEFlAlGw06WIiTV2yOaZzAPuu7L4PhYpPn87NerOxtS2x//HWtXlBW52sc8Wd4wfCPCoZXOSLkPUtfT58bbFkJIUh039Mi5sWxLT8BQX3wgC3LJuCk6Ra+Nrryu0a8Uc1ZkofOY3UEpoO4Ry53E1Mh8MqNtbJ5iTw7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709597799; c=relaxed/simple;
	bh=9g4elZyS7t+ZdtDfIMwy46fPX3MhNp6jb87re7cBkKY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LjzjQHP/6mOJRSeiG6JEU+mH8xi1Im0/EiWWRptF4vk8s1F7sboW/2yNT5x/QO7ZvVQDrzlO3jKVKjPIsYX1ba9yuEbS6/IXIjpBKt5Tz8JpMjvBmBaH92csxv68Xog/ZARh9RKYrrAf6H1EwT7G/DoyLwMxiv8ycCZM7+kVI38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=b71JBGCz; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1709597795;
	bh=4sEqwP8v2Pe+YO/5GaRVCftFMQfgnoX7jzUKfZAJ9Zg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=b71JBGCzpgdhYRkGYZIXDPW7VuYDER5Ug8EuABtZ3hSAWXDjOtMV1ZGdVwuElz9pN
	 esAzVBM1C5LZwgA2nTDKYmsm8m2PcJD9+WouN4ilLOrCgOkz27xjnOo4sUysKCjaa0
	 87taZOhn874p0phkRI0RiFePSuTty/+4O606RTw8WOCwSZV/+CDQSdWCKOoqjg1iEt
	 pcnqvN6GMy0CwvHVFLTQz2gfisDvIcJyojJhnscUP+dxVZ0ZmSbx0ZIEvLxIWINM5n
	 dAG02POouS90xl8n8FHtzeYz7Bt/CRQPtKjEEOKCMLW9JL3lbajvAeIK5Wbgadz6J5
	 6UnjgY+XWB4sg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Tpbhf6tZWz4wcF;
	Tue,  5 Mar 2024 11:16:34 +1100 (AEDT)
Date: Tue, 5 Mar 2024 11:16:34 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Lee Jones <lee@kernel.org>
Cc: Duje =?UTF-8?B?TWloYW5vdmnEhw==?= <duje.mihanovic@skole.hr>, Linux
 Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the backlight tree
Message-ID: <20240305111634.57e84398@canb.auug.org.au>
In-Reply-To: <20240226132828.7524baec@canb.auug.org.au>
References: <20240226132828.7524baec@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/IPQcpFq//f6HOfV8vnIEoT6";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/IPQcpFq//f6HOfV8vnIEoT6
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Mon, 26 Feb 2024 13:28:28 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> After merging the backlight tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
>=20
> drivers/video/backlight/ktd2801-backlight.c:8:10: fatal error: linux/leds=
-expresswire.h: No such file or directory
>     8 | #include <linux/leds-expresswire.h>
>       |          ^~~~~~~~~~~~~~~~~~~~~~~~~~
>=20
> Caused by commit
>=20
>   48749e2f14e3 ("backlight: Add Kinetic KTD2801 backlight support")
>=20
> I have used the backlight tree from next-20240223 for today.

I am still getting this failure.

--=20
Cheers,
Stephen Rothwell

--Sig_/IPQcpFq//f6HOfV8vnIEoT6
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXmZGIACgkQAVBC80lX
0Gwfswf/X8SSkHsb1g7gPrn3/LI8fF+pdVdsaUxh7R7A8OWcUtj2dogu+aB6SqH+
840ES5lrTb/puJXtwq0yEj1luMjuTWwrogs4iImU4Ka3tmCEX/zKtOu8Dc92sNVV
D5/TiUbC+wXCwBd31FHwIcWvW+iq75N/cVVoSETusviV6PqC+HOXeBN8XtHyHMT/
/abgnkv4UBWwRJLf1Esh6gpRCff8DOtm9JFN3PzTre1Mmw8E9ABRvIGVz6HEDBEp
6UEj5ieHygftXCLhgfHOGmjedKrx1iFRV8uhj6SvBlkI13YTGMEVMJwqEKHO+xDl
nV1aECWfVAHrGdYOMXSNF9EOlgIVFw==
=fBKv
-----END PGP SIGNATURE-----

--Sig_/IPQcpFq//f6HOfV8vnIEoT6--

