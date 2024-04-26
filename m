Return-Path: <linux-kernel+bounces-159388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FE3D8B2E06
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 02:28:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3AD71C21781
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 00:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 096A323A0;
	Fri, 26 Apr 2024 00:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ek3txEhk"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D473C394;
	Fri, 26 Apr 2024 00:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714091279; cv=none; b=TK/IC9UZuKuMg4HevCkhLPbHEzN2jL3vsXh2cRv9UUB3Shd0V4RdCZdfqgMBl4sS/vyvXwYzg/byVCKA5oYfdeJh/Nj89FA5a7+Y0yiGMbTexScJsDY3xg+8nIjnYCE1sVLyVzGouEeo31muFZXFUuEbFtPbDEURyqf9XgS/v7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714091279; c=relaxed/simple;
	bh=lyIbq+nP0cBCF1zgRWYmDIwwiLEkwqeSE8WWHJwMHZs=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jPSOwVnkdenpzVFetEQ13bYmor3/oxfTPcVgijkRkrUai1ieOjbP6b7FfWQ5Dg8n7eankTCRWVNjTUT7kZ57Q3RPzNNw1MRr9xLXQ/PBMz1K1heOENtNHo1Z0o57Lp3slNOIcNheIzej87h5QLagRRgk+1MTJtS/GUr0ActUV7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ek3txEhk; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714091278; x=1745627278;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=lyIbq+nP0cBCF1zgRWYmDIwwiLEkwqeSE8WWHJwMHZs=;
  b=ek3txEhkNu+uDX9JmlhnhUnHlNPwM1RiJHx9RloyR9hJeI2SkwHg7WGa
   bYFvxut0tJyorUlLPkiBg7Y18h9NhE0TsqgpFTgkfcToLGDEl4rwKj20e
   XR+dM7/gpiCWaHDFTzGhF2SwhuhW//6IZpSblfX5hBtNUBKMCUc3FMjlP
   JbK6Uqp5PN1vGQlgqOdHPxYuATKjTmE1u0LzBgLY8hwvellRfsBaWhWj9
   iGoWHBNQjohq80OgdydH7ZJb/IhV2B88bIhspe46JJZjQGDJ8/6OdxCk0
   6kofPfZOQPBksM+p/x0xlA0XlKI5/Fn/V0jzE6RDaR/fSfISGssLbmhXr
   w==;
X-CSE-ConnectionGUID: kiaeID87R0WNaXrUNKj23w==
X-CSE-MsgGUID: InRKLERkTy6oUBRGL30zZg==
X-IronPort-AV: E=McAfee;i="6600,9927,11055"; a="9650244"
X-IronPort-AV: E=Sophos;i="6.07,230,1708416000"; 
   d="scan'208";a="9650244"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2024 17:27:56 -0700
X-CSE-ConnectionGUID: NuB36YcDQfW+cUlI0E50mQ==
X-CSE-MsgGUID: iW+sq78RQza+r7TGw6X4Mg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,230,1708416000"; 
   d="scan'208";a="25329113"
Received: from breannah-mobl.amr.corp.intel.com (HELO xpardee-test1.hsd1.or.comcast.net) ([10.209.32.125])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2024 17:27:55 -0700
From: Xi Pardee <xi.pardee@linux.intel.com>
To: xi.pardee@linux.intel.com,
	irenic.rajneesh@gmail.com,
	david.e.box@intel.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] platform/x86:intel/pmc: Add support to show S0ix blocker counter
Date: Thu, 25 Apr 2024 17:27:51 -0700
Message-Id: <20240426002752.2504282-3-xi.pardee@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240426002752.2504282-1-xi.pardee@linux.intel.com>
References: <20240426002752.2504282-1-xi.pardee@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Xi Pardee <xi.pardee@intel.com>

S0ix blocker counter is available in PWRM space. Add support to
read and show S0ix blocker counter value through debugfs.

Signed-off-by: Xi Pardee <xi.pardee@intel.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/platform/x86/intel/pmc/core.c | 38 +++++++++++++++++++++++++++
 drivers/platform/x86/intel/pmc/core.h |  6 +++++
 2 files changed, 44 insertions(+)

diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
index 10c96c1a850a..2ad2f8753e5d 100644
--- a/drivers/platform/x86/intel/pmc/core.c
+++ b/drivers/platform/x86/intel/pmc/core.c
@@ -678,6 +678,41 @@ static int pmc_core_ltr_show(struct seq_file *s, void *unused)
 }
 DEFINE_SHOW_ATTRIBUTE(pmc_core_ltr);
 
