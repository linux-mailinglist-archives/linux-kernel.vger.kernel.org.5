Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AB4E778652
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 05:59:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233360AbjHKD7q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 23:59:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbjHKD7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 23:59:43 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 251E02D5E
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 20:59:42 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RMVRY600Pz4f3mJ8
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 11:59:37 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP4 (Coremail) with SMTP id gCh0CgB3B6opstVkr4O6AQ--.62491S2;
        Fri, 11 Aug 2023 11:59:38 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, baolin.wang@linux.alibaba.com,
        mgorman@techsingularity.net, david@redhat.com, willy@infradead.org
Cc:     shikemeng@huaweicloud.com
Subject: [PATCH 0/2] Two minor cleanups for get pageblock migratetype
Date:   Fri, 11 Aug 2023 19:59:43 +0800
Message-Id: <20230811115945.3423894-1-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgB3B6opstVkr4O6AQ--.62491S2
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
        VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYc7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E
        6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l87I20VAvwVAaII0Ic2I_JF
        v_Gryl8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AK
        xVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67
        AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28I
        cVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx
        0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwAC
        jI8F5VA0II8E6IAqYI8I648v4I1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr
        0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY
        17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcV
        C0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI
        42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWI
        evJa73UjIFyTuYvjTRNgAwUUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all, this series contains two minor cleanups for get pageblock
migratetype. More details can be found in respective pages. Thanks!

Kemeng Shi (2):
  mm/page_alloc: remove unnecessary inner __get_pfnblock_flags_mask
  mm/page_alloc: use get_pfnblock_migratetype to avoid extra page_to_pfn

 mm/page_alloc.c | 34 +++++++++++++---------------------
 1 file changed, 13 insertions(+), 21 deletions(-)

-- 
2.30.0

