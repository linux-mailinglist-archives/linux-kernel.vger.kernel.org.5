Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4318F75B0AB
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 16:04:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231834AbjGTOEA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 10:04:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231821AbjGTOD6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 10:03:58 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2431123
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 07:03:53 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id d9443c01a7336-1b8ad907ba4so4799555ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 07:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689861833; x=1690466633;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lbBdDUz6VGX98niIu+BGaqGxsZA67A1XV22QOnIoLPo=;
        b=J/WIA0vAnFMqsMD0cDTzPYrsu3oQvTmexdcY5wVpuL/h7i5K/uWpEk6uPbs1RqbY+y
         jf74qn6EqDQsrNcSmvzDndHJUP8GPxO0+cjDFPvH7en5FOHxCQqw9PGjCOk6IwBF357j
         BM8br2FTCELh3Zvnj0fTywtrCLRQ/mEZB26yN6/62ueXrYaizunykxC975HpT6gLwLXe
         RI5omi1yfryP/U7UwH6sC10ixiszR1kXdLTyfqpdzf6Y32fIi3sM9lB5lJQum3og+3le
         JYNkUh0OAr6/u63s6NB2o/aNSgAXtYkWvM0t4iLVXxIFXJMxTfCM8IbxP+qSe6qOzBgx
         w0Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689861833; x=1690466633;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lbBdDUz6VGX98niIu+BGaqGxsZA67A1XV22QOnIoLPo=;
        b=VvHrO4MqCzJ5U9zH4PNFSDq7I3m/LXuopWlhA5vWwJIazZcVc+JhrW/FR7DBmtEgk4
         BjIbTeooryIab4Rl48dFTZi7dloxikyc3dnFWMkIEHTR67hyxXw0CrJdqBHx87VXpsbz
         LPk1vgE0YuzmHabFJRXWt+62GjzMiAd2O5P2R1HNwBSo25aZCCU4//bxJ+3QJqPjW9Ax
         jLL56WXpf6BTo7Io02KKp8Z9ntl/zD5kNtUXsmptfP614MXXv3KvrAavbFR5YdfKuxFc
         E1sSOAQ/Bk0GjSBsqEH7erelA5TeIyHkI9cm1i1E6v2dwt2VpHsjQ3gW5zmN4oJ5kSa0
         HIwQ==
X-Gm-Message-State: ABy/qLa+14R4tbFsGqHOEwpu68lhynDAUKFxC/dR6ucOP3f3stFutbYD
        exirQGVr8jYYwdfoq5BWuCs=
X-Google-Smtp-Source: APBJJlFYniAOxPj+jbipSRdp28xO9A220xt8cX/XWm8kkwoPNSZ8fIMX6wUYeDqQAY52A1uw7cmdcw==
X-Received: by 2002:a17:903:41d2:b0:1b8:ab0d:cd5 with SMTP id u18-20020a17090341d200b001b8ab0d0cd5mr19262956ple.49.1689861832818;
        Thu, 20 Jul 2023 07:03:52 -0700 (PDT)
Received: from localhost ([212.107.28.53])
        by smtp.gmail.com with ESMTPSA id jg19-20020a17090326d300b001b9bebb7a9dsm1398531plb.90.2023.07.20.07.03.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 07:03:52 -0700 (PDT)
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
        Shiqi Zhang <shiqi@isrc.iscas.ac.cn>
Subject: [PATCH v4] riscv: entry: set a0 = -ENOSYS only when syscall != -1
Date:   Thu, 20 Jul 2023 21:56:29 +0800
Message-ID: <20230720140348.4716-1-CoelacanthusHex@gmail.com>
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
get ENOSYS instead. We got same result with commit 9c2598d43510 ("riscv: entry:
Save a0 prior syscall_enter_from_user_mode()").

After analysing code, we think that regs->a0 = -ENOSYS should only be executed
when syscall != -1 In __seccomp_filter, when seccomp rejected this syscall with
specified errno, they will set a0 to return number as syscall ABI, and then
return -1. This return number is finally pass as return number of
syscall_enter_from_user_mode, and then is compared with NR_syscalls after
converted to ulong (so it will be ULONG_MAX). The condition
syscall < NR_syscalls will always be false, so regs->a0 = -ENOSYS is always
executed. It covered a0 set by seccomp, so we always get ENOSYS when match
seccomp RET_ERRNO rule.

Fixes: f0bddf50586d ("riscv: entry: Convert to generic entry")
Reported-by: Felix Yan <felixonmars@archlinux.org>
Co-developed-by: Ruizhe Pan <c141028@gmail.com>
Signed-off-by: Ruizhe Pan <c141028@gmail.com>
Co-developed-by: Shiqi Zhang <shiqi@isrc.iscas.ac.cn>
Signed-off-by: Shiqi Zhang <shiqi@isrc.iscas.ac.cn>
Signed-off-by: Celeste Liu <CoelacanthusHex@gmail.com>
Tested-by: Felix Yan <felixonmars@archlinux.org>
Reviewed-by: Björn Töpel <bjorn@rivosinc.com>
Reviewed-by: Guo Ren <guoren@kernel.org>
---

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

