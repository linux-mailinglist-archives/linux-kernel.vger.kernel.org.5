Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 234ED780C07
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 14:45:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359477AbjHRMoe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 08:44:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376845AbjHRMoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 08:44:12 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 312113A99
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 05:44:11 -0700 (PDT)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RS1jy1F9jz1GDS2;
        Fri, 18 Aug 2023 20:42:46 +0800 (CST)
Received: from localhost (10.174.179.215) by canpemm500007.china.huawei.com
 (7.192.104.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Fri, 18 Aug
 2023 20:44:08 +0800
From:   Yue Haibing <yuehaibing@huawei.com>
To:     <johan@kernel.org>, <elder@kernel.org>,
        <gregkh@linuxfoundation.org>, <yuehaibing@huawei.com>
CC:     <greybus-dev@lists.linaro.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] greybus: svc: Remove unused declarations
Date:   Fri, 18 Aug 2023 20:43:38 +0800
Message-ID: <20230818124338.37880-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500007.china.huawei.com (7.192.104.62)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 84427943d2da ("greybus: svc: drop legacy-protocol dependency")
removed these implementations but not the declarations.

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 include/linux/greybus/svc.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/include/linux/greybus/svc.h b/include/linux/greybus/svc.h
index 5afaf5f06856..da547fb9071b 100644
--- a/include/linux/greybus/svc.h
+++ b/include/linux/greybus/svc.h
@@ -100,7 +100,4 @@ bool gb_svc_watchdog_enabled(struct gb_svc *svc);
 int gb_svc_watchdog_enable(struct gb_svc *svc);
 int gb_svc_watchdog_disable(struct gb_svc *svc);
 
-int gb_svc_protocol_init(void);
-void gb_svc_protocol_exit(void);
-
 #endif /* __SVC_H */
-- 
2.34.1

