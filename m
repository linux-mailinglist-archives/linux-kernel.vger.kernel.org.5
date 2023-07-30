Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC3D0768473
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 10:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbjG3I1c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 04:27:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbjG3I11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 04:27:27 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 210751709
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 01:27:25 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-522382c4840so5113894a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 01:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690705643; x=1691310443;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SimULQDdjpxXsYNdrfirKLk/fw8zuGv/egec0Yb7dzM=;
        b=Ka3V4bKaipjHIdFwBaUbvZopzCCe7cVlYdzQdNIAY9n6AyuDohH4211nmO3bbJ0Xdg
         Ur0LWW2k9uEXsnlWhaBWI0p2ybgnV00QpSTvbZoPhQyCNx5Ir2Woi0bFudpmb52ynpJk
         ePutJ+JeE0YVQuiJqkllHi9DbdxxTNI/m496ybuqV8txe4ucnSZICAFThXnLkkFYCJSh
         AEs+Yk+Uc5uz7+wFWgWiACGxsPKVM4q3vMD4/CcOk09PU+Z5e8Fvk1hCzwcZs1xhryaZ
         DnrVUhkNKibdML6rONMM386r/39VektrRLvv11bmJNfTHI65A5OEAsow8Mdnttalrr+O
         5LiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690705643; x=1691310443;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SimULQDdjpxXsYNdrfirKLk/fw8zuGv/egec0Yb7dzM=;
        b=V8IX56jvcbF3arZhLkmbsjO+ceTQ+HV+P5HOSZROyYRUzbIhyuyKVfxmaq8e2u64Zb
         waF1zmqegi956OZ1koxlTTxHOS+UosBYIlhNqIZj7PsqYCOmArAXqeD7F1RVoL8v0yBe
         uAgkZE37mRoXY9+fUJ+FjImKJqKKiX4GhOl7nSS3ceXLCr71o/a3R303eGO3aStAR3hW
         r52kH1+WBjDCPytw8ik4F1Owr7DqCSkAUJChqTyUuAybzZnkfauX8v5M8Mw/m6FRFuZM
         r24jD18OWhbcqoiDAa3CsP1BO5MgVcJyvSroQC5TxGo+ygWSKhqeUjT60hpRuR2errDy
         4rsw==
X-Gm-Message-State: ABy/qLbMJVDEIJ/ROGPtPSugIyW0He7r6tRhwncNSiLvamAAr5ohFj6M
        iyxVsu7DYGmOOOeCMf29Lfs=
X-Google-Smtp-Source: APBJJlHuYaRULyZJssvkHmCmmwoVNjfNhvOm5DYln4RYnWRjLUMNsD8+TP8VgT1J4/gKJsVzi0knqw==
X-Received: by 2002:a17:906:530e:b0:993:6845:89d6 with SMTP id h14-20020a170906530e00b00993684589d6mr4470426ejo.47.1690705643484;
        Sun, 30 Jul 2023 01:27:23 -0700 (PDT)
Received: from nam-dell (ip-217-105-46-58.ip.prioritytelecom.net. [217.105.46.58])
        by smtp.gmail.com with ESMTPSA id n16-20020a1709067b5000b009927a49ba94sm4333519ejo.169.2023.07.30.01.27.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jul 2023 01:27:23 -0700 (PDT)
From:   Nam Cao <namcaov@gmail.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Nam Cao <namcaov@gmail.com>
Subject: [PATCH 3/3] riscv: kprobes: simulate c.beqz and c.bnez
Date:   Sun, 30 Jul 2023 10:27:09 +0200
Message-Id: <1d879dba4e4ee9a82e27625d6483b5c9cfed684f.1690704360.git.namcaov@gmail.com>
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

kprobes currently rejects instruction c.beqz and c.bnez. Implement them.

Signed-off-by: Nam Cao <namcaov@gmail.com>
---
 arch/riscv/kernel/probes/decode-insn.c   |  4 +--
 arch/riscv/kernel/probes/simulate-insn.c | 44 ++++++++++++++++++++++++
 arch/riscv/kernel/probes/simulate-insn.h |  2 ++
 3 files changed, 48 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/kernel/probes/decode-insn.c b/arch/riscv/kernel/probes/decode-insn.c
