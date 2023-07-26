Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8306C762E43
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 09:44:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbjGZHob (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 03:44:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230140AbjGZHnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 03:43:53 -0400
Received: from frasgout11.his.huawei.com (unknown [14.137.139.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 580D244B6;
        Wed, 26 Jul 2023 00:39:32 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.227])
        by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4R9lqX53bRz9v7VL;
        Wed, 26 Jul 2023 15:28:08 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
        by APP2 (Coremail) with SMTP id GxC2BwA3CmGhzcBkURUHBQ--.31802S2;
        Wed, 26 Jul 2023 08:39:19 +0100 (CET)
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v2] security: Fix ret values doc for security_inode_init_security()
Date:   Wed, 26 Jul 2023 09:39:05 +0200
Message-Id: <20230726073905.1175826-1-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GxC2BwA3CmGhzcBkURUHBQ--.31802S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Zr1xKr17tFWUZr47ZrWxCrg_yoW8Xw1fpw
        4UKFyjgr15tFy7Wrn5AF47u3WSkay5Gr4UGrs8Zr17A3WDurn3tr4FyF15ury3XrWUAw10
        qw42kF43Jr1DAw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUgEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Y
        z7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zV
        AF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4l
        IxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WF
        yUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIY
        CTnIWIevJa73UjIFyTuYvjxUOyCJDUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAKBF1jj5DyKwAAs3
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        MAY_BE_FORGED,RCVD_IN_MSPIKE_BL,RCVD_IN_MSPIKE_L3,RDNS_DYNAMIC,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roberto Sassu <roberto.sassu@huawei.com>

Commit 6bcdfd2cac55 ("security: Allow all LSMs to provide xattrs for
inode_init_security hook") unified the !initxattrs and initxattrs cases. By
doing that, security_inode_init_security() cannot return -EOPNOTSUPP
anymore, as it is always replaced with zero at the end of the function.

Also, mentioning -ENOMEM as the only possible error is not correct. For
example, evm_inode_init_security() could return -ENOKEY.

Fix these issues in the documentation of security_inode_init_security().

Fixes: 6bcdfd2cac55 ("security: Allow all LSMs to provide xattrs for inode_init_security hook")
Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 security/security.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/security.c b/security/security.c
index cfdd0cbbcb9..f86567083e6 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1604,8 +1604,8 @@ EXPORT_SYMBOL(security_dentry_create_files_as);
  * a security attribute on this particular inode, then it should return
  * -EOPNOTSUPP to skip this processing.
  *
- * Return: Returns 0 on success, -EOPNOTSUPP if no security attribute is
- * needed, or -ENOMEM on memory allocation failure.
+ * Return: Returns 0 if the LSM successfully initialized all of the inode
+ *         security attributes that are required, negative values otherwise.
  */
 int security_inode_init_security(struct inode *inode, struct inode *dir,
 				 const struct qstr *qstr,
-- 
2.34.1

