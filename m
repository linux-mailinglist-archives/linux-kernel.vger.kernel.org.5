Return-Path: <linux-kernel+bounces-22732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EB9B82A24B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 21:32:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF54B280FC9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 20:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F36824CB5C;
	Wed, 10 Jan 2024 20:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="pbtheVb3"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055BF2A8C1;
	Wed, 10 Jan 2024 20:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1704918731;
	bh=XFOS2qLLkVkIaaZj5xvJ4tw9u8PG9ljBiUsf7yVc5Ug=;
	h=Date:From:To:Cc:Subject:From;
	b=pbtheVb3aJNQzeGydVKAKkayoc42GR6J1CEEi6rYEEbi6fHhWbAyeubmK4dhF7Hr2
	 LX2WGhySK9r2cO9jq5q5c9VqBVDjYwMTMVkArW0a0tAiVR/yLMqwZup2cTRuOWszv9
	 vZzlILvG0o8Gmf8sPUwoWjYFDYJT9mZnhXmu0bZIGHJhBplx2CsYvofQIjbeGUni4J
	 FI7cF5eDbBtROPRA+Rt10olNQxuda3HFFQbRwgr8BBjT1ZadUaG0c66AqQuioqNdlg
	 Dz7iVtjzYR6AM+rLxsIC0jLVkT2SHIRJ65IKbF8M07/RUHx5XLvHgCeavKZwJpkF9R
	 bULEa3hw6wCWw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4T9KGg1dWMz4wcJ;
	Thu, 11 Jan 2024 07:32:11 +1100 (AEDT)
Date: Thu, 11 Jan 2024 07:32:10 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Christoph Hellwig <hch@lst.de>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the mm-hotfixes-unstable
 branch of the  mm-hotfixes tree
Message-ID: <20240111073210.447e1888@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/JATSvo6mdpnHQceXXBWFyCE";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/JATSvo6mdpnHQceXXBWFyCE
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commits

  bb7d64e992cc ("xfs: disable large folio support in xfile_create")
  bb939c8386af ("mm: add a mapping_clear_large_folios helper")

Fixes tag

  Fixes: 3934e8ebb7c ("xfs: create a big array data structure")

has these problem(s):

  - SHA1 should be at least 12 digits long
    This can be fixed for the future by setting core.abbrev to 12 (or
    more) or (for git v2.11 or later) just making sure it is not set
    (or set to "auto").

In commit

  f5929874fde1 ("kernel/crash_core.c: make __crash_hotplug_lock static")

Fixes tag

  Fixes: e2a8f20dd8e ("Crash: add lock to serialize crash hotplug handling")

has these problem(s):

  - SHA1 should be at least 12 digits long
    This can be fixed for the future by setting core.abbrev to 12 (or
    more) or (for git v2.11 or later) just making sure it is not set
    (or set to "auto").

--=20
Cheers,
Stephen Rothwell

--Sig_/JATSvo6mdpnHQceXXBWFyCE
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmWe/soACgkQAVBC80lX
0GzjmQf+Nu9lMVxDP7a/P2feF65DNteFkkzwWViSpQVgxb7jXo58FBrdqaWL5LnZ
k4rQnQgR5Cf1DMma3ZQouz3J5ewlgbWAbI3atwKBNnvbbhRx//q4tPzcujZrGKVZ
zN6Bqwwz+xrQyMjhD9d0QZh2Uj4Dcs+kwlbqHu8yP8D6jpPcsVA/OJnuWmmL3AGi
WazAABv3NOBIV5qNDqQV2oE/IU0ft7tCQvxGCwkIcUMwWRhK1mtvWbmva3rg+vQz
X6mlcURCxiKu4hCovPpQEDQ6MaG3kg+49Hfe9E5tL/9k09vbeV2J2EL1t4Mra9IH
mFhb9Y5ToT+8emZN5XAcmenXa+aSMQ==
=6KeX
-----END PGP SIGNATURE-----

--Sig_/JATSvo6mdpnHQceXXBWFyCE--

