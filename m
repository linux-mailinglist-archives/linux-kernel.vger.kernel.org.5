Return-Path: <linux-kernel+bounces-43835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7391084195F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 03:38:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A538D1C23E22
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 02:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D133636B1D;
	Tue, 30 Jan 2024 02:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="bV9YhjR5"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7731D55F;
	Tue, 30 Jan 2024 02:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706582275; cv=none; b=KjaCE9Z1afPRiM9yF+/WSQB8L8wro/vw3KcF/m+4XjgeZ55S01GcS9cVq/T31pWP9v/j9hI+88Uxk4+KgxEgANY2sWkS5n3tvLewIt3DRfVSYouoez42/7prnQ1jDQBgrFZptxb8UIGzPTAyVt26TOuUIkY/cXf+Y2wCL4WsdqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706582275; c=relaxed/simple;
	bh=Cx6jrY1LqK0Mi0xtR9ncr3IyboSqCtIVTeXRYU9xQS0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=EB8CfrAbTc50wPcWqaBPfGR9/SYX07Fs2AQPWLE1eMVL6fHypWL3lm6yBJZbjRqunKv04hu51Jr5XM6suR/6rPmnlqOvtaQNgPgUGScQW/egpvSIgUh8APBiFaDR7pQcjdLY10tlvS1BJg+JGbNOeqeTqIR1UH+8ZZSR36Zerw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=bV9YhjR5; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1706582269;
	bh=1pIrZnyMO+/9z4pqrFTOiyJtxbZC4vdz1Rs57pXkRGk=;
	h=Date:From:To:Cc:Subject:From;
	b=bV9YhjR5AfWleeRZLa54gVwAFiKQjQggPAPE1Mf7kVRTNY2RPAHqEY+rK9J8Cimhr
	 SL36OIvD2vtI8Tqhsvyd+oemUCg49ERpKxfXM7h5V/s4HOwj//+V2Fwm5ogYKkMnws
	 gEPxRE3Y0h8+BFMa2UNIhKdzu8+9RMOQIa98zs67k0Hkcml7iBIJVuL+xB2ij8uK4B
	 KG0PyRD3iGhgY0WRxBWWDX4VQ/+IjnVoyWLjwHGm1FNyWRs2Cqiq03Ypp87r7AjVMW
	 D9CC6VuXhr6MT0vXmNd7NlzEDknBp+yYijQWu/epFVlRc4m/sTBhth7ydYVvWopjzk
	 KZkEk5zydWuUQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TP8Tn1gmrz4wc3;
	Tue, 30 Jan 2024 13:37:49 +1100 (AEDT)
Date: Tue, 30 Jan 2024 13:37:48 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Tejun Heo <tj@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the workqueues tree
Message-ID: <20240130133748.7c30d71f@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/QQbdYwxTkUeMtU1al5QzKYb";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/QQbdYwxTkUeMtU1al5QzKYb
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the workqueues tree, today's linux-next build (htmldocs)
produced this warning:

Documentation/core-api/workqueue:761: include/linux/workqueue.h:476: WARNIN=
G: Inline literal start-string without end-string.

Introduced by commit

  5797b1c18919 ("workqueue: Implement system-wide nr_active enforcement for=
 unbound workqueues")

--=20
Cheers,
Stephen Rothwell

--Sig_/QQbdYwxTkUeMtU1al5QzKYb
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmW4YPwACgkQAVBC80lX
0Gw51Qf/dKfGSDCfaimg5w4kWJn3/b12BW0uO11C6eC9b71asCxk4pjT9LhH2LiY
JnmIfMFRzvBX1FBoEFIw6NvBxHjK0jkX4zJ1QEFHAp/JGRjEgSC6zEv9gshDdEJ7
yJgIHet37lj1CekAHjxy+BrWkgJ+ihtbueTwXSWuBU8aP4naf0kl/gR0wEvQDtko
0S3cNMqzPsSzXjNnrZ2GBF+3ZYiEYV+hQCvDlcf8ehb47odEFTa4Gx0GDvE4fhf8
AS45RYznyuPpDAQ8DYDXB09CrYVb2hRP/qi2zznXSiuXzB3B3BsnVtz70qimDkaG
ngKGFu+nEb1m+e7s9+PHRzQkYtP9Iw==
=/410
-----END PGP SIGNATURE-----

--Sig_/QQbdYwxTkUeMtU1al5QzKYb--

