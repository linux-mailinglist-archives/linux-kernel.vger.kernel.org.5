Return-Path: <linux-kernel+bounces-145603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F07E28A5869
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 19:02:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A6061F21A2C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 17:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2140685280;
	Mon, 15 Apr 2024 17:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="bV0Zo0LD"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB2F83CBD
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 17:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713200505; cv=none; b=mqTkfFIJHnnK4BqA1Eykk3Rqe8kRRN8Sa/mIJ3JFxc/9qNqJqoDRUM/ezpizHGTCSomNt/BMy3IutHPZfNiOQPl1Hfh2Nxn83QgResSLPhQAckXeJ9I+HoDX8hm5FAhprgEtah5BPRyl0nrF42HjAxHyFZ68DRXyE9sIahXN7P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713200505; c=relaxed/simple;
	bh=G6d/szsfyOmNpE6H7iCYICRZyVGX7D2nTzxNR2hGcHo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XyOcHz0Ysy1Cy1H3Ozp1ROArY8TDQeNDA34IJfi1EyLhM4TMk2XUs087Ri/0cQVU/78CCsoxrd/2IqAIvaWn9GmGp6SwDLQs+Iaigs1AMdNXvgFoXwFnw+5Ld3VLN6gHznlbKc3XrjBIZH9XOpybBcB6VYEQ4mkSMOO6FgEdHFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=bV0Zo0LD; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6ed627829e6so3791302b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 10:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1713200503; x=1713805303; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VoHprznTatfd3jPIiDLel21Ov4h1fvX4qo25ti25gdk=;
        b=bV0Zo0LDx5NDrF6bqKXVmNbkIOSyeIRjQqV948/WmDDbWbcdCm/sqd0bYzvUgHuHqj
         oUOuyihoRZvTsgbNgTG/+EOqSPoqWt3ch26v8iuZMrTtUdiTyYTXTzrHX8DWAROnYQaq
         BVopx7D9OEbpHKOBL6/VZ9D+KpuM1gfaoHimXUjgwD34vxC8PdGcWbX2Uos6qg7h40vH
         BCbgkEYGcEdGhW5BlVM8yOlrd7unVSAcZ1M4CHLM4Avva2DRjf0JvEWPNYfv7SGj6whT
         OvHiVYQNnxrUp30ufygWULfZ3z0By+5QdAZbhSluSoi2wPoS1DY49Dgn0GvsjELsILKD
         508A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713200503; x=1713805303;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VoHprznTatfd3jPIiDLel21Ov4h1fvX4qo25ti25gdk=;
        b=smJKNSmHbGKtDmJhPZxaPfn3yymmz78gmYc6APcNxqZEC3aCzj7neTSkaOB/wIlksu
         Du2G1rjEZhHjAqzZIjqXeLUF7eV5s5mULaRo18Yes9X62PsPshQDOi1Y0G5Bhda+wQNP
         phSkTuWwJGRDngrb6shv+Q3t/CXszwmFY+YvnmOLEWXiw56/DQHsnt0bXe7nFx38cMHW
         t6/e2IBdTEj3p1E9KIJ3E5o6ttlbtDTiw1YF0n1mkZpBlZHqDj0WTx315ZcnIl9CF2yD
         0LLSqdqe6TJrpE7GLt3g4NChauk/CGZFWA7en+KPOSrpF2120RvIWDMOJSWiqoOaFtjM
         aAKw==
X-Forwarded-Encrypted: i=1; AJvYcCVXSXH+Bj3oU6SlOzxQPMQJhFDQmt/+nzDBaiv6TByQYxqXq6O0DCs51wkodbZbkD9fEUp89S9wPY4alspuE4XlX4HVi2x8TDIdnh9X
X-Gm-Message-State: AOJu0Yz2L9irheoe84DXkcSn01RnL0npSI2B6hOGM5Cm6bGo8AmTc4XX
	grtxxzWPZz06mxXFghB3e3gUrX8QXCRpJ+J9lAoQ0tCwnNc2n0w1dmAu+D71Gcw=
X-Google-Smtp-Source: AGHT+IEZTBakzY6PKzMTgs/zcMBONEtbNskqJbnRsI44xNlUKHaklyMLmZlZj49QTc7g7/a+/pPcjw==
X-Received: by 2002:a05:6a21:3381:b0:1a7:58ca:cdf3 with SMTP id yy1-20020a056a21338100b001a758cacdf3mr14872194pzb.8.1713200503358;
        Mon, 15 Apr 2024 10:01:43 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.187.230])
        by smtp.gmail.com with ESMTPSA id 1-20020a056a00072100b006ed045e3a70sm7433158pfm.25.2024.04.15.10.01.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 10:01:42 -0700 (PDT)
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
Subject: [RFC PATCH v4 03/20] PCI: Make pci_create_root_bus() declare its reliance on MSI domains
Date: Mon, 15 Apr 2024 22:30:56 +0530
Message-Id: <20240415170113.662318-4-sunilvl@ventanamicro.com>
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

Similar to commit 9ec37efb8783 ("PCI/MSI: Make
pci_host_common_probe() declare its reliance on MSI domains"), declare
this dependency for PCI probe in ACPI based flow.

This is required especially for RISC-V platforms where MSI controller
can be absent. However, setting this for all architectures seem to cause
issues on non RISC-V architectures [1]. Hence, enabled this only for
RISC-V.

[1] - https://lore.kernel.org/oe-lkp/202403041047.791cb18e-oliver.sang@intel.com

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 drivers/pci/probe.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 1325fbae2f28..e09915bee2ee 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -3048,6 +3048,9 @@ struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
 	bridge->sysdata = sysdata;
 	bridge->busnr = bus;
 	bridge->ops = ops;
+#ifdef CONFIG_RISCV
+	bridge->msi_domain = true;
+#endif
 
 	error = pci_register_host_bridge(bridge);
 	if (error < 0)
-- 
2.40.1


