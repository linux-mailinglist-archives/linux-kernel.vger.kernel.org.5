Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 553207E5FEE
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 22:25:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230474AbjKHVZp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 16:25:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjKHVZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 16:25:43 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D2E5211D;
        Wed,  8 Nov 2023 13:25:41 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-41cd7a3e8f8so1233601cf.0;
        Wed, 08 Nov 2023 13:25:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699478740; x=1700083540; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RZ7VQVWmywUCJj8m+Y7uBiNQefyfO/uFLoxjMz4m8no=;
        b=AnSMbOfsZOfKsohglvZ8Jfvj0vm29m8O/ZQ+ua0B/d7JeCH3HGmX9opotNosnyX91K
         oADTtJeqmPfcxU+m8oOe/ctn6OmzgL7Evba9COoDthjsZWbMn0b3cyNIgk9H9aFGZX4Y
         QIvXvbGU57lbHTjbI5Nap9n3/O9Noy3qmx1e2AK0/e4gbBXqTMCjkW8HOTlTkyInVkcj
         DAY0cXvHg031Unva9NYAmnNWnyC7tF1274LgteGKInIV0zSbPUd4UaJZpHk2QsCM0p3L
         sjg7d2HVKCUVKZcK80aGAva0AVbrWiuDqlZs6YOK2cnktSdHJPkbd+LF2RYMt04usDK+
         NQGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699478740; x=1700083540;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RZ7VQVWmywUCJj8m+Y7uBiNQefyfO/uFLoxjMz4m8no=;
        b=GttP0jNWmaDIOZzpDtq9WJ7PynO9es0x98wlf1bHeCy/c/AWiz9u1enuasWipouGE0
         zN8OgR7Faauiq8AgMLYLt42rIzwWowWdGr/wwxmsjGoZpYcl1MF4ILsp0DXpU6qzNluN
         SWQ+n9PirJtfqf4IeIl1cgXdUNXX2skv7AH+9V7gZKBUwcKFG4+DIgmfEiSmCHQGC4Tb
         iRwGm8eZrSKGC60M8GMaCJasDTG1N+5zYiCJxoHLzU8dLVdRFyZFWgZrfAHGS99PEfG6
         V3I13KSsLUwy5qK2ys5J4tPAWBZa3bIKTSbj8jxPy/Z+jg5rj4Zy06OYjIazxEnuivix
         HhcQ==
X-Gm-Message-State: AOJu0YxM+bqnQC8i1oJop8aaTa75bIsM9Lv5OnmC+XcTK1Tcwvjy6POB
        O6ksn84E+HsA5fWHepsKwTU=
X-Google-Smtp-Source: AGHT+IGjh5dBkGk6kw7u8KR2u2/K+crTHBl7T3vYG8QHmAVbTYadRWnd6zJ87hdm9CvDrMW6i+kbAg==
X-Received: by 2002:a05:622a:170a:b0:418:1084:1e1 with SMTP id h10-20020a05622a170a00b00418108401e1mr3687242qtk.57.1699478740620;
        Wed, 08 Nov 2023 13:25:40 -0800 (PST)
Received: from pm2-ws13.praxislan02.com (207-172-141-204.s8906.c3-0.slvr-cbr1.lnh-slvr.md.cable.rcncustomer.com. [207.172.141.204])
        by smtp.gmail.com with ESMTPSA id j14-20020ac85c4e000000b004181138e0c0sm1299644qtj.31.2023.11.08.13.25.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Nov 2023 13:25:39 -0800 (PST)
From:   Jason Andryuk <jandryuk@gmail.com>
To:     Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Cc:     michal.wilczynski@intel.com,
        Roger Pau Monne <roger.pau@citrix.com>,
        stable@vger.kernel.org, Jason Andryuk <jandryuk@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org
Subject: [PATCH v5] acpi/processor: sanitize _OSC/_PDC capabilities for Xen dom0
Date:   Wed,  8 Nov 2023 16:25:15 -0500
Message-ID: <20231108212517.72279-1-jandryuk@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roger Pau Monne <roger.pau@citrix.com>

The Processor capability bits notify ACPI of the OS capabilities, and
so ACPI can adjust the return of other Processor methods taking the OS
capabilities into account.

When Linux is running as a Xen dom0, the hypervisor is the entity
in charge of processor power management, and hence Xen needs to make
sure the capabilities reported by _OSC/_PDC match the capabilities of
the driver in Xen.

Introduce a small helper to sanitize the buffer when running as Xen
dom0.

