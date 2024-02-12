Return-Path: <linux-kernel+bounces-62549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E894A8522A5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 00:38:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 758CC284A2B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 23:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79D7151008;
	Mon, 12 Feb 2024 23:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="TWnLP4sy"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9F451004;
	Mon, 12 Feb 2024 23:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707781044; cv=none; b=VZUBBwdoeRQwTES/sT7tMRD8TEftTkowGPCt9f+AUW4Wr0zaj3x0eS5L9oXM83YgV7ixZk+3qhZck5APlxV+tvw69TOSnMkTyAzT/1jWZMVrFT6X5EmR739jEGugyhyjMjzdzoaz1v9wOSj/oeNgEQ6YYXZ7HSt89QDFR6tUkjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707781044; c=relaxed/simple;
	bh=kfALUnSIZNSIB+S1PHxAStHw7h2anMolKf1dYlZOCqk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=MC/UT4TfUQ4wjxw8m8UO/wHa5M4f1THHhQxfDXN4vyeT/+kZVRJTKKULYmTA5TCRgMc4LTrU5coNYtZcTWNvsyDdyKF4/qfxObDJPaLQGSt1shLGZK7xg2NwQDl8CS4NPHLmw/2casViDaDjSiF4KFLX4PveQAUMJsrWHZxDAhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=TWnLP4sy; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1707781040;
	bh=WlUs3EVYHBD8VHBC9BDwY5URnvcvDcUbBK9rHsycS+w=;
	h=Date:From:To:Cc:Subject:From;
	b=TWnLP4syHiDdNd6QOoULknVIEsR+7lKM5jdDT3U+xu0nwpK9MjE496B6DeeACNI9q
	 er6tBChyOvx+5Rcn5IOOp0AHKrdI5+xVxp+H44ilQbkVHeZ3DqPqC+AlAOIc19OCZd
	 KAEm3OkdtAFMineueuYIkWe9Kcp7x+viH6Wjm4885EiNcf/ZxYzz0HXwdhDyH/Iv46
	 avxnNzaQyuzzNJrGqUT0mRAQCqttELWYejUhbzVZJq4Z2NLV5i5JRP9lAJbn0XuBR0
	 cUaLuzdBapdqU0ttXA2jUriBKIooEiu7KcCYoFSiuFm0I0k2TgO8T72zj5jWBBzBIf
	 d4zFPchdlk6VQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TYgq40m3kz4wcq;
	Tue, 13 Feb 2024 10:37:19 +1100 (AEDT)
Date: Tue, 13 Feb 2024 10:37:19 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Jonathan Corbet <corbet@lwn.net>, Christian Brauner <brauner@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the jc_docs tree
Message-ID: <20240213103719.7784020d@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/kLjv0Yu6tRt8JB0YJ2BmFUw";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/kLjv0Yu6tRt8JB0YJ2BmFUw
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit is also in the vfs-brauner tree as a different commit
(but the same patch):

  b66140d8e43f ("docs: filesystems: fix typo in docs")

This is commit

  f1d1f00279f6 ("docs: filesystems: fix typo in docs")

--=20
Cheers,
Stephen Rothwell

--Sig_/kLjv0Yu6tRt8JB0YJ2BmFUw
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXKq68ACgkQAVBC80lX
0Gw9cwf+IXkNlTeFH6RetKQ8oWYYfZbkK/7xMZBHAdIPO/9/oIVpDXUIJHZrfdGZ
AEh2RixZebAFQtfBW9IczdOLWGcHd6rLYt572BdBSXszS+6XmMnq73HKw/D04U0O
yX+s9HIOn1CjkIb+tFxrxDSxBDc5Jr0b/WhPJJ6BubhASoO/AZrfJxzFD/nfQW14
KLd3LsKdD4ZCv3FVQuSngF5he7sspFprZr6qdbLWNc4UGtfDrHwI0T23bPCLDcE+
oISnPC9sr1ZNOO2/l5h0uJZrSO0HSOLQGo8lhV0mMqYK0Wx0M7hu1sJ3/t5PZIxV
D/stEgOtE+d2mSI//7z6EDH6q+zhbw==
=iQrh
-----END PGP SIGNATURE-----

--Sig_/kLjv0Yu6tRt8JB0YJ2BmFUw--

