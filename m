Return-Path: <linux-kernel+bounces-155866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1487F8AF832
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 22:47:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E9C4B262EF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 20:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E98A143C74;
	Tue, 23 Apr 2024 20:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nzjwIqsj"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E04142E96;
	Tue, 23 Apr 2024 20:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713905187; cv=none; b=SwovBvqfZeZmddRHFepV8XSi6rB6hRqxKrIxXNeatAiQrywJCVAZSHN+/W6GQnpMEV7oHMbEk0H/r+HFgpUDY8B13YvLUBA8q9FQyK1vUa+Zev0ZqE0RKrNBEQxouYYu3iOhwYMVeovJxnCJr+8UmUSiRXizonfUGKheqfhb5To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713905187; c=relaxed/simple;
	bh=WKb7qELQbbK6hy0ANQKL1fGApsnx2UeaCuqul+3j10g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l52pCIsz8ogkIAwWXpfFJfmEtofutMQPzXPm+N7yeQJd2b06WDFdF0tmvSvWbVKCzjm+ct2AesahEek1hAVYLXwzy0wdPjaLNo2wsqIrTa3c5a51viKM1JNbhxJl361TLeLDYLQWaycq7/RBGtlbmT5loF8mNv4PNn2HehTa74Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nzjwIqsj; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713905186; x=1745441186;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WKb7qELQbbK6hy0ANQKL1fGApsnx2UeaCuqul+3j10g=;
  b=nzjwIqsj4SimTgDtKEcOdUh30dfqebIDh2cQXvl8TjKmPfCqm6c9k80N
   Vpb8Fhnns36QgC++mZJYp4VS91IFoJyx1g9Ow7RknBigcynbgNMfzoNN+
   g/DCEh6t8zR5DtOssZW7SLdnW/mZfdI5sET5ZPdawijGZ2PXPCDt6KEXA
   YrgPHDApY/tA8FqpCCpw4kmPPe1cBySo/QVFoVHynlCxpXqov5FGy+2lU
   HE5Xbu76OZ/ltBF1Ub2GW3dEWs9gGTikMpIkHWMxagM7N9JtRmZDqM+Jk
   ly8vn3xTShe9cc1gy6nQcKuaBGmQ+ExC1bvpfHHfp5GIKNeKzEyN8c4X5
   Q==;
X-CSE-ConnectionGUID: bdv9TkK0TPOFSGleAnN1nA==
X-CSE-MsgGUID: kbSZLCEITDe7Uo7nXIr03Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="34912322"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="34912322"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 13:46:24 -0700
X-CSE-ConnectionGUID: VeA3AUQVR+yRTkiqdO/XNQ==
X-CSE-MsgGUID: b0zOSvnYRnmayDA3NSeyaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="24533085"
Received: from spandruv-desk.jf.intel.com ([10.54.75.14])
  by fmviesa010.fm.intel.com with ESMTP; 23 Apr 2024 13:46:23 -0700
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 04/10] platform/x86/intel/tpmi: Add additional TPMI header fields
Date: Tue, 23 Apr 2024 13:46:13 -0700
Message-Id: <20240423204619.3946901-5-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240423204619.3946901-1-srinivas.pandruvada@linux.intel.com>
References: <20240423204619.3946901-1-srinivas.pandruvada@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

TPMI information header added additional fields in version 2. Some of the
reserved fields in version 1 are used to define new fields.

Parse new fields and export as part of platform data. These fields include:
- PCI segment ID
- Partition ID of the package: If a package is represented by more than
  one PCI device, then partition ID along with cdie_mask, describes the
  scope. For example to update get/set properties for a compute die, one
  of the PCI MMIO region is selected from the partition ID.
- cdie_mask: Mask of all compute dies in this partition.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Zhang Rui <rui.zhang@intel.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/platform/x86/intel/tpmi.c | 15 ++++++++++++++-
 include/linux/intel_tpmi.h        |  6 ++++++
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/intel/tpmi.c b/drivers/platform/x86/intel/tpmi.c
index a5bcb77bcb35..6c0cbccd80bb 100644
--- a/drivers/platform/x86/intel/tpmi.c
+++ b/drivers/platform/x86/intel/tpmi.c
@@ -128,6 +128,9 @@ struct intel_tpmi_info {
  * @dev:	PCI device number
  * @bus:	PCI bus number
  * @pkg:	CPU Package id
+ * @segment:	PCI segment id
+ * @partition:	Package Partition id
+ * @cdie_mask:	Bitmap of compute dies in the current partition
  * @reserved:	Reserved for future use
  * @lock:	When set to 1 the register is locked and becomes read-only
  *		until next reset. Not for use by the OS driver.
@@ -139,7 +142,10 @@ struct tpmi_info_header {
 	u64 dev:5;
 	u64 bus:8;
 	u64 pkg:8;
-	u64 reserved:39;
+	u64 segment:8;
+	u64 partition:2;
+	u64 cdie_mask:16;
+	u64 reserved:13;
 	u64 lock:1;
 } __packed;
 
@@ -667,6 +673,7 @@ static int tpmi_create_devices(struct intel_tpmi_info *tpmi_info)
 
 #define TPMI_INFO_BUS_INFO_OFFSET	0x08
 #define TPMI_INFO_MAJOR_VERSION		0x00
+#define TPMI_INFO_MINOR_VERSION		0x02
 
 static int tpmi_process_info(struct intel_tpmi_info *tpmi_info,
 			     struct intel_tpmi_pm_feature *pfs)
@@ -693,6 +700,12 @@ static int tpmi_process_info(struct intel_tpmi_info *tpmi_info,
 	tpmi_info->plat_info.device_number = header.dev;
 	tpmi_info->plat_info.function_number = header.fn;
 
+	if (TPMI_MINOR_VERSION(feature_header) >= TPMI_INFO_MINOR_VERSION) {
+		tpmi_info->plat_info.cdie_mask = header.cdie_mask;
+		tpmi_info->plat_info.partition = header.partition;
+		tpmi_info->plat_info.segment = header.segment;
+	}
+
 error_info_header:
 	iounmap(info_mem);
 
diff --git a/include/linux/intel_tpmi.h b/include/linux/intel_tpmi.h
index 685a41dddf82..1e880cb0f454 100644
--- a/include/linux/intel_tpmi.h
+++ b/include/linux/intel_tpmi.h
@@ -27,7 +27,10 @@ enum intel_tpmi_id {
 
 /**
  * struct intel_tpmi_plat_info - Platform information for a TPMI device instance
+ * @cdie_mask:       Mask of all compute dies in the partition
  * @package_id:      CPU Package id
+ * @partition:       Package partition id when multiple VSEC PCI devices per package
+ * @segment:         PCI segment ID
  * @bus_number:      PCI bus number
  * @device_number:   PCI device number
  * @function_number: PCI function number
@@ -36,7 +39,10 @@ enum intel_tpmi_id {
  * struct is used to return data via tpmi_get_platform_data().
  */
 struct intel_tpmi_plat_info {
+	u16 cdie_mask;
 	u8 package_id;
+	u8 partition;
+	u8 segment;
 	u8 bus_number;
 	u8 device_number;
 	u8 function_number;
-- 
2.40.1


