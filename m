Return-Path: <linux-kernel+bounces-106692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48BDB87F1FC
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 22:24:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF973282037
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 21:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0339D58AA2;
	Mon, 18 Mar 2024 21:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="lfdCBJjP"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7DB758230;
	Mon, 18 Mar 2024 21:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710797027; cv=none; b=OwxNuT/5L2yRW7L6/mO+/3A/5WVFPe15rlL7hqzbK6YAonHvOaCAZNS955Q2T1AdzJTUXhfto1U1KmiLiE6xt+RtTycZ4a14Zbzqeyq1yY2hvTf79DTEGGSymOyaApRZESLLXS3ZWYjZLrSXyYylm/FWONjjLskQlJYJ1WOxq0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710797027; c=relaxed/simple;
	bh=bj4M62RiByQRlTBjZPQ8rXvS3glPzrIJAWqA7mRKj7k=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=g6Os3Dk22xTN7Xv1bbq3Gz96tN0pGP0kuJJyhhDj8x9gnl/eGoljssW+lPGC2+8vb+sEUxnfoVNwNBeSYU70rZlIKTMYV1xJuYQ4UFOqG4Bja9BjAP0T3WYmF3paViXjs+E7OUBiewUXc9dRHl+O2mA+sT2mvBPIo4tqPoHQ+oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=lfdCBJjP; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1710797022;
	bh=TVqaAIoEkwXM0+zXFmchwHuGTFez6sg5JrLqF4O6pUA=;
	h=Date:From:To:Cc:Subject:From;
	b=lfdCBJjPOCO83Gx3TyeSX9a5PWCKnFKoDBmC1oylRsk8k9l7hvhsFPAzYtLJDzHap
	 f6wYfzq0Gmni3Jg15mKKHO73NRWp5f5GCir/z2NM4wpIjDyI5fkaL3HZ4+qF9dUayA
	 qsvdPHXld99v4aZD5Fr2V7tO7Lm2TjL08uWPWokmKNG3z33ASJ6zUZvz/llytXGpbk
	 dQSO4aGS0rOSHAjPHqxSMExLs0mw0x4AbkywJ0oz13aJHfs+ITS8iymkCfZt9Tcsza
	 VHuulkN963LYJQCZSTZ0hhJKaa9v6XWzzrm+ekkot/8yrZyUAtT40jxjuf/Sy9omXh
	 mXKVKrfMloNiw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Tz7Bk5QMjz4wck;
	Tue, 19 Mar 2024 08:23:42 +1100 (AEDT)
Date: Tue, 19 Mar 2024 08:23:41 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Christian Brauner <brauner@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the vfs-brauner tree
Message-ID: <20240319082341.51a1d007@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/qfwbP+BDQYswKTQ.emHQKGl";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/qfwbP+BDQYswKTQ.emHQKGl
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit is also in Linus Torvalds' tree as a different commit
(but the same patch):

  9ddf5fe47f2e ("fs,block: get holder during claim")

This is commit

  59a55a63c246 ("fs,block: get holder during claim")

in Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/qfwbP+BDQYswKTQ.emHQKGl
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmX4sN0ACgkQAVBC80lX
0Gz9+gf9EXH//dUSCHIpiGr+TuOKPJx4EkbbqZ2iDQnsRHatxSGxETNb9BJzxAUy
/F/OD6EQfc+6GkAWmLr8kBKA30iOFEIWlYytD8K2oDckuwS8+diK0qSz4e+8lem2
LhJJY4dI4uAcJ0TxaXhAju+cBVNq72+d+kh22lGmfFTQx28AWkdD/GBnC7+rkM+N
q9n8wO9a0adAASqITF+Hfsaj87PsybNZIcVj4R7zx2ieG/NTowPC+WE04I7LtdQ3
wFGPxXEFXUD7ZXRx+traypS4j+QYJ4HMI9jBjJlu3O20eOenUJHm2yOOo3foWLSQ
wWhscRyHW/ht+rD45t5vLkDASQSbeA==
=fJzf
-----END PGP SIGNATURE-----

--Sig_/qfwbP+BDQYswKTQ.emHQKGl--

