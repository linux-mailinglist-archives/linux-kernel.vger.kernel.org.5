Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BBDC77BAE8
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 16:05:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231518AbjHNOFZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 10:05:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231944AbjHNOFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 10:05:18 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8072EE6D;
        Mon, 14 Aug 2023 07:05:17 -0700 (PDT)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RPbjS54rNzrSMF;
        Mon, 14 Aug 2023 22:03:56 +0800 (CST)
Received: from localhost (10.174.179.215) by canpemm500007.china.huawei.com
 (7.192.104.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Mon, 14 Aug
 2023 22:05:15 +0800
From:   Yue Haibing <yuehaibing@huawei.com>
To:     <deller@gmx.de>, <yuehaibing@huawei.com>
CC:     <linux-fbdev@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] video: fbdev: kyro: Remove unused declarations
Date:   Mon, 14 Aug 2023 22:05:10 +0800
Message-ID: <20230814140510.42408-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500007.china.huawei.com (7.192.104.62)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These declarations is never implemented since the beginning of git history.

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 include/video/kyro.h | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/include/video/kyro.h b/include/video/kyro.h
index b958c2e9c915..418eef6c5523 100644
--- a/include/video/kyro.h
+++ b/include/video/kyro.h
@@ -38,18 +38,6 @@ struct kyrofb_info {
 	int wc_cookie;
 };
 
-extern int kyro_dev_init(void);
-extern void kyro_dev_reset(void);
-
-extern unsigned char *kyro_dev_physical_fb_ptr(void);
-extern unsigned char *kyro_dev_virtual_fb_ptr(void);
-extern void *kyro_dev_physical_regs_ptr(void);
-extern void *kyro_dev_virtual_regs_ptr(void);
-extern unsigned int kyro_dev_fb_size(void);
-extern unsigned int kyro_dev_regs_size(void);
-
-extern u32 kyro_dev_overlay_offset(void);
-
 /*
  * benedict.gaster@superh.com
  * Added the follow IOCTLS for the creation of overlay services...
-- 
2.34.1

