Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7486810B5C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 08:18:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235246AbjLMHLb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 02:11:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjLMHLU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 02:11:20 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BEDFAD;
        Tue, 12 Dec 2023 23:11:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702451486; x=1733987486;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mpmTezQGrve2/NrxamBbNPU/OAxLkPtY5ZqRUCbQMQs=;
  b=Hr76UOKKDGvOn/rQ8TTNKyObpEX6WjDNJAXtZqNcwuLEmwDCPMUr2w8i
   lt0Kzgb+ms82g7DTWqBGuqpCJLPNwTzgZNhN9N0WDfrnfz/FmUBYkOy8S
   LADe8fDDV57aQhspUExGwN30h0D8KXW/k2eahtRfuex5pvSd7l6+s1nyB
   dZGfXi+2Pq+qDny7DnIMQmCgEFFgUFEtF1ch+OeSrpWKgirnIAVXdIbwH
   59UmPcGFRYqOcRmtaVA5JSfHtZRGo5CS8UKXc0NvTe4dmEvkF7zP9YJGs
   jDSB1M8XPJLEdo/P7tOYDUN7sd31qHva52Sbn1sKIQeVrGPAaTgSFy0oy
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="481126095"
X-IronPort-AV: E=Sophos;i="6.04,272,1695711600"; 
   d="scan'208";a="481126095"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 23:11:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="767109214"
X-IronPort-AV: E=Sophos;i="6.04,272,1695711600"; 
   d="scan'208";a="767109214"
Received: from pglc00021.png.intel.com ([10.221.207.41])
  by orsmga007.jf.intel.com with ESMTP; 12 Dec 2023 23:11:23 -0800
From:   <deepakx.nagaraju@intel.com>
To:     joyce.ooi@intel.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, Nagaraju DeepakX <deepakx.nagaraju@intel.com>,
        Andy Schevchenko <andriy.schevchenko@linux.intel.com>
Subject: [PATCH 1/5] net: ethernet: altera: remove unneeded assignments
Date:   Wed, 13 Dec 2023 15:11:08 +0800
Message-Id: <20231213071112.18242-2-deepakx.nagaraju@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20231213071112.18242-1-deepakx.nagaraju@intel.com>
References: <20231213071112.18242-1-deepakx.nagaraju@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nagaraju DeepakX <deepakx.nagaraju@intel.com>

Remove unneeded assignments in the code.

Signed-off-by: Nagaraju DeepakX <deepakx.nagaraju@intel.com>
Reviewed-by: Andy Schevchenko <andriy.schevchenko@linux.intel.com>
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

