Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95C3F76395A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 16:38:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233574AbjGZOid (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 10:38:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231536AbjGZOic (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 10:38:32 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A442D1985;
        Wed, 26 Jul 2023 07:38:30 -0700 (PDT)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4R9xJJ3RrbztRdv;
        Wed, 26 Jul 2023 22:35:12 +0800 (CST)
Received: from localhost (10.174.179.215) by canpemm500007.china.huawei.com
 (7.192.104.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 26 Jul
 2023 22:38:26 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <j.vosburgh@gmail.com>, <andy@greyhouse.net>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <jon.toppins+linux@gmail.com>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <liuhangbin@gmail.com>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH v2 net-next] bonding: 3ad: Remove unused declaration bond_3ad_update_lacp_active()
Date:   Wed, 26 Jul 2023 22:38:16 +0800
Message-ID: <20230726143816.15280-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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

This is not used since commit 3a755cd8b7c6 ("bonding: add new option lacp_active")

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
v2: fix patch prefix
---
 include/net/bond_3ad.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/net/bond_3ad.h b/include/net/bond_3ad.h
index a016f275cb01..c5e57c6bd873 100644
--- a/include/net/bond_3ad.h
+++ b/include/net/bond_3ad.h
@@ -301,7 +301,6 @@ int  __bond_3ad_get_active_agg_info(struct bonding *bond,
 int bond_3ad_lacpdu_recv(const struct sk_buff *skb, struct bonding *bond,
 			 struct slave *slave);
 int bond_3ad_set_carrier(struct bonding *bond);
-void bond_3ad_update_lacp_active(struct bonding *bond);
 void bond_3ad_update_lacp_rate(struct bonding *bond);
 void bond_3ad_update_ad_actor_settings(struct bonding *bond);
 int bond_3ad_stats_fill(struct sk_buff *skb, struct bond_3ad_stats *stats);
-- 
2.34.1

