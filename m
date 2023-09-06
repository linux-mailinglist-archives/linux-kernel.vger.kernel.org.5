Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF6247942FD
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 20:21:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243847AbjIFSVp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 14:21:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237740AbjIFSVn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 14:21:43 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CADEB10CA;
        Wed,  6 Sep 2023 11:21:36 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id af79cd13be357-76dc7b0da9fso8719385a.1;
        Wed, 06 Sep 2023 11:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694024496; x=1694629296; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zklSHdsI2UWJPNn1ecr8Eo6vQMjVOJa/0zR4bl3TAqc=;
        b=I4AfqcsyHgvp/9XkeB99SsAy4veuUaDrizA78uwUUwxNCDBpVp5AHH7RK/BOX9RYLu
         Cb2FF0FDDWsk+MZvegfm8+9B2UxIOJXLQ4zQLurZLTzwFag3a9gm+abt+xZR3C+xDrOW
         bn9eGcvlRLbPEJP3mMPabyiwOn3biErJrazNfQcTQAUnj82HFGfIr+fdK5yv2Y+YpSn6
         jjJcgnnRQPMrML2CEUvLmXAyEuniOsgrMZd/xKzSkLr2oKRaK4FIUul87U4Ysr9BoIje
         MfbE/ixwHrOW8WKjICw6I+g9RhQjddCxB2yzsOOKYyQS3ksSu9XS10/kcNfTsiDQt8MI
         TeSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694024496; x=1694629296;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zklSHdsI2UWJPNn1ecr8Eo6vQMjVOJa/0zR4bl3TAqc=;
        b=J9hm5rqRfA3Zhpog8o4346ky9DdNaZVAvxqBmraS/3MtpdUEIJEkMdelFBU+jIgJY1
         77RhZBmrZu1IZwuutq4bpQ3oQqMuYrgwpGGDcJ8Z1aZg0QrYGejdfmV7qXv/6d7hiVlI
         U5hXdq2njhWgyN8hiYXfr8m/4cxtV+vECZCA7aRxnshx/gI4++HyWBJbIvt56RKsfQ3P
         R7mBomqDA0HIf8+Jnasg+anlKs7EEoLkznHcWpo/xK2E+PRB39N2YLtqkkxrOg9HUKU9
         j5cX79mif/GytHzxkCifkfvepu+vuwY8XRwYYQP8u8R239FfyRU55W3YwZKlUfwUHt1v
         /Oxg==
X-Gm-Message-State: AOJu0YyKaWkTkPVWdfldVWJEKUd/ut6aol2CVVCILltwXU+ARbffwZ6c
        fE5BIL+cfTxZkH2YYmgWVb8=
X-Google-Smtp-Source: AGHT+IGHLnABm96FdDRUcT50m1IX58j6HqwLhDE/W1lxdQtnCSL26QzqbxI+re/ZCl4UzGIAe5nrRQ==
X-Received: by 2002:a05:620a:248a:b0:76e:f5c5:1bac with SMTP id i10-20020a05620a248a00b0076ef5c51bacmr19230155qkn.48.1694024495823;
        Wed, 06 Sep 2023 11:21:35 -0700 (PDT)
Received: from pm2-ws13.praxislan02.com (207-172-141-204.s8906.c3-0.slvr-cbr1.lnh-slvr.md.cable.rcncustomer.com. [207.172.141.204])
        by smtp.gmail.com with ESMTPSA id f9-20020a05620a15a900b0076ee82f7726sm5090024qkk.132.2023.09.06.11.21.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 11:21:34 -0700 (PDT)
From:   Jason Andryuk <jandryuk@gmail.com>
To:     Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>
Cc:     Roger Pau Monne <roger.pau@citrix.com>, stable@vger.kernel.org,
        Jason Andryuk <jandryuk@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: [PATCH v2] acpi/processor: sanitize _PDC buffer bits when running as Xen dom0
Date:   Wed,  6 Sep 2023 14:21:23 -0400
Message-ID: <20230906182125.48642-1-jandryuk@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Roger Pau Monne <roger.pau@citrix.com>

The Processor _PDC buffer bits notify ACPI of the OS capabilities, and
so ACPI can adjust the return of other Processor methods taking the OS
capabilities into account.

When Linux is running as a Xen dom0, it's the hypervisor the entity
in charge of processor power management, and hence Xen needs to make
sure the capabilities reported in the _PDC buffer match the
capabilities of the driver in Xen.

Introduce a small helper to sanitize the buffer when running as Xen
dom0.

