Return-Path: <linux-kernel+bounces-156305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09D178B0109
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 07:30:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3CC95B230CE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 05:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35F74156668;
	Wed, 24 Apr 2024 05:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GbDBCcQ6"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA3D1552FC;
	Wed, 24 Apr 2024 05:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713936647; cv=none; b=T/RKMeJX1PqyvIomq8X2o7m65276+XQxhICwE5nIL+0hLjiBfVicnFArYf7YpoW0+/puOyV2VJuU/j3XIrZrafYBRLAAaH8twogGv8u5kTYo+n3jHXFfEzDaAYIGb77hiblj2ugnJ526st0gEznOHziBlVerSga+Y6lukvUmGjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713936647; c=relaxed/simple;
	bh=LBRamLcaPYBt1vaIiWAE+5pLGZIJAaHQiWBQITKAtzg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AtO5N+3fy8Y6iYjaAU3c4qbuU+hAea6uOD6ORP8ZQ/qlnVxt2LKpUwV2iNM/P/emXLh0e1/NSQwsBngTux0LI2dJyBpHOK1BFqmY7i2vk0YVavpK3IKcNGns3aWbA4QAfpdWHa8RpGRdUiRP0tMlSmmSs7H2DYw+8Ibbd8DnmhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GbDBCcQ6; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713936647; x=1745472647;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LBRamLcaPYBt1vaIiWAE+5pLGZIJAaHQiWBQITKAtzg=;
  b=GbDBCcQ6Xhf/sWegGNDkPrJvIYcbBl5d/ndugUt2g3C19OLp6Q2D/FO8
   OAW9qhEEQzrPaahRWq7V0jwbP4Zexyx1Wz9Ffvro7ro39LsfBTYTP7HZq
   GgNf+1QgG+Nyvo6XbSILBa/UcSf4XrzPM6ZsPGYeaaxV/lxSD/66+ZJgG
   EYwjhvtjMmE/vzB0agsQYz8W6Mqht83jyAWjh9LCjN1GGSl/EyWAKT1uM
   +V8kzpCvQyLJ229igZMiZgIp3mlpWF/Plb7u9e3QqzS1Te2Cz2u74IxqB
   uRQnX9Sln+S0qwmw5luOLrZSzTdUIi5D3v50NWsBpAyX/CqDxp1Es88Pe
   w==;
X-CSE-ConnectionGUID: sMy9ySTkTHC22po1vnXNKg==
X-CSE-MsgGUID: 2rUpQHQ9SQerxBnWKaR3UQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="27004358"
X-IronPort-AV: E=Sophos;i="6.07,225,1708416000"; 
   d="scan'208";a="27004358"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 22:30:46 -0700
X-CSE-ConnectionGUID: NJ2MBZ8YRCSg/pZQf2DG6g==
X-CSE-MsgGUID: aZfxAwKdTxWSKMg1Rak9mA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,225,1708416000"; 
   d="scan'208";a="62050299"
Received: from unknown (HELO haibo-OptiPlex-7090.sh.intel.com) ([10.239.159.132])
  by orviesa001.jf.intel.com with ESMTP; 23 Apr 2024 22:30:35 -0700
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
	Baoquan He <bhe@redhat.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Greentime Hu <greentime.hu@sifive.com>,
	Zong Li <zong.li@sifive.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Chen Jiahao <chenjiahao16@huawei.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	James Morse <james.morse@arm.com>,
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
Subject: [PATCH v3 4/6] ACPI: NUMA: Make some NUMA related parse functions common
Date: Wed, 24 Apr 2024 13:46:24 +0800
Message-Id: <bc3fabec0ce4c990adcae2bb136450f058f467af.1713778236.git.haibo1.xu@intel.com>
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

The acpi_numa_slit_init(), acpi_numa_memory_affinity_init()
and acpi_parse_cfmws() functions are common enough to be used
on platforms that support ACPI_NUMA(x86/arm64/loongarch).
Remove the condition to avoid long defined(CONFIG_ARCH) check
when new platform(riscv) support was enabled.

Suggested-by: Sunil V L <sunilvl@ventanamicro.com>
Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
Reviewed-by: Sunil V L <sunilvl@ventanamicro.com>
---
 drivers/acpi/numa/srat.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
index bc8f34b2ad51..860900faa843 100644
--- a/drivers/acpi/numa/srat.c
+++ b/drivers/acpi/numa/srat.c
@@ -221,7 +221,6 @@ int __init srat_disabled(void)
 	return acpi_numa < 0;
 }
 
-#if defined(CONFIG_X86) || defined(CONFIG_ARM64) || defined(CONFIG_LOONGARCH)
 /*
  * Callback for SLIT parsing.  pxm_to_node() returns NUMA_NO_NODE for
  * I/O localities since SRAT does not list them.  I/O localities are
@@ -353,13 +352,6 @@ static int __init acpi_parse_cfmws(union acpi_subtable_headers *header,
 	(*fake_pxm)++;
 	return 0;
 }
-#else
-static int __init acpi_parse_cfmws(union acpi_subtable_headers *header,
-				   void *arg, const unsigned long table_end)
-{
-	return 0;
-}
-#endif /* defined(CONFIG_X86) || defined (CONFIG_ARM64) */
 
 static int __init acpi_parse_slit(struct acpi_table_header *table)
 {
-- 
2.34.1