When Xen supports HWP, this serves as the equivalent of commit
a21211672c9a ("ACPI / processor: Request native thermal interrupt
handling via _OSC") to avoid SMM crashes.  Xen will set bit
ACPI_PROC_CAP_COLLAB_PROC_PERF (bit 12) in the capability bits and the
_OSC/_PDC call will apply it.

[ jandryuk: Mention Xen HWP's need.  Support _OSC & _PDC ]
Signed-off-by: Roger Pau Monné <roger.pau@citrix.com>
Cc: stable@vger.kernel.org
Signed-off-by: Jason Andryuk <jandryuk@gmail.com>
Reviewed-by: Michal Wilczynski <michal.wilczynski@intel.com>
Reviewed-by: Juergen Gross <jgross@suse.com>
---
v5:
Only update caps on hypercall success - Roger
Add Juergen & Michal Reviewed-by: - hopefully okay with above change

v4:
Use xen_santize_proc_cap_bits() name - Michal
Rephrase comment - Michal

v3:
Move xen_sanitize_pdc() call to arch_acpi_set_proc_cap_bits() to cover
_OSC and _PDC.
drivers/xen/pcpu.c is CONFIG_DOM0 && CONFIG_X86

v2:
Move local variables in acpi_processor_eval_pdc() to reuse in both conditions.
---
 arch/x86/include/asm/acpi.h           | 14 ++++++++++++++
 arch/x86/include/asm/xen/hypervisor.h |  9 +++++++++
 drivers/xen/pcpu.c                    | 22 ++++++++++++++++++++++
 3 files changed, 45 insertions(+)

diff --git a/arch/x86/include/asm/acpi.h b/arch/x86/include/asm/acpi.h
index c8a7fc23f63c..f896eed4516c 100644
--- a/arch/x86/include/asm/acpi.h
+++ b/arch/x86/include/asm/acpi.h
@@ -16,6 +16,9 @@
 #include <asm/x86_init.h>
 #include <asm/cpufeature.h>
 #include <asm/irq_vectors.h>
+#include <asm/xen/hypervisor.h>
+
+#include <xen/xen.h>
 
 #ifdef CONFIG_ACPI_APEI
 # include <asm/pgtable_types.h>
@@ -127,6 +130,17 @@ static inline void arch_acpi_set_proc_cap_bits(u32 *cap)
 	if (!cpu_has(c, X86_FEATURE_MWAIT) ||
 	    boot_option_idle_override == IDLE_NOMWAIT)
 		*cap &= ~(ACPI_PROC_CAP_C_C1_FFH | ACPI_PROC_CAP_C_C2C3_FFH);
+
+	if (xen_initial_domain()) {
+		/*
+		 * When Linux is running as Xen dom0, the hypervisor is the
+		 * entity in charge of the processor power management, and so
+		 * Xen needs to check the OS capabilities reported in the
+		 * processor capabilities buffer matches what the hypervisor
+		 * driver supports.
+		 */
+		xen_sanitize_proc_cap_bits(cap);
+	}
 }
 
 static inline bool acpi_has_cpu_in_madt(void)
diff --git a/arch/x86/include/asm/xen/hypervisor.h b/arch/x86/include/asm/xen/hypervisor.h
index 7048dfacc04b..a9088250770f 100644
--- a/arch/x86/include/asm/xen/hypervisor.h
+++ b/arch/x86/include/asm/xen/hypervisor.h
@@ -100,4 +100,13 @@ static inline void leave_lazy(enum xen_lazy_mode mode)
 
 enum xen_lazy_mode xen_get_lazy_mode(void);
 
+#if defined(CONFIG_XEN_DOM0) && defined(CONFIG_ACPI)
+void xen_sanitize_proc_cap_bits(uint32_t *buf);
+#else
+static inline void xen_sanitize_proc_cap_bits(uint32_t *buf)
+{
+	BUG();
+}
+#endif
+
 #endif /* _ASM_X86_XEN_HYPERVISOR_H */
diff --git a/drivers/xen/pcpu.c b/drivers/xen/pcpu.c
index b3e3d1bb37f3..508655273145 100644
--- a/drivers/xen/pcpu.c
+++ b/drivers/xen/pcpu.c
@@ -47,6 +47,9 @@
 #include <asm/xen/hypervisor.h>
 #include <asm/xen/hypercall.h>
 
+#ifdef CONFIG_ACPI
+#include <acpi/processor.h>
+#endif
 
 /*
  * @cpu_id: Xen physical cpu logic number
@@ -400,4 +403,23 @@ bool __init xen_processor_present(uint32_t acpi_id)
 
 	return online;
 }
+
+void xen_sanitize_proc_cap_bits(uint32_t *cap)
+{
+	struct xen_platform_op op = {
+		.cmd			= XENPF_set_processor_pminfo,
+		.u.set_pminfo.id	= -1,
+		.u.set_pminfo.type	= XEN_PM_PDC,
+	};
+	u32 buf[3] = { ACPI_PDC_REVISION_ID, 1, *cap };
+	int ret;
+
+	set_xen_guest_handle(op.u.set_pminfo.pdc, buf);
+	ret = HYPERVISOR_platform_op(&op);
+	if (ret)
+		pr_err("sanitize of _PDC buffer bits from Xen failed: %d\n",
+		       ret);
+	else
+		*cap = buf[2];
+}
 #endif
-- 
2.41.0

