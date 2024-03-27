Return-Path: <linux-kernel+bounces-122082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72A8B88F1AB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 23:13:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26BFC1F2965A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 22:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7277D153819;
	Wed, 27 Mar 2024 22:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="ZrA1A0q6"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942481DDD1;
	Wed, 27 Mar 2024 22:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711577626; cv=none; b=Ow8ah59iJ3X94glSSw8DW3SGNE3AU7bP0Zy/s9URJ7LoKgxqyL2VmZ2JtLUcD+wRP2hVhVIvWK/KWzBe6heQ7cJTL0xGbDv6gDYcmXth19kEU/58x2mJ7gs3uDbhIB4G65v0ZpUqy1inYKiSwVZ7J4HyFpuToYkNHlShmNH+pgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711577626; c=relaxed/simple;
	bh=Aj4ptK6nKqfO0SSSLwsSil4TNRAjcHPITdBMrnAd/co=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=lMDkt0mNFtUz+PyrRBL1aZ/rBH/Ls6JEGjfGdZcPGxLt3ZHSrpTgeKTtn+83T1XyHPhy1piDLYogddo4V5mmPiHmCh+0vW9sbhoOuEOHksRW8tDWqiCG8yzmwPQL9zlUSaWS8WHKcQLh4Izfw3m3JtFyxzAHtCFoFhi1PrLN9NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=ZrA1A0q6; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1711577620;
	bh=JVoVESu6RdDDGqwpOs7A7QE0ixju1ecUHMEwEy9hlno=;
	h=Date:From:To:Cc:Subject:From;
	b=ZrA1A0q6I0hFMCZo3rGKUAP/Q88CeHBhesdH6RJgRcCnZOQLdlge7DJZp0jlTw/nM
	 4GBGAPEz6vsktpfifBH9vRni26rSbtukh7/RvXIOL3y9NaoBM+1w3JLfydXOIxuA6W
	 tkZ+CAwik6apHnQeHGHSnDFDjRrW1ppVeOeXYCL9AZyavls6+ppMtdHDFCUcKB4jO7
	 bbehpmKBjxT9A5Tx40fczh3bR7iZGQZcJm4iXv7zd3FXDGWoAQ7bP4GbkoPz99icLp
	 Kz1TmOEVczen07uGRzNtYpwmTCHv3rubP4n0HWTojjg9Q8DXQMYj+cp8m13DXqEg8D
	 qh338g1H6AT2A==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4V4gtD4K81z4wbv;
	Thu, 28 Mar 2024 09:13:40 +1100 (AEDT)
Date: Thu, 28 Mar 2024 09:13:37 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Baoquan He <bhe@redhat.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the mm tree
Message-ID: <20240328091337.03421187@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/UbVv3PiohOhbbL2fgZafsTc";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/UbVv3PiohOhbbL2fgZafsTc
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the mm tree, today's linux-next build (arm
multi_v7_defconfig) produced this warning:

mm/page_alloc.c: In function 'build_zonelists':
mm/page_alloc.c:5324:13: warning: unused variable 'node' [-Wunused-variable]
 5324 |         int node, local_node;
      |             ^~~~

Introduced by commit

  95d0185255a3 ("mm/page_alloc.c: remove unneeded codes in !NUMA version of=
 build_zonelists()")

from the mm-unstable branch of the mm tree.
--=20
Cheers,
Stephen Rothwell

--Sig_/UbVv3PiohOhbbL2fgZafsTc
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYEmhEACgkQAVBC80lX
0GwtaQf/WJHdqIJoJkugdSgk1N5b5zFB9wUvFuOPNDB1U/VnU/AcaOLpmimKNAtw
WsLZUeEkO6qs9hE0oHZG3smubw25WB7T5VTUWba7YqxCnvl9sfK+xsVhb37Xk0lL
CvS2HJnDrglhhQ9Y4LOL8lKDclknhKacvGr976wOYrYvn/dg/5DuVBLL3at7sP4v
QMUxk5rXLJzgMo+6IwKtg8HBd5/YpMAmojWrGbDb6Y1DG4ebX+cdpa2kkDOwj2L6
nox+E4htlC0TqG5gshd7Ba7kyLM4gpWm42mI3btiyZva3O1TVaB00k+Fg5z1b2ZB
64ZW7bpnwcx6VtnuHaSp7MQ/uOC+kQ==
=f17s
-----END PGP SIGNATURE-----

--Sig_/UbVv3PiohOhbbL2fgZafsTc--

