Return-Path: <linux-kernel+bounces-45432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E58EC84306D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 23:52:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A198F287718
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 22:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBA6E7993B;
	Tue, 30 Jan 2024 22:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="m1OQJ4n3"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3FC7762E7;
	Tue, 30 Jan 2024 22:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706655159; cv=none; b=nhsWqQwBzAo+Dw/vbIciLVIn5iJQyehWQAWIT/EJUuO/xBnseGzyilbebaSgneWbhJgGGCFxWnw2fAYItg16+8J+9/IbscJOLheRGWxyWm3PDKJbkWliDjBOcLodFZQEhB0wBGHv/I9Z85xQP60+U1CbRdV2lGPar517aCo4FxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706655159; c=relaxed/simple;
	bh=YyLYasP0pOILyLWowQmNGZjzxaGZdfhFwF8VS+XcsiY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=B+CuIccpoKDOFm02CirrDFohpktmUS67M9ZQOYBgXEMsNcleT0o7bfVw8A7LbZIjGAqxbG/j1Rwjn8dD0eukWUl+uvZ8UWQgrvT86qK7G3AD8LbOTVbO4HOba4WCYB12raoacK46pZXDnz78Ni6tsgQy8/zBMx3pHB25YGHgya4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=m1OQJ4n3; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1706655153;
	bh=6XIISc8ch5WBdNoc3WXfwX9OwjBJgr8GK3svOK/ZC8A=;
	h=Date:From:To:Cc:Subject:From;
	b=m1OQJ4n31fLnwY7HZYy8bz7xI7bbGbiTsqYmKlRRdTOYm+4PF+jpPUt707NGYkzT/
	 QmS7IlNXbTuHngnNmPRkPf7uYD1PHacqffFjjEhIChyFAp6CdbKy2coBbupCUo2s4f
	 IhxI01K++d2zwEE7xHUtBHPhGRic+a7vGC+ZH4PbxY4xjsQ2vbj+M7jeaD/pr9dgqI
	 9eDmtkPBdEIFDGCwN8Ae9gspE5cdqBfPsemtQhPq14UITGFR9Q02jgj7ufF057DU0d
	 Rdh/qUm+Nt/nWQn25ZhsT1UzxWJLAeDY8FauRdzXWGe2d5N/x37KOLq+D41ybWR6+h
	 O4h91p1VZmyYw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TPgRP06Gnz4wyl;
	Wed, 31 Jan 2024 09:52:32 +1100 (AEDT)
Date: Wed, 31 Jan 2024 09:52:31 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Jonathan Corbet <corbet@lwn.net>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>, Randy Dunlap
 <rdunlap@infradead.org>, Udipto Goswami <quic_ugoswami@quicinc.com>
Subject: linux-next: manual merge of the jc_docs tree with the usb.current
 tree
Message-ID: <20240131095231.292911c3@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/8wyep8sWf56.W5L1XcqloAs";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/8wyep8sWf56.W5L1XcqloAs
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the jc_docs tree got a conflict in:

  Documentation/usb/gadget-testing.rst

between commit:

  20d03ae36ec0 ("usb: gadget: ncm: Fix indentations in documentation of NCM=
 section")

from the usb.current tree and commit:

  e49bf650ab5b ("usb: gadget: fix max_segment_size malformed table")

from the jc_docs tree.

I fixed it up (these commits fix the same problem, I used the former) and
can carry the fix as necessary. This is now fixed as far as linux-next
is concerned, but any non trivial conflicts should be mentioned to your
upstream maintainer when your tree is submitted for merging.  You may
also want to consider cooperating with the maintainer of the conflicting
tree to minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/8wyep8sWf56.W5L1XcqloAs
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmW5fa8ACgkQAVBC80lX
0Gw3uwf/YOTZq+29TPvAF+j/ZgECk+GQ/NjAKnNCVFCh/XTFXo9iUkpLb2LPnujP
Oplx5cbwYVWwBbBvIwAm3guJhqVoKNIFCAGbDdDeFT4d9vWV9VU4B4Wy7BOjW/nT
QCAGJMGFCa+sR61oZRidBjw3xAO7YQWwagU28tDSLc4Z1Z72U/86gl8loQe5YN7m
DWcO69UzquW5rZpjYDj0r2dXDnCh76nMJ3zXxXaqQjk7oUfMQuYC5tkOpMwUIkVz
/kQW0yAkuctHyLshZDMwfTM+qVcEP7GKrjnNrGeuZ7KXk/VbiEQlLm0nyZ3eTfDf
x8ExIP0zvvsySurk0rUCz78PxmPpXQ==
=dkJY
-----END PGP SIGNATURE-----

--Sig_/8wyep8sWf56.W5L1XcqloAs--

