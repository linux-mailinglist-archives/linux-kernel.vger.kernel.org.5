Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C15C7C9864
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 10:41:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233534AbjJOIlG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 04:41:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233421AbjJOIlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 04:41:05 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 257EAC5
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 01:41:03 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-9adb9fa7200so713098266b.0
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 01:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697359261; x=1697964061; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=g4DjT3Phka8w5skOZXUV7G8lYOeliLen0y3NNyRZq5o=;
        b=JBXxB91lV4iZkpjOv0s3XN+IGPm0R9boPcfz9AG+4Ecth3R73bztBxoGeOTWPkv9Gb
         UrtLxLX6CYqE7g7d8UlTDz8mYliCwfzo7TJ510yfMRYV3JZ92+OS2aNJUOEaR872GQO0
         D7MXDZbBtmTEKy82IiA1xXQrD8Zve+Wv7U/u4Qj14wNiJK+aTWCpy+pbyhwZl1A3/Bm6
         RAl1KTkzwV4W9UMViFZyp/WaHs+DnkqKWyVMcO7j8F50vqQ+BpNjah8WKbqIgfeycNZk
         fIf/vtEA6X/8o2/ftxGs4oPEWJya5mxkEGsU2gTcr0wHvgPZjEXsSgDzIXN2oD+IH5oy
         Qv7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697359261; x=1697964061;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g4DjT3Phka8w5skOZXUV7G8lYOeliLen0y3NNyRZq5o=;
        b=UbN3vSqUI4oa396ig7zufebirj2ZLts2uitvy/rd2sT29gh3vkIz48yKop2M0sdqu0
         TL6ycZ9eM1efVf/3PYnKUme0XOJVfiNeKZJjpM/ODSWAnGg6FpYwjzW9nh142EZtjqJZ
         z7w8c0jvtAP/qD+v8wZIPH4ZJ0ZhKqd1yhiZwOhmS8wnA+hD/dpeR53Z/QLESu0YzUUS
         tE6HmQzsxkGhZCnAdkw3oa1gGuubDtVoufN3NHtE77q+Zh7xLVbQsbQdfAF3LQShQG4d
         4DrLCc1y/qfcnH25dCInJCxtH/PDY95q6VR7KxjA9mB+v38eASuy1YsLTA3K6AZi1DNh
         RdGg==
X-Gm-Message-State: AOJu0YzcDiN36QwdZp+Og8a5aNmHt7GR7InHEVJSti9e+MSbYX9l5JVQ
        Tib61jdp9YJ+MAQ6uAsEYNk=
X-Google-Smtp-Source: AGHT+IGvccDQJIwPFkgr5OBRmNSlJ9j8DhX5WqCnKIURU6aaSX8BKYwwgSO9OiPDPQdLUUjdZx7fcw==
X-Received: by 2002:a17:907:7fa8:b0:9aa:206d:b052 with SMTP id qk40-20020a1709077fa800b009aa206db052mr4719301ejc.27.1697359260807;
        Sun, 15 Oct 2023 01:41:00 -0700 (PDT)
Received: from gmail.com (1F2EF7B2.nat.pool.telekom.hu. [31.46.247.178])
        by smtp.gmail.com with ESMTPSA id kg9-20020a17090776e900b009b957d5237asm1969699ejc.80.2023.10.15.01.40.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Oct 2023 01:41:00 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Sun, 15 Oct 2023 10:40:58 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] CPU hotplug fix
Message-ID: <ZSulmjIwmcZdkMGg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest smp/urgent git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git smp-urgent-2023-10-15

   # HEAD: c4dd854f740c21ae8dd9903fc67969c5497cb14b cpu-hotplug: Provide prototypes for arch CPU registration

Fix a Longsoon build warning by harmonizing the arch_[un]register_cpu()
prototypes between architectures.

 Thanks,

	Ingo

------------------>
Russell King (Oracle) (1):
      cpu-hotplug: Provide prototypes for arch CPU registration


 arch/ia64/include/asm/cpu.h   | 5 -----
 arch/ia64/kernel/topology.c   | 2 +-
 arch/x86/include/asm/cpu.h    | 2 --
 arch/x86/kernel/topology.c    | 2 +-
 drivers/acpi/acpi_processor.c | 1 +
 include/acpi/processor.h      | 5 -----
 include/linux/cpu.h           | 2 ++
 7 files changed, 5 insertions(+), 14 deletions(-)

