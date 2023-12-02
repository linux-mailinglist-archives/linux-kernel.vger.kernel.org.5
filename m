Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A792801FC6
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 00:49:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232505AbjLBXMZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 18:12:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjLBXMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 18:12:23 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D685116
        for <linux-kernel@vger.kernel.org>; Sat,  2 Dec 2023 15:12:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1701558743;
        bh=diPwzgYq7ttjANZrcYoi/1ctTlG834TrG8++NNBlRMM=;
        h=From:To:Cc:Subject:Date:From;
        b=EFkrCGBy3yqmIU7ECyk208SVqtt/FvspZPTZuuD8mbuY+yqEhjm6kfn91n3JY0YN2
         mFWrmZNjYob4te5S8htmaUXsgByisNjyQkWnPGVKFVNySIxFH7UXXdIMz+6nYjIgEq
         1fWJNfFSNBmSzdTo9bJ89HH/3xMqx8Pm/HhODkPaRAJwmFBYrQP/kC9fM5KR/TNfM2
         teVBkWPfEpM7snHmk/UQF6JWadoxtKeY8jbeHrWMGaDYUZ3/3BoRBUyz9ISLkTOxm3
         CvDTZZfMWTyozGa6KRpASW7VrO8gZ9Cmmb5oYc4H3UDUGEG0hJ/jRl1ZBx+hLjPB+N
         yOfzpTI+eZjyw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SjQgW5w7cz4wd7;
        Sun,  3 Dec 2023 10:12:23 +1100 (AEDT)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        npiggin@gmail.com, tpearson@raptorengineering.com, axboe@kernel.dk,
        daniel@mariadb.org
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-6.7-3 tag
Date:   Sun, 03 Dec 2023 10:12:23 +1100
Message-ID: <87jzpw9p2g.fsf@mail.lhotse>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Hi Linus,

Please pull some powerpc fixes for 6.7:

The following changes since commit 98b1cc82c4affc16f5598d4fa14b1858671b2263:

  Linux 6.7-rc2 (2023-11-19 15:02:14 -0800)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.7-3

for you to fetch changes up to dc158d23b33df9033bcc8e7117e8591dd2f9d125:

  KVM: PPC: Book3S HV: Fix KVM_RUN clobbering FP/VEC user registers (2023-11-29 22:24:21 +1100)

- ------------------------------------------------------------------
powerpc fixes for 6.7 #3

 -  Fix corruption of f0/vs0 during FP/Vector save, seen as userspace crashes
    when using io-uring workers (in particular with MariaDB).

 -  Fix KVM_RUN potentially clobbering all host userspace FP/Vector registers.

Thanks to: Timothy Pearson, Jens Axboe, Nicholas Piggin.

- ------------------------------------------------------------------
Nicholas Piggin (1):
      KVM: PPC: Book3S HV: Fix KVM_RUN clobbering FP/VEC user registers

Timothy Pearson (1):
      powerpc: Don't clobber f0/vs0 during fp|altivec register save


 arch/powerpc/kernel/fpu.S     | 13 +++++++++++++
 arch/powerpc/kernel/process.c |  6 +++---
 arch/powerpc/kernel/vector.S  |  2 ++
 3 files changed, 18 insertions(+), 3 deletions(-)
-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJFGtCPCthwEv2Y/bUevqPMjhpYAFAmVruPoACgkQUevqPMjh
pYBdlg//cW9CHahWFix93X5k3b+5LluRynR63BN4FnY+qVni95ihTxRC56rRpmUE
JfbgADz3fFgPdX4/XXnpkrMY7rDyrwTelNT1X5Dl6nwounrqBRvCvplfHrlAPZqR
C12ZBgbdJJmLucAtZv0mXsJ1NMiay9QZK7qIS7xJ22F7nEmnb5/BWs908hH6IwP0
pPOoi0AwiLqtsi6caIXr4GV1qoUbhfNOihZdXObCKetaOpEdcHUfu/vcNOhsVfgS
f8NbyOKZ+dLasCB5ifa5gVw7MQfj++ljLive5C2t51Y1v2I1C3KRhQdoZmTFvWZD
CXxRdCVfgrG5KWGXflG43pypYhmPcJSplDrP2Rg7EGFdasgl7Duc5VGh1l40p84k
Via0iNCJBzL+j6heq47a4TA+oJRAK1HtPjd+ZrP4Rx3sxlIR9IiKAO3i2s8i3Djh
nbK+BAxDBRlmE1+xOeplOsW5ZfjUVjv+mXHycGIGU//RGD8xOaX90USu1uBq2xbQ
UKEpAMwrgpuZpCj/+nWaaEj/SuorkfyZeSoIce3l70LpBZTEJFT5cNNexFW63q2p
QWcnnOxm3flS9tU+GOd/lFjAfV4AJSRKiagUk3JrIjGezl4HyXj6NXulZIIKvgVD
zzDTDEL4trP/Eh8x9JEAKs0qmoMHoqe0hBCsnKS9qSoBoUZQvkI=
=d6c4
-----END PGP SIGNATURE-----
