Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F28B876FC77
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 10:50:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbjHDIuA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 04:50:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbjHDItg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 04:49:36 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A621A49F5
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 01:49:32 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RHK8568pkzJrTM;
        Fri,  4 Aug 2023 16:46:45 +0800 (CST)
Received: from huawei.com (10.67.175.31) by dggpemm500024.china.huawei.com
 (7.185.36.203) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 4 Aug
 2023 16:49:30 +0800
From:   GUO Zihua <guozihua@huawei.com>
To:     <keescook@chromium.org>, <arnd@arndb.de>,
        <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] lkdtm/bugs: Make huge and ignored static
Date:   Fri, 4 Aug 2023 16:49:02 +0800
Message-ID: <20230804084902.31562-1-guozihua@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.175.31]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500024.china.huawei.com (7.185.36.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

huge and ignored is not referred elsewhere, so make them static.

This resolves sparse warnings:
  warning: symbol 'huge' was not declared. Should it be static?
  warning: symbol 'ignored' was not declared. Should it be static?

Signed-off-by: GUO Zihua <guozihua@huawei.com>
---
 drivers/misc/lkdtm/bugs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/lkdtm/bugs.c b/drivers/misc/lkdtm/bugs.c
index 3c95600ab2f7..9b0310e0b923 100644
--- a/drivers/misc/lkdtm/bugs.c
+++ b/drivers/misc/lkdtm/bugs.c
@@ -273,8 +273,8 @@ static void lkdtm_HUNG_TASK(void)
 	schedule();
 }
 
-volatile unsigned int huge = INT_MAX - 2;
-volatile unsigned int ignored;
+static const volatile unsigned int huge = INT_MAX - 2;
+static volatile unsigned int ignored;
 
 static void lkdtm_OVERFLOW_SIGNED(void)
 {
-- 
2.17.1