diff --git a/arch/ia64/include/asm/cpu.h b/arch/ia64/include/asm/cpu.h
index db125df9e088..642d71675ddb 100644
--- a/arch/ia64/include/asm/cpu.h
+++ b/arch/ia64/include/asm/cpu.h
@@ -15,9 +15,4 @@ DECLARE_PER_CPU(struct ia64_cpu, cpu_devices);
 
 DECLARE_PER_CPU(int, cpu_state);
 
-#ifdef CONFIG_HOTPLUG_CPU
-extern int arch_register_cpu(int num);
-extern void arch_unregister_cpu(int);
-#endif
-
 #endif /* _ASM_IA64_CPU_H_ */
diff --git a/arch/ia64/kernel/topology.c b/arch/ia64/kernel/topology.c
index 94a848b06f15..741863a187a6 100644
--- a/arch/ia64/kernel/topology.c
+++ b/arch/ia64/kernel/topology.c
@@ -59,7 +59,7 @@ void __ref arch_unregister_cpu(int num)
 }
 EXPORT_SYMBOL(arch_unregister_cpu);
 #else
-static int __init arch_register_cpu(int num)
+int __init arch_register_cpu(int num)
 {
 	return register_cpu(&sysfs_cpus[num].cpu, num);
 }
diff --git a/arch/x86/include/asm/cpu.h b/arch/x86/include/asm/cpu.h
index 3a233ebff712..25050d953eee 100644
--- a/arch/x86/include/asm/cpu.h
+++ b/arch/x86/include/asm/cpu.h
@@ -28,8 +28,6 @@ struct x86_cpu {
 };
 
 #ifdef CONFIG_HOTPLUG_CPU
-extern int arch_register_cpu(int num);
-extern void arch_unregister_cpu(int);
 extern void soft_restart_cpu(void);
 #endif
 
diff --git a/arch/x86/kernel/topology.c b/arch/x86/kernel/topology.c
index ca004e2e4469..0bab03130033 100644
--- a/arch/x86/kernel/topology.c
+++ b/arch/x86/kernel/topology.c
@@ -54,7 +54,7 @@ void arch_unregister_cpu(int num)
 EXPORT_SYMBOL(arch_unregister_cpu);
 #else /* CONFIG_HOTPLUG_CPU */
 
-static int __init arch_register_cpu(int num)
+int __init arch_register_cpu(int num)
 {
 	return register_cpu(&per_cpu(cpu_devices, num).cpu, num);
 }
diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
index c711db8a9c33..0f5218e361df 100644
--- a/drivers/acpi/acpi_processor.c
+++ b/drivers/acpi/acpi_processor.c
@@ -12,6 +12,7 @@
 #define pr_fmt(fmt) "ACPI: " fmt
 
 #include <linux/acpi.h>
+#include <linux/cpu.h>
 #include <linux/device.h>
 #include <linux/dmi.h>
 #include <linux/kernel.h>
diff --git a/include/acpi/processor.h b/include/acpi/processor.h
index 94181fe9780a..3f34ebb27525 100644
--- a/include/acpi/processor.h
+++ b/include/acpi/processor.h
@@ -465,9 +465,4 @@ extern int acpi_processor_ffh_lpi_probe(unsigned int cpu);
 extern int acpi_processor_ffh_lpi_enter(struct acpi_lpi_state *lpi);
 #endif
 
-#ifdef CONFIG_ACPI_HOTPLUG_CPU
-extern int arch_register_cpu(int cpu);
-extern void arch_unregister_cpu(int cpu);
-#endif
-
 #endif
diff --git a/include/linux/cpu.h b/include/linux/cpu.h
index 0abd60a7987b..eb768a866fe3 100644
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -80,6 +80,8 @@ extern __printf(4, 5)
 struct device *cpu_device_create(struct device *parent, void *drvdata,
 				 const struct attribute_group **groups,
 				 const char *fmt, ...);
+extern int arch_register_cpu(int cpu);
+extern void arch_unregister_cpu(int cpu);
 #ifdef CONFIG_HOTPLUG_CPU
 extern void unregister_cpu(struct cpu *cpu);
 extern ssize_t arch_cpu_probe(const char *, size_t);
