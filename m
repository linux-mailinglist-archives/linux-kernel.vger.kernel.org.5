Return-Path: <linux-kernel+bounces-128673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE175895DF5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 22:45:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C5791C2258B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 20:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E12BC15E1EC;
	Tue,  2 Apr 2024 20:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gU/YeZI8"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A047215ADB1;
	Tue,  2 Apr 2024 20:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712090695; cv=none; b=dCXDxb2MDnXwF98gCWflSHvDINbiY9jl+159ZoMt53UlQNMYZK+8q95uC3zXYRfj070E5z/QLubNBtGXwPR+jB00c9BrLm47FiYoaK9NM3+1cW6zul9aw/SQyko3TrVnUeIBjVKzz8rzqKjdzrNv6LpZ4+QXrPwg2cJezRm4exg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712090695; c=relaxed/simple;
	bh=vcrKVU++LGt1iRwlSiCMBR0ER4wiRkTCi/zpxSgyE6g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o/OwIotO8yUEQ8z0Rkubkz/lAvMi8btwvPpOMsAEu/pOKma31nBRZ8VH4+d7378fSS41dMAm2wh0Ijo1WMqS4RR2H8fMIPv7PqQWyZb7c1teBXDDdbOOYFR3T7rsFvYs9W0d6046gBfWIcLoy8gncN5lRaGC0l5kjoUueD+kl68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gU/YeZI8; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712090693; x=1743626693;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=vcrKVU++LGt1iRwlSiCMBR0ER4wiRkTCi/zpxSgyE6g=;
  b=gU/YeZI8Y8D63sYcWTbCM3//6IRGn4Fv+RIuJUOprb4RCE2PiBbFjw1M
   hMatmF4hR+xLP/+S5a2kmMYkYsQAXM+rd52tt/hDbuSnbbIs4r5CFGLsH
   CXF/qJINHq/C0LRkxMW3w5CzIIx71ig2pRLndLmHWp2PKNGpLIS1VrjlP
   SJSftWVlAtWTvnYvwL6OvHpod+gE6r0IQk4zeI0BJRRHeWtu535X6PDFw
   6CUlQt2ZMjGWKeF68LSu6sHRAyaxc+X1pWJcVdwWY33H6h/lOimn86e22
   ZdwRlCNLl2wcnlDwPDemkwp1ExtEUYmzp93EAbmhXSPTy3uNYfPiKDCGv
   A==;
X-CSE-ConnectionGUID: gjb1uiXmQwWtG685ajzOKw==
X-CSE-MsgGUID: fwS7P0tlSa+ZvC7QkTmFhw==
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="7188486"
X-IronPort-AV: E=Sophos;i="6.07,176,1708416000"; 
   d="scan'208";a="7188486"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 13:44:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="937083805"
X-IronPort-AV: E=Sophos;i="6.07,176,1708416000"; 
   d="scan'208";a="937083805"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 02 Apr 2024 13:44:49 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id EEEC21C5; Tue,  2 Apr 2024 23:44:48 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Hans de Goede <hdegoede@redhat.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-media@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v1 1/1] media: atomisp: Get rid of PCI device ID hack check
Date: Tue,  2 Apr 2024 23:44:47 +0300
Message-ID: <20240402204447.294280-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Always check exact PCI ID match and drop hack checks.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 .../media/atomisp/pci/atomisp_internal.h      |  3 +-
 .../staging/media/atomisp/pci/atomisp_v4l2.c  | 40 +++++++++----------
 2 files changed, 21 insertions(+), 22 deletions(-)

diff --git a/drivers/staging/media/atomisp/pci/atomisp_internal.h b/drivers/staging/media/atomisp/pci/atomisp_internal.h
index bba9bc64d447..e6a090d9f310 100644
--- a/drivers/staging/media/atomisp/pci/atomisp_internal.h
+++ b/drivers/staging/media/atomisp/pci/atomisp_internal.h
@@ -49,14 +49,13 @@
 	(((isp)->media_dev.hw_revision & ATOMISP_HW_REVISION_MASK) == \
 	 ((rev) << ATOMISP_HW_REVISION_SHIFT))
 
-#define ATOMISP_PCI_DEVICE_SOC_MASK	0xfff8
+#define ATOMISP_PCI_DEVICE_SOC_BYT	0x0f38
 /* MRFLD with 0x1178: ISP freq can burst to 457MHz */
 #define ATOMISP_PCI_DEVICE_SOC_MRFLD	0x1178
 /* MRFLD with 0x1179: max ISP freq limited to 400MHz */
 #define ATOMISP_PCI_DEVICE_SOC_MRFLD_1179	0x1179
 /* MRFLD with 0x117a: max ISP freq is 400MHz and max freq at Vmin is 200MHz */
 #define ATOMISP_PCI_DEVICE_SOC_MRFLD_117A	0x117a
-#define ATOMISP_PCI_DEVICE_SOC_BYT	0x0f38
 #define ATOMISP_PCI_DEVICE_SOC_ANN	0x1478
 #define ATOMISP_PCI_DEVICE_SOC_CHT	0x22b8
 
