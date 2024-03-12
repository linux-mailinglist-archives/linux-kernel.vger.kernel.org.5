Return-Path: <linux-kernel+bounces-99853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96AF2878E5B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 06:58:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00C8D283B6C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 05:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D124C2E3EF;
	Tue, 12 Mar 2024 05:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="TCZvuQiK"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9F11CD33;
	Tue, 12 Mar 2024 05:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710223118; cv=none; b=auhp+IGiYKLcDp2+Cgm/D3bNq26lB1g09paguayoy/G2vhDQb1BYfmO5ivu5elAczrU6yCEZFL0bNmOaBrVO2EbYjAQ8MAYjVzb1VWJXNfMNF/dBeFaraLU5BH+vxpV7WC3tdg1SkK/3btEsSTREV86W6G7C76lbEogiadhVi8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710223118; c=relaxed/simple;
	bh=IIvM0V7g6Ms8cToE8B4Y4PpsRM/o/h8xtV8EbSf3q9c=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=rf8AwQ1U9aoxY7bE5PWzzfXyj6Slbn5hflOS6upox9qBrf9FdP8VXWg70fD5gM6CByzs2ilwCaenYu8033gH98+RsT0k5IpBScI6HYyz6srC3/DEVxTN3M+XgeyaBsFxern+Px66b+hWO/FAKyZUvf1M/YpDolGJMGAohOHlXdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=TCZvuQiK; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1710223110;
	bh=ShNF3LSRbKIdHoAqT7jf6MJhsSfAHiRF+M1zS/RWuQU=;
	h=Date:From:To:Cc:Subject:From;
	b=TCZvuQiKZkDT8Ia2oLxxXh+kglvJuffKpObR9hXsqSMQOYGbomVsflWr3CIr3v7dy
	 980XXt9RcgXIwA8CLMoLqZN+znNkJWNUdFfHG5+uhIwX0okKuVpgP91c9Kb3tLahUD
	 QeE2Ux1r2iVkLGM1wlPBYT0pS+f298hndTIC7RRsqEcmz+HEndnpJnxgdpKhP01208
	 nvBPMqvkdTQr8b9D2hjEWWiFg8DFrxwNZIlY+dNKKtqKa0OS9oT7KK6cPKghMtGohs
	 64OJ6tj8QLN1ObrdcMEwVsm8Y6g3RMw2n5lohpR3mABEdWmpyKTQ29PpSEI2KeyAD8
	 FMEODFgUzPamA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Tv2xy44dJz4wqN;
	Tue, 12 Mar 2024 16:58:30 +1100 (AEDT)
Date: Tue, 12 Mar 2024 16:58:28 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the mm-nonmm-stable tree
Message-ID: <20240312165828.25386176@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/pmohdFeZMQS4nqrzHga_eyQ";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/pmohdFeZMQS4nqrzHga_eyQ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit is also in Linus Torvalds' tree as a different commit
(but the same patch):

  022b973a3de9 ("smp: make __smp_processor_id() 0-argument macro")

This is commit

  b57b4126dd3b ("smp: Make __smp_processor_id() 0-argument macro")

in Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/pmohdFeZMQS4nqrzHga_eyQ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXv7wQACgkQAVBC80lX
0Gz56QgAm6K+a5yRbtHI4gSnoze1gBJ5oS9ZoEK5FyiMwM8kKpG9L9qUA7qaGDd1
+1/a9AN6BjWV19WzOj85uLZobPTLWD6c1HxxTzeocjjL43h7p7JRFctqY8U2Jsuq
zo8hCHZQ2BDBSXJ/1peZ07EqCY7INkKaANQEV6b5sr+0fw7KmVQ+r2XKqLUs7PBU
KBjmAIFEud1zOM9w2wgGAiCJD0yyHInv963yK5FpJtv56jG1iCGLCFF/W5gPLz6i
HVeR6MeizC6dGZmmWDTJ2yhr2/XDsrq+bqKZb3PrgoQVeUxoA3GN4hGF1vShHSQI
pef0ERQle8bkbGigYHVfR+eqNc056w==
=DgcD
-----END PGP SIGNATURE-----

--Sig_/pmohdFeZMQS4nqrzHga_eyQ--

