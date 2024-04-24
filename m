Return-Path: <linux-kernel+bounces-156302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81A878B0103
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 07:29:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC3CAB231CD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 05:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FA12155385;
	Wed, 24 Apr 2024 05:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RGQnoufZ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4166F154BF3;
	Wed, 24 Apr 2024 05:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713936586; cv=none; b=MiS0inPV5cPe2r1aChSqEGpAZmO5aUJsVCV+TjiTIsRB7O+56CRCJ9klcBsXeRIERYgWIWLEUtu8Zw55Qis31AJ60xIqwfvL+dtymY0JPo0hqBZJUi9Ax98+lkjOkTlDRtRA+EkA+URI6kqX/p9HHxPUFcVVvHsc2HmD7F4ozMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713936586; c=relaxed/simple;
	bh=vVb6RIIvOt4enB6/MzuWcA6dkAPHXShQ2Vxb7to1nk8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KGHH3xFkcnxaDTS9/4tKaKVczdhgWizuiLyIDwz4cbmGEAn1OZFrC3IVuyVeDnQVuLGr5GBXuhOz3IzQPFbGRM4Tih/E6h0nAb70qqFW0ljOGvEaQsSaG+d6Pao/kz8HHQoqozAuTOhieYT43gpP4flRfu437B4ngU/UzY67xb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RGQnoufZ; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713936586; x=1745472586;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vVb6RIIvOt4enB6/MzuWcA6dkAPHXShQ2Vxb7to1nk8=;
  b=RGQnoufZII6jQNW8lA++dA0x/bwNpDJqWF2SEDqKWYxSn/06p7yctrLh
   fwIE4acPlPnXmRG2aWtswGH8mrtbKvJp19OPEcx/FINQC/gaM9B2+kGX/
   yyyTPXjolcGvvxNZ4vdZpgF3zKP1M1X0Lv3xJBr9ejKDWO7M1EppPVJF5
   w8hbYIF+t8WkHfqpmQKinlI1svWGyUx0EKzfQ1SeAI1KTCXZXZCJgWW7k
   DyKeR2idNaPNEVmeRiVhGq8FHGTGWVSPe3/cCaq2+IPiwiRLL97QEDLsp
   abu1Yi/G6Y09as+1dWSNFNd9Dz3ril8KO97OrCWbdn3E2FuQm2jyEF63W
   w==;
X-CSE-ConnectionGUID: 22jTlp4oQOCCXTZJI1elaQ==
X-CSE-MsgGUID: EmBmKdsOS0Guory+w9IP/A==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="27004186"
X-IronPort-AV: E=Sophos;i="6.07,225,1708416000"; 
   d="scan'208";a="27004186"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 22:29:45 -0700
X-CSE-ConnectionGUID: L2sj6Cs+Tj+J/3PjA4uG7g==
X-CSE-MsgGUID: cBYvsSoMS+GBiu/n6bwCcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,225,1708416000"; 
   d="scan'208";a="62049714"
Received: from unknown (HELO haibo-OptiPlex-7090.sh.intel.com) ([10.239.159.132])
  by orviesa001.jf.intel.com with ESMTP; 23 Apr 2024 22:29:35 -0700
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
	Guo Ren <guoren@kernel.org>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Baoquan He <bhe@redhat.com>,
	Greentime Hu <greentime.hu@sifive.com>,
	Zong Li <zong.li@sifive.com>,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Chen Jiahao <chenjiahao16@huawei.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	James Morse <james.morse@arm.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Evan Green <evan@rivosinc.com>,
	Yang Li <yang.lee@linux.alibaba.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ard Biesheuvel <ardb@kernel.org>,
	Tony Luck <tony.luck@intel.com>,
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
Subject: [PATCH v3 1/6] ACPICA: SRAT: Add RISC-V RINTC affinity structure
Date: Wed, 24 Apr 2024 13:46:21 +0800
Message-Id: <400608fe1804f5f2b52e611bf58e3a3a0b839b92.1713778236.git.haibo1.xu@intel.com>
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

ACPICA commit 93caddbf2f620769052c59ec471f018281dc3a24

Add definition of RISC-V Interrupt Controller(RINTC)
affinity structure which was approved by UEFI forum
and will be part of next ACPI spec version(6.6).

Link: https://github.com/acpica/acpica/commit/93caddbf
Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
---
 include/acpi/actbl3.h | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/include/acpi/actbl3.h b/include/acpi/actbl3.h
index c080d579a546..5202e3fc9b41 100644
--- a/include/acpi/actbl3.h
+++ b/include/acpi/actbl3.h
@@ -192,7 +192,8 @@ enum acpi_srat_type {
 	ACPI_SRAT_TYPE_GIC_ITS_AFFINITY = 4,	/* ACPI 6.2 */
 	ACPI_SRAT_TYPE_GENERIC_AFFINITY = 5,	/* ACPI 6.3 */
 	ACPI_SRAT_TYPE_GENERIC_PORT_AFFINITY = 6,	/* ACPI 6.4 */
-	ACPI_SRAT_TYPE_RESERVED = 7	/* 7 and greater are reserved */
+	ACPI_SRAT_TYPE_RINTC_AFFINITY = 7,	/* ACPI 6.6 */
+	ACPI_SRAT_TYPE_RESERVED = 8	/* 8 and greater are reserved */
 };
 
 /*
@@ -296,6 +297,21 @@ struct acpi_srat_generic_affinity {
 #define ACPI_SRAT_GENERIC_AFFINITY_ENABLED     (1)	/* 00: Use affinity structure */
 #define ACPI_SRAT_ARCHITECTURAL_TRANSACTIONS   (1<<1)	/* ACPI 6.4 */
 
+/* 7: RINTC Affinity (ACPI 6.6) */
+
+struct acpi_srat_rintc_affinity {
+	struct acpi_subtable_header header;
+	u16 reserved;           /* Reserved, must be zero */
+	u32 proximity_domain;
+	u32 acpi_processor_uid;
+	u32 flags;
+	u32 clock_domain;
+};
+
+/* Flags for struct acpi_srat_rintc_affinity */
+
+#define ACPI_SRAT_RINTC_ENABLED     (1)	/* 00: Use affinity structure */
+
 /*******************************************************************************
  *
  * STAO - Status Override Table (_STA override) - ACPI 6.0
-- 
2.34.1


