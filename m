Return-Path: <linux-kernel+bounces-156307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BB6B8B010D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 07:31:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4FE728546E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 05:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 292E915667D;
	Wed, 24 Apr 2024 05:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gL0SCOdX"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F670155356;
	Wed, 24 Apr 2024 05:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713936689; cv=none; b=N2vL261tcfzBaLE1RrEvI+3CaMuuEX8fpEczVmGdtg7KBDfk/Ra7RznYLTc/f29fhA051Wq0SvzLvOl3bI9ChjZBpLEr3i3v+8InKiQ4roTuW5n1nuchyLgOsOFK9ZInF3Fyx32fUl6q3y/rbtHzxiW/UjoUWT6NxV0uhjxEB9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713936689; c=relaxed/simple;
	bh=tPo4ypzFj/KicqcCKxaiOjCo7Eyu+TsGnLXFq3hFYTc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nAN+r1BSvurJON20sFRtMOSC/OSPfwYhpGQD+OGaxd6B7e8J54XsI9IqI1TJ9Z91JZBq7E/uQ6v3xVlEEWZZEpWH1asA+mnAW9/pIqgBjR6vM30CcO89Jn73WzI+nC0AF1twY2FMK36jpBxm6TIcWh3KjcKwYO4YVdpAmseu3wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gL0SCOdX; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713936688; x=1745472688;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tPo4ypzFj/KicqcCKxaiOjCo7Eyu+TsGnLXFq3hFYTc=;
  b=gL0SCOdXaEOJkH48CwLlNNYb6X1X+WgXbMhxfce6c9ajjf80uUQd2Y20
   zeDuvOBH0G2EjuNKylfmUC3P/Xo7+hg+ehq0kJWcJInFDGYlSRzh8zZMV
   m/wVG4i1TVN7zKSGppqK22sLVoWcb7ZmXu7+Fz5mGv+ivflyfqhz0nZIV
   nJMB7HpeKo0agO08rYM0WFxPRgUFiWodR2j+bLc/qg+lxFMAu9ondfK/N
   MXvMoKpagHAVsJbTIVPb/TkOQ4MOdspxdlEYj633+63E+buxi5fY1sfm/
   Q6IiKZEST49vy5VNN/y92fYhrYp/Qd3JDtZhHXxk9Wx2SL2MmxRbFc+s2
   A==;
X-CSE-ConnectionGUID: LFTOQx15QXaHIc+lR4XO/g==
X-CSE-MsgGUID: rGh+fLP+RsGFaQJfVLQawg==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="27004485"
X-IronPort-AV: E=Sophos;i="6.07,225,1708416000"; 
   d="scan'208";a="27004485"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 22:31:28 -0700
X-CSE-ConnectionGUID: K2nGZA+6SxS85oF+8k8ISA==
X-CSE-MsgGUID: idXSMI25RBWTdeIp9t4v1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,225,1708416000"; 
   d="scan'208";a="62050525"
Received: from unknown (HELO haibo-OptiPlex-7090.sh.intel.com) ([10.239.159.132])
  by orviesa001.jf.intel.com with ESMTP; 23 Apr 2024 22:31:16 -0700
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
	Baoquan He <bhe@redhat.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Chen Jiahao <chenjiahao16@huawei.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	James Morse <james.morse@arm.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Evan Green <evan@rivosinc.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Marc Zyngier <maz@kernel.org>,
	Tony Luck <tony.luck@intel.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Yuntao Wang <ytcoode@gmail.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev
Subject: [PATCH v3 6/6] ACPI: NUMA: replace pr_info with pr_debug in arch_acpi_numa_init
Date: Wed, 24 Apr 2024 13:46:26 +0800
Message-Id: <70870d88a26f50677eb31ac72bd8c343f428e5b6.1713778236.git.haibo1.xu@intel.com>
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

There are lots of ACPI enabled systems that aren't NUMA and If the
firmware didn't provide the SRAT/SLIT, then there will be a message
"Failed to initialise from firmware" from arch_acpi_numa_init() which
adding noise to the boot on all of those kind of systems. Replace the
pr_info with pr_debug in arch_acpi_numa_init() to avoid it.

Suggested-by: Sunil V L <sunilvl@ventanamicro.com>
Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
---
 drivers/base/arch_numa.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/arch_numa.c b/drivers/base/arch_numa.c
index 5b59d133b6af..555aee3ee8e7 100644
--- a/drivers/base/arch_numa.c
+++ b/drivers/base/arch_numa.c
@@ -445,7 +445,7 @@ static int __init arch_acpi_numa_init(void)
 
 	ret = acpi_numa_init();
 	if (ret) {
-		pr_info("Failed to initialise from firmware\n");
+		pr_debug("Failed to initialise from firmware\n");
 		return ret;
 	}
 
-- 
2.34.1


