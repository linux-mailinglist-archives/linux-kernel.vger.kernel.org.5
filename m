Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 047227B2584
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 20:49:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232119AbjI1Stf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 14:49:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231406AbjI1Std (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 14:49:33 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39014194
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 11:49:32 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1c3d6d88231so100085845ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 11:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695926971; x=1696531771; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rJ1Xm03fGvRdWwUPqQq1Cea3T9DyHrKQnz43Fil7hXc=;
        b=TQbbzG/4ukJaM+4mIoKAlaICg/oiv1Nsr0rq9SzhhEhxwXE+LZ+HRGUUVpf+1pFBOi
         IhZ6fMIo4bZykStOSQVIincDPKBhYXhY1za8Syd868zRb/7/SVMjaI115XnaroIw/lmM
         DFaBeTbaLy41oRjwiyRxEhhN4qE9P0qI1evFlwKeeXkqexOvDlsKsLsYiVSnQImcrxbI
         mBgykFmpw1qkAECZ25lT+qN5n4trvzIyMur9WkXftSeZMHjoSFSE0CEZ6pQxf19upMtI
         Jh3FmV7+wOyqNzekrk2FNj2v9oLYrALmgyNTR11LOAQ7nHM6u2vLUuLtC7MgZihYyNp9
         8OLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695926971; x=1696531771;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rJ1Xm03fGvRdWwUPqQq1Cea3T9DyHrKQnz43Fil7hXc=;
        b=jydLi9HB2cyVq+UYxeCTAf7aAHecfUj99vLUSSrcPGxdCzRzR4xMnOPdr5n8bI24+6
         Zk/xZEZUn87wwIcc5hrJ1C6dItUFjwWrPtGguqIHJxhXij1XrQYDVFkk617UufZ8gFzc
         SMnMFOD8Eoh63kqfeMalTfZ/BmWsVhBR39epkYAJe7cVu/XtWniHS7+iVy3PBJO7MOhT
         jWeaH0k9rNRufkpYeU1po0OeZ3V0CTlieT4Gw3SyJm+AQRsYrSg35m/RrGpp80MaLLjp
         gSzC+jOneqtugWk9HNLYYuM+GX8qDA9vP2k+tl5FdmYsepGOjXEYeF+87ixMg/ifKRuj
         xDhQ==
X-Gm-Message-State: AOJu0Yzx8t2wyd3UABqEneO9/FxFTVn4V9uX7RraXMKj2ZxkaUfxvkIk
        qHIrXp6lmYgIudX/z6XFwoY=
X-Google-Smtp-Source: AGHT+IHQ2bhuPXrdqR5cEgy2tha86qCru/kNFTo9NhZctpV4JHUJEwQ06kGOSLeyjG5Zhdq+GQcwsg==
X-Received: by 2002:a17:903:1109:b0:1b9:e937:9763 with SMTP id n9-20020a170903110900b001b9e9379763mr2259812plh.12.1695926971492;
        Thu, 28 Sep 2023 11:49:31 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net ([2601:646:a201:19d0:a19c:f3d0:698d:f7a])
        by smtp.gmail.com with ESMTPSA id u7-20020a170902b28700b001b9ecee459csm15264713plr.34.2023.09.28.11.49.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 11:49:31 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PULL 00/16] Xtensa fixes for v6.6
Date:   Thu, 28 Sep 2023 11:49:24 -0700
Message-Id: <20230928184924.164748-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_LOCAL_NOVOWEL,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull the following fixes for the Xtensa architecture.

The following changes since commit ce9ecca0238b140b88f43859b211c9fdfd8e5b70:

  Linux 6.6-rc2 (2023-09-17 14:40:24 -0700)

are available in the Git repository at:

  https://github.com/jcmvbkbc/linux-xtensa.git tags/xtensa-20230928

for you to fetch changes up to f54d02c8f2cc4b46ba2a3bd8252a6750453b6f2b:

  xtensa: boot/lib: fix function prototypes (2023-09-20 05:03:30 -0700)

----------------------------------------------------------------
Xtensa fixes for v6.6:

- fix build warnings from builds performed with W=1

----------------------------------------------------------------
Max Filippov (2):
      xtensa: add default definition for XCHAL_HAVE_DIV32
      xtensa: boot/lib: fix function prototypes

Randy Dunlap (14):
      xtensa: fault: include <asm/traps.h>
      xtensa: irq: include <asm/traps.h>
      xtensa: ptrace: add prototypes to <asm/ptrace.h>
      xtensa: processor.h: add init_arch() prototype
      xtensa: signal: include headers for function prototypes
      xtensa: stacktrace: include <asm/ftrace.h> for prototype
      xtensa: traps: add <linux/cpu.h> for function prototype
      irqchip: irq-xtensa-mx: include header for missing prototype
      xtensa: smp: add headers for missing function prototypes
      xtensa: hw_breakpoint: include header for missing prototype
      xtensa: tlb: include <asm/tlb.h> for missing prototype
      xtensa: iss/network: make functions static
      xtensa: boot: don't add include-dirs
      xtensa: umulsidi3: fix conditional expression

 arch/xtensa/boot/Makefile               | 3 +--
 arch/xtensa/boot/lib/zmem.c             | 5 +++--
 arch/xtensa/include/asm/core.h          | 4 ++++
 arch/xtensa/include/asm/hw_breakpoint.h | 1 +
 arch/xtensa/include/asm/processor.h     | 5 +++++
 arch/xtensa/include/asm/ptrace.h        | 3 +++
 arch/xtensa/include/asm/smp.h           | 1 +
 arch/xtensa/include/asm/tlb.h           | 2 ++
 arch/xtensa/kernel/hw_breakpoint.c      | 1 +
 arch/xtensa/kernel/irq.c                | 1 +
 arch/xtensa/kernel/ptrace.c             | 1 -
 arch/xtensa/kernel/signal.c             | 2 ++
 arch/xtensa/kernel/smp.c                | 1 +
 arch/xtensa/kernel/stacktrace.c         | 1 +
 arch/xtensa/kernel/traps.c              | 1 +
 arch/xtensa/lib/umulsidi3.S             | 4 +++-
 arch/xtensa/mm/fault.c                  | 1 +
 arch/xtensa/mm/tlb.c                    | 1 +
 arch/xtensa/platforms/iss/network.c     | 4 ++--
 drivers/irqchip/irq-xtensa-mx.c         | 1 +
 20 files changed, 35 insertions(+), 8 deletions(-)

-- 
Thanks.
-- Max
