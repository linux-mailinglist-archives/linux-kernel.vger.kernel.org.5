Return-Path: <linux-kernel+bounces-4109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9197C817803
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 18:00:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 499E61C23244
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 17:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 270A65A845;
	Mon, 18 Dec 2023 17:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0t43dfb2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ryC53oId";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="iKQweVNv";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="RRbSRKUP"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CDDC498AB
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 17:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D87D221F0B;
	Mon, 18 Dec 2023 17:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702918801; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jyap0mqHbf21Ly20XfNS0pjDY2xo0PJzlsoqIjW37d0=;
	b=0t43dfb2QU3n0MQhKLRXz+Mw39btFEuMUmfLyzKpxn3RlRS8OKEaU+t6WBALKVM9ewwgSx
	W3LaR6453/JeZ/dYdIcoQp3GTvDmJLEci8af9mBKCTG0u6K+7Ltc6INUxS6COyRYOtpTyJ
	2omfpiQOlFAVJwITcuJ6wkQx5QesM64=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702918801;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jyap0mqHbf21Ly20XfNS0pjDY2xo0PJzlsoqIjW37d0=;
	b=ryC53oIdgmTVYAtsHxbwveri53scNWzGWbKPr0Nxs+X0gJP96D6OjmKVUGBjlTfrtgkj1s
	AcTLX+KTgHtl8TDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702918800; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jyap0mqHbf21Ly20XfNS0pjDY2xo0PJzlsoqIjW37d0=;
	b=iKQweVNva6DSDAvw4hghoRXX+NXyrZwTgnQbg76H/M79SV0EvyJinPq7c2QMkl5dfaNk3M
	Lu8HKrmuuFi5WFoETEMh4DG8Zt9DqecuqENGCDAYcJH2f+V4RjtkemmHWbuyAkrxI8uWVt
	TUxSs8eRS4NWTlaRiGd/F+tZV2tyhtw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702918800;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jyap0mqHbf21Ly20XfNS0pjDY2xo0PJzlsoqIjW37d0=;
	b=RRbSRKUPL3JGZuYgC6Pf9i2Vj8/nB55ZfL1XpwvKq955aNNg/AWBZblAh83VOgsDXJkUQd
	RxZDZU9l3MrNz9Dg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id C025313927;
	Mon, 18 Dec 2023 17:00:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 1fjqLZB6gGVKDwAAn2gu4w
	(envelope-from <dwagner@suse.de>); Mon, 18 Dec 2023 17:00:00 +0000
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>,
	Max Gurtovoy <mgurtovoy@nvidia.com>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v6 2/6] nvme: refactor ns info helpers
