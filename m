Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CFC17AF8D1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 05:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbjI0DsI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 23:48:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbjI0DqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 23:46:05 -0400
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1020E1BC3;
        Tue, 26 Sep 2023 18:02:11 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0Vsy7KZH_1695776528;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0Vsy7KZH_1695776528)
          by smtp.aliyun-inc.com;
          Wed, 27 Sep 2023 09:02:09 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     geert+renesas@glider.be, magnus.damm@gmail.com
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] ARM: shmobile: Remove unneeded semicolon
Date:   Wed, 27 Sep 2023 09:02:07 +0800
Message-Id: <20230927010207.78326-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

./arch/arm/mach-shmobile/smp-sh73a0.c:52:2-3: Unneeded semicolon
./arch/arm/mach-shmobile/smp-r8a7779.c:46:2-3: Unneeded semicolon
./arch/arm/mach-shmobile/pm-rcar-gen2.c:58:2-3: Unneeded semicolon

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=6704
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 arch/arm/mach-shmobile/pm-rcar-gen2.c | 2 +-
 arch/arm/mach-shmobile/smp-r8a7779.c  | 2 +-
 arch/arm/mach-shmobile/smp-sh73a0.c   | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-shmobile/pm-rcar-gen2.c b/arch/arm/mach-shmobile/pm-rcar-gen2.c
index 3453d5733224..907a4f8c5aed 100644
--- a/arch/arm/mach-shmobile/pm-rcar-gen2.c
+++ b/arch/arm/mach-shmobile/pm-rcar-gen2.c
@@ -55,7 +55,7 @@ void __init rcar_gen2_pm_init(void)
 	if (!request_mem_region(0, SZ_256K, "Boot Area")) {
 		pr_err("Failed to request boot area\n");
 		return;
-	};
+	}
 
 	for_each_of_cpu_node(np) {
 		if (of_device_is_compatible(np, "arm,cortex-a15"))
diff --git a/arch/arm/mach-shmobile/smp-r8a7779.c b/arch/arm/mach-shmobile/smp-r8a7779.c
index 2b1b8248450c..474c325323a3 100644
--- a/arch/arm/mach-shmobile/smp-r8a7779.c
+++ b/arch/arm/mach-shmobile/smp-r8a7779.c
@@ -43,7 +43,7 @@ static void __init r8a7779_smp_prepare_cpus(unsigned int max_cpus)
 	if (!request_mem_region(0, SZ_4K, "Boot Area")) {
 		pr_err("Failed to request boot area\n");
 		return;
-	};
+	}
 
 	base = ioremap(HPBREG_BASE, 0x1000);
 
diff --git a/arch/arm/mach-shmobile/smp-sh73a0.c b/arch/arm/mach-shmobile/smp-sh73a0.c
index 3757aed64c42..9196b37ea292 100644
--- a/arch/arm/mach-shmobile/smp-sh73a0.c
+++ b/arch/arm/mach-shmobile/smp-sh73a0.c
@@ -49,7 +49,7 @@ static void __init sh73a0_smp_prepare_cpus(unsigned int max_cpus)
 	if (!request_mem_region(0, SZ_4K, "Boot Area")) {
 		pr_err("Failed to request boot area\n");
 		return;
-	};
+	}
 
 	/* Map the reset vector (in headsmp.S) */
 	ap = ioremap(AP_BASE, PAGE_SIZE);
-- 
2.20.1.7.g153144c

