Return-Path: <linux-kernel+bounces-141958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E45818A2580
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 07:12:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D7631C22594
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 05:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4514E17731;
	Fri, 12 Apr 2024 05:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="qR1sBwC3"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D4A62C853;
	Fri, 12 Apr 2024 05:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712898713; cv=none; b=QktrmGcUNDi9NRP22uSa67d+5K97t2XjstpmsCcsTfRbZwPu6ieATa4V2sgq6XjtH+CZjWb+ospjtn/X1PP3+dz7AqH4JnSY7V8U4fGavUE4H22/YBcPOsWUWM5svgAejRdYQzmGezZnmBSvID0/wXkkTJxj2IANiGnunWxm/44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712898713; c=relaxed/simple;
	bh=ckxiAva6NtfOVZb76KvA2/vT+MZfq8toz6Bf3K5O6wI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=tzQT9hweMS/dzMbo8wlxcfkP95Of6A8UWiL1QMcbw47T1ZZrub62lu65oNlizkLHgs1OrB6MB3UR6XncAS1S90bMyIzeSSejqORQJgrVPkbmitGaitBCj4mUnPogAaVtnpnC2b1f3mwnDj2RGSSkgq9OwOyFvYtpyOy59MKsFHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=qR1sBwC3; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1712898708;
	bh=FZe94IGm60i+wrx7mytputrazrpPG+SV8qrIZglowmg=;
	h=Date:From:To:Cc:Subject:From;
	b=qR1sBwC3vlTfLWyH1uiHI/UnlIjSUoWhZo4szCw9EytXnnGp5ceQSEJd85as8Gkbt
	 +XaEiifvkeZDFJ0+GhDu09rV38JCNN+NNjsiJT8QDMwPtUmREQ0FrLyYNvoZ7H8k2/
	 vRlIjdpgTGdrzjW1iyochicBCcyAyX/s+FPiNtEYP4VXk61LfmDoH4fPClufNaTnNz
	 Ld4fXMuYxQ/WeABNBrRn9g/J1MHYzXKlyc/DVKhShZfvWEcUfTk+t4mmdxJR21u9Ag
	 dw8DVvlS9go4r5Oo4wMrBus9Sej8xdR3kYYguMzuWMtui9HmNFhJeHcEMxqCacpjW+
	 zA74AT67Xko0g==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VG4Rl6HY6z4wx5;
	Fri, 12 Apr 2024 15:11:47 +1000 (AEST)
Date: Fri, 12 Apr 2024 15:11:47 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>, Wu Hao
 <hao.wu@intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Xu Yilun
 <yilun.xu@linux.intel.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the fpga tree
Message-ID: <20240412151147.22a059ff@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/eRnw..xp0u8Ga9jNOdmZ2SW";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/eRnw..xp0u8Ga9jNOdmZ2SW
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the fpga tree, today's linux-next build (x86_64
allmodconfig) failed like this:

drivers/fpga/ice40-spi.c:201:35: error: implicit declaration of function 'o=
f_match_ptr' [-Werror=3Dimplicit-function-declaration]
  201 |                 .of_match_table =3D of_match_ptr(ice40_fpga_of_matc=
h),
      |                                   ^~~~~~~~~~~~
drivers/fpga/ice40-spi.c:201:35: error: initialization of 'const struct of_=
device_id *' from 'int' makes pointer from integer without a cast [-Werror=
=3Dint-conversion]
drivers/fpga/ice40-spi.c:201:35: note: (near initialization for 'ice40_fpga=
_driver.driver.of_match_table')
drivers/fpga/ice40-spi.c:201:35: error: initializer element is not constant
drivers/fpga/ice40-spi.c:201:35: note: (near initialization for 'ice40_fpga=
_driver.driver.of_match_table')
cc1: all warnings being treated as errors

Caused by commit

  5d04660b29fb ("fpga: ice40-spi: Remove unused of_gpio.h")

I have used the fpga tree from next-20240411 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/eRnw..xp0u8Ga9jNOdmZ2SW
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYYwpMACgkQAVBC80lX
0Gx0yQgAgoRAfQYJw5MwUHc55xNs/m1J2IAReeekwKlpJK3GWDbaZ350/tkn1wCq
4NllF3tnntYjUYWJf18BZx+GM0bci/UMReiILCb0wEIa13TJu3DhU176hxdlxph7
Ckq0ve4+J2z+Vfh1+2xwSzVcNSecgXEPgpU4kBTMQPO9jSV9oUqbbXQ8elAd5nV/
nhotpXwCzbmvUFtxDLjEmWTHKjLXJ05ZtG70+KW9m8kcQaZ+eXFIwr0GdN8eF2gN
285Mjmj73h9+SbZ+T31a4OeQ07MdYBTZ9SNcqBVIl1FDxWmTKjIfBFu6qBtUzQje
9tKKLhd2RaiUsU9FQzq7BmzyXdtZxg==
=XnsU
-----END PGP SIGNATURE-----

--Sig_/eRnw..xp0u8Ga9jNOdmZ2SW--

