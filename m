Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26BFE78A1B8
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 23:06:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbjH0VGT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 17:06:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbjH0VF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 17:05:58 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 347BE12D
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 14:05:56 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-401b393ddd2so24444295e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 14:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693170354; x=1693775154;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GJAK2lEo2Ushg+QTBvqS02TVMVDEl0y6m3BBQOKXzGM=;
        b=FopJmSg7ZXozcyNB81zsjPNDv5AbQ9Ya0jOuSJcY0GLmMSsEpwREdij13eT186ZdWo
         IqMmJViX0DgTZfr7I5rRz6uN4nAG7DexDjeWzmcjIWOhH5jGL4mzHCSFyKDyCv5ib/PO
         2XLf0/szlthiHRdTgbsS13jo6FSjZDgmx4JjbJa1oUVAwghZZOmlrN3tatpamsmThu91
         ZdeSl/e/ayQO3VUjt95AM0uwKRAi2agjB+lIZgv0ceRUAgohi51TAn/wn14iMRw07PI+
         EKwW1MstpvEKeYGIV/Mon71W+VW+nQOyPb80iPUH/UPsHTJFFz6FxEwABgkES1wMJHHc
         6oMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693170354; x=1693775154;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GJAK2lEo2Ushg+QTBvqS02TVMVDEl0y6m3BBQOKXzGM=;
        b=O9Xz1jOgaH+RvgIZZoQhL2V8tcMUNOETywgUSCkzOlUVoCWMI8k18UKZOhYSktr9SA
         jMQpOT3O+w8+pwepQBnA51oI4zSakidcIBK/1NgqKeObN6AnB5JnDTLwJEF5fBwBw8Kj
         CTDD4ctUCDGGq3/pJ2aK6HR2y0333J1+/IKj4YvBkf8L1WR1mUd8hAF40cbs3SSjDwjA
         AU10uEuOjGpvKLhHgjacTX8frCxBGbaMuGkGQwtkxUOJTKRLyEDrVVk1TFt95BO9NHWb
         WdXhDfln4DLp8ayplxFwonWreOFgfWqp/ThX4AQ2rWeyS8vNlXre1TwmUdDrCjqD05LC
         t5ew==
X-Gm-Message-State: AOJu0YyWvuzY8I330asxcA9FZf9zfHYdOSH2PL4WtYEc+3CdUagB/ax5
        YuG02n+9rWfSpCs127CRWIxTONYSceo=
X-Google-Smtp-Source: AGHT+IHP5M1qiNTQZpm6LuN89GbfBfpH51fArtUnAdfRI5sTiMPPAGKYSQphLdCYxaxDZABFQSyEUg==
X-Received: by 2002:a17:907:a05c:b0:9a1:bd53:b23 with SMTP id gz28-20020a170907a05c00b009a1bd530b23mr12148538ejc.14.1693169811749;
        Sun, 27 Aug 2023 13:56:51 -0700 (PDT)
Received: from nam-dell (ip-217-105-46-58.ip.prioritytelecom.net. [217.105.46.58])
        by smtp.gmail.com with ESMTPSA id z3-20020a1709064e0300b009a19fa8d2e9sm3799181eju.206.2023.08.27.13.56.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Aug 2023 13:56:51 -0700 (PDT)
From:   Nam Cao <namcaov@gmail.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        bjorn@kernel.org, guoren@kernel.org
Cc:     Nam Cao <namcaov@gmail.com>
Subject: [PATCH] riscv: provide riscv-specific is_trap_insn()
Date:   Sun, 27 Aug 2023 22:56:41 +0200
Message-Id: <20230827205641.46836-1-namcaov@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

uprobes expects is_trap_insn() to return true for any trap instructions,
not just the one used for installing uprobe. The current default
implementation only returns true for 16-bit c.ebreak if C extension is
enabled. This can confuse uprobes if a 32-bit ebreak generates a trap
exception from userspace: uprobes asks is_trap_insn() who says there is no
trap, so uprobes assume a probe was there before but has been removed, and
return to the trap instruction. This cause an infinite loop of entering
and exiting trap handler.

Instead of using the default implementation, implement this function
speficially for riscv which checks for both ebreak and c.ebreak.

Fixes: 74784081aac8 ("riscv: Add uprobes supported")
Signed-off-by: Nam Cao <namcaov@gmail.com>
---
 arch/riscv/kernel/probes/uprobes.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/riscv/kernel/probes/uprobes.c b/arch/riscv/kernel/probes/uprobes.c
index 194f166b2cc4..91f4ce101cd1 100644
--- a/arch/riscv/kernel/probes/uprobes.c
+++ b/arch/riscv/kernel/probes/uprobes.c
@@ -3,6 +3,7 @@
 #include <linux/highmem.h>
 #include <linux/ptrace.h>
 #include <linux/uprobes.h>
+#include <asm/insn.h>
 
 #include "decode-insn.h"
 
@@ -17,6 +18,15 @@ bool is_swbp_insn(uprobe_opcode_t *insn)
 #endif
 }
 
+bool is_trap_insn(uprobe_opcode_t *insn)
+{
+#ifdef CONFIG_RISCV_ISA_C
+	if (riscv_insn_is_c_ebreak(*insn))
+		return true;
+#endif
+	return riscv_insn_is_ebreak(*insn);
+}
+
 unsigned long uprobe_get_swbp_addr(struct pt_regs *regs)
 {
 	return instruction_pointer(regs);
-- 
2.34.1

