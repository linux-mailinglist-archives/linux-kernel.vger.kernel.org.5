Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E11DF7F98BB
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 06:36:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbjK0FgO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 00:36:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjK0FgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 00:36:11 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C8D9F0
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 21:36:17 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-6cd8c3a9edaso480190b3a.2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 21:36:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1701063377; x=1701668177; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7BNSjAfjsj6TnStXG6ZmHRofXAvHYH/XMDwqXWavaiA=;
        b=djCOBxEufKTjjCU3R9kJFeIMdc/qTwwDfzY0BszzAliVJS4PDmUD/xtEvUsjK1eo/N
         vrjpY9OlDV9m0wmYVEo+JYPQ8gaen2EhNxl6iJf8WZFzB0wHLwiDUISvrobfVgCRAWKO
         9L6+qIjzbOLN8uGddnBFxayJDANTa8Ap2DR2p1Sag97NW7MS/GIRVJzJYRWqG2gTQUqE
         MUFZjkNTj5OOsM6i6sMqzWdE8SGC+SPKKo7CVItXglGJH4rxeT2NMxSST6cPmcCSIrCn
         pMRP6+X5p5zJ7iZLY58exz976XCWeroCJT5/Od1YPGedL0QMWgaAQsBZVvkm64FFU1L0
         of/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701063377; x=1701668177;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7BNSjAfjsj6TnStXG6ZmHRofXAvHYH/XMDwqXWavaiA=;
        b=k/bM1z9mdPJzEMi/9Jll+AHElBPfPJ3n9Dbz3jtdOYl4JTBKaW7q+WDAjj9QPa4rIm
         1ZGy0uCkxxzOgrK9LuSn0FKn5GidCGFY2RupMmcvxsU8ihing49UwxftjqrhoShddwkq
         WIodIAQPwYWn9onZsnSFM4idWYAXEVg9g0Ql7Mm1+QRFi40Nn2+gTP6IuryBtWcJ+POC
         9wGwNeA3r4wLo9bzaNs+dTJ6BsQlJdxtuRAeaCr0sOSZcvOBDZHj/EALsBiIZ0uV7COu
         rpAvKl3fiudL3irqFDc7eKO83tzPW6tlR546aosd53fI/9ekE2hYNscXxi6wAsA//S3h
         mfLg==
X-Gm-Message-State: AOJu0YzXtHdmNdLeb2NIAOLXXt3SfPPEtZlmfGZwaFvBFxdqkxleCDYs
        aG7tylvjcm2c95sOz7VZp3j78A==
X-Google-Smtp-Source: AGHT+IF7wlbCLu5aKqnvoDa+vzLrPQ1alT3S0V3uWasMqktoQcwKrtJf60uEqCxrF1GQbEBwQWcW5w==
X-Received: by 2002:a05:6a21:3391:b0:182:119d:2d0e with SMTP id yy17-20020a056a21339100b00182119d2d0emr10898995pzb.20.1701063376908;
        Sun, 26 Nov 2023 21:36:16 -0800 (PST)
Received: from basil.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id b6-20020a170902ed0600b001cc3875e658sm7300465pld.303.2023.11.26.21.36.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Nov 2023 21:36:16 -0800 (PST)
From:   Tree Davies <tdavies@darkphysics.net>
To:     gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com,
        anjan@momi.ca
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 01/15] Staging: rtl8192e: Rename variable pTxTs
Date:   Sun, 26 Nov 2023 21:42:51 -0800
Message-ID: <20231127054305.148276-2-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231127054305.148276-1-tdavies@darkphysics.net>
References: <20231127054305.148276-1-tdavies@darkphysics.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NO_DNS_FOR_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename variable pTxTs to ts to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtl819x_BAProc.c | 50 +++++++++++------------
 drivers/staging/rtl8192e/rtl819x_TSProc.c |  8 ++--
 drivers/staging/rtl8192e/rtllib_tx.c      | 18 ++++----
 3 files changed, 38 insertions(+), 38 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_BAProc.c b/drivers/staging/rtl8192e/rtl819x_BAProc.c
index b52b42ac0fc4..497791a980ba 100644
--- a/drivers/staging/rtl8192e/rtl819x_BAProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_BAProc.c
@@ -23,10 +23,10 @@ static void deactivate_ba_entry(struct rtllib_device *ieee, struct ba_record *ba
 	del_timer_sync(&ba->timer);
 }
 
