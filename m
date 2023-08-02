Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 061F476C3AA
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 05:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231858AbjHBDqB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 23:46:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230082AbjHBDp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 23:45:59 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1CC91BC1;
        Tue,  1 Aug 2023 20:45:55 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4RFyYn5bvxz4f3jHr;
        Wed,  2 Aug 2023 11:45:49 +0800 (CST)
Received: from huaweicloud.com (unknown [10.174.178.55])
        by APP4 (Coremail) with SMTP id gCh0CgD3X7Nq0clky7F2PQ--.46299S4;
        Wed, 02 Aug 2023 11:45:51 +0800 (CST)
From:   thunder.leizhen@huaweicloud.com
To:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Zqiang <qiang.zhang1211@gmail.com>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, openeuler <kernel@openeuler.org>
Subject: [PATCH v3 0/2] rcu: Dump memory object info if callback function is invalid
Date:   Wed,  2 Aug 2023 11:45:15 +0800
Message-Id: <20230802034518.1115-1-thunder.leizhen@huaweicloud.com>
X-Mailer: git-send-email 2.37.3.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgD3X7Nq0clky7F2PQ--.46299S4
X-Coremail-Antispam: 1UD129KBjvdXoW7Wr1DKr1rGrWUZF4DZrW8Zwb_yoWkurXEq3
        40q348Xr47XF1xAF1ayFWxXryDCr4kCas2y3y3Kw4Syry3Xa1fZw4DJFn8Za48Za1vyrsF
        kr93Ar9rK3srXjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbxxYFVCjjxCrM7AC8VAFwI0_Xr0_Wr1l1xkIjI8I6I8E6xAIw20E
        Y4v20xvaj40_JFC_Wr1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
        A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x02
        67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
        0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lw4CEc2x0
        rVAKj4xxMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrV
        AFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCI
        c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267
        AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWU
        JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUwV
        bkUUUUU
X-CM-SenderInfo: hwkx0vthuozvpl2kv046kxt4xhlfz01xgou0bp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhen Lei <thunder.leizhen@huawei.com>

v2 --> v3:
1. I made statistics about the source of 'rhp'. kmem_valid_obj() accounts for
   more than 97.5%, and vmalloc accounts for less than 1%. So change call
   mem_dump_obj() to call kmem_dump_obj() can meet debugging requirements and
   avoid the potential deadlock risk of vmalloc_dump_obj().
-		mem_dump_obj(rhp);
+		if (kmem_valid_obj(rhp))
+			kmem_dump_obj(rhp);

   The discussion about vmap_area_lock deadlock in v2:
   https://lkml.org/lkml/2022/11/11/493

2. Provide static inline empty functions for kmem_valid_obj() and kmem_dump_obj()
   when CONFIG_PRINTK=n.

v1 --> v2:
1. Remove condition "(unsigned long)rhp->func & 0x3", it have problems on x86.
2. Paul E. McKenney helped me update the commit message, thanks.

Zhen Lei (2):
  mm: Provide empty function for kmem_dump_obj() when CONFIG_PRINTK=n
  rcu: Dump memory object info if callback function is invalid

 include/linux/slab.h  | 3 +++
 kernel/rcu/rcu.h      | 9 +++++++++
 kernel/rcu/srcutiny.c | 1 +
 kernel/rcu/srcutree.c | 1 +
 kernel/rcu/tasks.h    | 1 +
 kernel/rcu/tiny.c     | 1 +
 kernel/rcu/tree.c     | 1 +
 7 files changed, 17 insertions(+)

-- 
2.34.1

