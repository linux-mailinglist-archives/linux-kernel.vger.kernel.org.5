Return-Path: <linux-kernel+bounces-156304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 349E08B0107
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 07:30:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64DC51C2254C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 05:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A54E6155721;
	Wed, 24 Apr 2024 05:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ca908mHD"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889E8154BF3;
	Wed, 24 Apr 2024 05:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713936627; cv=none; b=n8N3aA3gEYA9sli57g/EpO+/JNUTs8Qq6q/2M4y+T4sW0dgIVD/bkoGIRj1/P5as0RC7Ba/D9zvqL/E+Rkts9I768cVUxggnGG4tmgonPvSnT1D0+W1dTU6rY+IxPe3H3FvuHr13Ewqbn0YJQ/Ka9AeQ02KpRGTjwik2E96O6Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713936627; c=relaxed/simple;
	bh=QpctZFOgjLCGZkae6U7fJY9a2aL5ED2kqQ9t0GVRrMI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UoNTw+ThwI9Vl2Np0eWcK1QiOKGYAGxAUKkSQZtiikF9pMf2I4urOgWDR/9cPbBbU61JDYFlP+raUDEEKtllFx9FArUSf3QvkxBYdGNZErpX0cJUVqO9+8fnM64ZCHo3jlstGxy/KFWMY+WwOgnSJAWrP3N0WgYWAnkALyZqoaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ca908mHD; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713936626; x=1745472626;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QpctZFOgjLCGZkae6U7fJY9a2aL5ED2kqQ9t0GVRrMI=;
  b=Ca908mHD+K3f0+0icjvlAJc5MLIAsXkbsycomwDEnCV8ulppjiXwrZS1
   yOm+kDPX9TVErrFsuFTz08ZF+EJ+GymhKMIameKyfu4U9ZsWxU81UTvQj
   ccFo6p7HPTtQroEKIffB8vKA0nRWyXY92Bn61b5S0Yuc3rz4/qFDz5V/6
   oyoIHOTCSM4rAdysw4Ku+kcsEfiBz35AcOfp4m+ENLjOrBChQ3NI+OkQP
   E/Yq7LdNP7h85n8ZF5lLoJbxu7X5nuOk0u2CpyvcqCYLlwoZt4u3FrAg8
   BWDdwWTV6rkqfQFG4+F/Elk8uwAqVRNSCK6J+8TUe4OvVjHbFzvjYeYbS
   Q==;
X-CSE-ConnectionGUID: sG3NEsBaTF2l3y5PhUrbPA==
X-CSE-MsgGUID: eaog4hBMStyZ7KXVeLi4zg==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="27004324"
X-IronPort-AV: E=Sophos;i="6.07,225,1708416000"; 
   d="scan'208";a="27004324"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 22:30:26 -0700
X-CSE-ConnectionGUID: Gj/C8lUAS9OBNw5v0pwjHA==
X-CSE-MsgGUID: IUvD6jDHSJS/9jHbK9aPLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,225,1708416000"; 
   d="scan'208";a="62050113"
Received: from unknown (HELO haibo-OptiPlex-7090.sh.intel.com) ([10.239.159.132])
  by orviesa001.jf.intel.com with ESMTP; 23 Apr 2024 22:30:15 -0700
From: Haibo Xu <haibo1.xu@intel.com>
To: sunilvl@ventanamicro.com,
	arnd@arndb.de
Cc: xiaobo55x@gmail.com,
	ajones@ventanamicro.com,
	Haibo Xu <haibo1.xu@intel.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Robert Moore <robert.moore@intel.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Guo Ren <guoren@kernel.org>,
	Greentime Hu <greentime.hu@sifive.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Baoquan He <bhe@redhat.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	Chen Jiahao <chenjiahao16@huawei.com>,
	James Morse <james.morse@arm.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Evan Green <evan@rivosinc.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Tony Luck <tony.luck@intel.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Yuntao Wang <ytcoode@gmail.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev
Subject: [PATCH v3 3/6] ACPI: NUMA: Add handler for SRAT RINTC affinity structure
Date: Wed, 24 Apr 2024 13:46:23 +0800
Message-Id: <5f6167bbe37f19796b93dd20975853a2681e5ce8.1713778236.git.haibo1.xu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1713778236.git.haibo1.xu@intel.com>
References: <cover.1713778236.git.haibo1.xu@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add RINTC affinity structure handler during parsing SRAT table.

Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
Reviewed-by: Sunil V L <sunilvl@ventanamicro.com>
---
 drivers/acpi/numa/srat.c | 32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
index e45e64993c50..bc8f34b2ad51 100644
--- a/drivers/acpi/numa/srat.c
+++ b/drivers/acpi/numa/srat.c
@@ -167,6 +167,19 @@ acpi_table_print_srat_entry(struct acpi_subtable_header *header)
 		}
 	}
 	break;
+
+	case ACPI_SRAT_TYPE_RINTC_AFFINITY:
+		{
+			struct acpi_srat_rintc_affinity *p =
+			    (struct acpi_srat_rintc_affinity *)header;
+			pr_debug("SRAT Processor (acpi id[0x%04x]) in proximity domain %d %s\n",
+				 p->acpi_processor_uid,
+				 p->proximity_domain,
+				 (p->flags & ACPI_SRAT_RINTC_ENABLED) ?
+				 "enabled" : "disabled");
+		}
+		break;
+
 	default:
 		pr_warn("Found unsupported SRAT entry (type = 0x%x)\n",
 			header->type);
@@ -450,6 +463,21 @@ acpi_parse_gi_affinity(union acpi_subtable_headers *header,
 }
 #endif /* defined(CONFIG_X86) || defined (CONFIG_ARM64) */
 
+static int __init
+acpi_parse_rintc_affinity(union acpi_subtable_headers *header,
+			  const unsigned long end)
+{
+	struct acpi_srat_rintc_affinity *rintc_affinity;
+
+	rintc_affinity = (struct acpi_srat_rintc_affinity *)header;
+	acpi_table_print_srat_entry(&header->common);
+
+	/* let architecture-dependent part to do it */
+	acpi_numa_rintc_affinity_init(rintc_affinity);
+
+	return 0;
+}
+
 static int __initdata parsed_numa_memblks;
 
 static int __init
@@ -503,7 +531,7 @@ int __init acpi_numa_init(void)
 
 	/* SRAT: System Resource Affinity Table */
 	if (!acpi_table_parse(ACPI_SIG_SRAT, acpi_parse_srat)) {
-		struct acpi_subtable_proc srat_proc[4];
+		struct acpi_subtable_proc srat_proc[5];
 
 		memset(srat_proc, 0, sizeof(srat_proc));
 		srat_proc[0].id = ACPI_SRAT_TYPE_CPU_AFFINITY;
@@ -514,6 +542,8 @@ int __init acpi_numa_init(void)
 		srat_proc[2].handler = acpi_parse_gicc_affinity;
 		srat_proc[3].id = ACPI_SRAT_TYPE_GENERIC_AFFINITY;
 		srat_proc[3].handler = acpi_parse_gi_affinity;
+		srat_proc[4].id = ACPI_SRAT_TYPE_RINTC_AFFINITY;
+		srat_proc[4].handler = acpi_parse_rintc_affinity;
 
 		acpi_table_parse_entries_array(ACPI_SIG_SRAT,
 					sizeof(struct acpi_table_srat),
-- 
2.34.1


