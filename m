Return-Path: <linux-kernel+bounces-160177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54CA18B3A48
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 16:44:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BBAA286399
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 14:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76F37148831;
	Fri, 26 Apr 2024 14:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QxHf3Tve"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78FC634CD8;
	Fri, 26 Apr 2024 14:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714142678; cv=none; b=R71xR2lrSCCxFVfqsVFLIz/EYyx9sfrcKLdbWVJB5/D7R/46U6OrgmUyCpUORIxvLQBg+Gk2uMJtdG3PIflKvw/MydKPaiJWKiHqRpyHhMcUnepGjTwEBH8ujtpWsCUDtZIQlO7SwC/ZEH/FA2acc0IUlN2ZiT+YGbPfB3ZTPrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714142678; c=relaxed/simple;
	bh=c0dO8Re1PPSOl6/PX/WShnH30RI1DTXQ2uGy1lx3ZGY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sj9SO98A11SLfDxndMicwYessahSdIcak3aZ5+8csxlLEqN9Q8yBcEkW1Noh8dWoiAEsKNHIoTku9S7Fp9/H1xCujWHVA3ws6jNkmcOHSBuFUUpKJS7NrbVttHtwWllFUdLjugsu8nA5tWthcKT7esv+1oyxdVUYDf2AHbuuLE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QxHf3Tve; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714142677; x=1745678677;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=c0dO8Re1PPSOl6/PX/WShnH30RI1DTXQ2uGy1lx3ZGY=;
  b=QxHf3TveYWXhXkZs6VpVLsMZ8hCHVNxNzGmRuJ5SDkv5NciWWk45Xut0
   US/KD4LApuDQ8VbilrbLhbvyx90hJVP/3oOByjv7yEYMouKaBQPT5TBBa
   vvOE4CS6cIrkxawuG02Lab7kQwHeNIsrXEcOgncH+sowT8eyQgIF0fEWG
   rPP7XGDToKC0mBblX7WyAxnglr1ePH6KsQ6LPNr9OlapAUHwkPVWb4kgG
   ZTzGcp40dhhaFENcFdFrO4r35g5vTDrWkxv4Cgue8YcEooaTSwsuo6OCT
   NoRiNHUGvjm4MrRnNnjb4ktGAg2oh+5IetB1d8jMTdwEhxUiVYGCOkxaq
   w==;
X-CSE-ConnectionGUID: XwGv4Kq3Q5CZcv5SOntvgw==
X-CSE-MsgGUID: RLTt0K/iQze6EvHxFRUytw==
X-IronPort-AV: E=McAfee;i="6600,9927,11056"; a="21027171"
X-IronPort-AV: E=Sophos;i="6.07,232,1708416000"; 
   d="scan'208";a="21027171"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2024 07:44:36 -0700
X-CSE-ConnectionGUID: TSpeNl3CRVa+TG14ajS9gA==
X-CSE-MsgGUID: lRRvpSkZQn6dyH8QEoaxqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,232,1708416000"; 
   d="scan'208";a="25441219"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmviesa007.fm.intel.com with ESMTP; 26 Apr 2024 07:44:33 -0700
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Michal Kubiak <michal.kubiak@intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH iwl] idpf: don't enable NAPI and interrupts prior to allocating Rx buffers
Date: Fri, 26 Apr 2024 16:44:08 +0200
Message-ID: <20240426144408.1353962-1-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, idpf enables NAPI and interrupts prior to allocating Rx
buffers.
This may lead to frame loss (there are no buffers to place incoming
frames) and even crashes on quick ifup-ifdown. Interrupts must be
enabled only after all the resources are here and available.
Split interrupt init into two phases: initialization and enabling,
and perform the second only after the queues are fully initialized.
Note that we can't just move interrupt initialization down the init
process, as the queues must have correct a ::q_vector pointer set
and NAPI already added in order to allocate buffers correctly.
Also, during the deinit process, disable HW interrupts first and
only then disable NAPI. Otherwise, there can be a HW event leading
to napi_schedule(), but the NAPI will already be unavailable.

Fixes: d4d558718266 ("idpf: initialize interrupts and enable vport")
Reported-by: Michal Kubiak <michal.kubiak@intel.com>
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_txrx.h |  1 +
 drivers/net/ethernet/intel/idpf/idpf_lib.c  |  1 +
 drivers/net/ethernet/intel/idpf/idpf_txrx.c | 12 +++++++-----
 3 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.h b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
index 3d046b81e507..551391e20464 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
@@ -990,6 +990,7 @@ int idpf_vport_intr_alloc(struct idpf_vport *vport);
 void idpf_vport_intr_update_itr_ena_irq(struct idpf_q_vector *q_vector);
 void idpf_vport_intr_deinit(struct idpf_vport *vport);
 int idpf_vport_intr_init(struct idpf_vport *vport);
+void idpf_vport_intr_ena(struct idpf_vport *vport);
 enum pkt_hash_types idpf_ptype_to_htype(const struct idpf_rx_ptype_decoded *decoded);
 int idpf_config_rss(struct idpf_vport *vport);
 int idpf_init_rss(struct idpf_vport *vport);
diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
index 5d3532c27d57..ae8a48c48070 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
@@ -1394,6 +1394,7 @@ static int idpf_vport_open(struct idpf_vport *vport, bool alloc_res)
 	}
 
 	idpf_rx_init_buf_tail(vport);
+	idpf_vport_intr_ena(vport);
 
 	err = idpf_send_config_queues_msg(vport);
 	if (err) {
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index 285da2177ee4..b023704bbbda 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -3746,9 +3746,9 @@ static void idpf_vport_intr_ena_irq_all(struct idpf_vport *vport)
  */
 void idpf_vport_intr_deinit(struct idpf_vport *vport)
 {
+	idpf_vport_intr_dis_irq_all(vport);
 	idpf_vport_intr_napi_dis_all(vport);
 	idpf_vport_intr_napi_del_all(vport);
-	idpf_vport_intr_dis_irq_all(vport);
 	idpf_vport_intr_rel_irq(vport);
 }
 
@@ -4179,7 +4179,6 @@ int idpf_vport_intr_init(struct idpf_vport *vport)
 
 	idpf_vport_intr_map_vector_to_qs(vport);
 	idpf_vport_intr_napi_add_all(vport);
-	idpf_vport_intr_napi_ena_all(vport);
 
 	err = vport->adapter->dev_ops.reg_ops.intr_reg_init(vport);
 	if (err)
@@ -4193,17 +4192,20 @@ int idpf_vport_intr_init(struct idpf_vport *vport)
 	if (err)
 		goto unroll_vectors_alloc;
 
-	idpf_vport_intr_ena_irq_all(vport);
-
 	return 0;
 
 unroll_vectors_alloc:
-	idpf_vport_intr_napi_dis_all(vport);
 	idpf_vport_intr_napi_del_all(vport);
 
 	return err;
 }
 
+void idpf_vport_intr_ena(struct idpf_vport *vport)
+{
+	idpf_vport_intr_napi_ena_all(vport);
+	idpf_vport_intr_ena_irq_all(vport);
+}
+
 /**
  * idpf_config_rss - Send virtchnl messages to configure RSS
  * @vport: virtual port
-- 
2.44.0


