Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F21147A69B7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 19:41:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232062AbjISRl2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 13:41:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232089AbjISRl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 13:41:26 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1D632D6
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 10:41:20 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 36282C15;
        Tue, 19 Sep 2023 10:41:57 -0700 (PDT)
Received: from e103737-lin.cambridge.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DE89D3F5A1;
        Tue, 19 Sep 2023 10:41:18 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
Date:   Tue, 19 Sep 2023 18:40:49 +0100
Subject: [PATCH RFT v2 01/18] firmware: arm_ffa: Update the FF-A command
 list with v1.1 additions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230919-ffa_v1-1_notif-v2-1-6f3a3ca3923c@arm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3496; i=sudeep.holla@arm.com;
 h=from:subject:message-id; bh=GwWLoVhrulDY2bwfDeXIMqLT2lw7GQ+ueDJLTgf69i8=;
 b=owEBbQKS/ZANAwAIAQBBurwxfuKYAcsmYgBlCd06kGM6XsrPjDdXez3yDjtxP3Awzq6XK3WwH
 MpW+a9ZgUuJAjMEAAEIAB0WIQS6ceUSBvMeskPdk+EAQbq8MX7imAUCZQndOgAKCRAAQbq8MX7i
 mPVSD/9Kwk/e1SwDW41AbZA2sPkQu95RhBGG4kr4FbqWHyC9moXEzGTQkEfR+jiShfVye2JCRRe
 paeYSlN1XOhMaqaKA3yEhQE1Bj7HH3DVtn8HvCLScSFQ6UeZTSeJyQzi1+1SoesHJsvBsIQVX3+
 pOvgzv9Ax8w1iuRvMlqFgMVjzGRREh+ncoY4Ak/JWRjZ1+NXMvPZMmfe2QvWdCRs0y+KI2r9DJ0
 nB902wEifp5aiRzxYzheknJ37HlDQRrGWtWzcITRq7Ks2E81cB+0DAQOw/opeS+QNlBFPzO2iVX
 GZ0t62vPF2OWniN26mr+qwyb7NmcTmdPh2yqAekq/9VaRUTOBnzoGjUg/q0HqmPoBeMmjI9Rdfk
 5QCSWYXcj8m7cfMRJnKg/CNbkETcPnX+onz5ybvnTyBV8tc9UURnNVrRL7dSSqvDdXy2Kk0TOfd
 zhhVH5kkVZjn/4Ozih97+cW6jdARSAWXG5pyaEDpa9MkhlYvBzdZ/SEEzCQWWUkSTMaHjMBOfhC
 PpIL03zlQthsw4N1/YKg8J4EQA+rfbP8thNJsnf48kc1+Np7kJEqg0Lu0d0FMkAQey+wivf6B84
 zMbbmt5HlU7CIGz0H6DZmeL2+Q/4QBG7p8M+mYcZlDc3UIGYDgVb+34R1kDIp8j7864t2eyUjLk
 VLJq85EOIg4e8Zw==
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
 drivers/firmware/arm_ffa/driver.c |  3 ++-
 include/linux/arm_ffa.h           | 20 ++++++++++++++++++++
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
index 2109cd178ff7..6fc83fa6b81c 100644
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

