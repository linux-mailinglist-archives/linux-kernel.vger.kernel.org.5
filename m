Return-Path: <linux-kernel+bounces-165219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DE4B8B89B0
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 14:19:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5862DB21EA1
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 12:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3374812AAFD;
	Wed,  1 May 2024 12:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="h4HZBs0B"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D11885C66
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 12:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714565917; cv=none; b=NAMEzoa7Vdj2gLoWSrY+8vFEckCbMLXRQyzibX8PCzBOX3Kjp/NR5M8Ed+3MZhL3d9wq5Pb3iupTWTft2JfHeJsfaEwHlp1ncS7V9SjTcoeb90tsYN+3+Z6wJnNkGZVeyiywMHf62Vmrw9mnruALX+ryT+GDTA64D8p2I8pRRKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714565917; c=relaxed/simple;
	bh=40G7efalCDrGiaKldSdMEYPAzuXFlQlo+Lbo7W3hChc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VV+/tL1IIBEopYOkAiaaMhcTIBJB+htQOhSYTi9lJnji5chKzerFshb27EEdb39/4MQeVy1Fj0JHo8IJ+wjylZn/CaSF6fdY+uEan4p+Q1z1dtRxz0Z1eiWG7EGX4gRBMUAzLCslWolOKYHQKRT5fwbS0qKr51UTuqShq0dDKwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=h4HZBs0B; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1e65a1370b7so62843425ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2024 05:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1714565915; x=1715170715; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lRvT/oDJzrljnZE8hh4Mfx8UjypBfU2BU36kOdk78lo=;
        b=h4HZBs0Bn73Rm4fNaVr3pul7ugd1BbfuHkILtLV0f8tkse95SrlILOungqpfHgKkrB
         m+NCLQ7JDz1EW/W0yFGhiCvWUBQvg7VGYI7zIGhmx5flfOzHH0dbIeSfoB8pj4IxBvk9
         hjW3FgJo0NEFgTE4siK/J57Fdh4DU6gtAS90zF11b1KPW8n7gzZD//V48eCLAep4WIj5
         jYwKKt4QQ0+TacKZajz1hMh4iTmvTOrP5BXo45l3MNIMx4I9dwOUxif2skIctkQcGmvg
         OrlWzsWPgiuQyuKrUfbZz3o/a5D+iqBjfY1g8v9hd5XU2CudQUBq3PDNTmw8Qmrf6SMH
         rLaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714565915; x=1715170715;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lRvT/oDJzrljnZE8hh4Mfx8UjypBfU2BU36kOdk78lo=;
        b=LjCHzTn4O5311cFvR1+6MJ7dQR9In3wYF9OdIDZ2T6RXEjGRUL4XI6RLNHnwV1WD4T
         DWxHORGPJOZR3QtgqzUOQ9THT79SA+pa0BNR5EmK2cYjPU4xvS5Zb0YfUNEtULfU/Rpx
         dHZo9oz3ZiMNjcsYTaHHreYyB7zXgXDgrgcdmMRbcPzRNV3L0cKnCa/laooq6qwxOH6f
         +O11eeKsfPVEkiobWk8BFUwms9mbhQyRIViNaELcmzfBpuXEv4PRtuUUkSBhxpB4GVOy
         GkN9VmFWvE4MV4WroRPdwJaiCHL4K8raAVoHB5661LjFzu1tRcPe3YgfLZljVVV8O5Gp
         BKBA==
X-Forwarded-Encrypted: i=1; AJvYcCVbsxL9MVaBV7FpMEQ2ZCpltQX6Y7wlWG4sJZ9p9ujMpZZgXCtLVv6J60AA49OstIfrnOxfM8JRRAMEYKooMAdupNnnNbp64WFDIGxK
X-Gm-Message-State: AOJu0YxR2g7xRI5CLPUPG7LEHQBWKd9MGhyb34M+fuoSN9FGviODMVEo
	CSrm55DYmBth0g1Byq9AjxPi+xEGAzxuudVXL3FJyXVD2bsI8tPi/DbDeO0+kts=
X-Google-Smtp-Source: AGHT+IFj7UjbvAZWh+cyRVOuEeVGC8mPfC0AaziB0MuMPmALOJzUu9Sq7LhvOrdMq5PmFj31+IKF9Q==
X-Received: by 2002:a17:902:e5c4:b0:1eb:4a72:91ff with SMTP id u4-20020a170902e5c400b001eb4a7291ffmr3011610plf.49.1714565915161;
        Wed, 01 May 2024 05:18:35 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.188.106])
        by smtp.gmail.com with ESMTPSA id im15-20020a170902bb0f00b001ec8888b22esm1336900plb.65.2024.05.01.05.18.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 05:18:34 -0700 (PDT)
