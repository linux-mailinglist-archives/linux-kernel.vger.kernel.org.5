Return-Path: <linux-kernel+bounces-164010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C5928B7714
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 15:30:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94F5BB21E24
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 13:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA4E217799F;
	Tue, 30 Apr 2024 13:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aO2zYnwA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zxC3KWWh"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E865D172BAF;
	Tue, 30 Apr 2024 13:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714483728; cv=none; b=cnn1WhrzcmLCXMKMJHYuhnH3Q62HQylZSAi2PTP9RpeU65zZaoxNiQwPafXEjCIGK6inxNDalu+EE3AEZBS8j28/Et5SNvxH28LduhXu1aemKzVPVcA6El2tJtfSrbdo0ZAfS/IQT0I1S26CkybYdlLOgn8jPaIZSmt/7c8/dhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714483728; c=relaxed/simple;
	bh=SalhTQ3GnQAEknRfJhFsrFnTUp9pGE96j9CqLBM0nIU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=sajU7Q9M0aUDoO99M3w6943Z9mHxdgUAaNr1pwI2jvXu9a8Qd3sKgCli5de6xfN3Ud7zj9Xu2wuPnl1pqTLj3zCNwmH6Bjrrym+FwNYXQnWD2+oPskOsgaii76CulU3KkLjJJC1ZEj0rp8qazQeu0n3BcDhmdvl3XnRXkYML1G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aO2zYnwA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zxC3KWWh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 30 Apr 2024 13:28:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1714483723;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mwErHmG4UO8ztPuhK0kP17O1Xx8eTHCjts15RwKqDbg=;
	b=aO2zYnwAU0Tts7+s+eH/Id+Ue9Lcbtu1qiMv0gRkZOiDOn0cvdyNiPTa0xBUkYjC+zJ0T9
	ScUUt4mjYsBsNpTn/bxMlOEk2AQbAoHVQcXSAEBVW6A+Qlo8rVj/jvq+ZR8GRz2Di8n6+L
	4k2vdsxiU0N+6NS6AK2GE/wCsiOzgL8oveY6jWDV5zRmoSoDnKxeO/W6XPlxzPKGWffaq9
	YtSeLLwfFV3th+RdcDAc2JRFMWGAW7iFYQKUF0yorZqbCasXhvl06osXGIzBZlR0LyTrN7
	QM4NgOj3rBccZXp8WR3zDGyRDQoKReHn63YJPJlRZ5pWGjK97jhyrBHNApX20g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1714483723;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mwErHmG4UO8ztPuhK0kP17O1Xx8eTHCjts15RwKqDbg=;
	b=zxC3KWWh8sNaJnqmF6JtKAMmNA29ldl9kzJZQzWxW6avRIeIlW6kL+i8zCddyhK5F/8IWX
	wRJ9C8O2FWIowuAA==
From: "tip-bot2 for Jacob Pan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/irq] KVM: VMX: Move posted interrupt descriptor out of VMX code
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Sean Christopherson <seanjc@google.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240423174114.526704-2-jacob.jun.pan@linux.intel.com>
References: <20240423174114.526704-2-jacob.jun.pan@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171448372295.10875.12289588267834639461.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/irq branch of tip:

Commit-ID:     699f67512f04cbaee965fad872702c06eaf440f6
Gitweb:        https://git.kernel.org/tip/699f67512f04cbaee965fad872702c06eaf440f6
Author:        Jacob Pan <jacob.jun.pan@linux.intel.com>
AuthorDate:    Tue, 23 Apr 2024 10:41:03 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 30 Apr 2024 00:54:42 +02:00

KVM: VMX: Move posted interrupt descriptor out of VMX code

To prepare native usage of posted interrupts, move the PID declarations out
of VMX code such that they can be shared.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Sean Christopherson <seanjc@google.com>
Link: https://lore.kernel.org/r/20240423174114.526704-2-jacob.jun.pan@linux.intel.com

---
 arch/x86/include/asm/posted_intr.h | 88 +++++++++++++++++++++++++++-
 arch/x86/kvm/vmx/posted_intr.h     | 93 +-----------------------------
 arch/x86/kvm/vmx/vmx.c             |  1 +-
 arch/x86/kvm/vmx/vmx.h             |  2 +-
 4 files changed, 91 insertions(+), 93 deletions(-)
 create mode 100644 arch/x86/include/asm/posted_intr.h

