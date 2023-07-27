Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AFB37643AA
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 04:06:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbjG0CGR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 22:06:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbjG0CGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 22:06:13 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A5E21BFF
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 19:06:11 -0700 (PDT)
Received: from kwepemi500024.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RBDYp5CD7ztRcf;
        Thu, 27 Jul 2023 10:02:54 +0800 (CST)
Received: from huawei.com (10.175.103.91) by kwepemi500024.china.huawei.com
 (7.221.188.100) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 27 Jul
 2023 10:06:08 +0800
From:   Zeng Heng <zengheng4@huawei.com>
To:     <catalin.marinas@arm.com>, <will@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <xiexiuqi@huawei.com>,
        <linux-arm-kernel@lists.infradead.org>, <liwei391@huawei.com>,
        <weiyongjun1@huawei.com>
Subject: [PATCH] arm64/Kconfig: Sort the RCpc feature under the ARMv8.3 features menu
Date:   Thu, 27 Jul 2023 10:03:24 +0800
Message-ID: <20230727020324.2149960-1-zengheng4@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500024.china.huawei.com (7.221.188.100)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Moving LDAPR detective config under the ARMv8.3 menu would be more
reasonable than under ARMv8.1, since this feature was released together
with the ARMv8.3 features list.

Signed-off-by: Zeng Heng <zengheng4@huawei.com>
---
 arch/arm64/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 343e1e1cae10..601602add6d3 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1765,9 +1765,6 @@ config ARM64_PAN
 	  The feature is detected at runtime, and will remain as a 'nop'
 	  instruction if the cpu does not implement the feature.
 
-config AS_HAS_LDAPR
-	def_bool $(as-instr,.arch_extension rcpc)
-
 config AS_HAS_LSE_ATOMICS
 	def_bool $(as-instr,.arch_extension lse)
 
@@ -1905,6 +1902,9 @@ config AS_HAS_ARMV8_3
 config AS_HAS_CFI_NEGATE_RA_STATE
 	def_bool $(as-instr,.cfi_startproc\n.cfi_negate_ra_state\n.cfi_endproc\n)
 
+config AS_HAS_LDAPR
+	def_bool $(as-instr,.arch_extension rcpc)
+
 endmenu # "ARMv8.3 architectural features"
 
 menu "ARMv8.4 architectural features"
-- 
2.25.1