From: Sunil V L <sunilvl@ventanamicro.com>
To: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-serial@vger.kernel.org,
	acpica-devel@lists.linux.dev
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Anup Patel <anup@brainfault.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Samuel Holland <samuel.holland@sifive.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Robert Moore <robert.moore@intel.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Marc Zyngier <maz@kernel.org>,
	Atish Kumar Patra <atishp@rivosinc.com>,
	Andrei Warkentin <andrei.warkentin@intel.com>,
	Haibo1 Xu <haibo1.xu@intel.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Sunil V L <sunilvl@ventanamicro.com>
Subject: [PATCH v5 04/17] ACPI: scan: Refactor dependency creation
Date: Wed,  1 May 2024 17:47:29 +0530
Message-Id: <20240501121742.1215792-5-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240501121742.1215792-1-sunilvl@ventanamicro.com>
References: <20240501121742.1215792-1-sunilvl@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some architectures like RISC-V will use implicit dependencies like GSI
map to create dependencies between interrupt controller and devices. To
support doing that, the function which creates the dependency, is
refactored bit and made public so that dependency can be added from
outside of scan.c as well.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 drivers/acpi/scan.c     | 48 ++++++++++++++++++++++++-----------------
 include/acpi/acpi_bus.h |  1 +
 2 files changed, 29 insertions(+), 20 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 837b8fc89dfb..3e3320ddb3da 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -2023,33 +2023,18 @@ static void acpi_scan_init_hotplug(struct acpi_device *adev)
 	}
 }
 
-static u32 acpi_scan_check_dep(acpi_handle handle)
+int acpi_scan_add_dep(acpi_handle handle, struct acpi_handle_list *dep_devices)
 {
-	struct acpi_handle_list dep_devices;
 	u32 count;
 	int i;
 
-	/*
-	 * Check for _HID here to avoid deferring the enumeration of:
-	 * 1. PCI devices.
-	 * 2. ACPI nodes describing USB ports.
-	 * Still, checking for _HID catches more then just these cases ...
-	 */
-	if (!acpi_has_method(handle, "_DEP") || !acpi_has_method(handle, "_HID"))
-		return 0;
-
-	if (!acpi_evaluate_reference(handle, "_DEP", NULL, &dep_devices)) {
-		acpi_handle_debug(handle, "Failed to evaluate _DEP.\n");
-		return 0;
-	}
-
-	for (count = 0, i = 0; i < dep_devices.count; i++) {
+	for (count = 0, i = 0; i < dep_devices->count; i++) {
 		struct acpi_device_info *info;
 		struct acpi_dep_data *dep;
 		bool skip, honor_dep;
 		acpi_status status;
 
-		status = acpi_get_object_info(dep_devices.handles[i], &info);
+		status = acpi_get_object_info(dep_devices->handles[i], &info);
 		if (ACPI_FAILURE(status)) {
 			acpi_handle_debug(handle, "Error reading _DEP device info\n");
 			continue;
@@ -2068,7 +2053,7 @@ static u32 acpi_scan_check_dep(acpi_handle handle)
 
 		count++;
 
-		dep->supplier = dep_devices.handles[i];
+		dep->supplier = dep_devices->handles[i];
 		dep->consumer = handle;
 		dep->honor_dep = honor_dep;
 
@@ -2077,7 +2062,30 @@ static u32 acpi_scan_check_dep(acpi_handle handle)
 		mutex_unlock(&acpi_dep_list_lock);
 	}
 
-	acpi_handle_list_free(&dep_devices);
+	acpi_handle_list_free(dep_devices);
+	return count;
+}
+
+static u32 acpi_scan_check_dep(acpi_handle handle)
+{
+	struct acpi_handle_list dep_devices;
+	u32 count = 0;
+
+	/*
+	 * Check for _HID here to avoid deferring the enumeration of:
+	 * 1. PCI devices.
+	 * 2. ACPI nodes describing USB ports.
+	 * Still, checking for _HID catches more then just these cases ...
+	 */
+	if (!acpi_has_method(handle, "_DEP") || !acpi_has_method(handle, "_HID"))
+		return count;
+
+	if (!acpi_evaluate_reference(handle, "_DEP", NULL, &dep_devices)) {
+		acpi_handle_debug(handle, "Failed to evaluate _DEP.\n");
+		return count;
+	}
+
+	count += acpi_scan_add_dep(handle, &dep_devices);
 	return count;
 }
 
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 1a4dfd7a1c4a..28a9b87c23fa 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -993,6 +993,7 @@ static inline void acpi_put_acpi_dev(struct acpi_device *adev)
 
 int acpi_wait_for_acpi_ipmi(void);
 
+int acpi_scan_add_dep(acpi_handle handle, struct acpi_handle_list *dep_devices);
 #else	/* CONFIG_ACPI */
 
 static inline int register_acpi_bus_type(void *bus) { return 0; }
-- 
2.40.1


