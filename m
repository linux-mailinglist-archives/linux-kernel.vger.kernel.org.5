Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFF417B363C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 17:03:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233360AbjI2PDW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 11:03:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbjI2PDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 11:03:19 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 289B71A7
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 08:03:16 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4C5CCDA7;
        Fri, 29 Sep 2023 08:03:54 -0700 (PDT)
Received: from e103737-lin.cambridge.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E98F73F5A1;
        Fri, 29 Sep 2023 08:03:14 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
Date:   Fri, 29 Sep 2023 16:02:50 +0100
Subject: [PATCH v3 01/17] firmware: arm_ffa: Update the FF-A command list
 with v1.1 additions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230929-ffa_v1-1_notif-v3-1-c8e4f15190c8@arm.com>
References: <20230929-ffa_v1-1_notif-v3-0-c8e4f15190c8@arm.com>
In-Reply-To: <20230929-ffa_v1-1_notif-v3-0-c8e4f15190c8@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        Marc Bonnici <marc.bonnici@arm.com>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Coboy Chen <coboy.chen@mediatek.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Olivier Deprez <olivier.deprez@arm.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3496; i=sudeep.holla@arm.com;
 h=from:subject:message-id; bh=iM0M4h4uY9LcS7jhU1Ni5Kw/SdOd9wlQU64B4wmmDx0=;
 b=owEBbQKS/ZANAwAIAQBBurwxfuKYAcsmYgBlFucupa6nu79ubQS1rGE5x6xDF2tzzi8ymkczB
 +9PQ0u0UjSJAjMEAAEIAB0WIQS6ceUSBvMeskPdk+EAQbq8MX7imAUCZRbnLgAKCRAAQbq8MX7i
 mLjEEACOITJFey81YFZaZ4P1XZfaKQl3vuVT1PteZN8+r24U0QvVP6mibtqsrCl4IdmaN7ZeoOr
 xxRNx4r5EnDIuJuLiHKXEl4jOmQ/Nal4jRKeXZpWy+dDikzbxmi+heZT+Mkp9PPhVpIj5XRYUf3
 ToQCVjUw8W65uU8pfa+btq9MRmhiNj5Umv8tq4QqoTXmm6YSrdws7xDcWpm2V7Q0VjgWYouKGin
 GgAnZWoqx6Xw3rNqqtEjiPbgT1mwJykkw7aqvrJ00Bn4zMdH8iCVlIQj6jVppgcL3a5brKuMCyQ
 Bs5xmJE3dirLFz9V/YDPKMgQHKCdEJ6zEbO8xc+R7g6MIDAYGpUZIRz0xCQFqWpGeKLP3oZO0g7
 +V3CuTyV8w9CbkylNAA4U9JRUejXay1ozQaXFx3+sAlWNKLXWaKKx1YChwuyMAFmP3yXd+J9kxH
 Bj75RFUQpOObva2z1SqAebRDPchCO5G+O1SK/llnjNYBTxlEsoQZGQJSiZpJWxLz0a2ALsiYyQV
 XhTyOCHWoOC1oMLCmCU+y3GQBbEsQn5z46OkEj4pkuZlpz1KccE+hCxvNc4mFIzqX/Q4p3kgwKA
 he1B8mEgOID8KJ5607k6eyvN3pV2ZWPiRSwiaNzG1G9VhZ1/XvSto3MF7DqcdeXUOt8alvTZh+r
 pLzgvyV8EwSxujw==
X-Developer-Key: i=sudeep.holla@arm.com; a=openpgp;
 fpr=7360A21742ADF5A11767C1C139CFD4755FE2D5B4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
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
 drivers/firmware/arm_ffa/driver.c |  3 ++-
 include/linux/arm_ffa.h           | 20 ++++++++++++++++++++
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
index 121f4fc903cd..2b24cda2a185 100644
--- a/drivers/firmware/arm_ffa/driver.c
+++ b/drivers/firmware/arm_ffa/driver.c
@@ -64,6 +64,7 @@ static const int ffa_linux_errmap[] = {
 	-EACCES,	/* FFA_RET_DENIED */
 	-EAGAIN,	/* FFA_RET_RETRY */
 	-ECANCELED,	/* FFA_RET_ABORTED */
+	-ENODATA,	/* FFA_RET_NO_DATA */
 };
 
 static inline int ffa_to_linux_errno(int errno)
@@ -336,7 +337,7 @@ static int ffa_mem_first_frag(u32 func_id, phys_addr_t buf, u32 buf_sz,
 	if (ret.a0 == FFA_ERROR)
 		return ffa_to_linux_errno((int)ret.a2);
 
-	if (ret.a0 == FFA_SUCCESS) {
+	if (ret.a0 == FFA_SUCCESS || ret.a0 == FFA_FN64_SUCCESS) {
 		if (handle)
 			*handle = PACK_HANDLE(ret.a2, ret.a3);
 	} else if (ret.a0 == FFA_MEM_FRAG_RX) {
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

