Return-Path: <linux-kernel+bounces-128521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0585F895BFC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 20:50:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36C5A1C2262B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 18:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47AEA15B97A;
	Tue,  2 Apr 2024 18:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Kgu/3+e6"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B090315B553;
	Tue,  2 Apr 2024 18:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712083797; cv=none; b=bONRNFTBV4VVEO7MLEShEA2zTaPcv9WK6tXgFQuP2npBqUdG7zLQx0sSwsrhIvuEkyb2EG7RRTbAnTzT/qYD0BLoZy0adNbXkKNfl9M9f9Sdq0xHDc9sIHVQ4fWcmD/0zarLpITdTBsY4Cz4MqUuygZvE8Q167koO8eitxMTMCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712083797; c=relaxed/simple;
	bh=+jxJFFGhO18A5fcTOhAFG93kDT8mXXm+SYRYnLhGXjQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eSsHlVh4pwwBH1KzWx+laKjGXB1sF0U9EOQ//QW9AjmhpZbx0gEtJnIICf7O+DPvoatwS48lL7PJ/m7thJnchy729A92cJ/AL3ZsW/AXyrxGfZMtXG/rcDGKitpoVUYF+RnyIr4HiR9R9ldsnbxUql189pSv6JRSlYq7ULE/kTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Kgu/3+e6; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712083796; x=1743619796;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+jxJFFGhO18A5fcTOhAFG93kDT8mXXm+SYRYnLhGXjQ=;
  b=Kgu/3+e6Luv/yxUCuM2rhqYg4Etpk/KYFVtAHerd1sADEOjbYg/TM4/8
   DaoR2MWxRxf/4HkL1ippya3y1l65MUsLkyJy9t0eWxpZCCB7BxdXWP9Rm
   GQcK1/Dz7aS/298QzXtEuu773O0OXG6tbKxWjjPmOcG6RHmEs19LG2PRd
   5yGxVzO90+r8HiyExk3iNOA0+XdcSjTxaaadm+BagCD8JXBgQ50J+4bZq
   AABTFhf22j+dqGznPnN25mE8U5LmXA1tqDzc82O7+jd7x0fBWfgR+lgiL
   VmOxEiP3epSaKXawsgBR8YGVPR5WgQE18tQepn7g6qVNjv5n+X2TV7SDY
   w==;
X-CSE-ConnectionGUID: 7Z2VweekS6KLqCV7hnfkwA==
X-CSE-MsgGUID: K45Wp5HTTyuLscVu4WU/hQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="11101122"
X-IronPort-AV: E=Sophos;i="6.07,175,1708416000"; 
   d="scan'208";a="11101122"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 11:49:55 -0700
X-CSE-ConnectionGUID: NCxthvyYSN+jtveitdjXxg==
X-CSE-MsgGUID: qgn/jjCYRsijkuf1qXgn+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,175,1708416000"; 
   d="scan'208";a="18222581"
Received: from sj-4150-psse-sw-opae-dev3.sj.intel.com ([10.233.115.74])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 11:49:54 -0700
From: Peter Colberg <peter.colberg@intel.com>
To: Moritz Fischer <mdf@kernel.org>,
	Wu Hao <hao.wu@intel.com>,
	Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>,
	Lee Jones <lee@kernel.org>,
	linux-fpga@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Russ Weight <russ.weight@linux.dev>,
	Marco Pagani <marpagan@redhat.com>,
	Matthew Gerlach <matthew.gerlach@linux.intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Russ Weight <russell.h.weight@intel.com>,
	Peter Colberg <peter.colberg@intel.com>
Subject: [PATCH v2] mfd: intel-m10-bmc: Change staging size to a variable
Date: Tue,  2 Apr 2024 14:49:25 -0400
Message-ID: <20240402184925.1065932-1-peter.colberg@intel.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

The secure update driver does a sanity-check of the image size in
comparison to the size of the staging area in FLASH. Instead of
hard-wiring M10BMC_STAGING_SIZE, move the staging size to the
m10bmc_csr_map structure to make the size assignment more flexible.

