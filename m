Return-Path: <linux-kernel+bounces-31989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C66AA8354F7
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 10:10:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAC3D1C21511
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 09:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B20232E3FD;
	Sun, 21 Jan 2024 09:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="WhQdjtZL"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577DC22086;
	Sun, 21 Jan 2024 09:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705828196; cv=none; b=eHYC+/fk+Z1Q/bikbjUgF2O+thNrZpsIhymMxAP7FgRHPwd6Y45srMyrf7plEL8GKyz+dh2dZ+QxJ1fdgNa+n1YfC4ofo9GYWt57FLo9qRx18hp8PVo1Fxt79r64TTc06rgFMUiNllhnUVFU/ddfiCyG3J27jf8uRYT4B8ljKzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705828196; c=relaxed/simple;
	bh=5uUEUl88Mro0xgkG1Sjv5Y/mEVgGHsAyqnd9iXH20Ho=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=M+wzvxMqt5o4e4nry7XEb9itB323P/tGFP83vToFtw5IQe1NYrQpsgg2gF0ZJA70bx9UdhkMhHqrHjFICjKmspHAaiQUcspogQ9gp5UFm/NcLl0iaeRiGW2fQ+fqLMTODxyqoZ0ckz5z3MslpJxlO4zVSVh2mbg8kSiYHcr9E94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=WhQdjtZL; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1705828191;
	bh=HP/FNm2ibD0SL9ihdibQe3yQULw31Y38Y+OIDXXFAVU=;
	h=Date:From:To:Cc:Subject:From;
	b=WhQdjtZLPDXgZ18Y7X04TPm+i7VOgWDt9T0XeHQQmNHnd97TVsUr5gFR1dicxNifg
	 k9rKWzCyHpSW67RIcnlOLPK8WYjaFRJ8gTou5uPQ/y9n0LqMbe9j9VspDmaImjkL+R
	 GkdkxvPlJmLR1c9on0ZvENpg6HJPTxQPfFQJyvsQKeaVdXGkknNUM0gj4g84u3/jcQ
	 /SA84qdrv6duadjheYGbUwZTjTQzOzPlQeOOJdM6vJa/rhR0g4saYnVdzf1Y6xVxUr
	 Cdb8KqXktCC2dEj4cVbJE7E0V4tLFv+vfc+d5YAiRhQWMVMgFs4By4YQbIeZCORcYP
	 Mc8w2Q/kmy6yA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4THncG6P9Cz4wd5;
	Sun, 21 Jan 2024 20:09:50 +1100 (AEDT)
Date: Sun, 21 Jan 2024 20:09:48 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Kees Cook <keescook@chromium.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the bcachefs tree
Message-ID: <20240121200948.75a85811@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/HfrPOO2Z2azyRPTIq97chu3";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/HfrPOO2Z2azyRPTIq97chu3
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit is also in Linus Torvalds' tree as a different commit
(but the same patch):

  9d9487185411 ("bcachefs: Fix strlcpy() usage")

This is commit

  e28b0359587f ("bcachefs: Replace strlcpy() with strscpy()")

in Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/HfrPOO2Z2azyRPTIq97chu3
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmWs31wACgkQAVBC80lX
0GyW2wf/Vk4DHmPlkXVv1x5rh8nfIOM4H+N36vwE324tVd4HHB87OfLmvf6JsEQg
DEpgNG4xZjCFBcquabaJHEUN30NF0KsCzcdLRe1WJZKdGm2rbTbrtIHXAsYW6E5R
vOY3tVmkO3LIHhMWZeHZu1AuCJWg1mlRqRdQ/5q/rpDq4KlZn5797jRsCrUdVyTm
nrsJEohkNtss7W7dPJhgHNIDO8WKuHw1p+JwXsSgGAMCwjSIRFuE2gZFmGrhqjGi
k+BKeNWefDXd8Mo8b2FxO0VqFzZOkexwCXgIeuVsYLzPgyragxZ5dWSmvZ2yI0KK
BxHZWNTyy2UNxnipUXWNyrjUs5k4mQ==
=h+Ck
-----END PGP SIGNATURE-----

--Sig_/HfrPOO2Z2azyRPTIq97chu3--

