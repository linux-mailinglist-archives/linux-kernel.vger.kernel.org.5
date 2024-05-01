Return-Path: <linux-kernel+bounces-164849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92E758B83F4
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 03:25:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3022F1F2431E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 01:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AADE94C97;
	Wed,  1 May 2024 01:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="BRMCwMQF"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8F32F2D;
	Wed,  1 May 2024 01:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714526712; cv=none; b=fSecrPRwzBVv+cp3TcbhCnfnz6z3tt1twBVCoFANnTH3F2RRGZgTF2S8G8o6EBwYazf34RbcUOLlY74nMnkPYtEYRBUaWxl5CAzYoNl2axGqiC2f6n3glAnayp1b2veoAso1DGZPA1VqqWmxWOnNwYzhTe/CzAmhoXk5O/qO7UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714526712; c=relaxed/simple;
	bh=vW7NLhwnZvPamUR5KsBr747Do5nqO+AvA+ZrmO/N3MY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=eifadcjHClXy5a5W3Th8UKP9JI51W2WVo+TOY1UPit+sg2ztSqUKNQjdyzqU+b69nlpoQ1+UjhfZVAeOM59r3HsZoNXbbnV5EuCT+7sHRbfnTfKqmVWxlfTRe6ITrX8l5VP3BTQUYhwDqFF3QSEJKZnCkDq1I91TTbPStpY4C/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=BRMCwMQF; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1714526706;
	bh=nP5SMpDJ/2GvExyerRKKlP05DnejVyacDjAMo5mn2+M=;
	h=Date:From:To:Cc:Subject:From;
	b=BRMCwMQFc7gRxND+tzLrfbyoUqXg9QCgVXRMdJb62AXG0khLafpnhnt8mBz3FQcRG
	 ecLlfsUQHx5u9Qjzsj+aeZREtOQInx5GL+gCQkWdqc65LYsct9jXGixUDfMwljJ3pR
	 qaESdh4Y35MMUnPhV+rVYwcABrKdvQoBjcF6R5JIlKOPCBpeZ2APeuG06IKE2H9V8P
	 hlqgWqYiVhoD3cXSKi7YKgx669BNmFliO7w7PTU0rGIVQvZl/QYRJR6fCIXc0KGZ58
	 MPjPlPLtDU0wer7uFMLA1zMuWz7fpNsZNl+KfGb2iYl4mRz5HxDGwo/fCtdpo0QKMR
	 NAHxAesnjcIPA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VTfWQ0qyJz4x10;
	Wed,  1 May 2024 11:25:05 +1000 (AEST)
Date: Wed, 1 May 2024 11:25:03 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: David Sterba <dsterba@suse.cz>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the btrfs tree
Message-ID: <20240501112503.4e40931b@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ZBnG=INdMWcOHCfmVgzBYW3";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/ZBnG=INdMWcOHCfmVgzBYW3
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit is also in the btrfs-fixes tree as a different commit
(but the same patch):

  6d31c0d2309d ("btrfs: set correct ram_bytes when splitting ordered extent=
")

This is commit

  63a6ce5a1a62 ("btrfs: set correct ram_bytes when splitting ordered extent=
")

in the btrfs-fixes tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/ZBnG=INdMWcOHCfmVgzBYW3
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYxme8ACgkQAVBC80lX
0GyCOggAny3P73R+/k7egZ6kAdVEGEPAMBEgSo7CGc7KleGTxhQsd2zmKBodjNDb
4ISEnKu13F/VmNOrdtSJ1UmV4nUjf5jnpjtXxfqhMcFx0IjVbzVGINOzBIiFbMW9
M/XySojSSSHvKPZXKaL+MU9hsAXel56jM3Vlp7/8HuN5Gr+wuE0i+cOY/wuQDVZa
RCLMCvEZmP5M5pOPC2YqW+jFDcR7V6kBZeRC8PwUV4j5hQppBTJl+DRAPjse63mG
NEEMq3QaICHfj5k9dhnIH+tqNyAEXHrE/2WjzTO42dAymlNn6hZDWMiMhjdfi1oP
cx8I1hvlojtqNa6dvfkxUiqA/j6nhw==
=Y0JH
-----END PGP SIGNATURE-----

--Sig_/ZBnG=INdMWcOHCfmVgzBYW3--

