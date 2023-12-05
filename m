Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26856804D04
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 10:00:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234865AbjLEJAG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 04:00:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234860AbjLEJAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 04:00:01 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57401184
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 01:00:05 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1d04c097e34so29954765ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 01:00:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1701766804; x=1702371604; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wi6K2Brpiu9Fka3m9z0bXgXfpslNvz1u3mb0b6dJW6o=;
        b=m544HOAuNFcIu+ul2XhWjOVdgMp4Ozi4RmvgDecZb0y12mlA8Vek9manj1OR2nm44J
         GYDQyGHXvEUANx3ha22Bii8l0rBDL9hr9n3vlBmiH6pSW/Uu+JmRP4M0e6aoI+n3jtio
         q8p4J1/pAQlbtXgLTEXkwaLo+Z5/zCxo5aOtyhAXKZnPOt97RsXQ9dTSn831Sg4WzRlg
         WrPBlKpLwM2rqQaSV1NbtwhiACufxIgAU/N1hMQK02liHQxVBii41Dw4wDQl99Fdtj6z
         iANx+dB52azxEIbzjnVE+XH5kdT7lqLRhlHr1U/k2XQmnVFBMEH+cX9XbJWOTuG6rQiy
         QsKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701766804; x=1702371604;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wi6K2Brpiu9Fka3m9z0bXgXfpslNvz1u3mb0b6dJW6o=;
        b=G26V+ek9L5wUXUWwiBtrhAfFOUnPT8a24qJpB2iDwh8RDhhApPzadS9Rqdr3xBW2ve
         bpejDk9NyKhGzi6oUGTe//Wy47Dip9jy0WOoJmQTI4q6/Uh5cYQY1DMYQ5PQmdBKjpHo
         kzY4E1bpb9hcLZRq+2/qwS8YMKDNfGMZWtvRq5XkOE9gYtY8loeeXJACl8oqv6a8X/48
         B4yzurNPoO8t0BKZN3A7L3f+CFI12bQoSNav5YmJYfjr1NTG0K/UoWAE9ZRv0P2XGlSU
         qK6oEjAynLrkv9Mt24vjjS5IgANmmBrnBuTpyM8kVK8DhzgHu8HB2JZEfYjpk0wIQhF7
         L6Uw==
X-Gm-Message-State: AOJu0YzszvdBryRmPlDdDx8pGLLnYvOtrsdlqV8MSOOLI4wFOFOI0ohS
        cuFEqIP0ooyyoTxCT+cFPX01YA==
X-Google-Smtp-Source: AGHT+IGyFPsKcbZnXk366DYq/es2JWb3tJA7eqKSX6IfX54Hcco/J4PuKhtkOuzGVLlbAyicuyZl5Q==
X-Received: by 2002:a17:902:ecca:b0:1cf:f868:5b8c with SMTP id a10-20020a170902ecca00b001cff8685b8cmr1228712plh.8.1701766804259;
        Tue, 05 Dec 2023 01:00:04 -0800 (PST)
Received: from hsinchu26.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id q1-20020a17090311c100b001cfc9c926b7sm6134629plh.75.2023.12.05.01.00.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 01:00:04 -0800 (PST)
From:   Zong Li <zong.li@sifive.com>
To:     palmer@dabbelt.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Zong Li <zong.li@sifive.com>
Subject: [PATCH] riscv: add CALLER_ADDRx support
Date:   Tue,  5 Dec 2023 08:59:59 +0000
Message-Id: <20231205085959.32177-1-zong.li@sifive.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CALLER_ADDRx returns caller's address at specified level, they are used
for several tracers. These macros eventually use
__builtin_return_address(n) to get the caller's address if arch doesn't
define their own implementation.

In RISC-V, __builtin_return_address(n) only works when n == 0, we need
to walk the stack frame to get the caller's address at specified level.

data.level started from 'level + 3' due to the call flow of getting
caller's address in RISC-V implementation. If we don't have additional
three iteration, the level is corresponding to follows:

callsite -> return_address -> arch_stack_walk -> walk_stackframe
|           |                 |                  |
level 3     level 2           level 1            level 0

Signed-off-by: Zong Li <zong.li@sifive.com>
---
 arch/riscv/include/asm/ftrace.h    |  5 ++++
 arch/riscv/kernel/Makefile         |  2 ++
 arch/riscv/kernel/return_address.c | 48 ++++++++++++++++++++++++++++++
 3 files changed, 55 insertions(+)
 create mode 100644 arch/riscv/kernel/return_address.c

diff --git a/arch/riscv/include/asm/ftrace.h b/arch/riscv/include/asm/ftrace.h
index 2b2f5df7ef2c..42777f91a9c5 100644
--- a/arch/riscv/include/asm/ftrace.h
+++ b/arch/riscv/include/asm/ftrace.h
@@ -25,6 +25,11 @@
 
 #define ARCH_SUPPORTS_FTRACE_OPS 1
 #ifndef __ASSEMBLY__
+
+extern void *return_address(unsigned int level);
+
+#define ftrace_return_address(n) return_address(n)
+
 void MCOUNT_NAME(void);
 static inline unsigned long ftrace_call_adjust(unsigned long addr)
 {
diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
index fee22a3d1b53..40d054939ae2 100644
--- a/arch/riscv/kernel/Makefile
+++ b/arch/riscv/kernel/Makefile
@@ -7,6 +7,7 @@ ifdef CONFIG_FTRACE
 CFLAGS_REMOVE_ftrace.o	= $(CC_FLAGS_FTRACE)
 CFLAGS_REMOVE_patch.o	= $(CC_FLAGS_FTRACE)
 CFLAGS_REMOVE_sbi.o	= $(CC_FLAGS_FTRACE)
+CFLAGS_REMOVE_return_address.o	= $(CC_FLAGS_FTRACE)
 endif
 CFLAGS_syscall_table.o	+= $(call cc-option,-Wno-override-init,)
 CFLAGS_compat_syscall_table.o += $(call cc-option,-Wno-override-init,)
@@ -46,6 +47,7 @@ obj-y	+= irq.o
 obj-y	+= process.o
 obj-y	+= ptrace.o
 obj-y	+= reset.o
+obj-y	+= return_address.o
 obj-y	+= setup.o
 obj-y	+= signal.o
 obj-y	+= syscall_table.o
diff --git a/arch/riscv/kernel/return_address.c b/arch/riscv/kernel/return_address.c
new file mode 100644
index 000000000000..c2008d4aa6e5
--- /dev/null
+++ b/arch/riscv/kernel/return_address.c
@@ -0,0 +1,48 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * This code come from arch/arm64/kernel/return_address.c
+ *
+ * Copyright (C) 2023 SiFive.
+ */
+
+#include <linux/export.h>
+#include <linux/kprobes.h>
+#include <linux/stacktrace.h>
+
+struct return_address_data {
+	unsigned int level;
+	void *addr;
+};
+
+static bool save_return_addr(void *d, unsigned long pc)
+{
+	struct return_address_data *data = d;
+
+	if (!data->level) {
+		data->addr = (void *)pc;
+		return false;
+	}
+
+	--data->level;
+
+	return true;
+}
+NOKPROBE_SYMBOL(save_return_addr);
+
+void *return_address(unsigned int level)
+{
+	struct return_address_data data;
+
+	data.level = level + 3;
+	data.addr = NULL;
+
+	arch_stack_walk(save_return_addr, &data, current, NULL);
+
+	if (!data.level)
+		return data.addr;
+	else
+		return NULL;
+
+}
+EXPORT_SYMBOL_GPL(return_address);
+NOKPROBE_SYMBOL(return_address);
-- 
2.17.1

