Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4976077483D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 21:29:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236073AbjHHT3I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 15:29:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236188AbjHHT2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 15:28:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACC79634A8;
        Tue,  8 Aug 2023 11:55:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 350FE62A68;
        Tue,  8 Aug 2023 18:55:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4496DC433C7;
        Tue,  8 Aug 2023 18:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691520937;
        bh=liubOIEuM67wflnh1UEyOjyHuX6eBRu5ICtNTZcnfic=;
        h=From:To:Cc:Subject:Date:From;
        b=ISH0wNGiM1i3RUQerD9FM2sf2xVqednK8wvwJdMDlOuj5P10dMmmA8VkgSeVVKynV
         AXLW7ZFi+k+1MktXWdMWz90Gks8yx+xAp91ch3HnCFPJBr+D7BvqydWjHzkG1CuhAh
         BO0kXYh2mFAVoy4rFr+Jj+3S2+41z1Aspp5cXc+g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.4.252
Date:   Tue,  8 Aug 2023 20:55:33 +0200
Message-ID: <2023080814-relax-divisible-dea4@gregkh>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-----------------
Note, PLEASE TEST this kernel if you are on the 5.4.y tree before using
it in a real workload.  This was a quick release due to the obvious
security fixes in it, and as such, it has not had very much testing "in
the wild".  Please let us know of any problems seen.  Also note that the
user/kernel api for the new security mitigations might be changing over
time, so do not get used to them being fixed in stone just yet.
-----------------

I'm announcing the release of the 5.4.252 kernel.

All users of the 5.4 kernel series must upgrade.

The updated 5.4.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.4.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/ABI/testing/sysfs-devices-system-cpu         |   11 
 Documentation/admin-guide/hw-vuln/gather_data_sampling.rst |  109 ++++++
 Documentation/admin-guide/hw-vuln/index.rst                |    1 
 Documentation/admin-guide/kernel-parameters.txt            |   39 +-
 Makefile                                                   |    2 
 arch/Kconfig                                               |    3 
 arch/alpha/include/asm/bugs.h                              |   20 -
 arch/arm/Kconfig                                           |    1 
 arch/arm/include/asm/bugs.h                                |    4 
 arch/arm/kernel/bugs.c                                     |    3 
 arch/ia64/Kconfig                                          |    1 
 arch/ia64/include/asm/bugs.h                               |   20 -
 arch/ia64/kernel/setup.c                                   |    3 
 arch/m68k/Kconfig                                          |    1 
 arch/m68k/include/asm/bugs.h                               |   21 -
 arch/m68k/kernel/setup_mm.c                                |    3 
 arch/mips/Kconfig                                          |    1 
 arch/mips/include/asm/bugs.h                               |   17 -
 arch/mips/kernel/setup.c                                   |   13 
 arch/parisc/include/asm/bugs.h                             |   20 -
 arch/powerpc/include/asm/bugs.h                            |   15 
 arch/sh/Kconfig                                            |    1 
 arch/sh/include/asm/bugs.h                                 |   78 ----
 arch/sh/include/asm/processor.h                            |    2 
 arch/sh/kernel/idle.c                                      |    1 
 arch/sh/kernel/setup.c                                     |   55 +++
 arch/sparc/Kconfig                                         |    1 
 arch/sparc/include/asm/bugs.h                              |   18 -
 arch/sparc/kernel/setup_32.c                               |    7 
 arch/um/Kconfig                                            |    1 
 arch/um/include/asm/bugs.h                                 |    7 
 arch/um/kernel/um_arch.c                                   |    3 
 arch/x86/Kconfig                                           |   20 +
 arch/x86/include/asm/bugs.h                                |    2 
 arch/x86/include/asm/cpufeature.h                          |   10 
 arch/x86/include/asm/cpufeatures.h                         |   18 -
 arch/x86/include/asm/disabled-features.h                   |    4 
 arch/x86/include/asm/fpu/internal.h                        |    2 
 arch/x86/include/asm/mem_encrypt.h                         |    2 
 arch/x86/include/asm/msr-index.h                           |   12 
 arch/x86/include/asm/required-features.h                   |    4 
 arch/x86/kernel/cpu/amd.c                                  |    3 
 arch/x86/kernel/cpu/bugs.c                                 |  209 +++++++++----
 arch/x86/kernel/cpu/common.c                               |  122 ++++++-
 arch/x86/kernel/cpu/cpu.h                                  |    2 
 arch/x86/kernel/cpu/scattered.c                            |    3 
 arch/x86/kernel/fpu/init.c                                 |    8 
 arch/x86/kernel/smpboot.c                                  |    1 
 arch/x86/kvm/cpuid.h                                       |    1 
 arch/x86/kvm/x86.c                                         |    5 
 arch/x86/mm/init.c                                         |    7 
 arch/x86/xen/smp_pv.c                                      |    2 
 arch/xtensa/include/asm/bugs.h                             |   18 -
 drivers/base/cpu.c                                         |    8 
 drivers/net/xen-netback/netback.c                          |   15 
 include/asm-generic/bugs.h                                 |   11 
 include/linux/cpu.h                                        |    6 
 include/linux/sched/task.h                                 |    2 
 init/main.c                                                |   21 -
 kernel/fork.c                                              |   37 +-
 tools/arch/x86/include/asm/cpufeatures.h                   |   18 -
 tools/arch/x86/include/asm/disabled-features.h             |    3 
 tools/arch/x86/include/asm/required-features.h             |    3 
 63 files changed, 659 insertions(+), 402 deletions(-)

