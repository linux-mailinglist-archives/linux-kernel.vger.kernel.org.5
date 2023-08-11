Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BA07779215
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 16:42:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235018AbjHKOmq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 10:42:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235401AbjHKOmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 10:42:43 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEE3830C4;
        Fri, 11 Aug 2023 07:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1691764953; x=1692369753; i=deller@gmx.de;
 bh=mJziApYjz/mBqsECS0Xxjk3AvB6tiMP/YX9716jRGoU=;
 h=X-UI-Sender-Class:Date:From:To:Subject;
 b=CqGNIPJ7S3NtlWcZ9bUDJiJvF8OSXSM39Lme1Ga3MIiwetZckhZsV6OkD2rBPSnojCQY6xv
 cXvURVeNWdX4sPeqJhLEubvonu43Fhn8denVOcy+f5NdzdPe0bgIIda94BLnr93IyHVRpE6v1
 X+doFuUfXWMBVZdIOSBSJ1q3vEpc1PA1e8nQvEWfwbNXOTwme9Zlpc6HIUJZF/dlLGhbt1DCt
 EkryfNf9hT57QmddpjDW8HMA434q5gbRdbOcYp+va3nY1WX1thmcYtfvjMwyNbmdsCc2uwGOL
 NAgLJXsaBmt/ib101aygXqDSuJ0Oq/GEt1BpDigj9ANqvhki1TzA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from p100 ([94.134.154.87]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MCbEf-1qd2CZ41Lf-009e9T; Fri, 11
 Aug 2023 16:42:33 +0200
Date:   Fri, 11 Aug 2023 16:42:30 +0200
From:   Helge Deller <deller@gmx.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>
Subject: [GIT PULL] parisc architecture fixes for v6.5-rc6
Message-ID: <ZNZI1sVFrK97d/gW@p100>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Provags-ID: V03:K1:oqF8AGJA0qjsGTCHbTZ1BbelXWIr7SH96YUauZxWtjAKErUVwy3
 O81YP+bXN4pbISg5gtxzDMnXyDOUD1jr197REJRldR4iDzrpqIPC6Tr1aivR0VUT3j/PxVB
 68283J4lRAAztyHQd2jSpn083E+3Vr+Zmi9/ccoIa+QBwmUy4AR2ef8Rg5Gj0lK1/a9hhrK
 5d44nPeOwK1DvXYL175FA==
UI-OutboundReport: notjunk:1;M01:P0:p8s8H2ayjWw=;9IDHw3glQjZjOPimTve23e00zzj
 1oJzoGllOmi7lEPtE2QUFPHgS+yIx/bijI7Xkzp4FRBrdDzTB6BAqI0PsPYTPwZjgRdkNshlA
 3yolyQkRQf9RXJmGthE7cVt7NGRQLOMVsl5CSq/njJgIXvoeXT1cGq/0lSebn4rJiYoTnrnse
 TCJq80DtgcNAkDtYE76P6Qkec8fZ+hridod0haiw2PbvlRPHeA7eNZk6ybCdi9KvlvOhhhyyp
 KwbaoGz+VIvOcHqJ+Z1XFVfGvIFJQprmhZDe2ttZ8botUvUD8o75Id/1VEs95GGUNhjWrSSEc
 OqGlyajEo8LqosOwVHAcMsYaljiSsEyWvlQ5lvXcici/KwfLsP0+HSR2Rf6z7y0hvFrIG1jUf
 K3IvYDGCIAeL2ZXyQ4vSNXDtjJBOsGPC8ljm67YHvzxLe/5cEgOLGQ5qXAmkji0LhfYE5zhLV
 2a0vMMJusHxawyDuBU2tNIB4BZt6cH7FBeeY9na8+LpQ6kIL8loh5qfbyom6qRglByujuCLQS
 QCQdz3KU3H9jFbp5KhkHEUABk+ebuy35sMESqxp5NHmINNeS2gLejmhzxC3RvhAdf1vEXxIcu
 4gXCRyR+xWLcWL9XC/JQv6tOsdyetan9fM+du+wpFxyhzHxGJPVA1Vao/s7ZGpLyRuoAhfW2+
 c461wO/X9FeNpLcwS66bTpYw2CrRnjv2eI1H58uQgveIDARGMhWvSfIYdCwycr1ltDMAQk6dj
 OtJ8DX/D7dcz5g/DcOelBEQi4qk7b04hFwJtugzVy1vuGrIrqviPCjLLY3N3s4YPaoyWeDGeh
 jGxB5Z/w4DHQq7D6KdXFP3I4jgh/hiAe8PIggTW6zSXGEdKK8Gq8kDyY297rA9Qya9S1ELdoe
 ovW9/UxKwZ+49F12v5dohBdlazhFMFMgEsLRucd5gUQqF62L895n94ydogSIYQfXF9UTfQy9o
 Z9MKdeDynhFGqwZJmTZkKwWd9Ug=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull some more fixes for the parisc architecture for kernel 6.5-rc6.

This patchset includes a bugfix in the LWS code, which used different lock words
than the parisc lightweight spinlock checks. This inconsistency triggered
false positives when the lightweight spinlock checks checked the locks of
mutexes.

The other patches are trivial cleanups and most of them fix sparse warnings.

Thanks!
Helge

----------------------------------------------------------------
The following changes since commit a027b2eca0b7e90b11a0b0ddfad0dc4068707799:

  Merge tag 'for-linus' of git://git.kernel.org/pub/scm/virt/kvm/kvm (2023-08-07 10:18:20 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git tags/parisc-for-6.5-rc6

for you to fetch changes up to d863066e6ce0a70c479a7f618088912ac0ba44ac:

  parisc: perf: Make cpu_device variable static (2023-08-10 23:00:18 +0200)

----------------------------------------------------------------
parisc architecture fixes for kernel v6.5-rc6:

- Fix LWS code to use same lock words as for the parisc lightweight
  spinlocks
- Use PTR_ERR_OR_ZERO() in pdt init code
- Fix lots of sparse warnings

----------------------------------------------------------------
Helge Deller (15):
      parisc: Fix lightweight spinlock checks to not break futexes
      parisc: fault: Use C99 arrary initializers
      parisc: ioremap: Fix sparse warnings
      parisc: signal: Fix sparse incorrect type in assignment warning
      parisc: firmware: Fix sparse context imbalance warnings
      parisc: firmware: Mark pdc_result buffers local
      parisc: ucmpdi2: Fix no previous prototype for '__ucmpdi2' warning
      parisc: parisc_ksyms: Include libgcc.h for libgcc prototypes
      parisc: dma: Add prototype for pcxl_dma_start
      parisc: Move proc_mckinley_root and proc_runway_root to sba_iommu
      parisc: unaligned: Include linux/sysctl.h for unaligned_enabled
      parisc: processor: Include asm/smp.h for init_per_cpu()
      parisc: boot: Nuke some sparse warnings in decompressor
      parisc: ftrace: Add declaration for ftrace_function_trampoline()
      parisc: perf: Make cpu_device variable static

Yang Yingliang (1):
      parisc: pdt: Use PTR_ERR_OR_ZERO() to simplify code

 arch/parisc/Kconfig.debug                |  2 +-
 arch/parisc/boot/compressed/misc.c       | 10 +++----
 arch/parisc/include/asm/dma.h            |  2 ++
 arch/parisc/include/asm/ftrace.h         |  4 +++
 arch/parisc/include/asm/spinlock.h       |  2 --
 arch/parisc/include/asm/spinlock_types.h |  6 ++++
 arch/parisc/kernel/firmware.c            |  8 ++---
 arch/parisc/kernel/ftrace.c              |  2 +-
 arch/parisc/kernel/parisc_ksyms.c        |  7 +----
 arch/parisc/kernel/pci-dma.c             |  4 +--
 arch/parisc/kernel/pdt.c                 |  4 +--
 arch/parisc/kernel/perf.c                |  2 +-
 arch/parisc/kernel/processor.c           |  1 +
 arch/parisc/kernel/setup.c               | 48 ------------------------------
 arch/parisc/kernel/signal.c              |  2 +-
 arch/parisc/kernel/syscall.S             | 23 +++++++++++++--
 arch/parisc/kernel/unaligned.c           |  1 +
 arch/parisc/lib/ucmpdi2.c                |  3 +-
 arch/parisc/mm/fault.c                   | 50 ++++++++++++++++----------------
 arch/parisc/mm/init.c                    |  4 ---
 arch/parisc/mm/ioremap.c                 |  9 +++---
 drivers/parisc/sba_iommu.c               |  6 ++++
 22 files changed, 88 insertions(+), 112 deletions(-)
