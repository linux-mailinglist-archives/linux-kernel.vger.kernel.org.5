Return-Path: <linux-kernel+bounces-166583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 598498B9CB2
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 16:47:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B0001C21ABC
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 14:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72E1A15445F;
	Thu,  2 May 2024 14:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A0YExunH"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D599915380F;
	Thu,  2 May 2024 14:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714661199; cv=none; b=a5GMkyezCWwCLi7rdRWOFrFAgSV6ddn7nNrSXq4Q0Q+jFrAsCfLw83RMVCMqYh3Q2JqLkGgtwhXUfLWrXqT179GZg2e2bQQC185iO9rTrxMDEd89S5crP0VfyE/uunmK9oTNScF1SFgFo6Hsd1gqNxS1frmQuxtP0fXGoSJlCC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714661199; c=relaxed/simple;
	bh=MNevgiHkmuCG//FLCxCfm2v7RKLaRbqWb2DHuURYI4c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K2K2LL1vetQtbl0oRZqOgsVIEriYhYCBaUND0y2jHYykMRrbBAbWtnkGqAU97W75BChLkm2uSxaU3EYQKZ9J2kn/AlEkgOm7GYRG+NRjJgivO0XnJ4aXPONWR4Y3J6EImBQELQeymh/ApKJoqhf7iY+EBvZSEPI/OqhgQRUeidM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A0YExunH; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714661197; x=1746197197;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MNevgiHkmuCG//FLCxCfm2v7RKLaRbqWb2DHuURYI4c=;
  b=A0YExunHNrfAX9vW+fEn9kWNL/UHKSxBMz3Wk6uIrTY+ELm7cBszWYck
   2j+lDfBsjN2Zkwb+4S74R1Ltu/rK6+RMZOlj2UwqfWo9zaUQBNOqUd1d/
   wXuKeuDS57fmI7XEs7hiq+aqbO/6YnGX0xKrU+CiEOx2PigKvLEOKC90f
   fSlLRSsbiPxIJWEVxMwhhBASxqDmin3D0T+nmh3Myhki3HOrgDhNkeVNF
   l1rT/V2Sv5Ll6ZyLMHHmvMSbTmA6QMUmd2XyrlVoLiiEX9P/Y3+FuWAJ/
   ZyMwBUFij3VyeYdmc3RAgfFtojp/rs75CQyff+rGPzgqgMKxuAEMWTyso
   A==;
X-CSE-ConnectionGUID: KdfRmQtuRxiFDvQIeZBLbA==
X-CSE-MsgGUID: 3oUMpcGERiWhTzFEldt5uw==
X-IronPort-AV: E=McAfee;i="6600,9927,11062"; a="10306073"
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="10306073"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2024 07:46:34 -0700
X-CSE-ConnectionGUID: LOXpM/xoTNS3EhxQvU/jNA==
X-CSE-MsgGUID: 5k9v+jPRTbOPJDH7ZomXuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="31632825"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa003.fm.intel.com with ESMTP; 02 May 2024 07:46:32 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id E089B21A; Thu,  2 May 2024 17:46:30 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Parker Newman <pnewman@connecttech.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH v1 03/13] serial: 8250_exar: Kill CTI_PCI_DEVICE()
Date: Thu,  2 May 2024 17:43:57 +0300
Message-ID: <20240502144626.2716994-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20240502144626.2716994-1-andriy.shevchenko@linux.intel.com>
References: <20240502144626.2716994-1-andriy.shevchenko@linux.intel.com>
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


