Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A2EC7DA759
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 15:37:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbjJ1Nhy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Oct 2023 09:37:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjJ1Nhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Oct 2023 09:37:52 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C35C4C0
        for <linux-kernel@vger.kernel.org>; Sat, 28 Oct 2023 06:37:50 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9d216597f64so33858466b.3
        for <linux-kernel@vger.kernel.org>; Sat, 28 Oct 2023 06:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698500269; x=1699105069; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=w0tdV8EdrN+r6rFvS4b1TPJ6xBBB4wTUissluCAyhPo=;
        b=Hk3+BhTnGTZe+bdOfhDP8wlEmGo2Bfo2ssu6vo05+DS3tSSZG3JCDFABe3qRbqJXp9
         mIave3SV2F+vzMHDlA9/jqvqEJirqw5lStlalLAQZv0PXTOb8GKPHbUzF+P5ARcnJR+j
         YuOkRcAKKh8OGNErDnpwGkpkZ2Msub2W1u8FAdtYELIoJn1dkz2JHCRJeS4JnBGPutU5
         JjfaY3zOjhg2XFVGjCnd3iK6X3jhp65AwCDGepZkBu/rTtimjs1qp3H2tbldOPcWN/Tw
         uEqjMzHmKT9uYfvddHgPgwPnvAj7S89Xa3NObzrARXQqOyslcBN2BhieIo0ROT2VCJ6h
         0SCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698500269; x=1699105069;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w0tdV8EdrN+r6rFvS4b1TPJ6xBBB4wTUissluCAyhPo=;
        b=dMcw+ghY9wgIonWEOi+XCkIDAhtXkmOoxVzS/mmIzIXn8yRsmfa6HtcFXmiubQbJsG
         Co03d5q3dlTgLpbzLssv5Z+1oW2bMFE0lwnJx1Vw6wSRNaGBRSZ/VCUnmj4Ac+JBt7ej
         c9Llk+VX15ZVPJXmi32x/dN2WZ7McrVbLX2JPOKQl3189fMzupN1onTpDoQMCQGr/JVt
         2mflX68iR63TckdlN+jUZ9OMk+OX1uXYtEt8b4XstzX6yA6kOfUB9QZNylZRjH4FNa2X
         zZZpoci4T9z8Ftk9sW6shA6Gdq4A1aob08m0ClNGXlfhoZnJpJKX7XxF9hHUOIYN4Q1Y
         5a5Q==
X-Gm-Message-State: AOJu0YyOY0ddwZIp6e328p6tb2MyPns4O07b85A2hU7MsvcA9Cg4jHKl
        lvjshXcWu/HvRnvEhSl+S7M=
X-Google-Smtp-Source: AGHT+IEcfOLJWVqncFQsdNd7LUjmSxySQ29MgBJ+u32QkoJSxYq+JPLr+SRkk1bfv6dfPhMkSF+f2A==
X-Received: by 2002:a17:907:9718:b0:9be:6395:6b0f with SMTP id jg24-20020a170907971800b009be63956b0fmr4350663ejc.29.1698500268996;
        Sat, 28 Oct 2023 06:37:48 -0700 (PDT)
Received: from gmail.com (1F2EF1E7.nat.pool.telekom.hu. [31.46.241.231])
        by smtp.gmail.com with ESMTPSA id w17-20020a17090652d100b009c46445fcc7sm2808211ejn.33.2023.10.28.06.37.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Oct 2023 06:37:48 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Sat, 28 Oct 2023 15:37:46 +0200
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
Subject: [GIT PULL] x86/entry changes for v6.7
Message-ID: <ZT0OqhIh/7c9IOYU@gmail.com>
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

Please pull the latest x86/entry git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-entry-2023-10-28

   # HEAD: 1a09a27153f91cd7676b2d4ca574577572a8c999 x86/entry/32: Clean up syscall fast exit tests

Changes to the x86 entry code in v6.7:

 - Make IA32_EMULATION boot time configurable with
   the new ia32_emulation=<bool> boot option.

 - Clean up fast syscall return validation code: convert
   it to C and refactor the code.

 - As part of this, optimize the canonical RIP test code.

 Thanks,

	Ingo

------------------>
Brian Gerst (7):
      x86/entry/64: Remove obsolete comment on tracing vs. SYSRET
      x86/entry/compat: Combine return value test from syscall handler
      x86/entry/32: Convert do_fast_syscall_32() to bool return type
      x86/entry/32: Remove SEP test for SYSEXIT
      x86/entry/64: Convert SYSRET validation tests to C
      x86/entry/64: Use TASK_SIZE_MAX for canonical RIP test
      x86/entry/32: Clean up syscall fast exit tests

Nikolay Borisov (6):
      x86: Introduce ia32_enabled()
      x86/entry: Rename ignore_sysret()
      x86/entry: Compile entry_SYSCALL32_ignore() unconditionally
      x86/elf: Make loading of 32bit processes depend on ia32_enabled()
      x86/entry: Make IA32 syscalls' availability depend on ia32_enabled()
      x86: Make IA32_EMULATION boot time configurable


 Documentation/admin-guide/kernel-parameters.txt |   6 ++
 arch/x86/Kconfig                                |   9 ++
 arch/x86/entry/common.c                         | 113 +++++++++++++++++-------
 arch/x86/entry/entry_32.S                       |   2 +-
 arch/x86/entry/entry_64.S                       |  72 +--------------
 arch/x86/entry/entry_64_compat.S                |  11 ++-
 arch/x86/include/asm/elf.h                      |   3 +-
 arch/x86/include/asm/ia32.h                     |  16 +++-
 arch/x86/include/asm/processor.h                |   2 +-
 arch/x86/include/asm/proto.h                    |   3 +
 arch/x86/include/asm/syscall.h                  |   6 +-
 arch/x86/kernel/cpu/common.c                    |  37 ++++----
 arch/x86/kernel/idt.c                           |   7 ++
 13 files changed, 155 insertions(+), 132 deletions(-)
