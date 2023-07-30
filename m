Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 332BF768471
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 10:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbjG3I1Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 04:27:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbjG3I1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 04:27:23 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDCEE1709
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 01:27:21 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4fe27849e6aso1527578e87.1
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 01:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690705640; x=1691310440;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+8yniXpHYJ5LlYOtJMJGlRfIyf396b9o9LmHCkYj9G0=;
        b=o/cTI5Ls2O0mo6N0cv3Y1lzwya7GUKhEWOZEp+1uxyeF8BIcFpDi/fx+VjyDUt4Zve
         kV+wrlPFqq8rHMLHlvef7fFM+cXx8pwdzBUAM4MGQrrkkGigegHRH35j6YE80rcJHlim
         xBaXZ2e7QjTw6Fzv+FE1ZnnNIvwlBMzs+WXUXkXwnTrVLeqXl/qnOmK1Lcbzz18QqMNx
         ebcfHt1kGRmfKUNWyUAFwNhnRXoPWrpXF3QdHk2V1Mqui7StMMqi/9WR82vrO6UwTVkK
         /iLx4pzINlfnok2v7OmHnYI8AGQ2mdIvB/meMwFELznrCsV1P7kCWp8Tfj5r0p8/Qrpi
         hApw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690705640; x=1691310440;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+8yniXpHYJ5LlYOtJMJGlRfIyf396b9o9LmHCkYj9G0=;
        b=BJbFi2eVvBEUlPPj64WfNfPchjJvgq/K9qll0ZqTHvaGf2yT+shvH/XzO4FBwqpUZl
         H3dpVUnJ5ywm6cM7As8Qk06qiYX3BS5yThGphLooodZrqwopsZZr+54G15DNLKGgUI1s
         4kXqmoi/HgDsHFx8BJ6E99fqyPH6tSyog2VVG9hSS/wlRk1/Nx2iX5+jnO7rjXCJbL2P
         xvs1mB5RNBQI0n5fFeoeoFSKBusWFfd5VgpTMxgGg+/v/o+s7Hk03T6pln9u8V194bT2
         cuGLCN/t9RTgD47i9Rk8t/nC6z1FR41HvdUPDPFhiW00zOVClReWTnmL9wFRMWiwuvfm
         XrjA==
X-Gm-Message-State: ABy/qLbHdlW3AllS14udT/lZtIJbSvPCsiAImB6/WOf4QF3KZmAZ5nxg
        ThURRFjmjYepgKz64tPPL8w=
X-Google-Smtp-Source: APBJJlFJTRX8mqrdX3Kt0N/6M1IBQQS0CKigxwiOWmQstL7Qprhb06BM4NCCMnmQNETsf9+3s7AgBg==
X-Received: by 2002:a05:6512:3686:b0:4fe:18be:ef47 with SMTP id d6-20020a056512368600b004fe18beef47mr3919927lfs.67.1690705639941;
        Sun, 30 Jul 2023 01:27:19 -0700 (PDT)
Received: from nam-dell (ip-217-105-46-58.ip.prioritytelecom.net. [217.105.46.58])
        by smtp.gmail.com with ESMTPSA id k16-20020aa7d8d0000000b0051e2670d599sm3861915eds.4.2023.07.30.01.27.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jul 2023 01:27:19 -0700 (PDT)
From:   Nam Cao <namcaov@gmail.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Nam Cao <namcaov@gmail.com>
Subject: [PATCH 1/3] riscv: kprobes: simulate c.j instruction
Date:   Sun, 30 Jul 2023 10:27:07 +0200
Message-Id: <6ef76cd9984b8015826649d13f870f8ac45a2d0d.1690704360.git.namcaov@gmail.com>
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

kprobes currently rejects c.j instruction. Implement it.

