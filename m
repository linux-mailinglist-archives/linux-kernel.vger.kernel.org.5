Return-Path: <linux-kernel+bounces-144535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B89B78A4785
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 07:20:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2EF11C21516
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 05:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59CCF5234;
	Mon, 15 Apr 2024 05:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="cNCcyY2k"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23778441F;
	Mon, 15 Apr 2024 05:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713158414; cv=none; b=U76TgNCegCM6L34bH8vOdJEFHyt4OpfOEdgZ5haM0f1fj5k+MuaPwpIKEDk8GdYzRWS8w8KJdeFr4mCZbmpCEhZiwv3ORbam7KNPG7y95QLpK+Ci83KvRAseTpv6NBzdjYQ90w61X8mzNWVMFNw2IuqXMzeVqQgeYYhRW3b/g3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713158414; c=relaxed/simple;
	bh=3+2slqMSSHYSy3izbMcmiQrG16EbrDDl0oQELaj4Zv0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=BAQiNyVeHxKn0hMcx8T8rRDLmwnGRNgtIwslGDw2Xf35f3Fpr3/gu0vn1qqQ0bPuhbt9RCalWCiPGnLQ3eWLK/CihC0T5HR9hbnZh0VqVQc517mvRTb6a85U7QrH5QXTgEANn3rzxXOXM9bLA659yyWZRLtOshNmrWIQ4WuM6rM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=cNCcyY2k; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1713158409;
	bh=Qe+r7ojQoqxGOKMmJ7jfbUFde7TJ+FtV5rP61rPrhYg=;
	h=Date:From:To:Cc:Subject:From;
	b=cNCcyY2k50CEfjvj9O/x4BeCo0d3ZMbnqDuYz5pxBy0tipPS9qQwapPeX6b/qug4d
	 x8DdgiHhqCrY1ru7C9sAyckVwmkmDZX/YkhQ2fYb4RYObxdSVRyzJy02ppJVbvW7FM
	 fi+YuXMQV1j9SA+dzWpj2N2JFn1+dJuyUK2GI9OXTzmZtNG8WSdnvhacR1rotb+/Kj
	 e1ADqGEffpwazEyBNIhMlopvfZMFyHdaBI0Wq1JbHV7/T2b8xzb9gr5TgbaSpQuVfc
	 4ICRFQlPNxmIrqlNp5VUCAZieMje88wpmwdxe5CR9K3Ke97DjbXYjdGSSyVIdx5Jqo
	 67HoYid64ZlPQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VHwV05sGhz4wcR;
	Mon, 15 Apr 2024 15:20:08 +1000 (AEST)
Date: Mon, 15 Apr 2024 15:20:08 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Barry Song <v-songbaohua@oppo.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the mm tree
Message-ID: <20240415152008.0708afb1@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/1bVpxP8y_WER/.L72r/mfsc";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/1bVpxP8y_WER/.L72r/mfsc
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the mm tree, today's linux-next build (htmldocs) produced
this warning:

Documentation/ABI/testing/sys-kernel-mm-transparent-hugepage:2: ERROR: Unex=
pected indentation.

Introduced by commit

  a70dabb40c3d ("mm: add docs for per-order mTHP counters and transhuge_pag=
e ABI")

from the mm-unstable branch of the mm tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/1bVpxP8y_WER/.L72r/mfsc
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYcuQgACgkQAVBC80lX
0GynSwf+I+a9CfjizKw8Q6NodnX8M7lW9J8QwI6GekOFeMGdTjtdSDMrH9WXIXuT
aHjZGSUAakXjXpGu51FNz+IN3b4J5Hqn0rguxoa3zSawcBuQdPUt4i7Vx/L4A5JL
H0GKX5mVfH5bx+7vGfDMMvXMRs9OCpsre5STG0nIWlNud3ypjx4srLCXsviJVZ1L
XrCzP72yNF7Ux0/j4JPPsJ7FxWsoms4J4nll6Wpe4C5EShUP0Gz9rMFJMw6/fMhU
hc7cQCt77O4fvV2F8VBylEwjm0iJi/1LsGVUOxO4H1xod6lQay6cPPgeJN4ZB1ga
+fq+iciYNB9zsfXwI31QMA5l0xs/DA==
=0bRo
-----END PGP SIGNATURE-----

--Sig_/1bVpxP8y_WER/.L72r/mfsc--