diff --git a/drivers/staging/media/atomisp/pci/atomisp_v4l2.c b/drivers/staging/media/atomisp/pci/atomisp_v4l2.c
index f736e54c7df3..4f414b812408 100644
--- a/drivers/staging/media/atomisp/pci/atomisp_v4l2.c
+++ b/drivers/staging/media/atomisp/pci/atomisp_v4l2.c
@@ -1238,7 +1238,8 @@ static int atomisp_pci_probe(struct pci_dev *pdev, const struct pci_device_id *i
 	const struct atomisp_platform_data *pdata;
 	struct atomisp_device *isp;
 	unsigned int start;
-	int err, val;
+	u32 val;
+	int err;
 
 	/* Pointer to struct device. */
 	atomisp_dev = &pdev->dev;
@@ -1266,8 +1267,10 @@ static int atomisp_pci_probe(struct pci_dev *pdev, const struct pci_device_id *i
 
 	pci_set_drvdata(pdev, isp);
 
-	switch (id->device & ATOMISP_PCI_DEVICE_SOC_MASK) {
+	switch (id->device) {
 	case ATOMISP_PCI_DEVICE_SOC_MRFLD:
+	case ATOMISP_PCI_DEVICE_SOC_MRFLD_1179:
+	case ATOMISP_PCI_DEVICE_SOC_MRFLD_117A:
 		isp->media_dev.hw_revision =
 		    (ATOMISP_HW_REVISION_ISP2400
 		     << ATOMISP_HW_REVISION_SHIFT) |
@@ -1420,28 +1423,25 @@ static int atomisp_pci_probe(struct pci_dev *pdev, const struct pci_device_id *i
 	 */
 	atomisp_css2_hw_store_32(MRFLD_CSI_RECEIVER_SELECTION_REG, 1);
 
-	if ((id->device & ATOMISP_PCI_DEVICE_SOC_MASK) ==
-	    ATOMISP_PCI_DEVICE_SOC_MRFLD) {
-		u32 csi_afe_trim;
-
+	switch (id->device) {
+	case ATOMISP_PCI_DEVICE_SOC_MRFLD:
+	case ATOMISP_PCI_DEVICE_SOC_MRFLD_1179:
+	case ATOMISP_PCI_DEVICE_SOC_MRFLD_117A:
 		/*
 		 * Workaround for imbalance data eye issue which is observed
 		 * on TNG B0.
 		 */
-		pci_read_config_dword(pdev, MRFLD_PCI_CSI_AFE_TRIM_CONTROL, &csi_afe_trim);
-		csi_afe_trim &= ~((MRFLD_PCI_CSI_HSRXCLKTRIM_MASK <<
-				   MRFLD_PCI_CSI1_HSRXCLKTRIM_SHIFT) |
-				  (MRFLD_PCI_CSI_HSRXCLKTRIM_MASK <<
-				   MRFLD_PCI_CSI2_HSRXCLKTRIM_SHIFT) |
-				  (MRFLD_PCI_CSI_HSRXCLKTRIM_MASK <<
-				   MRFLD_PCI_CSI3_HSRXCLKTRIM_SHIFT));
-		csi_afe_trim |= (MRFLD_PCI_CSI1_HSRXCLKTRIM <<
-				 MRFLD_PCI_CSI1_HSRXCLKTRIM_SHIFT) |
-				(MRFLD_PCI_CSI2_HSRXCLKTRIM <<
-				 MRFLD_PCI_CSI2_HSRXCLKTRIM_SHIFT) |
-				(MRFLD_PCI_CSI3_HSRXCLKTRIM <<
-				 MRFLD_PCI_CSI3_HSRXCLKTRIM_SHIFT);
-		pci_write_config_dword(pdev, MRFLD_PCI_CSI_AFE_TRIM_CONTROL, csi_afe_trim);
+		pci_read_config_dword(pdev, MRFLD_PCI_CSI_AFE_TRIM_CONTROL, &val);
+		val &= ~((MRFLD_PCI_CSI_HSRXCLKTRIM_MASK << MRFLD_PCI_CSI1_HSRXCLKTRIM_SHIFT) |
+			 (MRFLD_PCI_CSI_HSRXCLKTRIM_MASK << MRFLD_PCI_CSI2_HSRXCLKTRIM_SHIFT) |
+			 (MRFLD_PCI_CSI_HSRXCLKTRIM_MASK << MRFLD_PCI_CSI3_HSRXCLKTRIM_SHIFT));
+		val |= (MRFLD_PCI_CSI1_HSRXCLKTRIM << MRFLD_PCI_CSI1_HSRXCLKTRIM_SHIFT) |
+		       (MRFLD_PCI_CSI2_HSRXCLKTRIM << MRFLD_PCI_CSI2_HSRXCLKTRIM_SHIFT) |
+		       (MRFLD_PCI_CSI3_HSRXCLKTRIM << MRFLD_PCI_CSI3_HSRXCLKTRIM_SHIFT);
+		pci_write_config_dword(pdev, MRFLD_PCI_CSI_AFE_TRIM_CONTROL, val);
+		break;
+	default:
+		break;
 	}
 
 	err = atomisp_initialize_modules(isp);
-- 
2.43.0.rc1.1.gbec44491f096


