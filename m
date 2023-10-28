Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 598167DA709
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 15:00:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbjJ1M7y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Oct 2023 08:59:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjJ1M7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Oct 2023 08:59:52 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1BB6DE
        for <linux-kernel@vger.kernel.org>; Sat, 28 Oct 2023 05:59:49 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-51e28cac164so8415483a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 28 Oct 2023 05:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698497988; x=1699102788; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=3UR3GS6imOR6YGJJdA7lpkHOMfJC/pVezhxlj/37b0I=;
        b=E13sv1wJEbdcifpCRLcy13dm58vFUPHoXXfEvH2czV04EPDRmA7rl+SDNFC4POkMnE
         MPzMy1pohEQ24t5mo2epEO2rvijE1s+wCsqhXxdj9nzMfitzipKs8JunLh2BUS7Ve3TD
         2Y8huYAXnRufKwZCq1DD4erTTs/LEMX4tE4iFo5l2wvieCQsiOmsxsR4ZMLoGK/zm7Xf
         Ica9JfsetlqWg3sJXBAJanWLh2C0qPCgM5R0QA8HqyHlja0CpGaG5S2os9sasbGjZqXI
         kAUz0EXW6Pkhm1Zo4lw9SdooZURHHtV7IuL6bUdZr+YMe2KyuXYEuJzGOVgFmOn6MyLY
         cHwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698497988; x=1699102788;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3UR3GS6imOR6YGJJdA7lpkHOMfJC/pVezhxlj/37b0I=;
        b=L1SXvbFkXcaIYIc7ENXkNh4YxhuYu3oITO3tczlVtpIx0Yw5b97yyvkJrQxTeRsoz3
         ObLexWrs58sSTXlgUNnvpb4uzoOR6423JYh9asKjNwy5JhY8GWIo1eBtJxxB7ol34Kdr
         pRZAuOnQk8eWEkiTm2V7tk10F5EBkJ+M5MR3fO40WcdCb60AjBrIlHY2Wo2ihqcIDYsx
         leT9blO65XWCaxhF0PNMHTDIWUoaBdobbCvsE971Lq+212tsW7OxoJ4lUYEAC6hUdwkp
         srX24dQpfNdjeW62mnevYZiP5DnQGg35vykNNMQehicQlwnCP8dY1mrHU8eTuFz4+PDF
         5Etg==
X-Gm-Message-State: AOJu0YzWvjGM/OojMMQZpLnty5gxcDkSpkRGPaCriCGXJI2u4MC1GNne
        TJv8lxTQKZzTMti3+deu5lTRowEfkSM=
X-Google-Smtp-Source: AGHT+IGnFL5uFSse0sHaxzVMKIJT6Tjv9APXTdbeTNk6avHvV2KfbsRxegJzGYGHosW240tU136rvw==
X-Received: by 2002:a17:906:f291:b0:9a5:aa43:1c7c with SMTP id gu17-20020a170906f29100b009a5aa431c7cmr4405860ejb.26.1698497988320;
        Sat, 28 Oct 2023 05:59:48 -0700 (PDT)
Received: from gmail.com (1F2EF1E7.nat.pool.telekom.hu. [31.46.241.231])
        by smtp.gmail.com with ESMTPSA id x6-20020a1709064a8600b00977cad140a8sm2735083eju.218.2023.10.28.05.59.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Oct 2023 05:59:47 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Sat, 28 Oct 2023 14:59:45 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Uros Bizjak <ubizjak@gmail.com>,
        Brian Gerst <brgerst@gmail.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: [GIT PULL] x86/asm changes for v6.7
Message-ID: <ZT0FwZYk4Dm/Lqix@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86/asm git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-asm-2023-10-28

   # HEAD: 8ae292c66dcb160b3e1e16b66c3076d5a2c63873 x86/lib: Address kernel-doc warnings

x86 assembly code improvements for v6.7 are:

- Micro-optimize the x86 bitops code
- Define target-specific {raw,this}_cpu_try_cmpxchg{64,128}() to improve code generation
- Define and use raw_cpu_try_cmpxchg() preempt_count_set()
- Do not clobber %rsi in percpu_{try_,}cmpxchg{64,128}_op
- Remove the unused __sw_hweight64() implementation on x86-32
- Misc fixes and cleanups

 Thanks,

	Ingo

------------------>
Ingo Molnar (1):
      x86/bitops: Remove unused __sw_hweight64() assembly implementation on x86-32

Nick Desaulniers (1):
      x86/asm/bitops: Use __builtin_clz{l|ll} to evaluate constant expressions

Uros Bizjak (4):
      x86/percpu: Define {raw,this}_cpu_try_cmpxchg{64,128}
      x86/percpu: Define raw_cpu_try_cmpxchg and this_cpu_try_cmpxchg()
      x86/percpu: Use raw_cpu_try_cmpxchg() in preempt_count_set()
      x86/percpu: Do not clobber %rsi in percpu_{try_,}cmpxchg{64,128}_op

Xin Li (Intel) (2):
      x86/entry: Remove unused argument %rsi passed to exc_nmi()
      x86/entry: Fix typos in comments

Zhu Wang (1):
      x86/lib: Address kernel-doc warnings


 arch/x86/entry/entry_64.S       |  10 ++--
 arch/x86/include/asm/bitops.h   |   9 ++++
 arch/x86/include/asm/percpu.h   | 110 +++++++++++++++++++++++++++++++++++++---
 arch/x86/include/asm/preempt.h  |   4 +-
 arch/x86/lib/csum-wrappers_64.c |   5 --
 arch/x86/lib/hweight.S          |  20 +++-----
 6 files changed, 125 insertions(+), 33 deletions(-)
