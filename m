Return-Path: <linux-kernel+bounces-75961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64B2585F12B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 06:56:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8498283668
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 05:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 937EE168A8;
	Thu, 22 Feb 2024 05:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="oqTbNApA"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B362B12E4F;
	Thu, 22 Feb 2024 05:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708581402; cv=none; b=hUD5BuJH1E2Myk04AqGUUkCHpOWr78ifGwtdrvfWvCi60UlSaC4JT5iLD1sJejdzqFD3XgBz6c8gOAW71PFmT+DO1CVU1NWjJmj0MwJStnELoTpKQdiR1FqOFYI9aeo5ZhxHVZSAf/3Zfn93uy6EqCi+QFr4Vu6mFZfFnZ7XPuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708581402; c=relaxed/simple;
	bh=igvdT3OW8iB13zNtn88d6z8rm2yodrqF6L3B5TbaL5o=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=YUZdJmZ5+/tqMSurSv6aB/xCroH5DF2A8uvMatdggrU+PvXX1jVX4N31tkmqh8il7q+8JTxVgT3sdMZZ4loZODE7FTTfDZsVsi/KUlhZZC44hZhqmn1DyJdFq814gytG1YSPIFsr0cZo8jabk4xD4wEFyyGr0w/4cr91O+dGf6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=oqTbNApA; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1708581395;
	bh=A8bs9/nh2+Pun4s3PfS5o+wVH+viQgRLUCoSctg7lss=;
	h=Date:From:To:Cc:Subject:From;
	b=oqTbNApAeMcdsnsekVtpz7CVwKlryIBwbD59X3BzTfSYOHuU1r1xz/07BVTfURvbF
	 p75QqjA9syOKY7aUX+b65HM72TFF7aTdLHQR+M2pXWr+aR+6YNZBhdvEKjPCau0eDs
	 xVYFfYU2EWnKiBkx75ci/o3/s/iU60934133UCIVNZWYogxVOVcmoB/HjEmZbh7lnq
	 /2fPkYzvZ5osL0QcezK9v07+Tf/Zp04NWfeuiKiiG4uneVlTkzkdukIiAgkDBEZnyx
	 dXxQ7yBtYpHFDd+nA1MIceSbfI+Bo1eTESpNC+EDl1fmSxWwK2I+eRRv8XIuTb9Vha
	 U730EJqSjZL8w==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TgMpW5RRFz4wcR;
	Thu, 22 Feb 2024 16:56:35 +1100 (AEDT)
Date: Thu, 22 Feb 2024 16:56:35 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Kees Cook <keescook@chromium.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the kspp tree
Message-ID: <20240222165635.3dbfad02@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/AU3eQiveujyOPJWsYNlEQ8h";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/AU3eQiveujyOPJWsYNlEQ8h
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the kspp tree, today's linux-next build (arm
multi_v7_defconfig) produced this warning:

arch/arm/boot/compressed/misc.c:157:6: warning: no previous prototype for '=
__fortify_panic' [-Wmissing-prototypes]
  157 | void __fortify_panic(const u8 reason, size_t avail, size_t size)
      |      ^~~~~~~~~~~~~~~

Introduced by commit

  0f4459080884 ("fortify: Split reporting and avoid passing string pointer")

--=20
Cheers,
Stephen Rothwell

--Sig_/AU3eQiveujyOPJWsYNlEQ8h
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXW4hMACgkQAVBC80lX
0GzF+Af+K8otmvDsrNokGTZE+0H9N45+z4KWWtTfJFSm/oIVL9rtNey+V3I2tWvJ
KCAV0wu4vFlhHM4gUhUDudEljfOJfS4x5n2ofAfHO1Id1XHFCLZL2QeU17IE0MEz
eK7LFQ7bDLqayP2KUBlFOG/czCCCW1GewTKZPa5RU3kgx9eV9h66vZ5QKSn72MAr
y2oosJDCTD3DksQQFkauR0LRh6/18uS32XCwz1ZtKpOGKZw3xqrK+ibe8GxuV34n
Ptumxe9783C1C5A08uEZxzyDw877fsGsYGFayg618boNMDKSOsksiI2cGUDBOxra
0WYqOlX1LISzZcZlseL62sRR4khHYg==
=6U6F
-----END PGP SIGNATURE-----

--Sig_/AU3eQiveujyOPJWsYNlEQ8h--

