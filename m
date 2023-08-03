Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FE7976F32F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 21:03:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233978AbjHCTDR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 15:03:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232342AbjHCTCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 15:02:49 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 112334214
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 12:02:35 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 59004113E;
        Thu,  3 Aug 2023 12:03:18 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3DC7B3F6C4;
        Thu,  3 Aug 2023 12:02:34 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Lucian Paul-Trifu <lucian.paul-trifu@arm.com>,
        Marc Bonnici <marc.bonnici@arm.com>,
        Coboy Chen <coboy.chen@mediatek.com>
Subject: [PATCH RFT 10/12] firmware: arm_ffa: Add interfaces to request notification callbacks
Date:   Thu,  3 Aug 2023 20:02:14 +0100
Message-ID: <20230803-ffa_v1-1_notif-v1-10-6613ff2b1f81@arm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230803-ffa_v1-1_notif-v1-0-6613ff2b1f81@arm.com>
References: <20230803-ffa_v1-1_notif-v1-0-6613ff2b1f81@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=6618; i=sudeep.holla@arm.com; h=from:subject:message-id; bh=qRF9OB5UOVl/Be6YUQOHzq1xMEFWDG0OS9Avnbmk21A=; b=owEBbQKS/ZANAwAIAQBBurwxfuKYAcsmYgBky/iO9aX61DhQFM6JoVap5dmKBG3eS7G5cKSaq NdhCUr47UeJAjMEAAEIAB0WIQS6ceUSBvMeskPdk+EAQbq8MX7imAUCZMv4jgAKCRAAQbq8MX7i mJehEACbjnTfB37YuPYdsBOXuPhf6FQNyCNBdlRuRWfYG7fL2TClyp9hlhGgkg+8FU7oI1SGPqE Bcl0wKOsd0LKRUpV1QdWHyCA3p9EK/+41J/LtXcDXjB9eNSltAW6+EOFG+m2+Zpe15r/WNXnwhx MnQtDjrE++Z1kcmqhzbyLsi6tfxaBKkLh1LGNzm/CIZ7TLe9blNkltWMehbci2DZvrbtAi21YyM xREdgLLEwZRpmr6V+g+i3X70Spd8e5EyzBo6Z/jJV/59vaMEHw+71gu1wWG5Cbn+es4f31LIIo9 3nBWV2KYB57m08F4GxzKHkwlM/Bm4SuOMw/SGwIJuqbprs9L/SoWVlgNeKykqkmulbeIQs8qVaV l/57wWYuTqBZeFovCvz0fjY6rh1jp8sSOZXI27Z0kVU5rXg85k/65lLRQPktl9snGi2f4NX1064 ORxjrnjCUDzx9uUaiQu6NfyqjnTNWxLfLijQrbzLbnSX5NcLrdJHKnY/L6/UgPPaCVszdfbfn1M JseXJt2/6lea5sZd9UWc/gvlLTWgDlfA7Vzh3r4UD9yGF3PZrcvD74+YK+cU3qj/sO7dQJgOE3U /g5pohHD2Vylk2be6Spzujz0uhDEv+sIQa+CVrdDWQEgGy22Vmn7Ilx8zgmpTDhtP2TF71NsjoN aUFAQX7s
 xTEUlJQ==
X-Developer-Key: i=sudeep.holla@arm.com; a=openpgp; fpr=7360A21742ADF5A11767C1C139CFD4755FE2D5B4
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add interface to the FFA driver to allow for client drivers to request
and relinquish a notification as well as provide a callback for the
notification.

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/arm_ffa/driver.c | 130 ++++++++++++++++++++++++++++++++++++++
 include/linux/arm_ffa.h           |   5 ++
 2 files changed, 135 insertions(+)

diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
index 54fca776e5d8..29f69f7010c9 100644
--- a/drivers/firmware/arm_ffa/driver.c
+++ b/drivers/firmware/arm_ffa/driver.c
@@ -27,11 +27,13 @@
 #include <linux/bitfield.h>
 #include <linux/cpuhotplug.h>
 #include <linux/device.h>
