Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4E457C02D4
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 19:39:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233694AbjJJRjv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 13:39:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233604AbjJJRjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 13:39:49 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2AE5D7;
        Tue, 10 Oct 2023 10:39:44 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id 3f1490d57ef6-d9a3d737d66so1838542276.2;
        Tue, 10 Oct 2023 10:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696959584; x=1697564384; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=c/yA30J39p3R+cEj+Qw2hre1tLrE/L7D+ruLEDIk3qM=;
        b=T94PRguXqoagegHpmYcscFOoHkxx4wbT6LHetq9sis4eEZf++zsRSKDk7cEgcdt9E8
         +fakFTpQ8X2/XyN43a1L5JHrUHtcNtutcVvp8UPdelaQ96Jzwd6v6r7LiCmeCxy4Nhcf
         dUIyG6awvbGV87RZ638aA81Li6/qoxWDYAZfmOtJrjT16b4mEV5JvSHwxzTyzbLBw89i
         dywo2rsSnEOD76pxxGP46WOONHSqJ93WrBci7iHwp5uP5iDWMZpUA4Zs6fIXSSXR/2Lm
         d0+KG3Dl6oNRM/S1CUkurE/TtJtO6y0iwjSB5z/1+EhGqA0gUjHwnmDeHkrNriw+r0C/
         kl5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696959584; x=1697564384;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c/yA30J39p3R+cEj+Qw2hre1tLrE/L7D+ruLEDIk3qM=;
        b=gZ1Rg9kUHSsl8hOwaPALaMH4yHAk1s3NKfBz51uF4eQq+sMX3E4jobKSw0hv/suj8/
         4fz6n4U6jqdIi6HGEKDy2k/CnEwlo6ESebtaTUhJZlouMxyVQsgkB8PeCq4iuZ9slDr7
         T04u42tUu84PQb2g7+reFmEbnThi3Ew5EhHlmfOl9dBmJdtTFsW/V8hWDj6vwreCIfpW
         f4af0nF03pFAAmsk+qMGx2+QlpL+wBf6ej/thlhCVdEtBL/8ebm2KlfK/7164ct5hQeG
         sGesF5wOz9N2I1bv4h+O4J5nh0RPFxrExkkGm2qmK9DXWfvnvlSutcrbIbCwAtzSTcvy
         DjQg==
X-Gm-Message-State: AOJu0Yywq7bTaqUcfEHb9UprgQsNZwZeZF2l5fqQkCybn3tdJUSgrQnx
        nGF/Ev8P+3z10axG9zGH4m0=
X-Google-Smtp-Source: AGHT+IH2Qw4C8iG+DuwqBgGLWMpC8w2kEty6i3xOSJxBWfFTL8DaOHH5TvMD6QyQeRt0Ruy2GjA4Ww==
X-Received: by 2002:a5b:a50:0:b0:d97:213b:4775 with SMTP id z16-20020a5b0a50000000b00d97213b4775mr10865311ybq.34.1696959583666;
        Tue, 10 Oct 2023 10:39:43 -0700 (PDT)
Received: from pm2-ws13.praxislan02.com (207-172-141-204.s8906.c3-0.slvr-cbr1.lnh-slvr.md.cable.rcncustomer.com. [207.172.141.204])
        by smtp.gmail.com with ESMTPSA id y8-20020a0cf148000000b00655d711180dsm4930073qvl.17.2023.10.10.10.39.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 10:39:43 -0700 (PDT)
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
Subject: [PATCH v3] acpi/processor: sanitize _OSC/_PDC capabilities for Xen dom0
Date:   Tue, 10 Oct 2023 13:39:22 -0400
Message-ID: <20231010173924.44167-1-jandryuk@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
---
v3:
Move xen_sanitize_pdc() call to arch_acpi_set_proc_cap_bits() to cover
_OSC and _PDC.
drivers/xen/pcpu.c is CONFIG_DOM0 && CONFIG_X86

v2:
Move local variables in acpi_processor_eval_pdc() to reuse in both conditions.
---
 arch/x86/include/asm/acpi.h           | 13 +++++++++++++
 arch/x86/include/asm/xen/hypervisor.h |  9 +++++++++
 drivers/xen/pcpu.c                    | 21 +++++++++++++++++++++
 3 files changed, 43 insertions(+)

diff --git a/arch/x86/include/asm/acpi.h b/arch/x86/include/asm/acpi.h
index c8a7fc23f63c..cc8d1669d6e8 100644
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
@@ -127,6 +130,16 @@ static inline void arch_acpi_set_proc_cap_bits(u32 *cap)
 	if (!cpu_has(c, X86_FEATURE_MWAIT) ||
 	    boot_option_idle_override == IDLE_NOMWAIT)
 		*cap &= ~(ACPI_PROC_CAP_C_C1_FFH | ACPI_PROC_CAP_C_C2C3_FFH);
+
+	if (xen_initial_domain()) {
+		/*
+		 * When Linux is running as Xen dom0, the hypervisor is the
+		 * entity in charge of the processor power management, and so
+		 * Xen needs to check the OS capabilities reported in the _PDC
+		 * buffer matches what the hypervisor driver supports.
+		 */
+		xen_sanitize_pdc(cap);
+	}
 }
 
 static inline bool acpi_has_cpu_in_madt(void)
diff --git a/arch/x86/include/asm/xen/hypervisor.h b/arch/x86/include/asm/xen/hypervisor.h
index 7048dfacc04b..c6c2f174fa30 100644
--- a/arch/x86/include/asm/xen/hypervisor.h
+++ b/arch/x86/include/asm/xen/hypervisor.h
@@ -100,4 +100,13 @@ static inline void leave_lazy(enum xen_lazy_mode mode)
 
 enum xen_lazy_mode xen_get_lazy_mode(void);
 
+#if defined(CONFIG_XEN_DOM0) && defined(CONFIG_ACPI)
+void xen_sanitize_pdc(uint32_t *buf);
+#else
+static inline void xen_sanitize_pdc(uint32_t *buf)
+{
+	BUG();
+}
+#endif
+
 #endif /* _ASM_X86_XEN_HYPERVISOR_H */
diff --git a/drivers/xen/pcpu.c b/drivers/xen/pcpu.c
index b3e3d1bb37f3..859bb6027105 100644
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
@@ -400,4 +403,22 @@ bool __init xen_processor_present(uint32_t acpi_id)
 
 	return online;
 }
+
+void xen_sanitize_pdc(uint32_t *cap)
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
+		pr_info("sanitize of _PDC buffer bits from Xen failed: %d\n",
+			ret);
+	*cap = buf[2];
+}
 #endif
-- 
2.41.0