diff --git a/arch/x86/include/asm/posted_intr.h b/arch/x86/include/asm/posted_intr.h
new file mode 100644
index 0000000..f0324c5
--- /dev/null
+++ b/arch/x86/include/asm/posted_intr.h
@@ -0,0 +1,88 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _X86_POSTED_INTR_H
+#define _X86_POSTED_INTR_H
+
+#define POSTED_INTR_ON  0
+#define POSTED_INTR_SN  1
+
+#define PID_TABLE_ENTRY_VALID 1
+
+/* Posted-Interrupt Descriptor */
+struct pi_desc {
+	u32 pir[8];     /* Posted interrupt requested */
+	union {
+		struct {
+				/* bit 256 - Outstanding Notification */
+			u16	on	: 1,
+				/* bit 257 - Suppress Notification */
+				sn	: 1,
+				/* bit 271:258 - Reserved */
+				rsvd_1	: 14;
+				/* bit 279:272 - Notification Vector */
+			u8	nv;
+				/* bit 287:280 - Reserved */
+			u8	rsvd_2;
+				/* bit 319:288 - Notification Destination */
+			u32	ndst;
+		};
+		u64 control;
+	};
+	u32 rsvd[6];
+} __aligned(64);
+
+static inline bool pi_test_and_set_on(struct pi_desc *pi_desc)
+{
+	return test_and_set_bit(POSTED_INTR_ON, (unsigned long *)&pi_desc->control);
+}
+
+static inline bool pi_test_and_clear_on(struct pi_desc *pi_desc)
+{
+	return test_and_clear_bit(POSTED_INTR_ON, (unsigned long *)&pi_desc->control);
+}
+
+static inline bool pi_test_and_clear_sn(struct pi_desc *pi_desc)
+{
+	return test_and_clear_bit(POSTED_INTR_SN, (unsigned long *)&pi_desc->control);
+}
+
+static inline bool pi_test_and_set_pir(int vector, struct pi_desc *pi_desc)
+{
+	return test_and_set_bit(vector, (unsigned long *)pi_desc->pir);
+}
+
+static inline bool pi_is_pir_empty(struct pi_desc *pi_desc)
+{
+	return bitmap_empty((unsigned long *)pi_desc->pir, NR_VECTORS);
+}
+
+static inline void pi_set_sn(struct pi_desc *pi_desc)
+{
+	set_bit(POSTED_INTR_SN, (unsigned long *)&pi_desc->control);
+}
+
+static inline void pi_set_on(struct pi_desc *pi_desc)
+{
+	set_bit(POSTED_INTR_ON, (unsigned long *)&pi_desc->control);
+}
+
+static inline void pi_clear_on(struct pi_desc *pi_desc)
+{
+	clear_bit(POSTED_INTR_ON, (unsigned long *)&pi_desc->control);
+}
+
+static inline void pi_clear_sn(struct pi_desc *pi_desc)
+{
+	clear_bit(POSTED_INTR_SN, (unsigned long *)&pi_desc->control);
+}
+
+static inline bool pi_test_on(struct pi_desc *pi_desc)
+{
+	return test_bit(POSTED_INTR_ON, (unsigned long *)&pi_desc->control);
+}
+
+static inline bool pi_test_sn(struct pi_desc *pi_desc)
+{
+	return test_bit(POSTED_INTR_SN, (unsigned long *)&pi_desc->control);
+}
+
+#endif /* _X86_POSTED_INTR_H */
diff --git a/arch/x86/kvm/vmx/posted_intr.h b/arch/x86/kvm/vmx/posted_intr.h
index 2699207..6b2a022 100644
--- a/arch/x86/kvm/vmx/posted_intr.h
+++ b/arch/x86/kvm/vmx/posted_intr.h
@@ -1,98 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #ifndef __KVM_X86_VMX_POSTED_INTR_H
 #define __KVM_X86_VMX_POSTED_INTR_H
