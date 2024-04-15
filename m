Return-Path: <linux-kernel+bounces-145604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C3B88A586A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 19:03:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB9D61F21B2E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 17:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0CA78529B;
	Mon, 15 Apr 2024 17:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="YHush3tG"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6648062B
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 17:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713200512; cv=none; b=kUzQv/7WyK90QOx0HyaUX6ZcbojzJIglOrjrURV4hGeMewEbtaJY6PQ18G0OjvBdqG3FPa+wrdqAlrIkpR+26RoCsCUoWPVl+3/Y0K9udzAPLbZXAvJNi95nF7NGQn4QnN8Lhp8xj2g2GpjzXYpXSf1qS7VIKUnCJUrirShWiD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713200512; c=relaxed/simple;
	bh=dDrKFILdmWkoGj6OkVS37yIsnuHW0WzK5+l8GvebI1Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GxKvj4QZYq5CKY/iA1T7OzHd+Wxg/IPKHLTj8SyddUlH9d1Klv8CIOKI+gEz6jZrajUPfSBXOBW9KJJYrPdSBhJNPOHlKRxP2+EFd70fGnsf0aiY9lTKjV3ESmviCPMmykzAby9//o9TJP2MtTUmwsimqZcuKt0SXG1IJdCULPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=YHush3tG; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6ed04c91c46so3648736b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 10:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1713200510; x=1713805310; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NV0OeA3LqOjcEQwVzmEUb3l+O0qMWG2Q7MAVkkjj25w=;
        b=YHush3tGWr4Hec4PFk5UeTWH2DN08a1TFuMnEGU8wZjSVYhfTmuBVu7ggj3M+XFOgx
         pf0SsscYHV/TcXhngqnFOlKmpBGbho4aWRmaxDwMQkyn8VEqlIkp8SnKUU7zkLeY9nUQ
         vfQgO4fRFZtscFwPgDdkEVmyRUYRtxjaLiuu8R9T1Bh3MoNfmpNWFHnWp8bdPRcLptm6
         PcFpGREG0Z2TfOYm+vnMbKXEbxN0TBAgXa3CkfnMgrhloMHMl+b/G5z7dxvCQiuS7jcJ
         kxOXiRLdYWvAaptgYFbdFw1tZTNsg1fA43SGBOa77bTyhGoHwjp9E7p3eNrihl9SK85n
         RDFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713200510; x=1713805310;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NV0OeA3LqOjcEQwVzmEUb3l+O0qMWG2Q7MAVkkjj25w=;
        b=dF9+6/kc8/mpNL/R8ihN4SQZqNNQK24yFsM35yCxWmiBn/n0ZUj4Fe+3j/TlCeYDpI
         X/Di8VcCqQikC5iU7mQr9xWdLQsQh7WR6EHp11Y4E0XFtM7FyHpmvb9NBMAWYRFZ7be+
         Weig095hnWRs6OK5dixhEfrNBYo9oI+0tiBPmWKG7pFCHlrhRcmhShlYkZ/SDXc6jhU0
         hDpqA+1FJhgspTnbFgNueF4XASHRhK3gd8cR3SJK8f5++glF3Sgse+9XGqg6FV39YvUg
         MIzM+yjczoQ9pqEcVzsB5Mo2PX3tDNJ1aoXElU4eC8XuWIahLc7UdxWzkD8p2rkpu8Ti
         G+1g==
X-Forwarded-Encrypted: i=1; AJvYcCVB922qwPAzdseE+MJ8MxGH0wKnR6j3OooOyUK+/xEZYFRr+FZ21eWPaf9d3jLjc7zDX5NWqXQDcxlJ58Rd0dd8GGklsK2/LthYdFuo
X-Gm-Message-State: AOJu0YwltULJ2Kjk/okpsxR3aEm8aYNJzdBK6KCHkQCi67B4LcdocP5t
	ZA5XoZLjPwkhzeZZRAtcBPFa/2zwn4Sa2n1dywZGzG9AbQeK+cyqCexBIwTx9oY=
X-Google-Smtp-Source: AGHT+IGvmjYeaJvV6Cs9b+D8sHsU8MJVs6hR0ePtYiL5D9g9wvurdSLwMSWttPbHZlSkX+z1czGUNQ==
X-Received: by 2002:a05:6a00:21d0:b0:6ed:de6f:d738 with SMTP id t16-20020a056a0021d000b006edde6fd738mr13801645pfj.9.1713200510295;
        Mon, 15 Apr 2024 10:01:50 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.187.230])
        by smtp.gmail.com with ESMTPSA id 1-20020a056a00072100b006ed045e3a70sm7433158pfm.25.2024.04.15.10.01.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 10:01:49 -0700 (PDT)
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
Subject: [RFC PATCH v4 04/20] ACPI: scan.c: Add weak arch specific function to reorder the IRQCHIP probe
Date: Mon, 15 Apr 2024 22:30:57 +0530
Message-Id: <20240415170113.662318-5-sunilvl@ventanamicro.com>
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

Unlike OF framework, the irqchip probe using IRQCHIP_ACPI_DECLARE has no
order defined. Depending on the driver Makefile is not a good idea. So,
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
index 68f101323f53..de30a0af7a2f 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -2749,6 +2749,8 @@ static int __init acpi_match_madt(union acpi_subtable_headers *header,
 	return 0;
 }
 
+void __weak arch_sort_irqchip_probe(struct acpi_probe_entry *ap_head, int nr) { }
+
 int __init __acpi_probe_device_table(struct acpi_probe_entry *ap_head, int nr)
 {
 	int count = 0;
@@ -2757,6 +2759,7 @@ int __init __acpi_probe_device_table(struct acpi_probe_entry *ap_head, int nr)
 		return 0;
 
 	mutex_lock(&acpi_probe_mutex);
+	arch_sort_irqchip_probe(ap_head, nr);
 	for (ape = ap_head; nr; ape++, nr--) {
 		if (ACPI_COMPARE_NAMESEG(ACPI_SIG_MADT, ape->id)) {
 			acpi_probe_count = 0;
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 168201e4c782..914ecd22ba64 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -1337,6 +1337,8 @@ struct acpi_probe_entry {
 	kernel_ulong_t driver_data;
 };
 
+void arch_sort_irqchip_probe(struct acpi_probe_entry *ap_head, int nr);
+
 #define ACPI_DECLARE_PROBE_ENTRY(table, name, table_id, subtable,	\
 				 valid, data, fn)			\
 	static const struct acpi_probe_entry __acpi_probe_##name	\
-- 
2.40.1


