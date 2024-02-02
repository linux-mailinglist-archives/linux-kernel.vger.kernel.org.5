Return-Path: <linux-kernel+bounces-49027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5DD08464F5
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 01:16:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E90691C23A7F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 00:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B86DA10F2;
	Fri,  2 Feb 2024 00:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="sgZdeGqb"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4978B1FAB;
	Fri,  2 Feb 2024 00:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706832978; cv=none; b=EgTp9TADhzzqjru7Fbc+wtlEJtLRGMizu1CGShhFAVB9K8ZSD5qu9srwtwbmuXU+aj4nghto567nzAuvzi6KjJZib5SDdi2AmPbI8N1ZDVSHkPT1wcCkOs+ESuFK+YwCOE9vz0pscwTVc3/loTLn87HXzkRhV+ro2KzhMJD1FLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706832978; c=relaxed/simple;
	bh=lmS+wybu4wNF3e0wk8RHIylcCeGGWVaehkVC2nWRkf0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=DyGg0RTF1k8+NkraReH1Jv51p3DFXLhKa2aU903dndSU/1eNyvn65wk4OZyvsIY2Yn/ypQ5061ctXGyX+k3nvGNXVmWMGkuCYYGSmom8qoRNhm3MUUJ/L7X3j9drTP9jDjSXhPts+Lu0yyTMeMmEd8ZOHmGXiXubuay3c9AAvEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=sgZdeGqb; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1706832965;
	bh=whV8rHXMnKnvSUUF5lisiusEi1Tlql1PLJCW4XCJG50=;
	h=Date:From:To:Cc:Subject:From;
	b=sgZdeGqbPq8xWriM/a5OuSWY6tflpWDmvn1V35VqNZLcPf1B+ZMBc1ytfWukr1rpf
	 Z0ZmGJ07ofdUJX2Eo4owwnIM/ZRP8M6UtKdw4M8iZRQj/q1BDLOQjAku4Kqc/XVbsd
	 xz0KAdxPMY/64VkMoKvg2vSE/HWsK867MsAKPeIc+l8bOYho0zYHSVRP1tEGcSpwxE
	 PPDiAjbRTusaMK012ZLaQYhUE3y1SCh/AjPIFcnC3vq8r6CH0FZsNFvWJX3SY8czsP
	 fuY5BmtUDemF1xTivTAaMBy6iFynBDstvCwLjJX5M2KSvgac1SS6hIziviyQCLCLPk
	 a/dCaRvqFtMlw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TQxBs1hdBz4wcH;
	Fri,  2 Feb 2024 11:16:04 +1100 (AEDT)
Date: Fri, 2 Feb 2024 11:16:02 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: Li Zhijian <lizhijian@fujitsu.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the ieee1394 tree
Message-ID: <20240202111602.6f6e2c1a@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/L/qgCPZa.WV=QodD/8mQd3b";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/L/qgCPZa.WV=QodD/8mQd3b
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the ieee1394 tree, today's linux-next build (x86_64
allmodconfig) failed like this:

drivers/firewire/core-device.c: In function 'show_text_leaf':
drivers/firewire/core-device.c:369:48: error: 'bufsize' undeclared (first u=
se in this function); did you mean 'ksize'?
  369 |                                                bufsize);
      |                                                ^~~~~~~
      |                                                ksize

Caused by commit

  67a5a58c0443 ("firewire: Kill unnecessary buf check in device_attribute.s=
how")

interacting with commit

  47dc55181dcb ("firewire: core: search descriptor leaf just after vendor d=
irectory entry in root directory")

from Linus' tree (v6.8-rc2 - that the ieee1394 tree has just been rebased on
top of).  I have dropped the ieee1394 tree for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/L/qgCPZa.WV=QodD/8mQd3b
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmW8NEIACgkQAVBC80lX
0GxSUAf/U/ngAUGGo2hybcp883UHGqxIdp20byOpoqFJf7az1LeYEx3OUvn+IfRJ
tEEVQEW57rhTgFJbueNvJnNTRW5wbNEhWmvIlMNsAaLj5x8NzzQgzjReCyHGwBAX
HNgIid+4WmRXAEfkH2EB2RPNkXxLeqzmamyNmtbui3s6AliX3O+Etz2z457YPOnN
vn9BRR+L/0Z6fSu/V6UXKrHuLdMZotxcy9wRQwgLmAsgSjfiCGVOqz0V5mEw+Rvf
2jo+nn6FysZVxEU3fnWlNzxcC++8z6CO7yyVe6l0C8edYUxcgILypIzDEjVDvY3p
exVvbSd6bePDDzGbp7Nn+8llT8wtvQ==
=yLAp
-----END PGP SIGNATURE-----

--Sig_/L/qgCPZa.WV=QodD/8mQd3b--

