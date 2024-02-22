Return-Path: <linux-kernel+bounces-76545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A2DF85F8AB
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 13:52:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16462285BEF
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 12:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43D701339AB;
	Thu, 22 Feb 2024 12:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="NNN7FErc"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3865212E1C6
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 12:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708606271; cv=none; b=iBuH2GfyHi5JeA7mxLBfwIGfMEyZ9Mh70CD8vUTegR488DXQyGy8g/OAuAgEJL4Vu5untJDBEzOKNeM5TmnA+p5fB7/PH9AdASJqQACrVK2oBfVLXo5IqKzdbeSzc+cwhYRLOKp8OJqgO6VF5w4JiPVMGMx5dbGLxmhtA4r2L4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708606271; c=relaxed/simple;
	bh=MYyr69+UMqG9UKpTihNKg9odwyYpkoVtCSzlJlFgzek=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MZtq3fsR3QB1soPCOZzJrmBw/LQetWzigVIRzR0wjB/tcP7xdDU32SIvLJbwKIGUpsFHfMhoBio/gIHcPiEUqMM6/iubuIqL9vOz5hn7+im3vu02E80s2Zu58bQzV2wmYgezs3mG6EZZU0jP9g2l3om6drpYVtRK4WbB+mPhwvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=NNN7FErc; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-5cdbc42f5efso2115986a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 04:51:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1708606268; x=1709211068; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J2PyoWckVK6XWNDryodJyaW+Id4uE7HyyMwS32Zbr7s=;
        b=NNN7FErcKSwCAMOYiVoLnj0ooBMFJOZTbrMiA3Jb8RNquEH4HRdbijeyB/yh2smTF+
         wDwH1KKCmxfTb5WZuTk0TmrQqscMD5++myCuu6yEol9S7yrW5I7+TmPb3ucGGtl2AVYK
         1VYKTBuyN2iuSTraQLLu0rizYUa1Wzbr2xm++ow6+GtAIsi3GhHBDnxR3F//uSM7IbVQ
         KWa9Cqh0a3C315WK6H+C3jP2PXgmuiYKHQdBo4cZG1bBl6QljNSC77FnsLtpLh9/BQMO
         kjzFH4fdaD03fnmRquKJ/l/xnbf9y2fxMZCCU+csvA4RGztqtnK0HNMW1eN7OQItTznj
         E01w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708606268; x=1709211068;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J2PyoWckVK6XWNDryodJyaW+Id4uE7HyyMwS32Zbr7s=;
        b=NNIj6YAFmQ/Jew8tdZknfshpRqzLm9xzZTz9rDjgqZruQvIsL/u/zAGzd8LAF4JpLs
         /iYVt1aFxEyli9YQmuIG8Rb9DDfT+fRXVi11NnalpUT4l8D0IQCswtNOjGxLctsB4I5/
         wpQUDxsVY0XwfWGzApOLDE644YDE7nOJGC+lLga/N0+dd1NdoFs6Xigwquc7GlbY4nlB
         mFwgwobN0DkClE3wgo7zcnl81pQyXmLPqlggWQ7nZ3lFpmAIX3LGmYNG38EVE192sDOE
         ZzLehi08vslgN1GjE+H6Gf6qJEUjax4pViQtlXcp1S0f9G5gAhvobK6UCUt3EVePzuBC
         eHOQ==
X-Forwarded-Encrypted: i=1; AJvYcCWM9gCYVzfTdli+YHkrthWvDmd5kSS2y9P5JGQPjxR5l2dj2Gu52w21l3if2cPFM2Y6+D7gz5hPK8zJB7eFU/8k+73NnqH6lwpHuHKK
X-Gm-Message-State: AOJu0YzQl8wp8TbLhkp6qKcyroC8d565eOYN4EwDpiNbhr7s4WAP8jwM
	2SfksK79MRgaleXbSEKGxfFuCUQUdVqz/Cm3EMemWL+/bv2ETR6EU3Cb47U9Kho=
X-Google-Smtp-Source: AGHT+IEh7rkBG77CU4SzfMt/wi8zxe+CH8TgX8CKsAYfOe5eLVGl/iArQsvWAF5ugJDKFoLJZvToHw==
X-Received: by 2002:a05:6a20:6a1c:b0:1a0:b3c0:a080 with SMTP id p28-20020a056a206a1c00b001a0b3c0a080mr2400620pzk.4.1708606268240;
        Thu, 22 Feb 2024 04:51:08 -0800 (PST)
Received: from aryabhatta.. ([49.37.248.155])
        by smtp.gmail.com with ESMTPSA id k5-20020a170902e90500b001db7599aba0sm9898438pld.24.2024.02.22.04.51.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 04:51:07 -0800 (PST)
From: Himanshu Chauhan <hchauhan@ventanamicro.com>
To: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu
Subject: [RFC PATCH 2/2] riscv: Introduce support for hardware break/watchpoints
Date: Thu, 22 Feb 2024 18:20:59 +0530
Message-Id: <20240222125059.13331-3-hchauhan@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240222125059.13331-1-hchauhan@ventanamicro.com>
References: <20240222125059.13331-1-hchauhan@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

RISC-V hardware breakpoint framework is built on top of perf subsystem and uses
SBI debug trigger extension to install/uninstall/update/enable/disable hardware
triggers as specified in Sdtrig ISA extension.

Signed-off-by: Himanshu Chauhan <hchauhan@ventanamicro.com>
---
 arch/riscv/Kconfig                     |   1 +
 arch/riscv/include/asm/hw_breakpoint.h | 327 ++++++++++++
 arch/riscv/include/asm/kdebug.h        |   3 +-
 arch/riscv/kernel/Makefile             |   1 +
 arch/riscv/kernel/hw_breakpoint.c      | 659 +++++++++++++++++++++++++
 arch/riscv/kernel/traps.c              |   6 +
 6 files changed, 996 insertions(+), 1 deletion(-)
 create mode 100644 arch/riscv/include/asm/hw_breakpoint.h
 create mode 100644 arch/riscv/kernel/hw_breakpoint.c

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index bffbd869a068..7fbc068a11d5 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -128,6 +128,7 @@ config RISCV
 	select HAVE_FUNCTION_ERROR_INJECTION
 	select HAVE_GCC_PLUGINS
 	select HAVE_GENERIC_VDSO if MMU && 64BIT
