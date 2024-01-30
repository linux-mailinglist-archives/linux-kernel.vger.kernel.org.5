Return-Path: <linux-kernel+bounces-43862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 220ED8419B0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 03:56:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D04CF28285A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 02:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4A0E37141;
	Tue, 30 Jan 2024 02:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="jg+p2Zat"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EDC2107A0;
	Tue, 30 Jan 2024 02:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706583391; cv=none; b=ZaePJMt+ybzxhpxbT2LF/jq5D43w3JPY4C2V6qF4u7R0dfU1nQ3R4uwk9WQngIHSZfMjl82Jodio9qNZxcH33o3YZJIDxFF+VfuSK80XDlcSp5+BoKXxeaNu6IiW748LIkveQTkCJAK3SrBu/n3dbEnHxm/r8it5Nl/hxrvWz3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706583391; c=relaxed/simple;
	bh=Q6uAVkCoaKODzrYKLAnOwDwx78tGKRAr/VKY1xyQfbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=IbR+d3U1IxV0vVeaWFqTU1MEleyncQ+j1CVE6bqX/xwP7QkTM/GIxTAcyofONb2op2pCX5N0qEkwD7OudJUhG5f13jSIpJVaTcQvB66eJ3qtLS119L/mw8HPccZgNglNRSlfWM0Cv+hPTsO6S3//9JeTflrJ4K4oajaQy4X+koI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=jg+p2Zat; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1706583387;
	bh=0+EOYfajcZ/TV+MFrlf2z5WbLeXPsYHm5PqylBzh6Vk=;
	h=Date:From:To:Cc:Subject:From;
	b=jg+p2ZatK/eC2s7rUc+v7K0ejBoocfJRSQOFYbeyha3DL8ocF7twEWJ52UbG7EO8P
	 jjd9jvPywQUUENjc8nB+tojgdwskRWwX+55cl+omn2/gle1idU2EQABfL5KVkid3b+
	 HlcQLFxektR1FXnzqvZVV8BSjvcjXxeLDFcPxqTYI8bHIWKH1u2Ss5BHSYuSl7FrNd
	 GsR0/efc1DQUugBiKf8YlV96GG7kMatkjdct+8+X7efScmPb2+FakvGHwBGc9YJKe+
	 ImASSNncaicoRGM6fvkaWRG/PhKuutnqx27O9p0zrLGFTnIqLT+I/pTecNKuR3oKKp
	 o+i7GftnB+5bQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TP8vH4Hmxz4wd4;
	Tue, 30 Jan 2024 13:56:27 +1100 (AEDT)
Date: Tue, 30 Jan 2024 13:56:26 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, Rodrigo Siqueira
 <Rodrigo.Siqueira@amd.com>, Dave Airlie <airlied@redhat.com>, DRI
 <dri-devel@lists.freedesktop.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the amdgpu tree
Message-ID: <20240130135626.312c7ebd@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/yC9TqX/56zDEg2S45L_X2UM";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/yC9TqX/56zDEg2S45L_X2UM
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the amdgpu tree, today's linux-next build (htmldocs)
produced this warning:

drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dio.h:1: warning: no str=
uctured comments found
drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dio.h:1: warning: no str=
uctured comments found

Introduced by commit

  d79833f34bdc ("Documentation/gpu: Add entry for the DIO component")

--=20
Cheers,
Stephen Rothwell

--Sig_/yC9TqX/56zDEg2S45L_X2UM
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmW4ZVoACgkQAVBC80lX
0Gw3zwf/anEpXHd5gKFWQB4oHjXW0ubKX3GOREnVx2bDMhw31uwilKykLMHrZmGf
dkgUSj1PIevfecSsiuZ8fatDizTPFMXM27cSlQDGyKqHRB7eUuikYQlS1MqqR/Zl
VnK2+HDzqqgbh5rZi5PMVeLHNY7ayr/mNGX2Gstr0YU40XiojL4ZWxZrXNbVWgB8
xa2n0cqUdc4jzyiB5dD6z2W+bRsaw0GhlPjZo860oQl7LMnsDEaBcm/6K17oy/h3
NcLjoZzXr5Pn6QjTo17srl7gpqtl2ldCEb67rUcxYQzfs1XUeRYbdMcmZLjcFNIM
CZFuwwvkcV14erWSrbEI0GIIoYRbjA==
=nkZd
-----END PGP SIGNATURE-----

--Sig_/yC9TqX/56zDEg2S45L_X2UM--

