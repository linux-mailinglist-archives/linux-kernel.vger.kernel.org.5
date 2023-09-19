Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 823B57A69BB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 19:42:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232198AbjISRmE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 13:42:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232384AbjISRlp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 13:41:45 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D10F7131
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 10:41:31 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 030D1C15;
        Tue, 19 Sep 2023 10:42:09 -0700 (PDT)
Received: from e103737-lin.cambridge.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AC2523F5A1;
        Tue, 19 Sep 2023 10:41:30 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
Date:   Tue, 19 Sep 2023 18:40:59 +0100
Subject: [PATCH RFT v2 11/18] firmware: arm_ffa: Add interface to send a
 notification to a given partition
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230919-ffa_v1-1_notif-v2-11-6f3a3ca3923c@arm.com>
References: <20230919-ffa_v1-1_notif-v2-0-6f3a3ca3923c@arm.com>
In-Reply-To: <20230919-ffa_v1-1_notif-v2-0-6f3a3ca3923c@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Marc Bonnici <marc.bonnici@arm.com>,
        Coboy Chen <coboy.chen@mediatek.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Olivier Deprez <olivier.deprez@arm.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2181; i=sudeep.holla@arm.com;
 h=from:subject:message-id; bh=mf13geoyRUVq+k7QY/1WTY0HvW1S38+M9VoghctS2VY=;
 b=owEBbQKS/ZANAwAIAQBBurwxfuKYAcsmYgBlCd074rORL91R/e9bjGTHEFnHip8ToRIvg1XiG
 TM8fH769IaJAjMEAAEIAB0WIQS6ceUSBvMeskPdk+EAQbq8MX7imAUCZQndOwAKCRAAQbq8MX7i
 mIVVD/96c5oId3hsFXU8Px9FTT8Ln6/vK7dSNd8JamLQye/U43K2AT6Cyu8q3dFqyeqQhTdMUZg
 H41PCfQuwkozpqsWOvX2rWgFCzcIRe6eneuvEgkvu695mNghv7K8cDMqaUhWdUPGvdnFVSgeet9
 DmrXWoeId4ZDCFgWWmqnteZx1nEPJrUP7tPEzFswidMazhVrE+omjgPWqy1SVJ7THtP2K1ir83s
 4/WgdyLQT+nUw9vE2qhghORJpJJ7VRFWOo+WjIbC5NYaWBV6z/51r5vhdRCAqopYGP5KZhhhPYu
 OqfTtn5i47sWAcMANVjH8oAcz6BGp0iqkfPeB8bN6F9U4wkt9EOA76/3jCvWqruOaPoFralx3AL
 J0XjIFfcMc9xW76BRWz2eM2ArSgMEnvLPz0NJ7h6F2hlM8kTuHqfbyoE5OzNA2fJXGcwlVC3WWP
 A0QqGaTcAXGg9UiW8qUIx7HA8S8ALIVrwD8Wkjvj/WNPhAyFAkedB8WFh+82yUX5Zovgi7xeH0V
 +O783nfHNcxwzHVLvZ42kXIiSJCSScpXiezYEmhH3MjazXYttFh2eQV2M9xz7Es7vRLfmpc9zcj
 JoSb2+QvEwmlwePjXu5XWRGP1T5Q7vSCaNxIvrMlY7qErop94tvZtfTUAnYkm5Eom7ouR7OiB75
 1Gu+7e5PfgN2GsQ==
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
index 1d61442ca4fa..b95c7979da8d 100644
--- a/drivers/firmware/arm_ffa/driver.c
+++ b/drivers/firmware/arm_ffa/driver.c
@@ -1033,6 +1033,18 @@ static int ffa_notify_request(struct ffa_device *dev, bool is_per_vcpu,
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
@@ -1058,6 +1070,7 @@ static const struct ffa_notifier_ops ffa_drv_notifier_ops = {
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

