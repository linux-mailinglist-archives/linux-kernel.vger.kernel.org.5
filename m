Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 196A675DF93
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 03:35:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbjGWBfB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 21:35:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjGWBe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 21:34:58 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8448C1FCB
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 18:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1690076090;
        bh=1TKytknFGuphttPIya8TKJDLqOtMLU5bs0nxrsTcGL8=;
        h=From:To:Cc:Subject:Date:From;
        b=h4UZcCEr/P8cJH05rZo2ayzoFlUo7p43V27VeHuBCxz9foBmep8zRdHp36DKjgDRb
         VREX/i76Xv4Ikdv6Pg3Uvgxvwb8Q6Ue6tn3NXUV/etFlwGYHxHjBUaHRsHQGMW20N7
         faksyP30bELyIsSYUltqKfaHdH6u8gvDc1pznkNYiLXp1QFbIfOxyYgbOQ3ok+/E2o
         yDlFad/61AKO1AlqAvdcoAZmH20Eg4YrZ4xNBfgwMICv/9hiICsxherE4VC1AliiDq
         yI+d/x+hVkVx312F+XyoTrKtO0B9PeTPJIQHOI5SESva0UeX3wXhsHvfb0RI+08Wea
         I1KR9o9em+wEg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4R7m7D4lJMz4wyQ;
        Sun, 23 Jul 2023 11:34:48 +1000 (AEST)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ajd@linux.ibm.com, bgray@linux.ibm.com,
        christophe.leroy@csgroup.eu, haren@linux.ibm.com,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        naveen@kernel.org, ruscur@russell.cc,
        u.kleine-koenig@pengutronix.de
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-6.5-4 tag
Date:   Sun, 23 Jul 2023 11:34:48 +1000
Message-ID: <87sf9fpg07.fsf@mail.lhotse>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Hi Linus,

Please pull some more powerpc fixes for 6.5:

The following changes since commit fdf0eaf11452d72945af31804e2a1048ee1b574c:

  Linux 6.5-rc2 (2023-07-16 15:10:37 -0700)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/po=
werpc-6.5-4

for you to fetch changes up to 106ea7ffd56b0f9454cd4f625474967f12ac4dbd:

  Revert "powerpc/64s: Remove support for ELFv1 little endian userspace" (2=
023-07-19 21:28:35 +1000)

- ------------------------------------------------------------------
powerpc fixes for 6.5 #4

 - Reinstate support for little endian ELFv1 binaries, which it turns out s=
till
   exist in the wild.

 - Revert a change which used asm goto for WARN_ON/__WARN_FLAGS, as it lead=
 to
   dead code generation and seemed to trigger compiler bugs in some edge ca=
ses.

 - Fix a deadlock in the pseries VAS code, between live migration and the
   driver's mmap handler.

 - Disable KCOV instrumentation in the powerpc KASAN code.

Thanks to: Andrew Donnellan, Benjamin Gray, Christophe Leroy, Haren Myneni,
Russell Currey, Uwe Kleine-K=C3=B6nig.

- ------------------------------------------------------------------
Andrew Donnellan (1):
      Revert "powerpc/64s: Remove support for ELFv1 little endian userspace"

Benjamin Gray (1):
      powerpc/kasan: Disable KCOV in KASAN code

Christophe Leroy (1):
      Revert "powerpc/bug: Provide better flexibility to WARN_ON/__WARN_FLA=
GS() with asm goto"

Haren Myneni (1):
      powerpc/pseries/vas: Hold mmap_mutex after mmap lock during window cl=
ose

Russell Currey (1):
      powerpc/crypto: Add gitignore for generated P10 AES/GCM .S files

Uwe Kleine-K=C3=B6nig (1):
      powerpc/512x: lpbfifo: Convert to platform remove callback returning =
void


 arch/powerpc/crypto/.gitignore                |  3 +
 arch/powerpc/include/asm/bug.h                | 69 ++++----------------
 arch/powerpc/include/asm/elf.h                |  6 --
 arch/powerpc/include/asm/thread_info.h        |  6 +-
 arch/powerpc/kernel/traps.c                   |  9 +--
 arch/powerpc/mm/kasan/Makefile                |  1 +
 arch/powerpc/platforms/512x/mpc512x_lpbfifo.c |  6 +-
 arch/powerpc/platforms/pseries/vas.c          |  9 ++-
 8 files changed, 29 insertions(+), 80 deletions(-)
 create mode 100644 arch/powerpc/crypto/.gitignore
-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJFGtCPCthwEv2Y/bUevqPMjhpYAFAmS8guQACgkQUevqPMjh
pYBJ2A//f8zyL2FfBB7JRFoA6B06TmEg7GR1NlxRBrW0HWNaaxbAqureHJNElcm4
0eyi0aUy1ky2IkkyqBTJWZxwewlGkPOZTDdXvGam76B8Y5U+/beHwaKlOYkb/GHs
lnlsZsMpEiHI6T7b8PFqWn+bE3O5EaJ3eamxIiPQv5XIRk84D0ny9OH4jRcbQIY3
AMZRcJIvWFSCe043JzYjj3CVfL5ySxWEjYYWNgSuhJ9zOnDb9CtZBKjHyNk0/paW
vFnG309jyOKvl+2J66+JHgCvjV8Dl2nZCjQpQ42/FX5cdRTjr/b+6FE57ygC5ZvS
jsSR/EFACAPHPOLRfdBXaRb7PJ1zDb4YCVtNTxwJ4059XBzKzvdBd5dc1UO4+WCR
dxtn4pvWHv6mCJ5YLKcJXSOgvdVq4aLtnkirwuqoY/QY7XhuYosqB305CevRJrWp
upDhMtzvofmEVN81SCB48TnzTYXyxNrSEvNjJgFby9pIXgTnXkwJvgU7LKvSrSox
cbsCZEcgIy1iUjFQZENQ3GWve1RRea77C0RAsNWSPvgLna3ITNDiKlWFo4vEtrt6
9wKKegRvOsz4yCJAEfYe62qLDu/4tqIknPxqxuapnhNj+N2+f+5wjcV8D7E7hSaP
f1y8QXbN2+yRvFGIRhdqwE0+4BEP6B/fq4XXQ1fjmw4aIrNWoSc=3D
=3DBUmd
-----END PGP SIGNATURE-----
