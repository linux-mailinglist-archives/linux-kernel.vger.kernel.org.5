Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78A287BA23F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 17:23:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232243AbjJEPXp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 11:23:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232787AbjJEPXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 11:23:08 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1783F93FE
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 07:45:58 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 69AD6165C;
        Thu,  5 Oct 2023 07:46:08 -0700 (PDT)
Received: from e103737-lin.cambridge.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B40EF3F641;
        Thu,  5 Oct 2023 07:45:28 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
Date:   Thu, 05 Oct 2023 15:45:10 +0100
Subject: [PATCH v4 17/17] firmware: arm_ffa: Upgrade the driver version to
 v1.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231005-ffa_v1-1_notif-v4-17-cddd3237809c@arm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=687; i=sudeep.holla@arm.com;
 h=from:subject:message-id; bh=8SIeTzl6vfeVnSukOY6SLPu6xQWTGCA8RlmB08AfRzE=;
 b=owEBbQKS/ZANAwAIAQBBurwxfuKYAcsmYgBlHsvztoI4de2Cc5nOvWVIziqQtyYMiDZMOD3tc
 WBouUU3Wx6JAjMEAAEIAB0WIQS6ceUSBvMeskPdk+EAQbq8MX7imAUCZR7L8wAKCRAAQbq8MX7i
 mFhDD/4jQiafvyRrcC2b2LaGjuEUPeCodEI/rRe0nBjODHCAqzlejdqSphbj+vL6tH8E/yNs0yI
 0bNJi1s4p9YxYGBoCSecB0t/OIrstLVWiJE3Kx5sMb9Qm0/h5UG9ZXjy+TlT+zwYxb0HmfxBxtA
 G+wRUxur9rOh0IZECNkx6p0MYNCSHKg0PEOXbBVpxFsfgtqVS/38AqUyoH0eDHZpQAsaTJqBzaJ
 p1kJbcPknG6P4uRvrvkvTTNS9O3rBIadKkNDQJ6IAgFqNoNCAIPktl9rldt9mXZEKDe+Nw3uhwn
 vcF/9PcceCIjNhlWas42vsC1HA7HoWiLQSrnRvDV90Q+iDp2mjdTrQBEYxinT8sLrEZ7IAFLOnm
 aJ0Y/AhrvlbWXPnyVcdewKn+u7+d0+cgLPYX1qKyZmZHTGJweggDqTwwhIkV+BVxZQ8hWQ62dEN
 j02d9aFkqeFvNk5dQT2BT6+Hsye6c69eP7ZqLGgUzTmiOVPh4zkq/BIP2SThzMf/AHFfIO8Xkes
 vXirXf1P2uk6XilG4P8hEAljGjdFnxzTf9I2y1Ql/BuBXTpYm+WLKmwEQpB3tOKWT2NKd6UhswJ
 ulieKWOpF7ll6xkWPR2VNLcDJvygLs8K8AhLWdeWhkkVLMsOQHlv4yAg2L1ARvtN/h5Qh2q+R/P
 Qj9KybnRjVCtntA==
X-Developer-Key: i=sudeep.holla@arm.com; a=openpgp;
 fpr=7360A21742ADF5A11767C1C139CFD4755FE2D5B4
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With quite a few v1.1 features supported, we can bump the driver version
to v1.1 now.

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/arm_ffa/driver.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
index 7b3db675454c..7b6fa6a2781d 100644
--- a/drivers/firmware/arm_ffa/driver.c
+++ b/drivers/firmware/arm_ffa/driver.c
@@ -43,7 +43,7 @@
 
 #include "common.h"
 
-#define FFA_DRIVER_VERSION	FFA_VERSION_1_0
+#define FFA_DRIVER_VERSION	FFA_VERSION_1_1
 #define FFA_MIN_VERSION		FFA_VERSION_1_0
 
 #define SENDER_ID_MASK		GENMASK(31, 16)

-- 
2.42.0

