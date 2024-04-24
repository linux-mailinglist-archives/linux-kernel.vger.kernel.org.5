Return-Path: <linux-kernel+bounces-157696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FD6A8B14B0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 22:38:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABCE51F212A0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 20:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C8D916D9BE;
	Wed, 24 Apr 2024 20:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g+a0RV9m"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7A4156F5A;
	Wed, 24 Apr 2024 20:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713990988; cv=none; b=g8m1mkcOkZ2Zq19Hx2oQrCwPV6jqTghKKPY0qco2OLuVmGFzDLG4EHsyw0MjefGj4beRTs9xf+LbK7r3IIcqWLmGb2CzSmokaZYkK1bG/AD7qZ/y8RLrxNlsHxBtXcVT2HXPfvhPWr7W6gtfOzg8Dfjv/DtmckZRKm+jFrl4vlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713990988; c=relaxed/simple;
	bh=SR/txrItjji3b1VBUabdl8RvbDYOnvGXLR2JMpM/4iY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=krMhydMbudMeDLToEpSpjHXD6QyCFm0oWTG0L/WA3QW1sW+tKWahSRICY4T+qE3EJecFbHIyN/kC0ek/37rY9/7W2sCeFADJ/ynPQt5uwjs/JF618d1VIDSFGwmXLe9CGRdD8PswMEGngyOaFRNiMNtpFrOxqlf9yf8uhQTx9rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g+a0RV9m; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713990986; x=1745526986;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SR/txrItjji3b1VBUabdl8RvbDYOnvGXLR2JMpM/4iY=;
  b=g+a0RV9mehyksfa7CmJfJU7aMdEGlcyk+quN5YxcW5HVEP1XYKEnfsKc
   x9sRYnfuFln16kOYTJMigjbf+NeH6JJU6Jg6OWTpq7Ga3kgmdwd4hYv9N
   CzvydxhoMBCAcLdjum8dazYxzPQjduiTwnrqf2HXf44/uDZhv5L0AFOp5
   uDWaTvrIzzEcNMZEVsIJDSHb+ZOq89LkVZyaWQ1QMu2I+hOd9pcKSDUZI
   /LkCLEINgWJNojBHN8jQS/+rbPz6LPqv6UTNZd7w8BZeXVi2tEAIeEYK5
   gnmSIGmq5so38BR++xuR5gjdYjltD9kV9pVJaKls95rBP2PcTrDVQv0uC
   w==;
X-CSE-ConnectionGUID: GaVh15wmQJOjOUQR/fcdWg==
X-CSE-MsgGUID: YHCawr9RR8KbHn6f8r2SmQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11054"; a="9511979"
X-IronPort-AV: E=Sophos;i="6.07,227,1708416000"; 
   d="scan'208";a="9511979"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 13:36:21 -0700
X-CSE-ConnectionGUID: pn5kNLIEQjGCY7TKZz+bUQ==
X-CSE-MsgGUID: 8133M7oxTLetwLo+T87sig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,227,1708416000"; 
   d="scan'208";a="29314999"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa003.fm.intel.com with ESMTP; 24 Apr 2024 13:36:20 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	anthony.l.nguyen@intel.com,
	hawk@kernel.org,
	linux-mm@kvack.org,
	przemyslaw.kitszel@intel.com,
	alexanderduyck@fb.com,
	ilias.apalodimas@linaro.org,
	linux-kernel@vger.kernel.org,
	linyunsheng@huawei.com,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	cl@linux.com,
	akpm@linux-foundation.org,
	vbabka@suse.cz
Subject: [PATCH net-next v11 08/10] iavf: pack iavf_ring more efficiently
Date: Wed, 24 Apr 2024 13:35:55 -0700
Message-ID: <20240424203559.3420468-9-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240424203559.3420468-1-anthony.l.nguyen@intel.com>
References: <20240424203559.3420468-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexander Lobakin <aleksander.lobakin@intel.com>

Before replacing the Rx buffer management with libie, clean up
&iavf_ring a bit.
There are several fields not used anywhere in the code -- simply remove
them. Move ::tail up to remove a hole. Replace ::arm_wb boolean with
1-bit flag in ::flags to free 1 more byte. Finally, move ::prev_pkt_ctr
out of &iavf_tx_queue_stats -- it doesn't belong there (used for Tx
stall detection). Place it next to the stats on the ring itself to fill
the 4-byte slot.
The result: no holes and all the hot fields fit into the first 64-byte
cacheline.

Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf_txrx.c | 12 +++++------
 drivers/net/ethernet/intel/iavf/iavf_txrx.h | 22 +++------------------
 2 files changed, 9 insertions(+), 25 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_txrx.c b/drivers/net/ethernet/intel/iavf/iavf_txrx.c
index c7602c173420..2ec68b51bebe 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_txrx.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_txrx.c
@@ -185,7 +185,7 @@ void iavf_detect_recover_hung(struct iavf_vsi *vsi)
 			 * pending work.
 			 */
 			packets = tx_ring->stats.packets & INT_MAX;
