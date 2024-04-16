Return-Path: <linux-kernel+bounces-146434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 74C698A6533
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 09:35:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04151B21D9B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 07:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC42E77658;
	Tue, 16 Apr 2024 07:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="qv7aTioN"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2EEA6EB76;
	Tue, 16 Apr 2024 07:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713252930; cv=none; b=ZVhCBBZn1/VEliZ8FdRk1Djr7J/v5jXJLBGv6H+/ErVhu0X391U9eHoKW4+gEex7K1o1+pIY0NxYP7q4wDhG1zIqINCUL5Ora9zHf3Cg5WmA+ZJEnskhaWj09YYnriraRq5Vml3TXCGgMz0KHlxRfyhCZTr3TrEYtD1FtYqL3OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713252930; c=relaxed/simple;
	bh=JMrSB2vtHd87jmb/6tQVI8XZlvFc5qGHfa1gdFH0WHE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=Zl/vMC4JDfHRQC6Wb2YehZArGV+FBDotvOdIBifDC2ECaURcvFsImizyEJ3QoQXuiADsQJfWRQgo9IvKRJmUbkmTjPZhggeSThyFoPIgrw3iwnKZIlnJ72vhv1JF67my/ep5Vn/9z6TCuirisivCy+8gth2cZ/miHXBz8nQdt6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=qv7aTioN; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1713252926;
	bh=tnnNt/t034qKaAf1ydeuaNKpn5Psit75e8DV0NmVCDk=;
	h=Date:From:To:Cc:Subject:From;
	b=qv7aTioNK5/NlFKcK+4a2GsyXJ+asQsQ/FRmaQe8VIm6xN/WyMxmOR7aUkT7nbO/N
	 IG/NuV7SVsUce0sN1KZ2+aCSg67aq3DQPFkPqVl//b28NrsLOlndkRzF9fIRRIajz9
	 MExabLXqxTTaiOcuV5iCGAqzx1x+WbtouAeeEwr1XW29LToZ5a3WmKnMZhOTYFuYZh
	 3gVNYDwWJHYFD86lWEH6ZQ5CDblO8m0z73rapcDtzJg9q34UfPfIJwok+IgVoCRj4h
	 yrTAE0AnZrHAO2MiJ02jCoW+v4SE6j0JH/K/8qzW5s0IOD/sonorg3MA9pGK8ezoR1
	 d6jJHtd9taX+Q==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VJbRd4RfDz4wc1;
	Tue, 16 Apr 2024 17:35:25 +1000 (AEST)
Date: Tue, 16 Apr 2024 17:35:25 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Qiang Zhang <qiang4.zhang@intel.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the mm-hotfixes tree
Message-ID: <20240416173525.13bfd8dc@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/AL+mdrIrcnRM5E1CmhuGYPo";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/AL+mdrIrcnRM5E1CmhuGYPo
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the mm-hotfixes tree, today's linux-next build (htmldocs)
produced this warning:

lib/bootconfig.c:911: warning: Function parameter or struct member 'early' =
not described in '_xbc_exit'
lib/bootconfig.c:911: warning: expecting prototype for xbc_exit(). Prototyp=
e was for _xbc_exit() instead

Introduced by commit

  aaeda6237dec ("bootconfig: use memblock_free_late to free xbc memory to b=
uddy")

from the mm-hotfixes-unstable branch of the mm-hotfixes tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/AL+mdrIrcnRM5E1CmhuGYPo
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYeKj0ACgkQAVBC80lX
0GzApAf9FEDZtT1V56f9UfCTIglLm1g4TnSkg2m5/qeY8eF8NIc1IpJYZImVPRbl
S5MydH3EJHGXqoGDANkydpH8oDpKpQcS5KsRlIv7wsh+AvCo8TAmrl1A+FWuAGoY
QctHG1+Ecdv1Kh31EjGdH7l42EyDUkZHwruqrO8St/6/b562nCiaNmWarRpi8Og5
vIZcMGUsoAd3Weksm6RfEfU7SuN9pD9HC7uKUYJuTorukCxsVeymDfVoi9SWN6zL
N6La8GCAae9KzUXmqmKeISmN3s/Evc3WFPhrHexir+YFB1d26bHbmmNiBChP+WYr
S6Be8P9pUk/rhofVb5WRbCy+fP5AXg==
=khWx
-----END PGP SIGNATURE-----

--Sig_/AL+mdrIrcnRM5E1CmhuGYPo--

