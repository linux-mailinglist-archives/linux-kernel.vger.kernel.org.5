Return-Path: <linux-kernel+bounces-100835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 51C03879DE4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 22:51:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BB671F21F6A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 21:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26881143751;
	Tue, 12 Mar 2024 21:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="GBTcO4cd"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4696B4AEEB;
	Tue, 12 Mar 2024 21:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710280303; cv=none; b=GXhlKAr9BGF0rYelmDY+601s9Cc/NPrS7XsXrAkawywQWzc+VMdAQMUFZyv7VriP0Nv375Os4cOteB72reIvltZWY452hrMShUXz5Zv3CzdHSytI0vKcG0Ijko0al6rSN18J/+k7TothrnQFsxJ9jqNL71dTh7qZr51irETfp9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710280303; c=relaxed/simple;
	bh=7NqfT9TdaICSlrZte0UgCg2l9YA4Ye8LMG1y7vQ4YSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=jDYseYLXiMpn0jJMdctTwtNvZc3deePXUBCS16N1OXzt9oJAvk2U134bw1cGX+n2NqWYJF0jK0SiDEBUip00+JbD+HgLW13A6gaMB0OTmSVZcDw9AfB1pcb3sklR1Wvwkq/RQPKSpfUCc3uyOzof6Elr0+Z+pO7ICL6aSE+5Whw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=GBTcO4cd; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1710280297;
	bh=NfQLoHYJ5DClXcTQfww+2SzYHTQ8VCi5zsfEcgF2NkY=;
	h=Date:From:To:Cc:Subject:From;
	b=GBTcO4cd5pIoA8qLzrR58SF7RhnjftJttvDke11txK/Q2jXKz49wT+nF0MFV/D3hP
	 SdP3nfqdn8YLexcjTX2mLSbEF+NaGmiDxCFih4O7qjP7wNvQqEcjqeAc+nlz1SC5OY
	 00ydZW0BQIOT/jre7HYlbh3G5j1MX1SV3dq2q0UpJ2aRYF6ByiSug//3iHKmypYweA
	 dXxnaKF4kvaH1VaAzWmpboR7qVTjQuBpLcGl+Uqf+tNd7tOxjPpFDm1LwjnhVMcmxe
	 xAzqMUi3HETLhjFDyGRcQFSb0BlzMxbefoIpwUCuyn4/fahAyy5tPZYES4xMIqgUpN
	 fKnJdIjePcknw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TvS5j1GfHz4wcT;
	Wed, 13 Mar 2024 08:51:36 +1100 (AEDT)
Date: Wed, 13 Mar 2024 08:51:36 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Takashi Iwai <tiwai@suse.de>
Cc: Johan Carlsson <johan.carlsson@teenage.engineering>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the sound-current tree
Message-ID: <20240313085136.056eaf24@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/yuQLNtLuXwX5yCCUtDYktAx";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/yuQLNtLuXwX5yCCUtDYktAx
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the sound-current tree, today's linux-next build (arm
multi_v7_defconfig) failed like this:

sound/usb/stream.c: In function 'convert_chmap':
sound/usb/stream.c:306:34: error: 'chmaps' undeclared (first use in this fu=
nction); did you mean 'chmap'?
  306 |                         if (c =3D=3D chmaps->channels)
      |                                  ^~~~~~
      |                                  chmap
sound/usb/stream.c:306:34: note: each undeclared identifier is reported onl=
y once for each function it appears in

Caused by commit

  a94566ace3ca ("ALSA: usb-audio: Stop parsing channels bits when all chann=
els are found.")

I have reverted that commit for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/yuQLNtLuXwX5yCCUtDYktAx
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXwzmgACgkQAVBC80lX
0GwscwgAlXVVuvuaUyEQ7JabKXohY1sAKqXask288JoeLabO9BQ5FituhwvBLjgH
p/n5SZgijHJTgajQlnHduxalnsTwCqqg1CR4nNvhzRoizcfrJuF94FU9LgWq9fQ/
mGPE8ijMAT4LJzu6nP3Q8q8+hAgI3NR/S3zItb/7qmaO+kqWWDhYUklnOBG+j9Lx
ODPpP9icVTGqdrC4fqmGtRSHdrFqLxVZkT9RmJ9hcuglw6IcTMds6nJZLSEe7yeZ
l0cTQYhRbivIY90Hc1caZMNyN4YHd52+0rdvt2xPmLie9kYBecEEyt986Xe6Zaqz
3FEQblwf0FNVLczFDGmzlZRFKBoBQg==
=W1PY
-----END PGP SIGNATURE-----

--Sig_/yuQLNtLuXwX5yCCUtDYktAx--

