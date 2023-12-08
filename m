Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB74B80A195
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 11:54:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573761AbjLHKyC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 05:54:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573699AbjLHKxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 05:53:40 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2a07:de40:b251:101:10:150:64:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69058171F
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 02:53:46 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E80F72118E;
        Fri,  8 Dec 2023 10:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1702032825; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hWczCS20tTRrwDpvwe8/CSLdZ7ac/VDOdxeHB+SKxMI=;
        b=IHsm223H1P1U4r7Eji/BGR5s099PArvMt8Gt/UMckdqQ7fWZ5ViIzcaI42LRbcujlktYqs
        +3n7Xkr1vX0GKT/lFGuWNtQyHgo86y3Lm/jQzeosRNO38rH9/IdkzqMC2pjamH1FgjGxz2
        r7x2sM7zGcqca+beePCj2/kTkUHAK68=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1702032825;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hWczCS20tTRrwDpvwe8/CSLdZ7ac/VDOdxeHB+SKxMI=;
        b=Ljd9YXXO1FdfrOmzNuF5RVlvmEY365GmBqsz9tREmTnchGd4XuQIU3n9qnnzoEB3I6YVVs
        nIa2NZ94sFx6XJCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1702032824; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hWczCS20tTRrwDpvwe8/CSLdZ7ac/VDOdxeHB+SKxMI=;
        b=FYg1nsf/pUHgyWqOw9QdWXvHGxahOsmrtwSJchtojW1QLeleRvxgm0g6DNiNPGB3x2H3Zg
        SBpaO8W2tXdVvlBAPpNBeLsXOS63B5smMjPQuluQdmQ5K/NzqZX4X5kVkAtlQ5uicZqNVf
        sm9k7coB1OPlydS1OugGArrC/BARyRI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1702032824;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hWczCS20tTRrwDpvwe8/CSLdZ7ac/VDOdxeHB+SKxMI=;
        b=k5AveeftcK6eLCcRnmk5qr09Ze+8kxs/x925wKJJSVibB9ABJoJx7FR4fJ2u6majrKtj1y
        Mvcq9Td0iA5rM7AQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id D6347138FF;
        Fri,  8 Dec 2023 10:53:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
        by imap2.dmz-prg2.suse.org with ESMTPSA
        id gNviMrj1cmU7VgAAn2gu4w
        (envelope-from <dwagner@suse.de>); Fri, 08 Dec 2023 10:53:44 +0000
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>, Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v5 5/6] nvme: add csi, ms and nuse to sysfs
Date:   Fri,  8 Dec 2023 11:53:36 +0100
Message-ID: <20231208105337.23409-6-dwagner@suse.de>
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
Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/nvme/host/core.c  |  6 ++-
 drivers/nvme/host/nvme.h  |  6 +++
 drivers/nvme/host/sysfs.c | 85 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 96 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index c537914b75e3..3138cbb3b380 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -20,6 +20,7 @@
 #include <linux/ptrace.h>
 #include <linux/nvme_ioctl.h>
 #include <linux/pm_qos.h>
+#include <linux/ratelimit.h>
 #include <asm/unaligned.h>
 
 #include "nvme.h"
@@ -1459,7 +1460,7 @@ static int nvme_identify_ns_descs(struct nvme_ctrl *ctrl,
 	return status;
 }
 
-static int nvme_identify_ns(struct nvme_ctrl *ctrl, unsigned nsid,
+int nvme_identify_ns(struct nvme_ctrl *ctrl, unsigned nsid,
 			struct nvme_id_ns **id)
 {
 	struct nvme_command c = { };
@@ -2061,6 +2062,7 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
 	blk_mq_freeze_queue(ns->disk->queue);
 	lbaf = nvme_lbaf_index(id->flbas);
 	ns->head->lba_shift = id->lbaf[lbaf].ds;
+	ns->head->nuse = le64_to_cpu(id->nuse);
 	nvme_set_queue_limits(ns->ctrl, ns->queue);
 
 	ret = nvme_configure_metadata(ns->ctrl, ns->head, id);
@@ -3423,6 +3425,8 @@ static struct nvme_ns_head *nvme_alloc_ns_head(struct nvme_ctrl *ctrl,
 	head->ns_id = info->nsid;
 	head->ids = info->ids;
 	head->shared = info->is_shared;
+	ratelimit_state_init(&head->rs_nuse, 5 * HZ, 1);
+	ratelimit_set_flags(&head->rs_nuse, RATELIMIT_MSG_ON_RELEASE);
 	kref_init(&head->ref);
 
 	if (head->ids.csi) {
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index b783b37328fa..8912292720d4 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -16,6 +16,7 @@
 #include <linux/rcupdate.h>
 #include <linux/wait.h>
 #include <linux/t10-pi.h>
+#include <linux/ratelimit_types.h>
 
 #include <trace/events/block.h>
 
@@ -456,6 +457,7 @@ struct nvme_ns_head {
 	u16			pi_size;
 	u16			sgs;
 	u32			sws;
+	u64			nuse;
 	u8			pi_type;
 	u8			guard_type;
 #ifdef CONFIG_BLK_DEV_ZONED
@@ -463,6 +465,8 @@ struct nvme_ns_head {
 #endif
 	unsigned long		features;
 
+	struct ratelimit_state	rs_nuse;
+
 	struct cdev		cdev;
 	struct device		cdev_device;
 
@@ -867,6 +871,8 @@ int nvme_ns_chr_uring_cmd(struct io_uring_cmd *ioucmd,
 		unsigned int issue_flags);
 int nvme_ns_head_chr_uring_cmd(struct io_uring_cmd *ioucmd,
 		unsigned int issue_flags);
+int nvme_identify_ns(struct nvme_ctrl *ctrl, unsigned nsid,
+		struct nvme_id_ns **id);
 int nvme_getgeo(struct block_device *bdev, struct hd_geometry *geo);
 int nvme_dev_uring_cmd(struct io_uring_cmd *ioucmd, unsigned int issue_flags);
 
diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index d682d0a667a0..3cfae0c3af76 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -114,12 +114,97 @@ static ssize_t nsid_show(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_RO(nsid);
 
+static ssize_t csi_show(struct device *dev, struct device_attribute *attr,
+		char *buf)
+{
+	return sysfs_emit(buf, "%d\n", dev_to_ns_head(dev)->ids.csi);
+}
+static DEVICE_ATTR_RO(csi);
+
+static ssize_t metadata_bytes_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%d\n", dev_to_ns_head(dev)->ms);
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

