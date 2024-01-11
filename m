Return-Path: <linux-kernel+bounces-23319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9CAB82AB04
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 10:32:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FF33284C81
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 09:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A68B514F85;
	Thu, 11 Jan 2024 09:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="aAhgOOjr"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEAAF14F77
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 09:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-5cddfe0cb64so2241101a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 01:31:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1704965477; x=1705570277; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cUtZ/fl35OGrV0n4xrT7BhxLu5Q7HTfNcZ5vLHqEvsY=;
        b=aAhgOOjriQGmuzcaLibbZYF/b0kB2ZBDGRV4mR9LeIBAz8s51PwlgJF50yUhIXudLl
         Y43c9cI3Og7sdQ/hmDFoV2RDzcw/XfQMWsJhfMMKbkdA7D1S5HfdGI+dS98i+cpg8rfn
         FnME2T9wGG2g4qhaWz7MOSO3uKp/G26iAek3FvUj5GGqAo11UFehInxOgoLb4Ypc3MBq
         0sJhgef9UnXBfDc4/9Je0klHvh0MUwOE+DxaiD+xbcVwnRWR5yY8bGJoM6kbw1gyGxaj
         uY9EZ0RI50vYjHGvLcjNmuq2v+5URsYtBfDFp/l7JdzR2sU02C1M88u2FaVvT24V5FCF
         lJkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704965477; x=1705570277;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cUtZ/fl35OGrV0n4xrT7BhxLu5Q7HTfNcZ5vLHqEvsY=;
        b=S322wmHyYKp6n88rCzPsdBDUystIEa1rlYDhoSTC3uaBF+C91m98gZ7Ra4Ue79WEC0
         R98D1Bb3CBCZnffv7c193HqtErj+WZ04sJydQBwFlILYIY/nJx0kIiTH6lsSY9AjRapM
         RjNSCFu8ID+gMs0cxo+faGQ28LlX7pZkx7U31vZKfVO9kTCdOZvATU6KlVK5ZgPEYzDM
         Z8GwGAV/7r8h5QjdMQQSLiCfjKr45B2xK/qsWvFud51+1cm2iY9jCyBEL5NhlegmDtO1
         W2UptASQSUflj/ZqYbw9Kz4ePr00ZOTAJdTs5pdobpW0OCMtdXIHOvWhTPsxCCMIncv+
         qm5w==
X-Gm-Message-State: AOJu0Yx42e8em54Iy03FULPUEriJUP8gDkXZIbmpQjvqLnb0q24YJA5n
	XWFxqUAIAKaNCUCkWNN/PIPVIMlp36FmZA==
X-Google-Smtp-Source: AGHT+IF4264zzKBNpeub4VH/x1A2zu/MAt7+saMEpmuhHRaKZH8w152mN6eN2xwM9KYg/qXnJMYHcw==
X-Received: by 2002:a05:6a21:32aa:b0:19a:1719:8cd4 with SMTP id yt42-20020a056a2132aa00b0019a17198cd4mr595390pzb.107.1704965476861;
        Thu, 11 Jan 2024 01:31:16 -0800 (PST)
Received: from sunil-laptop.. ([106.51.188.200])
        by smtp.gmail.com with ESMTPSA id jd2-20020a170903260200b001d4a7cf0673sm730566plb.117.2024.01.11.01.31.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 01:31:16 -0800 (PST)
From: Sunil V L <sunilvl@ventanamicro.com>
To: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-riscv@lists.infradead.org
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Anup Patel <anup@brainfault.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Conor Dooley <conor@kernel.org>,
	Andrew Jones <ajones@ventanamicro.com>,
	Atish Kumar Patra <atishp@rivosinc.com>,
	Sunil V L <sunilvl@ventanamicro.com>
Subject: [PATCH -next 2/2] cpuidle: RISC-V: Add ACPI LPI support
Date: Thu, 11 Jan 2024 15:00:58 +0530
Message-Id: <20240111093058.121838-3-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240111093058.121838-1-sunilvl@ventanamicro.com>
References: <20240111093058.121838-1-sunilvl@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add required callbacks to support Low Power Idle (LPI) on ACPI based
RISC-V platforms.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 drivers/cpuidle/cpuidle-riscv-sbi.c | 78 +++++++++++++++++++++++++++++
 1 file changed, 78 insertions(+)

diff --git a/drivers/cpuidle/cpuidle-riscv-sbi.c b/drivers/cpuidle/cpuidle-riscv-sbi.c
index e8094fc92491..cea67a54ab39 100644
--- a/drivers/cpuidle/cpuidle-riscv-sbi.c
+++ b/drivers/cpuidle/cpuidle-riscv-sbi.c
@@ -632,3 +632,81 @@ static int __init sbi_cpuidle_init(void)
 	return 0;
 }
 device_initcall(sbi_cpuidle_init);
+
+#ifdef CONFIG_ACPI_PROCESSOR_IDLE
+
+#include <linux/acpi.h>
+#include <acpi/processor.h>
+
+#define RISCV_FFH_LPI_TYPE_MASK		0x1000000000000000ULL
+#define RISCV_FFH_LPI_RSVD_MASK		0x0FFFFFFF00000000ULL
+
+static int acpi_cpu_init_idle(unsigned int cpu)
+{
+	int i;
+	struct acpi_lpi_state *lpi;
+	struct acpi_processor *pr = per_cpu(processors, cpu);
+
+	if (unlikely(!pr || !pr->flags.has_lpi))
+		return -EINVAL;
+
+	/*
+	 * The SBI HSM suspend function is only available when:
+	 * 1) SBI version is 0.3 or higher
+	 * 2) SBI HSM extension is available
+	 */
+	if (sbi_spec_version < sbi_mk_version(0, 3) ||
+	    !sbi_probe_extension(SBI_EXT_HSM)) {
+		pr_warn("HSM suspend not available\n");
+		return -EINVAL;
+	}
+
+	if (pr->power.count <= 1)
+		return -ENODEV;
+
+	for (i = 1; i < pr->power.count; i++) {
+		u32 state;
+
+		lpi = &pr->power.lpi_states[i];
+
+		/* Validate Entry Method as per FFH spec.
+		 * bits[63:60] should be 0x1
+		 * bits[59:32] should be 0x0
+		 * bits[31:0] represent a SBI power_state
+		 */
+		if (!(lpi->address & RISCV_FFH_LPI_TYPE_MASK) ||
+		    (lpi->address & RISCV_FFH_LPI_RSVD_MASK)) {
+			pr_warn("Invalid LPI entry method %#llx\n", lpi->address);
+			return -EINVAL;
+		}
+
+		state = lpi->address;
+		if (!sbi_suspend_state_is_valid(state)) {
+			pr_warn("Invalid SBI power state %#x\n", state);
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
+int acpi_processor_ffh_lpi_probe(unsigned int cpu)
+{
+	return acpi_cpu_init_idle(cpu);
+}
+
+int acpi_processor_ffh_lpi_enter(struct acpi_lpi_state *lpi)
+{
+	u32 state = lpi->address;
+
+	if (state & SBI_HSM_SUSP_NON_RET_BIT)
+		return CPU_PM_CPU_IDLE_ENTER_PARAM(sbi_suspend,
+						   lpi->index,
+						   state);
+	else
+		return CPU_PM_CPU_IDLE_ENTER_RETENTION_PARAM(sbi_suspend,
+							     lpi->index,
+							     state);
+}
+
+#endif
-- 
2.34.1


