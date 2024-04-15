Return-Path: <linux-kernel+bounces-145612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AFEF48A5888
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 19:05:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66D3D2820E7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 17:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FA11127E15;
	Mon, 15 Apr 2024 17:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="ioW7xzZI"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36235127B65
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 17:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713200566; cv=none; b=XrMNtHoe18VFmUy31fDV+a+J41iOPMsKT44YXQGu63q1X4yTZnBSsHDlgpkrKAl1qGJ0HKkbFcZsw3vQKlRCK3lALdUwVxo696wDY2++MuqIx+bt/DSfzx+owZvHcK6rS+b4b9kp+oskQ6XFOxvjV1+xHxkKRKzq4zuIePU3Myo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713200566; c=relaxed/simple;
	bh=lcp2vRbGtp8KCmYdWlqSYigWg+ei7eHBlhWOvHRhJIg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SBd0grR7VhFMAFzwIsV3mlaK9PScTbsIRXS1OrKcmp4ctQh5DvekWVBKpqiQSnFGy6YvnYAbsvDkPjyKBl6sve5xxRpYesGC4Om/QvIROHEGkADDv8udod+bPvax/LWy4NjaSve6p5FkwnHG0tDn1QQlt9dipLAlTaA0mHs0CTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=ioW7xzZI; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6ed01c63657so3100348b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 10:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1713200564; x=1713805364; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YAAOkQmqhfZx+8yFnraUuWf5SW+MXW6uPQvUnDzGd+Y=;
        b=ioW7xzZIk8X+LdD2s7acWrWptFqCbqbPHIycyzyE8GM99fBjF1QbenXW0QKzNCuB5C
         4S/Z3z4fisDf/s2kpMdkEHKTW9zZL7+tiNU/ds97bdB0uWFF4UwxSTZwEQTI3NLWSdr8
         B8LZgYQlc5Uk0n1UuBwG29/MVg6aWkxvzuiF/svAw61s9fk/1Ao3hQAbP0mrSheRFgfB
         9Y+P3wG762bAPK1deXea/0nZlnIE21HGaiBhyZr+Oll/8tYwdcds0YZ3vXYJkc/q3EL+
         6uYyPzpwzxEop479PzdXYb/R4BfRG14/hQ++m65J6Wy2QYG+DRIV/LUTLHsiXON5TuSx
         PSDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713200564; x=1713805364;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YAAOkQmqhfZx+8yFnraUuWf5SW+MXW6uPQvUnDzGd+Y=;
        b=PmYa3z0j27qDd1Cg1tmDUT9u0xZmGqat4q+Koc2NuYjy0ofMtlg9IJ/SI3fRH15Xh+
         +AvAo5/sLoqUOcbhlHOM5dJUeZtQfzQmtF2M/BInWoXM44GRrzrifQJHz4lwmVAkzR4M
         ruLdAj+KXGCaTW6hDWtW50OLInrH6sCJJPG1MZwiEv3NLOVYUZ5AwnC1fxtyStPCt3Y+
         HSaAnyL9EviFV+UOEzbFbI+6u3EjjTX6KTsfAU1RlZLmjSCGRKbuHcirzxENvb6wTBBt
         wOei309TjFajtgLEFnXjFhjBuHTCTDh9Jedp4Lzd3TBibWcTA2DemS3Yt9rO9WP7tjex
         jK1w==
X-Forwarded-Encrypted: i=1; AJvYcCWAuPupDFWntw06RCKTYhz0BuzD5skOE+3wc9n1nSFqAUUs3qvc4TYlpkomzmznO0T36fKtIiHJuFoOV+ABWkCyOgRElbcOAMr0pX8E
X-Gm-Message-State: AOJu0YxJgyJ/YbhdFuvHvpAYvVvdV/wEa3NLoQB39/LKVEBHRJ0HtWPU
	qziotQc/yuQ7oOew4Ar3GfgByFy454+ezCmf5yeVWUj4NE5OG0eorCp/A+upN10=
