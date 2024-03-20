Return-Path: <linux-kernel+bounces-108312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F41E8808FE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 02:22:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40DF01C226E5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 01:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B7FC748E;
	Wed, 20 Mar 2024 01:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="iI1XTNSr"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F151364;
	Wed, 20 Mar 2024 01:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710897754; cv=none; b=oN+s1d72pstPsZx64CXpeIfHzuaFgkKZadSWjBj/+ZRov2i53QOEYS3Xk5e5Be5osvYvFC6ShFf1bZh8yaFUR3RUlVX0MQr5Dq39NO33uGSduo4ctfoOOiN7FAH6tJIhGfzzMuJ7zblfm/ljUchEmiO/vZDRlddMJGeZhwqTj5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710897754; c=relaxed/simple;
	bh=Q1haBrHN0+uSKsisw2ZL83TjtCSC5SfmpxFLim8tjvA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=Qn2v4PI+4mQd/X+kXXG61jKFiqBWo/GsN5ggEF7XIRhyBv7+pqhy5bPYzzbIBGM4vOyZXO9M14ltkj1ew/mYVdAS9F9ON8+xURXLRWyEHF7+LK8F+/sSVD78cNDuBu92aD5DoE45xaVq4TzA6PGEXYV2kLgfRqHNil5BKfq4UGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=iI1XTNSr; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1710897748;
	bh=T3idANwoIWhVCRjjdSvmB8hJe9YUnMieJ6qyeMnwPtw=;
	h=Date:From:To:Cc:Subject:From;
	b=iI1XTNSr8vydWurPkuYXaOM7TZoSV2d0oWFFs5IUPjWDSBK0xp/WhcexFSnlf7g7u
	 HVMpl+qwXuwvkFkRbI/EycSU/AA4eoBB0unEt/MI7fE1V6yf9trDIcVSijBqXCROzl
	 j3skiXo2yF5QpxPUk+8C2PeIGXWJChDR0g1uOaYk33TUExlcPRU4vhJ3Eyuao5waaT
	 N9ySH5bDbyhtiKh8dU+x2VA/w0Dgt+2obGDnhgSG5Oamd0UAoCFtVY8nMACnM6CoJE
	 62g4mS61GGtAk8AhRldyjF+Utmc08oKLZg9/MzmeJib+RIR5lb00WR3L9vmZ8vNEs0
	 4mYAGpSzERh1g==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TzrRl4bvBz4wcF;
	Wed, 20 Mar 2024 12:22:27 +1100 (AEDT)
Date: Wed, 20 Mar 2024 12:22:25 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andy Gross <agross@kernel.org>, Greg KH <greg@kroah.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patches in the qcom tree
Message-ID: <20240320122225.58136464@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/UdNNaS_MCbiXRYFu.FTn.FN";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/UdNNaS_MCbiXRYFu.FTn.FN
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commits are also in the usb tree tree as different
commits (but the same patches):

  601feafa7dad ("arm64: dts: qcom: pm6150: define USB-C related blocks")
  a5b150af2c6a ("dt-bindings: soc: qcom: qcom,pmic-glink: document QCM6490 =
compatible")

These are commits

  f81c2f01cad6 ("arm64: dts: qcom: pm6150: define USB-C related blocks")
  6677138d7310 ("dt-bindings: soc: qcom: qcom,pmic-glink: document QCM6490 =
compatible")

from the usb tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/UdNNaS_MCbiXRYFu.FTn.FN
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmX6OlEACgkQAVBC80lX
0Gx/agf+JqZTVKZAya5kqoqUOJFd6uQD7bMZrcJ3f8nBOYk1WUfx43AjH8ip03s6
Pheb1BGYfHw4AQJWOm6tmQ5dRB4P1n4Xj5BaU4jyxzTdyyUvp1ZJc39mVfbA7iqQ
+Xq0PoRynXnhFZ+bkqflE1VcGrMUYhdbqpI4rLaudJcPJrXizkfQzFqInRlCIssa
dYngFC9gTdffUoQYjpe96xKAW9cYKjPWYt1hHpU80xGdRUoMY6IugtTKmK9Vv530
7s88xaBxQC0uJvuzypEr3p3sSK29hPFULGbDnZsawuQj0nP8NFbOZ3lXJxycw//d
P+62C/YdJSMbNSmJ8ePcWiig+5Gw8g==
=dzdF
-----END PGP SIGNATURE-----

--Sig_/UdNNaS_MCbiXRYFu.FTn.FN--

