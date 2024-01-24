Return-Path: <linux-kernel+bounces-37696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B36283B3F6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 22:33:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C86442869B0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 21:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1805D1353F2;
	Wed, 24 Jan 2024 21:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="WdHN/naj"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E20912BE96;
	Wed, 24 Jan 2024 21:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706131980; cv=none; b=CS85AvKG4JHXs+QG06wNGLIRLHq+lH6FPQcuNpQUk0V6RWnfXKPSmsjj/Dbm74ShyPCn56fhiC8LNl2FNhdx8RwxjZdwVmJqsVNXw6VB7+2+QpHx6gqZeJmM8zBn2JWM2vHJs5Wxyl6vbv/6ylJYtkoTtFyfsi2/KROdRfelVW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706131980; c=relaxed/simple;
	bh=X9jA6bgP93JAu69tHzxCV5t15m5CsIlVJN86ap0gzE4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=ZY1493FGCCdwxttOELwmWRoQySt/tIAjr9ok92Qjr9jdX3nchprwzC4t8J2/cBJTLtSgKI1myJxTUWxlaFX7R1lthSZfPVreYUTnxEozurMvFfxitM8PMrKHyC7YBF0C/AejpUxUzUTUqY/yBWlCpsjIFK9xpLYW8eS9xA6vqDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=WdHN/naj; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1706131972;
	bh=XA65Jt7yPiuLfsmADc9KK7O72HMx1x27Bm1ZJ8yxl3I=;
	h=Date:From:To:Cc:Subject:From;
	b=WdHN/najftXCJvHFHM3heItTjEkF+5QhK2HHEJrM0b/Tq7GE7VmjEYT7NwSKXKLia
	 3yKQLBB+3DhHNLBqRBKnPe9vZ9w98g4elgGUaji230OlWcivRnGqArPQkZ1pMx81iJ
	 P2b15gmv4f7U1ltrNrPD7XMts5fgdE+szorvVM/LuJhiRIlUYH5QXzAYdPsOFmV4CT
	 +LIpRH8xg/F9e1Dh3e2thkp8XJgXtMgEFGNR08j2Q2vdYOlwDA9gu6L6+prKoZ8Ea8
	 RfASrl+JFczTP2cnozd/ji+cgql5aQ+nRp9OqB3/5LxrMNoCuTV5xQF6cDqBs7el5C
	 kY3FoW9zYaQ6Q==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TKxyD0gY4z4x5l;
	Thu, 25 Jan 2024 08:32:51 +1100 (AEDT)
Date: Thu, 25 Jan 2024 08:32:29 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the smack tree
Message-ID: <20240125083229.6bba94ec@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/8HN_.k4NzV+x0E1_iOB4vcJ";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/8HN_.k4NzV+x0E1_iOB4vcJ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commits

  39fcdc643c23 ("smack: Initialize the in-memory inode in smack_inode_init_=
security()")
  ea2d37d1b553 ("smack: Always determine inode labels in smack_inode_init_s=
ecurity()")
  da5bea06bde0 ("smack: Handle SMACK64TRANSMUTE in smack_inode_setsecurity(=
)")
  9c5589ad9d82 ("smack: Set SMACK64TRANSMUTE only for dirs in smack_inode_s=
etxattr()")

are missing a Signed-off-by from their committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/8HN_.k4NzV+x0E1_iOB4vcJ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmWxge0ACgkQAVBC80lX
0GyamwgAoXHzntxXGL+NfNfK6pmjcZMjl/nFQQCHZZsFwBMCJHhfvQHPA66qjVOm
IsyPMwbKO5FmbaJaQcAiPg24iu5VNXfgobnu/7I41qIm+I91aBK8ebPozzw2CkNf
wp5hf+uGb6/nGXI8XDTiN+rGz60cbSn7PqnunXkASrI1Qe5bm36vN09P81H2Dtke
UJMDdIEUF573UT7e7v8lXMQP3+dhOw0GcpiDyzriHB6cfjyWh/aFyNzHgz8rU/dm
1fVNuKa2APDZIVw51pnPdH21toj+/05lGz0uqHEYL66gCxmNtrTGAqdFj02sDJ7z
aGkmC8YDFV4pYDz8awRroswgJBzQ4g==
=zXSk
-----END PGP SIGNATURE-----

--Sig_/8HN_.k4NzV+x0E1_iOB4vcJ--