+	select HAVE_HW_BREAKPOINT if PERF_EVENTS
 	select HAVE_IRQ_TIME_ACCOUNTING
 	select HAVE_KPROBES if !XIP_KERNEL
 	select HAVE_KPROBES_ON_FTRACE if !XIP_KERNEL
diff --git a/arch/riscv/include/asm/hw_breakpoint.h b/arch/riscv/include/asm/hw_breakpoint.h
new file mode 100644
index 000000000000..f1cf83f51c19
--- /dev/null
+++ b/arch/riscv/include/asm/hw_breakpoint.h
@@ -0,0 +1,327 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2024 Ventana Micro Systems Inc.
+ */
+
+#ifndef __RISCV_HW_BREAKPOINT_H
+#define __RISCV_HW_BREAKPOINT_H
+
+struct task_struct;
+
+#ifdef CONFIG_HAVE_HW_BREAKPOINT
+
+#include <uapi/linux/hw_breakpoint.h>
+
+#if __riscv_xlen == 64
+#define cpu_to_le cpu_to_le64
+#define le_to_cpu le64_to_cpu
+#elif __riscv_xlen == 32
+#define cpu_to_le cpu_to_le32
+#define le_to_cpu le32_to_cpu
+#else
+#error "Unexpected __riscv_xlen"
+#endif
+
+#define RV_DBTR_BIT(_prefix, _name)		\
+	RV_DBTR_##_prefix##_##_name##_BIT
+
+#define RV_DBTR_BIT_MASK(_prefix, _name)	\
+	RV_DBTR_##_prefix##_name##_BIT_MASK
+
+#define RV_DBTR_DECLARE_BIT(_prefix, _name, _val)	\
+	RV_DBTR_BIT(_prefix, _name) = _val
+
+#define RV_DBTR_DECLARE_BIT_MASK(_prefix, _name, _width)		\
+	RV_DBTR_BIT_MASK(_prefix, _name) =				\
+		(((1UL << _width) - 1) << RV_DBTR_BIT(_prefix, _name))
+
+#define CLEAR_DBTR_BIT(_target, _prefix, _bit_name)	\
+	__clear_bit(RV_DBTR_BIT(_prefix, _bit_name), &_target)
+
+#define SET_DBTR_BIT(_target, _prefix, _bit_name)	\
+	__set_bit(RV_DBTR_BIT(_prefix, _bit_name), &_target)
+
+enum {
+	RV_DBTR_BP	= 0,
+	RV_DBTR_WP	= 1,
+};
+
+enum {
+	RV_DBTR_TRIG_NONE = 0,
+	RV_DBTR_TRIG_LEGACY,
+	RV_DBTR_TRIG_MCONTROL,
+	RV_DBTR_TRIG_ICOUNT,
+	RV_DBTR_TRIG_ITRIGGER,
+	RV_DBTR_TRIG_ETRIGGER,
+	RV_DBTR_TRIG_MCONTROL6,
+};
+
+/* Trigger Data 1 */
+enum {
+	RV_DBTR_DECLARE_BIT(TDATA1, DATA,   0),
+#if __riscv_xlen == 64
+	RV_DBTR_DECLARE_BIT(TDATA1, DMODE,  59),
+	RV_DBTR_DECLARE_BIT(TDATA1, TYPE,   60),
+#elif __riscv_xlen == 32
+	RV_DBTR_DECLARE_BIT(TDATA1, DMODE,  27),
+	RV_DBTR_DECLARE_BIT(TDATA1, TYPE,   28),
+#else
+	#error "Unknown __riscv_xlen"
+#endif
+};
+
+enum {
+#if __riscv_xlen == 64
+	RV_DBTR_DECLARE_BIT_MASK(TDATA1, DATA,  59),
+#elif __riscv_xlen == 32
+	RV_DBTR_DECLARE_BIT_MASK(TDATA1, DATA,  27),
+#else
+	#error "Unknown __riscv_xlen"
+#endif
+	RV_DBTR_DECLARE_BIT_MASK(TDATA1, DMODE, 1),
+	RV_DBTR_DECLARE_BIT_MASK(TDATA1, TYPE,  4),
+};
+
+/* MC - Match Control Type Register */
+enum {
+	RV_DBTR_DECLARE_BIT(MC, LOAD,    0),
+	RV_DBTR_DECLARE_BIT(MC, STORE,   1),
+	RV_DBTR_DECLARE_BIT(MC, EXEC,    2),
+	RV_DBTR_DECLARE_BIT(MC, U,       3),
+	RV_DBTR_DECLARE_BIT(MC, S,       4),
+	RV_DBTR_DECLARE_BIT(MC, RES2,    5),
+	RV_DBTR_DECLARE_BIT(MC, M,       6),
+	RV_DBTR_DECLARE_BIT(MC, MATCH,   7),
+	RV_DBTR_DECLARE_BIT(MC, CHAIN,   11),
+	RV_DBTR_DECLARE_BIT(MC, ACTION,  12),
+	RV_DBTR_DECLARE_BIT(MC, SIZELO,  16),
+	RV_DBTR_DECLARE_BIT(MC, TIMING,  18),
+	RV_DBTR_DECLARE_BIT(MC, SELECT,  19),
+	RV_DBTR_DECLARE_BIT(MC, HIT,     20),
+#if __riscv_xlen >= 64
+	RV_DBTR_DECLARE_BIT(MC, SIZEHI,  21),
+#endif
+#if __riscv_xlen == 64
+	RV_DBTR_DECLARE_BIT(MC, MASKMAX, 53),
+	RV_DBTR_DECLARE_BIT(MC, DMODE,   59),
+	RV_DBTR_DECLARE_BIT(MC, TYPE,    60),
+#elif __riscv_xlen == 32
+	RV_DBTR_DECLARE_BIT(MC, MASKMAX, 21),
+	RV_DBTR_DECLARE_BIT(MC, DMODE,   27),
+	RV_DBTR_DECLARE_BIT(MC, TYPE,    28),
+#else
+	#error "Unknown riscv xlen"
+#endif
+};
+
+enum {
+	RV_DBTR_DECLARE_BIT_MASK(MC, LOAD,    1),
+	RV_DBTR_DECLARE_BIT_MASK(MC, STORE,   1),
+	RV_DBTR_DECLARE_BIT_MASK(MC, EXEC,    1),
+	RV_DBTR_DECLARE_BIT_MASK(MC, U,       1),
+	RV_DBTR_DECLARE_BIT_MASK(MC, S,       1),
+	RV_DBTR_DECLARE_BIT_MASK(MC, RES2,    1),
+	RV_DBTR_DECLARE_BIT_MASK(MC, M,       1),
+	RV_DBTR_DECLARE_BIT_MASK(MC, MATCH,   4),
+	RV_DBTR_DECLARE_BIT_MASK(MC, CHAIN,   1),
+	RV_DBTR_DECLARE_BIT_MASK(MC, ACTION,  4),
+	RV_DBTR_DECLARE_BIT_MASK(MC, SIZELO,  2),
+	RV_DBTR_DECLARE_BIT_MASK(MC, TIMING,  1),
+	RV_DBTR_DECLARE_BIT_MASK(MC, SELECT,  1),
+	RV_DBTR_DECLARE_BIT_MASK(MC, HIT,     1),
+#if __riscv_xlen >= 64
+	RV_DBTR_DECLARE_BIT_MASK(MC, SIZEHI,  2),
+#endif
+	RV_DBTR_DECLARE_BIT_MASK(MC, MASKMAX, 6),
+	RV_DBTR_DECLARE_BIT_MASK(MC, DMODE,   1),
+	RV_DBTR_DECLARE_BIT_MASK(MC, TYPE,    4),
+};
+
+/* MC6 - Match Control 6 Type Register */
+enum {
+	RV_DBTR_DECLARE_BIT(MC6, LOAD,   0),
+	RV_DBTR_DECLARE_BIT(MC6, STORE,  1),
+	RV_DBTR_DECLARE_BIT(MC6, EXEC,   2),
+	RV_DBTR_DECLARE_BIT(MC6, U,      3),
+	RV_DBTR_DECLARE_BIT(MC6, S,      4),
+	RV_DBTR_DECLARE_BIT(MC6, RES2,   5),
+	RV_DBTR_DECLARE_BIT(MC6, M,      6),
+	RV_DBTR_DECLARE_BIT(MC6, MATCH,  7),
+	RV_DBTR_DECLARE_BIT(MC6, CHAIN,  11),
+	RV_DBTR_DECLARE_BIT(MC6, ACTION, 12),
+	RV_DBTR_DECLARE_BIT(MC6, SIZE,   16),
+	RV_DBTR_DECLARE_BIT(MC6, TIMING, 20),
+	RV_DBTR_DECLARE_BIT(MC6, SELECT, 21),
+	RV_DBTR_DECLARE_BIT(MC6, HIT,    22),
+	RV_DBTR_DECLARE_BIT(MC6, VU,     23),
+	RV_DBTR_DECLARE_BIT(MC6, VS,     24),
+#if __riscv_xlen == 64
+	RV_DBTR_DECLARE_BIT(MC6, DMODE,  59),
+	RV_DBTR_DECLARE_BIT(MC6, TYPE,   60),
+#elif __riscv_xlen == 32
+	RV_DBTR_DECLARE_BIT(MC6, DMODE,  27),
+	RV_DBTR_DECLARE_BIT(MC6, TYPE,   28),
+#else
+	#error "Unknown riscv xlen"
+#endif
+};
+
+enum {
+	RV_DBTR_DECLARE_BIT_MASK(MC6, LOAD,   1),
+	RV_DBTR_DECLARE_BIT_MASK(MC6, STORE,  1),
+	RV_DBTR_DECLARE_BIT_MASK(MC6, EXEC,   1),
+	RV_DBTR_DECLARE_BIT_MASK(MC6, U,      1),
+	RV_DBTR_DECLARE_BIT_MASK(MC6, S,      1),
+	RV_DBTR_DECLARE_BIT_MASK(MC6, RES2,   1),
+	RV_DBTR_DECLARE_BIT_MASK(MC6, M,      1),
+	RV_DBTR_DECLARE_BIT_MASK(MC6, MATCH,  4),
+	RV_DBTR_DECLARE_BIT_MASK(MC6, CHAIN,  1),
+	RV_DBTR_DECLARE_BIT_MASK(MC6, ACTION, 4),
+	RV_DBTR_DECLARE_BIT_MASK(MC6, SIZE,   4),
+	RV_DBTR_DECLARE_BIT_MASK(MC6, TIMING, 1),
+	RV_DBTR_DECLARE_BIT_MASK(MC6, SELECT, 1),
+	RV_DBTR_DECLARE_BIT_MASK(MC6, HIT,    1),
+	RV_DBTR_DECLARE_BIT_MASK(MC6, VU,     1),
+	RV_DBTR_DECLARE_BIT_MASK(MC6, VS,     1),
+#if __riscv_xlen == 64
+	RV_DBTR_DECLARE_BIT_MASK(MC6, DMODE,  1),
+	RV_DBTR_DECLARE_BIT_MASK(MC6, TYPE,   4),
+#elif __riscv_xlen == 32
+	RV_DBTR_DECLARE_BIT_MASK(MC6, DMODE,  1),
+	RV_DBTR_DECLARE_BIT_MASK(MC6, TYPE,   4),
+#else
+	#error "Unknown riscv xlen"
+#endif
+};
+
+#define RV_DBTR_SET_TDATA1_TYPE(_t1, _type)				\
+	do {								\
+		_t1 &= ~RV_DBTR_BIT_MASK(TDATA1, TYPE);			\
+		_t1 |= (((unsigned long)_type				\
+			 << RV_DBTR_BIT(TDATA1, TYPE))			\
+			& RV_DBTR_BIT_MASK(TDATA1, TYPE));		\
+	}while (0);
+
+#define RV_DBTR_SET_MC_TYPE(_t1, _type)				\
+	do {							\
+		_t1 &= ~RV_DBTR_BIT_MASK(MC, TYPE);		\
+		_t1 |= (((unsigned long)_type			\
+			 << RV_DBTR_BIT(MC, TYPE))		\
+			& RV_DBTR_BIT_MASK(MC, TYPE));		\
+	}while (0);
+
+#define RV_DBTR_SET_MC6_TYPE(_t1, _type)			\
+	do {							\
+		_t1 &= ~RV_DBTR_BIT_MASK(MC6, TYPE);		\
+		_t1 |= (((unsigned long)_type			\
+			 << RV_DBTR_BIT(MC6, TYPE))		\
+			& RV_DBTR_BIT_MASK(MC6, TYPE));		\
+	}while (0);
+
+#define RV_DBTR_SET_MC_EXEC(_t1)		\
+	SET_DBTR_BIT(_t1, MC, EXEC)
+
+#define RV_DBTR_SET_MC_LOAD(_t1)		\
+	SET_DBTR_BIT(_t1, MC, LOAD)
+
+#define RV_DBTR_SET_MC_STORE(_t1)		\
+	SET_DBTR_BIT(_t1, MC, STORE)
+
+#define RV_DBTR_SET_MC_SIZELO(_t1, _val)			\
+	do {							\
+		_t1 &= ~RV_DBTR_BIT_MASK(MC, SIZELO);		\
+		_t1 |= ((_val << RV_DBTR_BIT(MC, SIZELO))	\
+			& RV_DBTR_BIT_MASK(MC, SIZELO));	\
+	} while(0);
+
+#define RV_DBTR_SET_MC_SIZEHI(_t1, _val)			\
+	do {							\
+		_t1 &= ~RV_DBTR_BIT_MASK(MC, SIZEHI);		\
+		_t1 |= ((_val << RV_DBTR_BIT(MC, SIZEHI))	\
+			& RV_DBTR_BIT_MASK(MC, SIZEHI));	\
+	} while(0);
+
+#define RV_DBTR_SET_MC6_EXEC(_t1)		\
+	SET_DBTR_BIT(_t1, MC6, EXEC)
+
+#define RV_DBTR_SET_MC6_LOAD(_t1)		\
+	SET_DBTR_BIT(_t1, MC6, LOAD)
+
+#define RV_DBTR_SET_MC6_STORE(_t1)		\
+	SET_DBTR_BIT(_t1, MC6, STORE)
+
+#define RV_DBTR_SET_MC6_SIZE(_t1, _val)				\
+	do {							\
+		_t1 &= ~RV_DBTR_BIT_MASK(MC6, SIZE);		\
+		_t1 |= ((_val << RV_DBTR_BIT(MC6, SIZE))	\
+			& RV_DBTR_BIT_MASK(MC6, SIZE));		\
+	} while(0);
+
+typedef unsigned long riscv_dbtr_tdata1_mcontrol_t;
+typedef unsigned long riscv_dbtr_tdata1_mcontrol6_t;
+
+struct arch_hw_breakpoint {
+	unsigned long address;
+	unsigned long len;
+	unsigned int type;
+
+	/* Trigger configuration data */
+	unsigned long tdata1;
+	unsigned long tdata2;
+	unsigned long tdata3;
+};
+
+/* Maximum number of hardware breakpoints supported */
+#define HW_BP_NUM_MAX 32
+
+struct perf_event_attr;
+struct notifier_block;
+struct perf_event;
+struct pt_regs;
+
+int hw_breakpoint_slots(int type);
+int arch_check_bp_in_kernelspace(struct arch_hw_breakpoint *hw);
+int hw_breakpoint_arch_parse(struct perf_event *bp,
+			     const struct perf_event_attr *attr,
+			     struct arch_hw_breakpoint *hw);
+int hw_breakpoint_exceptions_notify(struct notifier_block *unused,
+				    unsigned long val, void *data);
+
+void arch_enable_hw_breakpoint(struct perf_event *bp);
+void arch_update_hw_breakpoint(struct perf_event *bp);
+void arch_disable_hw_breakpoint(struct perf_event *bp);
+int arch_install_hw_breakpoint(struct perf_event *bp);
+void arch_uninstall_hw_breakpoint(struct perf_event *bp);
+void hw_breakpoint_pmu_read(struct perf_event *bp);
+void clear_ptrace_hw_breakpoint(struct task_struct *tsk);
+void flush_ptrace_hw_breakpoint(struct task_struct *tsk);
+
+#else
+
+int hw_breakpoint_slots(int type)
+{
+	return 0;
+}
+
+static inline void clear_ptrace_hw_breakpoint(struct task_struct *tsk)
+{
+}
+
+static inline void flush_ptrace_hw_breakpoint(struct task_struct *tsk)
+{
+}
+
+void arch_enable_hw_breakpoint(struct perf_event *bp)
+{
+}
+
+void arch_update_hw_breakpoint(struct perf_event *bp)
+{
+}
+
+void arch_disable_hw_breakpoint(struct perf_event *bp)
+{
+}
+
+#endif /* CONFIG_HAVE_HW_BREAKPOINT */
+#endif /* __RISCV_HW_BREAKPOINT_H */
diff --git a/arch/riscv/include/asm/kdebug.h b/arch/riscv/include/asm/kdebug.h
index 85ac00411f6e..53e989781aa1 100644
--- a/arch/riscv/include/asm/kdebug.h
+++ b/arch/riscv/include/asm/kdebug.h
@@ -6,7 +6,8 @@
 enum die_val {
 	DIE_UNUSED,
 	DIE_TRAP,
-	DIE_OOPS
+	DIE_OOPS,
+	DIE_DEBUG
 };
 
 #endif
diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
index f71910718053..7d0205031d63 100644
--- a/arch/riscv/kernel/Makefile
+++ b/arch/riscv/kernel/Makefile
@@ -81,6 +81,7 @@ obj-$(CONFIG_DYNAMIC_FTRACE)	+= mcount-dyn.o
 
 obj-$(CONFIG_PERF_EVENTS)	+= perf_callchain.o
 obj-$(CONFIG_HAVE_PERF_REGS)	+= perf_regs.o
+obj-$(CONFIG_HAVE_HW_BREAKPOINT)	+= hw_breakpoint.o
 obj-$(CONFIG_RISCV_SBI)		+= sbi.o
 ifeq ($(CONFIG_RISCV_SBI), y)
 obj-$(CONFIG_SMP)		+= sbi-ipi.o
diff --git a/arch/riscv/kernel/hw_breakpoint.c b/arch/riscv/kernel/hw_breakpoint.c
new file mode 100644
index 000000000000..7787123c7180
--- /dev/null
+++ b/arch/riscv/kernel/hw_breakpoint.c
@@ -0,0 +1,659 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2024 Ventana Micro Systems Inc.
+ */
+
+#include <linux/hw_breakpoint.h>
+#include <linux/perf_event.h>
+#include <linux/spinlock.h>
+#include <linux/percpu.h>
+#include <linux/kdebug.h>
+#include <linux/bitops.h>
+#include <linux/cpu.h>
+#include <linux/cpuhotplug.h>
+
+#include <asm/sbi.h>
+
+/* Registered per-cpu bp/wp */
+static DEFINE_PER_CPU(struct perf_event *, pcpu_hw_bp_events[HW_BP_NUM_MAX]);
+static DEFINE_PER_CPU(unsigned long, ecall_lock_flags);
+static DEFINE_PER_CPU(raw_spinlock_t, ecall_lock);
+
+/* Per-cpu shared memory between S and M mode */
+static struct sbi_dbtr_shmem_entry __percpu *sbi_dbtr_shmem;
+
+/* number of debug triggers on this cpu . */
+static int dbtr_total_num __ro_after_init;
+static int dbtr_type __ro_after_init;
+static int dbtr_init __ro_after_init;
+
+#if __riscv_xlen == 64
+#define MEM_HI(_m)	((u64)_m >> 32)
+#define MEM_LO(_m)	((u64)_m & 0xFFFFFFFFUL)
+#elif __riscv_xlen == 32
+#define MEM_HI(_m)	(((u64)_m >> 32) & 0x3)
+#define MEM_LO(_m)	((u64)_m & 0xFFFFFFFFUL)
+#else
+#error "Unknown __riscv_xlen"
+#endif
+
+static int arch_smp_setup_sbi_shmem(unsigned int cpu)
+{
+	struct sbi_dbtr_shmem_entry *dbtr_shmem;
+	unsigned long shmem_pa;
+	struct sbiret ret;
+	int rc;
+
+	dbtr_shmem = per_cpu_ptr(sbi_dbtr_shmem, cpu);
+	if (!dbtr_shmem) {
+		pr_err("Invalid per-cpu shared memory for debug triggers\n");
+		return -ENODEV;
+	}
+
+	shmem_pa = __pa(dbtr_shmem);
+
+	ret = sbi_ecall(SBI_EXT_DBTR, SBI_EXT_DBTR_SETUP_SHMEM,
+			(!MEM_LO(shmem_pa) ? 0xFFFFFFFFUL : MEM_LO(shmem_pa)),
+			(!MEM_HI(shmem_pa) ? 0xFFFFFFFFUL : MEM_HI(shmem_pa)),
+			 0, 0, 0, 0);
+
+	if (ret.error) {
+		switch(ret.error) {
+		case SBI_ERR_DENIED:
+			pr_warn("%s: Access denied for shared memory at %lx\n",
+				__func__, shmem_pa);
+			rc = -EPERM;
+			break;
+
+		case SBI_ERR_INVALID_PARAM:
+		case SBI_ERR_INVALID_ADDRESS:
+			pr_warn("%s: Invalid address parameter (%lu)\n",
+				__func__, ret.error);
+			rc = -EINVAL;
+			break;
+
+		case SBI_ERR_ALREADY_AVAILABLE:
+			pr_warn("%s: Shared memory is already set\n",
+				__func__);
+			rc = -EADDRINUSE;
+			break;
+
+		case SBI_ERR_FAILURE:
+			pr_err("%s: Internal sdtrig state error\n",
+			       __func__);
+			rc = -ENXIO;
+			break;
+
+		default:
+			pr_warn("%s: Unknown error %lu\n", __func__, ret.error);
+			rc = -ENXIO;
+			break;
+		}
+	}
+
+	pr_warn("CPU %d: HW Breakpoint shared memory registered.\n", cpu);
+
+	return rc;
+}
+
+static int arch_smp_teardown_sbi_shmem(unsigned int cpu)
+{
+	struct sbiret ret;
+
+	/* Disable shared memory */
+	ret = sbi_ecall(SBI_EXT_DBTR, SBI_EXT_DBTR_SETUP_SHMEM,
+			-1UL, -1UL, 0, 0, 0, 0);
+
+	if (ret.error) {
+		switch(ret.error) {
+		case SBI_ERR_DENIED:
+			pr_err("%s: Access denied for shared memory.\n",
+			       __func__);
+			break;
+
+		case SBI_ERR_INVALID_PARAM:
+		case SBI_ERR_INVALID_ADDRESS:
+			pr_err("%s: Invalid address parameter (%lu)\n",
+			       __func__, ret.error);
+			break;
+
+		case SBI_ERR_ALREADY_AVAILABLE:
+			pr_err("%s: Shared memory is already set\n",
+			       __func__);
+			break;
+		case SBI_ERR_FAILURE:
+			pr_err("%s: Internal sdtrig state error\n",
+			       __func__);
+			break;
+		default:
+			pr_err("%s: Unknown error %lu\n", __func__, ret.error);
+			break;
+		}
+	}
+
+	pr_warn("CPU %d: HW Breakpoint shared memory disabled.\n", cpu);
+
+	return 0;
+}
+
+static void init_sbi_dbtr(void)
+{
+	unsigned long tdata1;
+	struct sbiret ret;
+
+	if (sbi_probe_extension(SBI_EXT_DBTR) <= 0) {
+		pr_warn("%s: SBI_EXT_DBTR is not supported\n", __func__);
+		dbtr_total_num = 0;
+		goto done;
+	}
+
+	ret = sbi_ecall(SBI_EXT_DBTR, SBI_EXT_DBTR_NUM_TRIGGERS,
+			0, 0, 0, 0, 0, 0);
+	if (ret.error) {
+		pr_warn("%s: Failed to detect triggers\n", __func__);
+		dbtr_total_num = 0;
+		goto done;
+	}
+
+	tdata1 = 0;
+	RV_DBTR_SET_TDATA1_TYPE(tdata1, RV_DBTR_TRIG_MCONTROL6);
+
+	ret = sbi_ecall(SBI_EXT_DBTR, SBI_EXT_DBTR_NUM_TRIGGERS,
+			tdata1, 0, 0, 0, 0, 0);
+	if (ret.error) {
+		pr_warn("%s: failed to detect mcontrol6 triggers\n", __func__);
+	} else if (!ret.value) {
+		pr_warn("%s: type 6 triggers not available\n", __func__);
+	} else {
+		dbtr_total_num = ret.value;
+		dbtr_type = RV_DBTR_TRIG_MCONTROL6;
+		pr_warn("%s: mcontrol6 trigger available.\n", __func__);
+		goto done;
+	}
+
+	/* fallback to type 2 triggers if type 6 is not available */
+
+	tdata1 = 0;
+	RV_DBTR_SET_TDATA1_TYPE(tdata1, RV_DBTR_TRIG_MCONTROL);
+
+	ret = sbi_ecall(SBI_EXT_DBTR, SBI_EXT_DBTR_NUM_TRIGGERS,
+			tdata1, 0, 0, 0, 0, 0);
+	if (ret.error) {
+		pr_warn("%s: failed to detect mcontrol triggers\n", __func__);
+	} else if (!ret.value) {
+		pr_warn("%s: type 2 triggers not available\n", __func__);
+	} else {
+		dbtr_total_num = ret.value;
+		dbtr_type = RV_DBTR_TRIG_MCONTROL;
+		goto done;
+	}
+
+done:
+	dbtr_init = 1;
+}
+
+int hw_breakpoint_slots(int type)
+{
+	/*
+	 * We can be called early, so don't rely on
+	 * static variables being initialised.
+	 */
+
+	if (!dbtr_init)
+		init_sbi_dbtr();
+
+	return dbtr_total_num;
+}
+
+int arch_check_bp_in_kernelspace(struct arch_hw_breakpoint *hw)
+{
+	unsigned int len;
+	unsigned long va;
+
+	va = hw->address;
+	len = hw->len;
+
+	return (va >= TASK_SIZE) && ((va + len - 1) >= TASK_SIZE);
+}
+
+static int rv_init_mcontrol_trigger(const struct perf_event_attr *attr,
+				    struct arch_hw_breakpoint *hw)
+{
+	switch (attr->bp_type) {
+	case HW_BREAKPOINT_X:
+		hw->type = RV_DBTR_BP;
+		RV_DBTR_SET_MC_EXEC(hw->tdata1);
+		break;
+	case HW_BREAKPOINT_R:
+		hw->type = RV_DBTR_WP;
+		RV_DBTR_SET_MC_LOAD(hw->tdata1);
+		break;
+	case HW_BREAKPOINT_W:
+		hw->type = RV_DBTR_WP;
+		RV_DBTR_SET_MC_STORE(hw->tdata1);
+		break;
+	case HW_BREAKPOINT_RW:
+		hw->type = RV_DBTR_WP;
+		RV_DBTR_SET_MC_LOAD(hw->tdata1);
+		RV_DBTR_SET_MC_STORE(hw->tdata1);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	switch (attr->bp_len) {
+	case HW_BREAKPOINT_LEN_1:
+		hw->len = 1;
+		RV_DBTR_SET_MC_SIZELO(hw->tdata1, 1);
+		break;
+	case HW_BREAKPOINT_LEN_2:
+		hw->len = 2;
+		RV_DBTR_SET_MC_SIZELO(hw->tdata1, 2);
+		break;
+	case HW_BREAKPOINT_LEN_4:
+		hw->len = 4;
+		RV_DBTR_SET_MC_SIZELO(hw->tdata1, 3);
+		break;
+#if __riscv_xlen >= 64
+	case HW_BREAKPOINT_LEN_8:
+		hw->len = 8;
+		RV_DBTR_SET_MC_SIZELO(hw->tdata1, 1);
+		RV_DBTR_SET_MC_SIZEHI(hw->tdata1, 1);
+		break;
+#endif
+	default:
+		return -EINVAL;
+	}
+
+	RV_DBTR_SET_MC_TYPE(hw->tdata1, RV_DBTR_TRIG_MCONTROL);
+
+	CLEAR_DBTR_BIT(hw->tdata1, MC, DMODE);
+	CLEAR_DBTR_BIT(hw->tdata1, MC, TIMING);
+	CLEAR_DBTR_BIT(hw->tdata1, MC, SELECT);
+	CLEAR_DBTR_BIT(hw->tdata1, MC, ACTION);
+	CLEAR_DBTR_BIT(hw->tdata1, MC, CHAIN);
+	CLEAR_DBTR_BIT(hw->tdata1, MC, MATCH);
+	CLEAR_DBTR_BIT(hw->tdata1, MC, M);
+
+	SET_DBTR_BIT(hw->tdata1, MC, S);
+	SET_DBTR_BIT(hw->tdata1, MC, U);
+
+	return 0;
+}
+
+static int rv_init_mcontrol6_trigger(const struct perf_event_attr *attr,
+				     struct arch_hw_breakpoint *hw)
+{
+	switch (attr->bp_type) {
+	case HW_BREAKPOINT_X:
+		hw->type = RV_DBTR_BP;
+		RV_DBTR_SET_MC6_EXEC(hw->tdata1);
+		break;
+	case HW_BREAKPOINT_R:
+		hw->type = RV_DBTR_WP;
+		RV_DBTR_SET_MC6_LOAD(hw->tdata1);
+		break;
+	case HW_BREAKPOINT_W:
+		hw->type = RV_DBTR_WP;
+		RV_DBTR_SET_MC6_STORE(hw->tdata1);
+		break;
+	case HW_BREAKPOINT_RW:
+		hw->type = RV_DBTR_WP;
+		RV_DBTR_SET_MC6_STORE(hw->tdata1);
+		RV_DBTR_SET_MC6_LOAD(hw->tdata1);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	switch (attr->bp_len) {
+	case HW_BREAKPOINT_LEN_1:
+		hw->len = 1;
+		RV_DBTR_SET_MC6_SIZE(hw->tdata1, 1);
+		break;
+	case HW_BREAKPOINT_LEN_2:
+		hw->len = 2;
+		RV_DBTR_SET_MC6_SIZE(hw->tdata1, 2);
+		break;
+	case HW_BREAKPOINT_LEN_4:
+		hw->len = 4;
+		RV_DBTR_SET_MC6_SIZE(hw->tdata1, 3);
+		break;
+	case HW_BREAKPOINT_LEN_8:
+		hw->len = 8;
+		RV_DBTR_SET_MC6_SIZE(hw->tdata1, 5);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	RV_DBTR_SET_MC6_TYPE(hw->tdata1, RV_DBTR_TRIG_MCONTROL6);
+
+	CLEAR_DBTR_BIT(hw->tdata1, MC6, DMODE);
+	CLEAR_DBTR_BIT(hw->tdata1, MC6, TIMING);
+	CLEAR_DBTR_BIT(hw->tdata1, MC6, SELECT);
+	CLEAR_DBTR_BIT(hw->tdata1, MC6, ACTION);
+	CLEAR_DBTR_BIT(hw->tdata1, MC6, CHAIN);
+	CLEAR_DBTR_BIT(hw->tdata1, MC6, MATCH);
+	CLEAR_DBTR_BIT(hw->tdata1, MC6, M);
+	CLEAR_DBTR_BIT(hw->tdata1, MC6, VS);
+	CLEAR_DBTR_BIT(hw->tdata1, MC6, VU);
+
+	SET_DBTR_BIT(hw->tdata1, MC6, S);
+	SET_DBTR_BIT(hw->tdata1, MC6, U);
+
+	return 0;
+}
+
+int hw_breakpoint_arch_parse(struct perf_event *bp,
+			     const struct perf_event_attr *attr,
+			     struct arch_hw_breakpoint *hw)
+{
+	int ret;
+
+	/* Breakpoint address */
+	hw->address = attr->bp_addr;
+	hw->tdata2 = attr->bp_addr;
+	hw->tdata3 = 0x0;
+
+	switch (dbtr_type) {
+	case RV_DBTR_TRIG_MCONTROL:
+		ret = rv_init_mcontrol_trigger(attr, hw);
+		break;
+	case RV_DBTR_TRIG_MCONTROL6:
+		ret = rv_init_mcontrol6_trigger(attr, hw);
+		break;
+	default:
+		pr_warn("unsupported trigger type\n");
+		ret = -EOPNOTSUPP;
+		break;
+	}
+
+	return ret;
+}
+
+/*
+ * HW Breakpoint/watchpoint handler
+ */
+static int hw_breakpoint_handler(struct die_args *args)
+{
+	int ret = NOTIFY_DONE;
+	struct arch_hw_breakpoint *bp;
+	struct perf_event *event;
+	int i;
+
+	for (i = 0; i < dbtr_total_num; i++) {
+		event = this_cpu_read(pcpu_hw_bp_events[i]);
+		if (!event)
+			continue;
+
+		bp = counter_arch_bp(event);
+		switch (bp->type) {
+		/* Breakpoint */
+		case RV_DBTR_BP:
+			if (bp->address == args->regs->epc) {
+				perf_bp_event(event, args->regs);
+				ret = NOTIFY_STOP;
+			}
+			break;
+
+		/* Watchpoint */
+		case RV_DBTR_WP:
+			if (bp->address == csr_read(CSR_STVAL)) {
+				perf_bp_event(event, args->regs);
+				ret = NOTIFY_STOP;
+			}
+			break;
+
+		default:
+			pr_warn("%s: Unknown type: %u\n", __func__, bp->type);
+			break;
+		}
+	}
+
+	return ret;
+}
+
+int hw_breakpoint_exceptions_notify(struct notifier_block *unused,
+				    unsigned long val, void *data)
+{
+	if (val != DIE_DEBUG)
+		return NOTIFY_DONE;
+
+	return hw_breakpoint_handler(data);
+}
+
+/* atomic: counter->ctx->lock is held */
+int arch_install_hw_breakpoint(struct perf_event *event)
+{
+	struct arch_hw_breakpoint *bp = counter_arch_bp(event);
+	struct sbi_dbtr_shmem_entry *shmem = this_cpu_ptr(sbi_dbtr_shmem);
+	struct sbi_dbtr_data_msg *xmit;
+	struct sbi_dbtr_id_msg *recv;
+	struct perf_event **slot;
+	unsigned long idx;
+	struct sbiret ret;
+	int err = 0;
+
+	raw_spin_lock_irqsave(this_cpu_ptr(&ecall_lock),
+			      *this_cpu_ptr(&ecall_lock_flags));
+
+	xmit = &shmem->data;
+	recv = &shmem->id;
+	xmit->tdata1 = cpu_to_le(bp->tdata1);
+	xmit->tdata2 = cpu_to_le(bp->tdata2);
+	xmit->tdata3 = cpu_to_le(bp->tdata3);
+
+	ret = sbi_ecall(SBI_EXT_DBTR, SBI_EXT_DBTR_TRIG_INSTALL,
+			1, 0, 0, 0, 0, 0);
+
+	if (ret.error) {
+		pr_warn("%s: failed to install trigger\n", __func__);
+		err = -EIO;
+		goto done;
+	}
+
+	idx = le_to_cpu(recv->idx);
+	if (idx >= dbtr_total_num) {
+		pr_warn("%s: invalid trigger index %lu\n", __func__, idx);
+		err = -EINVAL;
+		goto done;
+	}
+
+	slot = this_cpu_ptr(&pcpu_hw_bp_events[idx]);
+	if (*slot) {
+		pr_warn("%s: slot %lu is in use\n", __func__, idx);
+		err = -EBUSY;
+		goto done;
+	}
+
+	pr_debug("Trigger 0x%lu installed at index 0x%lx\n", bp->tdata2, idx);
+
+	/* Save the event - to be looked up in handler */
+	*slot = event;
+
+done:
+	raw_spin_unlock_irqrestore(this_cpu_ptr(&ecall_lock),
+				   *this_cpu_ptr(&ecall_lock_flags));
+	return err;
+}
+
+/* atomic: counter->ctx->lock is held */
+void arch_uninstall_hw_breakpoint(struct perf_event *event)
+{
+	struct sbiret ret;
+	int i;
+
+	for (i = 0; i < dbtr_total_num; i++) {
+		struct perf_event **slot = this_cpu_ptr(&pcpu_hw_bp_events[i]);
+
+		if (*slot == event) {
+			*slot = NULL;
+			break;
+		}
+	}
+
+	if (i == dbtr_total_num) {
+		pr_warn("%s: Breakpoint not installed.\n", __func__);
+		return;
+	}
+
+	ret = sbi_ecall(SBI_EXT_DBTR, SBI_EXT_DBTR_TRIG_UNINSTALL,
+			i, 1, 0, 0, 0, 0);
+	if (ret.error)
+		pr_warn("%s: Failed to uninstall trigger %d.\n", __func__, i);
+}
+
+void arch_enable_hw_breakpoint(struct perf_event *event)
+{
+	struct sbiret ret;
+	int i;
+	struct perf_event **slot;
+
+	for (i = 0; i < dbtr_total_num; i++) {
+		slot = this_cpu_ptr(&pcpu_hw_bp_events[i]);
+
+		if (*slot == event)
+			break;
+	}
+
+	if (i == dbtr_total_num) {
+		pr_warn("%s: Breakpoint not installed.\n", __func__);
+		return;
+	}
+
+	ret = sbi_ecall(SBI_EXT_DBTR, SBI_EXT_DBTR_TRIG_ENABLE,
+			i, 1, 0, 0, 0, 0);
+
+	if (ret.error) {
+		pr_warn("%s: Failed to install trigger %d\n", __func__, i);
+		return;
+	}
+}
+EXPORT_SYMBOL_GPL(arch_enable_hw_breakpoint);
+
+void arch_update_hw_breakpoint(struct perf_event *event)
+{
+	struct arch_hw_breakpoint *bp = counter_arch_bp(event);
+	struct sbi_dbtr_shmem_entry *shmem = this_cpu_ptr(sbi_dbtr_shmem);
+	struct sbi_dbtr_data_msg *xmit;
+	struct perf_event **slot;
+	struct sbiret ret;
+	int i;
+
+	for (i = 0; i < dbtr_total_num; i++) {
+		slot = this_cpu_ptr(&pcpu_hw_bp_events[i]);
+
+		if (*slot == event)
+			break;
+	}
+
+	if (i == dbtr_total_num) {
+		pr_warn("%s: Breakpoint not installed.\n", __func__);
+		return;
+	}
+
+	raw_spin_lock_irqsave(this_cpu_ptr(&ecall_lock),
+			      *this_cpu_ptr(&ecall_lock_flags));
+
+	xmit = &shmem->data;
+	xmit->tdata1 = cpu_to_le(bp->tdata1);
+	xmit->tdata2 = cpu_to_le(bp->tdata2);
+	xmit->tdata3 = cpu_to_le(bp->tdata3);
+
+	ret = sbi_ecall(SBI_EXT_DBTR, SBI_EXT_DBTR_TRIG_UPDATE,
+			i, 1, 0, 0, 0, 0);
+	if (ret.error)
+		pr_warn("%s: Failed to update trigger %d.\n", __func__, i);
+
+	raw_spin_unlock_irqrestore(this_cpu_ptr(&ecall_lock),
+				   *this_cpu_ptr(&ecall_lock_flags));
+}
+EXPORT_SYMBOL_GPL(arch_update_hw_breakpoint);
+
+void arch_disable_hw_breakpoint(struct perf_event *event)
+{
+	struct sbiret ret;
+	int i;
+
+	for (i = 0; i < dbtr_total_num; i++) {
+		struct perf_event **slot = this_cpu_ptr(&pcpu_hw_bp_events[i]);
+
+		if (*slot == event)
+			break;
+	}
+
+	if (i == dbtr_total_num) {
+		pr_warn("%s: Breakpoint not installed.\n", __func__);
+		return;
+	}
+
+	ret = sbi_ecall(SBI_EXT_DBTR, SBI_EXT_DBTR_TRIG_DISABLE,
+			i, 1, 0, 0, 0, 0);
+
+	if (ret.error) {
+		pr_warn("%s: Failed to uninstall trigger %d.\n", __func__, i);
+		return;
+	}
+}
+EXPORT_SYMBOL_GPL(arch_disable_hw_breakpoint);
+
+void hw_breakpoint_pmu_read(struct perf_event *bp)
+{
+	/* TODO */
+}
+
+void clear_ptrace_hw_breakpoint(struct task_struct *tsk)
+{
+	/* TODO */
+}
+
+void flush_ptrace_hw_breakpoint(struct task_struct *tsk)
+{
+	/* TODO */
+}
+
+static int __init arch_hw_breakpoint_init(void)
+{
+	unsigned int cpu;
+	int rc = 0;
+
+	for_each_possible_cpu(cpu)
+		raw_spin_lock_init(&per_cpu(ecall_lock, cpu));
+
+	if (!dbtr_init)
+		init_sbi_dbtr();
+
+	if (dbtr_total_num) {
+		pr_info("%s: total number of type %d triggers: %u\n",
+			__func__, dbtr_type, dbtr_total_num);
+	} else {
+		pr_info("%s: No hardware triggers available\n", __func__);
+		goto out;
+	}
+
+	/* Allocate per-cpu shared memory */
+	sbi_dbtr_shmem = __alloc_percpu(sizeof(*sbi_dbtr_shmem) * dbtr_total_num,
+					PAGE_SIZE);
+
+	if (!sbi_dbtr_shmem) {
+		pr_warn("%s: Failed to allocate shared memory.\n", __func__);
+		rc = -ENOMEM;
+		goto out;
+	}
+
+	/* Hotplug handler to register/unregister shared memory with SBI */
+	rc = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN,
+			       "riscv/hw_breakpoint:prepare",
+			       arch_smp_setup_sbi_shmem,
+			       arch_smp_teardown_sbi_shmem);
+
+	if (rc < 0) {
+		pr_warn("%s: Failed to setup CPU hotplug state\n", __func__);
+		free_percpu(sbi_dbtr_shmem);
+		return rc;
+	}
+ out:
+	return rc;
+}
+arch_initcall(arch_hw_breakpoint_init);
diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
index a1b9be3c4332..53e1dfe5746b 100644
--- a/arch/riscv/kernel/traps.c
+++ b/arch/riscv/kernel/traps.c
@@ -277,6 +277,12 @@ void handle_break(struct pt_regs *regs)
 	if (probe_breakpoint_handler(regs))
 		return;
 
+#ifdef CONFIG_HAVE_HW_BREAKPOINT
+	if (notify_die(DIE_DEBUG, "EBREAK", regs, 0, regs->cause, SIGTRAP)
+	    == NOTIFY_STOP)
+		return;
+#endif
+
 	current->thread.bad_cause = regs->cause;
 
 	if (user_mode(regs))
-- 
2.34.1


