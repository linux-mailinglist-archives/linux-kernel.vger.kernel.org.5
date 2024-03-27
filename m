Return-Path: <linux-kernel+bounces-120242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D21B988D4C3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 03:45:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E975E1C24C04
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 02:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89FAD219FD;
	Wed, 27 Mar 2024 02:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="oX5hrtcW"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E797F21101;
	Wed, 27 Mar 2024 02:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711507528; cv=none; b=aR13txl6lHbyOQ4JcvNlA5QAl7HpOalRoOk7o3yvb9+AQx7x/aGed7lL/Q7LXDr6azu7/1OWOJVaaqnezy6lahrwm6Ol898zEzgdbje1zz08DpMhPMj9boMyfE6iLV38M5ZkwmU30UeymEOx9zb2sbXFvc8LohNbQbMycyWM0oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711507528; c=relaxed/simple;
	bh=5MHiWieVQ4gbjFpnZPpz8dKpkqqX+jPNDtx3xM1CSzg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=EXbEimKnkbf1JENCajgXvvQaBoxn1pdb0ICODwwZ3A83h6wDB21W06N12TXmuCh0E0aszXE47lGha1Sh7FzchQnlKTMBOzzIHxAcp5G+sgxIRa4ppWO44gvx8Y2J8ME7RINnzxMpXN658twXuz41Uh664CbLgFIvsn9U/oeW0lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=oX5hrtcW; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1711507523;
	bh=UNyyFnWd5iTHu4DRnwAINrJMJPeoN+TCGrIUZ8pnd9k=;
	h=Date:From:To:Cc:Subject:From;
	b=oX5hrtcWDm0CiNoiy4z22mDNXDRLFYt4OuDU/GuDX/BtXQlubZuOEicAeqktVgJDV
	 DxHclqmzKa7h25/yJQWY+iA1NzFr6UsADhHttCAvOcWw4+0L2XEOaCC7GEx6zAxxhb
	 tf5tX59KaC9pno3gY40rVJklHXuibi0p8biT6hackfw6x9D0sNFh/MWITA4rWTx0ge
	 rY2J57Vedla9C3r0LGD315g6ffQII3FgtY2iIfwRIeg1LECVteYhaKyPc7IbY7U1qZ
	 MxXc86EMIkulx09iOtu4zTCLpy7vXGc+BO0d5J9GDW6VtY1qzbPukPEJZVVaSllBWs
	 DXd6dmAcwZt6g==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4V49yC0yXDz4wd7;
	Wed, 27 Mar 2024 13:45:23 +1100 (AEDT)
Date: Wed, 27 Mar 2024 13:45:22 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Igor Pylypiv <ipylypiv@google.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the scsi-mkp tree
Message-ID: <20240327134522.7ac4cb54@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/6V+TiWKkVGZQcTnjs349U9o";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/6V+TiWKkVGZQcTnjs349U9o
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the scsi-mkp tree, today's linux-next build (arm64
defconfig) failed like this:

aarch64-linux-gnu-ld: drivers/ata/libata-sata.o:drivers/ata/libata-sata.c:9=
00: multiple definition of `dev_attr_ncq_prio_supported'; drivers/scsi/libs=
as/sas_ata.o:drivers/scsi/libsas/sas_ata.c:984: first defined here
aarch64-linux-gnu-ld: drivers/ata/libata-sata.o:drivers/ata/libata-sata.c:1=
026: multiple definition of `dev_attr_ncq_prio_enable'; drivers/scsi/libsas=
/sas_ata.o:drivers/scsi/libsas/sas_ata.c:1022: first defined here

Caused by commit

  b4d3ddd2df75 ("scsi: libsas: Define NCQ Priority sysfs attributes for SAT=
A devices")

I have used the scsi-mkp tree from next-20240326 for today.
--=20
Cheers,
Stephen Rothwell

--Sig_/6V+TiWKkVGZQcTnjs349U9o
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYDiEIACgkQAVBC80lX
0Gx1kwgAlcy71BSzACqBTfsHwKEMbxPzlaVklXmye8xLbQdKF04NOLbswfh5dxLa
PrPXZ49DywoSxD83ff9bUFTmCRj74zF6mxoHXxaNYBewI86h8liFJq2DYwpVtd4X
WT3Y1T5ddMKCugg0qkFe08UTkeHMgtA7FkWEplK0ZRlmf1iLoRwaAwC9MjUV5S37
IXxRVjyFifcKwFLiY8ldnQp9yv037ucnzY8LyzfYkBOiHEya/rjp6Kv7FIyDKPzp
5WSd9YpjtgxBK6leUnfbIoBuD0NCMm1eUnN4qz3OXgc8VwMAkhFfSnOLLXzIilP6
u6KEPm3Vc8X+OqmnMwjxMJAShbNhdA==
=1FqZ
-----END PGP SIGNATURE-----

--Sig_/6V+TiWKkVGZQcTnjs349U9o--

