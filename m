Return-Path: <linux-kernel+bounces-137684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C938589E5E6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 01:09:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 824792846E2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 23:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DF33158DB0;
	Tue,  9 Apr 2024 23:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="W28KEUCv"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56635156C6D;
	Tue,  9 Apr 2024 23:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712704143; cv=none; b=FRA9EqKNcup7Buh3SShYaykr4UdFC2+m3KnSDGEyl3wtBsqjACPXvzfcanwYIt91kLYx8/CnX3Tb5ab9QgfXNtL6Q3Z3+xbP7cIJJyw1h5S6u6+K05azWquVmnCYFbSHj7lFAlWCI5WGJh2bGajHqLxM6Qx8xiG6Ux+1yKgOSR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712704143; c=relaxed/simple;
	bh=ZYIQtNCfFcQ4hNAtIYvJF57vHrzLbrpfBGOVmsFAmUs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=b2ERrrMBtgULBNGpvfV0MFKv9X9t6fhHuRQwBO4RXeg0un3lp0uSU/sDFcCSsIV9g/8ZiI/7EJyLnEUPwad3de6P9Yp2WPcNNmcVbM0ZMEQSILWsPFqoxbiqKdK0ZLTcTNp9WRbNWYHZ++TfnNAeULGuCMbhLvOoIziIriVYxxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=W28KEUCv; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1712704139;
	bh=vbCWh37N3JF+rpOCB/gFvQkREDM91HMUz4kTDIPorxk=;
	h=Date:From:To:Cc:Subject:From;
	b=W28KEUCvCKaepIji2qf1NR2BlbFE6bk4HhNR3z6UcRJlJtfvhcq/mB8xqxVtDeIGr
	 +7vffGIyWKbD6oKsAF1dDE4va/CGlGB7vqXcaI1RgncwIWQPrlCTqLNvoyZzlgqVe5
	 Vvp5Y5M6dJWqvmybd6xvEI92yYUjLCHj4iQzmXHu6dju7OaCPdZASS9YMLlsfb0nyO
	 Rt2F/LHKjQZdtUZKzmvMw6kcy8feIkcTkyRIUBal9oa9d33IH4KsNlDJuiJ9mbsoTe
	 FFJjFiAuvd9HS9FZOKEhwQ80l2TNAjlSL5MlKCd+Q4QpykQf1/ObZ1b438V6AIAwMd
	 BCyfEhOqO8vYQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VDhV30MGGz4wcn;
	Wed, 10 Apr 2024 09:08:58 +1000 (AEST)
Date: Wed, 10 Apr 2024 09:08:58 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Olof Johansson
 <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>
Cc: ARM <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the samsung-krzk-fixes tree
Message-ID: <20240410090858.549161db@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/R9JxI4JxuZwOJR6X5NGLobo";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/R9JxI4JxuZwOJR6X5NGLobo
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit is also in the arm-soc-fixes tree as a different
commit (but the same patch):

  c51102b6a279 ("MAINTAINERS: Change Krzysztof Kozlowski's email address")

This is commit

  011d79ef1cfa ("MAINTAINERS: Change Krzysztof Kozlowski's email address")

in the amr-soc-fixes tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/R9JxI4JxuZwOJR6X5NGLobo
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYVyooACgkQAVBC80lX
0GzlDwf+LGeky+9sZz5xOoezwuwf/OsMakl/BT3+WM0tSHylI39hORJjBsXhbcdB
9NTPwvO5ULyfEg6IGOyM7yQ4S7rJZprZSVy5oRKoH0IJ7Wgztj0atRO4m1m5nmMU
y9QM+xebaYrdEz+ux8xc6BN0BbO5ymxgKZSXM9g7K9DJUpZJb11bCnZlbJ3nvJUk
vEFhkREiEeS/YuPPOQbaf15omzm5EKdbxaswi6tmMMk7XtmMPYoqgOQPBMfSpy4z
zBxx0yo5q2XXHGVXXv2farOwXPbWoxJ6KOL1cg+Z39xrxaNMaxZqZvQt5IBeV0AS
vvRu6FvKq0b12pjbj+0g+Tse+VzhkQ==
=NJgb
-----END PGP SIGNATURE-----

--Sig_/R9JxI4JxuZwOJR6X5NGLobo--

