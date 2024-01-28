Return-Path: <linux-kernel+bounces-41525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE16583F3AF
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 04:56:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D5352841E2
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 03:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEBEB46AF;
	Sun, 28 Jan 2024 03:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="qXM77+uY"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5ECC3C35;
	Sun, 28 Jan 2024 03:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706414191; cv=none; b=jVE99JR38GUtaIyv8iNxSx+LPOFaVx8wbTZmIAowWNzeAlU5xLXZdR24P9KeOSPObTRuvk/tMvbBC22WZRVh0/WjQPgvDWbM2C74KEYggx6r09OVp/3VrIa350S0q/sShTiNYV1D563StQrHrMVDykbJ3pfdBB7Vd7jZd0SJ/ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706414191; c=relaxed/simple;
	bh=DkqjdcDp8yw1gRWxs7b/P6TwSwEjLEV1DUmqAJg7TUU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=LvT3iw7vtQGOl8QXjG6e93r/j66are7bpsXboXx2dtk6iQEr59I+hUJXwCRHBsCQjevsmy8lt+ILx2a982CtmsEPUGFA5PLBiHuEcOkI+86G7pjm22wqTQDjzhz5ZLiA3BtHyB9idFOWE1r8EUjzGVoiV0GqpRGLkl6R4GM12Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=qXM77+uY; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1706414187;
	bh=vXn7ksdiJVIxoUKftEdiEi30oaIcq5qpDJAZ1K4V/VA=;
	h=Date:From:To:Cc:Subject:From;
	b=qXM77+uYZE5mD66LI6BffxtOErGdOfX+LX0c1aGHOMzx4qPtrv1cbCxZ+RiDF2rKW
	 aBD413ViATvolpKY2CRFi9hGKBNo+L/6Cp7t2cBqNfuPKuQLL/bzjo6RZXxdlNCiOu
	 AWVjq6gRGoYM9ot/vQeqsyktdziPbSmOiRTIVOqa1qaXn9gvbmMHgyaRZlPLKfXBl4
	 QKBirU257eQ9KpHJf49LTk0XIh5a1ee+RlyzSyA96ehitT6fUdErKOqk6uTVjQsJea
	 HlMmGydGToWXcVPA1f76tP4pH2i/BbCRUA5HziwCh0UsdVcMx4QzBdSMRfDaDTkiex
	 esZkc0aFthFNQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TMyKR03rLz4wc6;
	Sun, 28 Jan 2024 14:56:26 +1100 (AEDT)
Date: Sun, 28 Jan 2024 14:56:26 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Steve French <smfrench@gmail.com>, CIFS <linux-cifs@vger.kernel.org>
Cc: Steve French <stfrench@microsoft.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the cifs tree
Message-ID: <20240128145626.53e7a0d3@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ODSJ.Wj51jgF_/jSwry+gH4";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/ODSJ.Wj51jgF_/jSwry+gH4
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commits

  60c2fcda9c84 ("smb: client: add support for WSL reparse points")
  f6819b9b72b5 ("smb: client: reduce number of parameters in smb2_compound_=
op()")
  c08113706498 ("smb: client: fix potential broken compound request")
  35f88f006a3f ("smb: client: move most of reparse point handling code to c=
ommon file")
  985f1bce45c4 ("smb: client: introduce reparse mount option")

are missing a Signed-off-by from their committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/ODSJ.Wj51jgF_/jSwry+gH4
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmW10GoACgkQAVBC80lX
0GxLNAgAlCoozwRf49j2+NpjUJ8AtbPXhAw6hiXNDQrW4/U7BLqHsTwgXSN6jY4m
iBul3QJIVp3bXMY/Slck+6pF3JQQxc9ZkZbkz6TjTZu00XEvVJTOzyAhIlTe221d
tegI6bfePbHo7ny7Y0leUoj4ME7rYWEBq0J+5p4cEBXL1gwJzHcEgVNZ8YosO0Qz
v8vDiVUkjRTkeECE0ifpQatpVyljV2fAXBmV3W1tBo1MIbTcqGAaZbV180ZWVMT3
lkse/bsI+yysZjfV8rqw9RzrkmWUfvBJg06VxG0hT6gq122iLOYIfLNNKtbnWhjV
SX9QtslMAz8aKXKJbuMpwTebW/ExsA==
=57xP
-----END PGP SIGNATURE-----

--Sig_/ODSJ.Wj51jgF_/jSwry+gH4--

