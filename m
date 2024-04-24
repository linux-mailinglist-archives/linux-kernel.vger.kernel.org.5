Return-Path: <linux-kernel+bounces-156306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B00F8B010C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 07:31:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AD001C226C1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 05:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 046EC156673;
	Wed, 24 Apr 2024 05:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OA9mFPSn"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF19D154BFC;
	Wed, 24 Apr 2024 05:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713936667; cv=none; b=LrR52KXkwIEmJuPoZKJcg08zIElBicXA5DlK9C3oMWCEifU5NQvyydtiQ34DlDaDzirZYGtrfIjImxEL+k9prWuDRqECRRRWLIqG8Y63QM18v15skVMBW4FsCoj6T66ChRz7dHFhK3/+dWbK2V5wTIPaOYW5ofRw4QNqsuUv/qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713936667; c=relaxed/simple;
	bh=Xx39zSGpS7CLVBj5LielZhHEXa/MDDWMlQjEZWaS27o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IwzcYkzGrV51IdYotTre8uZUNJd0gPsircQU4yM5MyX5Y++zvOeCyR0UXSFUbUK5qQlq9YNOIsLZfeo+VPE3jqiItojmjYpIUzRjOUCjtsl8tUJ+QPVHXNoevtKC6A+i3IAposQeqMvj1umf2Y5po/rFYwipdvdCMHCgXVjffSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OA9mFPSn; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713936667; x=1745472667;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Xx39zSGpS7CLVBj5LielZhHEXa/MDDWMlQjEZWaS27o=;
  b=OA9mFPSnE+SHBYO3BftzWPtlKspDpmsy7qgRUNOie2Qfy9CZgvxzZu+8
   BD+Tspq1ML9uHLBGh/Fhrnwbp+Vm6eryZ28zt5SVQJjlXx0tt1fJxCYHH
   L6m8shgsdfuX2f8SkqcJXl1f0+PEf4lb/wJ8CsfLdhJuNXWTuwIFQI5VL
   QJpn4gqg9Z1NkL2GJxftO2qcF6X8fH3ewRpcde/KTCwHOU7wOqNELgtS9
   MXh7lMlMjzCD8YZNAZ6zq+h3a5+HILIfS6bpAs0ZP6nQMfyQFIzxtsZRd
   7llYVe6VTjqVOEdk1D8xgZ/mQOFMam42pDiY+4ETTQF2K99UYlwXX/a25
   Q==;
X-CSE-ConnectionGUID: jaHX/1eBRcixuW1OYI7QLg==
X-CSE-MsgGUID: Bd0QOJ5ASwqGk6eIZn/4Og==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="27004425"
X-IronPort-AV: E=Sophos;i="6.07,225,1708416000"; 
   d="scan'208";a="27004425"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 22:31:06 -0700
X-CSE-ConnectionGUID: qWS/ZITWTV66hOx7yeOqmQ==
X-CSE-MsgGUID: Nbe1G5h2Sai4uMbWmluw7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,225,1708416000"; 
   d="scan'208";a="62050438"
Received: from unknown (HELO haibo-OptiPlex-7090.sh.intel.com) ([10.239.159.132])
  by orviesa001.jf.intel.com with ESMTP; 23 Apr 2024 22:30:56 -0700
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
	Baoquan He <bhe@redhat.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Greentime Hu <greentime.hu@sifive.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Zong Li <zong.li@sifive.com>,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Chen Jiahao <chenjiahao16@huawei.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	James Morse <james.morse@arm.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Evan Green <evan@rivosinc.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ard Biesheuvel <ardb@kernel.org>,
	Tony Luck <tony.luck@intel.com>,
	Yuntao Wang <ytcoode@gmail.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev
Subject: [PATCH v3 5/6] ACPI: NUMA: change the ACPI_NUMA to a hidden option
Date: Wed, 24 Apr 2024 13:46:25 +0800
Message-Id: <5c3a005a67096010cf3c465f8e3362651763fe3b.1713778236.git.haibo1.xu@intel.com>
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

x86/arm64/loongarch would select ACPI_NUMA by default and riscv
would do the same thing, so change it to a hidden option and the
select statements except for the X86_64_ACPI_NUMA can also go away.

Suggested-by: Arnd Bergmann <arnd@arndb.de>
Suggested-by: Sunil V L <sunilvl@ventanamicro.com>
Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
---
 arch/arm64/Kconfig        | 1 -
 arch/loongarch/Kconfig    | 1 -
 drivers/acpi/numa/Kconfig | 5 +----
 3 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 7b11c98b3e84..c6c667898da6 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1439,7 +1439,6 @@ config HOTPLUG_CPU
 config NUMA
 	bool "NUMA Memory Allocation and Scheduler Support"
 	select GENERIC_ARCH_NUMA
-	select ACPI_NUMA if ACPI
 	select OF_NUMA
 	select HAVE_SETUP_PER_CPU_AREA
 	select NEED_PER_CPU_EMBED_FIRST_CHUNK
diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index a5f300ec6f28..29d574a5c34c 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -465,7 +465,6 @@ config NR_CPUS
 config NUMA
 	bool "NUMA Support"
 	select SMP
-	select ACPI_NUMA if ACPI
 	help
 	  Say Y to compile the kernel with NUMA (Non-Uniform Memory Access)
 	  support.  This option improves performance on systems with more
diff --git a/drivers/acpi/numa/Kconfig b/drivers/acpi/numa/Kconfig
index 849c2bd820b9..f33194d1e43f 100644
--- a/drivers/acpi/numa/Kconfig
+++ b/drivers/acpi/numa/Kconfig
@@ -1,9 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 config ACPI_NUMA
-	bool "NUMA support"
-	depends on NUMA
-	depends on (X86 || ARM64 || LOONGARCH)
-	default y if ARM64
+	def_bool NUMA && !X86
 
 config ACPI_HMAT
 	bool "ACPI Heterogeneous Memory Attribute Table Support"
-- 
2.34.1