Co-developed-by: Russ Weight <russell.h.weight@intel.com>
Signed-off-by: Russ Weight <russell.h.weight@intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Peter Colberg <peter.colberg@intel.com>
---
v2:
- Revise commit message to remove reference to nonexistent larger FPGAs.
---
 drivers/fpga/intel-m10-bmc-sec-update.c | 3 ++-
 drivers/mfd/intel-m10-bmc-pmci.c        | 1 +
 drivers/mfd/intel-m10-bmc-spi.c         | 1 +
 include/linux/mfd/intel-m10-bmc.h       | 1 +
 4 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/fpga/intel-m10-bmc-sec-update.c b/drivers/fpga/intel-m10-bmc-sec-update.c
index 89851b133709..7ac9f9f5af12 100644
--- a/drivers/fpga/intel-m10-bmc-sec-update.c
+++ b/drivers/fpga/intel-m10-bmc-sec-update.c
@@ -529,11 +529,12 @@ static enum fw_upload_err m10bmc_sec_prepare(struct fw_upload *fwl,
 					     const u8 *data, u32 size)
 {
 	struct m10bmc_sec *sec = fwl->dd_handle;
+	const struct m10bmc_csr_map *csr_map = sec->m10bmc->info->csr_map;
 	u32 ret;
 
 	sec->cancel_request = false;
 
-	if (!size || size > M10BMC_STAGING_SIZE)
+	if (!size || size > csr_map->staging_size)
 		return FW_UPLOAD_ERR_INVALID_SIZE;
 
 	if (sec->m10bmc->flash_bulk_ops)
diff --git a/drivers/mfd/intel-m10-bmc-pmci.c b/drivers/mfd/intel-m10-bmc-pmci.c
index 0392ef8b57d8..698c5933938b 100644
--- a/drivers/mfd/intel-m10-bmc-pmci.c
+++ b/drivers/mfd/intel-m10-bmc-pmci.c
@@ -370,6 +370,7 @@ static const struct m10bmc_csr_map m10bmc_n6000_csr_map = {
 	.pr_reh_addr = M10BMC_N6000_PR_REH_ADDR,
 	.pr_magic = M10BMC_N6000_PR_PROG_MAGIC,
 	.rsu_update_counter = M10BMC_N6000_STAGING_FLASH_COUNT,
+	.staging_size = M10BMC_STAGING_SIZE,
 };
 
 static const struct intel_m10bmc_platform_info m10bmc_pmci_n6000 = {
diff --git a/drivers/mfd/intel-m10-bmc-spi.c b/drivers/mfd/intel-m10-bmc-spi.c
index cbeb7de9e041..d64d28199df6 100644
--- a/drivers/mfd/intel-m10-bmc-spi.c
+++ b/drivers/mfd/intel-m10-bmc-spi.c
@@ -109,6 +109,7 @@ static const struct m10bmc_csr_map m10bmc_n3000_csr_map = {
 	.pr_reh_addr = M10BMC_N3000_PR_REH_ADDR,
 	.pr_magic = M10BMC_N3000_PR_PROG_MAGIC,
 	.rsu_update_counter = M10BMC_N3000_STAGING_FLASH_COUNT,
+	.staging_size = M10BMC_STAGING_SIZE,
 };
 
 static struct mfd_cell m10bmc_d5005_subdevs[] = {
diff --git a/include/linux/mfd/intel-m10-bmc.h b/include/linux/mfd/intel-m10-bmc.h
index ee66c9751003..988f1cd90032 100644
--- a/include/linux/mfd/intel-m10-bmc.h
+++ b/include/linux/mfd/intel-m10-bmc.h
@@ -205,6 +205,7 @@ struct m10bmc_csr_map {
 	unsigned int pr_reh_addr;
 	unsigned int pr_magic;
 	unsigned int rsu_update_counter;
+	unsigned int staging_size;
 };
 
 /**
-- 
2.44.0


