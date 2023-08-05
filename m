Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BF23770EDF
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 10:41:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbjHEIlw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 04:41:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjHEIlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 04:41:50 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9850E468C
        for <linux-kernel@vger.kernel.org>; Sat,  5 Aug 2023 01:41:48 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RHwzr63xbz4f3lXJ
        for <linux-kernel@vger.kernel.org>; Sat,  5 Aug 2023 16:41:44 +0800 (CST)
Received: from huaweicloud.com (unknown [10.174.178.55])
        by APP4 (Coremail) with SMTP id gCh0CgAHuKtGC85kcXBwPg--.1103S6;
        Sat, 05 Aug 2023 16:41:45 +0800 (CST)
From:   thunder.leizhen@huaweicloud.com
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Cc:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 2/2] kobject: Remove redundant checks for whether ktype is NULL
Date:   Sat,  5 Aug 2023 16:41:14 +0800
Message-Id: <20230805084114.1298-3-thunder.leizhen@huaweicloud.com>
X-Mailer: git-send-email 2.37.3.windows.1
In-Reply-To: <20230805084114.1298-1-thunder.leizhen@huaweicloud.com>
References: <20230805084114.1298-1-thunder.leizhen@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAHuKtGC85kcXBwPg--.1103S6
X-Coremail-Antispam: 1UD129KBjvJXoWxur15ZF48GFyUXw18Jw4xZwb_yoW5GF4kpr
        sxCr9rKFW8Jr4xGwnxAan5Wr10yrn5K398Ca4F9wnavw48Cr90qrWUtFyFvFy5JFWfXrW2
        qa1UKas8tw1UKaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9mb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6r1S6rWUM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
        A2048vs2IY020Ec7CjxVAFwI0_JFI_Gr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
        6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
        Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
        Jr0_Gr1lF7xvr2IYc2Ij64vIr41lw4CEc2x0rVAKj4xxMxAIw28IcxkI7VAKI48JMxC20s
        026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_
        JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14
        v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xva
        j40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr
        0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07jjksgUUUUU=
X-CM-SenderInfo: hwkx0vthuozvpl2kv046kxt4xhlfz01xgou0bp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhen Lei <thunder.leizhen@huawei.com>

When adding koject or kset, we have made sure that ktype cannot be NULL.
Therefore, after adding koject or kset, there is no need to worry about
ktype being NULL. Clear all ktype-related redundancy checks.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 lib/kobject.c | 24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/lib/kobject.c b/lib/kobject.c
index 72fa20f405f1520..59dbcbdb1c916d9 100644
--- a/lib/kobject.c
+++ b/lib/kobject.c
@@ -74,12 +74,10 @@ static int create_dir(struct kobject *kobj)
 	if (error)
 		return error;
 
-	if (ktype) {
-		error = sysfs_create_groups(kobj, ktype->default_groups);
-		if (error) {
-			sysfs_remove_dir(kobj);
-			return error;
-		}
+	error = sysfs_create_groups(kobj, ktype->default_groups);
+	if (error) {
+		sysfs_remove_dir(kobj);
+		return error;
 	}
 
 	/*
@@ -591,8 +589,7 @@ static void __kobject_del(struct kobject *kobj)
 	sd = kobj->sd;
 	ktype = get_ktype(kobj);
 
-	if (ktype)
-		sysfs_remove_groups(kobj, ktype->default_groups);
+	sysfs_remove_groups(kobj, ktype->default_groups);
 
 	/* send "remove" if the caller did not do it but sent "add" */
 	if (kobj->state_add_uevent_sent && !kobj->state_remove_uevent_sent) {
@@ -669,10 +666,6 @@ static void kobject_cleanup(struct kobject *kobj)
 	pr_debug("'%s' (%p): %s, parent %p\n",
 		 kobject_name(kobj), kobj, __func__, kobj->parent);
 
-	if (t && !t->release)
-		pr_debug("'%s' (%p): does not have a release() function, it is broken and must be fixed. See Documentation/core-api/kobject.rst.\n",
-			 kobject_name(kobj), kobj);
-
 	/* remove from sysfs if the caller did not do it */
 	if (kobj->state_in_sysfs) {
 		pr_debug("'%s' (%p): auto cleanup kobject_del\n",
@@ -683,10 +676,13 @@ static void kobject_cleanup(struct kobject *kobj)
 		parent = NULL;
 	}
 
-	if (t && t->release) {
+	if (t->release) {
 		pr_debug("'%s' (%p): calling ktype release\n",
 			 kobject_name(kobj), kobj);
 		t->release(kobj);
+	} else {
+		pr_debug("'%s' (%p): does not have a release() function, it is broken and must be fixed. See Documentation/core-api/kobject.rst.\n",
+			 kobject_name(kobj), kobj);
 	}
 
 	/* free name if we allocated it */
@@ -1060,7 +1056,7 @@ const struct kobj_ns_type_operations *kobj_child_ns_ops(const struct kobject *pa
 {
 	const struct kobj_ns_type_operations *ops = NULL;
 
-	if (parent && parent->ktype && parent->ktype->child_ns_type)
+	if (parent && parent->ktype->child_ns_type)
 		ops = parent->ktype->child_ns_type(parent);
 
 	return ops;
-- 
2.34.1

