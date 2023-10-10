Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EDE17BF43B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 09:26:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442668AbjJJHYk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 03:24:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442499AbjJJHXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 03:23:47 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE63FB4;
        Tue, 10 Oct 2023 00:23:44 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4S4S7H4KXGz4f3mHl;
        Tue, 10 Oct 2023 15:23:39 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgDHXd31+yRl1AZbCg--.36859S19;
        Tue, 10 Oct 2023 15:23:42 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     song@kernel.org, xni@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com,
        yangerkun@huawei.com
Subject: [PATCH -next v4 15/19] md/md-linear: cleanup linear_add()
Date:   Tue, 10 Oct 2023 23:19:54 +0800
Message-Id: <20231010151958.145896-16-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231010151958.145896-1-yukuai1@huaweicloud.com>
References: <20231010151958.145896-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgDHXd31+yRl1AZbCg--.36859S19
X-Coremail-Antispam: 1UD129KBjvdXoWrKF17uw18ur13CFWUCrW8tFb_yoWktrbE9F
        4Du397Ar1UXry7Zr1Yvw4SvF90qryDWw1kZFySgr9aya48Xw1xAr95Jr45A3srZayfGay5
        Kryxtw4ftr48tjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbqxFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M28IrcIa0xkI8V
        A2jI8067AKxVWUAVCq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJ
        M28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2I
        x0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK
        6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4
        xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8
        JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20V
        AGYxC7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
        wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc4
        0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267AK
        xVW8Jr0_Cr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JV
        WxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7sRiVb
        yDUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

Now that caller already suspend the array, there is no need to suspend
array in liner_add().

Note that mddev_suspend/resume() is not used anymore.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/md-linear.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/md/md-linear.c b/drivers/md/md-linear.c
index ae2826e9645b..8eca7693b793 100644
--- a/drivers/md/md-linear.c
+++ b/drivers/md/md-linear.c
@@ -183,7 +183,6 @@ static int linear_add(struct mddev *mddev, struct md_rdev *rdev)
 	 * in linear_congested(), therefore kfree_rcu() is used to free
 	 * oldconf until no one uses it anymore.
 	 */
-	mddev_suspend(mddev);
 	oldconf = rcu_dereference_protected(mddev->private,
 			lockdep_is_held(&mddev->reconfig_mutex));
 	mddev->raid_disks++;
@@ -192,7 +191,6 @@ static int linear_add(struct mddev *mddev, struct md_rdev *rdev)
 	rcu_assign_pointer(mddev->private, newconf);
 	md_set_array_sectors(mddev, linear_size(mddev, 0, 0));
 	set_capacity_and_notify(mddev->gendisk, mddev->array_sectors);
-	mddev_resume(mddev);
 	kfree_rcu(oldconf, rcu);
 	return 0;
 }
-- 
2.39.2

