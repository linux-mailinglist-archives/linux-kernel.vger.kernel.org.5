Return-Path: <linux-kernel+bounces-167225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DF058BA5F1
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 06:16:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D86B1C21B2E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 04:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA604225D4;
	Fri,  3 May 2024 04:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="CMI4nB81"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D171414F62;
	Fri,  3 May 2024 04:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714709755; cv=none; b=SiekqW/vtLQF+g4x0AOTenSnnuKKI+IK5TG4ds6EHgJch8gw4uDgoRuwidj8Thirl5Njr8NdSqPSSZZbP7hACsZgXvawxuU3SRTFy43G5gaVCvuox3LxytPAXDHc2aSw9QJbgzrZ6GML5+q4OGPLaD4vxM5B2EqFEYijLBztZnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714709755; c=relaxed/simple;
	bh=lPqe85pM4W2pYPWMbI9MYc0iYmVXHeMyukbcVlZ6P7c=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=mjiggG/p0f5bRtztr03lo8It/JlBeOVUOC1AcWp7h226nz4RH/ywomLn3f9hqlxbuHu+TLMBwRLd4byMA16VHUGEtbNGTovFI4Cf/CVP+u59RUIZCkILY4UeH2/Huj9QUZgGv0pih6/O5474fwJHA3bP4e7c7/eIjpCs+ONdwkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=CMI4nB81; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1714709750;
	bh=opj61usVq9/2yjNFgbIoxgy04FK0ojr7bXPy+qKi/xE=;
	h=Date:From:To:Cc:Subject:From;
	b=CMI4nB81hUcbHqZnOkNchl4tvJqv4q5Iqkc+KrTvubCivIajWhJYthgu9YeYltyIY
	 B5YW+DPlCu9fUv35tsRjylserw65hxZDAEXgIoKp+V9FGnJGCGbJgH/ewdeHqFjASj
	 GM85LhYm7gJf6A7PQxAHO69+rdazhgFf9CsQBCmKH+8Y2Hfl132rS4cS0Hj60YLAWA
	 a3nSpyLEqZfS1HxNGAAEAxVh8VA4qZrIjKNDF8nyV4vMrNPvkVGLADQDQxo4pfqMUq
	 3ZsC5uHkJAKkL9e/yyg2PsPvuNdm7XRidx2uHCzCXizSBzFhlPvOwjEYNPWcz5GGOH
	 JDWUjceNgOLvg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VVyCV0Vknz4wd3;
	Fri,  3 May 2024 14:15:50 +1000 (AEST)
Date: Fri, 3 May 2024 14:15:48 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Rob Herring <robh@kernel.org>, Lee Jones <lee@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the devicetree tree
Message-ID: <20240503141548.68c2b106@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/cMkDskkwLKOtLWJMDJm5ra=";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/cMkDskkwLKOtLWJMDJm5ra=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit is also in the mfd tree as a different commit
(but the same patch):

  828215066d88 ("dt-bindings: mfd: aspeed: Drop 'oneOf' for pinctrl node")

This is commit

  8f553c27697b ("dt-bindings: mfd: aspeed: Drop 'oneOf' for pinctrl node")

in the mfd tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/cMkDskkwLKOtLWJMDJm5ra=
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmY0ZPQACgkQAVBC80lX
0GyyMwgAmDU4UaerScGA0aA22rIWy62bYa9alEWdZhKpxnM9otjwQdd6BqGH/Gr5
ptlHmXbzgE8urpZ9aHM2c4zHDDYBi25bAT7oE44ZJ3CfH8w1pcVY95nRPpdm2P/l
qeeumcS3PmFpoDbM0u1x83GER2c5a/XbgQl9f+c6YgvRGOE0Sk3VOhtdG7vBlQxL
I0uzCuMFGViMhhgOIpkZn5Y0a/ZieTuhoxTvItFx/HEBn+MJ4/lruUQ8XcpjGjcR
2w+KfTlBDImKz52CMim7HHiZfZdfshhOeUEljGVb8vVg7gcOui1kJOeb+hQ99yVP
lmtywPuVvEnRfBCzHgQokPKAGju9Dw==
=AHHq
-----END PGP SIGNATURE-----

--Sig_/cMkDskkwLKOtLWJMDJm5ra=--

