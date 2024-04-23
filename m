Return-Path: <linux-kernel+bounces-154358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D8C18ADB32
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 02:39:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 442081C210A5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 00:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D213EED8;
	Tue, 23 Apr 2024 00:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="SDLZfVyy"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7F16AA1;
	Tue, 23 Apr 2024 00:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713832783; cv=none; b=SGIfprtgfd9fTLlAS1FR8TwjErdZ4G4P6be1LJtDuky2pLyYKE+lXIGH0U14lyzASc3hQuCIqL7i/aLFsOUa7gnTNY855dTltfjdQsQUhz+/hI99T2KXXoW8T8QjQo2y05miC6e1EJ3TX3lK2BlkK15xGk07It0JMU+IM2TA4OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713832783; c=relaxed/simple;
	bh=agZr6c/xl9fEJY1kZKahHC4ATQbeGwxR+gGhFXXjFDg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=ti2m/R1JcxXAp209ggoW7pmbKrmnr7tjm1i3IXvXjDNC9w+4rNZqjTDfG+Lmixbe+jn0RxY7yfHACpG3h+efXVcvvmKh5MG+KP/KJaA5+uK+KkOwl8j18Pn4S2Iy9YbjnNt0WNO2TYjCiZhS7TTuX/XBfPnkZu+NUadjCEjvfZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=SDLZfVyy; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1713832778;
	bh=A8sYhUte2phTFGEt9R3CJDI4XFlLj/ipfjoUAO0mtt0=;
	h=Date:From:To:Cc:Subject:From;
	b=SDLZfVyyMAisNZjQvlzw6t1Oka4nVI28yS2le8FlTYgHq1wxLjcyHDXZbSR76GmPo
	 F3XzOU4Hww0W/sPFfFZdMZewF3bVebVfcgH5zZgT4WcknWe7McQKtOgIFvyvRAtvTI
	 a7NyZaoeGx3Mx101RMiRU+pnmSAe9UQWCXF1h3KQAvL8VHviQbqaHjTUo9x2zBfHzd
	 zG3t+FzQ2u28AJO7dY0f5BjmFYJFMVa60V9TRpkcWiR9JUuR8An+y72kL856slZC1j
	 mOEWxQ/foZcaOhjuizJTwyYf4KD8F9jdcYYkjVlRq7Zyo2jKuBtKaFPEhtBZQhntuL
	 mCCFhZy7O25PA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VNjtf1Qflz4wcq;
	Tue, 23 Apr 2024 10:39:37 +1000 (AEST)
Date: Tue, 23 Apr 2024 10:39:34 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Mike Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>
Cc: Cristian Marussi <cristian.marussi@arm.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patches in the clk tree
Message-ID: <20240423103934.399e2a6e@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/QX60uKT_F43BmfRZoPMp/_=";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/QX60uKT_F43BmfRZoPMp/_=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commits are also in the scmi tree as different commits
(but the same patches):

  87af9481af53 ("clk: scmi: Add support for get/set duty_cycle operations")
  fa23e091236b ("clk: scmi: Add support for re-parenting restricted clocks")
  c3ad1d0a7ef2 ("clk: scmi: Add support for rate change restricted clocks")
  a1b8faf8784c ("clk: scmi: Add support for state control restricted clocks=
")
  2641ee13c449 ("clk: scmi: Allocate CLK operations dynamically")

These are commits

  ca82ded0e3dc ("clk: scmi: Add support for get/set duty_cycle operations")
  3a0501ad6fd4 ("clk: scmi: Add support for re-parenting restricted clocks")
  4562172e3ec2 ("clk: scmi: Add support for rate change restricted clocks")
  6785c6c261bd ("clk: scmi: Add support for state control restricted clocks=
")
  4196d89b2393 ("clk: scmi: Allocate CLK operations dynamically")

in the scmi tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/QX60uKT_F43BmfRZoPMp/_=
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYnA0YACgkQAVBC80lX
0GwIrQf+JK2LgulV5HZfVZwyy7AcDsqm1+RkWfDrsDPGvidN5oQ3zJ7U834cJR/s
do/7Z/ihnHfbkAl817JStgIUjpzv8hB7HlDl5QOawwqSdGnaerb/Njb6zvR61vYO
WXDmafB9PwEbyY+Rr0iqiUiq6jJmGH4I35DWYNstFRP288r3LxxPytz45+O4ixdd
pDuS0F9XcLp9j+Tm9LRsSZ/tZS/bk14w+glIbglt+IWN8/TIEMzeVFEJSo1Ug6t5
M2ZRd/pp5JDD9HtxHyR5JAdfvLQbmLyo62NwXaVwsLxaHcTpB5rXCN3p4pCEsUz8
LLyTRDLUSOwnJbxFeAh6WdHzQyM6Vw==
=ExKv
-----END PGP SIGNATURE-----

--Sig_/QX60uKT_F43BmfRZoPMp/_=--

