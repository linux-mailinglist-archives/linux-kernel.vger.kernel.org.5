Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1E477E01E1
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 12:14:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233352AbjKCLG0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 07:06:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233633AbjKCLGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 07:06:22 -0400
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9E59D43
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 04:06:16 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 825ED40E01AA;
        Fri,  3 Nov 2023 11:06:14 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id VH8buNVNuuNc; Fri,  3 Nov 2023 11:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1699009569; bh=Ajb/za1SDuHp6OZFG0tUosl9r/wpClZdPnKsEpUEzwI=;
        h=Date:From:To:Cc:Subject:From;
        b=LDLhMSccaNx9de5JMSmqlAhodlwX9Sf5UYa3zz+kGiBZ/k8HHScI+cywLuWi2+i6L
         SHBaYRa8h4DfNnf0dfEAYu38/rfrBfR6iYWc94F4SKq1AeACfs3ASX4lGVBDgzu2ne
         A8kBr/dcS6URp8dtQqifaL3CIwe+Jm6SJG+p0Dr9EbijDm5dxorqGr2u81oA+wvBun
         Jl4fknb/p4HO1gO2dmA+KrRKRiystbqBv/vRQVrJPBm0ushhgqvus9TQMJ9EDFyMd4
         JZp6UmQR69Tvvez7/ceszaC28cBF0QTJseAHmahXGDLAKEJaww/k9qQknH0xrptX29
         TXLCwIbiYjoDyN9IgHRV3r97JfnT2pLr7lRoDvUyrlXp2AxKwbvXbB6V7S3MAx9Oq8
         dOBZZMj1cMAa1r4xzc2zxvmfz68/KFfFK+XFG73nN73C5cPtihAE7ZrKyri1BqgvzZ
         wj25LwO2L6u2+P31Aqz9qqJIM4xanZuqxos2gBOY6bY77iORsp8LA1Kye2Jy714DW7
         ZF0Y2OJJPaLpEYmOQcgoSvgoi5RKx2gAo6l25kMPWUoyoxSyYaRZeKO0Ca3tOpzRWe
         GSaQ0/Lc7dHcssxV9mSjohYcCTTZfFXI2QsntDWVD5UDEzRjtUW3BdRgXWnlhxq8PO
         bluGlU8saggI8ro3swfn5ahQ=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 197E640E0173;
        Fri,  3 Nov 2023 11:06:06 +0000 (UTC)
Date:   Fri, 3 Nov 2023 12:06:00 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/microcode for 6.7
Message-ID: <20231103110600.GAZUTUGFjhoLm1KZzE@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

I believe this is the last tip branch from the lineup this merge window.
It has a lot of nice things, it has been tested on everything we have
access to so it should be good. There's a trivial merge conflict with
your current tree (8f6f76a6a29f) which I'm pasting at the end of this
mail, just in case.

Please pull,
thx.

---

