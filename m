Return-Path: <linux-kernel+bounces-163101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D305F8B65B7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 00:27:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F6D41F22442
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 22:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99139194C6D;
	Mon, 29 Apr 2024 22:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="M4OSVMNW"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F2C194C8A;
	Mon, 29 Apr 2024 22:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714429618; cv=none; b=N8L8DuhWjnpYl95pL684nID5ZbJ7r/J1xP93Rv7QYJnabCpgA/nCyHFMoKlNWJlZosm6ufPnHuNEpEGhfgm5BDdN1u7JR1q21QyImOF9Jj2FtiJZAu4JRYV3DWe+kQv5n/EVQEqglhxJw8z6Vo/BMzf573ogYXdLq8EIVQqnyZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714429618; c=relaxed/simple;
	bh=nw+PXY4NiFT/ui9C2ojgpsqe0LVEcLuk0dLTvjTmUmI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=mcmLlDRvRsA7Eg6SaAzlkGDcybNYEp/4uaxG/9Qz1IJRakgAZRSed6ip/AFn3SBedktZ+oTtfGgBeHWD71LnaUPSqpI+3wsR5MzxFoVvJZejxj5URWGC6PtI7OSpHxIsTXHjLMxm6pPdFGeuf41LB3hb2n7ibhGppZZRvrqXAS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=M4OSVMNW; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1714429606;
	bh=0ok8I7x80XonScBBOaaW3VWygdo8EtCsA7tG2+F2q1Q=;
	h=Date:From:To:Cc:Subject:From;
	b=M4OSVMNW10ryIw8SFsyj8yq+2tuHEC1B26j7nmZmb2GfXspNMRVDZkHWyJVLT5SmX
	 zjZ6ukSSnpVXavF07E7PhbWymyrI0EfD3iBFL/PiOMHKo+z69qoFqjgglFzi3l9zxe
	 IuMkhLqq9wNFB2+q3BnGmrOs8UZoPt+XcV4toWt2BdcVtSUcKcFa/vFw5B9NAbSAVy
	 NLNxo/b/msuCUdamAzCElBWo5/GN/4pUXwZaPOJkK5nyLxMnkIXY0vCW4oLjqaXJW9
	 PzAoFmIPcGvNQZ7LLMIC561oN91Pa5yTek3ZqIaqKVUtex+cwd7tphdX+VVOnWbxMe
	 wn57zSnfEpcfQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VSyc61ydcz4wyS;
	Tue, 30 Apr 2024 08:26:45 +1000 (AEST)
Date: Tue, 30 Apr 2024 08:26:45 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: Marius Cristea <marius.cristea@microchip.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the iio-fixes tree
Message-ID: <20240430082645.45d72934@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/90BkdkCqisBIIT0HOI39a2a";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/90BkdkCqisBIIT0HOI39a2a
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  40297eee0f39 ("iio: adc: PAC1934: fix accessing out of bounds array index=
")

Fixes tag

  Fixes: 0fb528c8255b: "iio: adc: adding support for PAC193x"

has these problem(s):

  - The subject is not in the expected format
    Just use
        git log -1 --format=3D'Fixes: %h ("%s")'

--=20
Cheers,
Stephen Rothwell

--Sig_/90BkdkCqisBIIT0HOI39a2a
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYwHqUACgkQAVBC80lX
0GzrQQf/Yc8y/sGqAdQ8Axa1QQ+E4/svMvkaFN0usDhrG/QjNGVpIJHh4WL7iRzj
749cub8i3DndO+su9C8aaxV0FyUfjbVKeMtZfGeEg9mjprNDF/ll8i21Gg6c7QJK
EK+vBZQb7KQeBMu0eFsyf7spj4QreQcjKe6wW2PF7PXhQjgI9wDHGEDN/JtA7jfn
uvypuq5Mk4FcxKFL0xXbMq6Hrp1Zgy6nKA5ByI1RVSFSwc/0o0h9aOMwQLIXji/l
7/lwPaaz+otO9nrvimXSgBprw12CZkVcbHAb3wqLDnQACfmurye54WJ4mDu982ib
wEFKyQ/dlx9/JhzSG0tXxa04+zWlUQ==
=HVu5
-----END PGP SIGNATURE-----

--Sig_/90BkdkCqisBIIT0HOI39a2a--

