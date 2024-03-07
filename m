Return-Path: <linux-kernel+bounces-94946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD670874705
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 04:59:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A746C1C21A54
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 03:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D11114F70;
	Thu,  7 Mar 2024 03:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="XpmctIwi"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6502907;
	Thu,  7 Mar 2024 03:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709783992; cv=none; b=YQDXwwsqSqOJuw6J9zD/2Ywln5fmtdmZd7MT4J8h5Qee1FpoZHdNOZWv2JkTCs2QW8X3X1aEYBygtRLnoPC47hOhday6mwHkp7YzuWbOPhMhyHmh4BsYEUiKZoNLHUjwp4ztzigYOHKWkeYtaEw1Aj1+8hJZRKBB2KgiK7LI+P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709783992; c=relaxed/simple;
	bh=yPNMZIaAf1eKxNqvwbGmcEbv4O7LxTZ/kTwP05a7f7I=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=EYT49Wp5LcCPsjzAahOGIH053+ybm0eQDcbQEBp39XAD6OWHyRdfDuw1VSQ4M5preNX7ibNi0IUc5f7MWDOGrJChIvBaAyqt0HVy4RXx18dOG5z1CnmuuFoM1JVaUj3J+gL93fmEQdLbHJMnm0Lz9CMj+KX21hTO3XMjqbR9XJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=XpmctIwi; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1709783988;
	bh=4L/+DaWbCId5H2e83O6lG45R0RKroI5minai9klNoyc=;
	h=Date:From:To:Cc:Subject:From;
	b=XpmctIwiqJwwrdVlKq5MixaISOkBQRjQfqNrTVOEjigTbXVqIyyQbJmZ49gG6F6nh
	 15S6kbn5JWol2cValHZU8RQe98FfE4BtnOdba8X8a+qAS1bLOKxOxc3NWruIXSRkgN
	 Ye2g3v3XuZAcph1xxaQIweWAkx71h2qhLTr/5oxyDIH+edUI3er30kYhdA5GNZ4YZN
	 Q2HrZc2UJx/dVJZB1UYcny43WOMu//4cFrHHyQB0CnVW4UAy/Djag7BSUYlISuY+tM
	 UZouFDQaimNM2Q2uqNynEOiyUNouyjR882OkNbDleHmCPJkrT3JBqpgH41SYPDg0tw
	 6tqAqSFk/g5pg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TqwYJ2R90z4wcC;
	Thu,  7 Mar 2024 14:59:48 +1100 (AEDT)
Date: Thu, 7 Mar 2024 14:59:46 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Sean Christopherson <seanjc@google.com>, Anup Patel
 <anup@brainfault.org>
Cc: Haibo Xu <haibo1.xu@intel.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>, Peter Gonda <pgonda@google.com>
Subject: linux-next: manual merge of the kvm-x86 tree with the kvm-riscv
 tree
Message-ID: <20240307145946.7e014225@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/cT/yWs_83ci0fs0UAHyzWOS";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/cT/yWs_83ci0fs0UAHyzWOS
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the kvm-x86 tree got a conflict in:

  tools/testing/selftests/kvm/include/kvm_util_base.h

between commit:

  1e979288c9b5 ("KVM: riscv: selftests: Add guest helper to get vcpu id")

from the kvm-riscv tree and commit:

  be1bd4c5394f ("KVM: selftests: Allow tagging protected memory in guest pa=
ge tables")

from the kvm-x86 tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc tools/testing/selftests/kvm/include/kvm_util_base.h
index 39c2499df341,194963e05341..000000000000
--- a/tools/testing/selftests/kvm/include/kvm_util_base.h
+++ b/tools/testing/selftests/kvm/include/kvm_util_base.h
@@@ -1081,6 -1128,6 +1128,8 @@@ void kvm_selftest_arch_init(void)
 =20
  void kvm_arch_vm_post_create(struct kvm_vm *vm);
 =20
 +uint32_t guest_get_vcpuid(void);
 +
+ bool vm_is_gpa_protected(struct kvm_vm *vm, vm_paddr_t paddr);
+=20
  #endif /* SELFTEST_KVM_UTIL_BASE_H */

--Sig_/cT/yWs_83ci0fs0UAHyzWOS
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXpO7IACgkQAVBC80lX
0GyG9Qf8DDP1fXzfBSzdkDdU4qEEiccdmqmezJaI8DGdGvOd0lWf4c7jIbksOkhz
FQus6ycG/LnM+t8lK5dtMiWvdobwoy0JtYKvOjchozKrPMtGmHxIq0amuqIaIfc1
eV20RrvdmVylHdQcEe0vLCUcGcUWsaSViuKzXK8LHXN+lqPlx4/b5IdW4BcXw917
7ccMxIhvOGmBWktCT6m9zFZIMv9WC6WOmrgoNVtqiHdc6cEnlcGiCKFRwVDBT677
Ez1Inmsexe60dQNvr51A4yZcUwHoLCtOp1k9hQpgcDSe4lvBLiw0CM0lc765TJjH
SP1LUGwGt62e6CKlzPxhGcHilAwQmQ==
=Hulk
-----END PGP SIGNATURE-----

--Sig_/cT/yWs_83ci0fs0UAHyzWOS--

