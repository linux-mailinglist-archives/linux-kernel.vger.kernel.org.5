Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C89F47A2476
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 19:17:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235647AbjIORR2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 13:17:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235386AbjIORRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 13:17:02 -0400
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA4C583
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 10:16:56 -0700 (PDT)
Received: by mail-wm1-x349.google.com with SMTP id 5b1f17b1804b1-4043bc7c6c3so16848625e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 10:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694798215; x=1695403015; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Yhhwla0q64mfAEvxb+65DeZKNsI9N7tlzgRLGYw6MMQ=;
        b=DSZB+5Ma9OY/BtxdTkrSpkeXHnatd3Db+QYRs8g42XVydIbnVYYuRP1tTZ9U18B9cE
         KOL9rCUj4epM52ateuMhYWj7E+1FO5Wg3ronVw5/haJLc32/lsj9XLvnT9bi75+IxdmM
         WjiQk0+yDzw8vnziSwiJzfSB3qdweF0IF6taCJt3nhCaKmbD9e5LSTzLo4BdVHziRR+l
         9flEfCZ6iVGVUoy0RFkUNcbCJQCrTc+XZhtOgjL4UnK3Cyy3MnFmhXyMs7nMNcBelf/B
         HYQOelv/qF1rrTw35mZ3KN6kX4rSJ4SDQiViH3kCBaPJoNINC67WVbHL6MmN/tWx623U
         xJLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694798215; x=1695403015;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Yhhwla0q64mfAEvxb+65DeZKNsI9N7tlzgRLGYw6MMQ=;
        b=VGmCCrKlkRDpnOiHCZu4I1ooUrScTBdVrHqia6QHy6x87OPk5Q3raaDgvOcxPdwFsG
         c2zvrOTJDmHsJ78zc1XLlS0XP9Gj4U472Qlskv4Bh+JTL+B1oQXm0b6q4zZpA4gCzm5y
         pR3xNM8VkJ4t9lWGA9yKV8z4H1ovjnkWuoxiI7OtWkE0pcNpXui+Yo7vvtgb1RdxcYsK
         oTe05yciJvZbvThwZMkBVVtxFFuSLk0/HuTXk7lzMnQb13EgYZGlghh85iKRZO2DaJUZ
         OB24ahDwyhQFircjo/mHMDrQBOEVgOyVEYENaE6CRR9QAVV+dveu9WZVEDQTuBCYq58D
         THBQ==
X-Gm-Message-State: AOJu0YzNhZMe4dFlfDPBnAga+3NDt9RDuuhzjLUFTn/ZN6VGEid5GdgS
        ZOELWoyLqJLIQ+83XaCmwulCCnDw
X-Google-Smtp-Source: AGHT+IGOKZB3etJWSf3a4ggnUZAWd/NfGW/XWhm68UG564TCgWUah4IfQRybpm4jrxvkFEPjuE22hqDP
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:600c:219a:b0:402:f52f:10bc with SMTP id
 e26-20020a05600c219a00b00402f52f10bcmr41340wme.4.1694798215386; Fri, 15 Sep
 2023 10:16:55 -0700 (PDT)
Date:   Fri, 15 Sep 2023 17:16:24 +0000
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=3354; i=ardb@kernel.org;
 h=from:subject; bh=EtVAkpkv5PV6KFRb2SeP4yuLjjWAyfwe/VX5jt4+kBo=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIZVlYnp+9qcExUmGP5ZvD/DSVn521DNiwf+rfxQlohZGh
 qu+tJvaUcrCIMbBICumyCIw+++7nacnStU6z5KFmcPKBDKEgYtTACayxZzhr+SR3RpTkn8F5318
 qLA5y6Pc2GRy+7s5z85dSZ3Is/BY7QJGhud7lz73XlURWqOUvjRPpdxiI6e/7Knc7rqnivJV54N FmQE=
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
Message-ID: <20230915171623.655440-10-ardb@google.com>
Subject: [PATCH v3 0/8] x86/boot: Rework PE header generation
From:   Ard Biesheuvel <ardb@google.com>
To:     linux-efi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Evgeniy Baskov <baskov@ispras.ru>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Jones <pjones@redhat.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ard Biesheuvel <ardb@kernel.org>

Now that the EFI stub boot flow no longer relies on memory that is
executable and writable at the same time, we can reorganize the PE/COFF
view of the kernel image and expose the decompressor binary's code and
r/o data as a .text section and data/bss as a .data section, using 4k
alignment and limited permissions.

Doing so is necessary for compatibility with hardening measures that are
being rolled out on x86 PCs built to run Windows (i.e., the majority of
them). The EFI boot environment that the Linux EFI stub executes in is
especially sensitive to safety issues, given that a vulnerability in the
loader of one OS can be abused to attack another.

In true x86 fashion, this is a lot more complicated than on other
architectures, which have implemented this code/data split with 4k
alignment from the beginning. The complicating factor here is that the
boot image consists of two different parts, which are stitched together
and fixed up using a special build tool.

After this series is applied, the only remaining task performed by the
build tool is generating the CRC-32. Even though this checksum is
usually wrong (given that distro kernels are signed for secure boot in a
way that corrupts the CRC), this feature is retained as we cannot be
sure that nobody is relying on this.

This supersedes the work proposed by Evgeniy last year, which did a
major rewrite of the build tool in order to clean it up, before updating
it to generate the new 4k aligned image layout. As this series proves,
the build tool is mostly unnecessary, and we have too many of those
already.

Changes since v2:
- rebase onto tip/master
- drop patches that have been picked up already
- fix issue in the linker script that resulted in a bogus setup_size in
  some cases when using ld.bfd
- fix comment capitalization

Changes since v1:
- drop patch that removed the CRC and the build tool
- do not use fixed setup_size but derive it in the setup.ld linker
  script
- reorganize the PE header so the .compat section only covers its
  payload and the padding that follows it
- add hpa's ack to patch #4

Cc: Evgeniy Baskov <baskov@ispras.ru>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Jones <pjones@redhat.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>


Ard Biesheuvel (8):
  x86/boot: Grab kernel_info offset from zoffset header directly
  x86/boot: Set EFI handover offset directly in header asm
  x86/boot: Define setup size in linker script
  x86/boot: Derive file size from _edata symbol
  x86/boot: Construct PE/COFF .text section from assembler
  x86/boot: Drop PE/COFF .reloc section
  x86/boot: Split off PE/COFF .data section
  x86/boot: Increase section and file alignment to 4k/512

 arch/x86/boot/Makefile                 |   2 +-
 arch/x86/boot/compressed/vmlinux.lds.S |   5 +-
 arch/x86/boot/header.S                 | 146 +++++++------
 arch/x86/boot/setup.ld                 |   7 +-
 arch/x86/boot/tools/build.c            | 223 +-------------------
 5 files changed, 97 insertions(+), 286 deletions(-)

-- 
2.42.0.459.ge4e396fd5e-goog

