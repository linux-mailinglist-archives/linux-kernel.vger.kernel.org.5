Return-Path: <linux-kernel+bounces-57467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36F4684D971
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 05:58:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C96D41F234E7
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 04:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37A01679F8;
	Thu,  8 Feb 2024 04:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="amrWG92i"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44D967A04;
	Thu,  8 Feb 2024 04:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707368271; cv=none; b=lNg8HNO146O/K9VBHBHJK9Lg1mY6YV0yiDo/BI6eOCylsDrYaHPi2ySoyugA/PTP/MWxtK5AVxD/IeA4bi+0ncXIgROu5nspcMX1SYlOLrI2WFYfTkrxgrDEHv2INF/9WAWOp9aDxXtHY3MIkuQM26wkiIhVngcT5ay7/YyaFv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707368271; c=relaxed/simple;
	bh=3xd/FsavCQp4ZAHKSWb0gXBlZa+yZLHJ7oBTMzMS+os=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=X2cB5XVU2TNwraFt4ZAIR2bAJ1C4Rcx+xyupUF59Wi7ifOwAqO0sH+qPYGV+uceSpP+D4U7PKR+F3S67vFh8gSV9oEAnoy0K0FhZl5FqwI8bkqcSH2F/vcQUro77T4iYHmZnkzwXrHSot4ptUy3wLvehyLH8OMvjW3byLNoc09s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=amrWG92i; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1707368263;
	bh=u6NBGY84qWqGe0BXRfvuoMWXqSTDLCHF4kDelqZIKU0=;
	h=Date:From:To:Cc:Subject:From;
	b=amrWG92iJbv4jHSEc0MX+nCrZbe+of0Fe8wRMcz6mmvx8aG0Y7BI+vDsV+q7lJR4j
	 uWg2Wipfoiqn6vOctFT9+eoTipMpg7ep1sR7FoffMUHDxawSJvGqHxY7rKKT9KJjH/
	 v4h2daxym1vKO/2IBS6Uxm/JXQwod5QmHMSU8wqZIy4qYvwVUBHYQE5XJVrF8x4QaL
	 Hke9MHdeQ3a/jA7kGGpE6mZkrckfHjnVDjk4IMAi39WVguz4qLLehnT4Oe3GZlTF54
	 GWbttkrAAPr7bcDbfj4cOVyn+EBzyYzJdrdRVSPpLBN6Ow/qDjW2H50PTs3onQT40w
	 wmeprIuhv2rYw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TVl931Wq2z4wcJ;
	Thu,  8 Feb 2024 15:57:42 +1100 (AEDT)
Date: Thu, 8 Feb 2024 15:57:40 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Pablo Neira Ayuso <pablo@netfilter.org>, NetFilter
 <netfilter-devel@vger.kernel.org>
Cc: Jozsef Kadlecsik <kadlec@netfilter.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the netfilter tree
Message-ID: <20240208155740.24c6ada7@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/rVS5Vb4RTPE5xqVfSHwkEww";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/rVS5Vb4RTPE5xqVfSHwkEww
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  6099505cd2a2 ("netfilter: ipset: Missing gc cancellations fixed")

Fixes tag

  Fixes: fdb8e12cc2cc ("netfilter: ipset: fix performance regression in swa=
p operation")

has these problem(s):

  - Target SHA1 does not exist

Maybe you meant:

Fixes: 97f7cf1cd80e ("netfilter: ipset: fix performance regression in swap =
operation")

--=20
Cheers,
Stephen Rothwell

--Sig_/rVS5Vb4RTPE5xqVfSHwkEww
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXEX0QACgkQAVBC80lX
0Gykvgf/URSkBdOLpsC5GItUb2aNdQ0a6eWMgUYZ88fRAOCr2KSK0vspxzBh0yaL
k7BzaxTU8X8Z+cA4b19OWc38QoTMAvokhsVC0UUouC1YOqL++KDB9Et/uMWJwod/
cuHvcJ3zT5bDRlwkNx0NpRmS48Gdf3ww/kznGLJ0rXZe0j5RPIaihnpILkb6Efkm
ao+Yly0JsIfs+l0h92M2x0USUqYKBRnZq7P80rX/3LX/GtsZOcV72iuMWpWZiO1P
dGysbwwU3lDS6bwmBFAa5yXTfGoL6zEMQS2HQ+jiMgycbMmXFOPTHAsbkOCYmUt0
Ins8Fi4ZHbE47OUh5aUBVkCAYunhWg==
=PZHG
-----END PGP SIGNATURE-----

--Sig_/rVS5Vb4RTPE5xqVfSHwkEww--

