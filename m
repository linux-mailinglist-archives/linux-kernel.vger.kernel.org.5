Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4FA17E00FE
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 11:30:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346539AbjKCJCh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 05:02:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235199AbjKCJCe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 05:02:34 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05108187
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 02:02:30 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-408ffb55b35so1268305e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Nov 2023 02:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1699002148; x=1699606948; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=m+1tHEC+sLfsTYbEucEalWJbhmfqSui8PoKCdZjk+zI=;
        b=R1sdotQXKXwyUl2ag7nUS6FPVHY8dLkh33PXzlL12EZsA64ZK9d6b6F1I0p3IEhI00
         wP/RPRSDQ9iFCHvtt+K/eF8R8GPF7BAB/ptg00o+uNhFDw2eHZJOwfmuApr+kH1z0gys
         A++HmbCFETHfBLqcZA0ADkJ9aawi6otrRX69KcCAfBTv8Z1h02xnaeaIbLUZdox58zwe
         IcgmkEYkrjsegUGWWvwR+1SZMsGorHV+yFRXlR3vsESEDvSRE82Et1g/X3lArPKBNPEu
         CUnkn/dqgJIYaG1xxYw6hacWXMFzxsrPO8QQKLJ4Mcb2wq1kgJr5mN+BX8daivQnB8Ub
         1WEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699002148; x=1699606948;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m+1tHEC+sLfsTYbEucEalWJbhmfqSui8PoKCdZjk+zI=;
        b=T2LpKt0GMLjOCrysXRhPpoJD+n/Xd35Tt5pIho/YHeEHdoA/NtL5eAMVBJxHt8uvAJ
         sEZXJkduD0HJLB56C74hA+eESygIe141m5si0fd25l5rIjEa8Oe6MCs3cuBvaYJzL7+H
         QaOpM5jwLeDfPkJF/tI+fSh7I5Qsa9H9nsL1ia6igYx6gOmCe3wQF3N5qHARCGPjyrhs
         4eUaWQXcFlCkb+HsFyzfweNSduf7tl9ckcKvQNwmcQxmmy9UVvCiQX/yDNqfUjR1dPWD
         lN5T+SaUB9uzA0NJRAgOUYs9A3cDTzop5u65Oa/ou57MjvWq2vwOWFeK4HDLgolJr6xw
         TBsQ==
X-Gm-Message-State: AOJu0YycucCh7dMggQL8dwxkPYl9YJqhLiDwRmJODl0+Yhc0qs6X5r15
        4WLKqOlvHPYYgkSa38C8sHgOiA==
X-Google-Smtp-Source: AGHT+IEUKIxfzHqdx0bBHDfjL1JpFeGuQKT+ZUC9qvVxD+L3bcl3Xt888YkC73FNzyQScI+PUg41eQ==
X-Received: by 2002:a05:600c:1c21:b0:401:7d3b:cc84 with SMTP id j33-20020a05600c1c2100b004017d3bcc84mr16977354wms.0.1699002148251;
        Fri, 03 Nov 2023 02:02:28 -0700 (PDT)
Received: from carbon-x1.home (2a01cb008a4f7000834139aab36b6ffb.ipv6.abo.wanadoo.fr. [2a01:cb00:8a4f:7000:8341:39aa:b36b:6ffb])
        by smtp.gmail.com with ESMTPSA id m21-20020a056000175500b0032326908972sm1346558wrf.17.2023.11.03.02.02.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Nov 2023 02:02:27 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
Subject: [PATCH] riscv: fix misaligned access handling of C.SWSP and C.SDSP
Date:   Fri,  3 Nov 2023 10:02:23 +0100
Message-ID: <20231103090223.702340-1-cleger@rivosinc.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a backport of a fix that was done in OpenSBI: ec0559eb315b
("lib: sbi_misaligned_ldst: Fix handling of C.SWSP and C.SDSP").

Unlike C.LWSP/C.LDSP, these encodings can be used with the zero
register, so checking that the rs2 field is non-zero is unnecessary.

Additionally, the previous check was incorrect since it was checking
the immediate field of the instruction instead of the rs2 field.

Fixes: 956d705dd279 ("riscv: Unaligned load/store handling for M_MODE")
Signed-off-by: Clément Léger <cleger@rivosinc.com>
---
 arch/riscv/kernel/traps_misaligned.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/kernel/traps_misaligned.c b/arch/riscv/kernel/traps_misaligned.c
index 378f5b151443..5348d842c745 100644
--- a/arch/riscv/kernel/traps_misaligned.c
+++ b/arch/riscv/kernel/traps_misaligned.c
@@ -342,16 +342,14 @@ int handle_misaligned_store(struct pt_regs *regs)
 	} else if ((insn & INSN_MASK_C_SD) == INSN_MATCH_C_SD) {
 		len = 8;
 		val.data_ulong = GET_RS2S(insn, regs);
-	} else if ((insn & INSN_MASK_C_SDSP) == INSN_MATCH_C_SDSP &&
-		   ((insn >> SH_RD) & 0x1f)) {
+	} else if ((insn & INSN_MASK_C_SDSP) == INSN_MATCH_C_SDSP) {
 		len = 8;
 		val.data_ulong = GET_RS2C(insn, regs);
 #endif
 	} else if ((insn & INSN_MASK_C_SW) == INSN_MATCH_C_SW) {
 		len = 4;
 		val.data_ulong = GET_RS2S(insn, regs);
-	} else if ((insn & INSN_MASK_C_SWSP) == INSN_MATCH_C_SWSP &&
-		   ((insn >> SH_RD) & 0x1f)) {
+	} else if ((insn & INSN_MASK_C_SWSP) == INSN_MATCH_C_SWSP) {
 		len = 4;
 		val.data_ulong = GET_RS2C(insn, regs);
 	} else {
-- 
2.42.0