-
-#define POSTED_INTR_ON  0
-#define POSTED_INTR_SN  1
-
-#define PID_TABLE_ENTRY_VALID 1
-
-/* Posted-Interrupt Descriptor */
-struct pi_desc {
-	u32 pir[8];     /* Posted interrupt requested */
-	union {
-		struct {
-				/* bit 256 - Outstanding Notification */
-			u16	on	: 1,
-				/* bit 257 - Suppress Notification */
-				sn	: 1,
-				/* bit 271:258 - Reserved */
-				rsvd_1	: 14;
-				/* bit 279:272 - Notification Vector */
-			u8	nv;
-				/* bit 287:280 - Reserved */
-			u8	rsvd_2;
-				/* bit 319:288 - Notification Destination */
-			u32	ndst;
-		};
-		u64 control;
-	};
-	u32 rsvd[6];
-} __aligned(64);
-
-static inline bool pi_test_and_set_on(struct pi_desc *pi_desc)
-{
-	return test_and_set_bit(POSTED_INTR_ON,
-			(unsigned long *)&pi_desc->control);
-}
-
-static inline bool pi_test_and_clear_on(struct pi_desc *pi_desc)
-{
-	return test_and_clear_bit(POSTED_INTR_ON,
-			(unsigned long *)&pi_desc->control);
-}
-
-static inline bool pi_test_and_clear_sn(struct pi_desc *pi_desc)
-{
-	return test_and_clear_bit(POSTED_INTR_SN,
-			(unsigned long *)&pi_desc->control);
-}
-
-static inline bool pi_test_and_set_pir(int vector, struct pi_desc *pi_desc)
-{
-	return test_and_set_bit(vector, (unsigned long *)pi_desc->pir);
-}
-
-static inline bool pi_is_pir_empty(struct pi_desc *pi_desc)
-{
-	return bitmap_empty((unsigned long *)pi_desc->pir, NR_VECTORS);
-}
-
-static inline void pi_set_sn(struct pi_desc *pi_desc)
-{
-	set_bit(POSTED_INTR_SN,
-		(unsigned long *)&pi_desc->control);
-}
-
-static inline void pi_set_on(struct pi_desc *pi_desc)
-{
-	set_bit(POSTED_INTR_ON,
-		(unsigned long *)&pi_desc->control);
-}
-
-static inline void pi_clear_on(struct pi_desc *pi_desc)
-{
-	clear_bit(POSTED_INTR_ON,
-		(unsigned long *)&pi_desc->control);
-}
-
-static inline void pi_clear_sn(struct pi_desc *pi_desc)
-{
-	clear_bit(POSTED_INTR_SN,
-		(unsigned long *)&pi_desc->control);
-}
-
-static inline bool pi_test_on(struct pi_desc *pi_desc)
-{
-	return test_bit(POSTED_INTR_ON,
-			(unsigned long *)&pi_desc->control);
-}
-
-static inline bool pi_test_sn(struct pi_desc *pi_desc)
-{
-	return test_bit(POSTED_INTR_SN,
-			(unsigned long *)&pi_desc->control);
-}
+#include <asm/posted_intr.h>
 
 void vmx_vcpu_pi_load(struct kvm_vcpu *vcpu, int cpu);
 void vmx_vcpu_pi_put(struct kvm_vcpu *vcpu);
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 22411f4..273d264 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -70,6 +70,7 @@
 #include "x86.h"
 #include "smm.h"
 #include "vmx_onhyperv.h"
+#include "posted_intr.h"
 
 MODULE_AUTHOR("Qumranet");
 MODULE_LICENSE("GPL");
diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
index 90f9e44..7e48336 100644
--- a/arch/x86/kvm/vmx/vmx.h
+++ b/arch/x86/kvm/vmx/vmx.h
@@ -7,10 +7,10 @@
 #include <asm/kvm.h>
 #include <asm/intel_pt.h>
 #include <asm/perf_event.h>
+#include <asm/posted_intr.h>
 
 #include "capabilities.h"
 #include "../kvm_cache_regs.h"
-#include "posted_intr.h"
 #include "vmcs.h"
 #include "vmx_ops.h"
 #include "../cpuid.h"

