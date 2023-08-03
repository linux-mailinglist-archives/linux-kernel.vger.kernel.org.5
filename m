Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50DF376E0AE
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 09:02:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233833AbjHCHCO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 03:02:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233798AbjHCHB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 03:01:58 -0400
Received: from mail.nfschina.com (unknown [42.101.60.195])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id A4D7B3C02;
        Thu,  3 Aug 2023 00:01:40 -0700 (PDT)
Received: from localhost.localdomain (unknown [180.167.10.98])
        by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id 23296608E4EA5;
        Thu,  3 Aug 2023 15:01:37 +0800 (CST)
X-MD-Sfrom: yunchuan@nfschina.com
X-MD-SrcIP: 180.167.10.98
From:   Wu Yunchuan <yunchuan@nfschina.com>
To:     kvalo@kernel.org
Cc:     peter@n8pjl.ca, marex@denx.de, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Wu Yunchuan <yunchuan@nfschina.com>
Subject: [PATCH net-next 3/9] wifi: rsi: Remove unnecessary conversions
Date:   Thu,  3 Aug 2023 15:01:35 +0800
Message-Id: <20230803070135.3654465-1-yunchuan@nfschina.com>
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

No need cast (struct rsi_hw *) to (struct rsi_hw *).

Signed-off-by: Wu Yunchuan <yunchuan@nfschina.com>
---
 drivers/net/wireless/rsi/rsi_91x_hal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/rsi/rsi_91x_hal.c b/drivers/net/wireless/rsi/rsi_91x_hal.c
index d4489b943873..2cebe562a1f4 100644
--- a/drivers/net/wireless/rsi/rsi_91x_hal.c
+++ b/drivers/net/wireless/rsi/rsi_91x_hal.c
@@ -424,7 +424,7 @@ int rsi_send_bt_pkt(struct rsi_common *common, struct sk_buff *skb)
 
 int rsi_prepare_beacon(struct rsi_common *common, struct sk_buff *skb)
 {
-	struct rsi_hw *adapter = (struct rsi_hw *)common->priv;
+	struct rsi_hw *adapter = common->priv;
 	struct rsi_data_desc *bcn_frm;
 	struct ieee80211_hw *hw = common->priv->hw;
 	struct ieee80211_conf *conf = &hw->conf;
-- 
2.30.2

