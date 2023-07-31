Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E59B76A081
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 20:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231484AbjGaSji (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 14:39:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbjGaSjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 14:39:36 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28D759E
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 11:39:35 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-5222a38c0a0so7172449a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 11:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690828773; x=1691433573;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YeAGwgVyMXcNXeTFVIAMcPWnhWeRTG8FbEAKWB4lruA=;
        b=QXD623Lbsq+bP6iSgF9CXctMwS5P/KiKpYWKe7j23oIM9baaN5RfkgJAUxLwDOqOKy
         cbL9gIWdiD/ZFFvHs9xiC5SC6eKPdrETuDtKpzuwLxEZB3BYvh15LHJ/tBY/Jrr8z+i1
         bT07b9OkoIGk3VmSlKMVIP0jsmOemjLmZuwoT052zYTOsMEzEpaFOqX0jascwtBSwO3E
         Zks+RwHjv9fu1rlkr1rfrBtAk4mQkHD3MhoLR9eY2BuWOWtlhwxaMGn/D/T2x8JFww1O
         bgZwCpowmr5o0tqfjmGR0rMm24AOrLh1IvPY1ps3N7x1iDLosRbGKYg+DnsJKzMM85j9
         WC2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690828773; x=1691433573;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YeAGwgVyMXcNXeTFVIAMcPWnhWeRTG8FbEAKWB4lruA=;
        b=lv7+mlM6Kt7L6X79m1uGoC6Mhh8eyA2oekFutR+r1eTC+WNdME3sLuFs7iP1UikS0G
         ItGFPsAYoDQQPcy0oz/faPqwdaymalq8UdWUCV1EyQ558Dv/84jU65bxwQ83mr+RDw17
         6yLI0JK+H33l4ykbVFkv0iNaAMkRIjD7Ju+vfTlAYv8WHLRxVX6I3ADLFnW/Ml+1imqQ
         nhn1kj+N1LjNonGG5XAQEQPl7BzdYd8An4+eXXfAcB5yI172nZzFUAjH8ELQWHYfFFjF
         1ZfyGm/rdb4N7dvquPdw2HkDHcqdwMI8Gk78Xs7NHvDc31jufVFmILy2whjFR4D/PKnF
         684g==
X-Gm-Message-State: ABy/qLabE6ritOSYsvJk8Kt0JyPICTuvfLSEW2E8RC7Ks1FiLcKOL6r0
        OwLBon0pRH1iInIAHTH1mpVvSEID5nk4KQ==
X-Google-Smtp-Source: APBJJlHqZRzVIf0Z+xYOeJXTN/WJo2hTQPlEBaTRlnHgdOvgxP2YfI82UfOkdY1lriZt1Zq6V9XcRQ==
X-Received: by 2002:aa7:dd13:0:b0:521:7ab6:b95d with SMTP id i19-20020aa7dd13000000b005217ab6b95dmr549698edv.29.1690828773383;
        Mon, 31 Jul 2023 11:39:33 -0700 (PDT)
Received: from nam-dell (ip-217-105-46-58.ip.prioritytelecom.net. [217.105.46.58])
        by smtp.gmail.com with ESMTPSA id c7-20020aa7c747000000b0052237839229sm5772031eds.21.2023.07.31.11.39.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 11:39:32 -0700 (PDT)
From:   Nam Cao <namcaov@gmail.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Nam Cao <namcaov@gmail.com>
Subject: [PATCH] riscv: correct riscv_insn_is_c_jr() and riscv_insn_is_c_jalr()
Date:   Mon, 31 Jul 2023 20:39:25 +0200
Message-Id: <20230731183925.152145-1-namcaov@gmail.com>
X-Mailer: git-send-email 2.34.1
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

The instructions c.jr and c.jalr must have rs1 != 0, but
riscv_insn_is_c_jr() and riscv_insn_is_c_jalr() do not check for this. So,
riscv_insn_is_c_jr() can match a reserved encoding, while
riscv_insn_is_c_jalr() can match the c.ebreak instruction.

Rewrite them with check for rs1 != 0.

Signed-off-by: Nam Cao <namcaov@gmail.com>
---
 arch/riscv/include/asm/insn.h | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/include/asm/insn.h b/arch/riscv/include/asm/insn.h
index 4e1505cef8aa..fce00400c9bc 100644
--- a/arch/riscv/include/asm/insn.h
+++ b/arch/riscv/include/asm/insn.h
@@ -110,6 +110,7 @@
 #define RVC_INSN_FUNCT4_OPOFF	12
 #define RVC_INSN_FUNCT3_MASK	GENMASK(15, 13)
 #define RVC_INSN_FUNCT3_OPOFF	13
+#define RVC_INSN_J_RS1_MASK	GENMASK(11, 7)
 #define RVC_INSN_J_RS2_MASK	GENMASK(6, 2)
 #define RVC_INSN_OPCODE_MASK	GENMASK(1, 0)
 #define RVC_ENCODE_FUNCT3(f_)	(RVC_FUNCT3_##f_ << RVC_INSN_FUNCT3_OPOFF)
@@ -245,8 +246,6 @@ __RISCV_INSN_FUNCS(c_jal, RVC_MASK_C_JAL, RVC_MATCH_C_JAL)
 __RISCV_INSN_FUNCS(auipc, RVG_MASK_AUIPC, RVG_MATCH_AUIPC)
 __RISCV_INSN_FUNCS(jalr, RVG_MASK_JALR, RVG_MATCH_JALR)
 __RISCV_INSN_FUNCS(jal, RVG_MASK_JAL, RVG_MATCH_JAL)
-__RISCV_INSN_FUNCS(c_jr, RVC_MASK_C_JR, RVC_MATCH_C_JR)
-__RISCV_INSN_FUNCS(c_jalr, RVC_MASK_C_JALR, RVC_MATCH_C_JALR)
 __RISCV_INSN_FUNCS(c_j, RVC_MASK_C_J, RVC_MATCH_C_J)
 __RISCV_INSN_FUNCS(beq, RVG_MASK_BEQ, RVG_MATCH_BEQ)
 __RISCV_INSN_FUNCS(bne, RVG_MASK_BNE, RVG_MATCH_BNE)
@@ -273,6 +272,18 @@ static __always_inline bool riscv_insn_is_branch(u32 code)
 	return (code & RV_INSN_OPCODE_MASK) == RVG_OPCODE_BRANCH;
 }
 
+static __always_inline bool riscv_insn_is_c_jr(u32 code)
+{
+	return (code & RVC_MASK_C_JR) == RVC_MATCH_C_JR &&
+	       (code & RVC_INSN_J_RS1_MASK) != 0;
+}
+
+static __always_inline bool riscv_insn_is_c_jalr(u32 code)
+{
+	return (code & RVC_MASK_C_JALR) == RVC_MATCH_C_JALR &&
+	       (code & RVC_INSN_J_RS1_MASK) != 0;
+}
+
 #define RV_IMM_SIGN(x) (-(((x) >> 31) & 1))
 #define RVC_IMM_SIGN(x) (-(((x) >> 12) & 1))
 #define RV_X(X, s, mask)  (((X) >> (s)) & (mask))
-- 
2.34.1

