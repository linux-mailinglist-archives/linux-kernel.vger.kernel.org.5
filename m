Return-Path: <linux-kernel+bounces-79912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F64F862892
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 01:35:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7CC1B215C2
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 00:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29DA24414;
	Sun, 25 Feb 2024 00:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="TP4xKcBB"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5932563
	for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 00:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708821320; cv=none; b=fHUivMvhy/Q9MLmXgQU/b3pWQKuccctVgRvVZJR3HHI47YC4x9qqx/pcdv4xSNUcL5S/vpV/l3eV/297nj8+zaMB4+5y1TNUOEMsFZZ/BJ4TmqivS3hywixpTBC6jL3t7m5F3nY3u91YLDmOwb4T26pS5pl2SUK7iX/1ZS9smz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708821320; c=relaxed/simple;
	bh=YyNmnQcgMnBicLCHSi7QdvGXDsgOzEQqbmavpqIdfhs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YGUK4u9t2g5BUNmPfBP6xhj+KszbzZZfkBZ6EsmWO/3heAD7s9nTrIwAXLd6a0nr2aDhnhbvtm8VaiGgu2bm0/0pMHYMJNA6neuLVKap/bJbTVsSVMGPfEhGAiYJ4Q8YsoFHmeSelxZK4smtQjVhaqQEVcUd3PKZ5DveS5nNH2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=TP4xKcBB; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1708821315;
	bh=tLvA27IywCqmPJdmZJrtx88ptnr/tpk26DDMKilY+sg=;
	h=From:To:Cc:Subject:Date:From;
	b=TP4xKcBBXil+pgij8AERokUut70iOOLjx59dCdVtoSuxu8fXDPZzFDKAD5Io0LvCN
	 iPNap4A15QAWQpUQ3FPRrslmaDkRwABIC56eDHTJn4QviAUfv1r9d5QzmbOVqybGbT
	 N3fSAlRJO7GZ/v6r+ICjVMHQOTYa7lz30nPxs9Pym8m7mV3ZR2/AmaHgOGyN+7X+6x
	 afxWpRsRE1yoW6SUE0zHJu3ttll0lztp+Wfcw2IAgKzJO5RvPv8gHX3uKomEnxchMp
	 xBoJKetVL6fn7U7jX1CrwI5XAWIDqjhX1sv/lnPgZqDnpOU8giL0+dQlm6akfKGaJV
	 Xlx+n2dG19a5w==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Tj4XL6BNkz4wcT;
	Sun, 25 Feb 2024 11:35:14 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: amachhiw@linux.ibm.com, gbatra@linux.ibm.com,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-6.8-4 tag
Date: Sun, 25 Feb 2024 11:35:14 +1100
Message-ID: <87jzmt9y9p.fsf@mail.lhotse>
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

The following changes since commit 0846dd77c8349ec92ca0079c9c71d130f34cb192:

  powerpc/iommu: Fix the missing iommu_group_put() during platform domain attach (2024-02-14 23:59:23 +1100)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.8-4

for you to fetch changes up to 20c8c4dafe93e82441583e93bd68c0d256d7bed4:

  KVM: PPC: Book3S HV: Fix L2 guest reboot failure due to empty 'arch_compat' (2024-02-20 22:32:20 +1100)

- ------------------------------------------------------------------
powerpc fixes for 6.8 #4

 - Fix a crash when hot adding a PCI device to an LPAR since recent changes.

 - Fix nested KVM level-2 guest reboot failure due to empty 'arch_compat'.

Thanks to: Amit Machhiwal, Aneesh Kumar K.V (IBM), Brian King, Gaurav Batra,
Vaibhav Jain.

- ------------------------------------------------------------------
Amit Machhiwal (1):
      KVM: PPC: Book3S HV: Fix L2 guest reboot failure due to empty 'arch_compat'

Gaurav Batra (1):
      powerpc/pseries/iommu: DLPAR add doesn't completely initialize pci_controller


 arch/powerpc/include/asm/ppc-pci.h         | 10 ++++++++
 arch/powerpc/kernel/iommu.c                | 23 ++++++++++++-----
 arch/powerpc/kvm/book3s_hv.c               | 26 ++++++++++++++++++--
 arch/powerpc/kvm/book3s_hv_nestedv2.c      | 20 +++++++++++++--
 arch/powerpc/platforms/pseries/pci_dlpar.c |  4 +++
 5 files changed, 73 insertions(+), 10 deletions(-)
-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJFGtCPCthwEv2Y/bUevqPMjhpYAFAmXaiwcACgkQUevqPMjh
pYA7WQ//X2oU8721KN9VjHyeEjMS31bqBW2VqIOhqONDZu374sbwrOxb0gfGQXGX
0BQK/YWC96BO1JShfswMYgH8zaya0DzggwFPoFxjsiS9DYY9fR4xX4mR1eFUMJ1a
Q6yDKulx1pNDe5plLqkSbAAeZoCpJPVfnNgel2YV1BiySxgZd2b/tMgxbrhyUcl4
ZZSZGQsMLVzOyllGQba0Wu87D9uJYd5mpsy5pRGeSG2nQ0fvEdjUGlQlPqOAJk4D
w8z4ukBQypFfq+XAjOeJ1Vq8lwTdtvGnSEB1VrHe1sq2jLboVDin0dSWypuOSvx8
/aO9bzOSiB+JAlGlvECEZJYvlCjXIVHXN5HpbGBI33PB6kNyq67GNmVa3JvsWtmC
3mzHH2l6PbMmaeunp8c8I/8GvaUZuADfA5dac1FU/2vCLIBYt0UXP2vOsw0dPnLF
zb4iNEPmweZC/+bVQSY1PMU+ovUqa/nVKcMcU1NAPynQVRzC8kigkvwhsbnPKmhD
o/6JmX9t7RFVLVDi8AylzATNLf0NyztDBXUE4d1eJk0Eek7EqbEyCaswqUzX2dXA
42Kq8TjEjBVV7RtanW9/IFGunpRCbyqWXM66R0AXb8lhG9WOnLdE5amlUZD2jgm9
SmTtef1sPlQJV/CBVTCEV6ASNj7wo5tZpRJSb5ON4fSq6d1nP/U=
=0p8Z
-----END PGP SIGNATURE-----

