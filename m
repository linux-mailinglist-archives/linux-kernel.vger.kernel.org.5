Return-Path: <linux-kernel+bounces-49162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C78258466AC
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 04:54:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 065F81C244CA
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 03:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F10DAE57C;
	Fri,  2 Feb 2024 03:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="gxc1ayiJ"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3E0E549;
	Fri,  2 Feb 2024 03:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706846059; cv=none; b=ZjNkwldK9A3CNlbHodhx83Sl/4656dAc28YJ81Tzcrkc0/HLoh4LxM98UXJ6Sdn9ZmMpsLBOS6RGKqAxbTfZuOPO7B4vbzltNgD7RraXvjUcAwJMc+Pni5qAba5cSMZrtSAgLYMD8sr7VQcIcC/PC1IoZS287EONzLXT9a/DiTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706846059; c=relaxed/simple;
	bh=hovU4v6RNJspQnijjpSOQNwIuoXWRyMt0Gp5bdBDMXo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=A22iF6AxW6WOKwqrSWjZEfElAe7sU/ZekunOVLIpJGmXVLNyZpVA+plH15JhFcKVWH1ubswqvuzDMv2Ku1Efxx0E2feo1PwogfVdhdDCk3+88k1tdOgu//rcfro4A2jl8v5VUwt06NDPq26IUbL4mXzg+rkhYighN+KrdTSOks4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=gxc1ayiJ; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1706846054;
	bh=czID3W6OQTy6W9zm/O7HeCA6UzCDsh8k477jgxSdcck=;
	h=Date:From:To:Cc:Subject:From;
	b=gxc1ayiJoD0DtoXUEJylNo29EtKhV/7bIOY0I3/rLw5szK9TIZAuUMZGCuwVyqM2x
	 Fogzv3O4EWYZOWiAsh5DFcQBATya4S5fQORgzrnURPWMJKc2nB3K0sXDHp0IsNv2Xy
	 zoM5QMpn5A1nouirgZLAu5bT0g2rKvngBxVs1Kix5OMkswUz6gATn9gWhJVmxunWp/
	 vw4TNxd87gnQFiZqRpAdba3N6k9l2a1PullH67BO8Z3F6BYaGUMyqjbrAUmQhbZOBD
	 glDJpIehO9+XIfv32Fi43bXDLro/ZOZFsSzm9SK8zHIHfcRnxxURWrJugBUoTA68VL
	 XKaNFwRzDtGxA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TR22Z0nYfz4wbh;
	Fri,  2 Feb 2024 14:54:14 +1100 (AEDT)
Date: Fri, 2 Feb 2024 14:54:12 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the v4l-dvb-next tree
Message-ID: <20240202145412.336db5b2@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/5Punizh6YVtLZ6JouqZJ6Oa";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/5Punizh6YVtLZ6JouqZJ6Oa
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the v4l-dvb-next tree, today's linux-next build (htmldocs)
produced this warning:

Documentation/driver-api/media/v4l2-common:6: include/media/v4l2-common.h:5=
66: ERROR: Unexpected indentation.
Documentation/driver-api/media/v4l2-common:6: include/media/v4l2-common.h:5=
67: WARNING: Block quote ends without a blank line; unexpected unindent.

Introduced by commit

  a68e88e2cf9e ("media: v4l: Add a helper for setting up link-frequencies c=
ontrol")

--=20
Cheers,
Stephen Rothwell

--Sig_/5Punizh6YVtLZ6JouqZJ6Oa
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmW8Z2QACgkQAVBC80lX
0GxwPwf/Q7ENy50sXJ56BIkevDa96TFfjp/gzk4EO7nEab3tIfWC1pAHDwTW1Uzq
XyXEfInG2Drz7AjSGPMHdm2IIZXspAn+l0OJclRGTPcsbr7GhivNV9rbPfGKjZU8
IEcmaqOptePZ8wwxzbkMBBvmw0m6yvaNxTAg4z+2/f4HutNUfAVtCLZk/IRRHzbH
uzaxHqli+DBJRCmPEzAJll8M1Up696q6qJAy3mdQMgt0Xhowk/ngxsvSTgVeRTRy
QzZSSXMWZrAO+jMvPu1y/reR7ZUZe8GzyywwVr9Qa8V+BOP+5DN0O2IyAGtuYb8V
RWxS06lCKTRftX8IBxp8a3gaJjI5ww==
=ODP8
-----END PGP SIGNATURE-----

--Sig_/5Punizh6YVtLZ6JouqZJ6Oa--

