Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D16457727A2
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 16:25:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233587AbjHGOZj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 10:25:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231620AbjHGOZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 10:25:37 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2645B170A;
        Mon,  7 Aug 2023 07:25:34 -0700 (PDT)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RKJTS0NJfzVk5T;
        Mon,  7 Aug 2023 22:23:40 +0800 (CST)
Received: from localhost (10.174.179.215) by canpemm500007.china.huawei.com
 (7.192.104.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 7 Aug
 2023 22:25:32 +0800
From:   Yue Haibing <yuehaibing@huawei.com>
To:     <pablo@netfilter.org>, <kadlec@netfilter.org>, <fw@strlen.de>,
        <yuehaibing@huawei.com>
CC:     <netfilter-devel@vger.kernel.org>, <coreteam@netfilter.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next] netfilter: h323: Remove unused function declarations
Date:   Mon, 7 Aug 2023 22:25:26 +0800
Message-ID: <20230807142526.35648-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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

Commit f587de0e2feb ("[NETFILTER]: nf_conntrack/nf_nat: add H.323 helper port")
declared but never implemented these.

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 include/linux/netfilter/nf_conntrack_h323.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/include/linux/netfilter/nf_conntrack_h323.h b/include/linux/netfilter/nf_conntrack_h323.h
index 9e937f64a1ad..81286c499325 100644
--- a/include/linux/netfilter/nf_conntrack_h323.h
+++ b/include/linux/netfilter/nf_conntrack_h323.h
@@ -34,10 +34,6 @@ struct nf_ct_h323_master {
 int get_h225_addr(struct nf_conn *ct, unsigned char *data,
 		  TransportAddress *taddr, union nf_inet_addr *addr,
 		  __be16 *port);
-void nf_conntrack_h245_expect(struct nf_conn *new,
-			      struct nf_conntrack_expect *this);
-void nf_conntrack_q931_expect(struct nf_conn *new,
-			      struct nf_conntrack_expect *this);
 
 struct nfct_h323_nat_hooks {
 	int (*set_h245_addr)(struct sk_buff *skb, unsigned int protoff,
-- 
2.34.1

