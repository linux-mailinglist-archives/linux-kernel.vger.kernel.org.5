Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0655D762B5C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 08:25:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231479AbjGZGZj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 02:25:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjGZGZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 02:25:37 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D94C1982
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 23:25:35 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4R9kR76l4Xz4f3lx5
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 14:25:23 +0800 (CST)
Received: from huaweicloud.com (unknown [10.174.178.55])
        by APP4 (Coremail) with SMTP id gCh0CgBn0LNUvMBk3EtXOw--.15197S4;
        Wed, 26 Jul 2023 14:25:26 +0800 (CST)
From:   thunder.leizhen@huaweicloud.com
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Cc:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH] kobject: Add helper kobj_ns_type_is_valid()
Date:   Wed, 26 Jul 2023 14:25:08 +0800
Message-Id: <20230726062508.950-1-thunder.leizhen@huaweicloud.com>
X-Mailer: git-send-email 2.37.3.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgBn0LNUvMBk3EtXOw--.15197S4
X-Coremail-Antispam: 1UD129KBjvJXoWxuF4DZw4kGFWrCF1kKFy7trb_yoWrXw47pr
        4UurWqqF4DKrW2qw4DXFs8ua4Ykws7AryDGrn8Z3saya1jg3W3Xr1jyFy5u3WjkF4xJFZ7
        W3W5Xa95tw1qyrUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyGb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6r1S6rWUM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4kE6xkIj40Ew7xC0wCF04k20xvY0x0EwIxG
        rwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
        vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IY
        x2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26c
        xKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
        67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8j9aPUUUUU==
X-CM-SenderInfo: hwkx0vthuozvpl2kv046kxt4xhlfz01xgou0bp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhen Lei <thunder.leizhen@huawei.com>

There are too many "(type > KOBJ_NS_TYPE_NONE) && (type < KOBJ_NS_TYPES)"
and "(type <= KOBJ_NS_TYPE_NONE) || (type >= KOBJ_NS_TYPES)", add helper
kobj_ns_type_is_valid() to eliminate duplicate code and improve
readability.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 lib/kobject.c | 33 ++++++++++++++++-----------------
 1 file changed, 16 insertions(+), 17 deletions(-)

diff --git a/lib/kobject.c b/lib/kobject.c
index 16d530f9c174b9d..14e845209226ab8 100644
--- a/lib/kobject.c
+++ b/lib/kobject.c
@@ -56,6 +56,14 @@ void kobject_get_ownership(const struct kobject *kobj, kuid_t *uid, kgid_t *gid)
 		kobj->ktype->get_ownership(kobj, uid, gid);
 }
 
+static bool kobj_ns_type_is_valid(enum kobj_ns_type type)
+{
+	if ((type <= KOBJ_NS_TYPE_NONE) || (type >= KOBJ_NS_TYPES))
+		return false;
+
+	return true;
+}
+
 static int create_dir(struct kobject *kobj)
 {
 	const struct kobj_type *ktype = get_ktype(kobj);
@@ -86,8 +94,7 @@ static int create_dir(struct kobject *kobj)
 	 */
 	ops = kobj_child_ns_ops(kobj);
 	if (ops) {
-		BUG_ON(ops->type <= KOBJ_NS_TYPE_NONE);
-		BUG_ON(ops->type >= KOBJ_NS_TYPES);
+		BUG_ON(!kobj_ns_type_is_valid(ops->type));
 		BUG_ON(!kobj_ns_type_registered(ops->type));
 
 		sysfs_enable_ns(kobj->sd);
@@ -1017,11 +1024,7 @@ int kobj_ns_type_register(const struct kobj_ns_type_operations *ops)
 	spin_lock(&kobj_ns_type_lock);
 
 	error = -EINVAL;
-	if (type >= KOBJ_NS_TYPES)
-		goto out;
-
-	error = -EINVAL;
-	if (type <= KOBJ_NS_TYPE_NONE)
+	if (!kobj_ns_type_is_valid(type))
 		goto out;
 
 	error = -EBUSY;
@@ -1041,7 +1044,7 @@ int kobj_ns_type_registered(enum kobj_ns_type type)
 	int registered = 0;
 
 	spin_lock(&kobj_ns_type_lock);
-	if ((type > KOBJ_NS_TYPE_NONE) && (type < KOBJ_NS_TYPES))
+	if (kobj_ns_type_is_valid(type))
 		registered = kobj_ns_ops_tbl[type] != NULL;
 	spin_unlock(&kobj_ns_type_lock);
 
@@ -1068,8 +1071,7 @@ bool kobj_ns_current_may_mount(enum kobj_ns_type type)
 	bool may_mount = true;
 
 	spin_lock(&kobj_ns_type_lock);
-	if ((type > KOBJ_NS_TYPE_NONE) && (type < KOBJ_NS_TYPES) &&
-	    kobj_ns_ops_tbl[type])
+	if (kobj_ns_type_is_valid(type) && kobj_ns_ops_tbl[type])
 		may_mount = kobj_ns_ops_tbl[type]->current_may_mount();
 	spin_unlock(&kobj_ns_type_lock);
 
@@ -1081,8 +1083,7 @@ void *kobj_ns_grab_current(enum kobj_ns_type type)
 	void *ns = NULL;
 
 	spin_lock(&kobj_ns_type_lock);
-	if ((type > KOBJ_NS_TYPE_NONE) && (type < KOBJ_NS_TYPES) &&
-	    kobj_ns_ops_tbl[type])
+	if (kobj_ns_type_is_valid(type) && kobj_ns_ops_tbl[type])
 		ns = kobj_ns_ops_tbl[type]->grab_current_ns();
 	spin_unlock(&kobj_ns_type_lock);
 
@@ -1095,8 +1096,7 @@ const void *kobj_ns_netlink(enum kobj_ns_type type, struct sock *sk)
 	const void *ns = NULL;
 
 	spin_lock(&kobj_ns_type_lock);
-	if ((type > KOBJ_NS_TYPE_NONE) && (type < KOBJ_NS_TYPES) &&
-	    kobj_ns_ops_tbl[type])
+	if (kobj_ns_type_is_valid(type) && kobj_ns_ops_tbl[type])
 		ns = kobj_ns_ops_tbl[type]->netlink_ns(sk);
 	spin_unlock(&kobj_ns_type_lock);
 
@@ -1108,8 +1108,7 @@ const void *kobj_ns_initial(enum kobj_ns_type type)
 	const void *ns = NULL;
 
 	spin_lock(&kobj_ns_type_lock);
-	if ((type > KOBJ_NS_TYPE_NONE) && (type < KOBJ_NS_TYPES) &&
-	    kobj_ns_ops_tbl[type])
+	if (kobj_ns_type_is_valid(type) && kobj_ns_ops_tbl[type])
 		ns = kobj_ns_ops_tbl[type]->initial_ns();
 	spin_unlock(&kobj_ns_type_lock);
 
@@ -1119,7 +1118,7 @@ const void *kobj_ns_initial(enum kobj_ns_type type)
 void kobj_ns_drop(enum kobj_ns_type type, void *ns)
 {
 	spin_lock(&kobj_ns_type_lock);
-	if ((type > KOBJ_NS_TYPE_NONE) && (type < KOBJ_NS_TYPES) &&
+	if (kobj_ns_type_is_valid(type) &&
 	    kobj_ns_ops_tbl[type] && kobj_ns_ops_tbl[type]->drop_ns)
 		kobj_ns_ops_tbl[type]->drop_ns(ns);
 	spin_unlock(&kobj_ns_type_lock);
-- 
2.34.1

