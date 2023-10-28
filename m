Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3166E7DA768
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 15:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbjJ1NzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Oct 2023 09:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjJ1NzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Oct 2023 09:55:12 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F7A593
        for <linux-kernel@vger.kernel.org>; Sat, 28 Oct 2023 06:55:09 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-509109104e2so440907e87.3
        for <linux-kernel@vger.kernel.org>; Sat, 28 Oct 2023 06:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698501307; x=1699106107; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=13B4rWNHywHRgMR1Bza+TmHKe1mS1JOxZEq7LGiAlh4=;
        b=k61sdXgeir+tpNPDs7GCR1EYlYcU6MCAOinh4K0Icog3K47dDnu5fMcMYQvHtRx41G
         fx8kpeieUWSvTYegmIxDS/O5s1jA2ypcNwD5kfVOP9Dn3GiGklk2iOiaH3a0L1jEzPJx
         jaG3/JdEgbZImED9CK/E5Gt8CaaKRgBvoHvzz2A4Gv+fwWlKnHa1AgMTzzCsVS2V+nLb
         zzIJAiYx7UK44+LM9Q57W2Y66iS2qChQmrLSY3PxhoLDAYJ7q7c//ZD+q3tvJ0/RaSJi
         lkAy1hjQQddY3KynMHNiRd/z/PmrMZZQ9CC1B1RVOE62wcvlL9X+Cl7zaQdKTHkkwyna
         xoNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698501307; x=1699106107;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=13B4rWNHywHRgMR1Bza+TmHKe1mS1JOxZEq7LGiAlh4=;
        b=hrGSFC8neKkJT/N7bEEUl8NzeG2PjavH/9fIqHxLX6i+xbrWSRlRewEaQqiuVpNtpe
         vq2uoj4Mi9+MZIoIVb3C/KAD6E/ixEcn/XvkjsW8+t35GvOPZtobu0wm3InHfTdm7hhc
         kI8M4V64OKL6j46nwOIFekoSFDzJVcIW6Y+OOMhU2mPExqdll5gNQ0F1ynotwgZJL+zL
         pMTFBKgQORq7JShRbWFO79XNR8Cadoqcz9+WVX2H/kJMPBU0m/TKpbbPBTZZhM2ID+2T
         by9izrp2pA3Q9r/dePoWoWsP4B7SGVwqG/0/SfV3I3K/EJjhrLoK+R663YS96sAMy4ko
         q80A==
X-Gm-Message-State: AOJu0YxhnoLVCkN9+qGNlU0017M6HcFafjCu4h0pzOfBaDSRPn2tMQLs
        V3oXjMWKgenfER3XArdtRU0=
X-Google-Smtp-Source: AGHT+IHOpRcrvaAeONNReYdl5SEg4qntDuqfyY1rRfqTza9u39llM4DWSWe0dfrHfR3l/lzP1xtNew==
X-Received: by 2002:a05:6512:14c:b0:506:8b22:bac2 with SMTP id m12-20020a056512014c00b005068b22bac2mr3873234lfo.4.1698501306818;
        Sat, 28 Oct 2023 06:55:06 -0700 (PDT)
Received: from gmail.com (1F2EF1E7.nat.pool.telekom.hu. [31.46.241.231])
        by smtp.gmail.com with ESMTPSA id o15-20020a1709062e8f00b009c70b392051sm2816621eji.100.2023.10.28.06.55.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Oct 2023 06:55:06 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Sat, 28 Oct 2023 15:55:04 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [GIT PULL] x86/mm changes for v6.7
Message-ID: <ZT0SuFRzTlb0Q769@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86/mm git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-mm-2023-10-28

   # HEAD: a1e2b8b36820d8c91275f207e77e91645b7c6836 x86/mm: Drop the 4 MB restriction on minimal NUMA node memory size

x86 MM handling code changes for v6.7:

 - Add new NX-stack self-test
 - Improve NUMA partial-CFMWS handling
 - Fix #VC handler bugs resulting in SEV-SNP boot failures
 - Drop the 4MB memory size restriction on minimal NUMA nodes
 - Reorganize headers a bit, in preparation to header dependency reduction efforts
 - Misc cleanups & fixes

 Thanks,

	Ingo

------------------>
Adam Dunlap (2):
      x86/sev-es: Allow copy_from_kernel_nofault() in earlier boot
      x86/sev-es: Set x86_virt_bits to the correct value straight away, instead of a two-phase approach

Alexander Shishkin (2):
      x86/sev: Move sev_setup_arch() to mem_encrypt.c
      x86/sev: Drop unneeded #include

Alexey Dobriyan (1):
      selftests/x86/mm: Add new test that userspace stack is in fact NX

Alison Schofield (2):
      x86/numa: Introduce numa_fill_memblks()
      ACPI/NUMA: Apply SRAT proximity domain to entire CFMWS window

Binbin Wu (1):
      selftests/x86/lam: Zero out buffer for readlink()

Dave Hansen (1):
      x86/boot: Move x86_cache_alignment initialization to correct spot

GUO Zihua (1):
      x86/sev: Make boot_ghcb_page[] static

Hugh Dickins (1):
      x86_64: Show CR4.PSE on auxiliaries like on BSP

Ingo Molnar (1):
      x86/mm: Move arch_memory_failure() and arch_is_platform_page() definitions from <asm/processor.h> to <asm/pgtable.h>

Jianlin Li (2):
      x86/sev/docs: Update document URL in amd-memory-encryption.rst
      x86/iommu/docs: Update AMD IOMMU specification document URL

Justin Stitt (1):
      x86/tdx: Replace deprecated strncpy() with strtomem_pad()

Mike Rapoport (IBM) (1):
      x86/mm: Drop the 4 MB restriction on minimal NUMA node memory size


 Documentation/arch/x86/amd-memory-encryption.rst |   2 +-
 Documentation/arch/x86/iommu.rst                 |   2 +-
 arch/x86/boot/compressed/sev.c                   |   2 +-
 arch/x86/coco/tdx/tdx.c                          |   2 +-
 arch/x86/include/asm/mem_encrypt.h               |   4 +-
 arch/x86/include/asm/numa.h                      |   7 -
 arch/x86/include/asm/pgtable.h                   |   8 +
 arch/x86/include/asm/processor.h                 |   8 -
 arch/x86/include/asm/sparsemem.h                 |   2 +
 arch/x86/kernel/cpu/common.c                     |  40 +++--
 arch/x86/kernel/head_64.S                        |   4 +-
 arch/x86/kernel/setup.c                          |   2 +-
 arch/x86/mm/maccess.c                            |  19 +-
 arch/x86/mm/mem_encrypt.c                        |  34 ++++
 arch/x86/mm/mem_encrypt_amd.c                    |  36 ----
 arch/x86/mm/numa.c                               |  87 +++++++++-
 drivers/acpi/numa/srat.c                         |  11 +-
 include/linux/numa.h                             |   7 +
 tools/testing/selftests/x86/Makefile             |   4 +
 tools/testing/selftests/x86/lam.c                |   6 +-
 tools/testing/selftests/x86/nx_stack.c           | 212 +++++++++++++++++++++++
 21 files changed, 404 insertions(+), 95 deletions(-)
 create mode 100644 tools/testing/selftests/x86/nx_stack.c
