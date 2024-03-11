Return-Path: <linux-kernel+bounces-99560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CABF8789F7
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 22:21:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF27F1F21807
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 21:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59D9856B77;
	Mon, 11 Mar 2024 21:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="WUUoz/z2"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BFE256B69;
	Mon, 11 Mar 2024 21:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710192074; cv=none; b=NNuyj8Kh17ZqQIWm0ae/4pzD2oe7zuP/AWopdNRO0ezzvL5jzG/sQMzNUSPpzx0Z9a8TTd2DjdP530AuJZmZIobl8c27kTHofeq5HUcTodRiH24xB+zIbkilpQPDoANU+Eb6g5QS8d3W5QOpBbki8lCGEkwszyb09O/iSp1nxY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710192074; c=relaxed/simple;
	bh=tiMQ4dnWtJQoGY7uICYYoa0gjXW7tIFAp9DkN+AE0XU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=VxM/Wl4fDKIQGD/No+VmfdgNj7hDvdR3vNIdvHqwpgOXQZ7CS6rhprZwpOL503BTWVsfGXjbLSyXo6wiDDXgNcxRogF9Ft+c6eiK4W1oQDCHeWasZZNmLkG5W5jL9yh6B80TLkalQbwZ5tM5+IcF2kX/IkoAdV39EGQB1Q3gD/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=WUUoz/z2; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1710192070;
	bh=5+upRuzubYIKWiMYOZiYfjy4XDrgZ1Yxy2FzZ03wDoM=;
	h=Date:From:To:Cc:Subject:From;
	b=WUUoz/z27K6+8IMmD5XiVeglW7li52Myqux+BsqxLMpwvCCxaHVHGS+TXDemDERBa
	 VXyvi6Dytu/qR/bRZVIrCTcKiHN3Ayt8jy4uIdRnv7FTmAA73DH12ROxkgeQHKQio6
	 KDu5RnXPK1ypR7f9dt5uqmr7SHxbUIAW48u7A7KRFAwv5phKvIPHxTCzMd/AuA3BXt
	 sJb+gWriiLWz27pnuz0ECx+a/rI0F1+2oy7xdUhz/yIvurlCWji2iI4GDMr4eLNQTQ
	 plL+Z9oJx/HNcxizfsZqgVbYacdjqR/9jUBqqVcOUgIx11j6z6anKlVKS/lSqs79tb
	 ayNtK/Mt1aRzQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TtqT21yDmz4wcT;
	Tue, 12 Mar 2024 08:21:10 +1100 (AEDT)
Date: Tue, 12 Mar 2024 08:21:09 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andi Shyti <andi.shyti@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the i2c-host tree
Message-ID: <20240312082109.3b040f7b@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/EFpDnKTcBvh9zLaC2bA93oY";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/EFpDnKTcBvh9zLaC2bA93oY
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  43f58f3e4b66 ("i2c: nomadik: simplify IRQ masking logic")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/EFpDnKTcBvh9zLaC2bA93oY
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXvdcUACgkQAVBC80lX
0Gzr0gf+PS2PjXSdHWQI4pUb72hAQ+u+13mDsUgkSXFIrKITwyCpMg38d8d4A0Pu
As8cmLcJ5Bz4NkfRipwgmwocUm8iJxOQhrGMXJKHn0xMWhg3WsH92hONSISG29pE
bmnUqqkqY6xqP6Qvu6NhF19kSD1KkhVSUVjMOafyC/dX1stWM+74koDa64CzujvS
RBt0ABzNXvsQBmnnVTbPuoDHhqsn+zJ5ztM8E4hBetpZZ3PU7IRoBjVtrVCW8DzL
pPU5N+SzUYMMI5s353lbaJG+gKqgwJqIq66qIUifu0s+BOwF2xbw8uHP25nuqJvI
tFtPwoRUlWftZ0CpLj2Jf7rH6cYVrA==
=9GOT
-----END PGP SIGNATURE-----

--Sig_/EFpDnKTcBvh9zLaC2bA93oY--

