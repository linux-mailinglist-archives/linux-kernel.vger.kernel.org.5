Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 824FD7A2207
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 17:12:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235900AbjIOPMh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 11:12:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235898AbjIOPMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 11:12:31 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2D1D10D
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 08:12:26 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1c35ee3b0d2so17919135ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 08:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1694790746; x=1695395546; darn=vger.kernel.org;
        h=message-id:to:from:cc:subject:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TvdZikewOGbtBJy4jV7eLfxgLdyicvd893nAAhG6Kr4=;
        b=knUamhVjE7b0RJQe4eonkmxGe01QHEGforGkH9r6xQIsc5Od/eDRh1IswBzXkRqcDj
         oG+lxIKO25rG7uS+zceIWrzNxElVn+E4zIGZI0nR2MJXq0JX8Ldc0biZOjvOQmjxKVHL
         EXStm4Wwm2uLzxGZ6QQ7kNdeKPdD3rn20DIzCcdlrKnHjv9RdP1pAzPsGrocNUumemRh
         ZpHDwSvP5ximQ1BZdRmSB/M/bU18LEmXqHyHkN6+tTGSqMUOPewNEmIdA/napexymMVa
         xvQceDLlQnbrl19GSBzH0Tit/JBM4LfnjCzlEADgt8ljcFwoFuttkKNt1pyk4AZiKnY9
         ZHQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694790746; x=1695395546;
        h=message-id:to:from:cc:subject:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TvdZikewOGbtBJy4jV7eLfxgLdyicvd893nAAhG6Kr4=;
        b=wKS+OZwj/iqEi5Rvqld5IG2TUQ1nRp79dKuhqXHmkdirY0lW+LdVoPjqPD318fXT9+
         wFDVixL/5rupQQnpvzDZT3O9MnNvltADuXmYU4hqbwbmcvBSkVg0kKdHwQnCkAba41yE
         6R0WgIQ0atRwyjJt9x1TjjXqJlcSqMBNReHIEQQDstWjsK9XKm7BVLRqDsMHtZyRVTyD
         DNYEdePHjW/KduzABBSl350elJQNjuJ0II7rY6ajpElTE4CCXP5ms5UrhNNS/bWkKYA7
         xT6iWwD6GVBBblGdBARQ9R+1PWCY6KdYy8dBqYNj7zJKQQaqtANAOafTaV8+fj0JvRIM
         946Q==
X-Gm-Message-State: AOJu0YzcGMkeGhh/IKJFAJWtTy2Xy29FFFiwFZPGRelpKkzpZhiNkxTI
        E43hWC2SRM1ic/8CtdJvHOn9AmM9OCw6yAv3MqU=
X-Google-Smtp-Source: AGHT+IEgHQ3UNAjBW7KxV/WQLG8LILuRF6I7lSNAITcN9JQHLMiivMx8BGW0JezRPOZ6qFEwYnU70A==
X-Received: by 2002:a17:902:6806:b0:1c3:7628:fcb5 with SMTP id h6-20020a170902680600b001c37628fcb5mr1873527plk.62.1694790745936;
        Fri, 15 Sep 2023 08:12:25 -0700 (PDT)
Received: from localhost ([135.180.227.0])
        by smtp.gmail.com with ESMTPSA id a5-20020a1709027d8500b001b896686c78sm3595063plm.66.2023.09.15.08.12.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 08:12:25 -0700 (PDT)
Date:   Fri, 15 Sep 2023 08:12:25 -0700 (PDT)
X-Google-Original-Date: Fri, 15 Sep 2023 08:12:22 PDT (-0700)
Subject: [GIT PULL] RISC-V Fixes for 6.6-rc2
CC:         linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <mhng-28c66ddb-6068-4bcc-a1be-28c830775838@palmer-ri-x1c9>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 0bb80ecc33a8fb5a682236443c1e740d5c917d1d:

  Linux 6.6-rc1 (2023-09-10 16:28:41 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.6-rc2

for you to fetch changes up to 8eb8fe67e2c84324398f5983c41b4f831d0705b3:

  riscv: errata: fix T-Head dcache.cva encoding (2023-09-12 13:58:40 -0700)

----------------------------------------------------------------
RISC-V Fixes for 6.6-rc2

* A fix to align kexec'd kernels to PMD boundries.
* The T-Head dcache.cva encoding was incorrect, it has been fixed to
  invalidate all caches (as opposed to just the L1).

----------------------------------------------------------------
Icenowy Zheng (1):
      riscv: errata: fix T-Head dcache.cva encoding

Song Shuai (1):
      riscv: kexec: Align the kexeced kernel entry

 arch/riscv/include/asm/errata_list.h | 4 ++--
 arch/riscv/kernel/elf_kexec.c        | 8 +++++++-
 2 files changed, 9 insertions(+), 3 deletions(-)
