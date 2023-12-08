Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B2E280A193
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 11:54:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573748AbjLHKxv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 05:53:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573661AbjLHKxj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 05:53:39 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2a07:de40:b251:101:10:150:64:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB21B171D
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 02:53:45 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 511DA1F38E;
        Fri,  8 Dec 2023 10:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1702032824; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GomM3EpyG/paTprJTV6m4GXtr6dHAbVPRpRzOGdAVqo=;
        b=UXDBekQcmFR08RFL28KodkDcqEQkQGIpXUn7g6M/mMnWc/Dh5K594rtDdwL7vmpQ2pWacB
        7ScjStpGxflx5/3HurNLA1W6KLw/S4e8NPvh9KYqSOxN7IJUbB+eezn2ASApFuzPAKAyQZ
        twV/BxGf8dXBTDTNKoDAOwYArwAsPkY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1702032824;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GomM3EpyG/paTprJTV6m4GXtr6dHAbVPRpRzOGdAVqo=;
        b=LleqCbSbmHNTeIXlM2Ku2YVt1kweVlWKeT2HzehpwoVz3bStCk6LAj2Ld7fSGd3qpLuQv6
        iu+fe3w+VnwM0PDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1702032824; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GomM3EpyG/paTprJTV6m4GXtr6dHAbVPRpRzOGdAVqo=;
        b=UXDBekQcmFR08RFL28KodkDcqEQkQGIpXUn7g6M/mMnWc/Dh5K594rtDdwL7vmpQ2pWacB
        7ScjStpGxflx5/3HurNLA1W6KLw/S4e8NPvh9KYqSOxN7IJUbB+eezn2ASApFuzPAKAyQZ
        twV/BxGf8dXBTDTNKoDAOwYArwAsPkY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1702032824;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GomM3EpyG/paTprJTV6m4GXtr6dHAbVPRpRzOGdAVqo=;
        b=LleqCbSbmHNTeIXlM2Ku2YVt1kweVlWKeT2HzehpwoVz3bStCk6LAj2Ld7fSGd3qpLuQv6
        iu+fe3w+VnwM0PDQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 3DDD3138FF;
        Fri,  8 Dec 2023 10:53:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
        by imap2.dmz-prg2.suse.org with ESMTPSA
        id oAyqDbj1cmU5VgAAn2gu4w
        (envelope-from <dwagner@suse.de>); Fri, 08 Dec 2023 10:53:44 +0000
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>, Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v5 4/6] nvme: rename ns attribute group
Date:   Fri,  8 Dec 2023 11:53:35 +0100
Message-ID: <20231208105337.23409-5-dwagner@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231208105337.23409-1-dwagner@suse.de>
References: <20231208105337.23409-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Score: 0.70
Authentication-Results: smtp-out2.suse.de;
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
         RCPT_COUNT_SEVEN(0.00)[7];
         MID_CONTAINS_FROM(1.00)[];
         DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
         FUZZY_BLOCKED(0.00)[rspamd.com];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-3.00)[100.00%]
X-Spam-Flag: NO
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the 'id' part of the attribute group name because we want to expose
non 'id' related attributes via the ns attribute group.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/nvme/host/core.c      |  2 +-
 drivers/nvme/host/multipath.c |  2 +-
 drivers/nvme/host/nvme.h      |  2 +-
 drivers/nvme/host/sysfs.c     | 14 +++++++-------
 4 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 2468076d64c6..c537914b75e3 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3674,7 +3674,7 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, struct nvme_ns_info *info)
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
index eb748cc3e897..b783b37328fa 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -870,7 +870,7 @@ int nvme_ns_head_chr_uring_cmd(struct io_uring_cmd *ioucmd,
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