The following changes since commit 58720809f52779dc0f08e53e54b014209d13eebb:

  Linux 6.6-rc6 (2023-10-15 13:34:39 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86_microcode_for_v6.7_rc1

for you to fetch changes up to cf5ab01c87030a085e211a0a327535932ec6f719:

  x86/microcode/intel: Add a minimum required revision for late loading (2023-10-24 15:05:55 +0200)

----------------------------------------------------------------
Major microcode loader restructuring, cleanup and improvements by Thomas
Gleixner:

- Restructure the code needed for it and add a temporary initrd mapping
  on 32-bit so that the loader can access the microcode blobs. This in
  itself is a preparation for the next major improvement:

- Do not load microcode on 32-bit before paging has been enabled.
  Handling this has caused an endless stream of headaches, issues, ugly
  code and unnecessary hacks in the past. And there really wasn't any
  sensible reason to do that in the first place. So switch the 32-bit
  loading to happen after paging has been enabled and turn the loader
  code "real purrty" again

- Drop mixed microcode steppings loading on Intel - there, a single patch
  loaded on the whole system is sufficient

- Rework late loading to track which CPUs have updated microcode
  successfully and which haven't, act accordingly

- Move late microcode loading on Intel in NMI context in order to
  guarantee concurrent loading on all threads

- Make the late loading CPU-hotplug-safe and have the offlined threads
  be woken up for the purpose of the update

- Add support for a minimum revision which determines whether late
  microcode loading is safe on a machine and the microcode does not
  change software visible features which the machine cannot use anyway
  since feature detection has happened already. Roughly, the minimum
  revision is the smallest revision number which must be loaded
  currently on the system so that late updates can be allowed

- Other nice leanups, fixess, etc all over the place

----------------------------------------------------------------
Ashok Raj (2):
      x86/microcode/intel: Rip out mixed stepping support for Intel CPUs
      x86/microcode/intel: Add a minimum required revision for late loading

Paolo Bonzini (1):
      x86/microcode/amd: Fix snprintf() format string warning in W=1 build

Thomas Gleixner (37):
      x86/boot/32: Disable stackprotector and tracing for mk_early_pgtbl_32()
      x86/boot: Use __pa_nodebug() in mk_early_pgtbl_32()
      x86/boot/32: De-uglify the 2/3 level paging difference in mk_early_pgtbl_32()
      x86/boot/32: Restructure mk_early_pgtbl_32()
      x86/microcode: Provide CONFIG_MICROCODE_INITRD32
      x86/boot/32: Temporarily map initrd for microcode loading
      x86/microcode/32: Move early loading after paging enable
      x86/microcode/intel: Simplify scan_microcode()
      x86/microcode/intel: Simplify and rename generic_load_microcode()
      x86/microcode/intel: Cleanup code further
      x86/microcode/intel: Simplify early loading
      x86/microcode/intel: Save the microcode only after a successful late-load
      x86/microcode/intel: Switch to kvmalloc()
      x86/microcode/intel: Unify microcode apply() functions
      x86/microcode/intel: Rework intel_cpu_collect_info()
      x86/microcode/intel: Reuse intel_cpu_collect_info()
      x86/microcode/intel: Rework intel_find_matching_signature()
      x86/microcode: Remove pointless apply() invocation
      x86/microcode/amd: Use correct per CPU ucode_cpu_info
      x86/microcode/amd: Cache builtin microcode too
      x86/microcode/amd: Cache builtin/initrd microcode early
      x86/microcode/amd: Use cached microcode for AP load
      x86/microcode: Mop up early loading leftovers
      x86/microcode: Get rid of the schedule work indirection
      x86/microcode: Clean up mc_cpu_down_prep()
      x86/microcode: Handle "nosmt" correctly
      x86/microcode: Clarify the late load logic
      x86/microcode: Sanitize __wait_for_cpus()
      x86/microcode: Add per CPU result state
      x86/microcode: Add per CPU control field
      x86/microcode: Provide new control functions
      x86/microcode: Replace the all-in-one rendevous handler
      x86/microcode: Rendezvous and load in NMI
      x86/microcode: Protect against instrumentation
      x86/apic: Provide apic_force_nmi_on_cpu()
      x86/microcode: Handle "offline" CPUs correctly
      x86/microcode: Prepare for minimal revision check

 Documentation/admin-guide/kernel-parameters.txt |   5 +
 arch/x86/Kconfig                                |  29 +-
 arch/x86/include/asm/apic.h                     |   5 +-
 arch/x86/include/asm/cpu.h                      |  20 +-
 arch/x86/include/asm/microcode.h                |  21 +-
 arch/x86/include/asm/setup.h                    |   1 +
 arch/x86/kernel/Makefile                        |   1 +
 arch/x86/kernel/apic/apic_flat_64.c             |   2 +
 arch/x86/kernel/apic/ipi.c                      |   8 +
 arch/x86/kernel/apic/x2apic_cluster.c           |   1 +
 arch/x86/kernel/apic/x2apic_phys.c              |   1 +
 arch/x86/kernel/cpu/common.c                    |  12 -
 arch/x86/kernel/cpu/microcode/amd.c             | 157 +++---
 arch/x86/kernel/cpu/microcode/core.c            | 670 ++++++++++++++---------
 arch/x86/kernel/cpu/microcode/intel.c           | 688 ++++++++----------------
 arch/x86/kernel/cpu/microcode/internal.h        |  35 +-
 arch/x86/kernel/head32.c                        | 120 +++--
 arch/x86/kernel/head_32.S                       |  10 -
 arch/x86/kernel/nmi.c                           |   9 +-
 arch/x86/kernel/smpboot.c                       |  12 +-
 drivers/platform/x86/intel/ifs/load.c           |   8 +-
 21 files changed, 905 insertions(+), 910 deletions(-)

---

merge conflict resolve:

diff --cc arch/x86/include/asm/apic.h
index b0d192f613b7,17f2f28a495e..d21f48f1c242
--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@@ -528,12 -539,15 +529,14 @@@ extern int default_apic_id_valid(u32 ap
  extern u32 apic_default_calc_apicid(unsigned int cpu);
  extern u32 apic_flat_calc_apicid(unsigned int cpu);
  
 -extern bool default_check_apicid_used(physid_mask_t *map, int apicid);
  extern void default_ioapic_phys_id_map(physid_mask_t *phys_map, physid_mask_t *retmap);
 -extern int default_cpu_present_to_apicid(int mps_cpu);
 +extern u32 default_cpu_present_to_apicid(int mps_cpu);
  
+ void apic_send_nmi_to_offline_cpu(unsigned int cpu);
+ 
  #else /* CONFIG_X86_LOCAL_APIC */
  
 -static inline unsigned int read_apic_id(void) { return 0; }
 +static inline u32 read_apic_id(void) { return 0; }
  
  #endif /* !CONFIG_X86_LOCAL_APIC */
  

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
