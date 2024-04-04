Return-Path: <linux-kernel+bounces-130783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D48D897D10
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 02:28:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C1C21F2AC69
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 00:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30BBB1848;
	Thu,  4 Apr 2024 00:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="TRBOQm+F"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7760F367;
	Thu,  4 Apr 2024 00:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712190500; cv=none; b=NoPIjxRb48OanyDk/TuvkQR3xYRS1hl99NEiIF8W1TA8jDZjHT3lYrPszQJjOZrQsOalADrt6DK50YS8B/MSIT/PyYh4lCfbDQgt2aQr+t+IR6AAf4EJBO9/XXyAzGqjO+lj67jCDX21ZSXu745VRdAw7cLQlCrm8REo/KGvmZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712190500; c=relaxed/simple;
	bh=g/3zG1PsFBtDwbJLKeB2piKA+luIYblngtaoMDLRcH0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=Msn+33w7/JaYoS8ittfDoI3O/f2QrZoPgldQqI4uEwt3xwRe9iTOyDcJJhqeiDYRTGCU571f5sTRyfqJPhMrBGyRtpjeDtOJnkk3mg/yF/gUSMlxj74n+jUNjEIG4Q98ylEcoYg5f/dEOPnDrBv0zP5EV/yWeVutQEtYoxK1oOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=TRBOQm+F; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1712190490;
	bh=vpx8IMIkGxtx+N69krNuve3hd+m9nrp76chTq3odt8Q=;
	h=Date:From:To:Cc:Subject:From;
	b=TRBOQm+FVMVF1cb9dreCCCs2xDsQZnXJggi+1sJ91AkyIEdadCKPMJeuGr6BRxuHW
	 juA7RMjRk0EzSmwafipelW7XYu/LmvujvntpwnQwIPzu1Rqc2MYcIKsYXuBQVBdWeY
	 Jt2PNOI3Pr+pf9enVhJ2iWoGJ0RghA+RmTbnTbk6MazQeiY7TkaHKYOnxi83aTf1N4
	 bvA1EAMKzGGumQhYeTOg8h2U1+VVLavdKlJW9YdEvwESUugFB3cvt+twqDJqkeimqC
	 m6I5GyF4BMarLGt2RNn1PZ98D3jh8nDopHXPI0+LVtT/cWBPdEz58ybtwfPSm0dGZQ
	 EgLSkzb+oTcUQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4V92XB1v79z4wcb;
	Thu,  4 Apr 2024 11:28:10 +1100 (AEDT)
Date: Thu, 4 Apr 2024 11:28:07 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Krzysztof Kozlowski <krzk@kernel.org>, Joel Stanley <joel@jms.id.au>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>, Yang Chen <yangchen.openbmc@gmail.com>
Subject: linux-next: manual merge of the dt-krzk tree with the aspeed tree
Message-ID: <20240404112807.3c7fc933@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ujqdzDz6XE4DKneGS_YF/7i";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/ujqdzDz6XE4DKneGS_YF/7i
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the dt-krzk tree got a conflict in:

  arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva-cmc.dts

between commits:

  4afd304e4e36 ("ARM: dts: aspeed: minerva: Revise the name of DTS")
  6241b65454c7 ("ARM: dts: aspeed: minerva: Modify mac3 setting")

from the aspeed tree and commit:

  e515719c17be ("ARM: dts: aspeed: minerva-cmc: correct Mellanox multi-host=
 property")

from the dt-krzk tree.

I fixed it up (I just used the former version) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/ujqdzDz6XE4DKneGS_YF/7i
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYN9BcACgkQAVBC80lX
0GyS0gf/RocHKHltomnetQH0EFL3E7Beqxj0aqpU4ciPzcQJm10xrg8IeDAbdIXs
Rse9RfA3eOHKWPe+jTQDNfHYI52zQ9nUptUhOgq3MPnQKtGxpKGA2v2g7nAlsOHp
gEmxDOEZWcn8pz6k3kK/Ja8ifKrdeqcT8HFDd/E92MAczuwSAK19R6zYd79fqOJ0
C437AdRMc75RJMPif6EWqcuyKf2LCJa2ow/ztZnOhwgaqKO6j0gfj45atzhglL9Y
F23GxIpwy0T0o2gKpDHshAcmcHOP9X7Od1+QEttpOEEB+cZeLKRybtKfnwKeF5dV
DV1xvXmTXHbTX5JWGSdPpzWLQ6Rvrg==
=x2FM
-----END PGP SIGNATURE-----

--Sig_/ujqdzDz6XE4DKneGS_YF/7i--