-static u8 tx_ts_delete_ba(struct rtllib_device *ieee, struct tx_ts_record *pTxTs)
+static u8 tx_ts_delete_ba(struct rtllib_device *ieee, struct tx_ts_record *ts)
 {
-	struct ba_record *admitted_ba = &pTxTs->TxAdmittedBARecord;
-	struct ba_record *pending_ba = &pTxTs->TxPendingBARecord;
+	struct ba_record *admitted_ba = &ts->TxAdmittedBARecord;
+	struct ba_record *pending_ba = &ts->TxPendingBARecord;
 	u8 send_del_ba = false;
 
 	if (pending_ba->b_valid) {
@@ -443,20 +443,20 @@ int rtllib_rx_DELBA(struct rtllib_device *ieee, struct sk_buff *skb)
 
 		rx_ts_delete_ba(ieee, ts);
 	} else {
-		struct tx_ts_record *pTxTs;
+		struct tx_ts_record *ts;
 
-		if (!rtllib_get_ts(ieee, (struct ts_common_info **)&pTxTs, dst,
+		if (!rtllib_get_ts(ieee, (struct ts_common_info **)&ts, dst,
 			   (u8)pDelBaParamSet->field.tid, TX_DIR, false)) {
 			netdev_warn(ieee->dev, "%s(): can't get TS for TXTS\n",
 				    __func__);
 			return -1;
 		}
 
-		pTxTs->using_ba = false;
-		pTxTs->add_ba_req_in_progress = false;
-		pTxTs->add_ba_req_delayed = false;
-		del_timer_sync(&pTxTs->TsAddBaTimer);
-		tx_ts_delete_ba(ieee, pTxTs);
+		ts->using_ba = false;
+		ts->add_ba_req_in_progress = false;
+		ts->add_ba_req_delayed = false;
+		del_timer_sync(&ts->TsAddBaTimer);
+		tx_ts_delete_ba(ieee, ts);
 	}
 	return 0;
 }
@@ -489,14 +489,14 @@ void rtllib_ts_init_del_ba(struct rtllib_device *ieee,
 			   enum tr_select TxRxSelect)
 {
 	if (TxRxSelect == TX_DIR) {
-		struct tx_ts_record *pTxTs =
+		struct tx_ts_record *ts =
 			 (struct tx_ts_record *)pTsCommonInfo;
 
-		if (tx_ts_delete_ba(ieee, pTxTs))
+		if (tx_ts_delete_ba(ieee, ts))
 			rtllib_send_DELBA(ieee, pTsCommonInfo->addr,
-					  (pTxTs->TxAdmittedBARecord.b_valid) ?
-					 (&pTxTs->TxAdmittedBARecord) :
-					(&pTxTs->TxPendingBARecord),
+					  (ts->TxAdmittedBARecord.b_valid) ?
+					 (&ts->TxAdmittedBARecord) :
+					(&ts->TxPendingBARecord),
 					 TxRxSelect, DELBA_REASON_END_BA);
 	} else if (TxRxSelect == RX_DIR) {
 		struct rx_ts_record *ts =
@@ -510,23 +510,23 @@ void rtllib_ts_init_del_ba(struct rtllib_device *ieee,
 
 void rtllib_ba_setup_timeout(struct timer_list *t)
 {
-	struct tx_ts_record *pTxTs = from_timer(pTxTs, t,
+	struct tx_ts_record *ts = from_timer(ts, t,
 					      TxPendingBARecord.timer);
 
-	pTxTs->add_ba_req_in_progress = false;
-	pTxTs->add_ba_req_delayed = true;
-	pTxTs->TxPendingBARecord.b_valid = false;
+	ts->add_ba_req_in_progress = false;
+	ts->add_ba_req_delayed = true;
+	ts->TxPendingBARecord.b_valid = false;
 }
 
 void rtllib_tx_ba_inact_timeout(struct timer_list *t)
 {
-	struct tx_ts_record *pTxTs = from_timer(pTxTs, t,
+	struct tx_ts_record *ts = from_timer(ts, t,
 					      TxAdmittedBARecord.timer);
-	struct rtllib_device *ieee = container_of(pTxTs, struct rtllib_device,
-				     TxTsRecord[pTxTs->num]);
-	tx_ts_delete_ba(ieee, pTxTs);
-	rtllib_send_DELBA(ieee, pTxTs->TsCommonInfo.addr,
-			  &pTxTs->TxAdmittedBARecord, TX_DIR,
+	struct rtllib_device *ieee = container_of(ts, struct rtllib_device,
+				     TxTsRecord[ts->num]);
+	tx_ts_delete_ba(ieee, ts);
+	rtllib_send_DELBA(ieee, ts->TsCommonInfo.addr,
+			  &ts->TxAdmittedBARecord, TX_DIR,
 			  DELBA_REASON_TIMEOUT);
 }
 
diff --git a/drivers/staging/rtl8192e/rtl819x_TSProc.c b/drivers/staging/rtl8192e/rtl819x_TSProc.c
index 41c1e768348a..01d077bf0155 100644
--- a/drivers/staging/rtl8192e/rtl819x_TSProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_TSProc.c
@@ -82,12 +82,12 @@ static void RxPktPendingTimeout(struct timer_list *t)
 
 static void TsAddBaProcess(struct timer_list *t)
 {
-	struct tx_ts_record *pTxTs = from_timer(pTxTs, t, TsAddBaTimer);
-	u8 num = pTxTs->num;
-	struct rtllib_device *ieee = container_of(pTxTs, struct rtllib_device,
+	struct tx_ts_record *ts = from_timer(ts, t, TsAddBaTimer);
+	u8 num = ts->num;
+	struct rtllib_device *ieee = container_of(ts, struct rtllib_device,
 				     TxTsRecord[num]);
 
-	rtllib_ts_init_add_ba(ieee, pTxTs, BA_POLICY_IMMEDIATE, false);
+	rtllib_ts_init_add_ba(ieee, ts, BA_POLICY_IMMEDIATE, false);
 	netdev_dbg(ieee->dev, "%s(): ADDBA Req is started\n", __func__);
 }
 
diff --git a/drivers/staging/rtl8192e/rtllib_tx.c b/drivers/staging/rtl8192e/rtllib_tx.c
index 1da098f5b84c..2ef617a55995 100644
--- a/drivers/staging/rtl8192e/rtllib_tx.c
+++ b/drivers/staging/rtl8192e/rtllib_tx.c
@@ -267,7 +267,7 @@ static void rtllib_tx_query_agg_cap(struct rtllib_device *ieee,
 				    struct cb_desc *tcb_desc)
 {
 	struct rt_hi_throughput *ht_info = ieee->ht_info;
-	struct tx_ts_record *pTxTs = NULL;
+	struct tx_ts_record *ts = NULL;
 	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
 
 	if (rtllib_act_scanning(ieee, false))
@@ -289,25 +289,25 @@ static void rtllib_tx_query_agg_cap(struct rtllib_device *ieee,
 	if (!ieee->GetNmodeSupportBySecCfg(ieee->dev))
 		return;
 	if (ht_info->current_ampdu_enable) {
-		if (!rtllib_get_ts(ieee, (struct ts_common_info **)(&pTxTs), hdr->addr1,
+		if (!rtllib_get_ts(ieee, (struct ts_common_info **)(&ts), hdr->addr1,
 			   skb->priority, TX_DIR, true)) {
 			netdev_info(ieee->dev, "%s: can't get TS\n", __func__);
 			return;
 		}
-		if (!pTxTs->TxAdmittedBARecord.b_valid) {
+		if (!ts->TxAdmittedBARecord.b_valid) {
 			if (ieee->wpa_ie_len && (ieee->pairwise_key_type ==
 			    KEY_TYPE_NA)) {
 				;
 			} else if (tcb_desc->bdhcp == 1) {
 				;
-			} else if (!pTxTs->disable_add_ba) {
-				TsStartAddBaProcess(ieee, pTxTs);
+			} else if (!ts->disable_add_ba) {
+				TsStartAddBaProcess(ieee, ts);
 			}
 			goto FORCED_AGG_SETTING;
-		} else if (!pTxTs->using_ba) {
-			if (SN_LESS(pTxTs->TxAdmittedBARecord.ba_start_seq_ctrl.field.seq_num,
-				    (pTxTs->TxCurSeq + 1) % 4096))
-				pTxTs->using_ba = true;
+		} else if (!ts->using_ba) {
+			if (SN_LESS(ts->TxAdmittedBARecord.ba_start_seq_ctrl.field.seq_num,
+				    (ts->TxCurSeq + 1) % 4096))
+				ts->using_ba = true;
 			else
 				goto FORCED_AGG_SETTING;
 		}
-- 
2.39.2

