Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 544F077360A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 03:50:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbjHHBuK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 21:50:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjHHBuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 21:50:08 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78229F1;
        Mon,  7 Aug 2023 18:50:06 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RKbjP5CKYz4f3k5k;
        Tue,  8 Aug 2023 09:50:01 +0800 (CST)
Received: from vm-fedora-38.huawei.com (unknown [10.67.174.164])
        by APP4 (Coremail) with SMTP id gCh0CgD306ZIn9Fk9jvFAA--.36706S2;
        Tue, 08 Aug 2023 09:50:02 +0800 (CST)
From:   "GONG, Ruiqi" <gongruiqi@huaweicloud.com>
To:     Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        Roopa Prabhu <roopa@nvidia.com>,
        Nikolay Aleksandrov <razor@blackwall.org>,
        Kees Cook <keescook@chromium.org>
Cc:     netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Wang Weiyang <wangweiyang2@huawei.com>,
        Xiu Jianfeng <xiujianfeng@huawei.com>,
        gongruiqi@huaweicloud.com
Subject: [PATCH] netfilter: ebtables: fix fortify warnings
Date:   Tue,  8 Aug 2023 09:48:21 +0800
Message-ID: <20230808014821.241688-1-gongruiqi@huaweicloud.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgD306ZIn9Fk9jvFAA--.36706S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXF1xJw4UCw4xZw1DCw18Grg_yoW5Ww4kpF
        1qka45trWrJ3yakw4fJw1vvr1ruw1kWa43ArW7C34rKFyjqFyDXa9akryjka4kJws09F43
        tr90qFWfWrWDAaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvY14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
        Y2ka0xkIwI1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
        xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
        MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
        0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v2
        6r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0J
        Up6wZUUUUU=
X-CM-SenderInfo: pjrqw2pxltxq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "GONG, Ruiqi" <gongruiqi1@huawei.com>

When compiling with gcc 13 and CONFIG_FORTIFY_SOURCE=y, the following
warning appears:

In function ‘fortify_memcpy_chk’,
    inlined from ‘size_entry_mwt’ at net/bridge/netfilter/ebtables.c:2118:2:
./include/linux/fortify-string.h:592:25: error: call to ‘__read_overflow2_field’
declared with attribute warning: detected read beyond size of field (2nd parameter);
maybe use struct_group()? [-Werror=attribute-warning]
  592 |                         __read_overflow2_field(q_size_field, size);
      |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The compiler is complaining:

memcpy(&offsets[1], &entry->watchers_offset,
                       sizeof(offsets) - sizeof(offsets[0]));

where memcpy reads beyong &entry->watchers_offset to copy
{watchers,target,next}_offset altogether into offsets[]. Silence the
warning by wrapping these three up via struct_group().

Signed-off-by: GONG, Ruiqi <gongruiqi1@huawei.com>
---
 include/uapi/linux/netfilter_bridge/ebtables.h | 14 ++++++++------
 net/bridge/netfilter/ebtables.c                |  3 +--
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/include/uapi/linux/netfilter_bridge/ebtables.h b/include/uapi/linux/netfilter_bridge/ebtables.h
index a494cf43a755..e634da196d08 100644
--- a/include/uapi/linux/netfilter_bridge/ebtables.h
+++ b/include/uapi/linux/netfilter_bridge/ebtables.h
@@ -182,12 +182,14 @@ struct ebt_entry {
 	unsigned char sourcemsk[ETH_ALEN];
 	unsigned char destmac[ETH_ALEN];
 	unsigned char destmsk[ETH_ALEN];
-	/* sizeof ebt_entry + matches */
-	unsigned int watchers_offset;
-	/* sizeof ebt_entry + matches + watchers */
-	unsigned int target_offset;
-	/* sizeof ebt_entry + matches + watchers + target */
-	unsigned int next_offset;
+	struct_group(offsets,
+		/* sizeof ebt_entry + matches */
+		unsigned int watchers_offset;
+		/* sizeof ebt_entry + matches + watchers */
+		unsigned int target_offset;
+		/* sizeof ebt_entry + matches + watchers + target */
+		unsigned int next_offset;
+	);
 	unsigned char elems[0] __attribute__ ((aligned (__alignof__(struct ebt_replace))));
 };
 
diff --git a/net/bridge/netfilter/ebtables.c b/net/bridge/netfilter/ebtables.c
index 757ec46fc45a..5ec66b1ebb64 100644
--- a/net/bridge/netfilter/ebtables.c
+++ b/net/bridge/netfilter/ebtables.c
@@ -2115,8 +2115,7 @@ static int size_entry_mwt(const struct ebt_entry *entry, const unsigned char *ba
 		return ret;
 
 	offsets[0] = sizeof(struct ebt_entry); /* matches come first */
-	memcpy(&offsets[1], &entry->watchers_offset,
-			sizeof(offsets) - sizeof(offsets[0]));
+	memcpy(&offsets[1], &entry->offsets, sizeof(offsets) - sizeof(offsets[0]));
 
 	if (state->buf_kern_start) {
 		buf_start = state->buf_kern_start + state->buf_kern_offset;
-- 
2.41.0

