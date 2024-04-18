Return-Path: <linux-kernel+bounces-149985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C795C8A98C8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 13:39:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3376B22EAF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 11:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14AF916193C;
	Thu, 18 Apr 2024 11:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kZqa1dtA"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30B9161911;
	Thu, 18 Apr 2024 11:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713440231; cv=none; b=S22luvBm0z78HbWLIYG6MC6+UTsZ2zuhrdZJXe4LYzdaFtEIcNyS2gzSZ+Nsf1n5cEQdXiwTQ4cTnXWUluY42F6FtZu1scT+vsucG98JRt8FE4MNweWdNkVgwf7EPFTeveWPd7Rph2QsU7MKZyZJi1rXzxwRWHrbhmEugMU3NqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713440231; c=relaxed/simple;
	bh=kSrcRx/NAAWdhuB//E1o7Q3AqnsepHC5nNY58kWnwK8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sr3cVZWAQY+Zpa8DIIhJq0dgDECTUo1xhXkxqWKmdJRVZ25lVrSzIHkDZkYZxFyy3MV8Li63BWNyxU1Qq06YQiZ92fMLxJ0n25IW72o0ICl2F7cwuDqK8vVuPeGHQRe93Wu3EuX8YzQRbf4bPk6ngFjp0vGL/pWLYP4EP599arg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kZqa1dtA; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713440229; x=1744976229;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kSrcRx/NAAWdhuB//E1o7Q3AqnsepHC5nNY58kWnwK8=;
  b=kZqa1dtAkACmewr2uIm/5UKN3xai+VMdhrLavwWDHgxLhJrRQyhLSrRy
   Nyh+N7TBSyTpSm2pZPTieJUhhIrG6KmwlHUHpA8NqeFRv+dFcG+viFBLr
   R/7W4TEa1zlsev5cnmwgBccJeQ7uXk1EM8G9Rtc2zam0EgAZm/b4snclb
   gZgE3ssy40eZiRPWKmYH6GQAs7h8AmViZJHK9uCDq1sGhgW2MFVTBxDJl
   Frq3Iaf+NQbnH338BhJGrx64mnmTKQQqyStutfbMl6OKMHiS8yCfqNJ6U
   ej30dkotZwysI+t7IXxViXs1hZ0FbwlwO5k7IG/U173m0zxCGhQa0bBqz
   A==;
X-CSE-ConnectionGUID: vngShiikRNWYwRlaNuSsGA==
X-CSE-MsgGUID: yNDaUi+wQYKo/SagnrO/UQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="19587818"
X-IronPort-AV: E=Sophos;i="6.07,212,1708416000"; 
   d="scan'208";a="19587818"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 04:37:09 -0700
X-CSE-ConnectionGUID: K64o/89+TC+ds7zfU2Yybw==
X-CSE-MsgGUID: UOs9e55lRzq/XZW8d5CUDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,212,1708416000"; 
   d="scan'208";a="27586154"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmviesa004.fm.intel.com with ESMTP; 18 Apr 2024 04:37:05 -0700
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Alexander Duyck <alexanderduyck@fb.com>,
	Yunsheng Lin <linyunsheng@huawei.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Christoph Lameter <cl@linux.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	netdev@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v10 08/10] iavf: pack iavf_ring more efficiently
Date: Thu, 18 Apr 2024 13:36:14 +0200
Message-ID: <20240418113616.1108566-9-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240418113616.1108566-1-aleksander.lobakin@intel.com>
References: <20240418113616.1108566-1-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
---
 drivers/net/ethernet/intel/iavf/iavf_txrx.h | 22 +++------------------
 drivers/net/ethernet/intel/iavf/iavf_txrx.c | 12 +++++------
 2 files changed, 9 insertions(+), 25 deletions(-)

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
-- 
2.44.0


