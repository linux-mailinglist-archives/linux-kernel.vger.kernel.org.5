Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D5A6783F5D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 13:37:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234904AbjHVLhN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 07:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233604AbjHVLhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 07:37:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A492CF9;
        Tue, 22 Aug 2023 04:36:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 757036537E;
        Tue, 22 Aug 2023 11:36:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA154C433CB;
        Tue, 22 Aug 2023 11:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692704203;
        bh=Shy4uzllZTzfAoXNe/R74GUm2HRgtZWCevC91qt59wI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TUiJ0pscjxwt/7RMFSTVZWEoioTcDzWO+Y8tVUGYPAGNK0X+C+fM7c2fohQL+WwQV
         bURXcwmxCesDJfT/oIaQORsPlEsWxeJ5faKdZNpqhpBwpyJLXnnlEsED9LH/nCmX3y
         ED8J5CXIMG+MVmJV7w1I1J4kaggYOhNUkanAiK22HYRu9G95Q/rRltqfrsPOBi1KT/
         LcBufl4xOWGWs0hYISY17ENSA7LkqGztJGjYMTM8dZ46p4laTsGKqooEbjMURlYDK3
         TH7D2iDTQPAQml9ghPpF7QOybJkCIHMVbeLcEQR6/MuF01aMAaU6Iv2wtwga72CLBM
         R0PJAohOtUYqQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jian Shen <shenjian15@huawei.com>,
        Peiyang Wang <wangpeiyang1@huawei.com>,
        Jijie Shao <shaojijie@huawei.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>, yisen.zhuang@huawei.com,
        salil.mehta@huawei.com, davem@davemloft.net, edumazet@google.com,
        pabeni@redhat.com, huangguangbin2@huawei.com, lanhao@huawei.com,
        wangjie125@huawei.com, chenhao418@huawei.com,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 05/10] net: hns3: restore user pause configure when disable autoneg
Date:   Tue, 22 Aug 2023 07:36:23 -0400
Message-Id: <20230822113628.3551393-5-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230822113628.3551393-1-sashal@kernel.org>
References: <20230822113628.3551393-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.46
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jian Shen <shenjian15@huawei.com>

[ Upstream commit 15159ec0c831b565820c2de05114ea1b4cf07681 ]

Restore the mac pause state to user configuration when autoneg is disabled

Signed-off-by: Jian Shen <shenjian15@huawei.com>
Signed-off-by: Peiyang Wang <wangpeiyang1@huawei.com>
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
Link: https://lore.kernel.org/r/20230807113452.474224-2-shaojijie@huawei.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c | 5 ++++-
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c   | 2 +-
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.h   | 1 +
 3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 6af2273f227c2..84ecd8b9be48c 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -10936,9 +10936,12 @@ int hclge_cfg_flowctrl(struct hclge_dev *hdev)
 	u32 rx_pause, tx_pause;
 	u8 flowctl;
 
-	if (!phydev->link || !phydev->autoneg)
+	if (!phydev->link)
 		return 0;
 
+	if (!phydev->autoneg)
+		return hclge_mac_pause_setup_hw(hdev);
+
 	local_advertising = linkmode_adv_to_lcl_adv_t(phydev->advertising);
 
 	if (phydev->pause)
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c
index 150f146fa24fb..8b40c6b4ee53e 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c
@@ -1549,7 +1549,7 @@ static int hclge_bp_setup_hw(struct hclge_dev *hdev, u8 tc)
 	return 0;
 }
 
-static int hclge_mac_pause_setup_hw(struct hclge_dev *hdev)
+int hclge_mac_pause_setup_hw(struct hclge_dev *hdev)
 {
 	bool tx_en, rx_en;
 
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.h
index dd6f1fd486cf2..251e808456208 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.h
@@ -242,6 +242,7 @@ int hclge_pfc_pause_en_cfg(struct hclge_dev *hdev, u8 tx_rx_bitmap,
 			   u8 pfc_bitmap);
 int hclge_mac_pause_en_cfg(struct hclge_dev *hdev, bool tx, bool rx);
 int hclge_pause_addr_cfg(struct hclge_dev *hdev, const u8 *mac_addr);
+int hclge_mac_pause_setup_hw(struct hclge_dev *hdev);
 void hclge_pfc_rx_stats_get(struct hclge_dev *hdev, u64 *stats);
 void hclge_pfc_tx_stats_get(struct hclge_dev *hdev, u64 *stats);
 int hclge_tm_qs_shaper_cfg(struct hclge_vport *vport, int max_tx_rate);
-- 
2.40.1

