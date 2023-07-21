Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB7A575C6E1
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 14:29:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbjGUM3A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 08:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjGUM26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 08:28:58 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09EFE19B3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 05:28:55 -0700 (PDT)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4R6pfz3Z3WzNmLn;
        Fri, 21 Jul 2023 20:25:31 +0800 (CST)
Received: from localhost (10.174.179.215) by canpemm500007.china.huawei.com
 (7.192.104.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 21 Jul
 2023 20:28:52 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <yuehaibing@huawei.com>, <Anna.Schumaker@Netapp.com>,
        <dhowells@redhat.com>, <ebiederm@xmission.com>,
        <paul@paul-moore.com>
CC:     <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] cred: Remove unsued extern declaration change_create_files_as()
Date:   Fri, 21 Jul 2023 20:28:40 +0800
Message-ID: <20230721122840.31740-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500007.china.huawei.com (7.192.104.62)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 3a3b7ce93369 ("CRED: Allow kernel services to override LSM settings for task actions")
this is never used, so can be removed.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 include/linux/cred.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/cred.h b/include/linux/cred.h
index 9ed9232af934..f923528d5cc4 100644
--- a/include/linux/cred.h
+++ b/include/linux/cred.h
@@ -164,7 +164,6 @@ extern void abort_creds(struct cred *);
 extern const struct cred *override_creds(const struct cred *);
 extern void revert_creds(const struct cred *);
 extern struct cred *prepare_kernel_cred(struct task_struct *);
-extern int change_create_files_as(struct cred *, struct inode *);
 extern int set_security_override(struct cred *, u32);
 extern int set_security_override_from_ctx(struct cred *, const char *);
 extern int set_create_files_as(struct cred *, struct inode *);
-- 
2.34.1

