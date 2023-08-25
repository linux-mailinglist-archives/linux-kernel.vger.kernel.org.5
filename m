Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24A1B78883B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 15:17:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245008AbjHYNQv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 09:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245054AbjHYNQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 09:16:44 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACF41E78
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 06:16:42 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1bf55a81eeaso6923585ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 06:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1692969402; x=1693574202;
        h=message-id:to:from:cc:subject:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4rO/T+VQAJjKyFqYU/q8vdJEmTES2395aidBJOFqlkc=;
        b=ugf4EtqYq2JVD/vAGeFD6EbdjYI93k0jVrPkERBv58xTOuFkDnt9ifB5NSChYQDi7j
         1nu+WjzYtK6ir/P1OAY35X2HYj/LXQlTFazawP8dLBfAjemXkSd0YHgPIs2Tzf25XgAB
         M9BeSQCkaBJnc7cs6GGm4J58Ouhr+PCow9dG7mSLHReSKTD/2ipaLDsY7cGIIwYIBQKR
         szjf022J0YCd40+BetUEY7pIctRCrFuFG3cgGCxZk9ekJWxl/vboVfQ9mq4CA8mqONO2
         80sp6lQRGRMYGJmKwvxhp6tMhUtbl+v/SpKIyXcyMiUj22gPdmBwddmb1nxt78Vtvpzn
         6H/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692969402; x=1693574202;
        h=message-id:to:from:cc:subject:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4rO/T+VQAJjKyFqYU/q8vdJEmTES2395aidBJOFqlkc=;
        b=ihXyugCs22XgJrRk7x2CjdiivY88PR1t4bYTizzKx91S8goZODDpJfrRrFPt9wMyxI
         KQPJXs29FKy41hu4Z38cdF0eyiAitoNAhJpp098o88eKXbvLfMXt0MZBiZZMmziKSJ23
         AtB6mNDYO1VzvWTmojmyvDVARbX3+PLoGGyhdt1g8q3N+djbfEV2dNGrFNOC/ZjQMyfD
         kgY2kp8XAS18M2SQQhWcOp1J4jsXcvI/TXzKAYLYr4GjMct3mDzP2PkHBykm3mHhmmgw
         jYOdLKeOF0UFjeda6uXThyufegbKLpm/Kw3E644I/+lwoo0IYxGBsCmZ0RGeFdZRxIWc
         JWpw==
X-Gm-Message-State: AOJu0YzDGZxaQQuoKgglO21ku6b3j9qq5xaxdm5y4ZIka91EXH1CcUiU
        osgUKt8SHeAOV50oA27Yfpdl1qJZqtx9+ovs7vE=
X-Google-Smtp-Source: AGHT+IHBevM73Kvye69jaRbhoCXokaiiVy88IwWofacgNFMm10yHyulUw6HZsXBBoWq194yqe8RtUA==
X-Received: by 2002:a17:903:4cd:b0:1bb:b855:db3c with SMTP id jm13-20020a17090304cd00b001bbb855db3cmr14119522plb.41.1692969401992;
        Fri, 25 Aug 2023 06:16:41 -0700 (PDT)
Received: from localhost ([135.180.227.0])
        by smtp.gmail.com with ESMTPSA id b19-20020a170902ed1300b001bb99ea5d02sm1661383pld.4.2023.08.25.06.16.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 06:16:41 -0700 (PDT)
Date:   Fri, 25 Aug 2023 06:16:41 -0700 (PDT)
X-Google-Original-Date: Fri, 25 Aug 2023 06:15:01 PDT (-0700)
Subject: [GIT PULL] RISC-V Fixes for 6.5-rc8
CC:         linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <mhng-f80b6a8e-79e3-486b-95e4-18c04a1be0dd@palmer-ri-x1c9>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit ca09f772cccaeec4cd05a21528c37a260aa2dd2c:

  riscv: Handle zicsr/zifencei issue between gcc and binutils (2023-08-16 07:39:38 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.5-rc8

for you to fetch changes up to ef21fa7c198e04f3d3053b1c5b5f2b4b225c3350:

  riscv: Fix build errors using binutils2.37 toolchains (2023-08-24 12:35:20 -0700)

----------------------------------------------------------------
RISC-V Fixes for 6.5-rc8

* The vector ucontext extension has been extended with vlenb.
* The vector registers ELF core dump note type has been changed to avoid
  aliasing with the CSR type used in embedded systems.
* Support for accessing vector registers via ptrace() has been reverted.
* Another build fix for the ISA spec changes around Zifencei/Zicsr that
  manifests on some systems built with binutils-2.37 and gcc-11.2.

----------------------------------------------------------------
This is obviously not ideal, particularly for something this late in the cycle.
Unfortunately we found some uABI issues in the vector support while reviewing
the GDB port, which has triggered a revert -- probably a good sign we should
have reviewed GDB before merging this, I guess I just dropped the ball because
I was so worried about the context extension and libc suff I forgot.  Hence the
late revert.

There's some risk here as we're still exposing the vector context for signal
handlers, but changing that would have meant reverting all of the vector
support.  The issues we've found so far have been fixed already and they
weren't absolute showstoppers, so we're essentially just playing it safe by
holding ptrace support for another release (or until we get through a proper
userspace code review).

So sorry for the churn, I'll try to be more careful next time.

----------------------------------------------------------------
Andy Chiu (1):
      RISC-V: vector: export VLENB csr in __sc_riscv_v_state

Mingzheng Xing (1):
      riscv: Fix build errors using binutils2.37 toolchains

Palmer Dabbelt (2):
      RISC-V: Remove ptrace support for vectors
      Merge patch series "riscv: fix ptrace and export VLENB"

 arch/riscv/Kconfig                   |  8 ++---
 arch/riscv/include/asm/vector.h      |  3 +-
 arch/riscv/include/uapi/asm/ptrace.h |  1 +
 arch/riscv/kernel/ptrace.c           | 69 ------------------------------------
 include/uapi/linux/elf.h             |  1 -
 5 files changed, 7 insertions(+), 75 deletions(-)
