Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9275D76E1FF
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 09:39:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233941AbjHCHjD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 03:39:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233854AbjHCHgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 03:36:40 -0400
Received: from mail.nfschina.com (unknown [42.101.60.195])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 075AC3595;
        Thu,  3 Aug 2023 00:35:22 -0700 (PDT)
Received: from localhost.localdomain (unknown [180.167.10.98])
        by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id CDE0060915888;
        Thu,  3 Aug 2023 15:35:19 +0800 (CST)
X-MD-Sfrom: yunchuan@nfschina.com
X-MD-SrcIP: 180.167.10.98
From:   Wu Yunchuan <yunchuan@nfschina.com>
To:     kvalo@kernel.org
Cc:     johannes.berg@intel.com, alexander@wetzel-home.de,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Wu Yunchuan <yunchuan@nfschina.com>
Subject: [PATCH net-next v2 4/9] wifi: rsi: rsi_91x_mac80211: Remove unnecessary conversions
Date:   Thu,  3 Aug 2023 15:35:17 +0800
Message-Id: <20230803073517.3666559-1-yunchuan@nfschina.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No need cast (struct rsi_hw *) to (struct rsi_hw *),
or cast (struct rsi_common *) to (struct rsi_common *).

Signed-off-by: Wu Yunchuan <yunchuan@nfschina.com>
---
 drivers/net/wireless/rsi/rsi_91x_mac80211.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/rsi/rsi_91x_mac80211.c b/drivers/net/wireless/rsi/rsi_91x_mac80211.c
index bc1f038d1655..05890536e353 100644
--- a/drivers/net/wireless/rsi/rsi_91x_mac80211.c
+++ b/drivers/net/wireless/rsi/rsi_91x_mac80211.c
@@ -1763,8 +1763,8 @@ static int rsi_mac80211_roc(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 			    struct ieee80211_channel *chan, int duration,
 			    enum ieee80211_roc_type type)
 {
-	struct rsi_hw *adapter = (struct rsi_hw *)hw->priv;
-	struct rsi_common *common = (struct rsi_common *)adapter->priv;
+	struct rsi_hw *adapter = hw->priv;
+	struct rsi_common *common = adapter->priv;
 	int status = 0;
 
 	rsi_dbg(INFO_ZONE, "***** Remain on channel *****\n");
-- 
2.30.2