X-Google-Smtp-Source: AGHT+IG8/n77ZcwDo0dpINsAseTYN5DCCn1UfCXRDczymjXSK0MA9f3AzxnPM1y3GqoYLRAp+ADrkw==
X-Received: by 2002:a05:6a00:4686:b0:6ee:1b6e:662a with SMTP id de6-20020a056a00468600b006ee1b6e662amr7890055pfb.32.1713200564540;
        Mon, 15 Apr 2024 10:02:44 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.187.230])
        by smtp.gmail.com with ESMTPSA id 1-20020a056a00072100b006ed045e3a70sm7433158pfm.25.2024.04.15.10.02.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 10:02:44 -0700 (PDT)
From: Sunil V L <sunilvl@ventanamicro.com>
To: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org,
	acpica-devel@lists.linux.dev
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Anup Patel <anup@brainfault.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Samuel Holland <samuel.holland@sifive.com>,
	Robert Moore <robert.moore@intel.com>,
	Haibo1 Xu <haibo1.xu@intel.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Atish Kumar Patra <atishp@rivosinc.com>,
	Andrei Warkentin <andrei.warkentin@intel.com>,
	Marc Zyngier <maz@kernel.org>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Sunil V L <sunilvl@ventanamicro.com>
Subject: [RFC PATCH v4 12/20] RISC-V: ACPI: Implement function to add implicit dependencies
Date: Mon, 15 Apr 2024 22:31:05 +0530
Message-Id: <20240415170113.662318-13-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240415170113.662318-1-sunilvl@ventanamicro.com>
References: <20240415170113.662318-1-sunilvl@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

RISC-V interrupt controllers for wired interrupts are platform devices
and hence their driver will be probed late. Also, APLIC which is one
such interrupt controller can not be probed early since it needs MSI
services. This needs a probing order between the interrupt controller
driver and the device drivers.

_DEP is typically used to indicate such dependencies. However, the
dependency may be already available like GSI mapping. Hence, instead of
an explicit _DEP, architecture can find the implicit dependencies and
add to the dependency list.

For RISC-V, add the dependencies for below use cases.

1) For devices which has IRQ resource, find out the interrupt controller
using GSI number map and add the dependency.

2) For PCI host bridges:
	a) If _PRT indicate PCI link devices, add dependency on the link
	   device.
	b) If _PRT indicates GSI, find out the interrupt controller
	   using GSI number map and add the dependency.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 drivers/acpi/riscv/irq.c | 132 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 132 insertions(+)

diff --git a/drivers/acpi/riscv/irq.c b/drivers/acpi/riscv/irq.c
index de0f1ba92068..f98645461bbe 100644
--- a/drivers/acpi/riscv/irq.c
+++ b/drivers/acpi/riscv/irq.c
@@ -21,6 +21,12 @@ struct riscv_ext_intc_list {
 	struct list_head list;
 };
 
+struct acpi_irq_dep_ctx {
+	int rc;
+	unsigned int index;
+	acpi_handle handle;
+};
+
 LIST_HEAD(ext_intc_list);
 
 static int irqchip_cmp_func(const void *in0, const void *in1)
@@ -189,3 +195,129 @@ int __init riscv_acpi_init_gsi_mapping(void)
 	acpi_get_devices("RSCV0001", riscv_acpi_create_gsi_map, NULL, NULL);
 	return 0;
 }
