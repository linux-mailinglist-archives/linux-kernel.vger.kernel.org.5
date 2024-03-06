Return-Path: <linux-kernel+bounces-94637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C224874276
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 23:09:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 288A72813F4
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 22:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F5011BF28;
	Wed,  6 Mar 2024 22:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="iJVuTFwb"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FADC1BDDB;
	Wed,  6 Mar 2024 22:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709762965; cv=none; b=Gp4tR1FX1nLRTo69Az8JXLTkvG/oRchKLPfP0nXAE4oCnJ7CcVNT1oSbT/luoSvRqRBoAt84L2sTLT8xXrXP9xwGW80FEAd8kDoKKPoSb96+LP3tUZQIwuWT/GUiVIhRqCMrlfyaitYfymVzGq/oXnLo6ICRsyoKIDztiMZmpLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709762965; c=relaxed/simple;
	bh=LX2ohAYl8GQhiaId94O7ro0ygMkHO5YfA3YAXAoF5mI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=s6vvUyeQuvNu2UuMzOx1OsY1w0fXV5bdaP8z8nO7F4X9vxF3gJlReGaAk+qSxOPJEKiBriA9ZlFU/xkV273CYceSJ4pNa11VMUditl0loaYnNjMV60pa4OHwu0Y7kdB83kLpBhySpF1v32ROE58dBtd9BiMsHKkZqBne36ybyoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=iJVuTFwb; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1709762961;
	bh=AarL41wooHKw8YJROa/WRYWLj2wJyebbSOYHzcLWAtk=;
	h=Date:From:To:Cc:Subject:From;
	b=iJVuTFwb3BAZf8YAlxY0w9dFZzpGqHgMMZtrgTWTad5nlr9kk7X8f+qg0vrKYmUuw
	 DZbm+oNrigUm8taaaEJ12R8UggRSNgF4HbfDEv6G/okDnsUtF9iortuRCH0F/d7lJp
	 tRtkESnEflobSRZ8Zf9hGn0v4kJs285SStFxAZGDgwUNApnUDlrN7XfOMcOw6+dPYF
	 64rksSrxRW6G3EV4rt7aXEnoGgD4We66UaJu+zaftFgCSe7oOh9V7ql1t4EgE5mRVs
	 qcz6Bx50yTad3OM1KeWelWKaPMrBmrgUHzF48HFbSxIW2VC1YOfm0/TkP5zh38y13s
	 hnljmzzH70alg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Tqmmx1qL7z4wc7;
	Thu,  7 Mar 2024 09:09:20 +1100 (AEDT)
Date: Thu, 7 Mar 2024 09:09:19 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Anup Patel <anup@brainfault.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the kvm-riscv tree
Message-ID: <20240307090919.0db47a6f@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/d8tXtcvSMy08nQJOUF3/yhS";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/d8tXtcvSMy08nQJOUF3/yhS
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  2c5af1c84603 ("selftests/kvm: Fix issues with $(SPLIT_TESTS)")

Fixes tag

  Fixes: 17da79e009c3 ("KVM: arm64: selftests: Split get-reg-list test code=
", 2023-08-09)

has these problem(s):

  - Subject has leading but no trailing quotes
  - Subject does not match target commit subject
    Just use
        git log -1 --format=3D'Fixes: %h ("%s")'

The date portion adds nothing.

--=20
Cheers,
Stephen Rothwell

--Sig_/d8tXtcvSMy08nQJOUF3/yhS
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXo6Y8ACgkQAVBC80lX
0GwHgwf7BFBkh33wkIhRNafL7cFlfZ1WvGr/n11SMnooLrEXfGI2Zg+Q/cIN0omj
xu/JR3s3XHM4r57tcHhrfHx6EWqVN4EaqH/69rivD8mT2+16oPPotr8ZBb873Spb
gGcOz3twi76qsmx2HjztTNGN0w9xedNUgCVKQxtWP3jZaGVppbwgs2GvnTjm/6+7
ERvsGd8soV3hhnVan3G4qMRjnPJEA3FDcbjz9mIExxJrs9A8vlqyjOgtCk6vWujn
+VAyRXboilhoLY9fPQkk3gVQ1t1Vd8o9QhnG8RUF5+Q1td2OClDEO1SD6t6OV0O4
MPw1DX9fALwQbmmnpTsWXW6dYAiu6A==
=eaPS
-----END PGP SIGNATURE-----

--Sig_/d8tXtcvSMy08nQJOUF3/yhS--

