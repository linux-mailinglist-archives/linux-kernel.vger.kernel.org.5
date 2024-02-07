Return-Path: <linux-kernel+bounces-56057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A44384C573
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 08:05:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 083A81F2258A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 07:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AC451F5F0;
	Wed,  7 Feb 2024 07:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="lUDR7DBM"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092A91CFAB;
	Wed,  7 Feb 2024 07:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707289537; cv=none; b=Fq2ZCxvOOVJHIxRQJQxIYExtC3eyR1a6LVy1lDOSWUAzWgUSi/3R/q9G2ct/0jaVPLlvaWbxAlhfPzUuqK/dLSMxGpptXxb3ZGlvCyg2fhPDPJx3JFPgLjGvFEFlMZMsgDcIttk1SA+5qEBKHJ5CMvO2sMUhWqRG353p6hqaKFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707289537; c=relaxed/simple;
	bh=og4v4eEk4AuLFbAcHMM4x0owpToRD6qD5UYIOZ88rVw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=Qv1y+TBIKKFme64hVslCl+xnyaf/HsuX58mbHfgrbV2myBQi8PQuOrrU9OUL0S068vIb2o3aVjk7emd0aFOz/wQk99zhHiUyaRvBgPvdbJf1/Gx0grXcpxNOjmA0SbDDEdE2n0/pUGD67BxXeZ7hT8yAkMFl8RRBk0Wd7xJpYok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=lUDR7DBM; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1707289533;
	bh=BOwG/+aeCjtGS5+N0Fkd0h1k1ixiK15VugN66/XQELs=;
	h=Date:From:To:Cc:Subject:From;
	b=lUDR7DBMLMwvAH3GDchXIRxSQ4LwuWBDO70WzUhVR1JPL1rpspUF6ynpmWJ7x8LZL
	 Be6/Q7j4wIeRxNIL6dYqMbBuZI/RO5SKBluvklj38V2N0ePPsY6f2RSrKrhCZMtk1i
	 1smtRKju1jM8u4L8iwnVay43gtOiO2CBDQwDA49rZ5eA5J99HARW7C6+8ph09L76mT
	 vc2qm0bF1dkTBE+vuuF7UkMD1SHX7vYZDEloVi5u2P+4graoGgfWC7jk/SdJVFULuW
	 njWyspmTwtafFpHHhPWAtsJJn7MHSfZhhIq/aIZ4DQ9eov2wAr4eiAgAcZ6/A335Ri
	 LEb6DRnTOCdXg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TVB306sLNz4wck;
	Wed,  7 Feb 2024 18:05:32 +1100 (AEDT)
Date: Wed, 7 Feb 2024 18:05:29 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andy Gross <agross@kernel.org>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the qcom tree
Message-ID: <20240207180529.0c0dc548@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/NgZiu=Gd+g/5suFvkDkl5St";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/NgZiu=Gd+g/5suFvkDkl5St
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  1bd8c3ad02b1 ("clk: qcom: reset: Ensure write completion on reset de/asse=
rtion")

Fixes tag

  Fixes: db1029814f1f ("clk: qcom: reset: Ensure write completion on reset =
de/assertion")

has these problem(s):

  - Target SHA1 does not exist

And I can't find the intended commit since both the above subject lines
are identical.

--=20
Cheers,
Stephen Rothwell

--Sig_/NgZiu=Gd+g/5suFvkDkl5St
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXDK7kACgkQAVBC80lX
0GzevAgAlT3EIEtMTpxcgpGpnj5JeMUMXLbR8rV5XcuQGyAqsB8cozyCfRprwTkO
hYAWxp+zXXq8i3ZEp56+0X2tPShwVITTt6ZIF2+ghYXJ900kdaxjWTuEDeRnhaCr
KHlDPghpEAg9gapoMPlWNUGiGRuPk8KrmmAHZvJ6VxgGJtgr0pnVNcvBe/QuzCfo
JysdLs0Hkt8arag27KU5pfVKda4fu8B18WE7YfK5Uq2W7Yqjt9tS4M9mBdU3vg3R
GRQHUAfIoik6kAvoSNiaCfMA3zyyz7IF2e6imIae0k+CsTwgkAzfDO2MdevNDqiT
7OeEzBrJvrTuT7pxaE9U3Nr1CbaQeg==
=dI69
-----END PGP SIGNATURE-----

--Sig_/NgZiu=Gd+g/5suFvkDkl5St--

