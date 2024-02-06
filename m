Return-Path: <linux-kernel+bounces-55663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F5C884BFA9
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 23:02:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD952287A4E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 22:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62D611BF3F;
	Tue,  6 Feb 2024 22:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="XOwl4jMx"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FDA61BF26;
	Tue,  6 Feb 2024 22:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707256955; cv=none; b=AemVvKTc7jxa21Y9Z+iIZAmEsNLNwfFf7RlaDsMHVclhIsNS8SLs6XaPAl7TbSv4Z3ip4e6pcWJ3ImKydpBEgZ5rfqTOf15ZXyM7f9Qih5ofCBN2fEIA/RI35Or+h/UN83lNke/PfxAdAeawccx1ztUfuNPa4l4Wpq6AVPXXOzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707256955; c=relaxed/simple;
	bh=6aOYmHhhZj+cUVtNpQrtGno/VwVkeYHFolO6m4zcXN4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=ocBySvxNUrLhCdHuWbb9WJKZ0Wy24cul2V+CUJELHXnWrKH3B9Is3hUUwfMYcpuDwJ5i3tgc2RzNJz/j6NGe4m+NAUEHVzHwU8wAg8jzX2vYCp9i19Jp5mhZc+ZRRzLhlC7aMhh4Yq3B0jJ3mgPo+3Bq5v4vEWe7H4mR2wGar1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=XOwl4jMx; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1707256950;
	bh=ofWkcH2I2+yEGTodKcowPmBdFMxWAzYJyjabDLNUwMI=;
	h=Date:From:To:Cc:Subject:From;
	b=XOwl4jMxv0fFsNof/6XHZyM/olhok1y+nvxlgAUhkVfr1wKO+OjHGJecZYpaSPWNp
	 6a41hb/o80MfXPcbPFIuCkyOBVbsEYNgjvPGNtmkoNcSKDZeuEPPdeUyUEaVqJVLwe
	 oeYrlkuAa4/tGXC5V/dPii5/HQ/X7y3hb0VHEExRFquv7rOisFRe+EiGTtZ8bE2jW4
	 NaOpH4getYODDB/BsfeF7eJ8rFuzEpGvfjo2ULjBa2Zk2kP+rR1151Vr4B7GFXDez+
	 65TYim0pbsbKX6C2NMIQq89G67y61/aTSeCDbyvemLFyW4FQNjcO9il2d+Yi1YqwCQ
	 c8rtCHJGAWskg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TTy0P6gFsz4wcB;
	Wed,  7 Feb 2024 09:02:28 +1100 (AEDT)
Date: Wed, 7 Feb 2024 09:02:26 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the vfs-fixes tree
Message-ID: <20240207090226.64213a68@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/2Jf2rnb9+II.UG_VQKdOqRs";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/2Jf2rnb9+II.UG_VQKdOqRs
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  dac853a94365 ("Revert "get rid of DCACHE_GENOCIDE"")

is missing a Signed-off-by from its author and committer.

Reverts are commits as well.

--=20
Cheers,
Stephen Rothwell

--Sig_/2Jf2rnb9+II.UG_VQKdOqRs
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXCrHIACgkQAVBC80lX
0Gx7GggAordgJ4PyoBIFTEqc7q6Twv2Oi+0urs8bfEJi2qOGNhraCPPeUwSDDMnQ
7fjMPfI9+UY93zsjFxqIdHQRjmP1rkvJ1gJwNPdwzdfpQrNvAkC9F+UR9QKubyLM
pa95tqrh7ePE/zNKskgwvZEIFMO8StycLUkHeMJQQgj4WPe8hAwkR4uy5I1OZ1aL
2ywraSQUdK+jxJK6hyJS+Sn4P6esLlHFgrlbKdmeKYsn315OiCcbjtMRVOPgVmt6
aHfyMDx2OjQdmUzMoA0RzDNzLy5o2hgphqXSjcnxcNJgmOj5PkQ9cGrepIl8YyxF
WRvrzSMQhFJa+DhhZbJHSk45wVz3CA==
=rltN
-----END PGP SIGNATURE-----

--Sig_/2Jf2rnb9+II.UG_VQKdOqRs--

