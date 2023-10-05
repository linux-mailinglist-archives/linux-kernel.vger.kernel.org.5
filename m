Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 999EE7BA243
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 17:25:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbjJEPZi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 11:25:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232562AbjJEPZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 11:25:00 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DC1773852
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 07:45:41 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BD3F515A1;
        Thu,  5 Oct 2023 07:46:00 -0700 (PDT)
Received: from e103737-lin.cambridge.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 131023F641;
        Thu,  5 Oct 2023 07:45:20 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
Date:   Thu, 05 Oct 2023 15:45:04 +0100
Subject: [PATCH v4 11/17] firmware: arm_ffa: Add interface to send a
 notification to a given partition
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231005-ffa_v1-1_notif-v4-11-cddd3237809c@arm.com>
References: <20231005-ffa_v1-1_notif-v4-0-cddd3237809c@arm.com>
In-Reply-To: <20231005-ffa_v1-1_notif-v4-0-cddd3237809c@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        Marc Bonnici <marc.bonnici@arm.com>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Coboy Chen <coboy.chen@mediatek.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Olivier Deprez <olivier.deprez@arm.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2181; i=sudeep.holla@arm.com;
 h=from:subject:message-id; bh=iR7xv4zWGKiCOfOTUrWKzr2y6gNM1XQTF7Jjqnppvvw=;
 b=owEBbQKS/ZANAwAIAQBBurwxfuKYAcsmYgBlHsvyUa0kf0qaS0e9Fg2dVQkQFVfR5hK3IAhDQ
 3s8+Y7UIlyJAjMEAAEIAB0WIQS6ceUSBvMeskPdk+EAQbq8MX7imAUCZR7L8gAKCRAAQbq8MX7i
 mCgED/91RGR3wwqUHgbGtWvWw4cfovaRPFwuGja8Cj4hR3egB3+yLDr+TPgjf+wHVIK/ZEs5HFw
 0R+5bItjUQwwU7Y80SQYiSM9FkybAD3kZB1FBRsTl6beRCGLrJ0CklF1pPVOdF5XsSnbRLWhKx0
 jBnxfrKRfPVqjsfN5Yi5f6ULO440sAzg8cg7JtIJWr90zNlP73H+zJ6vXquz6TmeCyi77JF+FST
 yzN+4c8CE8gJf4IhWYCbkNp/nNnNCPjGngtU1+u5h7KLbgThhnTJ8FILeuE+4wIvQo5ZsJCgG63
 bhvLgyIXKeDemXY8cE7Nyjkz2P+sx+1aE5WPUTY+mFTn/3ghi1A1bQj0Ve+k2H/QCzFFNHzxtya
 SLhDDj8FntmyY0B4LG3jPV2AXUXUduTzRZPXHGrylpLBphhEyfFDfzFZ+zvJNGsQdSOOPGEnZqH
 FaAjTBLfPr5z430rzOETAznr6tmCsDwG9i+19z9Tar98vh0XO4SwrMAxqy8VffZtydzvMIsVqPK
 4gVugFVckzfTH7qK/TMMsOI3slkz/eVg/3pDovmx90tjBpkDd5E5nSHTQlD5oQ3GjGEcnDWYbCV
 W2Q6S68e32v6eQhNtRb7Ee5LN6Q4hANzyQg8lkVcWi+i0burck21d8HG7I7T+XIFwSDbCqD4QeZ
 EMS66X/ci5BMM5g==
X-Developer-Key: i=sudeep.holla@arm.com; a=openpgp;
 fpr=7360A21742ADF5A11767C1C139CFD4755FE2D5B4
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
index fc8b29648fb2..2a46052a280a 100644
--- a/drivers/firmware/arm_ffa/driver.c
+++ b/drivers/firmware/arm_ffa/driver.c
@@ -1038,6 +1038,18 @@ static int ffa_notify_request(struct ffa_device *dev, bool is_per_vcpu,
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
@@ -1063,6 +1075,7 @@ static const struct ffa_notifier_ops ffa_drv_notifier_ops = {
 	.sched_recv_cb_unregister = ffa_sched_recv_cb_unregister,
 	.notify_request = ffa_notify_request,
 	.notify_relinquish = ffa_notify_relinquish,
+	.notify_send = ffa_notify_send,
 };
 
 static const struct ffa_ops ffa_drv_ops = {
diff --git a/include/linux/arm_ffa.h b/include/linux/arm_ffa.h
index fb6f388a3737..f6df81f14b6d 100644
--- a/include/linux/arm_ffa.h
+++ b/include/linux/arm_ffa.h
@@ -401,6 +401,8 @@ struct ffa_notifier_ops {
 	int (*notify_request)(struct ffa_device *dev, bool per_vcpu,
 			      ffa_notifier_cb cb, void *cb_data, int notify_id);
 	int (*notify_relinquish)(struct ffa_device *dev, int notify_id);
+	int (*notify_send)(struct ffa_device *dev, int notify_id, bool per_vcpu,
+			   u16 vcpu);
 };
 
 struct ffa_ops {

-- 
2.42.0

