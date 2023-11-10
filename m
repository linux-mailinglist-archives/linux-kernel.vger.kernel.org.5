Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E5E47E83F6
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 21:37:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234640AbjKJUg5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 15:36:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235739AbjKJUgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 15:36:38 -0500
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82C889EE8;
        Fri, 10 Nov 2023 00:33:39 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0Vw3yTAp_1699605209;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0Vw3yTAp_1699605209)
          by smtp.aliyun-inc.com;
          Fri, 10 Nov 2023 16:33:35 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     briannorris@chromium.org
Cc:     kvalo@kernel.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] mwifiex: clean up some inconsistent indenting
Date:   Fri, 10 Nov 2023 16:33:27 +0800
Message-Id: <20231110083327.7022-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional modification involved.

drivers/net/wireless/marvell/mwifiex/sta_event.c:789 mwifiex_process_sta_event() warn: inconsistent indenting.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=7226
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/net/wireless/marvell/mwifiex/sta_event.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/sta_event.c b/drivers/net/wireless/marvell/mwifiex/sta_event.c
index df9cdd10a494..9dd3b6d71026 100644
--- a/drivers/net/wireless/marvell/mwifiex/sta_event.c
+++ b/drivers/net/wireless/marvell/mwifiex/sta_event.c
@@ -762,7 +762,7 @@ int mwifiex_process_sta_event(struct mwifiex_private *priv)
 		mwifiex_dbg(adapter, EVENT, "info: EVENT: AWAKE\n");
 		if (!adapter->pps_uapsd_mode &&
 		    (priv->port_open ||
-		     (priv->bss_mode == NL80211_IFTYPE_ADHOC)) &&
+		    (priv->bss_mode == NL80211_IFTYPE_ADHOC)) &&
 		    priv->media_connected && adapter->sleep_period.period) {
 			adapter->pps_uapsd_mode = true;
 			mwifiex_dbg(adapter, EVENT,
@@ -773,7 +773,7 @@ int mwifiex_process_sta_event(struct mwifiex_private *priv)
 			if (mwifiex_check_last_packet_indication(priv)) {
 				if (adapter->data_sent ||
 				    (adapter->if_ops.is_port_ready &&
-				     !adapter->if_ops.is_port_ready(priv))) {
+				    !adapter->if_ops.is_port_ready(priv))) {
 					adapter->ps_state = PS_STATE_AWAKE;
 					adapter->pm_wakeup_card_req = false;
 					adapter->pm_wakeup_fw_try = false;
@@ -781,12 +781,10 @@ int mwifiex_process_sta_event(struct mwifiex_private *priv)
 					break;
 				}
 				if (!mwifiex_send_null_packet
-					(priv,
-					 MWIFIEX_TxPD_POWER_MGMT_NULL_PACKET |
-					 MWIFIEX_TxPD_POWER_MGMT_LAST_PACKET))
-						adapter->ps_state =
-							PS_STATE_SLEEP;
-					return 0;
+				    (priv, MWIFIEX_TxPD_POWER_MGMT_NULL_PACKET |
+				     MWIFIEX_TxPD_POWER_MGMT_LAST_PACKET))
+					adapter->ps_state = PS_STATE_SLEEP;
+				return 0;
 			}
 		}
 		adapter->ps_state = PS_STATE_AWAKE;
-- 
2.20.1.7.g153144c

