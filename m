Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 905097BA230
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 17:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231599AbjJEPTq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 11:19:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232999AbjJEPTD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 11:19:03 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9C32A3850
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 07:45:10 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B3951DA7;
        Thu,  5 Oct 2023 07:45:48 -0700 (PDT)
Received: from e103737-lin.cambridge.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 099FA3F641;
        Thu,  5 Oct 2023 07:45:08 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
Date:   Thu, 05 Oct 2023 15:44:54 +0100
Subject: [PATCH v4 01/17] firmware: arm_ffa: Update the FF-A command list
 with v1.1 additions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231005-ffa_v1-1_notif-v4-1-cddd3237809c@arm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3114; i=sudeep.holla@arm.com;
 h=from:subject:message-id; bh=278KahauozE45XUUmHl11QnvUebKx7Dm6zTUaEvv3Cs=;
 b=owEBbQKS/ZANAwAIAQBBurwxfuKYAcsmYgBlHsvwExh2e02foBJMzeMrAazRi+haUyLVwCFry
 sj7SSL7VMWJAjMEAAEIAB0WIQS6ceUSBvMeskPdk+EAQbq8MX7imAUCZR7L8AAKCRAAQbq8MX7i
 mMeED/4pLumUe+LTTAquMVWC2OYtNXXQuLnLgaiSrgDLjpPeCYpasHYXpdF6zFoqoExrlcgrGFp
 gkByGXQSVkqoDUz4nilUhFkxHbVuLqyZ1z604MEe5xJkUDd1OXodi/gP53BfHKU81GzddyzHey0
 JaICJRZqPdChQV2sOXbwraD9LffsenQCB6tbu2GvZ6b+b/QENbErv+gIw8dOj0X9yitqJOmTPge
 3JVsxo8alTbZl6Z9Mn8JOQxt1JsLw4BsNCnShWXR+tBKX2wIpIEUXyx1ItzApPqbMiqFc8GZZEn
 ZLcY7qwpDU6FvfrSf41pTpc/Ql+iSosMdup7Z5Qe1FUVMgpWtR7F9dFQ/+XmOYaQibkyygUhJOa
 cXl5DCthQ6kGxbrtABxpDNfC/B7uE71gLxpQjwAr4bkOxPcVvYg8S5ndxlBvWBrbiqCNQ1nEMSG
 trn/8ofng02cTJqQyrlLS0vYF0Mwl3HfaivO7n0S/BgGQR1KeKNR38IaDKS/G22sYGUyE0bBLwT
 Yj515gl2lFlLYCEebRc9VcUhQuI+FSgfXDAG0CwPY/2kglmaHfAO2HeZS+gFz9OFhRrE/R451Hm
 oym3CG+WkD0iSxY87/WZq3VWdUogn2+F0W2WOfMfHQyXV+I/R4pLrOaret/D2Zh+1sevtSxVQMA
 hJPBFpxiyt0IUbQ==
X-Developer-Key: i=sudeep.holla@arm.com; a=openpgp;
 fpr=7360A21742ADF5A11767C1C139CFD4755FE2D5B4
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arm Firmware Framework for A-profile(FFA) v1.1 introduces notifications
and indirect messaging based upon notifications support and extends some
of the memory interfaces.

Let us add all the newly supported FF-A function IDs in the spec.
Also update to the error values and associated handling.

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/arm_ffa/driver.c |  1 +
 include/linux/arm_ffa.h           | 20 ++++++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
index 7cd6b1564e80..a64512388ea5 100644
--- a/drivers/firmware/arm_ffa/driver.c
+++ b/drivers/firmware/arm_ffa/driver.c
@@ -64,6 +64,7 @@ static const int ffa_linux_errmap[] = {
 	-EACCES,	/* FFA_RET_DENIED */
 	-EAGAIN,	/* FFA_RET_RETRY */
 	-ECANCELED,	/* FFA_RET_ABORTED */
+	-ENODATA,	/* FFA_RET_NO_DATA */
 };
 
 static inline int ffa_to_linux_errno(int errno)
diff --git a/include/linux/arm_ffa.h b/include/linux/arm_ffa.h
index cc060da51bec..2ea1717a0825 100644
--- a/include/linux/arm_ffa.h
+++ b/include/linux/arm_ffa.h
@@ -20,6 +20,7 @@
 
 #define FFA_ERROR			FFA_SMC_32(0x60)
 #define FFA_SUCCESS			FFA_SMC_32(0x61)
+#define FFA_FN64_SUCCESS		FFA_SMC_64(0x61)
 #define FFA_INTERRUPT			FFA_SMC_32(0x62)
 #define FFA_VERSION			FFA_SMC_32(0x63)
 #define FFA_FEATURES			FFA_SMC_32(0x64)
@@ -54,6 +55,23 @@
 #define FFA_MEM_FRAG_RX			FFA_SMC_32(0x7A)
 #define FFA_MEM_FRAG_TX			FFA_SMC_32(0x7B)
 #define FFA_NORMAL_WORLD_RESUME		FFA_SMC_32(0x7C)
+#define FFA_NOTIFICATION_BITMAP_CREATE	FFA_SMC_32(0x7D)
+#define FFA_NOTIFICATION_BITMAP_DESTROY FFA_SMC_32(0x7E)
+#define FFA_NOTIFICATION_BIND		FFA_SMC_32(0x7F)
+#define FFA_NOTIFICATION_UNBIND		FFA_SMC_32(0x80)
+#define FFA_NOTIFICATION_SET		FFA_SMC_32(0x81)
+#define FFA_NOTIFICATION_GET		FFA_SMC_32(0x82)
+#define FFA_NOTIFICATION_INFO_GET	FFA_SMC_32(0x83)
+#define FFA_FN64_NOTIFICATION_INFO_GET	FFA_SMC_64(0x83)
+#define FFA_RX_ACQUIRE			FFA_SMC_32(0x84)
+#define FFA_SPM_ID_GET			FFA_SMC_32(0x85)
+#define FFA_MSG_SEND2			FFA_SMC_32(0x86)
+#define FFA_SECONDARY_EP_REGISTER	FFA_SMC_32(0x87)
+#define FFA_FN64_SECONDARY_EP_REGISTER	FFA_SMC_64(0x87)
+#define FFA_MEM_PERM_GET		FFA_SMC_32(0x88)
+#define FFA_FN64_MEM_PERM_GET		FFA_SMC_64(0x88)
+#define FFA_MEM_PERM_SET		FFA_SMC_32(0x89)
+#define FFA_FN64_MEM_PERM_SET		FFA_SMC_64(0x89)
 
 /*
  * For some calls it is necessary to use SMC64 to pass or return 64-bit values.
@@ -76,6 +94,7 @@
 #define FFA_RET_DENIED             (-6)
 #define FFA_RET_RETRY              (-7)
 #define FFA_RET_ABORTED            (-8)
+#define FFA_RET_NO_DATA            (-9)
 
 /* FFA version encoding */
 #define FFA_MAJOR_VERSION_MASK	GENMASK(30, 16)
@@ -86,6 +105,7 @@
 	(FIELD_PREP(FFA_MAJOR_VERSION_MASK, (major)) |		\
 	 FIELD_PREP(FFA_MINOR_VERSION_MASK, (minor)))
 #define FFA_VERSION_1_0		FFA_PACK_VERSION_INFO(1, 0)
+#define FFA_VERSION_1_1		FFA_PACK_VERSION_INFO(1, 1)
 
 /**
  * FF-A specification mentions explicitly about '4K pages'. This should

-- 
2.42.0

