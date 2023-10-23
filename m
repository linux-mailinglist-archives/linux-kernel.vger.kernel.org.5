Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34BD97D27D1
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 03:11:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232984AbjJWBLi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 21:11:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232970AbjJWBLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 21:11:34 -0400
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD0C6ED;
        Sun, 22 Oct 2023 18:11:31 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R291e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0Vucq0b9_1698023488;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0Vucq0b9_1698023488)
          by smtp.aliyun-inc.com;
          Mon, 23 Oct 2023 09:11:28 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     john.johansen@canonical.com, paul@paul-moore.com,
        jmorris@namei.org, serge@hallyn.com
Cc:     apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next 2/2] apparmor: Fix some kernel-doc comments
Date:   Mon, 23 Oct 2023 09:11:24 +0800
Message-Id: <20231023011124.19034-2-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
In-Reply-To: <20231023011124.19034-1-yang.lee@linux.alibaba.com>
References: <20231023011124.19034-1-yang.lee@linux.alibaba.com>
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

Fix some kernel-doc comments to silence the warnings:
security/apparmor/policy.c:117: warning: Function parameter or member 'kref' not described in 'aa_pdb_free_kref'
security/apparmor/policy.c:117: warning: Excess function parameter 'kr' description in 'aa_pdb_free_kref'
security/apparmor/policy.c:882: warning: Function parameter or member 'subj_cred' not described in 'aa_may_manage_policy'

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=7037
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 security/apparmor/policy.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/apparmor/policy.c b/security/apparmor/policy.c
index a441d96adcbf..ed4c9803c8fa 100644
--- a/security/apparmor/policy.c
+++ b/security/apparmor/policy.c
@@ -111,7 +111,7 @@ static void aa_free_pdb(struct aa_policydb *policy)
 
 /**
  * aa_pdb_free_kref - free aa_policydb by kref (called by aa_put_pdb)
- * @kr: kref callback for freeing of a dfa  (NOT NULL)
+ * @kref: kref callback for freeing of a dfa  (NOT NULL)
  */
 void aa_pdb_free_kref(struct kref *kref)
 {
@@ -870,7 +870,7 @@ bool aa_current_policy_admin_capable(struct aa_ns *ns)
 
 /**
  * aa_may_manage_policy - can the current task manage policy
- * @subj_cred; subjects cred
+ * @subj_cred: subjects cred
  * @label: label to check if it can manage policy
  * @ns: namespace being managed by @label (may be NULL if @label's ns)
  * @mask: contains the policy manipulation operation being done
-- 
2.20.1.7.g153144c

