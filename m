Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4273076F32D
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 21:03:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232732AbjHCTDF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 15:03:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231636AbjHCTCs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 15:02:48 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EBE404680
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 12:02:37 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B14581474;
        Thu,  3 Aug 2023 12:03:19 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 95BB03F6C4;
        Thu,  3 Aug 2023 12:02:35 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Lucian Paul-Trifu <lucian.paul-trifu@arm.com>,
        Marc Bonnici <marc.bonnici@arm.com>,
        Coboy Chen <coboy.chen@mediatek.com>
Subject: [PATCH RFT 11/12] firmware: arm_ffa: Add interface to send a notification to a given partition
Date:   Thu,  3 Aug 2023 20:02:15 +0100
Message-ID: <20230803-ffa_v1-1_notif-v1-11-6613ff2b1f81@arm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230803-ffa_v1-1_notif-v1-0-6613ff2b1f81@arm.com>
References: <20230803-ffa_v1-1_notif-v1-0-6613ff2b1f81@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2181; i=sudeep.holla@arm.com; h=from:subject:message-id; bh=8wR5nAQmif3IV58CHUtYI7AoPHUdSNE2CQ+LZOQjskw=; b=owEBbQKS/ZANAwAIAQBBurwxfuKYAcsmYgBky/iOv1HNBdEX3FhKzkZotN+AhpxIqQqaUxIht 4xzQN93ADKJAjMEAAEIAB0WIQS6ceUSBvMeskPdk+EAQbq8MX7imAUCZMv4jgAKCRAAQbq8MX7i mLCpEACLQdZqfIGT2MeCv8uDmtpNpBXhU4pq0R58YJj1iTIeDSW/Sn6pVA5wPRgLDkwUSqZxAoE XbaE4Ewo/KUkXXnLY1kPZfKslpX5hPwgcguJK0fZescHMeK3lBqTCJvHlR7aLk3NboxpxCQyNYI FLOi/NUwsLGmYq3zRyJGzQ8E8Lo6FYVDfI0y7B6yv2GL29PKMcw1NI7dJLpTy/3wBdaEiotCi66 TSFsqrDBFXUwpxzrttsxGRc08EXwLH4Yjg+4cQSFXEdVWGfURKUXlHYHD6ClvTQMdSev5JsIXdZ Pgn4PMT2LLEPX6haBwPFXPIPSpzvAX2mTt6/Qb49aj2Lm3VWVbIosKaehnZg7RAwJhfR+0UdeHy yDtGtlKxNL5CYRg0UeT7G4Fi6h4KVy+IKtgCKeBpYlQvlxfwc2kH6TizN01d+qNwFmEiXKsRBj6 Gy0US0wZmwk8/5IMDUjSTtv3L0JrenLMRjP0dgMPB6jWXK4Kp9TLKD+9/QpRFVdq4fkkJRh9x13 JgiudN1I6fQ4UvPKNJoNmUHNS330p1PAKb4gkUnEBfM9aFL0D2iYw+qwc873m7ReIa5v2QNw9Vz eU8NuzLx7cdXRAooHTejIaQcmXFzuU/GzA/HupcAXQdJCUGFDdm5V3QFVrUIe16m/u/HSVqzPxV +yxpERWJ
 APVWPEg==
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

The framework provides an interface to the sender endpoint to specify
the notification to signal to the receiver endpoint. A sender signals
a notification by requesting its partition manager to set the
corresponding bit in the notifications bitmap of the receiver.

Expose the ability to send a notification to another partition.

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/arm_ffa/driver.c | 13 +++++++++++++
 include/linux/arm_ffa.h           |  2 ++
 2 files changed, 15 insertions(+)

diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
index 29f69f7010c9..d98d0fbe5605 100644
--- a/drivers/firmware/arm_ffa/driver.c
+++ b/drivers/firmware/arm_ffa/driver.c
@@ -1015,6 +1015,18 @@ static int ffa_notify_request(struct ffa_device *dev, bool is_per_vcpu,
 	return rc;
 }
 
+static int ffa_notify_send(struct ffa_device *dev, int notify_id,
+			   bool is_per_vcpu, u16 vcpu)
+{
+	u32 flags = 0;
+
+	if (is_per_vcpu)
+		flags |= (PER_VCPU_NOTIFICATION_FLAG | vcpu << 16);
+
+	return ffa_notification_set(dev->vm_id, drv_info->vm_id, flags,
+				    BIT(notify_id));
+}
+
 static const struct ffa_info_ops ffa_drv_info_ops = {
 	.api_version_get = ffa_api_version_get,
 	.partition_info_get = ffa_partition_info_get,
@@ -1040,6 +1052,7 @@ static const struct ffa_notifier_ops ffa_drv_notifier_ops = {
 	.sched_recv_cb_unregister = ffa_sched_recv_cb_unregister,
 	.notify_request = ffa_notify_request,
 	.notify_relinquish = ffa_notify_relinquish,
+	.notify_send = ffa_notify_send,
 };
 
 static const struct ffa_ops ffa_drv_ops = {
diff --git a/include/linux/arm_ffa.h b/include/linux/arm_ffa.h
index 99440129b733..3bba5f999e4f 100644
--- a/include/linux/arm_ffa.h
+++ b/include/linux/arm_ffa.h
@@ -402,6 +402,8 @@ struct ffa_notifier_ops {
 	int (*notify_request)(struct ffa_device *dev, bool per_vcpu,
 			      ffa_notifier_cb cb, void *cb_data, int notify_id);
 	int (*notify_relinquish)(struct ffa_device *dev, int notify_id);
+	int (*notify_send)(struct ffa_device *dev, int notify_id, bool per_vcpu,
+			   u16 vcpu);
 };
 
 struct ffa_ops {

-- 
2.41.0

