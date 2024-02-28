Return-Path: <linux-kernel+bounces-84489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4DC486A759
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 04:51:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F7741F241BE
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 03:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D53D820332;
	Wed, 28 Feb 2024 03:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="VOV2co6s"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34991F94D;
	Wed, 28 Feb 2024 03:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709092304; cv=none; b=BixuWzVmE13Q0rqgjRjE4AhpL8kEhziK1MkeOkz1McDujw59wQGjlbECgP/Y/z5gj9eKF7OK/ayeNZZFmU8s6ZAhrFxpIF3SMA9xjwNV/diJqZ8r2V3tVtNIeLR5ey7ydXP0io2n5t6BBJ8b1ry4BgkHGfX+hZuAmIWW1dcQA8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709092304; c=relaxed/simple;
	bh=8MVLVlrqD4j9HSuUdXtNL4OD++UUSJ32JL2smhWfInU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=F/RZ6ckOG0ANNcGPrseToz+29Zq/GqoUH9VnT3RmWSh06n49cVCIyLlnRwXF/o/jBhV3Cvpq6VjVyK5sUQ/PaowEbuHETaor7IPeeaK5vGgO012Z59KpmK3rd7841VlWu36/dIcJ37KSW8cd+4EiqAyQPatYg4XS/Ue1abF/AnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=VOV2co6s; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1709092297;
	bh=NJnamOiEuScuE3OfMKj/+x9Mr4ZVQY3hwB3v5cD2PEA=;
	h=Date:From:To:Cc:Subject:From;
	b=VOV2co6sN94QPfX4kbPRCUP6cBB8OA4/8ciXubEZwLqDK3BqeJUGHGRYHxSqR1q92
	 xS30UDpFZDFEaAzhcWpV2fsFT0fY5f+F9Sfz7VppruXG5/fiUUaY7W1WFfoLwb12Yq
	 99ME8jwZNzehDoh0BaoOUtLIYW9eY/12sIypYvrqSPAcQP9uU8k9wuMF0D0uD+Adw1
	 DJTTwf+cbb786EK2mf9UE/Fptb4T6WThQXwMbSHyfr0D6shH6e3pr0LjTX/cWYKPpo
	 TgST8uQ3phO/ELlZwFPmB/clKrOEX0zPFTYPUvYp1tOVk48bOxHnRKrnLVtwIj1Srx
	 1eujNEt72YWbg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Tl0lX6dKzz4wc6;
	Wed, 28 Feb 2024 14:51:36 +1100 (AEDT)
Date: Wed, 28 Feb 2024 14:51:34 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: Ramona Gradinariu <ramona.gradinariu@analog.com>, Linux Kernel Mailing
 List <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the iio tree
Message-ID: <20240228145134.03283c42@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/gi9v==n2V+dx.5Nq7v=D=qJ";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/gi9v==n2V+dx.5Nq7v=D=qJ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the iio tree, today's linux-next build (htmldocs) produced
this warning:

Documentation/iio/adis16475.rst:317: ERROR: Unexpected indentation.

Introduced by commit

  38033fdf3b09 ("docs: iio: add documentation for adis16475 driver")

--=20
Cheers,
Stephen Rothwell

--Sig_/gi9v==n2V+dx.5Nq7v=D=qJ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXercYACgkQAVBC80lX
0Gxz6wgAg2MVx6Z4x6NvdH3m83bSGdyhpbU8A1mSTSxlVcJL3qWGFpYnbhe3n2QE
DAJNrGnXZ5p1Z4hIZMTvIhaVc/pq5LWnVlK2SC7e/vQIgaGYcbvYelBADQotb8Yj
Bhn0jJKhsP7PWUZ/9qKcv7IE/ozi7H1AC3Ay8W5sfViQGY7IoowdVgH/Pcc1kH3c
QpDBZC2MSLbMEnnFC5ewO9XXFmyPbUXWgCmu/hNBifbpq51ePii7hvpAE2GUyL1l
Vg1APMjf7dhldmcBYGvqzEOAf+d5cPqmIF+0727FsGco4eCLR54AQ3GGi7COdk00
2h5EqFHMhh3ndssK6NLRFT5vGWuyVA==
=WIIU
-----END PGP SIGNATURE-----

--Sig_/gi9v==n2V+dx.5Nq7v=D=qJ--

