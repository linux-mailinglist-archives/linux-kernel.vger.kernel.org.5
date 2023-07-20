Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9510375A41C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 03:51:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbjGTBvw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 21:51:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjGTBvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 21:51:50 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 043D61FDF;
        Wed, 19 Jul 2023 18:51:49 -0700 (PDT)
Received: from dggpeml100024.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4R5wZM6hc7zNmVl;
        Thu, 20 Jul 2023 09:48:27 +0800 (CST)
Received: from hulk-vt.huawei.com (10.67.174.26) by
 dggpeml100024.china.huawei.com (7.185.36.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 20 Jul 2023 09:51:47 +0800
From:   Xiu Jianfeng <xiujianfeng@huawei.com>
To:     <paul@paul-moore.com>, <eparis@redhat.com>
CC:     <audit@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] audit: Include securiry.h unconditionally
Date:   Thu, 20 Jul 2023 01:50:32 +0000
Message-ID: <20230720015032.45960-1-xiujianfeng@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.26]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml100024.china.huawei.com (7.185.36.115)
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

The ifdef-else logic is already in the header file, so include it
unconditionally, no functional changes here.

Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
---
 kernel/audit.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/audit.c b/kernel/audit.c
index 9bc0b0301198..45b2fb1e45af 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -53,9 +53,7 @@
 #include <net/sock.h>
 #include <net/netlink.h>
 #include <linux/skbuff.h>
-#ifdef CONFIG_SECURITY
 #include <linux/security.h>
-#endif
 #include <linux/freezer.h>
 #include <linux/pid_namespace.h>
 #include <net/netns/generic.h>
-- 
2.34.1

