Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65F0580A190
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 11:54:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573710AbjLHKxn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 05:53:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573678AbjLHKxj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 05:53:39 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2a07:de40:b251:101:10:150:64:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3A8E115
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 02:53:43 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 755C62118A;
        Fri,  8 Dec 2023 10:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1702032822; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U2m6nayRKgXH2piN2PWQyDqfFBTz3iS878F9SLHT2gk=;
        b=VAsuwtecHl5w4CdWFPSJVaP2wx4sqa/BIZepy4NqU9oyKBzaBc4dOktCl+MIvw4rJdqVqg
        0hjIMaWi2GmvySgpCKVha4qUGqoK07LCkdig8UckPY1546YKckr6e4VRZJR8qpc8hj7fnO
        Uj+xqGyNVz5vv/6xnq41DZRcn8MmpkM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1702032822;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U2m6nayRKgXH2piN2PWQyDqfFBTz3iS878F9SLHT2gk=;
        b=thn4TClagVR/56wXY6TGDKOxhyVWFyZIedjBnO+f5upVfZ0lw7JDjH9rBtXUXyiOgeuOdI
        YQ6LwnnqSufryRAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1702032822; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U2m6nayRKgXH2piN2PWQyDqfFBTz3iS878F9SLHT2gk=;
        b=VAsuwtecHl5w4CdWFPSJVaP2wx4sqa/BIZepy4NqU9oyKBzaBc4dOktCl+MIvw4rJdqVqg
        0hjIMaWi2GmvySgpCKVha4qUGqoK07LCkdig8UckPY1546YKckr6e4VRZJR8qpc8hj7fnO
        Uj+xqGyNVz5vv/6xnq41DZRcn8MmpkM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1702032822;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U2m6nayRKgXH2piN2PWQyDqfFBTz3iS878F9SLHT2gk=;
        b=thn4TClagVR/56wXY6TGDKOxhyVWFyZIedjBnO+f5upVfZ0lw7JDjH9rBtXUXyiOgeuOdI
        YQ6LwnnqSufryRAw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 62168138FF;
        Fri,  8 Dec 2023 10:53:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
        by imap2.dmz-prg2.suse.org with ESMTPSA
        id Cj9+Frb1cmUxVgAAn2gu4w
        (envelope-from <dwagner@suse.de>); Fri, 08 Dec 2023 10:53:42 +0000
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>, Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v5 1/6] nvme: move ns id info to struct nvme_ns_head
Date:   Fri,  8 Dec 2023 11:53:32 +0100
Message-ID: <20231208105337.23409-2-dwagner@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231208105337.23409-1-dwagner@suse.de>
References: <20231208105337.23409-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: 0.70
X-Spamd-Result: default: False [1.90 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         R_MISSING_CHARSET(2.50)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         BROKEN_CONTENT_TYPE(1.50)[];
         RCVD_COUNT_THREE(0.00)[3];
         DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
         RCPT_COUNT_SEVEN(0.00)[7];
         MID_CONTAINS_FROM(1.00)[];
         DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
         FUZZY_BLOCKED(0.00)[rspamd.com];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-3.00)[100.00%]