When Xen supports HWP, this serves as the equivalent of commit
a21211672c9a ("ACPI / processor: Request native thermal interrupt
handling via _OSC") to avoid SMM crashes.  Xen will set bit 12 in the
_PDC bits and the _PDC call will apply it.

[ jandryuk: Mention Xen HWP's need.  Move local variables ]
Signed-off-by: Roger Pau Monné <roger.pau@citrix.com>
Cc: stable@vger.kernel.org
Signed-off-by: Jason Andryuk <jandryuk@gmail.com>
---
v2:
Move local variables in acpi_processor_eval_pdc() to reuse in both conditions.
---
 arch/x86/include/asm/xen/hypervisor.h |  6 ++++++
 arch/x86/xen/enlighten.c              | 19 +++++++++++++++++++
 drivers/acpi/processor_pdc.c          | 22 ++++++++++++++++------
 3 files changed, 41 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/xen/hypervisor.h b/arch/x86/include/asm/xen/hypervisor.h
index 5fc35f889cd1..0f88a7e450d3 100644
--- a/arch/x86/include/asm/xen/hypervisor.h
+++ b/arch/x86/include/asm/xen/hypervisor.h
@@ -63,4 +63,10 @@ void __init xen_pvh_init(struct boot_params *boot_params);
 void __init mem_map_via_hcall(struct boot_params *boot_params_p);
 #endif
 
+#ifdef CONFIG_XEN_DOM0
+void xen_sanitize_pdc(uint32_t *buf);
+#else
+static inline void xen_sanitize_pdc(uint32_t *buf) { BUG(); }
+#endif
+
 #endif /* _ASM_X86_XEN_HYPERVISOR_H */
diff --git a/arch/x86/xen/enlighten.c b/arch/x86/xen/enlighten.c
index b8db2148c07d..9f7fc11330a3 100644
--- a/arch/x86/xen/enlighten.c
+++ b/arch/x86/xen/enlighten.c
@@ -346,3 +346,22 @@ void xen_arch_unregister_cpu(int num)
 }
 EXPORT_SYMBOL(xen_arch_unregister_cpu);
 #endif
+
+#ifdef CONFIG_XEN_DOM0
+void xen_sanitize_pdc(uint32_t *buf)
+{
+	struct xen_platform_op op = {
+		.cmd			= XENPF_set_processor_pminfo,
+		.interface_version	= XENPF_INTERFACE_VERSION,
+		.u.set_pminfo.id	= -1,
+		.u.set_pminfo.type	= XEN_PM_PDC,
+	};
+	int ret;
+
+	set_xen_guest_handle(op.u.set_pminfo.pdc, buf);
+	ret = HYPERVISOR_platform_op(&op);
+	if (ret)
+		pr_info("sanitize of _PDC buffer bits from Xen failed: %d\n",
+		        ret);
+}
+#endif
diff --git a/drivers/acpi/processor_pdc.c b/drivers/acpi/processor_pdc.c
index 18fb04523f93..9393dd4a3158 100644
--- a/drivers/acpi/processor_pdc.c
+++ b/drivers/acpi/processor_pdc.c
@@ -122,6 +122,11 @@ static acpi_status
 acpi_processor_eval_pdc(acpi_handle handle, struct acpi_object_list *pdc_in)
 {
 	acpi_status status = AE_OK;
+	union acpi_object *obj;
+	u32 *buffer = NULL;
+
+	obj = pdc_in->pointer;
+	buffer = (u32 *)(obj->buffer.pointer);
 
 	if (boot_option_idle_override == IDLE_NOMWAIT) {
 		/*
@@ -129,14 +134,19 @@ acpi_processor_eval_pdc(acpi_handle handle, struct acpi_object_list *pdc_in)
 		 * mode will be disabled in the parameter of _PDC object.
 		 * Of course C1_FFH access mode will also be disabled.
 		 */
-		union acpi_object *obj;
-		u32 *buffer = NULL;
-
-		obj = pdc_in->pointer;
-		buffer = (u32 *)(obj->buffer.pointer);
 		buffer[2] &= ~(ACPI_PDC_C_C2C3_FFH | ACPI_PDC_C_C1_FFH);
-
 	}
+
+	if (xen_initial_domain()) {
+		/*
+		 * When Linux is running as Xen dom0, the hypervisor is the
+		 * entity in charge of the processor power management, and so
+		 * Xen needs to check the OS capabilities reported in the _PDC
+		 * buffer matches what the hypervisor driver supports.
+		 */
+		xen_sanitize_pdc(buffer);
+	}
+
 	status = acpi_evaluate_object(handle, "_PDC", pdc_in, NULL);
 
 	if (ACPI_FAILURE(status))
-- 
2.41.0

