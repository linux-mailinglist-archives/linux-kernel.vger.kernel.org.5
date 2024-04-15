Return-Path: <linux-kernel+bounces-145611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F141C8A5884
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 19:04:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F9581C20F29
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 17:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC114127B4B;
	Mon, 15 Apr 2024 17:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="jkpX6yBs"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94981272AF
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 17:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713200560; cv=none; b=cL27JjAGLzYb10LB380BqnCkwXED2T2yvxAWEowsEIUlBj2nYj/GULpXHAYGWg0W153J2EPLVizMFjgcNRiuoCkTcPV2ePwm64vI/0ROZElF2Wnt3uj9Rq5xplEJA+TJtMiRbthvGxqWauQT6RBJCD5KD7l3s0MDs6k51P9oE14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713200560; c=relaxed/simple;
	bh=LYtUv6qDwrcBtr8K6aN25hN45uuc46R4wBZ+hNYpcAk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QRDaPkYNS/m9OBTQVUY8j7/yt3SxP9RdE01pvaCBFyZAR9fNj29bBpkE0Msh+19CQkLXED5gXh3FCUl6xHiKZKInVSItOry8e+PY627nY2pYulCf4FHN27HQTzjG5pAGQjoLnoYMvtdV3XLmSTpQUgjnjTXNWKmnpV61Hz+DNL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=jkpX6yBs; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6ed627829e6so3793132b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 10:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1713200558; x=1713805358; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c1X7evQ35uoewh1RNAGJwcs/iaU3rzDK4qB90vlKVhs=;
        b=jkpX6yBsDW7onPzCFAsKKcOMByACBD8XrIKYAhwQhMZR9kRXkw0YcTdqLkecL9gsIl
         1iMrioEqkRlgVQ1B395y5gLmXpuH/dlRPyNddKUCZiSMgisGVjWFD1XV0vujsNJuC37Y
         ssPJBPXAS9oldXT4YCKxSyEQKrKVFWSoerQwR9ZaEQO4BMmn30eWIj5/6iWQ2dKn+FoU
         FsVHFjxm6SgMLyyJHs45PbaYl65N27FlmU5aqVLMJM5t2YP8SIkT03C6EHHgFO1he6tQ
         MeMzRcSpJCoCI5N9wWUhDmowv1fiYVgqNGkD62YFy4JCedoEdbmz8fBiQ/hTryCiEZcu
         yuzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713200558; x=1713805358;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c1X7evQ35uoewh1RNAGJwcs/iaU3rzDK4qB90vlKVhs=;
        b=Dh5mYhaRP09TvpVr0SE5XlLAd4VX6ECkSAuLm+oC+ECb8F43Xknd0jlI2ugpDRvr7E
         yvQcKoQzLsREjKg5VmDwcJsP/04ORcgu8msiAZmmiBQ5x7OsP4w63RbXRnyIAmhdkdkv
         oXANV16nAewdFaWG7UawU1iuCmysT+NicnJnuY2qerV3ra6+B7+2pgwCSdUXGgusoA3m
         3rAt/As4OjAzsx5cJpJBVTY1PCiZGb/31ZjhMXtrJMfszNcM5BPlbmrR37dFxCsWWFuK
         3D8dAwnRH7x3DXm1mkYXAb8usXB7zOO5z92W6VIGAMry6rFFfoF7qc2iha4xFw+nEMz8
         xHDg==
X-Forwarded-Encrypted: i=1; AJvYcCXN2FRmhJklP9OjOKZY841tVjtj4m0Nooy4nklbZ3ped8Kc4ErcfIVBLAhDB2BIJ9mOir1jHRke23on4BL+lX7yiPT8snHtyG8a9nPy
X-Gm-Message-State: AOJu0YxZPkpN/C1IzTRxzWwUGIHd9hHX0JTxcGdX3mhmTdwOFNyJGCE/
	5QQfvx/AqPNfaPJeyHzRfb9RjYz/qmv22TLwRdcxtPMLKc/pYrC+esPILYluvOE=
X-Google-Smtp-Source: AGHT+IHP5Rv0C3YxWinnwyj54lMdddb7BaD0yQpP0Yg8Qswii7cMjohW9Wcp53K9v1it+Ov4jHo51g==
X-Received: by 2002:a05:6a00:181d:b0:6ec:fe26:4ec1 with SMTP id y29-20020a056a00181d00b006ecfe264ec1mr12412388pfa.22.1713200558011;
        Mon, 15 Apr 2024 10:02:38 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.187.230])
        by smtp.gmail.com with ESMTPSA id 1-20020a056a00072100b006ed045e3a70sm7433158pfm.25.2024.04.15.10.02.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 10:02:36 -0700 (PDT)
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
Subject: [RFC PATCH v4 11/20] ACPI: scan.c: Define weak function to populate dependencies
Date: Mon, 15 Apr 2024 22:31:04 +0530
Message-Id: <20240415170113.662318-12-sunilvl@ventanamicro.com>
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

Some architectures like RISC-V need to add dependencies without explicit
_DEP. Define a weak function which can be implemented by the architecture.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 drivers/acpi/scan.c     | 11 +++++++++++
 include/acpi/acpi_bus.h |  1 +
 2 files changed, 12 insertions(+)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 07e91616b7d4..8e23b9508716 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -2073,11 +2073,22 @@ int acpi_scan_add_dep(acpi_handle handle, struct acpi_handle_list *dep_devices)
 	return count;
 }
 
+u32 __weak arch_acpi_add_auto_dep(acpi_handle handle) { return 0; }
+
 static u32 acpi_scan_check_dep(acpi_handle handle)
 {
 	struct acpi_handle_list dep_devices;
 	u32 count = 0;
 
+	/*
+	 * Some architectures like RISC-V need to add dependencies for
+	 * all devices which use GSI to the interrupt controller so that
+	 * interrupt controller is probed before any of those devices.
+	 * Instead of mandating _DEP on all the devices, detect the
+	 * dependency and add automatically.
+	 */
+	count += arch_acpi_add_auto_dep(handle);
+
 	/*
 	 * Check for _HID here to avoid deferring the enumeration of:
 	 * 1. PCI devices.
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 28a9b87c23fa..5fba4075d764 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -994,6 +994,7 @@ static inline void acpi_put_acpi_dev(struct acpi_device *adev)
 int acpi_wait_for_acpi_ipmi(void);
 
 int acpi_scan_add_dep(acpi_handle handle, struct acpi_handle_list *dep_devices);
+u32 arch_acpi_add_auto_dep(acpi_handle handle);
 #else	/* CONFIG_ACPI */
 
 static inline int register_acpi_bus_type(void *bus) { return 0; }
-- 
2.40.1


