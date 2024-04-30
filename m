Return-Path: <linux-kernel+bounces-163322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 15E4C8B6971
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 06:28:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76CE9B22A46
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 04:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6FAA134BE;
	Tue, 30 Apr 2024 04:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="dClXbTql"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC86C11CBD;
	Tue, 30 Apr 2024 04:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714451305; cv=none; b=Svy38hjIY7jcuEJqKQH7oSs7gKRGHXQ33KCxxmXKu0sAgs9ZrAaBa1Q6LP1hWaMNgQkEJBhKMHs7HzC1Az9YxTrhABFB+lneD082rd7tieqrvaYngaAE09lrw3dG3ir94L4sjd08LeZGX478r7H1WLPMCij3Iobd6fPVAG3rHsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714451305; c=relaxed/simple;
	bh=VGn9YL44m9zcpxkQnB83IyP3igbUiHLOnPeuJBsiuCs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=MKsY2/hL+KPG5/qTe5XYu9duKFLOVG+c4odqExeQTHdc6oLXGLIYIqhnwVIQw3NN10BT67Ca5ECCTgUC6Zvog5e6dUhXDQE1cVfPQA7BKGahtPgAIPvZFXO59flFQL4HKgY339F7qbniDzIDwk9Dp6Jg92fQRZk+bZQpjsMnw/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=dClXbTql; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1714451298;
	bh=mmfMVWtuFLxiisLoXyHBRqFgLahvdQVawDE5DoqGBno=;
	h=Date:From:To:Cc:Subject:From;
	b=dClXbTqluRKIgUBYEg3nTbzU2+uF1JwwGTo2/3qmaZ7kHMM76nepxYjyxLqW0QtQe
	 0bkQuaHc5WeVzKvaeLsKx4bIOP7TNT30u95h4RkVzdZn/6V+QBe9bqG7esUH4+3h4S
	 6sYAknOxveqXqnAAzvlUsHniGyL4/498f9QmuIm+7+wZcVDk4mCjDhNZ5FFm3Q2eJL
	 oWna5uJVUpvyN4AIYoCoxE9dgv98oqFVMV9Bvmt/NXiOmlAZag6ClMJtxa9LKmc619
	 z+ANs7dvsX1s9YbGI0QD3Z8+7WU+IOkTBFtHeFsmzynFL1F/2UJeznwxpGknkByUgZ
	 CrnxS9RZ6RejQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VT6dF3gy2z4wyk;
	Tue, 30 Apr 2024 14:28:17 +1000 (AEST)
Date: Tue, 30 Apr 2024 14:28:14 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Sean Christopherson <seanjc@google.com>, Christoffer Dall
 <cdall@cs.columbia.edu>, Marc Zyngier <maz@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>, Oliver Upton
 <oliver.upton@linux.dev>
Subject: linux-next: manual merge of the kvm-x86 tree with the kvm-arm tree
Message-ID: <20240430142814.183a8167@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/sHHn/d6V6_XHdWyEGUak66k";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/sHHn/d6V6_XHdWyEGUak66k
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the kvm-x86 tree got a conflict in:

  tools/testing/selftests/kvm/aarch64/psci_test.c

between commit:

  c3c369b508d9 ("KVM: selftests: Use MPIDR_HWID_BITMASK from cputype.h")

from the kvm-arm tree and commit:

  730cfa45b5f4 ("KVM: selftests: Define _GNU_SOURCE for all selftests code")

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

diff --cc tools/testing/selftests/kvm/aarch64/psci_test.c
index 9fa3578d47d5,1c8c6f0c1ca3..000000000000
--- a/tools/testing/selftests/kvm/aarch64/psci_test.c
+++ b/tools/testing/selftests/kvm/aarch64/psci_test.c
@@@ -10,12 -10,7 +10,9 @@@
   *  - A test for KVM's handling of PSCI SYSTEM_SUSPEND and the associated
   *    KVM_SYSTEM_EVENT_SUSPEND UAPI.
   */
-=20
- #define _GNU_SOURCE
-=20
 +#include <linux/kernel.h>
  #include <linux/psci.h>
 +#include <asm/cputype.h>
 =20
  #include "kvm_util.h"
  #include "processor.h"

--Sig_/sHHn/d6V6_XHdWyEGUak66k
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYwc14ACgkQAVBC80lX
0Gww7Af/aEPqvkljoKd262ArRNpAi25R6NGo4qkrr6R2doTW+/zeePVBEsF1KlAq
du0jSpijF9aEvJAaXQERPTZR4cOiBYtCU0DtOEXtHIqKx4AnzkMhGG6fY+9/5giF
NAA/MhIx1SeaxA6gzsg73QVW4rnhSQGXplKkqbMIF6NZ83/9MmWp9AS8o2vB47Gp
EGcD/rpK1Ul6+kvwFNw9OC8QDprU43CPN/tfc3xs9aNFjb91adzjHLb2AbQkQTGh
OdBIbs7tqUYZkO5pWOPezhk35DLUshn7mHH9ItqhQKQ62GzFYYHCCZOWLzw9bk4b
jpohhFTDs9BO3YG6faBeK13DUYsasA==
=VYBC
-----END PGP SIGNATURE-----

--Sig_/sHHn/d6V6_XHdWyEGUak66k--

