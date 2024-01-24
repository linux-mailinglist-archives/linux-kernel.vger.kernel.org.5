Return-Path: <linux-kernel+bounces-36233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 561CD839DBB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 01:52:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF2B52869A0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 00:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2CC71104;
	Wed, 24 Jan 2024 00:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="rnKSfAuW"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 226877E9;
	Wed, 24 Jan 2024 00:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706057523; cv=none; b=UcRYusmuTwqQEfq9xSx7hK57PG+F1ybzZerrJzCyQpSga6zq2Uq1KVZ1iU1TNzim1AamyeFZMRiiUyCscliH+tt7z7Ls6B3olRXXeQmEYsTkTHDiuhYLdYGkbF9D7eDz7qpAHstlx3QdNCHrhb8qxTwmSapXJtJEmZuwi6TeyYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706057523; c=relaxed/simple;
	bh=vl3qvpiZR9zSqRueJKQAxfJ8y/doxRsfrtmwgSFw7RY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=B039VcGkNh0qzyDWrvl/dhkOFfGCU8neDIPrrdDVOfmfkKA6dmCuu3QM/gs6MKNrmK8P9d8O1IIdCd94qNCWP7Q817yUi5f6KU3Osf1357WLIFwA7fJ9eyR7HHWBvjW8ZuL8lA9ddEiTMW5BcIsNpUXCGyzwSNZT/KmOqGOV5kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=rnKSfAuW; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1706057515;
	bh=pgZagxIqMzMSDcxS7mD+Rhnt885cyia9j3Gc3oARR+o=;
	h=Date:From:To:Cc:Subject:From;
	b=rnKSfAuW0O0JyLHTweOSbGHWrVo79doaZcCdDNmAELPkcZQamHazSySmdwBF4bwdi
	 eRUj9GRuJYNcTzcduASfMoPTGA3j3nG9zPLiHAHFJvSBH9ToACDGyPmvbiFKfzG+xD
	 ldIhNQmwJ5ltTe6Sx/gvTvfVURaG8Vh88BWYT8ywdlmyhDV06KYcu5WJ8kxIXV+5j5
	 xh2zZ5smqG2FYBfpoyXZoA8v4wCfza4cJiFPyjgjIYZ8D40tfZamEqOmG4FLRynXXj
	 bYSovRqRnpIUimLoXK8aRUHK9Y/2KdQrOeY8VZW6M84FLLmKdwEO7rDsmgNAt3DpxR
	 SXC01FNwBcB4Q==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TKQQM04W2z4wc6;
	Wed, 24 Jan 2024 11:51:54 +1100 (AEDT)
Date: Wed, 24 Jan 2024 11:51:52 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Linux Kernel Mailing
 List <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the pm tree
Message-ID: <20240124115152.0806fc05@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/QAQzqX=eiGopyE/zn7GjXAS";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/QAQzqX=eiGopyE/zn7GjXAS
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the pm tree, today's linux-next build (x86_64 allmodconfig)
failed like this:

drivers/base/power/runtime.c: In function 'pm_runtime_new_link':
drivers/base/power/runtime.c:1815:31: error: increment of a boolean express=
ion [-Werror=3Dbool-operation]
 1815 |         dev->power.links_count++;
      |                               ^~
drivers/base/power/runtime.c: In function 'pm_runtime_drop_link_count':
drivers/base/power/runtime.c:1823:31: error: decrement of a boolean express=
ion [-Werror=3Dbool-operation]
 1823 |         dev->power.links_count--;
      |                               ^~

Caused by commit

  5d872146e7f5 ("PM: sleep: Use bool for all 1-bit fields in struct dev_pm_=
info")

I have used the pm tree from next-20240123 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/QAQzqX=eiGopyE/zn7GjXAS
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmWwXygACgkQAVBC80lX
0Gyy/Qf/YQEnLknVNvYf59BqN+Y7yteW51UVwToCrwExqkJOv+xuSn+JK4YhtlgU
dXnPHDRDr6yEWyK25+fQPcyClkY0YTX4OubZPyQfE7TCNV7YpuEeuToWJxOSx9Fr
Q21GG9OT9gNKbZNxvFMHYQmVZHisHKido5PqC7g63ngeX48/8hQkU9/g6Avf/++W
XmrFMQkv0KzqjvkNCd8HR0m5wk1z31HP/byHYGadXUuNk0XQURbdQxEPzttAwxcV
k3lFB0QQuu+GdV3oBqu9XPIsw4JJCGUxcU0xaULUyG171L8CEeCmlLRE+ZKl/zPu
vC2FCSfIwRc2Mv69y8+r7+b5YuAzLA==
=ga5G
-----END PGP SIGNATURE-----

--Sig_/QAQzqX=eiGopyE/zn7GjXAS--

