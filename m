Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5E7775B155
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 16:35:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232266AbjGTOfQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 10:35:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230487AbjGTOfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 10:35:14 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C20C626AB
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 07:35:12 -0700 (PDT)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4R6FWQ28QmztR9G;
        Thu, 20 Jul 2023 22:32:02 +0800 (CST)
Received: from localhost (10.174.179.215) by canpemm500007.china.huawei.com
 (7.192.104.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 20 Jul
 2023 22:35:10 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <ericvh@kernel.org>, <lucho@ionkov.net>, <asmadeus@codewreck.org>,
        <linux_oss@crudebyte.com>
CC:     <v9fs@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] fs/9p: Remove unused extern declaration
Date:   Thu, 20 Jul 2023 22:35:06 +0800
Message-ID: <20230720143506.33860-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500007.china.huawei.com (7.192.104.62)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit bd238fb431f3 ("9p: Reorganization of 9p file system code")
left behind this.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 fs/9p/v9fs.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/9p/v9fs.c b/fs/9p/v9fs.c
index c7f774fe398f..d525957594b6 100644
--- a/fs/9p/v9fs.c
+++ b/fs/9p/v9fs.c
@@ -545,8 +545,6 @@ void v9fs_session_begin_cancel(struct v9fs_session_info *v9ses)
 	p9_client_begin_disconnect(v9ses->clnt);
 }
 
-extern int v9fs_error_init(void);
-
 static struct kobject *v9fs_kobj;
 
 #ifdef CONFIG_9P_FSCACHE
-- 
2.34.1

