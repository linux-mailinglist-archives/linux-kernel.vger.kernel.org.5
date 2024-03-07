Return-Path: <linux-kernel+bounces-94979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CC4D87477D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 05:51:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D97E4286A95
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 04:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19F6217BAB;
	Thu,  7 Mar 2024 04:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="TDlFGypx"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851FD15EA6;
	Thu,  7 Mar 2024 04:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709787106; cv=none; b=YtqGN/XMjVBh4MfbLSs6aXL2Ln+ablBW0aMx9Ldhd1B5EbbNSaxDuezg7A524iFxI8ZYPHW/UfDCQFg7/kvrC3hkKuGvKsmdfeRCBcSZZHCx7nIXQdoR8AfBGpbYayGvMjOFjZP+MjY6rBekNd48VmAdqNFIbyh3n5TIpdHW1IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709787106; c=relaxed/simple;
	bh=Bq0DLXrbmUR2V5d/aU4hu9+nI65kDN8R3dpW9WLNnSM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=H8AvzVVFfCIWHmjLizElqrtVNaD8Ufci577s204/+XFDy0Ks9AOjtpc2JIfHm6C4ga77XUMH5uWeAoqWHxdNfpcr+pJvrvJ5qNCPMlVDdW//IOoYg9dtaAWkyOB6+LnJ5lznhqhPQViNJPZu9uQstDlhYy3Ol7HwR0b6H55KZks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=TDlFGypx; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1709787100;
	bh=ZoNXxsmgq9stJfTSAYeDU7v9vK31/9ULNKvtA5uDRDE=;
	h=Date:From:To:Cc:Subject:From;
	b=TDlFGypxkzf+q23JhdE/YAr9c4BmHTdfH+UU0rW0DVMeckZwym0puNdSQYUlKfk1N
	 FhJSmlBCZesl7vxAuTjaeAoz9P6t3WBIkOijjNo/S9prRHiyKiyt74SjNh6pkZXf/v
	 sQ6HM3CECtJnFXuGaRq/Ah7pGRrCn/S08aB4oTD7/YkyaQNceW2wssYd5HmasvaKng
	 zIZ2cq97WCGOZqm+TdnHc8ZiKmQHEIrgKNe6oLyFg4PPZ3754spj4e5pp/GogglgAa
	 0a6f6aesmyTdPA0rpgEG43EILVPzTss1gCg35hU3FQQsf4fjf2U40H9uS4Vj7ZzrSh
	 m5exIzETZnwaw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Tqxj826ZSz4wb0;
	Thu,  7 Mar 2024 15:51:39 +1100 (AEDT)
Date: Thu, 7 Mar 2024 15:51:37 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@pengutronix.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the siox tree
Message-ID: <20240307155137.19a2a2cb@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/A4KTHfWokm22WTSqP9DIjn7";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/A4KTHfWokm22WTSqP9DIjn7
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the siox tree, today's linux-next build (x86_64
allmodconfig) failed like this:

ERROR: modpost: "devm_siox_master_alloc" [drivers/siox/siox-bus-gpio.ko] un=
defined!

Caused by commit

  5c941dc7bb21 ("siox: bus-gpio: Simplify using devm_siox_* functions")

I have dropped the siox tree for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/A4KTHfWokm22WTSqP9DIjn7
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXpR9kACgkQAVBC80lX
0Gx8pQgAn7Dobee2IhrYr8jZaTiMjrr4XvdL6auGusPe9PqiEtSKweRdwexjM6QE
2i9o1WitOiiu/U2xGzBbbZkNp+DWSDxaHrgkhcblQOVbu0cmllxK77ndX04uTfb0
wlnuKEdeWoe/xcakd6LuD6X8Kj9Iq7alwCKatuyi1Mg40Ug2mqs5EoBpgysOcLXz
YjRruLbpZRVYGRXOHrs1jbREAmQoGjJAqSnvLcucVY/pgksWIsBiFD4x5E4DVvPX
riMPnC8hT156cDo3fCQa4hIQyPXm5QMDPrjaND0veGoDpCHuhIt35+/yrU3vB4Rl
J6y0MWIfFDPgFp80Z9CRU2R3UMLKOg==
=Vgjw
-----END PGP SIGNATURE-----

--Sig_/A4KTHfWokm22WTSqP9DIjn7--

