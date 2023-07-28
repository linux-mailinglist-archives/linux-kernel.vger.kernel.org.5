Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FE78766DFB
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 15:21:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235863AbjG1NVi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 09:21:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234299AbjG1NVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 09:21:36 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1DEB1BC6;
        Fri, 28 Jul 2023 06:21:34 -0700 (PDT)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RC7XW3XT3zVjt1;
        Fri, 28 Jul 2023 21:19:55 +0800 (CST)
Received: from localhost (10.174.179.215) by canpemm500007.china.huawei.com
 (7.192.104.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 28 Jul
 2023 21:21:32 +0800
From:   Yue Haibing <yuehaibing@huawei.com>
To:     <jiri@resnulli.us>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Yue Haibing <yuehaibing@huawei.com>
Subject: [PATCH net-next] devlink: Remove unused extern declaration devlink_port_region_destroy()
Date:   Fri, 28 Jul 2023 21:21:13 +0800
Message-ID: <20230728132113.32888-1-yuehaibing@huawei.com>
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

devlink_port_region_destroy() is never implemented since
commit 544e7c33ec2f ("net: devlink: Add support for port regions").

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 include/net/devlink.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/net/devlink.h b/include/net/devlink.h
index 0cdb4b16e5b5..a1a8e1b6e7df 100644
--- a/include/net/devlink.h
+++ b/include/net/devlink.h
@@ -1790,8 +1790,6 @@ devlink_port_region_create(struct devlink_port *port,
 			   u32 region_max_snapshots, u64 region_size);
 void devl_region_destroy(struct devlink_region *region);
 void devlink_region_destroy(struct devlink_region *region);
-void devlink_port_region_destroy(struct devlink_region *region);
-
 int devlink_region_snapshot_id_get(struct devlink *devlink, u32 *id);
 void devlink_region_snapshot_id_put(struct devlink *devlink, u32 id);
 int devlink_region_snapshot_create(struct devlink_region *region,
-- 
2.34.1

