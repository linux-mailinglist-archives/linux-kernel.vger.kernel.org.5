Return-Path: <linux-kernel+bounces-166666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 60EE28B9DCA
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 17:50:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 876A7B2226A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 15:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E02CD15B97D;
	Thu,  2 May 2024 15:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h6TlrR0e"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A889215B56A;
	Thu,  2 May 2024 15:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714665007; cv=none; b=hnl7VDJNNH1BtENyJ3JVPW3F/jbs5t70/z2UJ7csp5b7wUud22grIjJEu3hDe7Nv8n6YcokJ2chxSDJ0tZthcktDEEfST6nLPAqaWnWH9o5UKDGp/6SYQuc0b2TpyZmLdYdQc5cX1TMKgP3IdXVVYCChWnO6Ik6an8KXlkYCpqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714665007; c=relaxed/simple;
	bh=c0fcIIK1hzpM+Ucqk29XrQIIPoJgmlTgGSCF9ZJGE0A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eWK1GpfQm0QUGbnu4PxFkB3MJQFHqAMKMFIjDVE0sFy2ebYR67Mz3G9su2J+J03JZJGLxh+/qWYf+yKStSdjCB6g7yaqL9mp7sBNPF2ffwDOTpShzCUJeY5t/W/RfXqG0e18h3T7dLuUYiiBOaRoV5ElDirE68ku/yeYdU+sG9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h6TlrR0e; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714665006; x=1746201006;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=c0fcIIK1hzpM+Ucqk29XrQIIPoJgmlTgGSCF9ZJGE0A=;
  b=h6TlrR0eqTO2EavMXPYp3EkKiAmOjKw3rS173PY2LvAY+P4vN5oxFbkO
   WydyH86pVuT8ReHoiVk1C1xEj+gJBhnETGIKZ5Sqeu/+utAC4yCRLovqF
   mnJpOmIgTEd8kjvUk1xapXzLHsiSxL1s0uol3l2SyEDCFFCS8TZjPbJ/d
   m8TeDPCCBFnlKyXv8/fRrMYykTNRovFwXCT0w0477h/LQLuA24nPaWqAT
   vvK0iS58VJbma9s4Y/1yTYNH7pp8QvSSR2GwVxHiy+2J3lt6xzwP7TUmm
   +rWTEpi5sk9Yuppkud6sz2LVb1GxeROhDPFwK+CyNTvY2CYaeoblhfuab
   w==;
X-CSE-ConnectionGUID: mIlOiVaQSN+goI/3MwDibw==
X-CSE-MsgGUID: sVRpmQ1mRKWvkpMCe+av2w==
X-IronPort-AV: E=McAfee;i="6600,9927,11062"; a="14258466"
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="14258466"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2024 08:50:06 -0700
X-CSE-ConnectionGUID: lbDpu8gxRvmR8er5gnqm2Q==
X-CSE-MsgGUID: 1KMNCNGZR2edWYSi+7O3/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="31954329"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2024 08:50:03 -0700
Received: from punajuuri.localdomain (punajuuri.localdomain [192.168.240.130])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id C10F711FA94;
	Thu,  2 May 2024 18:50:00 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.96)
	(envelope-from <sakari.ailus@linux.intel.com>)
	id 1s2Yh6-002IpH-2M;
	Thu, 02 May 2024 18:50:00 +0300
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>,
	linux-media@vger.kernel.org
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Bingbu Cao <bingbu.cao@intel.com>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: [PATCH 1/1] media: intel/ipu6: Don't re-allocate memory for firmware
Date: Thu,  2 May 2024 18:49:50 +0300
Message-Id: <20240502154950.549015-1-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240501102236.3b2585d1@canb.auug.org.au>
References: <20240501102236.3b2585d1@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ipu6 driver allocated vmalloc memory for the firmware if
request_firmware() somehow managed not to use vmalloc to allocate it.

Still how the memory is allocated by request_firmware() is not specified
in its API, so be prepared for kmalloc-allocated firmware, too. Instead of
allocating new vmalloc-backed buffer for the firmware, obtain the pages
from virtual addresses instead.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Fixes: 25fedc021985 ("media: intel/ipu6: add Intel IPU6 PCI device driver")
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
Hello everyone,

