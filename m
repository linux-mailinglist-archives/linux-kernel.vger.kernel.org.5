Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F27B768472
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 10:27:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbjG3I11 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 04:27:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbjG3I1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 04:27:25 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A208010FF
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 01:27:23 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-99bdf08860dso615375166b.0
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 01:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690705642; x=1691310442;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vN0J3GV61DkjP0ahWmkHwTyaQTvoRppASb5qgqqzbjw=;
        b=YZ2PPNBg6wWWnGRDU+wNzK5MoU3WKBPc9bVBjoUVTHI40uNXcmzZbmcbHV/KePlTAA
         AvBLFvCrTMZr49yldYsyTtHx5WeF60pgvz27lPOQgW4mVziCjoiwqLLqE9sw6s88Eu8q
         wazoKoBUdGEmiu9gptXikAzNwam/aXa8cYvusmmzBQozVt17FXPHU8oGcZMvjf63r3wE
         S1EvUfy74hilsMM5ZmtGoutxXKH+RtveolpjldW+9ZONd1ESlxIIaj+HNpFCEDgEQMOp
         Yfh7PFJNxyTOWkuQ2KNS4zA+6sbc7NXFBRQgbk0atwu0WxWLY0qOPzPc3AtxIeehAFrS
         t+Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690705642; x=1691310442;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vN0J3GV61DkjP0ahWmkHwTyaQTvoRppASb5qgqqzbjw=;
        b=VRHYCYwe9eKLvPnRBJ9J5xcm5LvOLZu3ph3kYzVclvrl/CjHbBu7BsnRtLUky9tYNW
         q2Lou2cTUn8pkNBZ5yzYvuilRBN/VOMQq8hlPiKKVpZdxzMVX6mboQ8hLLBBWK9D8auc
         m+xFc9E/WS0klBaTEK50NcA7CCI8fyRQEXdOaYZS40163jlIKj3oIUSOUHojbNmfhcpx
         94et26uQRXrRQq58tmzKq4ix4JZdmAERy8SRUH49j1KJZEfX8wCbPyS0/j1U2VceQAS8
         nplyM0cUkggxPPg9wQxW0V53UPZ788Faly+MEKBuFLUtye4YFmmCleOMCIwILIrw4A3S
         Bshw==
X-Gm-Message-State: ABy/qLYQUMkWJYO/awpIQl8C5+Kgrx/Jso6JvL50fc9c6KgNHo/le4MK
        P76oLNUVLy5P9CtXoCF+Lws=
X-Google-Smtp-Source: APBJJlGNq1tfaMiD7YOayjCJR0VBHsHKj+FG19g87epOYJbJwj4g1BG7lyZFx5qqyHX0lkQVKOG+sg==
X-Received: by 2002:a17:906:8441:b0:98e:2413:952f with SMTP id e1-20020a170906844100b0098e2413952fmr4407133ejy.18.1690705642114;
        Sun, 30 Jul 2023 01:27:22 -0700 (PDT)
Received: from nam-dell (ip-217-105-46-58.ip.prioritytelecom.net. [217.105.46.58])
        by smtp.gmail.com with ESMTPSA id qk29-20020a170906d9dd00b0098e34446464sm4327706ejb.25.2023.07.30.01.27.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jul 2023 01:27:21 -0700 (PDT)
From:   Nam Cao <namcaov@gmail.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Nam Cao <namcaov@gmail.com>
Subject: [PATCH 2/3] riscv: kprobes: simulate c.jr and c.jalr instructions
Date:   Sun, 30 Jul 2023 10:27:08 +0200
Message-Id: <db8b7787e9208654cca50484f68334f412be2ea9.1690704360.git.namcaov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1690704360.git.namcaov@gmail.com>
References: <cover.1690704360.git.namcaov@gmail.com>
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

kprobes currently rejects c.jr and c.jalr instructions. Implement them.

Signed-off-by: Nam Cao <namcaov@gmail.com>
---
 arch/riscv/kernel/probes/decode-insn.c   |  4 +--
 arch/riscv/kernel/probes/simulate-insn.c | 37 ++++++++++++++++++++++++
 arch/riscv/kernel/probes/simulate-insn.h |  2 ++
 3 files changed, 41 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/kernel/probes/decode-insn.c b/arch/riscv/kernel/probes/decode-insn.c