+static int pmc_core_s0ix_blocker_show(struct seq_file *s, void *unused)
+{
+	struct pmc_dev *pmcdev = s->private;
+	unsigned int pmcidx;
+
+	for (pmcidx = 0; pmcidx < ARRAY_SIZE(pmcdev->pmcs); pmcidx++) {
+		const struct pmc_bit_map **maps;
+		unsigned int arr_size, r_idx;
+		u32 offset, counter;
+		struct pmc *pmc;
+
+		pmc = pmcdev->pmcs[pmcidx];
+		if (!pmc)
+			continue;
+		maps = pmc->map->s0ix_blocker_maps;
+		offset = pmc->map->s0ix_blocker_offset;
+		arr_size = pmc_core_lpm_get_arr_size(maps);
+
+		for (r_idx = 0; r_idx < arr_size; r_idx++) {
+			const struct pmc_bit_map *map;
+
+			for (map = maps[r_idx]; map->name; map++) {
+				if (!map->blk)
+					continue;
+				counter = pmc_core_reg_read(pmc, offset);
+				seq_printf(s, "PMC%d:%-30s %-30d\n", pmcidx,
+					   map->name, counter);
+				offset += map->blk * S0IX_BLK_SIZE;
+			}
+		}
+	}
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(pmc_core_s0ix_blocker);
+
 static inline u64 adjust_lpm_residency(struct pmc *pmc, u32 offset,
 				       const int lpm_adj_x2)
 {
@@ -1197,6 +1232,9 @@ static void pmc_core_dbgfs_register(struct pmc_dev *pmcdev)
 
 	debugfs_create_file("ltr_show", 0444, dir, pmcdev, &pmc_core_ltr_fops);
 
+	if (primary_pmc->map->s0ix_blocker_maps)
+		debugfs_create_file("s0ix_blocker", 0444, dir, pmcdev, &pmc_core_s0ix_blocker_fops);
+
 	debugfs_create_file("package_cstate_show", 0444, dir, primary_pmc,
 			    &pmc_core_pkgc_fops);
 
diff --git a/drivers/platform/x86/intel/pmc/core.h b/drivers/platform/x86/intel/pmc/core.h
index 18ba4f901c10..88acfa801b5a 100644
--- a/drivers/platform/x86/intel/pmc/core.h
+++ b/drivers/platform/x86/intel/pmc/core.h
@@ -22,6 +22,7 @@ struct telem_endpoint;
 
 #define PMC_BASE_ADDR_DEFAULT			0xFE000000
 #define MAX_NUM_PMC			3
+#define S0IX_BLK_SIZE			4
 
 /* Sunrise Point Power Management Controller PCI Device ID */
 #define SPT_PMC_PCI_DEVICE_ID			0x9d21
@@ -288,6 +289,7 @@ extern const char *pmc_lpm_modes[];
 struct pmc_bit_map {
 	const char *name;
 	u32 bit_mask;
+	u8 blk;
 };
 
 /**
@@ -298,6 +300,7 @@ struct pmc_bit_map {
  * @pll_sts:		Maps name of PLL to corresponding bit status
  * @slps0_dbg_maps:	Array of SLP_S0_DBG* registers containing debug info
  * @ltr_show_sts:	Maps PCH IP Names to their MMIO register offsets
+ * @s0ix_blocker_maps:	Maps name of IP block to S0ix blocker counter
  * @slp_s0_offset:	PWRMBASE offset to read SLP_S0 residency
  * @ltr_ignore_offset:	PWRMBASE offset to read/write LTR ignore bit
  * @regmap_length:	Length of memory to map from PWRMBASE address to access
@@ -307,6 +310,7 @@ struct pmc_bit_map {
  * @pm_cfg_offset:	PWRMBASE offset to PM_CFG register
  * @pm_read_disable_bit: Bit index to read PMC_READ_DISABLE
  * @slps0_dbg_offset:	PWRMBASE offset to SLP_S0_DEBUG_REG*
+ * @s0ix_blocker_offset PWRMBASE offset to S0ix blocker counter
  *
  * Each PCH has unique set of register offsets and bit indexes. This structure
  * captures them to have a common implementation.
@@ -319,6 +323,7 @@ struct pmc_reg_map {
 	const struct pmc_bit_map *ltr_show_sts;
 	const struct pmc_bit_map *msr_sts;
 	const struct pmc_bit_map **lpm_sts;
+	const struct pmc_bit_map **s0ix_blocker_maps;
 	const u32 slp_s0_offset;
 	const int slp_s0_res_counter_step;
 	const u32 ltr_ignore_offset;
@@ -330,6 +335,7 @@ struct pmc_reg_map {
 	const u32 slps0_dbg_offset;
 	const u32 ltr_ignore_max;
 	const u32 pm_vric1_offset;
+	const u32 s0ix_blocker_offset;
 	/* Low Power Mode registers */
 	const int lpm_num_maps;
 	const int lpm_num_modes;
-- 
2.34.1


