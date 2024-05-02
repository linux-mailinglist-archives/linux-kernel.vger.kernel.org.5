Return-Path: <linux-kernel+bounces-166463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADD8D8B9B00
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 14:39:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A1332868F6
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 12:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A8AF81AC7;
	Thu,  2 May 2024 12:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OHY0BSt3"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6185662171;
	Thu,  2 May 2024 12:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714653541; cv=none; b=mTYZ61nTxi5PCEElNaJY4/U11wbAGf6tnGPSOncqZn/37Uf7HMBCoCz3h8wJ6aq87qb/bohvoZS2zZB2zpzn+bKoIqhP6BqnFo1siQCdOjf1JixUuB249aqj2rmcwzMmOwDGu+97UhA7KiEaU98P+3ynRPQRkccdFe/Uc3DsOHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714653541; c=relaxed/simple;
	bh=oDcRiPW3R8/rc8oPvXX15ddS2eU2agTCmVL3kfXdKHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SHY46GcrPE73hacA/Z26f7THyrrogWut7RS5YeTsep6Zspud9gi3yOoEye6EBECF2uLzmGzU36s5KBpb8Iq3UxNHYDV9SC9sc1OcJaVzDJHpkFIolvzdNsUln9qbF3psAFreQg/5Al6Z95bmsNN/KdO1hEWWPc/MO4nf8T6bdBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OHY0BSt3; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714653538; x=1746189538;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=oDcRiPW3R8/rc8oPvXX15ddS2eU2agTCmVL3kfXdKHQ=;
  b=OHY0BSt3rvkRg/7yXsq9PU4OcQYk+uYWU7lEQ03Rn/OV4//cOO6gSrK2
   xgG1iSUIZrV2doWq5U+F5RZYs1LPQBzlY/CemjT5QErTAH0uPFbKRqnbn
   8XVowZ6SedJiSAV7trh21QlUVFSIT1P/eRpacUu74gEzqUymEv9mwSFcG
   Gx8rDWOM6mTqH5saYUlUpMjBSw7pKNk2FHUfjoFrIt5tVQysAZYl8aTKd
   /rOrwrLr6XWeFOLTonISvM0/ztQ7hZpDw1xokrJQrEKksLtyaDIFJuHkJ
   arHf1Dmr+6VC0wmKLoz8QRNuN6FDE967Z3lh0yWdZ/jG09/O9jDFUOytS
   g==;
X-CSE-ConnectionGUID: Usvmq1+XTOiV+oUXlv8jsQ==
X-CSE-MsgGUID: 2eWlZNfTQNCyjJi8KOj8jA==
X-IronPort-AV: E=McAfee;i="6600,9927,11061"; a="21831222"
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="21831222"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2024 05:38:57 -0700
X-CSE-ConnectionGUID: GVfqGcjjS42MzhEwiWbN9Q==
X-CSE-MsgGUID: YM54t4dfTLat4O0HTk9EEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="31908012"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa004.jf.intel.com with ESMTP; 02 May 2024 05:38:56 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 18FE221A; Thu,  2 May 2024 15:38:55 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next v1 1/1] can: sja1000: plx_pci: Reuse predefined CTI subvendor ID
Date: Thu,  2 May 2024 15:38:52 +0300
Message-ID: <20240502123852.2631577-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is predefined PCI_SUBVENDOR_ID_CONNECT_TECH, use it in the driver.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/net/can/sja1000/plx_pci.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/can/sja1000/plx_pci.c b/drivers/net/can/sja1000/plx_pci.c
index 5de1ebb0c6f0..67e5316c6372 100644
--- a/drivers/net/can/sja1000/plx_pci.c
+++ b/drivers/net/can/sja1000/plx_pci.c
@@ -122,7 +122,6 @@ struct plx_pci_card {
 #define TEWS_PCI_VENDOR_ID		0x1498
 #define TEWS_PCI_DEVICE_ID_TMPC810	0x032A
 
-#define CTI_PCI_VENDOR_ID		0x12c4
 #define CTI_PCI_DEVICE_ID_CRG001	0x0900
 
 #define MOXA_PCI_VENDOR_ID		0x1393
@@ -358,7 +357,7 @@ static const struct pci_device_id plx_pci_tbl[] = {
 	{
 		/* Connect Tech Inc. CANpro/104-Plus Opto (CRG001) card */
 		PCI_VENDOR_ID_PLX, PCI_DEVICE_ID_PLX_9030,
-		CTI_PCI_VENDOR_ID, CTI_PCI_DEVICE_ID_CRG001,
+		PCI_SUBVENDOR_ID_CONNECT_TECH, CTI_PCI_DEVICE_ID_CRG001,
 		0, 0,
 		(kernel_ulong_t)&plx_pci_card_info_cti
 	},
-- 
2.43.0.rc1.1336.g36b5255a03ac


