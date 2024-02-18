Return-Path: <linux-kernel+bounces-70600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 861058599B1
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 23:08:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B99621C20B93
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 22:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB4AD74E0E;
	Sun, 18 Feb 2024 22:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="m1YmrSm/"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225397429B;
	Sun, 18 Feb 2024 22:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708294070; cv=none; b=njZNaTJxeuzy8zNovnSVvVckURwNLDskVhyFD0XrC0z42mF/U7uVsKYSQ6OW3TkzsFYX4+REJfc2v0A7ZRfCNThMYvMMrB1s+GI/V95W0vVcKMWZWrAi9TIM7NqEKn9ktO+HEQBERt9Fpwd/T5mo3WSjEf4bHLgrjbGeirIU/QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708294070; c=relaxed/simple;
	bh=Ej5nfJ2GT3uRzKUBzWXHQgvfvJ/V18GaIOwBeSOLf38=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=jnsqJ7IkICyPAApzXPYTcdHnG0sp0Nspb65wg+NOdoHPlaSXKkUfb7hnnuMEO4cm339TgtUWMjhD403tsHf3PdnDKsm0yxgJERpo18RSuR838Ja6HGrrJl62hvp8SMdmGNAoH9cdPsHMOuEatdvUhKYlJLVyvOz1W9pW4SysjNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=m1YmrSm/; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1708294064;
	bh=u3qYSIEt7wSwysWILAwarLcU86NlQvPnZ/iycotOidc=;
	h=Date:From:To:Cc:Subject:From;
	b=m1YmrSm/gLz1xJVYQXHLHhlNibmcRxgM3Nk8N3F+HGQyxQ/uioG2QPgiHaVNy2p5n
	 6CCwYmJRDEXRMnzkdsb5H17kbBYzt1XHpACWnYhymc029w5bh5/OzgHOHWROltBp57
	 IFYSU99V6nsck6inM/n08wcQlOmQTRa59EK2//3qiuxKTmqml/gExFWscvA4jlQ7qE
	 KtChDPCUazO0sy9zWOgo9mPsh6+AEkKtCYkZn8GpE4QDXtqZ2d6V0sIb9xlbdDpEuF
	 ebLEcLIw/2UPzUOtBU/+8qH+vPbx6MfX0ikHA9I+9N3ZAhk6bT8CMobQff2XG6c0YX
	 9XsIYy2563gAQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TdKXw4TfPz4wcV;
	Mon, 19 Feb 2024 09:07:44 +1100 (AEDT)
Date: Mon, 19 Feb 2024 09:07:43 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Ard Biesheuvel <ardb@kernel.org>, Ira Weiny <ira.weiny@intel.com>, Linux
 Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the cxl-fixes tree with Linus' tree
Message-ID: <20240219090743.1019a5f8@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/QjBePl/iy+7ECcbgyvh7q9i";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/QjBePl/iy+7ECcbgyvh7q9i
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the cxl-fixes tree got a conflict in:

  drivers/acpi/apei/ghes.c

between commit:

  54ce1927eb78 ("cxl/cper: Fix errant CPER prints for CXL events")

from Linus' tree and commit:

  6cb604ed24a1 ("acpi/ghes: Remove CXL CPER notifications")

from the cxl-fixes tree.

I fixed it up (I reverted the former commit before merging this tree) and
can carry the fix as necessary. This is now fixed as far as linux-next
is concerned, but any non trivial conflicts should be mentioned to your
upstream maintainer when your tree is submitted for merging.  You may
also want to consider cooperating with the maintainer of the conflicting
tree to minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/QjBePl/iy+7ECcbgyvh7q9i
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXSf68ACgkQAVBC80lX
0GxTLwf/TQmUZLa83oXxh6D+R7ZquWjdA7eTV7o780EYTtK3NS3b8dLbwFbH1Yxf
jVcuH8ECa8q92c/ob0149gL1UWpTk4cCkXcD9sc3Cifo+bgcBELiiyQUwtp3RN3f
PJPPsMsvKNtYNSbapsVChU41lxaymueI8qTnlxTyXZBmnOuaSdTkIxR9Ovulyr0g
GaaSMPDLb8PxV2DzQCDRaaTaGU4VH3fCqjwjZsOYaJFuCrbL1RO0lbDvbPnxn5yt
QxKKuaIk0W21+2IrbpSqcJr2fMojG36iNJVdAq0D3Se860KUjwa7I1XIfwoTrr2X
QkhbvfkWSdPhru7Dk3kSqsVxcsSgOA==
=GnwV
-----END PGP SIGNATURE-----

--Sig_/QjBePl/iy+7ECcbgyvh7q9i--

