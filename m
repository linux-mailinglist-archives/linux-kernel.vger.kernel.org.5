Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74228773B79
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 17:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230270AbjHHPv2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 11:51:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230115AbjHHPtp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 11:49:45 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 474091FD0
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 08:42:13 -0700 (PDT)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RKxDf1TT8zNmsB;
        Tue,  8 Aug 2023 22:59:46 +0800 (CST)
Received: from localhost (10.174.179.215) by canpemm500007.china.huawei.com
 (7.192.104.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 8 Aug
 2023 23:03:14 +0800
From:   Yue Haibing <yuehaibing@huawei.com>
To:     <agk@redhat.com>, <snitzer@kernel.org>, <dm-devel@redhat.com>,
        <heinzm@redhat.com>
CC:     <linux-kernel@vger.kernel.org>, <yuehaibing@huawei.com>
Subject: [PATCH -next] dm: Remove unused declaration dm_get_rq_mapinfo()
Date:   Tue, 8 Aug 2023 23:03:01 +0800
Message-ID: <20230808150301.45196-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500007.china.huawei.com (7.192.104.62)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit ae6ad75e5c3c ("dm: remove unused dm_get_rq_mapinfo()")
removed the implementation but leave declaration.

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 include/linux/device-mapper.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/device-mapper.h b/include/linux/device-mapper.h
index 69d0435c7ebb..5bc69c6a64e0 100644
--- a/include/linux/device-mapper.h
+++ b/include/linux/device-mapper.h
@@ -502,7 +502,6 @@ int dm_post_suspending(struct dm_target *ti);
 int dm_noflush_suspending(struct dm_target *ti);
 void dm_accept_partial_bio(struct bio *bio, unsigned int n_sectors);
 void dm_submit_bio_remap(struct bio *clone, struct bio *tgt_clone);
-union map_info *dm_get_rq_mapinfo(struct request *rq);
 
 #ifdef CONFIG_BLK_DEV_ZONED
 struct dm_report_zones_args {
-- 
2.34.1

