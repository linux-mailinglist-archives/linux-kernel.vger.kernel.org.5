Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 528EA758660
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 23:01:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbjGRVBC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 17:01:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbjGRVBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 17:01:00 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02794198C
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 14:00:59 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id 41be03b00d2f7-55b1238a013so4723995a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 14:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689714058; x=1692306058;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OHHcOhkbsv1p/qZwif2W/kSpl8RMjgRTDPZDHV7WrBw=;
        b=LOkbMmif5Ycr4XzhJft2CzhA9qbAeEjYa/Cr0ll2csDNgcvG/NXmoNZXISITQglpRj
         hhtX/VRxsa2hxIDKzNTyFAN++h5tdTzFUqqtIFcjQIHCj6Qq2zobuQLE/fBu/qw4+9uq
         KRjCEp33u2nXN0u+0H1XJGVL6NqeU3WZrWgnYRV3gc0ZAxp803ROYs0SKZ2VXffz8JLE
         xc97gI3pIYHq4XW72UVvcf3uVT8pn43z6plpgB5LFvwKGuee6miTf9TRMpipJglmdmAd
         RnU2XIrpwa1voPrQqUppPno9Bpmwtr7nz3oimKRWZIhB/dFSrlBzrIcfo+GK8654aZ4b
         FLgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689714058; x=1692306058;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OHHcOhkbsv1p/qZwif2W/kSpl8RMjgRTDPZDHV7WrBw=;
        b=jQD0nw6mRZiXqZOK0ibrdJPEqXrCkhiaV8mwH532Mkaq3MHvL3FQ/lLyCQhuApTEIF
         oFcvgoRrmUcjtcEQYN4mAvp1mwutDyByXn4iU53B4Fl9tuNvEAoSgPJshfFANVLkQpYC
         ytccMHktRcVp3cg66jsVp+41DKA7lhU1nNA0oW3f3NllsdF37nSMWDuC9PoRGFiN8NwY
         1c54njz436wb/xkrnvz7AKrboH/YB03v7EsrwFlLnXUn1F8jC4TPrHB1HYOscK7lHSps
         tVuBBx/yIva9qimaOKGYBtRgVf2NzY/cmcVLdeoU/2/ctSeEN+yR+K7UgR0NtI/ljoGU
         cteQ==
X-Gm-Message-State: ABy/qLZ9FUF84mIyKom/mBnGQJXJC356iB7TMVvQJSt/GD+R/Q/S6ECN
        vzabJOCCwqRLu+9VdAyFpfU=
X-Google-Smtp-Source: APBJJlGtYn6KzK28oMCE0qYWdPXLgvr+4ng4J+CyxMR+FL2Vlo5llyfi1/hx5fY2V82w7q/P8bwraA==
X-Received: by 2002:a17:90b:788:b0:264:2e2:7be8 with SMTP id l8-20020a17090b078800b0026402e27be8mr13566948pjz.18.1689714058379;
        Tue, 18 Jul 2023 14:00:58 -0700 (PDT)
Received: from localhost ([212.107.28.53])
        by smtp.gmail.com with ESMTPSA id 14-20020a17090a0cce00b00262e5449dbcsm20590pjt.24.2023.07.18.14.00.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 14:00:58 -0700 (PDT)
From:   Celeste Liu <coelacanthushex@gmail.com>
X-Google-Original-From: Celeste Liu <CoelacanthusHex@gmail.com>
To:     Palmer Dabbelt <palmer@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        linux-riscv@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Celeste Liu <CoelacanthusHex@gmail.com>,
        Felix Yan <felixonmars@archlinux.org>,
        Ruizhe Pan <c141028@gmail.com>,
        Shiqi Zhang <shiqi@isrc.iscas.ac.cn>
Subject: [PATCH v3] riscv: entry: set a0 = -ENOSYS only when syscall != -1
Date:   Wed, 19 Jul 2023 04:57:30 +0800
Message-ID: <20230718210037.250665-1-CoelacanthusHex@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
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
---

v2 -> v3: use if-statement instead of set default value,
          clarify the type of syscall
v1 -> v2: added explanation on why always got ENOSYS

 arch/riscv/kernel/traps.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
index f910dfccbf5d2..5cef728745420 100644
--- a/arch/riscv/kernel/traps.c
+++ b/arch/riscv/kernel/traps.c
@@ -297,6 +297,10 @@ asmlinkage __visible __trap_section void do_trap_break(struct pt_regs *regs)
 asmlinkage __visible __trap_section void do_trap_ecall_u(struct pt_regs *regs)
 {
 	if (user_mode(regs)) {
+		/*
+		 * Convert negative numbers to very high and thus out of range
+		 * numbers for comparisons.
+		 */
 		ulong syscall = regs->a7;
 
 		regs->epc += 4;
@@ -308,7 +312,7 @@ asmlinkage __visible __trap_section void do_trap_ecall_u(struct pt_regs *regs)
 
 		if (syscall < NR_syscalls)
 			syscall_handler(regs, syscall);
-		else
+		else if ((long)syscall != -1L)
 			regs->a0 = -ENOSYS;
 
 		syscall_exit_to_user_mode(regs);
-- 
2.41.0

