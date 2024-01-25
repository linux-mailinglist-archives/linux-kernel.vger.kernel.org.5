Return-Path: <linux-kernel+bounces-39097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D0DF83CADB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 19:24:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A1A1B25144
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 18:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A19913AA3F;
	Thu, 25 Jan 2024 18:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="liyW1Baf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mukRRYxS"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DECA31386B8;
	Thu, 25 Jan 2024 18:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706206895; cv=none; b=iCM3/fE7swADMgSwCOLjweAulXIxXLDF9axoukUbi+/ySc55RW0JdE/cPIgEeh6QUeaJh2yh2yCG2Xuq1nYMKOILk6zecmb/5G68jAw4GoERloUj+LGLSvHC+zknBRawDR2UQWdEZxooeZ3OpuAuuNenQqF+9L5sTeQiG7VElok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706206895; c=relaxed/simple;
	bh=/mdJbSRPAXkGrSCue/ixydcHNm9La22QHJD/UVwhIss=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=aIkmBY2Utri3exxlWb9vBQeSHfkikQcLWMhM1B5HDTUO5b62PHcne87Ott/sYRR58p+uc5JAdIGru+Mc2MNJMr/RUELWoKoXYv/D5tQtN+R6XPnc9EzT0xQZ9AF0Md7b8HkBNqrR3+J3EN8wbAkg45b1xo6ygWEaI4CGlyZplv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=liyW1Baf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mukRRYxS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 25 Jan 2024 18:21:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706206891;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D+nVUR0epg6aQPpJNOIwjA5JDENzJy348XmeSdNaPiU=;
	b=liyW1BafSUyFPCYWNYX9HxwXo/Turoicc+JdiLGSN7nckbvEkOFjylAk+QI4bfGiHBjIkN
	ZY9dIAENWylS24op2zBjxmG5GzJxtj4Tag53MpB7BuJ7m/4WV1ft+jTQaJD4jjGrsZeN77
	urcLyu3urHTXew3Qaj4lSnEzS/lGuqAceTbs9xmuj6bIZ2HoIm2IWG6YzKCn1Sq9oXXMta
	y+zxnX370G1okTKaw8O4neXoCbXkCnA6HWAA3uIlP+UmE7UP/jEL1z8C4Y3L1ziuw2txnj
	UjZsHHas2Q9idN8xAgZH8g5RC7rKfGVTNNVrLSv/c7PTx69DrZXqWhPqJxOhmA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706206891;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D+nVUR0epg6aQPpJNOIwjA5JDENzJy348XmeSdNaPiU=;
	b=mukRRYxSq4F1lP9WrcdIyOXmU47warEf8hLGnzV8binR7KhvKRxCkEtzZajRHXyu+LoUwk
	Zi51RZ2Cm6e+3oBw==
From: "tip-bot2 for H. Peter Anvin (Intel)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fred] x86/fred: Add a new header file for FRED definitions
Cc: "H. Peter Anvin (Intel)" <hpa@zytor.com>, Xin Li <xin3.li@intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Shan Kang <shan.kang@intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231205105030.8698-16-xin3.li@intel.com>
References: <20231205105030.8698-16-xin3.li@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170620689049.398.7309158202498643682.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/fred branch of tip:

Commit-ID:     6b0403ff15724348b3c1d409d9c39d62a7972ed4
Gitweb:        https://git.kernel.org/tip/6b0403ff15724348b3c1d409d9c39d62a7972ed4
Author:        H. Peter Anvin (Intel) <hpa@zytor.com>
AuthorDate:    Tue, 05 Dec 2023 02:50:04 -08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 25 Jan 2024 19:10:31 +01:00

x86/fred: Add a new header file for FRED definitions

Add a header file for FRED prototypes and definitions.

Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Signed-off-by: Xin Li <xin3.li@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Shan Kang <shan.kang@intel.com>
Link: https://lore.kernel.org/r/20231205105030.8698-16-xin3.li@intel.com

---
 arch/x86/include/asm/fred.h | 68 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 68 insertions(+)
 create mode 100644 arch/x86/include/asm/fred.h

diff --git a/arch/x86/include/asm/fred.h b/arch/x86/include/asm/fred.h
new file mode 100644
index 0000000..f514fdb
--- /dev/null
+++ b/arch/x86/include/asm/fred.h
@@ -0,0 +1,68 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Macros for Flexible Return and Event Delivery (FRED)
+ */
+
+#ifndef ASM_X86_FRED_H
+#define ASM_X86_FRED_H
+
+#include <linux/const.h>
+
+#include <asm/asm.h>
+
+/*
+ * FRED event return instruction opcodes for ERET{S,U}; supported in
+ * binutils >= 2.41.
+ */
+#define ERETS			_ASM_BYTES(0xf2,0x0f,0x01,0xca)
+#define ERETU			_ASM_BYTES(0xf3,0x0f,0x01,0xca)
+
+/*
+ * RSP is aligned to a 64-byte boundary before used to push a new stack frame
+ */
+#define FRED_STACK_FRAME_RSP_MASK	_AT(unsigned long, (~0x3f))
+
+/*
+ * Used for the return address for call emulation during code patching,
+ * and measured in 64-byte cache lines.
+ */
+#define FRED_CONFIG_REDZONE_AMOUNT	1
+#define FRED_CONFIG_REDZONE		(_AT(unsigned long, FRED_CONFIG_REDZONE_AMOUNT) << 6)
+#define FRED_CONFIG_INT_STKLVL(l)	(_AT(unsigned long, l) << 9)
+#define FRED_CONFIG_ENTRYPOINT(p)	_AT(unsigned long, (p))
+
+#ifndef __ASSEMBLY__
+
+#ifdef CONFIG_X86_FRED
+#include <linux/kernel.h>
+
+#include <asm/ptrace.h>
+
+struct fred_info {
+	/* Event data: CR2, DR6, ... */
+	unsigned long edata;
+	unsigned long resv;
+};
+
+/* Full format of the FRED stack frame */
+struct fred_frame {
+	struct pt_regs   regs;
+	struct fred_info info;
+};
+
+static __always_inline struct fred_info *fred_info(struct pt_regs *regs)
+{
+	return &container_of(regs, struct fred_frame, regs)->info;
+}
+
+static __always_inline unsigned long fred_event_data(struct pt_regs *regs)
+{
+	return fred_info(regs)->edata;
+}
+
+#else /* CONFIG_X86_FRED */
+static __always_inline unsigned long fred_event_data(struct pt_regs *regs) { return 0; }
+#endif /* CONFIG_X86_FRED */
+#endif /* !__ASSEMBLY__ */
+
+#endif /* ASM_X86_FRED_H */