-			if (tx_ring->tx_stats.prev_pkt_ctr == packets) {
+			if (tx_ring->prev_pkt_ctr == packets) {
 				iavf_force_wb(vsi, tx_ring->q_vector);
 				continue;
 			}
@@ -194,7 +194,7 @@ void iavf_detect_recover_hung(struct iavf_vsi *vsi)
 			 * to iavf_get_tx_pending()
 			 */
 			smp_rmb();
-			tx_ring->tx_stats.prev_pkt_ctr =
+			tx_ring->prev_pkt_ctr =
 			  iavf_get_tx_pending(tx_ring, true) ? packets : -1;
 		}
 	}
@@ -320,7 +320,7 @@ static bool iavf_clean_tx_irq(struct iavf_vsi *vsi,
 		    ((j / WB_STRIDE) == 0) && (j > 0) &&
 		    !test_bit(__IAVF_VSI_DOWN, vsi->state) &&
 		    (IAVF_DESC_UNUSED(tx_ring) != tx_ring->count))
-			tx_ring->arm_wb = true;
+			tx_ring->flags |= IAVF_TXR_FLAGS_ARM_WB;
 	}
 
 	/* notify netdev of completed buffers */
@@ -675,7 +675,7 @@ int iavf_setup_tx_descriptors(struct iavf_ring *tx_ring)
 
 	tx_ring->next_to_use = 0;
 	tx_ring->next_to_clean = 0;
-	tx_ring->tx_stats.prev_pkt_ctr = -1;
+	tx_ring->prev_pkt_ctr = -1;
 	return 0;
 
 err:
@@ -1491,8 +1491,8 @@ int iavf_napi_poll(struct napi_struct *napi, int budget)
 			clean_complete = false;
 			continue;
 		}
-		arm_wb |= ring->arm_wb;
-		ring->arm_wb = false;
+		arm_wb |= !!(ring->flags & IAVF_TXR_FLAGS_ARM_WB);
+		ring->flags &= ~IAVF_TXR_FLAGS_ARM_WB;
 	}
 
 	/* Handle case where we are called by netpoll with a budget of 0 */
diff --git a/drivers/net/ethernet/intel/iavf/iavf_txrx.h b/drivers/net/ethernet/intel/iavf/iavf_txrx.h
index e01777531635..ed559fa6f214 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_txrx.h
+++ b/drivers/net/ethernet/intel/iavf/iavf_txrx.h
@@ -227,7 +227,6 @@ struct iavf_tx_queue_stats {
 	u64 tx_done_old;
 	u64 tx_linearize;
 	u64 tx_force_wb;
-	int prev_pkt_ctr;
 	u64 tx_lost_interrupt;
 };
 
@@ -237,12 +236,6 @@ struct iavf_rx_queue_stats {
 	u64 alloc_buff_failed;
 };
 
-enum iavf_ring_state_t {
-	__IAVF_TX_FDIR_INIT_DONE,
-	__IAVF_TX_XPS_INIT_DONE,
-	__IAVF_RING_STATE_NBITS /* must be last */
-};
-
 /* some useful defines for virtchannel interface, which
  * is the only remaining user of header split
  */
@@ -264,10 +257,8 @@ struct iavf_ring {
 		struct iavf_tx_buffer *tx_bi;
 		struct iavf_rx_buffer *rx_bi;
 	};
-	DECLARE_BITMAP(state, __IAVF_RING_STATE_NBITS);
-	u16 queue_index;		/* Queue number of ring */
-	u8 dcb_tc;			/* Traffic class of ring */
 	u8 __iomem *tail;
+	u16 queue_index;		/* Queue number of ring */
 
 	/* high bit set means dynamic, use accessors routines to read/write.
 	 * hardware only supports 2us resolution for the ITR registers.
@@ -277,22 +268,14 @@ struct iavf_ring {
 	u16 itr_setting;
 
 	u16 count;			/* Number of descriptors */
-	u16 reg_idx;			/* HW register index of the ring */
 
 	/* used in interrupt processing */
 	u16 next_to_use;
 	u16 next_to_clean;
 
-	u8 atr_sample_rate;
-	u8 atr_count;
-
-	bool ring_active;		/* is ring online or not */
-	bool arm_wb;		/* do something to arm write back */
-	u8 packet_stride;
-
 	u16 flags;
 #define IAVF_TXR_FLAGS_WB_ON_ITR		BIT(0)
-/* BIT(1) is free, was IAVF_RXR_FLAGS_BUILD_SKB_ENABLED */
+#define IAVF_TXR_FLAGS_ARM_WB			BIT(1)
 /* BIT(2) is free */
 #define IAVF_TXRX_FLAGS_VLAN_TAG_LOC_L2TAG1	BIT(3)
 #define IAVF_TXR_FLAGS_VLAN_TAG_LOC_L2TAG2	BIT(4)
@@ -306,6 +289,7 @@ struct iavf_ring {
 		struct iavf_rx_queue_stats rx_stats;
 	};
 
+	int prev_pkt_ctr;		/* For Tx stall detection */
 	unsigned int size;		/* length of descriptor ring in bytes */
 	dma_addr_t dma;			/* physical address of ring */
 
-- 
2.41.0