+#include <linux/hashtable.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/mm.h>
+#include <linux/mutex.h>
 #include <linux/of_irq.h>
 #include <linux/scatterlist.h>
 #include <linux/slab.h>
@@ -57,6 +59,8 @@
  */
 #define RXTX_BUFFER_SIZE	SZ_4K
 
+#define FFA_MAX_NOTIFICATIONS		64
+
 static ffa_fn *invoke_ffa_fn;
 
 static const int ffa_linux_errmap[] = {
@@ -103,6 +107,8 @@ struct ffa_drv_info {
 	bool info_get_64b;
 	struct xarray partition_info;
 	unsigned int partition_count;
+	DECLARE_HASHTABLE(notifier_hash, ilog2(FFA_MAX_NOTIFICATIONS));
+	struct mutex notify_lock; /* lock to protect notifier hashtable  */
 };
 
 static struct ffa_drv_info *drv_info;
@@ -615,6 +621,9 @@ static int ffa_notification_bitmap_destroy(void)
 #define MAX_IDS_64				20
 #define MAX_IDS_32				10
 
+#define PER_VCPU_NOTIFICATION_FLAG		BIT(0)
+#define ALL_NOTIFICATION_BITMAPS_FLAGS		(0xF)
+
 static int ffa_notification_bind_common(u16 dst_id, u64 bitmap,
 					u32 flags, bool is_bind)
 {
@@ -858,6 +867,13 @@ static int ffa_memory_lend(struct ffa_mem_ops_args *args)
 	return ffa_memory_ops(FFA_MEM_LEND, args);
 }
 
+struct notifier_cb_info {
+	struct hlist_node hnode;
+	ffa_notifier_cb cb;
+	void *cb_data;
+	u16 vm_id;
+};
+
 static int ffa_sched_recv_cb_update(u16 part_id, ffa_sched_recv_cb callback,
 				    void *cb_data, bool is_registration)
 {
@@ -891,6 +907,114 @@ static int ffa_sched_recv_cb_unregister(struct ffa_device *dev)
 	return ffa_sched_recv_cb_update(dev->vm_id, NULL, NULL, false);
 }
 
+static int ffa_notification_bind(u16 dst_id, u64 bitmap, u32 flags)
+{
+	return ffa_notification_bind_common(dst_id, bitmap, flags, true);
+}
+
+static int ffa_notification_unbind(u16 dst_id, u64 bitmap)
+{
+	return ffa_notification_bind_common(dst_id, bitmap, 0, false);
+}
+
+/* Should be called while the notify_lock is taken */
+static struct notifier_cb_info *
+notifier_hash_node_get(u16 part_id, u16 notify_id)
+{
+	struct notifier_cb_info *node;
+
+	hash_for_each_possible(drv_info->notifier_hash, node, hnode, notify_id)
+		if (part_id == node->vm_id)
+			return node;
+
+	return NULL;
+}
+
+static int
+update_notifier_cb(u16 part_id, int notify_id, ffa_notifier_cb cb,
+		   void *cb_data, bool is_registration)
+{
+	struct notifier_cb_info *cb_info = NULL;
+	bool cb_found;
+
+	cb_info = notifier_hash_node_get(part_id, notify_id);
+	cb_found = !!cb_info;
+
+	if (!(is_registration ^ cb_found))
+		return -EINVAL;
+
+	if (is_registration) {
+		cb_info = kzalloc(sizeof(*cb_info), GFP_KERNEL);
+		if (!cb_info)
+			return -ENOMEM;
+
+		cb_info->vm_id = part_id;
+		cb_info->cb = cb;
+		cb_info->cb_data = cb_data;
+
+		hash_add(drv_info->notifier_hash, &cb_info->hnode, notify_id);
+	} else {
+		hash_del(&cb_info->hnode);
+	}
+
+	return 0;
+}
+
+static int ffa_notify_relinquish(struct ffa_device *dev, int notify_id)
+{
+	int rc;
+
+	if (notify_id >= FFA_MAX_NOTIFICATIONS)
+		return -EINVAL;
+
+	mutex_lock(&drv_info->notify_lock);
+
+	rc = update_notifier_cb(dev->vm_id, notify_id, NULL, NULL, false);
+	if (rc) {
+		pr_err("Could not unregister notifcation callback\n");
+		mutex_unlock(&drv_info->notify_lock);
+		return rc;
+	}
+
+	rc = ffa_notification_unbind(dev->vm_id, BIT(notify_id));
+
+	mutex_unlock(&drv_info->notify_lock);
+
+	return rc;
+}
+
+static int ffa_notify_request(struct ffa_device *dev, bool is_per_vcpu,
+			      ffa_notifier_cb cb, void *cb_data, int notify_id)
+{
+	int rc;
+	u32 flags = 0;
+
+	if (notify_id >= FFA_MAX_NOTIFICATIONS)
+		return -EINVAL;
+
+	mutex_lock(&drv_info->notify_lock);
+
+	if (is_per_vcpu)
+		flags = PER_VCPU_NOTIFICATION_FLAG;
+
+	rc = ffa_notification_bind(dev->vm_id, BIT(notify_id), flags);
+	if (rc) {
+		mutex_unlock(&drv_info->notify_lock);
+		return rc;
+	}
+
+	rc = update_notifier_cb(dev->vm_id, notify_id, cb, cb_data, true);
+	if (rc) {
+		pr_err("Failed to register callback for %d - %d\n",
+		       notify_id, rc);
+		ffa_notification_unbind(dev->vm_id, BIT(notify_id));
+		return rc;
+	}
+	mutex_unlock(&drv_info->notify_lock);
+
+	return rc;
+}
+
 static const struct ffa_info_ops ffa_drv_info_ops = {
 	.api_version_get = ffa_api_version_get,
 	.partition_info_get = ffa_partition_info_get,
@@ -914,6 +1038,8 @@ static const struct ffa_cpu_ops ffa_drv_cpu_ops = {
 static const struct ffa_notifier_ops ffa_drv_notifier_ops = {
 	.sched_recv_cb_register = ffa_sched_recv_cb_register,
 	.sched_recv_cb_unregister = ffa_sched_recv_cb_unregister,
+	.notify_request = ffa_notify_request,
+	.notify_relinquish = ffa_notify_relinquish,
 };
 
 static const struct ffa_ops ffa_drv_ops = {
@@ -1182,6 +1308,10 @@ static int ffa_notifications_setup(void)
 		goto cleanup;
 
 	drv_info->sched_recv_irq = irq;
+
+	hash_init(drv_info->notifier_hash);
+	mutex_init(&drv_info->notify_lock);
+
 	return 0;
 cleanup:
 	ffa_notifications_cleanup();
diff --git a/include/linux/arm_ffa.h b/include/linux/arm_ffa.h
index 63f2e1f5fdc4..99440129b733 100644
--- a/include/linux/arm_ffa.h
+++ b/include/linux/arm_ffa.h
@@ -393,10 +393,15 @@ struct ffa_cpu_ops {
 
 typedef void(*ffa_sched_recv_cb)(u16 partition_id, u16 vcpu, bool is_per_vcpu,
 				 void *cb_data);
+typedef void (*ffa_notifier_cb)(u16 part_id, int notify_id, void *cb_data);
+
 struct ffa_notifier_ops {
 	int (*sched_recv_cb_register)(struct ffa_device *dev,
 				      ffa_sched_recv_cb cb, void *cb_data);
 	int (*sched_recv_cb_unregister)(struct ffa_device *dev);
+	int (*notify_request)(struct ffa_device *dev, bool per_vcpu,
+			      ffa_notifier_cb cb, void *cb_data, int notify_id);
+	int (*notify_relinquish)(struct ffa_device *dev, int notify_id);
 };
 
 struct ffa_ops {

-- 
2.41.0

