Return-Path: <linux-kernel+bounces-8504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 264CB81B8C0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 14:52:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CC9C1C2592E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 13:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C8447BF19;
	Thu, 21 Dec 2023 13:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B6b1s5m+"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE297BEF3;
	Thu, 21 Dec 2023 13:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703166050; x=1734702050;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3syJNCMa8hUt3j8WdRfVgmIOlgF4BuJW8l8XY52N8DM=;
  b=B6b1s5m+kvuat59/tHcWE8LxadKJ4Xepu395bpslMWleCTOJj0ChTRVI
   d5BWWFW1Yv67mwQQe6oJieSgZdqfNQ798sWYFYh9xTDE8t0N7YQrCW8QC
   xegqn5fOGWiRxQunHUd9nI6gDTUNypDG8NOvwoc9UieqUyIqpHgOPDu5D
   lPaZpRFQNeabBMGRPyHjznb6//xDy3NmpucTAdv8b1vU9Wx6GSjVBhgbr
   iE/PrgPdyXF0GswODjp77qF+O5gaaG9kGOD0dpNusxH1hp5WPcCtOUhxZ
   DGJxJNfhmz9RGHLTGFnoNl2NlWJ0+7TyaQtbcsVFdadqS2aNxUGD5QUHj
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="9446058"
X-IronPort-AV: E=Sophos;i="6.04,293,1695711600"; 
   d="scan'208";a="9446058"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2023 05:40:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="1108105164"
X-IronPort-AV: E=Sophos;i="6.04,293,1695711600"; 
   d="scan'208";a="1108105164"
Received: from pglc00021.png.intel.com ([10.221.207.41])
  by fmsmga005.fm.intel.com with ESMTP; 21 Dec 2023 05:40:47 -0800
From: <deepakx.nagaraju@intel.com>
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: jdavem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	mun.yew.tham@intel.com,
	Nagaraju DeepakX <deepakx.nagaraju@intel.com>,
	Andy Schevchenko <andriy.schevchenko@linux.intel.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH v2 1/4] net: ethernet: altera: remove unneeded assignments
Date: Thu, 21 Dec 2023 21:40:38 +0800
Message-Id: <20231221134041.27104-2-deepakx.nagaraju@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20231221134041.27104-1-deepakx.nagaraju@intel.com>
References: <20231213071112.18242-6-deepakx.nagaraju@intel.com>
 <20231221134041.27104-1-deepakx.nagaraju@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Nagaraju DeepakX <deepakx.nagaraju@intel.com>

Remove unneeded assignments in the code.

Signed-off-by: Nagaraju DeepakX <deepakx.nagaraju@intel.com>
Reviewed-by: Andy Schevchenko <andriy.schevchenko@linux.intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 drivers/net/ethernet/altera/altera_sgdma.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/altera/altera_sgdma.c b/drivers/net/ethernet/altera/altera_sgdma.c
index 7f247ccbe6ba..5517f89f1ef9 100644
--- a/drivers/net/ethernet/altera/altera_sgdma.c
+++ b/drivers/net/ethernet/altera/altera_sgdma.c
@@ -63,8 +63,6 @@ int sgdma_initialize(struct altera_tse_private *priv)
 	INIT_LIST_HEAD(&priv->txlisthd);
 	INIT_LIST_HEAD(&priv->rxlisthd);

-	priv->rxdescphys = (dma_addr_t) 0;
-	priv->txdescphys = (dma_addr_t) 0;

 	priv->rxdescphys = dma_map_single(priv->device,
 					  (void __force *)priv->rx_dma_desc,
@@ -237,8 +235,8 @@ u32 sgdma_rx_status(struct altera_tse_private *priv)

 	desc = &base[0];
 	if (sts & SGDMA_STSREG_EOP) {
-		unsigned int pktlength = 0;
-		unsigned int pktstatus = 0;
+		unsigned int pktlength;
+		unsigned int pktstatus;
 		dma_sync_single_for_cpu(priv->device,
 					priv->rxdescphys,
 					SGDMA_DESC_LEN,
--
2.26.2


