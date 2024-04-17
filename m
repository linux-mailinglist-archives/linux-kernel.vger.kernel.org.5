Return-Path: <linux-kernel+bounces-147946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4477F8A7BB6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 07:14:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2F3D2833AD
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 05:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA21D524A2;
	Wed, 17 Apr 2024 05:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="MW74X5mU"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94C03BBF7;
	Wed, 17 Apr 2024 05:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713330850; cv=none; b=GRffBj/uXuVqSmURLalaEJgqrarb3LQ8asRxY03u9TLsyfWGpBP1ctkW5SF4ZC76qKeTF8gOE+pmiBUL6s3CXMBJfP8JDhj/NGfKO75N1WqytQMyBhPfoA9gaGs2tCHlCzFffsjdfnFPvQhS803Vw4sksFrIJLZDeRKVU4DdOPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713330850; c=relaxed/simple;
	bh=uNit2ZbbJNohSIwrl3Sq8IQ9FgobJb8MqkuX+1RsuRo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=Xox4A96wpc/xNvecji67NRcSECpwgI7iL1/x/0em9XJIXPfTQtDEr6jenhXTfXALrtx7Q17p3yjwRwlywRVitfUXRBFYRFfJAE5GSym2o1k1Ouo4XIPVYltIE35rK9TNNpsdG7DTE9kQLQWGnuTgxCi7GqELday03+vXYswWwAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=MW74X5mU; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1713330844;
	bh=OFz4AUUrn5pAW28yhO3deByzgoBG5yW5LaumHaDXViI=;
	h=Date:From:To:Cc:Subject:From;
	b=MW74X5mUoQpBY5J1U8r4gs7ZLZ0mGAptbZBR1GMQdX6xsx4k3K/MptP056f+g8F/U
	 lEttKobD7qFz2lrLMpWq68gjgFKwasx1c5Blz8qL/xIB1g7NUuK4bLZDHCXDU2d/Rv
	 beQ8lc0KW5Omw0G1xr/yM05x73eo0pxHBuP1WR9hHI6bBvoeI+ZPJu88482HGWenF2
	 kunKWgrkPBXKwjT+dwnT79e+i+WM5ieuuRcZ0IVwmusOG5/XwYWSFwlEkg6OJFmvms
	 5pJBc5Blj7q6RSf0liHZxmr6EnRWPFwYiO4LTx4EQNchBVyoyf+l+OLjzeA4gelI6F
	 ScuE14B4dPNtA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VK8G44kHFz4wyl;
	Wed, 17 Apr 2024 15:14:04 +1000 (AEST)
Date: Wed, 17 Apr 2024 15:14:03 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the s390 tree
Message-ID: <20240417151403.79234f3c@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/A/ndoaR6HkTxSodtYaKlwOH";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/A/ndoaR6HkTxSodtYaKlwOH
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the s390 tree, today's linux-next build (htmldocs) produced
this warning:

Documentation/arch/s390/mm.rst: WARNING: document isn't included in any toc=
tree

Introduced by commit

  231761a9db0f ("s390/mm: uncouple physical vs virtual address spaces")

--=20
Cheers,
Stephen Rothwell

--Sig_/A/ndoaR6HkTxSodtYaKlwOH
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYfWpsACgkQAVBC80lX
0GxsJwf+KsEXfr0n/2l4+o/UMRadiczBhC9bcyALRQu5dQKJY3oEWlwKnpkwnLWs
6i+srR/6SIqBOVI1Idl8mbr+FZ0Xp7jznbr5Pz/xvQExwEkqjxr/Ap7iadBfbMu6
GkR0uofETSQ4Tca/h2XmDyFsNzkJBCG+NAz/No3SXH6RhmpFrupMPi4alATbIdmA
EDv96oku5xc3/3Vnv9Iv5U/t45DLRlH+4jsjF01gbAm/gCOoOO0OEyM2bT2Muiav
gFfwD/vXNAIVEa19fF5PEfh6YRbu8ZRliMVpULFO5aZssxmPVgzw5ZPWAdL7y5rD
mLCxiki8SzZaoVym1jhtZ2VWz0HTlg==
=yNLh
-----END PGP SIGNATURE-----

--Sig_/A/ndoaR6HkTxSodtYaKlwOH--

