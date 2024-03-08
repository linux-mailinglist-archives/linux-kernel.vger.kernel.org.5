Return-Path: <linux-kernel+bounces-96436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66965875C13
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 02:48:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 074C3B2184E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 01:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 585052377A;
	Fri,  8 Mar 2024 01:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="jUZ5AzYd"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5617224EF;
	Fri,  8 Mar 2024 01:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709862465; cv=none; b=LQooEjDB3SroaMQ0j5sWzD0h4Me/qsJV81Y9fwvz0aOtwN3VguR1uba9BwSgZikRz32+4+fFQvPRbWnAOwTf2lxLHIWyN/VPS5s8jU/Atl43842B2ZB2OpEgtNexJsvb48KWUYETi3um7TKdRBTPpCI/h59awiUxMWUmpdxQmrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709862465; c=relaxed/simple;
	bh=qnucwu8sC+b5UCLM9QazJeTUSkl3RvfDeIUyhAnL+GY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=m+d1x5eR4mK+ufFjKVson0r3iLn6aAarblfsPhr2BMdH+hxYFUt9mUh2sM5bN7MK2+oPtPN5o2QJA0IEpyiD03HhczJyZgi+15AKcHAPfQtfK41GIR/leAnnGsxEInL+qs0uBkLaW7ICjxw9A0pfKWkRiV/RAvE35DVDex61vvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=jUZ5AzYd; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1709862454;
	bh=qAbAssxvhgRYu6NVeoFSc//1sLgqbgjwD49nQyyyh2I=;
	h=Date:From:To:Cc:Subject:From;
	b=jUZ5AzYd6fSljeswlwQ7oyinqWQYzTBEvbhvAyk0Hg5i8fKemgZwdkhiHM0+Bi8ig
	 PJdrkiTmb5sN17HTkDKFlI4zM9tJj9NEF6Cg2A9zTAd8vmTKO/WqHfiDquP58vKmKl
	 sYvkuH+zF4Uo+mTKe4gmzgUw2q0ABnStPgLIPJsAkhoenTf6ZBx23Z+mqBwbfLnA5A
	 mMrxBQtmzT/7p2Zb6mAtWHVVDvc3UBe9a7+CmCF/vgCJUsDq3geNjB1jrcscpvtH+S
	 WzluQO3KV03U71kAuQmORIG/yaxZABcxI3+qt8aWEt1eYAXUYQm/EEBZ8ryj3u/l5N
	 CO3HaDqfik9FQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TrTZF5y4Pz4wb0;
	Fri,  8 Mar 2024 12:47:33 +1100 (AEDT)
Date: Fri, 8 Mar 2024 12:47:31 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Christoffer Dall <cdall@cs.columbia.edu>, Marc Zyngier <maz@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>, Mark Brown <broonie@kernel.org>,
 Oliver Upton <oliver.upton@linux.dev>
Subject: linux-next: manual merge of the kvm-arm tree with the arm64 tree
Message-ID: <20240308124731.098502b1@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/yUSZTzhEF0rOIcqwwxU2xH5";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/yUSZTzhEF0rOIcqwwxU2xH5
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the kvm-arm tree got a conflict in:

  arch/arm64/include/asm/kvm_arm.h

between commit:

  b6c0b424cb91 ("arm64/fpsimd: Enable host kernel access to FPMR")

from the arm64 tree and commit:

  84de212d739e ("KVM: arm64: Make FEAT_MOPS UNDEF if not advertised to the =
guest")

from the kvm-arm tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc arch/arm64/include/asm/kvm_arm.h
index 7f45ce9170bb,a1769e415d72..000000000000
--- a/arch/arm64/include/asm/kvm_arm.h
+++ b/arch/arm64/include/asm/kvm_arm.h
@@@ -102,10 -102,8 +102,8 @@@
  #define HCR_HOST_NVHE_PROTECTED_FLAGS (HCR_HOST_NVHE_FLAGS | HCR_TSC)
  #define HCR_HOST_VHE_FLAGS (HCR_RW | HCR_TGE | HCR_E2H)
 =20
- #define HCRX_GUEST_FLAGS \
- 	(HCRX_EL2_SMPME | HCRX_EL2_TCR2En | \
- 	 (cpus_have_final_cap(ARM64_HAS_MOPS) ? (HCRX_EL2_MSCEn | HCRX_EL2_MCE2)=
 : 0))
+ #define HCRX_GUEST_FLAGS (HCRX_EL2_SMPME | HCRX_EL2_TCR2En)
 -#define HCRX_HOST_FLAGS (HCRX_EL2_MSCEn | HCRX_EL2_TCR2En)
 +#define HCRX_HOST_FLAGS (HCRX_EL2_MSCEn | HCRX_EL2_TCR2En | HCRX_EL2_EnFP=
M)
 =20
  /* TCR_EL2 Registers bits */
  #define TCR_EL2_DS		(1UL << 32)

--Sig_/yUSZTzhEF0rOIcqwwxU2xH5
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXqbjMACgkQAVBC80lX
0GytMwf/Wt4r7IPuELrFWWrxuNxwXwMbkS8EdIxLkDqfTyq3DSOV8hly/M+gfRjC
xQQmlgPBcdnL1T1CG9HrPZIvkWQeHRbDHvMmmkzHBWLV4Gh2yz4eSxvHux+6Eu43
HTo3OsvZQ0RqikJ4gtoh+A966iVP/g4BO9khGv1eP81UAkKdxb/ZF2gG1DHtkL2Z
6Y+Ec86cLRGu/LOzUFrri2VQuIDD/1+GPwa/YhhT8FVlyklFlK1OI++Gc1qUHcYb
iifXsi691xVWwlFJotF391UgQPyClg8dfrJkeoJVB0b8vjcIDaU9RPG9dqO7Y/4v
GDf5cW4ijOgJooje7b1wcZovuQratQ==
=qKbr
-----END PGP SIGNATURE-----

--Sig_/yUSZTzhEF0rOIcqwwxU2xH5--

