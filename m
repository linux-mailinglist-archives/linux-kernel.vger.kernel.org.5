Return-Path: <linux-kernel+bounces-89735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 89B6186F4D6
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 13:28:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 364471F21708
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 12:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D35E6C126;
	Sun,  3 Mar 2024 12:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="E9T1ZS0w"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675588C0A
	for <linux-kernel@vger.kernel.org>; Sun,  3 Mar 2024 12:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709468886; cv=none; b=HSJt6juzICMPMRNWq1Rov3qLntuuHi3Z/aMG/wAHC8k4BQD5gTbFQv9ZasDb0A28N9YJ0BB2EjWEiNRLoXIECZyyeefMHcz0OD6msd7/UuZZpVmWkzLp3dWpYQjkwWMq3cxZla/yhR+xTSVGpec6HQ4Tg74VRduuI2xXzNAkvvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709468886; c=relaxed/simple;
	bh=LJ9YUIu108kg8C9qNCO/7OhTfMjJ7yFvG2i4mxJIjXs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=b30lzy1/jQd4w4jdghFCz9iY9EyBcgFzxDJb2Yx0Kfc9WYar9oX0BrMkERxV4SpnoAGLCp5Q5l5tVnMTCj106KrjUHZDppzyKZjW/Z1EKxa45w5v5jr3Q8h38br0LnaQxoBZ1x7kgUmDsPuD5rAkY0Vvl5G6EK+HsEQ0jQJg+z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=E9T1ZS0w; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1709468875;
	bh=QEAXDMAV+OrDQesPZgpelgMCPzMqc/YssO9FkYejWgc=;
	h=From:To:Cc:Subject:Date:From;
	b=E9T1ZS0wpicvANs3fInjPcdL7t0mi0a2sVlkZw6m8JwihgmUCvUb9HC/rms1MSalP
	 8pv+STzglwZ2qgpuHwtk3ArMtlqk0kZkaS1/FEh1dDHqY7+abirY/7IkT3fcDY1yy6
	 eUnDNauvHvI4QGcdReSKBxI72o4Eh1AgalaJbYlHnKvb8PP9EnYfwOSK0rUsphxkvU
	 tw7j4m2zz5ETl7mbbfAh+3kPDO6xJu+pWSK1duxvpymkHrb8G5YUcKp00W9AgDJkuR
	 49ob8zpKST78vj/G4877XiCK8iwpl/viDWabPubB15CW65KTZOkLnZD/Dz51W4Pwwm
	 wANjsKuOr8Uzw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Tnh1R4L9Zz4wcK;
	Sun,  3 Mar 2024 23:27:55 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: gbatra@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, nathanl@linux.ibm.com
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-6.8-5 tag
Date: Sun, 03 Mar 2024 23:27:55 +1100
Message-ID: <877cijfqk4.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Hi Linus,

Please pull some more powerpc fixes for 6.8:

The following changes since commit 20c8c4dafe93e82441583e93bd68c0d256d7bed4:

  KVM: PPC: Book3S HV: Fix L2 guest reboot failure due to empty 'arch_compat' (2024-02-20 22:32:20 +1100)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.8-5

for you to fetch changes up to 380cb2f4df78433f64847cbc655fad2650e4769c:

  selftests/powerpc: Fix fpu_signal failures (2024-03-01 22:15:30 +1100)

- ------------------------------------------------------------------
powerpc fixes for 6.8 #5

 - Fix IOMMU table initialisation when doing kdump over SR-IOV.

 - Fix incorrect RTAS function name for resetting TCE tables.

 - Fix fpu_signal selftest failures since a recent change.

Thanks to: Gaurav Batra, Nathan Lynch.

- ------------------------------------------------------------------
Gaurav Batra (1):
      powerpc/pseries/iommu: IOMMU table is not initialized for kdump over SR-IOV

Michael Ellerman (1):
      selftests/powerpc: Fix fpu_signal failures

Nathan Lynch (1):
      powerpc/rtas: use correct function name for resetting TCE tables


 arch/powerpc/include/asm/rtas.h                   |   4 +-
 arch/powerpc/kernel/rtas.c                        |   9 +-
 arch/powerpc/platforms/pseries/iommu.c            | 156 +++++++++++++-------
 tools/testing/selftests/powerpc/math/fpu_signal.c |  16 +-
 4 files changed, 120 insertions(+), 65 deletions(-)
-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJFGtCPCthwEv2Y/bUevqPMjhpYAFAmXka0sACgkQUevqPMjh
pYDiQA/+I2ChbZG4duIm/lXz/vyaIeUTuiyxQmqg2ilpadn4gW7byridRki+fM6t
mfkjvRXqPXMjklYEWAoD/cOx9Fst94Dow+1kxOnj0gKIhY5xSrpIFsPBIkFYFaoA
6RNc1XshZQfc07txAKnc3jaXQAgBYZZJv54jbI33UT0Q3EGQlBO/SJYkBLzZdrJD
Cv61+EccysOlJrzzAkXdJP2OYBRbxKsSPDlnY712yhQQEfiKYSduxz9Xu8Y0s0wG
4UnrLbXnIsFSmqnwmyiG5po5kcoKhzdRh2NqQNnUWbXUBsnlpXLkEbNTt8dtd34p
68+sHOu+5k7bEROzZJ6rnRtmNMMX4ToQmPvtz3CZ1eQH0UomsxntMRz8uJegklpe
3/xUASE4X2KgfZbhyosMONBiAHFNrdhRyMKyYD7t/yaTiqFhpwm25QCm572gvh3t
SDEebeMc7fK2ExJYzf5wJDK4dTnD2yInyS7go+rkjysH7j3VKfZ5ySCbs1Vt3NpI
gI+RJC7HRx+nX4/9/aReaIvVHEQg7jAZXqCvHjA7pxLdbHTzDE9Ia/74sgmiZpbt
CYSP7xAOXH2juG9Nmd3PLVpn72neCuyMnwRDv90DT3dmSK+AtDpL3Qbqorh3UmmA
pkUqXv0lP85u9nXrobuy44o0LE/2S4aWRiUlEVWO2kdRR1PGwo0=
=CZjY
-----END PGP SIGNATURE-----

