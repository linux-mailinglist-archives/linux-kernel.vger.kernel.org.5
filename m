Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7A587698FF
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 16:07:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233145AbjGaOHb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 10:07:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232638AbjGaOHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 10:07:12 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0800B1FC6;
        Mon, 31 Jul 2023 07:04:55 -0700 (PDT)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RF0K61yX9ztRh9;
        Mon, 31 Jul 2023 22:01:30 +0800 (CST)
Received: from localhost (10.174.179.215) by canpemm500007.china.huawei.com
 (7.192.104.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 31 Jul
 2023 22:04:49 +0800
From:   Yue Haibing <yuehaibing@huawei.com>
To:     <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Yue Haibing <yuehaibing@huawei.com>
Subject: [PATCH net-next] inet6: Remove unused function declaration udpv6_connect()
Date:   Mon, 31 Jul 2023 22:04:37 +0800
Message-ID: <20230731140437.37056-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500007.china.huawei.com (7.192.104.62)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is never implemented since the beginning of git history.

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 include/net/transp_v6.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/net/transp_v6.h b/include/net/transp_v6.h
index d27b1caf3753..1a97e3f32029 100644
--- a/include/net/transp_v6.h
+++ b/include/net/transp_v6.h
@@ -33,8 +33,6 @@ void udplitev6_exit(void);
 int tcpv6_init(void);
 void tcpv6_exit(void);
 
-int udpv6_connect(struct sock *sk, struct sockaddr *uaddr, int addr_len);
-
 /* this does all the common and the specific ctl work */
 void ip6_datagram_recv_ctl(struct sock *sk, struct msghdr *msg,
 			   struct sk_buff *skb);
-- 
2.34.1

