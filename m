Return-Path: <linux-kernel+bounces-167958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 441668BB1A1
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 19:20:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74F7A1C2182F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 17:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F07715820C;
	Fri,  3 May 2024 17:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LdESeW/n"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA3C1581EE;
	Fri,  3 May 2024 17:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714756783; cv=none; b=fEi3sNmLT6jh77R5IO93zRp+VB6T4as6kfaHh6aDZMiovF8oAXVhi/7QHMFw6EYd0MaL6YlfhBV0aYx5/wMpQmJoyJAHPRcyIwJ+b5uc+wI8I5wPwdN17vqOylEz5HbtjoTGA7Nyg3l1zonx+eCcxQ/wrij1OkdxVubCmLCgPgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714756783; c=relaxed/simple;
	bh=MNevgiHkmuCG//FLCxCfm2v7RKLaRbqWb2DHuURYI4c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f9oAqfTs4UQM1ZpsLtyc/Z6JppwrQ5t2ZQHOILT7ECeRbxjuOa790z/8NPpzjVaGDg1SDHxVbQxfxQd4xtUsiGnrtWnr0GHnHrhsEXjBrQL6sJQE7wM3mbR/ZfgIwDbjqhkrVvEtyMuySkcSI6KRq5G3r59zzym+BvDmYyKri0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LdESeW/n; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714756782; x=1746292782;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MNevgiHkmuCG//FLCxCfm2v7RKLaRbqWb2DHuURYI4c=;
  b=LdESeW/nv3E5rF/lEJK3d4IcayMb/gwdRZ4h0jZe8XTtdZpfwK/rD5/n
   4tt+TM8xGRcn+tpS7FjCU/JH9sj2AqYVkGArFxaGgYgnaU7sl5SW/ph3b
   dxsYY6kirX7eUj7p/BKF7HN9vN6SGv8xkqe+v2QIaxCc35VyoiHIInuYA
   c9UtoKCx0K1/KW6wdcEMlKL6ajezxHsLgpVRM6vWhISShKZJ3VdoRAqBC
   0nlkkreAyN6H6sCCz6qYAPYPyH4odeBP35WZF7kcamPZpX+s6rqEJdDnr
   zNTcd+spPjlkejYWVsPRlvSgxBWMlXb+YFRpwd/D4rDjkv/UL1aElGaNS
   A==;
X-CSE-ConnectionGUID: PHivvf0+S5a6YKljexG3bw==
X-CSE-MsgGUID: w94ld1jvQYK4GdEgWqiuXg==
X-IronPort-AV: E=McAfee;i="6600,9927,11063"; a="35962093"
X-IronPort-AV: E=Sophos;i="6.07,251,1708416000"; 
   d="scan'208";a="35962093"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2024 10:19:41 -0700
X-CSE-ConnectionGUID: OqMjfBsQRW6s3Wvj07tMpA==
X-CSE-MsgGUID: kZDOZ3wlSXG+rRODBPqrrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,251,1708416000"; 
   d="scan'208";a="28098200"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa008.jf.intel.com with ESMTP; 03 May 2024 10:19:39 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 4408540F; Fri,  3 May 2024 20:19:38 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Parker Newman <pnewman@connecttech.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH v2 03/13] serial: 8250_exar: Kill CTI_PCI_DEVICE()
Date: Fri,  3 May 2024 20:15:55 +0300
Message-ID: <20240503171917.2921250-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20240503171917.2921250-1-andriy.shevchenko@linux.intel.com>
References: <20240503171917.2921250-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The CTI_PCI_DEVICE() duplicates EXAR_DEVICE(). Kill the former.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/8250/8250_exar.c | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
index 150c4abd92fc..ab0abc14ecf8 100644
--- a/drivers/tty/serial/8250/8250_exar.c
+++ b/drivers/tty/serial/8250/8250_exar.c
@@ -1737,7 +1737,6 @@ static const struct exar8250_board pbn_exar_XR17V8358 = {
 	.exit		= pci_xr17v35x_exit,
 };
 
-// For Connect Tech cards with Exar vendor/device PCI IDs
 #define CTI_EXAR_DEVICE(devid, bd) {                    \
 	PCI_DEVICE_SUB(                                 \
 		PCI_VENDOR_ID_EXAR,                     \
@@ -1747,16 +1746,6 @@ static const struct exar8250_board pbn_exar_XR17V8358 = {
 		(kernel_ulong_t)&bd                     \
 	}
 
-// For Connect Tech cards with Connect Tech vendor/device PCI IDs (FPGA based)
-#define CTI_PCI_DEVICE(devid, bd) {                     \
-	PCI_DEVICE_SUB(                                 \
-		PCI_VENDOR_ID_CONNECT_TECH,             \
-		PCI_DEVICE_ID_CONNECT_TECH_PCI_##devid, \
-		PCI_ANY_ID,                             \
-		PCI_ANY_ID), 0, 0,                      \
-		(kernel_ulong_t)&bd                     \
-	}
-
 #define EXAR_DEVICE(vend, devid, bd) { PCI_DEVICE_DATA(vend, devid, &bd) }
 
 #define IBM_DEVICE(devid, sdevid, bd) {			\
@@ -1786,6 +1775,7 @@ static const struct pci_device_id exar_pci_tbl[] = {
 	EXAR_DEVICE(ACCESSIO, COM_4SM, pbn_exar_XR17C15x),
 	EXAR_DEVICE(ACCESSIO, COM_8SM, pbn_exar_XR17C15x),
 
+	/* Connect Tech cards with Exar vendor/device PCI IDs */
 	CTI_EXAR_DEVICE(XR17C152,       pbn_cti_xr17c15x),
 	CTI_EXAR_DEVICE(XR17C154,       pbn_cti_xr17c15x),
 	CTI_EXAR_DEVICE(XR17C158,       pbn_cti_xr17c15x),
@@ -1798,9 +1788,10 @@ static const struct pci_device_id exar_pci_tbl[] = {
 	CTI_EXAR_DEVICE(XR17V354,       pbn_cti_xr17v35x),
 	CTI_EXAR_DEVICE(XR17V358,       pbn_cti_xr17v35x),
 
-	CTI_PCI_DEVICE(XR79X_12_XIG00X, pbn_cti_fpga),
-	CTI_PCI_DEVICE(XR79X_12_XIG01X, pbn_cti_fpga),
-	CTI_PCI_DEVICE(XR79X_16,        pbn_cti_fpga),
+	/* Connect Tech cards with Connect Tech vendor/device PCI IDs (FPGA based) */
+	EXAR_DEVICE(CONNECT_TECH, PCI_XR79X_12_XIG00X, pbn_cti_fpga),
+	EXAR_DEVICE(CONNECT_TECH, PCI_XR79X_12_XIG01X, pbn_cti_fpga),
+	EXAR_DEVICE(CONNECT_TECH, PCI_XR79X_16,        pbn_cti_fpga),
 
 	IBM_DEVICE(XR17C152, SATURN_SERIAL_ONE_PORT, pbn_exar_ibm_saturn),
 
-- 
2.43.0.rc1.1336.g36b5255a03ac


