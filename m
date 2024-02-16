Return-Path: <linux-kernel+bounces-67979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23FCB8573DF
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 04:00:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4623A1C22BC4
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 03:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 398F512E74;
	Fri, 16 Feb 2024 03:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="WFLMqNZt"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2DA512E47;
	Fri, 16 Feb 2024 03:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708052427; cv=none; b=sp+xr2r87DGZbkXrzblb13nJ6qRUETLU49u+ojHgMoBzyy+TqmUe49gAEil54S+yihHzDg1wd/9LfmWxh6dDNiObElg3iQrcgiRSo1P6DLUM1jTGEdcELxDHixj1AfUrC7QNJsDvWcc2+TZZr2voTgUk3lRjH546GhPa7tx5aek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708052427; c=relaxed/simple;
	bh=LSTqPDeS4346jrM2yPW5uGfc1r/hB4+DRKdPuVrJb5s=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=rvVj2Xs3mMprU1cIrhNat7TXzFenx+1THoVAbdN+TV5blptDInhZqmaldROeep0JUGH3RgOQ5l8StZPtZ0QxrmpptZKK7P1Y6yQgWP/KJmOSOZc80a5TBlORleZLz2jY2BryDl1MLHcDeMS90eztZX/RFpWnb2UDzmmF/TPEC+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=WFLMqNZt; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1708052416;
	bh=gZPeXU9S80XAmUtliDyrDrHRtr4QSF8Km/2CmnIrY/Y=;
	h=Date:From:To:Cc:Subject:From;
	b=WFLMqNZt3ig+PVpobkyYK2//A2jOjyPrpnrEgvFfAeVwOInYYIoTkqccKP+6d7DlC
	 wejVE4jx4nKHQk3SmCf5keWkYMvOryXZuvD0AFHgusaUdw4lBng3xi4Xhgz+aJAH0K
	 NKhLptM4umXxpsvVRBuyoyozB/hpAdphUJKu3lvtX4j1Tqgv+0gz7T1T9x4qGmd9j4
	 F2JM4uPWB9X1uDfcdHg7fS//2UZJkHws5ErM48uk7lnWhSKohMjB0BW3j5G8U5dcRn
	 //i3ppjilFgKwfqS4QxpMk6J9Zq+yvqtO+99JO5YEviMZujffM+2EhcLqL3IfgmRli
	 4WTTNhhmrZHgA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Tbc9r1Lfzz4wys;
	Fri, 16 Feb 2024 14:00:16 +1100 (AEDT)
Date: Fri, 16 Feb 2024 14:00:14 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Tejun Heo <tj@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the workqueues tree
Message-ID: <20240216140014.4842449a@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Ra+./NuH5ny64iR+A/ZRPry";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/Ra+./NuH5ny64iR+A/ZRPry
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the workqueues tree, today's linux-next build (x86_64
allnoconfig) produced this warning:

WARNING: unmet direct dependencies detected for IRQ_WORK
  Depends on [n]: SMP [=3Dn]
  Selected by [y]:
  - PRINTK [=3Dy]
  - PERF_EVENTS [=3Dy] && HAVE_PERF_EVENTS [=3Dy]

Other allnoconfig builds produced similar warnings.

Introduced by commit

  9d6efa8d0dd0 ("workqueue, irq_work: Build fix for !CONFIG_IRQ_WORK")

--=20
Cheers,
Stephen Rothwell

--Sig_/Ra+./NuH5ny64iR+A/ZRPry
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXOz74ACgkQAVBC80lX
0GyIjQf/Z3sqFltaYi0Vt7RxJOJoFSby9IbDH3mX0VP07nGXs6Pkf3PgxpcY6NWF
I4dya7BQcVMBoO+Un7DaNhkSuM+dm7mqAo32wEroh+adHFb7Mep2L1y3JY/58/Qy
FZG0mvBaIkX/sQbngYmNmXuvLEgBzHXqj17uY5L9e8ntEzJk1wjKY6oNzO3nc7RE
2bVRYtt2CLBtDwaFUsknVyZ7CKlsRb+XZbFIeuha3KzP0iDao1weMSFE46DEHKSX
HnWjuKW4fhXf2mXlI3Nlt4cLnkuHEvOyeaxEmT7my4Y5UKVxmw4bV0Bs+gD0bA6l
FC9+5QsuPYGqcr+zh6Ma5NMDomBQRg==
=6ePq
-----END PGP SIGNATURE-----

--Sig_/Ra+./NuH5ny64iR+A/ZRPry--

