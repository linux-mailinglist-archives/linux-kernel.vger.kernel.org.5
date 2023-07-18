Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 344AD758219
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 18:29:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232307AbjGRQ3q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 12:29:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231302AbjGRQ3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 12:29:45 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45D53E77
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 09:29:44 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id d2e1a72fcca58-66872d4a141so3856410b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 09:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689697784; x=1692289784;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yeYxjLuTkeXplzaU1/5MYQdHyT2ovErfxDS2RgTO3Ok=;
        b=gLQjkG4fVekO4wKfOEhQiTxp/MrdgHIZnXQ0WmW0vwH325FTQMH+hvO0Pl6Tv4So7B
         TCAB08k/nZ6tFUTBDeGsVNR9mEAipRHe0EIzaEVBs6wXYt6zGOPX28c+scik8leIgk07
         eXHW9moGIYwa1vSPSLZqXjFacnO4ukAE8io9e5ttRdydgXuNH2kjH/YQyI45Esm893uf
         GJnWKDfoIhvCgOP1jZL1yqtNK5n1DzSHjkMwGIunf7HYrnEdIAjkNt8C4/cbrV6ZnN1G
         J1XVF3sCTJ/XkxODVioUM9fy0W9h0Uo/IwsR9bTOhOMXUXsIx2qEzGpePAVqsxehokRB
         WS9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689697784; x=1692289784;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yeYxjLuTkeXplzaU1/5MYQdHyT2ovErfxDS2RgTO3Ok=;
        b=DoUNpdVxLFk+stzFrMJ6SbNA2SjLPTexSwqCWxH5OzClhQcGrwVpIi+JiF/A75u2jh
         XWu9HCA1/7/29SB3JClIa2ddCbtraQbR4Zzxjwu2VT7kRrsJZqfdvLCLKZ9w+Di6UBtm
         eCgrCrtgrtwAXdEuU2+KfuHErc9BKpbz17cSwk1XRrhU2em/rv2awSPFQYOBuac6MhB3
         9jfE9yf18R31E5QDuBDo166RN11ibAgUP+USjjpTXX6uVqcFx5aZEXucHi3VtD1YiigI
         RybqWvhFU95cwjW4kNqLGj+xC4gD6wTx4sorFMzCBpEdJ5s9v3PHeeLesRzG/+dChLP8
         bxvA==
X-Gm-Message-State: ABy/qLazJfbRMDVDeA/qeag5uPA1xPZ2ElWwo8iUov5MEPsYihA4AfWy
        V8zJP1w3ktV5hlrzCxV0eDI=
X-Google-Smtp-Source: APBJJlHJ1Qy7cPNo88MjFDp9ATIP+Ij4hUgUh/REqcmbOnaMxlELvzKUTeKwAjO70btUmn9wUqG1KA==
X-Received: by 2002:a05:6a20:1443:b0:101:1951:d491 with SMTP id a3-20020a056a20144300b001011951d491mr17658741pzi.6.1689697783544;
        Tue, 18 Jul 2023 09:29:43 -0700 (PDT)
Received: from localhost ([212.107.28.53])
        by smtp.gmail.com with ESMTPSA id g22-20020a62e316000000b0062bc045bf4fsm1807671pfh.19.2023.07.18.09.29.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 09:29:43 -0700 (PDT)
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
Subject: [PATCH v2] riscv: entry: set a0 prior to syscall_enter_from_user_mode
Date:   Wed, 19 Jul 2023 00:28:46 +0800
Message-ID: <20230718162940.226118-1-CoelacanthusHex@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
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
get ENOSYS instead. We got same result with 9c2598d43510 ("riscv: entry: Save a0
prior syscall_enter_from_user_mode()").

After analysing code, we think that regs->a0 = -ENOSYS should be advanced before
syscall_enter_from_user_mode to fix this problem. In __seccomp_filter, when
seccomp rejected this syscall with specified errno, they will set a0 to return
number as syscall ABI, and then return -1. This return number is finally pass
as return number of syscall_enter_from_user_mode, and then is compared
with NR_syscalls after converted to ulong (so it will be ULONG_MAX).
The condition syscall < NR_syscalls will always be false, so regs->a0 = -ENOSYS
is always executable. It covered a0 set by seccomp, so we always get
ENOSYS when match seccomp RET_ERRNO rule.

Fixes: f0bddf50586d ("riscv: entry: Convert to generic entry")
Reported-by: Felix Yan <felixonmars@archlinux.org>
Co-developed-by: Ruizhe Pan <c141028@gmail.com>
Signed-off-by: Ruizhe Pan <c141028@gmail.com>
Co-developed-by: Shiqi Zhang <shiqi@isrc.iscas.ac.cn>
Signed-off-by: Shiqi Zhang <shiqi@isrc.iscas.ac.cn>
Signed-off-by: Celeste Liu <CoelacanthusHex@gmail.com>
Tested-by: Felix Yan <felixonmars@archlinux.org>
---

v1 -> v2: added explanation on why always got ENOSYS

 arch/riscv/kernel/traps.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
index f910dfccbf5d2..ccadb5ffd063c 100644
--- a/arch/riscv/kernel/traps.c
+++ b/arch/riscv/kernel/traps.c
@@ -301,6 +301,7 @@ asmlinkage __visible __trap_section void do_trap_ecall_u(struct pt_regs *regs)
 
 		regs->epc += 4;
 		regs->orig_a0 = regs->a0;
+		regs->a0 = -ENOSYS;
 
 		riscv_v_vstate_discard(regs);
 
@@ -308,8 +309,6 @@ asmlinkage __visible __trap_section void do_trap_ecall_u(struct pt_regs *regs)
 
 		if (syscall < NR_syscalls)
 			syscall_handler(regs, syscall);
-		else
-			regs->a0 = -ENOSYS;
 
 		syscall_exit_to_user_mode(regs);
 	} else {
-- 
2.41.0

