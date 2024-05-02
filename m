Return-Path: <linux-kernel+bounces-166842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EAB7A8BA0B2
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 20:42:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89F721F228F0
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 18:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5D2A175571;
	Thu,  2 May 2024 18:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jISvnzMT"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03007174EF7;
	Thu,  2 May 2024 18:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714675362; cv=none; b=jHeO+vSzrFOU4H8z95pk6ipRJ5H0x38MxwuUU9Ftoxjxax2AKT4NnZ7gHRAsGuv7tV46w4KkrwMmQMw/R4ePIkXLQnGCVi7gxxp2Gp9KFEF48zLaDCUQFzYfioGEEkz7y4ulP5QAs4NBPUjqvTYf13/MqnMu9YHFxU6FwBa0s28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714675362; c=relaxed/simple;
	bh=+UPGxVtzvoqafoqDKCEmP/fdTBdI91Yv9oTxTOAU6Sw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=uTV7bgqjb9i1ThUeERSnl5vpD4l+Pz7iFcSRkXZDv+Vep8+9w5cZ9tdtWDJjZOnxMSUbVzoHpvLG4xIodLa7oOq0HGHl2TcJDYl4m+/eNHjLSsQEx3Zip86VN0MfRzb192oqM9O/1rlhwKi6ClTx66Q7t+HrPirNpe06B/RfB9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jISvnzMT; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714675360; x=1746211360;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=+UPGxVtzvoqafoqDKCEmP/fdTBdI91Yv9oTxTOAU6Sw=;
  b=jISvnzMT4xzmZVVqArs5fyROS5D78aEM+fp0k47aA32IIBIblixXRAtb
   YSs7vvBT3vvWYdxnBEfsVu4rUBv/xFNomcAraynCMRAZbXGFDC+3j4N0L
   gLDz7Dx1JfOqVAMAP1+jQdN12F+T/j5JE7cVlrs1+0OjOur9EMeRCBzcs
   7qizgtjG+7nK1L+EwGswEvMHD1aiHMeWMTUOO2EEKnAfBNA/kTbbjm8ic
   xqpmHO15Z2PZMS9O0Bs+QoC+ir23V4n/8xbUGd1vYRBRcOGcvF8l+k2SK
   L9rcoYIOutTlUkOxStCi8DLYjToSb4gyv9HkW8xlUbIkzTQr+Ie0Z/AGF
   w==;
X-CSE-ConnectionGUID: 7zt7sKWiRfKePkFezQacJw==
X-CSE-MsgGUID: o/VPEqVUScueCP918Y8yKw==
X-IronPort-AV: E=McAfee;i="6600,9927,11062"; a="10625118"
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="10625118"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2024 11:42:39 -0700
X-CSE-ConnectionGUID: luAIiTWMQxiBPLfGFSxplA==
X-CSE-MsgGUID: RpcBD7o2SI2H3ESmJxkWiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="31680682"
Received: from iweiny-mobl.sc.intel.com (HELO localhost) ([10.144.162.136])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2024 11:42:39 -0700
From: Ira Weiny <ira.weiny@intel.com>
Date: Thu, 02 May 2024 11:42:34 -0700
Subject: [PATCH] cxl/cper: Remove duplicated GUID defines
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240502-cper-fix-dup-guid-v1-1-283cc447c7bf@intel.com>
X-B4-Tracking: v=1; b=H4sIAJneM2YC/x2MQQqAIBAAvxJ7bkElI/tKdAhdbS8mihGEf086D
 sPMC4UyU4F1eCHTzYWv2EGOA9jziIGQXWdQQk1CC4U2UUbPD7qaMFR26Cc7a20WaYSH3qVM3f/
 PbW/tA94HXABjAAAA
To: Dave Jiang <dave.jiang@intel.com>, Tony Luck <tony.luck@intel.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>
X-Mailer: b4 0.13-dev-2d940
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714675358; l=2192;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=+UPGxVtzvoqafoqDKCEmP/fdTBdI91Yv9oTxTOAU6Sw=;
 b=ZfOUibA0BaV1p864RZSecPD9M/hDDUwzMQYyMBzut/PH0axj4QAqExKK8IX/HGQ/LjjM7nxR1
 q8eJ57kSdEXCaE8BYVBbpc9dWyRPxdSn8ycdGB0j/SrpfzS5Wp3Efyz
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=noldbkG+Wp1qXRrrkfY1QJpDf7QsOEthbOT7vm0PqsE=

Commit 54ce1927eb78 ("cxl/cper: Fix errant CPER prints for CXL events")
moved the CXL CPER section defines to include/linux/cper.h from ghes.c

When the latest cxl/cper series was reworked those defines were kept in
ghes.c by accident.  Thus they were duplicated.

Delete the duplicate defines keeping them in the header to be shared
between efi and apei.

Suggested-by: De Francesco, Fabio <fabio.maria.de.francesco@intel.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
No fixes tag because the change is only in linux-next.

Tony can I get a quick ack?  I think this should go through the CXL tree
and picked up by Dave.
---
 drivers/acpi/apei/ghes.c | 26 --------------------------
 1 file changed, 26 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 2247a1535b52..623cc0cb4a65 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -676,32 +676,6 @@ static void ghes_defer_non_standard_event(struct acpi_hest_generic_data *gdata,
 	schedule_work(&entry->work);
 }
 
-/* CXL Event record UUIDs are formated as GUIDs and reported in section type */
-
-/*
- * General Media Event Record
- * CXL rev 3.0 Section 8.2.9.2.1.1; Table 8-43
- */
-#define CPER_SEC_CXL_GEN_MEDIA_GUID					\
-	GUID_INIT(0xfbcd0a77, 0xc260, 0x417f,				\
-		  0x85, 0xa9, 0x08, 0x8b, 0x16, 0x21, 0xeb, 0xa6)
-
-/*
- * DRAM Event Record
- * CXL rev 3.0 section 8.2.9.2.1.2; Table 8-44
- */
-#define CPER_SEC_CXL_DRAM_GUID						\
-	GUID_INIT(0x601dcbb3, 0x9c06, 0x4eab,				\
-		  0xb8, 0xaf, 0x4e, 0x9b, 0xfb, 0x5c, 0x96, 0x24)
-
-/*
- * Memory Module Event Record
- * CXL rev 3.0 section 8.2.9.2.1.3; Table 8-45
- */
-#define CPER_SEC_CXL_MEM_MODULE_GUID					\
-	GUID_INIT(0xfe927475, 0xdd59, 0x4339,				\
-		  0xa5, 0x86, 0x79, 0xba, 0xb1, 0x13, 0xb7, 0x74)
-
 /* Room for 8 entries for each of the 4 event log queues */
 #define CXL_CPER_FIFO_DEPTH 32
 DEFINE_KFIFO(cxl_cper_fifo, struct cxl_cper_work_data, CXL_CPER_FIFO_DEPTH);

---
base-commit: eedb1dd62a7e7471cef18de55d3794cb64adb818
change-id: 20240502-cper-fix-dup-guid-f4c65598190f

Best regards,
-- 
Ira Weiny <ira.weiny@intel.com>


