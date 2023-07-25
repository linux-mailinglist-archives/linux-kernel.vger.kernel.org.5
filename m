Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51C3D761033
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 12:05:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232270AbjGYKF2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 06:05:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233196AbjGYKFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 06:05:01 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2FDB1FC2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 03:04:31 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4R9CLN17NLz4f3kKl
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 18:04:28 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP2 (Coremail) with SMTP id Syh0CgAXC+ksnr9kFkPOOg--.2821S2;
        Tue, 25 Jul 2023 18:04:28 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     willy@infradead.org, baolin.wang@linux.alibaba.com,
        david@redhat.com, shikemeng@huaweicloud.com
Subject: [PATCH RESEND 0/4] minor cleanups for compact lock functions in
Date:   Wed, 26 Jul 2023 02:04:52 +0800
Message-Id: <20230725180456.2146626-1-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgAXC+ksnr9kFkPOOg--.2821S2
X-Coremail-Antispam: 1UD129KBjvdXoWrur47JryxKw45tw1UCF1xXwb_yoWftrb_Aa
        yxJa4Dtw15AFy5JFZ8CFs0yFykKFW8Gr1UJ3Z5Zr45Cr929F1kJanrZw4fXr1YqF9rWws8
        Gw18Jw48uF17CjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbxkFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M28lY4IEw2IIxx
        k0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK
        6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjc
        xK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVAC
        Y4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJV
        W8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI2
        0VAGYxC7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrV
        AFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCI
        c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267
        AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Wr1j6rW3Jr1lIxAIcVC2z280aVAFwI0_
        Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7sRi
        RwZDUUUUU==
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        KHOP_HELO_FCRDNS,MAY_BE_FORGED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all, this series tries to remove repeact lock handle code in
compaction. Patch 1-3 try to make compact_unlock_should_abort
more common and can be used in both isolate_freepages_block and
isolate_migratepages_block. Patch 4 adds a new compact lock function
compact_unlock_irqrestore used along with existing compact_lock_irqsave
to remove repeat code to do compact unlock.
More details can be found in respective patches. Thanks!

Kemeng Shi (4):
  mm/compaction: use "spinlock_t *" to record held lock in compact
    [un]lock functions
  mm/compaction: use "spinlock_t *" to record held lock in
    isolate_migratepages_block
  mm/compaction: use compact_unlock_should_abort in
    isolate_migratepages_block
  mm/compaction: add compact_unlock_irqrestore to remove repeat code

 mm/compaction.c | 85 ++++++++++++++++++-------------------------------
 1 file changed, 31 insertions(+), 54 deletions(-)

-- 
2.30.0

