Return-Path: <linux-kernel+bounces-52041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F22A984933C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 06:15:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80F64282B3C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 05:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75EE0B671;
	Mon,  5 Feb 2024 05:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="QLMiXJGY"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7704B664;
	Mon,  5 Feb 2024 05:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707110091; cv=none; b=roD5PUfiEF9ixXG1tug3QnkHNG7P1c8K6QbELrDhOVAykH7dc+MYKFM6xWoL64fsXm0xkVT6jIyHE7AnFDUKWZcrydrBNd/FukjCdMmguVc8icUjDsWCx8MonMg8t6gAMOfiUC5jHaXJDXw69FdSqAkK1py9qkVMSSIP8wPlTQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707110091; c=relaxed/simple;
	bh=tp6SLwifN4RPSLuHIMPpI6UiqP88IsrExmfNpqGx7RA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=kUl4shpFO961R1e8GrMDRtUgRnH16wzUfZbH0jzpyjWMXkjuB76v4NdRRLlWLYwfnL9w3QyczOj1nQsflHGNXjc7puToXNcMS62OZY1d7VdpxEU4M/upmVOGi2Ub2MphaWeeR380Fb4iXA1ihgl99tJun4t7/zBObi5EllqyNnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=QLMiXJGY; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1707110087;
	bh=rAdaRc9JP0OEshPFdIF4PD04JxE2lYcY5cYz/Kr1fCY=;
	h=Date:From:To:Cc:Subject:From;
	b=QLMiXJGYEYjBGr/Uv/bWCtNpej8QSZt1kCo77ywAqzymYyOPYyA30iMDLyTwOH3e6
	 Wg8eK1UngXmo3x99cCRHtibCs6gmb251286ffZAlFHVI4tVJBTKl9UMNDkmI/ps7Cx
	 U7CvU1Vn3Y0MC8hLuTDq2a9fZZ0S5X/lxiiG5AMmesily+0Rk5KxllSn3aC63CBGr8
	 PsdlpKNvD8iyjQDLbmZHpEoowqb86amGZAdAM5iKAXYgT5E61IbP/F1z/SNDZWJ16S
	 QP3B4og2QFXpuSITdM+Oesa/ALg4sfFpyvEn9neNHUBTf/JbtpAOwAosFDop4L3oTO
	 tWK6RpP5AXeEg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TSvh70bKSz4wp3;
	Mon,  5 Feb 2024 16:14:46 +1100 (AEDT)
Date: Mon, 5 Feb 2024 16:14:46 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Kees Cook <keescook@chromium.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warnings after merge of the kspp tree
Message-ID: <20240205161446.4b0c90fb@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/5dR3Gpcut7u1rPWjpNWb_rX";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/5dR3Gpcut7u1rPWjpNWb_rX
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the kspp tree, today's linux-next build (htmldocs) produced
these warnings:

include/linux/overflow.h:97: warning: Function parameter or struct member '=
var' not described in 'inc_wrap'
include/linux/overflow.h:97: warning: Function parameter or struct member '=
offset' not described in 'inc_wrap'
include/linux/overflow.h:97: warning: Excess function parameter 'a' descrip=
tion in 'inc_wrap'
include/linux/overflow.h:97: warning: Excess function parameter 'b' descrip=
tion in 'inc_wrap'
include/linux/overflow.h:142: warning: Function parameter or struct member =
'var' not described in 'dec_wrap'
include/linux/overflow.h:142: warning: Function parameter or struct member =
'offset' not described in 'dec_wrap'
include/linux/overflow.h:142: warning: Excess function parameter 'a' descri=
ption in 'dec_wrap'
include/linux/overflow.h:142: warning: Excess function parameter 'b' descri=
ption in 'dec_wrap'

Introduced by commit

  6ad835d8849c ("overflow: Introduce inc_wrap() and dec_wrap()")

--=20
Cheers,
Stephen Rothwell

--Sig_/5dR3Gpcut7u1rPWjpNWb_rX
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXAbsYACgkQAVBC80lX
0GwD7wf/U7GR9q8gmIyuuoiw/1zUabOPD7ZG/NMDLOxzB5TcIIze7zsuzKbiYStc
kl3MXqRLo4l4DyR3b+CrIrcpgfrfqeY0IILjFQ/sVsk7vBzw13nlRk0n5SmWsNWm
00sVY5XF8mcqYINeN3GmVV05fTS6KDMO4lmG6J0wOpNbr5XlShxMcyIWnnZUV9nV
tSKKwLflB0tmJZZwYEpehpOp5fzpWqBDOLsCLj+hJiQLaOpf64A05YWzKhNBuv3U
Ad7gC5L8iVC2UAkuCwiwURalfllHHyudyn89ID2Dp1aIQpoWTQaNEvNfMKU9FcpK
tKSuq1KcWtiZS91i9b/pORg8aVSELw==
=Yq8i
-----END PGP SIGNATURE-----

--Sig_/5dR3Gpcut7u1rPWjpNWb_rX--