+
+static acpi_status riscv_acpi_irq_get_parent(struct acpi_resource *ares, void *context)
+{
+	struct acpi_irq_dep_ctx *ctx = context;
+	struct acpi_resource_irq *irq;
+	struct acpi_resource_extended_irq *eirq;
+
+	switch (ares->type) {
+	case ACPI_RESOURCE_TYPE_IRQ:
+		irq = &ares->data.irq;
+		if (ctx->index >= irq->interrupt_count) {
+			ctx->index -= irq->interrupt_count;
+			return AE_OK;
+		}
+		ctx->handle = riscv_acpi_get_gsi_handle(irq->interrupts[ctx->index]);
+		return AE_CTRL_TERMINATE;
+	case ACPI_RESOURCE_TYPE_EXTENDED_IRQ:
+		eirq = &ares->data.extended_irq;
+		if (eirq->producer_consumer == ACPI_PRODUCER)
+			return AE_OK;
+
+		if (ctx->index >= eirq->interrupt_count) {
+			ctx->index -= eirq->interrupt_count;
+			return AE_OK;
+		}
+
+		/* Not supported */
+		if (eirq->resource_source.string_length)
+			return AE_OK;
+
+		ctx->handle = riscv_acpi_get_gsi_handle(eirq->interrupts[ctx->index]);
+		return AE_CTRL_TERMINATE;
+	}
+
+	return AE_OK;
+}
+
+static int riscv_acpi_irq_get_dep(acpi_handle handle, unsigned int index, acpi_handle *gsi_handle)
+{
+	struct acpi_irq_dep_ctx ctx;
+
+	ctx.rc = -EINVAL;
+	ctx.index = index;
+	acpi_walk_resources(handle, METHOD_NAME__CRS, riscv_acpi_irq_get_parent, &ctx);
+	*gsi_handle = ctx.handle;
+	if (*gsi_handle)
+		return 1;
+
+	return 0;
+}
+
+static u32 riscv_acpi_add_prt_dep(acpi_handle handle)
+{
+	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
+	struct acpi_pci_routing_table *entry;
+	struct acpi_handle_list dep_devices;
+	acpi_handle gsi_handle;
+	acpi_handle link_handle;
+	acpi_status status;
+	u32 count = 0;
+
+	status = acpi_get_irq_routing_table(handle, &buffer);
+	if (ACPI_FAILURE(status)) {
+		kfree(buffer.pointer);
+		return 0;
+	}
+
+	entry = buffer.pointer;
+	while (entry && (entry->length > 0)) {
+		if (entry->source[0]) {
+			acpi_get_handle(handle, entry->source, &link_handle);
+			dep_devices.count = 1;
+			dep_devices.handles = kcalloc(1, sizeof(*dep_devices.handles), GFP_KERNEL);
+			if (!dep_devices.handles)
+				continue;
+
+			dep_devices.handles[0] = link_handle;
+			count += acpi_scan_add_dep(handle, &dep_devices);
+		} else {
+			gsi_handle = riscv_acpi_get_gsi_handle(entry->source_index);
+			dep_devices.count = 1;
+			dep_devices.handles = kcalloc(1, sizeof(*dep_devices.handles), GFP_KERNEL);
+			if (!dep_devices.handles)
+				continue;
+
+			dep_devices.handles[0] = gsi_handle;
+			count += acpi_scan_add_dep(handle, &dep_devices);
+		}
+
+		entry = (struct acpi_pci_routing_table *)
+			((unsigned long)entry + entry->length);
+	}
+
+	kfree(buffer.pointer);
+	return count;
+}
+
+static u32 riscv_acpi_add_irq_dep(acpi_handle handle)
+{
+	struct acpi_handle_list dep_devices;
+	acpi_handle gsi_handle;
+	u32 count = 0;
+	int i;
+
+	for (i = 0;
+	     riscv_acpi_irq_get_dep(handle, i, &gsi_handle);
+	     i++) {
+		dep_devices.count = 1;
+		dep_devices.handles = kcalloc(1, sizeof(*dep_devices.handles), GFP_KERNEL);
+		if (!dep_devices.handles)
+			continue;
+
+		dep_devices.handles[0] = gsi_handle;
+		count += acpi_scan_add_dep(handle, &dep_devices);
+	}
+
+	return count;
+}
+
+u32 arch_acpi_add_auto_dep(acpi_handle handle)
+{
+	if (acpi_has_method(handle, "_PRT"))
+		return riscv_acpi_add_prt_dep(handle);
+
+	return riscv_acpi_add_irq_dep(handle);
+}
-- 
2.40.1