X-Spam-Flag: NO
X-Spam-Score: 1.90
Authentication-Results: smtp-out1.suse.de;
        none
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the namesapce info to struct nvme_ns_head, because it's the same
for all associated namespaces.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/nvme/host/core.c  | 81 ++++++++++++++++++++-------------------
 drivers/nvme/host/ioctl.c |  8 ++--
 drivers/nvme/host/nvme.h  | 28 +++++++-------
 drivers/nvme/host/rdma.c  |  2 +-
 drivers/nvme/host/zns.c   | 17 ++++----
 5 files changed, 70 insertions(+), 66 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index d699f0c8b13e..72908e622049 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -312,12 +312,12 @@ static void nvme_log_error(struct request *req)
 	struct nvme_request *nr = nvme_req(req);
 
 	if (ns) {
-		pr_err_ratelimited("%s: %s(0x%x) @ LBA %llu, %llu blocks, %s (sct 0x%x / sc 0x%x) %s%s\n",
+		pr_err_ratelimited("%s: %s(0x%x) @ LBA %llu, %u blocks, %s (sct 0x%x / sc 0x%x) %s%s\n",
 		       ns->disk ? ns->disk->disk_name : "?",
 		       nvme_get_opcode_str(nr->cmd->common.opcode),
 		       nr->cmd->common.opcode,
-		       (unsigned long long)nvme_sect_to_lba(ns, blk_rq_pos(req)),
-		       (unsigned long long)blk_rq_bytes(req) >> ns->lba_shift,
+		       nvme_sect_to_lba(ns, blk_rq_pos(req)),
+		       blk_rq_bytes(req) >> ns->head->lba_shift,
 		       nvme_get_error_status_str(nr->status),
 		       nr->status >> 8 & 7,	/* Status Code Type */
 		       nr->status & 0xff,	/* Status Code */
@@ -794,7 +794,7 @@ static blk_status_t nvme_setup_discard(struct nvme_ns *ns, struct request *req,
 
 	if (queue_max_discard_segments(req->q) == 1) {
 		u64 slba = nvme_sect_to_lba(ns, blk_rq_pos(req));
-		u32 nlb = blk_rq_sectors(req) >> (ns->lba_shift - 9);
+		u32 nlb = blk_rq_sectors(req) >> (ns->head->lba_shift - 9);
 
 		range[0].cattr = cpu_to_le32(0);
 		range[0].nlb = cpu_to_le32(nlb);
@@ -803,7 +803,7 @@ static blk_status_t nvme_setup_discard(struct nvme_ns *ns, struct request *req,
 	} else {
 		__rq_for_each_bio(bio, req) {
 			u64 slba = nvme_sect_to_lba(ns, bio->bi_iter.bi_sector);
-			u32 nlb = bio->bi_iter.bi_size >> ns->lba_shift;
+			u32 nlb = bio->bi_iter.bi_size >> ns->head->lba_shift;
 
 			if (n < segments) {
 				range[n].cattr = cpu_to_le32(0);
@@ -841,7 +841,7 @@ static void nvme_set_ref_tag(struct nvme_ns *ns, struct nvme_command *cmnd,
 	u64 ref48;
 
 	/* both rw and write zeroes share the same reftag format */
-	switch (ns->guard_type) {
+	switch (ns->head->guard_type) {
 	case NVME_NVM_NS_16B_GUARD:
 		cmnd->rw.reftag = cpu_to_le32(t10_pi_ref_tag(req));
 		break;
@@ -871,15 +871,16 @@ static inline blk_status_t nvme_setup_write_zeroes(struct nvme_ns *ns,
 	cmnd->write_zeroes.slba =
 		cpu_to_le64(nvme_sect_to_lba(ns, blk_rq_pos(req)));
 	cmnd->write_zeroes.length =
-		cpu_to_le16((blk_rq_bytes(req) >> ns->lba_shift) - 1);
+		cpu_to_le16((blk_rq_bytes(req) >> ns->head->lba_shift) - 1);
 
-	if (!(req->cmd_flags & REQ_NOUNMAP) && (ns->features & NVME_NS_DEAC))
+	if (!(req->cmd_flags & REQ_NOUNMAP) &&
+	    (ns->head->features & NVME_NS_DEAC))
 		cmnd->write_zeroes.control |= cpu_to_le16(NVME_WZ_DEAC);
 
 	if (nvme_ns_has_pi(ns)) {
 		cmnd->write_zeroes.control |= cpu_to_le16(NVME_RW_PRINFO_PRACT);
 
-		switch (ns->pi_type) {
+		switch (ns->head->pi_type) {
 		case NVME_NS_DPS_PI_TYPE1:
 		case NVME_NS_DPS_PI_TYPE2:
 			nvme_set_ref_tag(ns, cmnd, req);
@@ -912,12 +913,13 @@ static inline blk_status_t nvme_setup_rw(struct nvme_ns *ns,
 	cmnd->rw.cdw3 = 0;
 	cmnd->rw.metadata = 0;
 	cmnd->rw.slba = cpu_to_le64(nvme_sect_to_lba(ns, blk_rq_pos(req)));
-	cmnd->rw.length = cpu_to_le16((blk_rq_bytes(req) >> ns->lba_shift) - 1);
+	cmnd->rw.length =
+		cpu_to_le16((blk_rq_bytes(req) >> ns->head->lba_shift) - 1);
 	cmnd->rw.reftag = 0;
 	cmnd->rw.apptag = 0;
 	cmnd->rw.appmask = 0;
 
-	if (ns->ms) {
+	if (ns->head->ms) {
 		/*
 		 * If formated with metadata, the block layer always provides a
 		 * metadata buffer if CONFIG_BLK_DEV_INTEGRITY is enabled.  Else
@@ -930,7 +932,7 @@ static inline blk_status_t nvme_setup_rw(struct nvme_ns *ns,
 			control |= NVME_RW_PRINFO_PRACT;
 		}
 
-		switch (ns->pi_type) {
+		switch (ns->head->pi_type) {
 		case NVME_NS_DPS_PI_TYPE3:
 			control |= NVME_RW_PRINFO_PRCHK_GUARD;
 			break;
@@ -1676,9 +1678,9 @@ static void nvme_init_integrity(struct gendisk *disk, struct nvme_ns *ns,
 {
 	struct blk_integrity integrity = { };
 
-	switch (ns->pi_type) {
+	switch (ns->head->pi_type) {
 	case NVME_NS_DPS_PI_TYPE3:
-		switch (ns->guard_type) {
+		switch (ns->head->guard_type) {
 		case NVME_NVM_NS_16B_GUARD:
 			integrity.profile = &t10_pi_type3_crc;
 			integrity.tag_size = sizeof(u16) + sizeof(u32);
@@ -1696,7 +1698,7 @@ static void nvme_init_integrity(struct gendisk *disk, struct nvme_ns *ns,
 		break;
 	case NVME_NS_DPS_PI_TYPE1:
 	case NVME_NS_DPS_PI_TYPE2:
-		switch (ns->guard_type) {
+		switch (ns->head->guard_type) {
 		case NVME_NVM_NS_16B_GUARD:
 			integrity.profile = &t10_pi_type1_crc;
 			integrity.tag_size = sizeof(u16);
@@ -1717,7 +1719,7 @@ static void nvme_init_integrity(struct gendisk *disk, struct nvme_ns *ns,
 		break;
 	}
 
-	integrity.tuple_size = ns->ms;
+	integrity.tuple_size = ns->head->ms;
 	blk_integrity_register(disk, &integrity);
 	blk_queue_max_integrity_segments(disk->queue, max_integrity_segments);
 }
@@ -1776,11 +1778,11 @@ static int nvme_init_ms(struct nvme_ns *ns, struct nvme_id_ns *id)
 	int ret = 0;
 	u32 elbaf;
 
-	ns->pi_size = 0;
-	ns->ms = le16_to_cpu(id->lbaf[lbaf].ms);
+	ns->head->pi_size = 0;
+	ns->head->ms = le16_to_cpu(id->lbaf[lbaf].ms);
 	if (!(ctrl->ctratt & NVME_CTRL_ATTR_ELBAS)) {
-		ns->pi_size = sizeof(struct t10_pi_tuple);
-		ns->guard_type = NVME_NVM_NS_16B_GUARD;
+		ns->head->pi_size = sizeof(struct t10_pi_tuple);
+		ns->head->guard_type = NVME_NVM_NS_16B_GUARD;
 		goto set_pi;
 	}
 
@@ -1803,13 +1805,13 @@ static int nvme_init_ms(struct nvme_ns *ns, struct nvme_id_ns *id)
 	if (nvme_elbaf_sts(elbaf))
 		goto free_data;
 
-	ns->guard_type = nvme_elbaf_guard_type(elbaf);
-	switch (ns->guard_type) {
+	ns->head->guard_type = nvme_elbaf_guard_type(elbaf);
+	switch (ns->head->guard_type) {
 	case NVME_NVM_NS_64B_GUARD:
-		ns->pi_size = sizeof(struct crc64_pi_tuple);
+		ns->head->pi_size = sizeof(struct crc64_pi_tuple);
 		break;
 	case NVME_NVM_NS_16B_GUARD:
-		ns->pi_size = sizeof(struct t10_pi_tuple);
+		ns->head->pi_size = sizeof(struct t10_pi_tuple);
 		break;
 	default:
 		break;
@@ -1818,10 +1820,10 @@ static int nvme_init_ms(struct nvme_ns *ns, struct nvme_id_ns *id)
 free_data:
 	kfree(nvm);
 set_pi:
-	if (ns->pi_size && (first || ns->ms == ns->pi_size))
-		ns->pi_type = id->dps & NVME_NS_DPS_PI_MASK;
+	if (ns->head->pi_size && (first || ns->head->ms == ns->head->pi_size))
+		ns->head->pi_type = id->dps & NVME_NS_DPS_PI_MASK;
 	else
-		ns->pi_type = 0;
+		ns->head->pi_type = 0;
 
 	return ret;
 }
@@ -1835,8 +1837,8 @@ static int nvme_configure_metadata(struct nvme_ns *ns, struct nvme_id_ns *id)
 	if (ret)
 		return ret;
 
-	ns->features &= ~(NVME_NS_METADATA_SUPPORTED | NVME_NS_EXT_LBAS);
-	if (!ns->ms || !(ctrl->ops->flags & NVME_F_METADATA_SUPPORTED))
+	ns->head->features &= ~(NVME_NS_METADATA_SUPPORTED | NVME_NS_EXT_LBAS);
+	if (!ns->head->ms || !(ctrl->ops->flags & NVME_F_METADATA_SUPPORTED))
 		return 0;
 
 	if (ctrl->ops->flags & NVME_F_FABRICS) {
@@ -1848,7 +1850,7 @@ static int nvme_configure_metadata(struct nvme_ns *ns, struct nvme_id_ns *id)
 		if (WARN_ON_ONCE(!(id->flbas & NVME_NS_FLBAS_META_EXT)))
 			return 0;
 
-		ns->features |= NVME_NS_EXT_LBAS;
+		ns->head->features |= NVME_NS_EXT_LBAS;
 
 		/*
 		 * The current fabrics transport drivers support namespace
@@ -1860,7 +1862,7 @@ static int nvme_configure_metadata(struct nvme_ns *ns, struct nvme_id_ns *id)
 		 * gain the ability to use other metadata formats.
 		 */
 		if (ctrl->max_integrity_segments && nvme_ns_has_pi(ns))
-			ns->features |= NVME_NS_METADATA_SUPPORTED;
+			ns->head->features |= NVME_NS_METADATA_SUPPORTED;
 	} else {
 		/*
 		 * For PCIe controllers, we can't easily remap the separate
@@ -1869,9 +1871,9 @@ static int nvme_configure_metadata(struct nvme_ns *ns, struct nvme_id_ns *id)
 		 * We allow extended LBAs for the passthrough interface, though.
 		 */
 		if (id->flbas & NVME_NS_FLBAS_META_EXT)
-			ns->features |= NVME_NS_EXT_LBAS;
+			ns->head->features |= NVME_NS_EXT_LBAS;
 		else
-			ns->features |= NVME_NS_METADATA_SUPPORTED;
+			ns->head->features |= NVME_NS_METADATA_SUPPORTED;
 	}
 	return 0;
 }
@@ -1898,7 +1900,7 @@ static void nvme_update_disk_info(struct gendisk *disk,
 		struct nvme_ns *ns, struct nvme_id_ns *id)
 {
 	sector_t capacity = nvme_lba_to_sect(ns, le64_to_cpu(id->nsze));
-	u32 bs = 1U << ns->lba_shift;
+	u32 bs = 1U << ns->head->lba_shift;
 	u32 atomic_bs, phys_bs, io_opt = 0;
 
 	/*
@@ -1906,7 +1908,8 @@ static void nvme_update_disk_info(struct gendisk *disk,
 	 * or smaller than a sector size yet, so catch this early and don't
 	 * allow block I/O.
 	 */
-	if (ns->lba_shift > PAGE_SHIFT || ns->lba_shift < SECTOR_SHIFT) {
+	if (ns->head->lba_shift > PAGE_SHIFT ||
+	    ns->head->lba_shift < SECTOR_SHIFT) {
 		capacity = 0;
 		bs = (1 << 9);
 	}
@@ -1949,9 +1952,9 @@ static void nvme_update_disk_info(struct gendisk *disk,
 	 * I/O to namespaces with metadata except when the namespace supports
 	 * PI, as it can strip/insert in that case.
 	 */
-	if (ns->ms) {
+	if (ns->head->ms) {
 		if (IS_ENABLED(CONFIG_BLK_DEV_INTEGRITY) &&
-		    (ns->features & NVME_NS_METADATA_SUPPORTED))
+		    (ns->head->features & NVME_NS_METADATA_SUPPORTED))
 			nvme_init_integrity(disk, ns,
 					    ns->ctrl->max_integrity_segments);
 		else if (!nvme_ns_has_pi(ns))
@@ -2052,7 +2055,7 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
 
 	blk_mq_freeze_queue(ns->disk->queue);
 	lbaf = nvme_lbaf_index(id->flbas);
-	ns->lba_shift = id->lbaf[lbaf].ds;
+	ns->head->lba_shift = id->lbaf[lbaf].ds;
 	nvme_set_queue_limits(ns->ctrl, ns->queue);
 
 	ret = nvme_configure_metadata(ns, id);
@@ -2078,7 +2081,7 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
 	 * do not return zeroes.
 	 */
 	if ((id->dlfeat & 0x7) == 0x1 && (id->dlfeat & (1 << 3)))
-		ns->features |= NVME_NS_DEAC;
+		ns->head->features |= NVME_NS_DEAC;
 	set_disk_ro(ns->disk, nvme_ns_is_readonly(ns, info));
 	set_bit(NVME_NS_READY, &ns->flags);
 	blk_mq_unfreeze_queue(ns->disk->queue);
diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 529b9954d2b8..feee9cf50670 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -283,10 +283,10 @@ static int nvme_submit_io(struct nvme_ns *ns, struct nvme_user_io __user *uio)
 		return -EINVAL;
 	}
 
-	length = (io.nblocks + 1) << ns->lba_shift;
+	length = (io.nblocks + 1) << ns->head->lba_shift;
 
 	if ((io.control & NVME_RW_PRINFO_PRACT) &&
-	    ns->ms == sizeof(struct t10_pi_tuple)) {
+	    ns->head->ms == sizeof(struct t10_pi_tuple)) {
 		/*
 		 * Protection information is stripped/inserted by the
 		 * controller.
@@ -296,11 +296,11 @@ static int nvme_submit_io(struct nvme_ns *ns, struct nvme_user_io __user *uio)
 		meta_len = 0;
 		metadata = NULL;
 	} else {
-		meta_len = (io.nblocks + 1) * ns->ms;
+		meta_len = (io.nblocks + 1) * ns->head->ms;
 		metadata = nvme_to_user_ptr(io.metadata);
 	}
 
-	if (ns->features & NVME_NS_EXT_LBAS) {
+	if (ns->head->features & NVME_NS_EXT_LBAS) {
 		length += meta_len;
 		meta_len = 0;
 	} else if (meta_len) {
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 578e6d311bc9..1ebe6a9b42c9 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -451,6 +451,17 @@ struct nvme_ns_head {
 	bool			shared;
 	int			instance;
 	struct nvme_effects_log *effects;
+	int			lba_shift;
+	u16			ms;
+	u16			pi_size;
+	u16			sgs;
+	u32			sws;
+	u8			pi_type;
+	u8			guard_type;
+#ifdef CONFIG_BLK_DEV_ZONED
+	u64			zsze;
+#endif
+	unsigned long		features;
 
 	struct cdev		cdev;
 	struct device		cdev_device;
@@ -492,17 +503,6 @@ struct nvme_ns {
 	struct kref kref;
 	struct nvme_ns_head *head;
 
-	int lba_shift;
-	u16 ms;
-	u16 pi_size;
-	u16 sgs;
-	u32 sws;
-	u8 pi_type;
-	u8 guard_type;
-#ifdef CONFIG_BLK_DEV_ZONED
-	u64 zsze;
-#endif
-	unsigned long features;
 	unsigned long flags;
 #define NVME_NS_REMOVING	0
 #define NVME_NS_ANA_PENDING	2
@@ -519,7 +519,7 @@ struct nvme_ns {
 /* NVMe ns supports metadata actions by the controller (generate/strip) */
 static inline bool nvme_ns_has_pi(struct nvme_ns *ns)
 {
-	return ns->pi_type && ns->ms == ns->pi_size;
+	return ns->head->pi_type && ns->head->ms == ns->head->pi_size;
 }
 
 struct nvme_ctrl_ops {
@@ -653,7 +653,7 @@ static inline int nvme_reset_subsystem(struct nvme_ctrl *ctrl)
  */
 static inline u64 nvme_sect_to_lba(struct nvme_ns *ns, sector_t sector)
 {
-	return sector >> (ns->lba_shift - SECTOR_SHIFT);
+	return sector >> (ns->head->lba_shift - SECTOR_SHIFT);
 }
 
 /*
@@ -661,7 +661,7 @@ static inline u64 nvme_sect_to_lba(struct nvme_ns *ns, sector_t sector)
  */
 static inline sector_t nvme_lba_to_sect(struct nvme_ns *ns, u64 lba)
 {
-	return lba << (ns->lba_shift - SECTOR_SHIFT);
+	return lba << (ns->head->lba_shift - SECTOR_SHIFT);
 }
 
 /*
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 81e2621169e5..fc0df91e6b36 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1423,7 +1423,7 @@ static int nvme_rdma_map_sg_pi(struct nvme_rdma_queue *queue,
 		goto mr_put;
 
 	nvme_rdma_set_sig_attrs(blk_get_integrity(bio->bi_bdev->bd_disk), c,
-				req->mr->sig_attrs, ns->pi_type);
+				req->mr->sig_attrs, ns->head->pi_type);
 	nvme_rdma_set_prot_checks(c, &req->mr->sig_attrs->check_mask);
 
 	ib_update_fast_reg_key(req->mr, ib_inc_rkey(req->mr->rkey));
diff --git a/drivers/nvme/host/zns.c b/drivers/nvme/host/zns.c
index ec8557810c21..fa9e8f664ae7 100644
--- a/drivers/nvme/host/zns.c
+++ b/drivers/nvme/host/zns.c
@@ -11,7 +11,7 @@ int nvme_revalidate_zones(struct nvme_ns *ns)
 {
 	struct request_queue *q = ns->queue;
 
-	blk_queue_chunk_sectors(q, ns->zsze);
+	blk_queue_chunk_sectors(q, ns->head->zsze);
 	blk_queue_max_zone_append_sectors(q, ns->ctrl->max_zone_append);
 
 	return blk_revalidate_disk_zones(ns->disk, NULL);
@@ -99,11 +99,12 @@ int nvme_update_zone_info(struct nvme_ns *ns, unsigned lbaf)
 		goto free_data;
 	}
 
-	ns->zsze = nvme_lba_to_sect(ns, le64_to_cpu(id->lbafe[lbaf].zsze));
-	if (!is_power_of_2(ns->zsze)) {
+	ns->head->zsze =
+		nvme_lba_to_sect(ns, le64_to_cpu(id->lbafe[lbaf].zsze));
+	if (!is_power_of_2(ns->head->zsze)) {
 		dev_warn(ns->ctrl->device,
 			"invalid zone size:%llu for namespace:%u\n",
-			ns->zsze, ns->head->ns_id);
+			ns->head->zsze, ns->head->ns_id);
 		status = -ENODEV;
 		goto free_data;
 	}
@@ -128,7 +129,7 @@ static void *nvme_zns_alloc_report_buffer(struct nvme_ns *ns,
 				   sizeof(struct nvme_zone_descriptor);
 
 	nr_zones = min_t(unsigned int, nr_zones,
-			 get_capacity(ns->disk) >> ilog2(ns->zsze));
+			 get_capacity(ns->disk) >> ilog2(ns->head->zsze));
 
 	bufsize = sizeof(struct nvme_zone_report) +
 		nr_zones * sizeof(struct nvme_zone_descriptor);
@@ -162,7 +163,7 @@ static int nvme_zone_parse_entry(struct nvme_ns *ns,
 
 	zone.type = BLK_ZONE_TYPE_SEQWRITE_REQ;
 	zone.cond = entry->zs >> 4;
-	zone.len = ns->zsze;
+	zone.len = ns->head->zsze;
 	zone.capacity = nvme_lba_to_sect(ns, le64_to_cpu(entry->zcap));
 	zone.start = nvme_lba_to_sect(ns, le64_to_cpu(entry->zslba));
 	if (zone.cond == BLK_ZONE_COND_FULL)
@@ -196,7 +197,7 @@ int nvme_ns_report_zones(struct nvme_ns *ns, sector_t sector,
 	c.zmr.zrasf = NVME_ZRASF_ZONE_REPORT_ALL;
 	c.zmr.pr = NVME_REPORT_ZONE_PARTIAL;
 
-	sector &= ~(ns->zsze - 1);
+	sector &= ~(ns->head->zsze - 1);
 	while (zone_idx < nr_zones && sector < get_capacity(ns->disk)) {
 		memset(report, 0, buflen);
 
@@ -220,7 +221,7 @@ int nvme_ns_report_zones(struct nvme_ns *ns, sector_t sector,
 			zone_idx++;
 		}
 
-		sector += ns->zsze * nz;
+		sector += ns->head->zsze * nz;
 	}
 
 	if (zone_idx > 0)
-- 
2.43.0

