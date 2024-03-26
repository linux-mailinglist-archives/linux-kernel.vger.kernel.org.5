Return-Path: <linux-kernel+bounces-118368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BDFD088B9A6
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 06:04:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F27BB21FA6
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 05:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D70682D72;
	Tue, 26 Mar 2024 05:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="vD1DvdKO"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB3E29B0;
	Tue, 26 Mar 2024 05:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711429433; cv=none; b=W7bt4N+4uuYC8pFMXjQkYZoIKTBGlnfaqA4kvsdzqVn0U0AfjyJ0Q9s2/0unPhrAjd3jdRAkreNtR1qWbtS12Zai8FkcankBRp85eQLgQZJKt1iGBNtKjdIAW1H+b0xlycoh2opnj8TtgRdOGBaJRgC2AOZH8vA7WQT2196cVNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711429433; c=relaxed/simple;
	bh=a7Nue+36+fVdm0u+RKF8nMe6XzNIRJzxV5fEAbZRa50=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=rNMFynZeWpsYisXZGkdiovrI0u0JKB6MiqeSvCzQYGCQfnCYhN2PJPDUdvN6OBXSjsJLGjU5lHsA9Js4pjqlnMeL8GRtH3aduTwJgxaoJdyl/vXkH2ym3MYXPBusm+mcjH8zLON9JCYDnoDhrgbeuIiku9hqARDAD4mG/S5VwI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=vD1DvdKO; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1711429430;
	bh=kyzNtarj/zmgK+HZBc0usXpanvDyeAX/URW2ZPCdScY=;
	h=Date:From:To:Cc:Subject:From;
	b=vD1DvdKO0bRCE4cvRAelwclyQSceVHGt7y/XT50ExIWANEkS8cj5Q8B5MhL5k18U5
	 y73dd6y0paF84R3OWKCfptJBPDR+egkjN+TyMk4/13Es0ZyjLjC6G4gMnM60VTpIzV
	 KpI15aAMEDmZMBR6Hz85XZ3/pvUa/9mcAPscCgRoyRBAb/LOzBVbXZowFtCKhGRDQY
	 d83R9SfAZIyXUsLrPlgoez2Eaj3DXtaQ44YJ+zd6P9hCONsUcuTh1s1Y2RIXioN1db
	 d+leESH5TVrlBhPCEsuWIbxSKlWvaScoJZzgmsgOw3YGjCKbI3SPUAtCnNotyY19or
	 nD37WnJrSdwFw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4V3d4P5l72z4wcs;
	Tue, 26 Mar 2024 16:03:49 +1100 (AEDT)
Date: Tue, 26 Mar 2024 16:03:49 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Radu Sabau <radu.sabau@analog.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the hwmon-staging tree
Message-ID: <20240326160349.471ac64b@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/xKFeqpsTi/4I+ChI04stSX+";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/xKFeqpsTi/4I+ChI04stSX+
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the hwmon-staging tree, today's linux-next build (htmldocs)
produced this warning:

Documentation/hwmon/adp1050.rst:15: WARNING: Block quote ends without a bla=
nk line; unexpected unindent.

Introduced by commit

  8631d463d634 ("hwmon: pmbus: adp1050: Add driver support")

--=20
Cheers,
Stephen Rothwell

--Sig_/xKFeqpsTi/4I+ChI04stSX+
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYCVzUACgkQAVBC80lX
0GwZawf/aqmk5yFYP78l7SI6i4kHtFJRPCQONqmwNNWkiuaqYqrmGZknuOWdAXf2
MYxQexgOxcbaiv2peeiU0fubiy1XDt+QTwNqA48SkSUktR/TfCx8CL1OEp7jSHLZ
lVYM3rBTzatulJIGGbrYUuJ1AimvnQmT9/IQJ/buXQo/uIZMRBP92GJMiAvKd985
myUGi5EbH/s/7dnU9haI6hY9GSWoPG0OCCKtkT1jTZ+5PU0RIwZ6UkFBsEmAjm7G
hZd3/Io3HJ9dnQieqcFopDzkyaFund1PjyBPRseVjZxjyZhvl7DYl9mVI5z1zZuM
E9p0DNqKrn/4PgWW1K+91ZdeIiZxCg==
=mcfK
-----END PGP SIGNATURE-----

--Sig_/xKFeqpsTi/4I+ChI04stSX+--

