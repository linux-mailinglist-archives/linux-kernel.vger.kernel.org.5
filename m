Return-Path: <linux-kernel+bounces-4112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04AF8817807
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 18:00:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A26EC283CB9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 17:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D1CD5BFA2;
	Mon, 18 Dec 2023 17:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="T9fp/vre";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Su+CZnkb";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="T9fp/vre";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Su+CZnkb"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594604FF68
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 17:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 691321FD50;
	Mon, 18 Dec 2023 17:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702918802; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=takDcgXV/tTKF3RS+Eh30UBJrZjZhLNOR+4fOHg32+M=;
	b=T9fp/vre1pUz1i4CK0Sh/Qpzh37eOLxs8SXbYVXRyciYWW1H7rtdq7BiFQZEKw7sHKlw3n
	mM2skR6MPtpswZHD8ikRi7A2Oi3OXeS2bljM1tYlPg4y3nAXwX/sb3F+gS04aOD5p0w/Pq
	ARGOhjno51jGzLXABw9sFc+7drKT71s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702918802;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=takDcgXV/tTKF3RS+Eh30UBJrZjZhLNOR+4fOHg32+M=;
	b=Su+CZnkb8qTj75XU498Y/3oUsFZdfPA81JrtrtlkoDVTMzJzYck1dTJJqWIRG+/0y3p9Uq
	6qgTMSGBv8IPx9DQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702918802; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=takDcgXV/tTKF3RS+Eh30UBJrZjZhLNOR+4fOHg32+M=;
	b=T9fp/vre1pUz1i4CK0Sh/Qpzh37eOLxs8SXbYVXRyciYWW1H7rtdq7BiFQZEKw7sHKlw3n
	mM2skR6MPtpswZHD8ikRi7A2Oi3OXeS2bljM1tYlPg4y3nAXwX/sb3F+gS04aOD5p0w/Pq
	ARGOhjno51jGzLXABw9sFc+7drKT71s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702918802;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=takDcgXV/tTKF3RS+Eh30UBJrZjZhLNOR+4fOHg32+M=;
	b=Su+CZnkb8qTj75XU498Y/3oUsFZdfPA81JrtrtlkoDVTMzJzYck1dTJJqWIRG+/0y3p9Uq
	6qgTMSGBv8IPx9DQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 59A1A13927;
	Mon, 18 Dec 2023 17:00:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id zJDlFJJ6gGVpDwAAn2gu4w
	(envelope-from <dwagner@suse.de>); Mon, 18 Dec 2023 17:00:02 +0000
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
Subject: [PATCH v6 5/6] nvme: add csi, ms and nuse to sysfs
Date: Mon, 18 Dec 2023 17:59:53 +0100
Message-ID: <20231218165954.29652-6-dwagner@suse.de>
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
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 
X-Spamd-Bar: /
X-Spam-Flag: NO
X-Spamd-Result: default: False [-0.31 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[9];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="T9fp/vre";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Su+CZnkb
X-Spam-Score: -0.31
X-Rspamd-Queue-Id: 691321FD50

libnvme is using the sysfs for enumarating the nvme resources. Though
there are few missing attritbutes in the sysfs. For these libnvme issues
commands during discovering.

As the kernel already knows all these attributes and we would like to
avoid libnvme to issue commands all the time, expose these missing
attributes.

The nuse value is updated on request because the nuse is a volatile
value. Since any user can read the sysfs attribute, a very simple rate
limit is added (update once every 5 seconds). A more sophisticated
update strategy can be added later if there is actually a need for it.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/nvme/host/core.c  |  6 ++-
 drivers/nvme/host/nvme.h  |  6 +++
 drivers/nvme/host/sysfs.c | 85 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 96 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index ba738ae83cba..22dae2a26ba4 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -20,6 +20,7 @@
 #include <linux/ptrace.h>
 #include <linux/nvme_ioctl.h>
 #include <linux/pm_qos.h>
+#include <linux/ratelimit.h>
 #include <asm/unaligned.h>
 
 #include "nvme.h"
@@ -1449,7 +1450,7 @@ static int nvme_identify_ns_descs(struct nvme_ctrl *ctrl,
 	return status;
 }
 
-static int nvme_identify_ns(struct nvme_ctrl *ctrl, unsigned nsid,
+int nvme_identify_ns(struct nvme_ctrl *ctrl, unsigned nsid,
 			struct nvme_id_ns **id)
 {
 	struct nvme_command c = { };
@@ -2040,6 +2041,7 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
 	blk_mq_freeze_queue(ns->disk->queue);
 	lbaf = nvme_lbaf_index(id->flbas);
 	ns->head->lba_shift = id->lbaf[lbaf].ds;
+	ns->head->nuse = le64_to_cpu(id->nuse);
 	nvme_set_queue_limits(ns->ctrl, ns->queue);
 
 	ret = nvme_configure_metadata(ns->ctrl, ns->head, id);
@@ -3420,6 +3422,8 @@ static struct nvme_ns_head *nvme_alloc_ns_head(struct nvme_ctrl *ctrl,
 	head->ns_id = info->nsid;
 	head->ids = info->ids;
 	head->shared = info->is_shared;
+	ratelimit_state_init(&head->rs_nuse, 5 * HZ, 1);
+	ratelimit_set_flags(&head->rs_nuse, RATELIMIT_MSG_ON_RELEASE);
 	kref_init(&head->ref);
 
 	if (head->ids.csi) {
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 919115916449..6211f18c53c7 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -16,6 +16,7 @@
 #include <linux/rcupdate.h>
 #include <linux/wait.h>
 #include <linux/t10-pi.h>
+#include <linux/ratelimit_types.h>
 
 #include <trace/events/block.h>
 
@@ -451,6 +452,7 @@ struct nvme_ns_head {
 	u16			pi_size;
 	u16			sgs;
 	u32			sws;
+	u64			nuse;
 	u8			pi_type;
 	u8			guard_type;
 #ifdef CONFIG_BLK_DEV_ZONED
@@ -458,6 +460,8 @@ struct nvme_ns_head {
 #endif
 	unsigned long		features;
 
+	struct ratelimit_state	rs_nuse;
+
 	struct cdev		cdev;
 	struct device		cdev_device;
 
@@ -862,6 +866,8 @@ int nvme_ns_chr_uring_cmd(struct io_uring_cmd *ioucmd,
 		unsigned int issue_flags);
 int nvme_ns_head_chr_uring_cmd(struct io_uring_cmd *ioucmd,
 		unsigned int issue_flags);
+int nvme_identify_ns(struct nvme_ctrl *ctrl, unsigned nsid,
+		struct nvme_id_ns **id);
 int nvme_getgeo(struct block_device *bdev, struct hd_geometry *geo);
 int nvme_dev_uring_cmd(struct io_uring_cmd *ioucmd, unsigned int issue_flags);
 
diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index d682d0a667a0..ac24ad102380 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -114,12 +114,97 @@ static ssize_t nsid_show(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_RO(nsid);
 
+static ssize_t csi_show(struct device *dev, struct device_attribute *attr,
+		char *buf)
+{
+	return sysfs_emit(buf, "%u\n", dev_to_ns_head(dev)->ids.csi);
+}
+static DEVICE_ATTR_RO(csi);
+
+static ssize_t metadata_bytes_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%u\n", dev_to_ns_head(dev)->ms);
+}
+static DEVICE_ATTR_RO(metadata_bytes);
+
+static int ns_head_update_nuse(struct nvme_ns_head *head)
+{
+	struct nvme_id_ns *id;
+	struct nvme_ns *ns;
+	int srcu_idx, ret = -EWOULDBLOCK;
+
+	/* Avoid issuing commands too often by rate limiting the update */
+	if (!__ratelimit(&head->rs_nuse))
+		return 0;
+
+	srcu_idx = srcu_read_lock(&head->srcu);
+	ns = nvme_find_path(head);
+	if (!ns)
+		goto out_unlock;
+
+	ret = nvme_identify_ns(ns->ctrl, head->ns_id, &id);
+	if (ret)
+		goto out_unlock;
+
+	head->nuse = le64_to_cpu(id->nuse);
+	kfree(id);
+
+out_unlock:
+	srcu_read_unlock(&head->srcu, srcu_idx);
+	return ret;
+}
+
+static int ns_update_nuse(struct nvme_ns *ns)
+{
+	struct nvme_id_ns *id;
+	int ret;
+
+	/* Avoid issuing commands too often by rate limiting the update. */
+	if (!__ratelimit(&ns->head->rs_nuse))
+		return 0;
+
+	ret = nvme_identify_ns(ns->ctrl, ns->head->ns_id, &id);
+	if (ret)
+		goto out_free_id;
+
+	ns->head->nuse = le64_to_cpu(id->nuse);
+
+out_free_id:
+	kfree(id);
+
+	return ret;
+}
+
+static ssize_t nuse_show(struct device *dev, struct device_attribute *attr,
+		char *buf)
+{
+	struct nvme_ns_head *head = dev_to_ns_head(dev);
+	struct gendisk *disk = dev_to_disk(dev);
+	struct block_device *bdev = disk->part0;
+	int ret;
+
+	if (IS_ENABLED(CONFIG_NVME_MULTIPATH) &&
+	    bdev->bd_disk->fops == &nvme_ns_head_ops)
+		ret = ns_head_update_nuse(head);
+	else
+		ret = ns_update_nuse(bdev->bd_disk->private_data);
+	if (ret)
+		return ret;
+
+	return sysfs_emit(buf, "%llu\n", head->nuse);
+}
+static DEVICE_ATTR_RO(nuse);
+
 static struct attribute *nvme_ns_attrs[] = {
 	&dev_attr_wwid.attr,
 	&dev_attr_uuid.attr,
 	&dev_attr_nguid.attr,
 	&dev_attr_eui.attr,
+	&dev_attr_csi.attr,
 	&dev_attr_nsid.attr,
+	&dev_attr_metadata_bytes.attr,
+	&dev_attr_nuse.attr,
 #ifdef CONFIG_NVME_MULTIPATH
 	&dev_attr_ana_grpid.attr,
 	&dev_attr_ana_state.attr,
-- 
2.43.0