Date: Mon, 18 Dec 2023 17:59:50 +0100
Message-ID: <20231218165954.29652-3-dwagner@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231218165954.29652-1-dwagner@suse.de>
References: <20231218165954.29652-1-dwagner@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: *
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: 0.70
X-Spamd-Result: default: False [0.70 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[9];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Flag: NO

Pass in the nvme_ns_head pointer directly. This reduces the necessity on
the caller side have the nvme_ns data structure present. Thus we can
refactor the caller side in the next step as well.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/nvme/host/core.c | 36 +++++++++++++++++++++---------------
 drivers/nvme/host/nvme.h | 12 ++++++------
 drivers/nvme/host/rdma.c |  2 +-
 drivers/nvme/host/zns.c  | 12 ++++++------
 4 files changed, 34 insertions(+), 28 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f9a70c70d95c..7be1db8caff4 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -316,7 +316,7 @@ static void nvme_log_error(struct request *req)
 		       ns->disk ? ns->disk->disk_name : "?",
 		       nvme_get_opcode_str(nr->cmd->common.opcode),
 		       nr->cmd->common.opcode,
-		       nvme_sect_to_lba(ns, blk_rq_pos(req)),
+		       nvme_sect_to_lba(ns->head, blk_rq_pos(req)),
 		       blk_rq_bytes(req) >> ns->head->lba_shift,
 		       nvme_get_error_status_str(nr->status),
 		       nr->status >> 8 & 7,	/* Status Code Type */
@@ -372,9 +372,12 @@ static inline enum nvme_disposition nvme_decide_disposition(struct request *req)
 static inline void nvme_end_req_zoned(struct request *req)
 {
 	if (IS_ENABLED(CONFIG_BLK_DEV_ZONED) &&
-	    req_op(req) == REQ_OP_ZONE_APPEND)
-		req->__sector = nvme_lba_to_sect(req->q->queuedata,
+	    req_op(req) == REQ_OP_ZONE_APPEND) {
+		struct nvme_ns *ns = req->q->queuedata;
+
+		req->__sector = nvme_lba_to_sect(ns->head,
 			le64_to_cpu(nvme_req(req)->result.u64));
+	}
 }
 
 static inline void nvme_end_req(struct request *req)
@@ -791,7 +794,7 @@ static blk_status_t nvme_setup_discard(struct nvme_ns *ns, struct request *req,
 	}
 
 	if (queue_max_discard_segments(req->q) == 1) {
-		u64 slba = nvme_sect_to_lba(ns, blk_rq_pos(req));
+		u64 slba = nvme_sect_to_lba(ns->head, blk_rq_pos(req));
 		u32 nlb = blk_rq_sectors(req) >> (ns->head->lba_shift - 9);
 
 		range[0].cattr = cpu_to_le32(0);
@@ -800,7 +803,8 @@ static blk_status_t nvme_setup_discard(struct nvme_ns *ns, struct request *req,
 		n = 1;
 	} else {
 		__rq_for_each_bio(bio, req) {
-			u64 slba = nvme_sect_to_lba(ns, bio->bi_iter.bi_sector);
+			u64 slba = nvme_sect_to_lba(ns->head,
+						    bio->bi_iter.bi_sector);
 			u32 nlb = bio->bi_iter.bi_size >> ns->head->lba_shift;
 
 			if (n < segments) {
@@ -867,7 +871,7 @@ static inline blk_status_t nvme_setup_write_zeroes(struct nvme_ns *ns,
 	cmnd->write_zeroes.opcode = nvme_cmd_write_zeroes;
 	cmnd->write_zeroes.nsid = cpu_to_le32(ns->head->ns_id);
 	cmnd->write_zeroes.slba =
-		cpu_to_le64(nvme_sect_to_lba(ns, blk_rq_pos(req)));
+		cpu_to_le64(nvme_sect_to_lba(ns->head, blk_rq_pos(req)));
 	cmnd->write_zeroes.length =
 		cpu_to_le16((blk_rq_bytes(req) >> ns->head->lba_shift) - 1);
 
@@ -875,7 +879,7 @@ static inline blk_status_t nvme_setup_write_zeroes(struct nvme_ns *ns,
 	    (ns->head->features & NVME_NS_DEAC))
 		cmnd->write_zeroes.control |= cpu_to_le16(NVME_WZ_DEAC);
 
-	if (nvme_ns_has_pi(ns)) {
+	if (nvme_ns_has_pi(ns->head)) {
 		cmnd->write_zeroes.control |= cpu_to_le16(NVME_RW_PRINFO_PRACT);
 
 		switch (ns->head->pi_type) {
@@ -910,7 +914,8 @@ static inline blk_status_t nvme_setup_rw(struct nvme_ns *ns,
 	cmnd->rw.cdw2 = 0;
 	cmnd->rw.cdw3 = 0;
 	cmnd->rw.metadata = 0;
-	cmnd->rw.slba = cpu_to_le64(nvme_sect_to_lba(ns, blk_rq_pos(req)));
+	cmnd->rw.slba =
+		cpu_to_le64(nvme_sect_to_lba(ns->head, blk_rq_pos(req)));
 	cmnd->rw.length =
 		cpu_to_le16((blk_rq_bytes(req) >> ns->head->lba_shift) - 1);
 	cmnd->rw.reftag = 0;
@@ -925,7 +930,7 @@ static inline blk_status_t nvme_setup_rw(struct nvme_ns *ns,
 		 * namespace capacity to zero to prevent any I/O.
 		 */
 		if (!blk_integrity_rq(req)) {
-			if (WARN_ON_ONCE(!nvme_ns_has_pi(ns)))
+			if (WARN_ON_ONCE(!nvme_ns_has_pi(ns->head)))
 				return BLK_STS_NOTSUPP;
 			control |= NVME_RW_PRINFO_PRACT;
 		}
@@ -1723,8 +1728,9 @@ static void nvme_config_discard(struct gendisk *disk, struct nvme_ns *ns)
 	struct request_queue *queue = disk->queue;
 	u32 size = queue_logical_block_size(queue);
 
-	if (ctrl->dmrsl && ctrl->dmrsl <= nvme_sect_to_lba(ns, UINT_MAX))
-		ctrl->max_discard_sectors = nvme_lba_to_sect(ns, ctrl->dmrsl);
+	if (ctrl->dmrsl && ctrl->dmrsl <= nvme_sect_to_lba(ns->head, UINT_MAX))
+		ctrl->max_discard_sectors =
+			nvme_lba_to_sect(ns->head, ctrl->dmrsl);
 
 	if (ctrl->max_discard_sectors == 0) {
 		blk_queue_max_discard_sectors(queue, 0);
@@ -1848,7 +1854,7 @@ static int nvme_configure_metadata(struct nvme_ns *ns, struct nvme_id_ns *id)
 		 * Note, this check will need to be modified if any drivers
 		 * gain the ability to use other metadata formats.
 		 */
-		if (ctrl->max_integrity_segments && nvme_ns_has_pi(ns))
+		if (ctrl->max_integrity_segments && nvme_ns_has_pi(ns->head))
 			ns->head->features |= NVME_NS_METADATA_SUPPORTED;
 	} else {
 		/*
@@ -1886,7 +1892,7 @@ static void nvme_set_queue_limits(struct nvme_ctrl *ctrl,
 static void nvme_update_disk_info(struct gendisk *disk,
 		struct nvme_ns *ns, struct nvme_id_ns *id)
 {
-	sector_t capacity = nvme_lba_to_sect(ns, le64_to_cpu(id->nsze));
+	sector_t capacity = nvme_lba_to_sect(ns->head, le64_to_cpu(id->nsze));
 	u32 bs = 1U << ns->head->lba_shift;
 	u32 atomic_bs, phys_bs, io_opt = 0;
 
@@ -1942,7 +1948,7 @@ static void nvme_update_disk_info(struct gendisk *disk,
 		    (ns->head->features & NVME_NS_METADATA_SUPPORTED))
 			nvme_init_integrity(disk, ns,
 					    ns->ctrl->max_integrity_segments);
-		else if (!nvme_ns_has_pi(ns))
+		else if (!nvme_ns_has_pi(ns->head))
 			capacity = 0;
 	}
 
@@ -1973,7 +1979,7 @@ static void nvme_set_chunk_sectors(struct nvme_ns *ns, struct nvme_id_ns *id)
 	    is_power_of_2(ctrl->max_hw_sectors))
 		iob = ctrl->max_hw_sectors;
 	else
-		iob = nvme_lba_to_sect(ns, le16_to_cpu(id->noiob));
+		iob = nvme_lba_to_sect(ns->head, le16_to_cpu(id->noiob));
 
 	if (!iob)
 		return;
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 7b3c93d80eb1..9e5b9e779fbd 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -512,9 +512,9 @@ struct nvme_ns {
 };
 
 /* NVMe ns supports metadata actions by the controller (generate/strip) */
-static inline bool nvme_ns_has_pi(struct nvme_ns *ns)
+static inline bool nvme_ns_has_pi(struct nvme_ns_head *head)
 {
-	return ns->head->pi_type && ns->head->ms == ns->head->pi_size;
+	return head->pi_type && head->ms == head->pi_size;
 }
 
 struct nvme_ctrl_ops {
@@ -646,17 +646,17 @@ static inline int nvme_reset_subsystem(struct nvme_ctrl *ctrl)
 /*
  * Convert a 512B sector number to a device logical block number.
  */
-static inline u64 nvme_sect_to_lba(struct nvme_ns *ns, sector_t sector)
+static inline u64 nvme_sect_to_lba(struct nvme_ns_head *head, sector_t sector)
 {
-	return sector >> (ns->head->lba_shift - SECTOR_SHIFT);
+	return sector >> (head->lba_shift - SECTOR_SHIFT);
 }
 
 /*
  * Convert a device logical block number to a 512B sector number.
  */
-static inline sector_t nvme_lba_to_sect(struct nvme_ns *ns, u64 lba)
+static inline sector_t nvme_lba_to_sect(struct nvme_ns_head *head, u64 lba)
 {
-	return lba << (ns->head->lba_shift - SECTOR_SHIFT);
+	return lba << (head->lba_shift - SECTOR_SHIFT);
 }
 
 /*
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index be2a3e5884c0..bc90ec3c51b0 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -2012,7 +2012,7 @@ static blk_status_t nvme_rdma_queue_rq(struct blk_mq_hw_ctx *hctx,
 	    queue->pi_support &&
 	    (c->common.opcode == nvme_cmd_write ||
 	     c->common.opcode == nvme_cmd_read) &&
-	    nvme_ns_has_pi(ns))
+	    nvme_ns_has_pi(ns->head))
 		req->use_sig_mr = true;
 	else
 		req->use_sig_mr = false;
diff --git a/drivers/nvme/host/zns.c b/drivers/nvme/host/zns.c
index fa9e8f664ae7..ded52ab05424 100644
--- a/drivers/nvme/host/zns.c
+++ b/drivers/nvme/host/zns.c
@@ -100,7 +100,7 @@ int nvme_update_zone_info(struct nvme_ns *ns, unsigned lbaf)
 	}
 
 	ns->head->zsze =
-		nvme_lba_to_sect(ns, le64_to_cpu(id->lbafe[lbaf].zsze));
+		nvme_lba_to_sect(ns->head, le64_to_cpu(id->lbafe[lbaf].zsze));
 	if (!is_power_of_2(ns->head->zsze)) {
 		dev_warn(ns->ctrl->device,
 			"invalid zone size:%llu for namespace:%u\n",
@@ -164,12 +164,12 @@ static int nvme_zone_parse_entry(struct nvme_ns *ns,
 	zone.type = BLK_ZONE_TYPE_SEQWRITE_REQ;
 	zone.cond = entry->zs >> 4;
 	zone.len = ns->head->zsze;
-	zone.capacity = nvme_lba_to_sect(ns, le64_to_cpu(entry->zcap));
-	zone.start = nvme_lba_to_sect(ns, le64_to_cpu(entry->zslba));
+	zone.capacity = nvme_lba_to_sect(ns->head, le64_to_cpu(entry->zcap));
+	zone.start = nvme_lba_to_sect(ns->head, le64_to_cpu(entry->zslba));
 	if (zone.cond == BLK_ZONE_COND_FULL)
 		zone.wp = zone.start + zone.len;
 	else
-		zone.wp = nvme_lba_to_sect(ns, le64_to_cpu(entry->wp));
+		zone.wp = nvme_lba_to_sect(ns->head, le64_to_cpu(entry->wp));
 
 	return cb(&zone, idx, data);
 }
@@ -201,7 +201,7 @@ int nvme_ns_report_zones(struct nvme_ns *ns, sector_t sector,
 	while (zone_idx < nr_zones && sector < get_capacity(ns->disk)) {
 		memset(report, 0, buflen);
 
-		c.zmr.slba = cpu_to_le64(nvme_sect_to_lba(ns, sector));
+		c.zmr.slba = cpu_to_le64(nvme_sect_to_lba(ns->head, sector));
 		ret = nvme_submit_sync_cmd(ns->queue, &c, report, buflen);
 		if (ret) {
 			if (ret > 0)
@@ -240,7 +240,7 @@ blk_status_t nvme_setup_zone_mgmt_send(struct nvme_ns *ns, struct request *req,
 
 	c->zms.opcode = nvme_cmd_zone_mgmt_send;
 	c->zms.nsid = cpu_to_le32(ns->head->ns_id);
-	c->zms.slba = cpu_to_le64(nvme_sect_to_lba(ns, blk_rq_pos(req)));
+	c->zms.slba = cpu_to_le64(nvme_sect_to_lba(ns->head, blk_rq_pos(req)));
 	c->zms.zsa = action;
 
 	if (req_op(req) == REQ_OP_ZONE_RESET_ALL)
-- 
2.43.0


