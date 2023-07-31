Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D9FA769905
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 16:08:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233212AbjGaOIb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 10:08:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230314AbjGaOIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 10:08:15 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04379268A;
        Mon, 31 Jul 2023 07:07:19 -0700 (PDT)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RF0My0zYlztQwm;
        Mon, 31 Jul 2023 22:03:58 +0800 (CST)
Received: from localhost (10.174.179.215) by canpemm500007.china.huawei.com
 (7.192.104.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 31 Jul
 2023 22:07:17 +0800
From:   Yue Haibing <yuehaibing@huawei.com>
To:     <johannes@sipsolutions.net>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <nbd@nbd.name>, <pagadala.yesu.anjaneyulu@intel.com>
CC:     <linux-wireless@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Yue Haibing <yuehaibing@huawei.com>
Subject: [PATCH] mac80211: mesh: Remove unused function declaration mesh_ids_set_default()
Date:   Mon, 31 Jul 2023 22:07:12 +0800
Message-ID: <20230731140712.1204-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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

Commit ccf80ddfe492 ("mac80211: mesh function and data structures definitions")
introducted this but never implemented.

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 net/mac80211/mesh.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/mac80211/mesh.h b/net/mac80211/mesh.h
index 6c94222a9df5..ad8469293d71 100644
--- a/net/mac80211/mesh.h
+++ b/net/mac80211/mesh.h
@@ -212,7 +212,6 @@ int mesh_rmc_check(struct ieee80211_sub_if_data *sdata,
 		   const u8 *addr, struct ieee80211s_hdr *mesh_hdr);
 bool mesh_matches_local(struct ieee80211_sub_if_data *sdata,
 			struct ieee802_11_elems *ie);
-void mesh_ids_set_default(struct ieee80211_if_mesh *mesh);
 int mesh_add_meshconf_ie(struct ieee80211_sub_if_data *sdata,
 			 struct sk_buff *skb);
 int mesh_add_meshid_ie(struct ieee80211_sub_if_data *sdata,
-- 
2.34.1