Mauro preferred not to merge the earlier patch. Admittedly, there are
better ways to fix the problem. Such as this one.

- Sakari

 drivers/media/pci/intel/ipu6/ipu6-buttress.c |  7 +++-
 drivers/media/pci/intel/ipu6/ipu6.c          | 41 +-------------------
 2 files changed, 7 insertions(+), 41 deletions(-)

diff --git a/drivers/media/pci/intel/ipu6/ipu6-buttress.c b/drivers/media/pci/intel/ipu6/ipu6-buttress.c
index dbcf1aa87872..23c537e7ce1e 100644
--- a/drivers/media/pci/intel/ipu6/ipu6-buttress.c
+++ b/drivers/media/pci/intel/ipu6/ipu6-buttress.c
@@ -552,12 +552,16 @@ int ipu6_buttress_reset_authentication(struct ipu6_device *isp)
 int ipu6_buttress_map_fw_image(struct ipu6_bus_device *sys,
 			       const struct firmware *fw, struct sg_table *sgt)
 {
+	bool is_vmalloc = is_vmalloc_addr(fw->data);
 	struct page **pages;
 	const void *addr;
 	unsigned long n_pages;
 	unsigned int i;
 	int ret;
 
+	if (!is_vmalloc && !virt_addr_valid(fw->data))
+		return -EDOM;
+
 	n_pages = PHYS_PFN(PAGE_ALIGN(fw->size));
 
 	pages = kmalloc_array(n_pages, sizeof(*pages), GFP_KERNEL);
@@ -566,7 +570,8 @@ int ipu6_buttress_map_fw_image(struct ipu6_bus_device *sys,
 
 	addr = fw->data;
 	for (i = 0; i < n_pages; i++) {
-		struct page *p = vmalloc_to_page(addr);
+		struct page *p = is_vmalloc ?
+			vmalloc_to_page(addr) : virt_to_page(addr);
 
 		if (!p) {
 			ret = -ENOMEM;
diff --git a/drivers/media/pci/intel/ipu6/ipu6.c b/drivers/media/pci/intel/ipu6/ipu6.c
index 7bcd9c5a381a..2cf04251c9e7 100644
--- a/drivers/media/pci/intel/ipu6/ipu6.c
+++ b/drivers/media/pci/intel/ipu6/ipu6.c
@@ -503,45 +503,6 @@ static void ipu6_configure_vc_mechanism(struct ipu6_device *isp)
 	writel(val, isp->base + BUTTRESS_REG_BTRS_CTRL);
 }
 
-static int request_cpd_fw(const struct firmware **firmware_p, const char *name,
-			  struct device *device)
-{
-	const struct firmware *fw;
-	struct firmware *dst;
-	int ret = 0;
-
-	ret = request_firmware(&fw, name, device);
-	if (ret)
-		return ret;
-
-	if (is_vmalloc_addr(fw->data)) {
-		*firmware_p = fw;
-		return 0;
-	}
-
-	dst = kzalloc(sizeof(*dst), GFP_KERNEL);
-	if (!dst) {
-		ret = -ENOMEM;
-		goto release_firmware;
-	}
-
-	dst->size = fw->size;
-	dst->data = vmalloc(fw->size);
-	if (!dst->data) {
-		kfree(dst);
-		ret = -ENOMEM;
-		goto release_firmware;
-	}
-
-	memcpy((void *)dst->data, fw->data, fw->size);
-	*firmware_p = dst;
-
-release_firmware:
-	release_firmware(fw);
-
-	return ret;
-}
-
 static int ipu6_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	struct ipu6_buttress_ctrl *isys_ctrl = NULL, *psys_ctrl = NULL;
@@ -627,7 +588,7 @@ static int ipu6_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (ret)
 		return ret;
 
-	ret = request_cpd_fw(&isp->cpd_fw, isp->cpd_fw_name, dev);
+	ret = request_firmware(&isp->cpd_fw, isp->cpd_fw_name, dev);
 	if (ret) {
 		dev_err_probe(&isp->pdev->dev, ret,
 			      "Requesting signed firmware %s failed\n",
-- 
2.39.2