index 39adb07a342d..6dba23a55ac7 100644
--- a/arch/riscv/kernel/probes/decode-insn.c
+++ b/arch/riscv/kernel/probes/decode-insn.c
@@ -29,14 +29,14 @@ riscv_probe_decode_insn(probe_opcode_t *addr, struct arch_probe_insn *api)
 	 * TODO: the REJECTED ones below need to be implemented
 	 */
 #ifdef CONFIG_RISCV_ISA_C
-	RISCV_INSN_REJECTED(c_jr,		insn);
 	RISCV_INSN_REJECTED(c_jal,		insn);
-	RISCV_INSN_REJECTED(c_jalr,		insn);
 	RISCV_INSN_REJECTED(c_beqz,		insn);
 	RISCV_INSN_REJECTED(c_bnez,		insn);
 	RISCV_INSN_REJECTED(c_ebreak,		insn);
 
 	RISCV_INSN_SET_SIMULATE(c_j,		insn);
+	RISCV_INSN_SET_SIMULATE(c_jr,		insn);
+	RISCV_INSN_SET_SIMULATE(c_jalr,		insn);
 #endif
 
 	RISCV_INSN_SET_SIMULATE(jal,		insn);
diff --git a/arch/riscv/kernel/probes/simulate-insn.c b/arch/riscv/kernel/probes/simulate-insn.c
index 3ba45c612cd8..1ead6f4951f9 100644
--- a/arch/riscv/kernel/probes/simulate-insn.c
+++ b/arch/riscv/kernel/probes/simulate-insn.c
@@ -212,3 +212,40 @@ bool __kprobes simulate_c_j(u32 opcode, unsigned long addr, struct pt_regs *regs
 
 	return true;
 }
+
+static bool __kprobes simulate_c_jr_jalr(u32 opcode, unsigned long addr, struct pt_regs *regs,
+					 bool is_jalr)
+{
+	/*
+	 *  15    12 11  7 6   2 1  0
+	 * | funct4 | rs1 | rs2 | op |
+	 *     4       5     5    2
+	 */
+
+	unsigned long jump_addr;
+
+	u32 rs1 = (opcode >> 7) & 0x1f;
+
+	if (rs1 == 0) /* C.JR is only valid when rs1 != x0 */
+		return false;
+
+	if (!rv_insn_reg_get_val(regs, rs1, &jump_addr))
+		return false;
+
+	if (is_jalr && !rv_insn_reg_set_val(regs, 1, addr + 2))
+		return false;
+
+	instruction_pointer_set(regs, jump_addr);
+
+	return true;
+}
+
+bool __kprobes simulate_c_jr(u32 opcode, unsigned long addr, struct pt_regs *regs)
+{
+	return simulate_c_jr_jalr(opcode, addr, regs, false);
+}
+
+bool __kprobes simulate_c_jalr(u32 opcode, unsigned long addr, struct pt_regs *regs)
+{
+	return simulate_c_jr_jalr(opcode, addr, regs, true);
+}
diff --git a/arch/riscv/kernel/probes/simulate-insn.h b/arch/riscv/kernel/probes/simulate-insn.h
index 4bd6c266e7d3..472a1948ec4f 100644
--- a/arch/riscv/kernel/probes/simulate-insn.h
+++ b/arch/riscv/kernel/probes/simulate-insn.h
@@ -25,5 +25,7 @@ bool simulate_branch(u32 opcode, unsigned long addr, struct pt_regs *regs);
 bool simulate_jal(u32 opcode, unsigned long addr, struct pt_regs *regs);
 bool simulate_jalr(u32 opcode, unsigned long addr, struct pt_regs *regs);
 bool simulate_c_j(u32 opcode, unsigned long addr, struct pt_regs *regs);
+bool simulate_c_jr(u32 opcode, unsigned long addr, struct pt_regs *regs);
+bool simulate_c_jalr(u32 opcode, unsigned long addr, struct pt_regs *regs);
 
 #endif /* _RISCV_KERNEL_PROBES_SIMULATE_INSN_H */
-- 
2.34.1