Arnaldo Carvalho de Melo (1):
      tools headers cpufeatures: Sync with the kernel sources

Borislav Petkov (AMD) (1):
      x86/bugs: Increase the x86 bugs vector size to two u32s

Daniel Sneddon (4):
      x86/speculation: Add Gather Data Sampling mitigation
      x86/speculation: Add force option to GDS mitigation
      x86/speculation: Add Kconfig option for GDS
      KVM: Add GDS_NO support to KVM

Dave Hansen (1):
      Documentation/x86: Fix backwards on/off logic about YMM support

Greg Kroah-Hartman (2):
      x86: fix backwards merge of GDS/SRSO bit
      Linux 5.4.252

Juergen Gross (2):
      x86/xen: Fix secondary processors' FPU initialization
      x86/mm: fix poking_init() for Xen PV guests

Kim Phillips (1):
      x86/cpu, kvm: Add support for CPUID_80000021_EAX

Peter Zijlstra (3):
      x86/mm: Use mm_alloc() in poking_init()
      mm: Move mm_cachep initialization to mm_init()
      x86/mm: Initialize text poking earlier

Ross Lagerwall (1):
      xen/netback: Fix buffer overrun triggered by unusual packet

Sean Christopherson (1):
      x86/cpufeatures: Assign dedicated feature word for CPUID_0x8000001F[EAX]

Thomas Gleixner (15):
      init: Provide arch_cpu_finalize_init()
      x86/cpu: Switch to arch_cpu_finalize_init()
      ARM: cpu: Switch to arch_cpu_finalize_init()
      ia64/cpu: Switch to arch_cpu_finalize_init()
      m68k/cpu: Switch to arch_cpu_finalize_init()
      mips/cpu: Switch to arch_cpu_finalize_init()
      sh/cpu: Switch to arch_cpu_finalize_init()
      sparc/cpu: Switch to arch_cpu_finalize_init()
      um/cpu: Switch to arch_cpu_finalize_init()
      init: Remove check_bugs() leftovers
      init: Invoke arch_cpu_finalize_init() earlier
      init, x86: Move mem_encrypt_init() into arch_cpu_finalize_init()
      x86/fpu: Remove cpuinfo argument from init functions
      x86/fpu: Mark init functions __init
      x86/fpu: Move FPU initialization into arch_cpu_finalize_init()

Tom Lendacky (2):
      x86/cpufeatures: Add SEV-ES CPU feature
      x86/cpu: Add VM page flush MSR availablility as a CPUID feature

