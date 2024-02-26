Return-Path: <linux-kernel+bounces-80603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70675866A38
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 07:46:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 060AF282A96
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 06:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C51901B7FF;
	Mon, 26 Feb 2024 06:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="ubwh1ieu"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C522717BCB;
	Mon, 26 Feb 2024 06:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708929989; cv=none; b=Zb6h0E+YY54RTQZ6el/gAnDI5CS0/iMaahQgY41+82ppJzdeBZa8TZBCW/hwEmpZK2+qpoMuTX3r/MKgk29gBXNQuLgmXeu7pBEqPjWUulm+Qu1WNhbsgPTO5Q/saUpb+Iy8XpX3RwSTY/NewN96JGbmaRtQMUa+JxjnmtMj4M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708929989; c=relaxed/simple;
	bh=4JQdMRdXPGOg6wErfZZgo+dbrhFcSXhjDwpdnFEwKWo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=FSN6kx4KkccsxS0o8tjohWvW8GkbiIKA7cD1Zjv4rF7mrPE+W2YPL2cMQdLhIqqevJ+SwWN5f9Fve4b3MuwtLb4N6TOBmFctF6s8PAJMLrtesFa9i46wdshbl8+lLIwvbYeu6CqEt3gI8Hc7Qi88Qm1w2+lGAtHwbHtoxnzEe1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=ubwh1ieu; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1708929985;
	bh=EnC58pb8OdSuXwDHDJ8jGc501Z2pV3db0m/2bPCC2aY=;
	h=Date:From:To:Cc:Subject:From;
	b=ubwh1ieuICciZian52EcWd0dlhUx7TF5Tt/6dzaKJQFCws389IWfSXQme79GXfFVC
	 3keYfpRJyaO4tDzehj8Fkh3f0OdBoN4qbNP4TTvaN1ITtK9Km+BKmZe1JEmiIWYahe
	 TDefz36xz7TxenuaiFXChpcC3B2YOy+3lGJv0d88deKu+MXSpblMvScCSK9x/ZZgYM
	 JZiEOl5EQTQFjbWh9JTa01Pcowmvflo7RxzPh8lssU6ampID9ULBdgWK/yDnlXAS29
	 R9drVvJuuo3xpFY9kdry8LBAZIbHwz2x1UhluSE+9T0R2YXIlRikiQ0dpzarUcplZw
	 D1y1R1fSEEFKw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Tjrk917v0z4wcC;
	Mon, 26 Feb 2024 17:46:24 +1100 (AEDT)
Date: Mon, 26 Feb 2024 17:46:24 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the bcachefs tree
Message-ID: <20240226174624.0d759818@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/rZ/AJNN_SJNc3_jOHfDc9LC";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/rZ/AJNN_SJNc3_jOHfDc9LC
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the bcachefs tree, today's linux-next build (htmldocs)
produced this warning:

Documentation/filesystems/bcachefs/errorcodes.rst: WARNING: document isn't =
included in any toctree

Introduced by commit

  8869a56a0158 ("bcachefs: Errcode tracepoint, documentation")

--=20
Cheers,
Stephen Rothwell

--Sig_/rZ/AJNN_SJNc3_jOHfDc9LC
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXcM8AACgkQAVBC80lX
0Gy/bgf7BM41I9IEdFbB3upzFN6eD7Suxeu1U45Hy9YsTr/JW7rRvFRmzW3jsw5I
b/ySUEBLPvzwaVFJ2HsJm1QbDgDpvEdTzCtTGFD22cGpmGNSxHUW7MTzZCbNurRP
3DW7x9YQE47ALL0Tethq3sDJ0lpZAr1uoGtVhJ5ZhSoSu2sufenSKy+RKQV2Q+gZ
Vtaf8oG6EZwvuFPjqf3my3T3KxXeDxYd9bCy0fO6kVEYV7XcKe3ZsyWGPHVUSwv/
wditUKhWSNpbusHHciMlV0UfMHmo8WjoYl7iQyrxRrDqvuBBbEkDS97U2f3H93rS
cDvBeJcbiMu/eZILePTQa2+c1nnzlw==
=aIRF
-----END PGP SIGNATURE-----

--Sig_/rZ/AJNN_SJNc3_jOHfDc9LC--

