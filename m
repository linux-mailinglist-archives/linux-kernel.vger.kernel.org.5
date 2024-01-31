Return-Path: <linux-kernel+bounces-45911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE5BF8437C2
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 08:25:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9727D287AC3
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 07:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EC946DD19;
	Wed, 31 Jan 2024 07:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="a106YsGD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jsY2uuHZ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3DC7762A;
	Wed, 31 Jan 2024 07:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706685687; cv=none; b=lZAgpaTxGMWUIZBarM3f3xso0HYAVmO22og766aL+AxR+yJpXmYAiJ5qB2RX5yRrCjApo1FX5020FACCLxHoBz2TVP6ZmFmjpDlhKUptnKgXLojKnXuv+hFtt0vRcfLz1Ayxp9eqYIHNf7mPWvz96wNB6xhVtbLGnYlte1mzxzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706685687; c=relaxed/simple;
	bh=6RRxLWb3dH7au70wZBPXOrUIN15uxtHdzTec5kWUkhw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=tIazcEuUd3qUEnGuStlgcmsRse03EZitmS56sXeoyfe7UDSAd0Z4B4WNbwHB3f5FJlgeEvQCKENRnudAdULzJqErAg25xxBcTXBnH4nFKPx3o8/2LZHqTIMnCCjthDYbrGVkVyaWnFZm1yhqMSx+hS+NhuczAuZPpA6KUHRsCM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=a106YsGD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jsY2uuHZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 31 Jan 2024 07:21:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706685684;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1rCYPWzXSr1NEHVUkBhjNffYDVhemEeEosbzclBK2Zw=;
	b=a106YsGDdEEQgjHhU0zXwNsGgCCgzM7nX2w5FiFI17RLbxl/mwNpo9+fFJ5kobIRMUUUyz
	0sirPcCfo8U00z/Q7nQQdpXKiTtIYljAMNimAcKxBd1NvY4pz5F3ltl16Z6wYckIN1cz9o
	X1WLXMylloaEPw9KUAXapwUAiGpXfYY7Dp6KCCjLIEd/LL4X744eI/wDUbz1rZgfm8xc1r
	YxSaZKo1+OiZD3011vjCaFMZ9wZBarYjlV9kvf2nVuUNqmWnNWLlg3tPE+RPzkZhFBGKCb
	Vua/4ABBkN0YtHT+ZV9qLMQZa/dj8Olrv17RP4E/TUjte/ycDTlMQnrBsB1Kww==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706685684;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1rCYPWzXSr1NEHVUkBhjNffYDVhemEeEosbzclBK2Zw=;
	b=jsY2uuHZlJFfiAetyi88v2eIcnRvEWw5oSjRdFuh2U/n46IK1xTlSMvFhDkmQ8epH1mbwo
	u0tVifFpOV4Ve2CQ==
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
Message-ID: <170668568348.398.12256006093463765752.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/fred branch of tip:

Commit-ID:     c413db75cb7db9740330f3375d1854994bd0c8cb
Gitweb:        https://git.kernel.org/tip/c413db75cb7db9740330f3375d1854994bd0c8cb
Author:        H. Peter Anvin (Intel) <hpa@zytor.com>
AuthorDate:    Tue, 05 Dec 2023 02:50:04 -08:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 30 Jan 2024 18:20:34 +01:00

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

