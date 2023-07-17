Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFC0F7559EE
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 05:11:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231336AbjGQDLy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 23:11:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231285AbjGQDLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 23:11:38 -0400
Received: from mail.nfschina.com (unknown [42.101.60.195])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id BA4DDE76;
        Sun, 16 Jul 2023 20:11:33 -0700 (PDT)
Received: from localhost.localdomain (unknown [180.167.10.98])
        by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id 628E76012605B;
        Mon, 17 Jul 2023 11:11:30 +0800 (CST)
X-MD-Sfrom: yunchuan@nfschina.com
X-MD-SrcIP: 180.167.10.98
From:   Wu Yunchuan <yunchuan@nfschina.com>
To:     yisen.zhuang@huawei.com, salil.mehta@huawei.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Wu Yunchuan <yunchuan@nfschina.com>,
        Hao Lan <lanhao@huawei.com>
Subject: [PATCH net-next v3 3/9] net: hns3: remove unnecessary (void*) conversions.
Date:   Mon, 17 Jul 2023 11:11:28 +0800
Message-Id: <20230717031128.54557-1-yunchuan@nfschina.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No need cast (void*) to (struct hns3_nic_priv *).

Signed-off-by: Wu Yunchuan <yunchuan@nfschina.com>
Reviewed-by: Hao Lan <lanhao@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
index 407d30ee55d2..36858a72d771 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
@@ -569,8 +569,8 @@ static void hns3_get_strings(struct net_device *netdev, u32 stringset, u8 *data)
 
 static u64 *hns3_get_stats_tqps(struct hnae3_handle *handle, u64 *data)
 {
-	struct hns3_nic_priv *nic_priv = (struct hns3_nic_priv *)handle->priv;
 	struct hnae3_knic_private_info *kinfo = &handle->kinfo;
+	struct hns3_nic_priv *nic_priv = handle->priv;
 	struct hns3_enet_ring *ring;
 	u8 *stat;
 	int i, j;
-- 
2.30.2