Signed-off-by: Nam Cao <namcaov@gmail.com>
---
 arch/riscv/kernel/probes/decode-insn.c   |  3 ++-
 arch/riscv/kernel/probes/simulate-insn.c | 24 ++++++++++++++++++++++++
 arch/riscv/kernel/probes/simulate-insn.h |  1 +
 3 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/probes/decode-insn.c b/arch/riscv/kernel/probes/decode-insn.c
index 64f6183b4717..39adb07a342d 100644
--- a/arch/riscv/kernel/probes/decode-insn.c
+++ b/arch/riscv/kernel/probes/decode-insn.c
@@ -29,13 +29,14 @@ riscv_probe_decode_insn(probe_opcode_t *addr, struct arch_probe_insn *api)
 	 * TODO: the REJECTED ones below need to be implemented
 	 */
 #ifdef CONFIG_RISCV_ISA_C
-	RISCV_INSN_REJECTED(c_j,		insn);
 	RISCV_INSN_REJECTED(c_jr,		insn);
 	RISCV_INSN_REJECTED(c_jal,		insn);
 	RISCV_INSN_REJECTED(c_jalr,		insn);
 	RISCV_INSN_REJECTED(c_beqz,		insn);
 	RISCV_INSN_REJECTED(c_bnez,		insn);
 	RISCV_INSN_REJECTED(c_ebreak,		insn);
+
+	RISCV_INSN_SET_SIMULATE(c_j,		insn);
 #endif
 
 	RISCV_INSN_SET_SIMULATE(jal,		insn);
diff --git a/arch/riscv/kernel/probes/simulate-insn.c b/arch/riscv/kernel/probes/simulate-insn.c
index 7441ac8a6843..3ba45c612cd8 100644
--- a/arch/riscv/kernel/probes/simulate-insn.c
+++ b/arch/riscv/kernel/probes/simulate-insn.c
@@ -188,3 +188,27 @@ bool __kprobes simulate_branch(u32 opcode, unsigned long addr, struct pt_regs *r
 
 	return true;
 }
+
+bool __kprobes simulate_c_j(u32 opcode, unsigned long addr, struct pt_regs *regs)
+{
+	/*
+	 *  15    13 12                            2 1      0
+	 * | funct3 | offset[11|4|9:8|10|6|7|3:1|5] | opcode |
+	 *     3                   11                    2
+	 */
+
+	s32 offset;
+
+	offset  = ((opcode >> 3)  & 0x7) << 1;
+	offset |= ((opcode >> 11) & 0x1) << 4;
+	offset |= ((opcode >> 2)  & 0x1) << 5;
+	offset |= ((opcode >> 7)  & 0x1) << 6;
+	offset |= ((opcode >> 6)  & 0x1) << 7;
+	offset |= ((opcode >> 9)  & 0x3) << 8;
+	offset |= ((opcode >> 8)  & 0x1) << 10;
+	offset |= ((opcode >> 12) & 0x1) << 11;
+
+	instruction_pointer_set(regs, addr + sign_extend32(offset, 11));
+
+	return true;
+}
diff --git a/arch/riscv/kernel/probes/simulate-insn.h b/arch/riscv/kernel/probes/simulate-insn.h
index 61e35db31001..4bd6c266e7d3 100644
--- a/arch/riscv/kernel/probes/simulate-insn.h
+++ b/arch/riscv/kernel/probes/simulate-insn.h
@@ -24,5 +24,6 @@ bool simulate_auipc(u32 opcode, unsigned long addr, struct pt_regs *regs);
 bool simulate_branch(u32 opcode, unsigned long addr, struct pt_regs *regs);
 bool simulate_jal(u32 opcode, unsigned long addr, struct pt_regs *regs);
 bool simulate_jalr(u32 opcode, unsigned long addr, struct pt_regs *regs);
+bool simulate_c_j(u32 opcode, unsigned long addr, struct pt_regs *regs);
 
 #endif /* _RISCV_KERNEL_PROBES_SIMULATE_INSN_H */
-- 
2.34.1

