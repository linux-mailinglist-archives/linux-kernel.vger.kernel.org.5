Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9B107D27CF
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 03:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232982AbjJWBLe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 21:11:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjJWBLc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 21:11:32 -0400
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0EB9F1;
        Sun, 22 Oct 2023 18:11:29 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0Vucq0a7_1698023486;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0Vucq0a7_1698023486)
          by smtp.aliyun-inc.com;
          Mon, 23 Oct 2023 09:11:26 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     john.johansen@canonical.com, paul@paul-moore.com,
        jmorris@namei.org, serge@hallyn.com
Cc:     apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next 1/2] apparmor: Fix one kernel-doc comment
Date:   Mon, 23 Oct 2023 09:11:23 +0800
Message-Id: <20231023011124.19034-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
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

Fix one kernel-doc comment to silence the warnings:
security/apparmor/domain.c:46: warning: Function parameter or member 'to_cred' not described in 'may_change_ptraced_domain'
security/apparmor/domain.c:46: warning: Excess function parameter 'cred' description in 'may_change_ptraced_domain'

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=7036
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 security/apparmor/domain.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/apparmor/domain.c b/security/apparmor/domain.c
index ed4a13d44894..89fbeab4b33b 100644
--- a/security/apparmor/domain.c
+++ b/security/apparmor/domain.c
@@ -31,7 +31,7 @@
 
 /**
  * may_change_ptraced_domain - check if can change profile on ptraced task
- * @cred: cred of task changing domain
+ * @to_cred: cred of task changing domain
  * @to_label: profile to change to  (NOT NULL)
  * @info: message if there is an error
  *
-- 
2.20.1.7.g153144c

