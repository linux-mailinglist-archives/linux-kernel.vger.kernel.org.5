Return-Path: <linux-kernel+bounces-4111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9818B817806
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 18:00:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21B271F22DE6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 17:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0068F5A875;
	Mon, 18 Dec 2023 17:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="2NzGooFI";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="5+NHRIw0";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="TPOcGfSI";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="PUyoqBYL"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45BF498BF
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 17:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E633F1FD4D;
	Mon, 18 Dec 2023 17:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702918802; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z3dMDhEUjiykoFbSfGcXN/uWD6Lqduji9HvcPFOBIvM=;
	b=2NzGooFIjvUSxtKGm/HwRGEGqVE7y2L5zhYQpEDL+4ct0+PM6R87vB/2e5yKvhJngn9v5t
	SAeY3FbNwgksPHTcKsLe2b+GxdOMy+FcRv/xgIdbwaVfD09b46yf4NRUUrOrqPPYkEIHnD
	1kuIPO4//rAsStVmQTtU19SONfsunZM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702918802;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z3dMDhEUjiykoFbSfGcXN/uWD6Lqduji9HvcPFOBIvM=;
	b=5+NHRIw0CQEgjB52hDlC0znZjGGz6BRthUtli5kH1GfnYoA542Csd86TJkD/kd0p6PR/JC
	h+SI1frlb5G6ARAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702918801; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z3dMDhEUjiykoFbSfGcXN/uWD6Lqduji9HvcPFOBIvM=;
	b=TPOcGfSIgCI2ZNKGTOX2Zu2f6eyqUG8GeCXpoTfSU4E9VkaCzfFfR4xbZqfgGVxKK9oVkA
	thus8wZflEmgywuDswUMs9VFG55EZihK6SqcT9BfwyUbiprBj2rtKtrA0csB+hMkBk5mR7
	0UqnV7VrpuK+cEaYPoDUFwuuH3cycMA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702918801;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z3dMDhEUjiykoFbSfGcXN/uWD6Lqduji9HvcPFOBIvM=;
	b=PUyoqBYLIHnD4GfL0fMhNHnfOIsl9ed2hrpXfxl2otHohNP39MX9FqaLibitB2plADLQvt
	Ws+jfU3w6hhFH4DQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id CDC6413927;
	Mon, 18 Dec 2023 17:00:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id x1RHMZF6gGVnDwAAn2gu4w
	(envelope-from <dwagner@suse.de>); Mon, 18 Dec 2023 17:00:01 +0000
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
Subject: [PATCH v6 4/6] nvme: rename ns attribute group
Date: Mon, 18 Dec 2023 17:59:52 +0100
Message-ID: <20231218165954.29652-5-dwagner@suse.de>
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
X-Spam-Score: 1.90
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
	 RCPT_COUNT_SEVEN(0.00)[9];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: *
X-Spam-Flag: NO

Drop the 'id' part of the attribute group name because we want to expose
non 'id' related attributes via the ns attribute group.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/nvme/host/core.c      |  2 +-
 drivers/nvme/host/multipath.c |  2 +-
 drivers/nvme/host/nvme.h      |  2 +-
 drivers/nvme/host/sysfs.c     | 14 +++++++-------
 4 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index e3e997a437d9..ba738ae83cba 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3671,7 +3671,7 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, struct nvme_ns_info *info)
 	up_write(&ctrl->namespaces_rwsem);
 	nvme_get_ctrl(ctrl);
 
-	if (device_add_disk(ctrl->device, ns->disk, nvme_ns_id_attr_groups))
+	if (device_add_disk(ctrl->device, ns->disk, nvme_ns_attr_groups))
 		goto out_cleanup_ns_from_list;
 
 	if (!nvme_ns_head_multipath(ns->head))
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 0a88d7bdc5e3..2dd4137a08b2 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -579,7 +579,7 @@ static void nvme_mpath_set_live(struct nvme_ns *ns)
 	 */
 	if (!test_and_set_bit(NVME_NSHEAD_DISK_LIVE, &head->flags)) {
 		rc = device_add_disk(&head->subsys->dev, head->disk,
-				     nvme_ns_id_attr_groups);
+				     nvme_ns_attr_groups);
 		if (rc) {
 			clear_bit(NVME_NSHEAD_DISK_LIVE, &ns->flags);
 			return;
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 9e5b9e779fbd..919115916449 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -865,7 +865,7 @@ int nvme_ns_head_chr_uring_cmd(struct io_uring_cmd *ioucmd,
 int nvme_getgeo(struct block_device *bdev, struct hd_geometry *geo);
 int nvme_dev_uring_cmd(struct io_uring_cmd *ioucmd, unsigned int issue_flags);
 
-extern const struct attribute_group *nvme_ns_id_attr_groups[];
+extern const struct attribute_group *nvme_ns_attr_groups[];
 extern const struct pr_ops nvme_pr_ops;
 extern const struct block_device_operations nvme_ns_head_ops;
 extern const struct attribute_group nvme_dev_attrs_group;
diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index c6b7fbd4d34d..d682d0a667a0 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -114,7 +114,7 @@ static ssize_t nsid_show(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_RO(nsid);
 
-static struct attribute *nvme_ns_id_attrs[] = {
+static struct attribute *nvme_ns_attrs[] = {
 	&dev_attr_wwid.attr,
 	&dev_attr_uuid.attr,
 	&dev_attr_nguid.attr,
@@ -127,7 +127,7 @@ static struct attribute *nvme_ns_id_attrs[] = {
 	NULL,
 };
 
-static umode_t nvme_ns_id_attrs_are_visible(struct kobject *kobj,
+static umode_t nvme_ns_attrs_are_visible(struct kobject *kobj,
 		struct attribute *a, int n)
 {
 	struct device *dev = container_of(kobj, struct device, kobj);
@@ -157,13 +157,13 @@ static umode_t nvme_ns_id_attrs_are_visible(struct kobject *kobj,
 	return a->mode;
 }
 
-static const struct attribute_group nvme_ns_id_attr_group = {
-	.attrs		= nvme_ns_id_attrs,
-	.is_visible	= nvme_ns_id_attrs_are_visible,
+static const struct attribute_group nvme_ns_attr_group = {
+	.attrs		= nvme_ns_attrs,
+	.is_visible	= nvme_ns_attrs_are_visible,
 };
 
-const struct attribute_group *nvme_ns_id_attr_groups[] = {
-	&nvme_ns_id_attr_group,
+const struct attribute_group *nvme_ns_attr_groups[] = {
+	&nvme_ns_attr_group,
 	NULL,
 };
 
-- 
2.43.0