index 6dba23a55ac7..65d9590bfb9f 100644
--- a/arch/riscv/kernel/probes/decode-insn.c
+++ b/arch/riscv/kernel/probes/decode-insn.c
@@ -30,13 +30,13 @@ riscv_probe_decode_insn(probe_opcode_t *addr, struct arch_probe_insn *api)
 	 */
 #ifdef CONFIG_RISCV_ISA_C
 	RISCV_INSN_REJECTED(c_jal,		insn);
-	RISCV_INSN_REJECTED(c_beqz,		insn);
-	RISCV_INSN_REJECTED(c_bnez,		insn);
 	RISCV_INSN_REJECTED(c_ebreak,		insn);
 
 	RISCV_INSN_SET_SIMULATE(c_j,		insn);
 	RISCV_INSN_SET_SIMULATE(c_jr,		insn);
 	RISCV_INSN_SET_SIMULATE(c_jalr,		insn);
+	RISCV_INSN_SET_SIMULATE(c_beqz,		insn);
+	RISCV_INSN_SET_SIMULATE(c_bnez,		insn);
 #endif
 
 	RISCV_INSN_SET_SIMULATE(jal,		insn);
diff --git a/arch/riscv/kernel/probes/simulate-insn.c b/arch/riscv/kernel/probes/simulate-insn.c
index 1ead6f4951f9..d3099d67816d 100644
--- a/arch/riscv/kernel/probes/simulate-insn.c
+++ b/arch/riscv/kernel/probes/simulate-insn.c
@@ -249,3 +249,47 @@ bool __kprobes simulate_c_jalr(u32 opcode, unsigned long addr, struct pt_regs *r
 {
 	return simulate_c_jr_jalr(opcode, addr, regs, true);
 }
+
+static bool __kprobes simulate_c_bnez_beqz(u32 opcode, unsigned long addr, struct pt_regs *regs,
+					   bool is_bnez)
+{
+	/*
+	 *  15    13 12           10 9    7 6                 2 1  0
+	 * | funct3 | offset[8|4:3] | rs1' | offset[7:6|2:1|5] | op |
+	 *     3            3          3             5           2
+	 */
+
+	s32 offset;
+	u32 rs1;
+	unsigned long rs1_val;
+
+	rs1 = 0x8 | ((opcode >> 7) & 0x7);
+
+	if (!rv_insn_reg_get_val(regs, rs1, &rs1_val))
+		return false;
+
+	if ((rs1_val != 0 && is_bnez) || (rs1_val == 0 && !is_bnez)) {
+		offset =  ((opcode >> 3)  & 0x3) << 1;
+		offset |= ((opcode >> 10) & 0x3) << 3;
+		offset |= ((opcode >> 2)  & 0x1) << 5;
+		offset |= ((opcode >> 5)  & 0x3) << 6;
+		offset |= ((opcode >> 12) & 0x1) << 8;
+		offset = sign_extend32(offset, 8);
+	} else {
+		offset = 2;
+	}
+
+	instruction_pointer_set(regs, addr + offset);
+
+	return true;
+}
+
+bool __kprobes simulate_c_bnez(u32 opcode, unsigned long addr, struct pt_regs *regs)
+{
+	return simulate_c_bnez_beqz(opcode, addr, regs, true);
+}
+
+bool __kprobes simulate_c_beqz(u32 opcode, unsigned long addr, struct pt_regs *regs)
+{
+	return simulate_c_bnez_beqz(opcode, addr, regs, false);
+}
diff --git a/arch/riscv/kernel/probes/simulate-insn.h b/arch/riscv/kernel/probes/simulate-insn.h
index 472a1948ec4f..44ebbc444db9 100644
--- a/arch/riscv/kernel/probes/simulate-insn.h
+++ b/arch/riscv/kernel/probes/simulate-insn.h
@@ -27,5 +27,7 @@ bool simulate_jalr(u32 opcode, unsigned long addr, struct pt_regs *regs);
 bool simulate_c_j(u32 opcode, unsigned long addr, struct pt_regs *regs);
 bool simulate_c_jr(u32 opcode, unsigned long addr, struct pt_regs *regs);
 bool simulate_c_jalr(u32 opcode, unsigned long addr, struct pt_regs *regs);
+bool simulate_c_bnez(u32 opcode, unsigned long addr, struct pt_regs *regs);
+bool simulate_c_beqz(u32 opcode, unsigned long addr, struct pt_regs *regs);
 
 #endif /* _RISCV_KERNEL_PROBES_SIMULATE_INSN_H */
-- 
2.34.1

