Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F85A7C630E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 04:49:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376933AbjJLCt1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 22:49:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376775AbjJLCsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 22:48:55 -0400
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42F78B6
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 19:48:53 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R561e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=rongwei.wang@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0VtykMgi_1697078930;
Received: from localhost.localdomain(mailfrom:rongwei.wang@linux.alibaba.com fp:SMTPD_---0VtykMgi_1697078930)
          by smtp.aliyun-inc.com;
          Thu, 12 Oct 2023 10:48:51 +0800
From:   Rongwei Wang <rongwei.wang@linux.alibaba.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, willy@infradead.org,
        catalin.marinas@arm.com, dave.hansen@linux.intel.com,
        tj@kernel.org, mingo@redhat.com
Subject: [PATCH RFC 3/5] arch_numa: remove __init in early_cpu_to_node()
Date:   Thu, 12 Oct 2023 10:48:40 +0800
Message-Id: <20231012024842.99703-4-rongwei.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20231012024842.99703-1-rongwei.wang@linux.alibaba.com>
References: <20231012024842.99703-1-rongwei.wang@linux.alibaba.com>
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

Most of arch does not stick '__init' for
early_cpu_to_node(). And it's safe to
delete this attribute here, ready for
later numa emulation.

Signed-off-by: Rongwei Wang <rongwei.wang@linux.alibaba.com>
---
 drivers/base/arch_numa.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/arch_numa.c b/drivers/base/arch_numa.c
index db0bb8b8fd67..5df0ad5cb09d 100644
--- a/drivers/base/arch_numa.c
+++ b/drivers/base/arch_numa.c
@@ -144,7 +144,7 @@ void __init early_map_cpu_to_node(unsigned int cpu, int nid)
 unsigned long __per_cpu_offset[NR_CPUS] __read_mostly;
 EXPORT_SYMBOL(__per_cpu_offset);
 
-static int __init early_cpu_to_node(unsigned int cpu)
+int early_cpu_to_node(unsigned int cpu)
 {
 	return cpu_to_node_map[cpu];
 }
-- 
2.32.0.3.gf3a3e56d6

