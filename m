Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE0DD774832
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 21:28:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236202AbjHHT21 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 15:28:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231880AbjHHT2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 15:28:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBE205F868;
        Tue,  8 Aug 2023 11:54:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 42C1362A1E;
        Tue,  8 Aug 2023 18:54:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50B1CC433C7;
        Tue,  8 Aug 2023 18:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691520866;
        bh=wSfB+zwUb2FmgHmNF0uWcGJQhUWa7SwhK3gVe15fv3I=;
        h=From:To:Cc:Subject:Date:From;
        b=aEkmMXKWBfIEAJCHwdA0MWDTz75AN/y68+bTxfGOrRJ0ZvG049vLliUjbAi6dOg05
         t+HFQRDmjDqvGHuNhQrNONiEtforuLDT0PNjO8tfF1z7AW3U5wn99+QGDQEs1mujK+
         UYtK9mI3BgId9n4xx+SODiGdAWwP787eeSyiF8YE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 4.14.321
Date:   Tue,  8 Aug 2023 20:54:21 +0200
Message-ID: <2023080807-joylessly-upchuck-b4fe@gregkh>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-----------------
Note, PLEASE TEST this kernel if you are on the 4.14.y tree before using
it in a real workload.  This was a quick release due to the obvious
security fixes in it, and as such, it has not had very much testing "in
the wild".  Please let us know of any problems seen.  Also note that the
user/kernel api for the new security mitigations might be changing over
time, so do not get used to them being fixed in stone just yet.
-----------------

I'm announcing the release of the 4.14.321 kernel.

All users of the 4.14 kernel series must upgrade.

The updated 4.14.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-4.14.y
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
 arch/powerpc/include/asm/bugs.h                            |   18 -
 arch/sh/Kconfig                                            |    1 
 arch/sh/include/asm/bugs.h                                 |   78 ----
 arch/sh/include/asm/processor.h                            |    2 
 arch/sh/kernel/idle.c                                      |    1 
 arch/sh/kernel/setup.c                                     |   55 +++
 arch/sparc/Kconfig                                         |    1 
 arch/sparc/include/asm/bugs.h                              |   18 -
 arch/sparc/kernel/setup_32.c                               |    7 
 arch/um/Kconfig.common                                     |    1 
 arch/um/include/asm/bugs.h                                 |    7 
 arch/um/kernel/um_arch.c                                   |    3 
 arch/x86/Kconfig                                           |   20 +
 arch/x86/include/asm/bugs.h                                |    2 
 arch/x86/include/asm/cpufeatures.h                         |    1 
 arch/x86/include/asm/fpu/internal.h                        |    2 
 arch/x86/include/asm/mem_encrypt.h                         |    2 
 arch/x86/include/asm/msr-index.h                           |   11 
 arch/x86/kernel/cpu/bugs.c                                 |  209 +++++++++----
 arch/x86/kernel/cpu/common.c                               |  117 ++++++-
 arch/x86/kernel/cpu/cpu.h                                  |    2 
 arch/x86/kernel/fpu/init.c                                 |    8 
 arch/x86/kernel/smpboot.c                                  |    1 
 arch/x86/kvm/x86.c                                         |    5 
 arch/x86/xen/smp_pv.c                                      |    2 
 arch/xtensa/include/asm/bugs.h                             |   18 -
 drivers/base/cpu.c                                         |    8 
 drivers/net/xen-netback/netback.c                          |   15 
 include/asm-generic/bugs.h                                 |   11 
 include/linux/cpu.h                                        |    6 
 init/main.c                                                |   15 
 51 files changed, 579 insertions(+), 361 deletions(-)

Daniel Sneddon (4):
      x86/speculation: Add Gather Data Sampling mitigation
      x86/speculation: Add force option to GDS mitigation
      x86/speculation: Add Kconfig option for GDS
      KVM: Add GDS_NO support to KVM

Dave Hansen (1):
      Documentation/x86: Fix backwards on/off logic about YMM support

Greg Kroah-Hartman (2):
      x86: fix backwards merge of GDS/SRSO bit
      Linux 4.14.321

Juergen Gross (1):
      x86/xen: Fix secondary processors' FPU initialization

Ross Lagerwall (1):
      xen/netback: Fix buffer overrun triggered by unusual packet

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

