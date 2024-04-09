Return-Path: <linux-kernel+bounces-136112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE76789D021
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 04:01:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46F1D282A05
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 02:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 815EB4EB4C;
	Tue,  9 Apr 2024 02:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="dNliNL23"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D280D4E1DA;
	Tue,  9 Apr 2024 02:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712628074; cv=none; b=jDeFqFdmEIiH3WffOAvmdbF1kD9LCYaoV3xJqyywyPYxO7PTtL2PCO3JV1RH1jJwfd779lllxBT4de5I4DMsMbZH2w7koafK0IcQDyjRRAJjX3LmPpwo+U3fae2Mvja1TOS3R9eS0nVhFv+6u72nEQuxtXfllceEbcqDEbCsdzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712628074; c=relaxed/simple;
	bh=k14wQNkaK0FDOaPrYg1ruJBnl/3BTruD+x0EpqL/4pA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=O+x4DtsXcYZdZobop6bI2cL+f4PmrNev7AgPonMk8+4PtqGtVxra35nNkclHfEoetx4D3YWvX+ThyPr2Osb4vsgb5NeyugpnrE1Gy7oUm9kDOwm7zoz+xbjcf7ibeDG1zKyZuIwsPPoMbaYEVkrzJXK/qdkXbg5ENbLsNLHiqCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=dNliNL23; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1712628068;
	bh=QaBsR0fy92pSRuUctybjiMsVmEST5lTM20nOfjnHsgQ=;
	h=Date:From:To:Cc:Subject:From;
	b=dNliNL23RYbXQvn4mHhSfECiiPD4TRt5TppdkOACuZ8Y/2t3M3A0Sy6/dCFXWJIwr
	 H3zcnxIDpp0qz2wlahRRN3+UJ+KRK6QNZEKiK8MZmeEBoHb0wL6X9sQys5jyE68+4O
	 XHuKVwsMaEXpa+XKImGFMB5GgpQSQ69fHD3+8cyyqCCKdvDXUxRw49BxE5ICkhY5jZ
	 MkMuwtaxFOqI0ozJrCV1kXhR4O3E4ELzzdYekNN12gh3wZ7cfI+vjyeWwVeCt0wSEl
	 pbZVjr7AUzJDkuODwg3qLJSi7jUAny14MHf26lK9NxmWgcY+7SX7Hpg6KeGDOLyKuu
	 fbombheyDjuBg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VD8M852HXz4wbr;
	Tue,  9 Apr 2024 12:01:08 +1000 (AEST)
Date: Tue, 9 Apr 2024 12:01:08 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the drm-msm-lumag tree
Message-ID: <20240409120108.2303d0bd@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/a6kvfG.o5mwwx4BTHQQI_2y";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/a6kvfG.o5mwwx4BTHQQI_2y
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the drm-msm-lumag tree, today's linux-next build (arm
multi_v7_defconfig) produced this warning:

lxml not found, skipping validation

(lots of these)

Introduced by commit

  8f7abf0b86fe ("drm/msm: generate headers on the fly")

--=20
Cheers,
Stephen Rothwell

--Sig_/a6kvfG.o5mwwx4BTHQQI_2y
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYUoWQACgkQAVBC80lX
0GzBYwf9G84BwOg2pXQH/mPYTOUjRJvuZ4yMr+JiuKdJ03gO+Nu93fZYubCtmcSf
AE65gB+t//xnQ5xw8WdySJS5oFWS75nlo1FfK1c6v5f6umuUS2qb+DlBxWMYAXi2
nARdBBg6Tm6020L5xF8i1XmtgIeq7cjArkNu3byL5V5laciawYB8+gyAhTkog3rH
6/uDCPS4BGUCiQc6lLNhxMb9M7EFEKxkl0GCGmmf7/Ky+LGMGrUj1REIxPXHpKSM
ksBjn7AvD8bCJWWQyw4gl8sbXd7pCMHhh+bRL9Fy7fBu6ia/TpkkxIl18Tlp6j9t
zfmU9Epnzs8IcHweSWby3IxADmOCWg==
=xNNm
-----END PGP SIGNATURE-----

--Sig_/a6kvfG.o5mwwx4BTHQQI_2y--

