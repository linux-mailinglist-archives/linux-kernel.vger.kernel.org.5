Return-Path: <linux-kernel+bounces-51957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 513658491E2
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 00:44:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A453281A27
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 23:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FCD110A31;
	Sun,  4 Feb 2024 23:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="GyMCu071"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF82FC09;
	Sun,  4 Feb 2024 23:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707090092; cv=none; b=PrVnlE9uuTYSOd0erjVzWyOXkP91rlY/EiP+zdIMf2EODBFnfGPpQXqnrfE2ybZcM1hBj4iXLmZBKH0jqgasTg6zqvlf75OMAhn5Hr9kNfHz7GWoMAkMl6pksyx0HMYgwcVkzXSvG3KBMxNNu/NjQ9B1uXvDkH4gTs3yhWWKE7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707090092; c=relaxed/simple;
	bh=AUJblLullMYa6PSexebsKZ4W9o6jjDUEYCfxnA57QjA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=SQg98Dgg+Vk6dT3AHfLamUp4uUX0kZUWckY/OR3sGCKOL1CjQx37Q2yTVZ+h8WtLGk5pmSMi50jq8Z8bM7UGl56vT+iMW9xcY8UpQaswrlabqe2CN7XCyw/+NDk0xfF3Qdy+vfcniIu28Yp3kcKqzmMu+L67CX/jhSCL//2V5wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=GyMCu071; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1707090084;
	bh=kIvMjRrurJdUb2q5LywogFzgihrrGdXpP6w3QkxneXE=;
	h=Date:From:To:Cc:Subject:From;
	b=GyMCu071t1OpWson/pw36b+KV3sjGQ7FqRCSa8lkX9vj9Jl6ozm3X+K7LrBqwlE00
	 ZdmhC4He/bb2F8PGg8Yfc3AN019MtvixHmEeTSr9M1EChLPv1jra5ebhQeuUcoov/C
	 1YgHMqjQKWh9/rLP0++VqsZloqqtN65kEye8ruviye+8DsngxLwlKNosiY6PfLrBEi
	 lubVHFkyrrmXoyGBfenr1WBuFefWK3LaNOKVsGzD27+WXfv50vCcmfhdSea5f8WQb6
	 oqjO9smJzs2CfYqhgekqtMF9rojHzUwWnGagRLv9y1Z+ISi9JjTRRXsaYOT6BUOrjK
	 fQrvaJP984rTg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TSmHS1bgqz4wyY;
	Mon,  5 Feb 2024 10:41:23 +1100 (AEDT)
Date: Mon, 5 Feb 2024 10:41:22 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Charles Hsu <ythsu0511@gmail.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: build warnings after merge of the hwmon-staging tree
Message-ID: <20240205104122.0e438076@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/5dCDA.CL8OyRVd/Yaet/omx";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/5dCDA.CL8OyRVd/Yaet/omx
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the hwmon-staging tree, today's linux-next build (x86_64
allmodconfig) produced these warnings:

WARNING: modpost: module mpq8785 uses symbol pmbus_do_probe from namespace =
PMBUS, but does not import it.
WARNING: modpost: module mpq8785 uses symbol pmbus_read_byte_data from name=
space PMBUS, but does not import it.

Introduced by commit

  7dd62e578cb4 ("hwmon: Add driver for MPS MPQ8785 Synchronous Step-Down Co=
nverter")

--=20
Cheers,
Stephen Rothwell

--Sig_/5dCDA.CL8OyRVd/Yaet/omx
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEyBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXAIKMACgkQAVBC80lX
0GxFrwf4vcUXXqugPcGWTMP8i5kPEDv1XPvlCjVOmFGLpa8JagOEmAjQU9CXsJc8
wuO6pTf1d57SqcQ1DHmqHRA3Rg2fIG5rlEnTMoqPhh+5r4wv+dh14Nk38UDXQllZ
c/kjY9WDvV+hIHIt13ZRDaxGJCse6LbjPHiAjmzArPAB7KcDZTyAEtXoirPFFhlP
Tb901Qu1N/LWuWx+aEU7dlXO+oLpJcd+zbgfTxkDJJMJEeoI8caT0JIOXlK9w940
ujO1mrofRskTOXu0hblqRTbUXyCRmUCQP2FSpi+RH/7GDJ6XVAuhp6qtGr991JoB
GKG7mB7ACumQ87bAKH+++ug1KpwV
=HuTP
-----END PGP SIGNATURE-----

--Sig_/5dCDA.CL8OyRVd/Yaet/omx--

