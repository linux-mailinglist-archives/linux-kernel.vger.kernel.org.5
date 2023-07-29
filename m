Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE577767F2E
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 14:35:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231649AbjG2MfV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 08:35:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjG2MfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 08:35:20 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 343BD3AB7;
        Sat, 29 Jul 2023 05:35:19 -0700 (PDT)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RCkSf18kRzVjkK;
        Sat, 29 Jul 2023 20:33:38 +0800 (CST)
Received: from localhost (10.174.179.215) by canpemm500007.china.huawei.com
 (7.192.104.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sat, 29 Jul
 2023 20:35:16 +0800
From:   Yue Haibing <yuehaibing@huawei.com>
To:     <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <yuehaibing@huawei.com>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next] net/hsr: Remove unused function declarations
Date:   Sat, 29 Jul 2023 20:34:56 +0800
Message-ID: <20230729123456.36340-1-yuehaibing@huawei.com>
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

commit f421436a591d ("net/hsr: Add support for the High-availability Seamless Redundancy protocol (HSRv0)")
introducted these but never implemented.

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 net/hsr/hsr_netlink.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/hsr/hsr_netlink.h b/net/hsr/hsr_netlink.h
index 501552d9753b..8c99e64e1cea 100644
--- a/net/hsr/hsr_netlink.h
+++ b/net/hsr/hsr_netlink.h
@@ -23,7 +23,5 @@ void __exit hsr_netlink_exit(void);
 void hsr_nl_ringerror(struct hsr_priv *hsr, unsigned char addr[ETH_ALEN],
 		      struct hsr_port *port);
 void hsr_nl_nodedown(struct hsr_priv *hsr, unsigned char addr[ETH_ALEN]);
-void hsr_nl_framedrop(int dropcount, int dev_idx);
-void hsr_nl_linkdown(int dev_idx);
 
 #endif /* __HSR_NETLINK_H */
-- 
2.34.1

