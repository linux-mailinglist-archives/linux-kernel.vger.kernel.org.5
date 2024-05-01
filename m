Return-Path: <linux-kernel+bounces-165217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 087E48B89A8
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 14:18:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27FDB1C21677
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 12:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4929B129A66;
	Wed,  1 May 2024 12:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="GWlyB4A9"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AAF885C66
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 12:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714565901; cv=none; b=MLT/s9sR6zzkb1onWETt7sSD2JwW5VvdpDFrjeVznY6AaMFsV2oV3mgcYXrVvzEOIRMQgRJqaMUHA582d4TCb222UzsRSLh1826eJAVTZN/NO6+v095uxGLUtJI3ccaxpscQLi45KOIbYoM0NDBAlv2oS34gHJJtfP+4Ji6FzAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714565901; c=relaxed/simple;
	bh=F85RREqd/8SNFxuf3cR7FkJMyzMuMjsdvVkhYC6pOzM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JJqXx8joh8YSai7bnN1sGF9257fpjOYmSlhhJtaP4I+fj6wONPZINwiTn69YanFPZ9F6aLkd6qmEXIGCnvMOhy7Wcsig6G1VHQWTv/zrdc4d2BAsQoVWGBQdiasvU6X1uxZ5lFvDif4PzoB4pf4x31YaXLWFUYlllezIgPeh6Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=GWlyB4A9; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1ec5387aed9so13688045ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2024 05:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1714565900; x=1715170700; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2U21IbVpVYWuDXnfpPitFjz/aLJhntW1ExhoP7hEzCc=;
        b=GWlyB4A9bLsb6rh2Gj7G5mzR0v60ja8rXP8r43Dt68LGK8ai4wflafr/et/fAMsj8s
         j8aPs5i1lvwGXByEm9nfjk3nNHigdvF+ZHhYMrh2E48tkVTEK8RUvARNG+rO0t0JH0VC
         YkoaTwczjYqNPHLseCiGJjCEM1hmV9pVW0ZPiwj5QIue56MgGB6B/CPgc1auj3mqWDdC
         rSUK1qm27Y4EdWRZwY7ZjaIZJj+vL0GBQ37u4ESkCy7s0R9SChuYmBgfqulCzW9GfclS
         ErFlNq8kZQoJJ/+87O2M1Hib2R+pE82Lw3AEd4MrCX5GctpZFR/9F/x2ZX7+AWqC2FGW
         s/rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714565900; x=1715170700;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2U21IbVpVYWuDXnfpPitFjz/aLJhntW1ExhoP7hEzCc=;
        b=EHNaHmPg0pJkNR7FBiWIiOIYf1IpCR88T7/Qh2O+6fklooZaBko6SuSMGbjfTED9zP
         ef9lNUJXeL0F/GIpZIFX22KmXO16MnW1Fwsodz56aWCTtpfSGbfX/O0W07u6NjNK7epC
         umVHZPc4vyQv89n5qZriLxy8TmV9XNgXoOFsyOWR0VwE98srxUPMe7sEm+sXrOkfOrPw
         kIhsWbQa8ZOqG6AcECB++0HK1DBghiDcwgN7xWcQK7W78QIrdAvU+2HMCwhm1kxaeg2i
         2B3qaAhx5aKu86iOzz6FD6bc87q6UMdXK4vZ8+JC565OMID4zFgGVfBLb7vUkF3NvNWs
         B4Jg==
X-Forwarded-Encrypted: i=1; AJvYcCWkZdKBDIpiOphhOmbk2oYEUgrGSEuUymn45apuUmtkpOeO7hA+C74m/aF5tjIZFRPvs1wPhvnlUQme1YrCenf+BOX2HHPfdV2KtUDJ
X-Gm-Message-State: AOJu0Yw5dKEEW8kvRaqcau24AF8qouC4iysSFsCeY15vAgLT7mMjWTRx
	F7yjmDEPLl2TmCfqC/Z1PkL5xC4qQ/RzgoYhwfJYAlrCydkLtg/BE26b4uaU0jE=
X-Google-Smtp-Source: AGHT+IEhKN1Gue1zmrkCOUBSqcJjzhxCt/OVWXcOEWxant109xhmvof+8Br6KhAL2UNxeD7n9gvBjw==
X-Received: by 2002:a17:903:11ce:b0:1e4:9c2f:d343 with SMTP id q14-20020a17090311ce00b001e49c2fd343mr2700552plh.7.1714565899631;
        Wed, 01 May 2024 05:18:19 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.188.106])
        by smtp.gmail.com with ESMTPSA id im15-20020a170902bb0f00b001ec8888b22esm1336900plb.65.2024.05.01.05.18.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 05:18:19 -0700 (PDT)
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
Subject: [PATCH v5 02/17] ACPI: scan: Add a weak function to reorder the IRQCHIP probe
Date: Wed,  1 May 2024 17:47:27 +0530
Message-Id: <20240501121742.1215792-3-sunilvl@ventanamicro.com>
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

Unlike OF framework, the irqchip probe using IRQCHIP_ACPI_DECLARE has no
order defined. Depending on the Makefile is not a good idea. So,
usually it is worked around by mandating only root interrupt controller
probed using IRQCHIP_ACPI_DECLARE and other interrupt controllers are
probed via cascade mechanism.

However, this is also not a clean solution because if there are multiple
root controllers (ex: RINTC in RISC-V which is per CPU) which need to be
probed first, then the cascade will happen for every root controller.
So, introduce a architecture specific weak function to order the probing
of the interrupt controllers which can be implemented by different
architectures as per their interrupt controller hierarchy.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 drivers/acpi/scan.c  | 3 +++
 include/linux/acpi.h | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 4804a2ad1578..837b8fc89dfb 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -2744,6 +2744,8 @@ static int __init acpi_match_madt(union acpi_subtable_headers *header,
 	return 0;
 }
 
+void __weak arch_sort_irqchip_probe(struct acpi_probe_entry *ap_head, int nr) { }
+
 int __init __acpi_probe_device_table(struct acpi_probe_entry *ap_head, int nr)
 {
 	int count = 0;
@@ -2752,6 +2754,7 @@ int __init __acpi_probe_device_table(struct acpi_probe_entry *ap_head, int nr)
 		return 0;
 
 	mutex_lock(&acpi_probe_mutex);
+	arch_sort_irqchip_probe(ap_head, nr);
 	for (ape = ap_head; nr; ape++, nr--) {
 		if (ACPI_COMPARE_NAMESEG(ACPI_SIG_MADT, ape->id)) {
 			acpi_probe_count = 0;
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index c2ae33b8dbb6..1afa289f1f4e 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -1339,6 +1339,8 @@ struct acpi_probe_entry {
 	kernel_ulong_t driver_data;
 };
 
+void arch_sort_irqchip_probe(struct acpi_probe_entry *ap_head, int nr);
+
 #define ACPI_DECLARE_PROBE_ENTRY(table, name, table_id, subtable,	\
 				 valid, data, fn)			\
 	static const struct acpi_probe_entry __acpi_probe_##name	\
-- 
2.40.1


