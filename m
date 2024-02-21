Return-Path: <linux-kernel+bounces-74071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0854B85CF9A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 06:28:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 399CA1C22404
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 05:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85A9A39FEB;
	Wed, 21 Feb 2024 05:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="RDaQGyZV"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348DC39AF1;
	Wed, 21 Feb 2024 05:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708493273; cv=none; b=Ktpoz6jWUXu4GWNMWv02eXJrN3whE2dxttScfVoO7T+RDdRCH1iVEp/2znwPcsGpjCeInhT8j67GuHyzoZBytO8d4Ipt9t5ByjeNHwBQKwDm3lYicIvS3JmNyfoh5/wn6JmhQ4OVKolKhxDBwN32Y0JcTnD54oGG2RyGrIH2NI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708493273; c=relaxed/simple;
	bh=+aTvz6D/KaDAHlHX0V2lqWahO7R0kOFXYq+Xtmnf0cs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=n8M3p/0jeJx4M4AKhy0+Kw7yS/O8fWW9lw8Mmih5e/xG4EhQ0DittNly/C8i2lp3H3JmgX2F6ntQgKwvSnRS9f3gARh4RE81lsRhSRKZ1aD8RMP0kyFXKI3cTn0mYV5WkBgKXjHot8i/85c7ok/a2DawGjcbe097Ox0UeW4rmjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=RDaQGyZV; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1708493267;
	bh=onubrhI03XHHQ7qzCyQv2Z95Tprmg6JBZD51WrYR+L4=;
	h=Date:From:To:Cc:Subject:From;
	b=RDaQGyZVX61aB+I8poOrk6vm6zCzNDb47owdmU8uRq1SgQ7gmwad+WjpyfTZP6YVH
	 ifeJxPUvmx90Lu2GDT+gVmm8quTYOXodSfLJDqwHFUQvEDVDs5FyJ/s+L9V3hqLX59
	 NP01a8TPUKUPGuj+qLNBJtmAjoldQ8lBKi5htcGDYepg2nB6X58yPyngxgOnk1xF1o
	 WU1jlj6q+U+7BBuXkDk8du/ugQyhV5wPSENYMi9R4NkBfQ3GNpvLHJxlfVMuWW3NX3
	 xkwhzrql4UFkUhGTbZN2PfI+QFCdQrRM5RK1L1hJqh4OxdZbmKNq1t6U/tjf6e647c
	 xtaw4bvcGw9HQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TflCk5Dnfz4wbr;
	Wed, 21 Feb 2024 16:27:46 +1100 (AEDT)
Date: Wed, 21 Feb 2024 16:27:45 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: build warnings after merge of the mm tree
Message-ID: <20240221162745.4332955c@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/rZSz2XyBy4/Li.uOi0DLWDM";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/rZSz2XyBy4/Li.uOi0DLWDM
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the mm tree, today's linux-next build (htmldocs) produced
these warnings:

Documentation/admin-guide/mm/damon/usage.rst:186: WARNING: undefined label:=
 'damon_design_confiurable_operations_set'
Documentation/admin-guide/mm/damon/usage.rst:369: WARNING: undefined label:=
 'damon_design_damos_quota_auto_tuning'

Introduced by commits

  afc858f0e6db ("Docs/mm/damon: move DAMON operation sets list from the usa=
ge to the design document")
  d50e871bd78b ("Docs/admin-guide/mm/damon/usage: document quota goal metri=
c file")

from the mm-unstable branch of the mm tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/rZSz2XyBy4/Li.uOi0DLWDM
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXVidEACgkQAVBC80lX
0GxENwf/Y9KwEj0NZzTnX9MvJ+re+4B9moHI6cnIX7BddS6MFhMy8aAXTeMJOhyw
qYv0v6mMYjaoK8cd9v3gy1eZARFUKUc779hqDj7/SijsvK6EDeXaT3sHWwVVnYR5
9Jb6HOyYYYxzKt2DiGNnmC8gWYFZGSe5bgCXDNWh2uSnBnXrMfm3JqxLmRooYebT
r4u4kA9HNmGb3bBf5buEg8ljMSTjaL/6ivsugAGsdjnUuawe9+ez9OFvABqBwItV
SwgWR7KCU1TJzZa9WXIHnG5OPmtTGWP9EyguwqFd3Tyj57e91/45OVGTDb2k2hYM
JGEjoa8zc+Y6l4HWeboWDP8R+LnYdw==
=nCJM
-----END PGP SIGNATURE-----

--Sig_/rZSz2XyBy4/Li.uOi0DLWDM--

