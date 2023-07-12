Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FDAB75148C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 01:36:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232547AbjGLXgz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 19:36:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231237AbjGLXgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 19:36:52 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B33D419B4
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 16:36:50 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F314F188139;
        Wed, 12 Jul 2023 19:36:49 -0400 (EDT)
        (envelope-from tdavies@darkphysics.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=date:from
        :to:cc:subject:message-id:mime-version:content-type; s=sasl; bh=
        COUTYsUyLILoRs96NQ5wzPfXSdx/NJTsrx9FChTnJ7A=; b=TANULkCTr7F9EJrf
        tSuwxVJyXZTmysrAnqH2BFBPUbpCQLiFhLc1Lxm4aaWshBptHbfxPFsEsnk/BnXt
        DVSE0kWzuiA5o72QHOCm+d17/LyQnXRfe9QVcbgCu1P2ohdGQqARjzU8CEuhCM2L
        PCWxbpzyBGr5hu6klB1ezySlk1k=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EC939188138;
        Wed, 12 Jul 2023 19:36:49 -0400 (EDT)
        (envelope-from tdavies@darkphysics.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=darkphysics.net;
 h=date:from:to:cc:subject:message-id:mime-version:content-type;
 s=2019-09.pbsmtp; bh=COUTYsUyLILoRs96NQ5wzPfXSdx/NJTsrx9FChTnJ7A=;
 b=dDcoDKjOTTKFhFv86Sn6YFpDmhVqRFy0qo0vPivxeHzvBnci3rAm7oWRdJqFBgGA/6EXeL+KjoQ0oJQLPQ+yZzso9qHT5Kzy0dgNE5VQWzOBcQE06PEGH6F1MJGoJ+Ti4SNV/DNdYp6LcEeAFRrPwUBSBQbTuV9vxeVczQylLnc=
Received: from basil (unknown [76.146.178.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 73669188136;
        Wed, 12 Jul 2023 19:36:48 -0400 (EDT)
        (envelope-from tdavies@darkphysics.net)
Date:   Wed, 12 Jul 2023 16:37:31 -0700
From:   Tree Davies <tdavies@darkphysics.net>
To:     gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com,
        anjan@momi.ca, error27@gmail.com
Cc:     tdavies@darkphysics.net, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 11/12] Staging: rtl8192e: Rename variable pTxTs
Message-ID: <ZK85Ow3Xe8OApBSt@basil>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Pobox-Relay-ID: F8AB6F56-210C-11EE-9782-C65BE52EC81B-45285927!pb-smtp1.pobox.com
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NO_DNS_FOR_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename variable pTxTs to ptx_ts in order to fix
checkpatch warning: Avoid CamelCase

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtl819x_BAProc.c | 54 +++++++++++------------
 drivers/staging/rtl8192e/rtl819x_TSProc.c |  8 ++--
 drivers/staging/rtl8192e/rtllib_tx.c      | 18 ++++----
 3 files changed, 40 insertions(+), 40 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_BAProc.c b/drivers/staging/rtl8192e/rtl819x_BAProc.c
index f64534d14104..bb9705222bc7 100644
--- a/drivers/staging/rtl8192e/rtl819x_BAProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_BAProc.c
@@ -23,10 +23,10 @@ static void deactivate_ba_entry(struct rtllib_device *ieee, struct ba_record *pb
 	del_timer_sync(&pba->timer);
 }
 
-static u8 tx_ts_delete_ba(struct rtllib_device *ieee, struct tx_ts_record *pTxTs)
+static u8 tx_ts_delete_ba(struct rtllib_device *ieee, struct tx_ts_record *ptx_ts)
 {
-	struct ba_record *pAdmittedBa = &pTxTs->TxAdmittedBARecord;
-	struct ba_record *pPendingBa = &pTxTs->TxPendingBARecord;
+	struct ba_record *padmitted_ba = &ptx_ts->TxAdmittedBARecord;
+	struct ba_record *pPendingBa = &ptx_ts->TxPendingBARecord;
 	u8 bSendDELBA = false;
 
 	if (pPendingBa->b_valid) {
@@ -34,8 +34,8 @@ static u8 tx_ts_delete_ba(struct rtllib_device *ieee, struct tx_ts_record *pTxTs
 		bSendDELBA = true;
 	}
 
-	if (pAdmittedBa->b_valid) {
-		deactivate_ba_entry(ieee, pAdmittedBa);
+	if (padmitted_ba->b_valid) {
+		deactivate_ba_entry(ieee, padmitted_ba);
 		bSendDELBA = true;
 	}
 	return bSendDELBA;
@@ -443,20 +443,20 @@ int rtllib_rx_DELBA(struct rtllib_device *ieee, struct sk_buff *skb)
 
 		RxTsDeleteBA(ieee, pRxTs);
 	} else {
-		struct tx_ts_record *pTxTs;
+		struct tx_ts_record *ptx_ts;
 
-		if (!GetTs(ieee, (struct ts_common_info **)&pTxTs, dst,
+		if (!GetTs(ieee, (struct ts_common_info **)&ptx_ts, dst,
 			   (u8)pDelBaParamSet->field.tid, TX_DIR, false)) {
 			netdev_warn(ieee->dev, "%s(): can't get TS for TXTS\n",
 				    __func__);
 			return -1;
 		}
 
-		pTxTs->bUsingBa = false;
-		pTxTs->bAddBaReqInProgress = false;
-		pTxTs->bAddBaReqDelayed = false;
-		del_timer_sync(&pTxTs->TsAddBaTimer);
-		tx_ts_delete_ba(ieee, pTxTs);
+		ptx_ts->bUsingBa = false;
+		ptx_ts->bAddBaReqInProgress = false;
+		ptx_ts->bAddBaReqDelayed = false;
+		del_timer_sync(&ptx_ts->TsAddBaTimer);
+		tx_ts_delete_ba(ieee, ptx_ts);
 	}
 	return 0;
 }
@@ -489,14 +489,14 @@ void ts_init_del_ba(struct rtllib_device *ieee,
 		 enum tr_select TxRxSelect)
 {
 	if (TxRxSelect == TX_DIR) {
-		struct tx_ts_record *pTxTs =
+		struct tx_ts_record *ptx_ts =
 			 (struct tx_ts_record *)pTsCommonInfo;
 
-		if (tx_ts_delete_ba(ieee, pTxTs))
+		if (tx_ts_delete_ba(ieee, ptx_ts))
 			rtllib_send_DELBA(ieee, pTsCommonInfo->Addr,
-					  (pTxTs->TxAdmittedBARecord.b_valid) ?
-					 (&pTxTs->TxAdmittedBARecord) :
-					(&pTxTs->TxPendingBARecord),
+					  (ptx_ts->TxAdmittedBARecord.b_valid) ?
+					 (&ptx_ts->TxAdmittedBARecord) :
+					(&ptx_ts->TxPendingBARecord),
 					 TxRxSelect, DELBA_REASON_END_BA);
 	} else if (TxRxSelect == RX_DIR) {
 		struct rx_ts_record *pRxTs =
@@ -510,23 +510,23 @@ void ts_init_del_ba(struct rtllib_device *ieee,
 
 void ba_setup_time_out(struct timer_list *t)
 {
-	struct tx_ts_record *pTxTs = from_timer(pTxTs, t,
+	struct tx_ts_record *ptx_ts = from_timer(ptx_ts, t,
 					      TxPendingBARecord.timer);
 
-	pTxTs->bAddBaReqInProgress = false;
-	pTxTs->bAddBaReqDelayed = true;
-	pTxTs->TxPendingBARecord.b_valid = false;
+	ptx_ts->bAddBaReqInProgress = false;
+	ptx_ts->bAddBaReqDelayed = true;
+	ptx_ts->TxPendingBARecord.b_valid = false;
 }
 
 void tx_ba_inact_timeout(struct timer_list *t)
 {
-	struct tx_ts_record *pTxTs = from_timer(pTxTs, t,
+	struct tx_ts_record *ptx_ts = from_timer(ptx_ts, t,
 					      TxAdmittedBARecord.timer);
-	struct rtllib_device *ieee = container_of(pTxTs, struct rtllib_device,
-				     TxTsRecord[pTxTs->num]);
-	tx_ts_delete_ba(ieee, pTxTs);
-	rtllib_send_DELBA(ieee, pTxTs->TsCommonInfo.Addr,
-			  &pTxTs->TxAdmittedBARecord, TX_DIR,
+	struct rtllib_device *ieee = container_of(ptx_ts, struct rtllib_device,
+				     TxTsRecord[ptx_ts->num]);
+	tx_ts_delete_ba(ieee, ptx_ts);
+	rtllib_send_DELBA(ieee, ptx_ts->TsCommonInfo.Addr,
+			  &ptx_ts->TxAdmittedBARecord, TX_DIR,
 			  DELBA_REASON_TIMEOUT);
 }
 
diff --git a/drivers/staging/rtl8192e/rtl819x_TSProc.c b/drivers/staging/rtl8192e/rtl819x_TSProc.c
index 2f7d5324edb9..35c4083542fc 100644
--- a/drivers/staging/rtl8192e/rtl819x_TSProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_TSProc.c
@@ -91,12 +91,12 @@ static void RxPktPendingTimeout(struct timer_list *t)
 
 static void TsAddBaProcess(struct timer_list *t)
 {
-	struct tx_ts_record *pTxTs = from_timer(pTxTs, t, TsAddBaTimer);
-	u8 num = pTxTs->num;
-	struct rtllib_device *ieee = container_of(pTxTs, struct rtllib_device,
+	struct tx_ts_record *ptx_ts = from_timer(ptx_ts, t, TsAddBaTimer);
+	u8 num = ptx_ts->num;
+	struct rtllib_device *ieee = container_of(ptx_ts, struct rtllib_device,
 				     TxTsRecord[num]);
 
-	ts_init_add_ba(ieee, pTxTs, BA_POLICY_IMMEDIATE, false);
+	ts_init_add_ba(ieee, ptx_ts, BA_POLICY_IMMEDIATE, false);
 	netdev_dbg(ieee->dev, "%s(): ADDBA Req is started\n", __func__);
 }
 
diff --git a/drivers/staging/rtl8192e/rtllib_tx.c b/drivers/staging/rtl8192e/rtllib_tx.c
index ec038ef806c3..e43a9b26e01a 100644
--- a/drivers/staging/rtl8192e/rtllib_tx.c
+++ b/drivers/staging/rtl8192e/rtllib_tx.c
@@ -267,7 +267,7 @@ static void rtllib_tx_query_agg_cap(struct rtllib_device *ieee,
 				    struct cb_desc *tcb_desc)
 {
 	struct rt_hi_throughput *ht_info = ieee->ht_info;
-	struct tx_ts_record *pTxTs = NULL;
+	struct tx_ts_record *ptx_ts = NULL;
 	struct rtllib_hdr_1addr *hdr = (struct rtllib_hdr_1addr *)skb->data;
 
 	if (rtllib_act_scanning(ieee, false))
@@ -289,25 +289,25 @@ static void rtllib_tx_query_agg_cap(struct rtllib_device *ieee,
 	if (!ieee->GetNmodeSupportBySecCfg(ieee->dev))
 		return;
 	if (ht_info->bCurrentAMPDUEnable) {
-		if (!GetTs(ieee, (struct ts_common_info **)(&pTxTs), hdr->addr1,
+		if (!GetTs(ieee, (struct ts_common_info **)(&ptx_ts), hdr->addr1,
 			   skb->priority, TX_DIR, true)) {
 			netdev_info(ieee->dev, "%s: can't get TS\n", __func__);
 			return;
 		}
-		if (!pTxTs->TxAdmittedBARecord.b_valid) {
+		if (!ptx_ts->TxAdmittedBARecord.b_valid) {
 			if (ieee->wpa_ie_len && (ieee->pairwise_key_type ==
 			    KEY_TYPE_NA)) {
 				;
 			} else if (tcb_desc->bdhcp == 1) {
 				;
-			} else if (!pTxTs->bDisable_AddBa) {
-				TsStartAddBaProcess(ieee, pTxTs);
+			} else if (!ptx_ts->bDisable_AddBa) {
+				TsStartAddBaProcess(ieee, ptx_ts);
 			}
 			goto FORCED_AGG_SETTING;
-		} else if (!pTxTs->bUsingBa) {
-			if (SN_LESS(pTxTs->TxAdmittedBARecord.ba_start_seq_ctrl.field.seq_num,
-				    (pTxTs->TxCurSeq + 1) % 4096))
-				pTxTs->bUsingBa = true;
+		} else if (!ptx_ts->bUsingBa) {
+			if (SN_LESS(ptx_ts->TxAdmittedBARecord.ba_start_seq_ctrl.field.seq_num,
+				    (ptx_ts->TxCurSeq + 1) % 4096))
+				ptx_ts->bUsingBa = true;
 			else
 				goto FORCED_AGG_SETTING;
 		}
-- 
2.41.0

