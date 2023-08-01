Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D46076B703
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 16:16:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232776AbjHAOQQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 10:16:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbjHAOQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 10:16:14 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7135BF
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 07:16:13 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id d9443c01a7336-1bbc06f830aso37586685ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Aug 2023 07:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690899373; x=1691504173;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3jFV9XAxcsKZ1IZ7FbIlGmL+fRJueIamD5rnI3l/9I4=;
        b=BU/pqNAyFkP3cndzLQYB/KyOxc68v55NJDx0inLLo//mG7WvlqrCpmiJ7xQ15WJu6e
         qxOGCnlzPYCrrKaGqu15t4FfPRNdT4xgHqvlsWsdFmIsxN7Efxt8lOk2iKE7tgREKYP8
         vEqaDoJEMWDgLcyKMhoMfwUZ+2BfD2Yw7XMxVvzuaQZrgt/AysZiirIRHF6DWIn/fhR8
         9VsRSBYPzI3YZsKo29TQc3WwMfWxjojPAPVFv8CUhL23DIredqJxr7RjSUnFGYRkEHPL
         tjBvqXjBu/3uAXVShAOLH6IZlYzO41Hnj0cXQQdL+GlMB+wFg/XJa/u2lgZS78z7tsPA
         1J0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690899373; x=1691504173;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3jFV9XAxcsKZ1IZ7FbIlGmL+fRJueIamD5rnI3l/9I4=;
        b=IZwsDDvzSdAuRgO95oTNB4EeES0Clj26kMg8msWQARiLkRP3SlTSQkpRaoyI3GAy/c
         t5pqmM8SAux0+fKL+pIB9xo6gGDKDGxOMW/UKgDrbaDlMRmTXk6k9d1h2fEc8q02U5P/
         X9xOfOpv946jlTUpwrGhnHVI+CsiKWdp58AENQSemrjJ/zq9/r4DSFAJ6bu/bA7y9I9a
         WCicI7QacUov1nfTKfONVNh72oUsKK+orFNQSMB8ekqQY3z4cpjfY6D0Gx0JpJ9EXXEX
         YOzj1z8xtKNiSlx+GFGwmRdpyI3NmNGRhcLXjtAX+aO+gqtTbTXvYHJCTtdTYhVoxmEo
         TJlw==
X-Gm-Message-State: ABy/qLYQVim8uofECcRwzMgs4wytbyXffSnquQMl5Xr/CXhXACcMGKyY
        XJnVOsPmSE8GKJKZMkL3Th4=
X-Google-Smtp-Source: APBJJlExiPxDP932JGscZIrLZalViGmQU7KrT7LdWCbl80hR5iI6lu7lJ6rBiYh9VtxYXBOMai260A==
X-Received: by 2002:a17:902:dacf:b0:1bb:c9e3:6d4f with SMTP id q15-20020a170902dacf00b001bbc9e36d4fmr17790506plx.10.1690899373147;
        Tue, 01 Aug 2023 07:16:13 -0700 (PDT)
Received: from localhost ([212.107.28.51])
        by smtp.gmail.com with ESMTPSA id h7-20020a170902f7c700b001b8c689060dsm10583434plw.28.2023.08.01.07.16.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 07:16:12 -0700 (PDT)
From:   Celeste Liu <coelacanthushex@gmail.com>
X-Google-Original-From: Celeste Liu <CoelacanthusHex@gmail.com>
To:     Palmer Dabbelt <palmer@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        linux-riscv@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Andreas Schwab <schwab@suse.de>,
        David Laight <David.Laight@ACULAB.COM>,
        Celeste Liu <CoelacanthusHex@gmail.com>,
        Felix Yan <felixonmars@archlinux.org>,
        Ruizhe Pan <c141028@gmail.com>,
        Shiqi Zhang <shiqi@isrc.iscas.ac.cn>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>
Subject: [PATCH v5] riscv: entry: set a0 = -ENOSYS only when syscall != -1
Date:   Tue,  1 Aug 2023 22:15:16 +0800
Message-ID: <20230801141607.435192-1-CoelacanthusHex@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we test seccomp with 6.4 kernel, we found errno has wrong value.
If we deny NETLINK_AUDIT with EAFNOSUPPORT, after f0bddf50586d, we will
get ENOSYS instead. We got same result with commit 9c2598d43510 ("riscv:
entry: Save a0 prior syscall_enter_from_user_mode()").

After analysing code, we think that regs->a0 = -ENOSYS should only be
executed when syscall != -1. In __seccomp_filter, when seccomp rejected
this syscall with specified errno, they will set a0 to return number as
syscall ABI, and then return -1. This return number is finally pass as
return number of syscall_enter_from_user_mode, and then is compared with
NR_syscalls after converted to ulong (so it will be ULONG_MAX). The
condition syscall < NR_syscalls will always be false, so regs->a0 = -ENOSYS
is always executed. It covered a0 set by seccomp, so we always get
ENOSYS when match seccomp RET_ERRNO rule.

Fixes: f0bddf50586d ("riscv: entry: Convert to generic entry")
Reported-by: Felix Yan <felixonmars@archlinux.org>
Co-developed-by: Ruizhe Pan <c141028@gmail.com>
Signed-off-by: Ruizhe Pan <c141028@gmail.com>
Co-developed-by: Shiqi Zhang <shiqi@isrc.iscas.ac.cn>
Signed-off-by: Shiqi Zhang <shiqi@isrc.iscas.ac.cn>
Signed-off-by: Celeste Liu <CoelacanthusHex@gmail.com>
Tested-by: Felix Yan <felixonmars@archlinux.org>
Tested-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
Reviewed-by: Björn Töpel <bjorn@rivosinc.com>
Reviewed-by: Guo Ren <guoren@kernel.org>
---

v4 -> v5: add Tested-by Emil Renner Berthing <emil.renner.berthing@canonical.com>
v3 -> v4: use long instead of ulong to reduce type cast and avoid
          implementation-defined behavior, and make the judgment of syscall
          invalid more explicit
v2 -> v3: use if-statement instead of set default value,
          clarify the type of syscall
v1 -> v2: added explanation on why always got ENOSYS

 arch/riscv/kernel/traps.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
index f910dfccbf5d2..729f79c97e2bf 100644
--- a/arch/riscv/kernel/traps.c
+++ b/arch/riscv/kernel/traps.c
@@ -297,7 +297,7 @@ asmlinkage __visible __trap_section void do_trap_break(struct pt_regs *regs)
 asmlinkage __visible __trap_section void do_trap_ecall_u(struct pt_regs *regs)
 {
 	if (user_mode(regs)) {
-		ulong syscall = regs->a7;
+		long syscall = regs->a7;
 
 		regs->epc += 4;
 		regs->orig_a0 = regs->a0;
@@ -306,9 +306,9 @@ asmlinkage __visible __trap_section void do_trap_ecall_u(struct pt_regs *regs)
 
 		syscall = syscall_enter_from_user_mode(regs, syscall);
 
-		if (syscall < NR_syscalls)
+		if (syscall >= 0 && syscall < NR_syscalls)
 			syscall_handler(regs, syscall);
-		else
+		else if (syscall != -1)
 			regs->a0 = -ENOSYS;
 
 		syscall_exit_to_user_mode(regs);
-- 
2.41.0

