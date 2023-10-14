Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3630C7C92C7
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 06:40:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232865AbjJNEkJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Oct 2023 00:40:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232750AbjJNEkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Oct 2023 00:40:01 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9766AC9
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 21:39:59 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-6b1ef786b7fso1289350b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 21:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1697258399; x=1697863199; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZCtkeW/AAlax77ncRvuWSk8ePDTDANoORemX0QeR1v4=;
        b=XiCIkw43YRLBmaQjbDAZGXsgoXGCxtg8knVheZfQ70SSTnWcHiZ76ztKt4+PAV/Fhe
         dS2vCTnlENNQI+ygKVnHmJ3Tt7vzjqHYx8g2CQnVvHRabxoSG1dBaMrxUx4xihQouPV0
         OjukRWp+tLFqfa+XzyeCOVPzCvmIKZl846GJof8sbkPHpfCxtG7+Y1pb5so6RbKKO0wS
         drkIrBXW4ccx6JnCLB1DUkRfUh6PWn/ZjLRgT0kUQtocROvbsbWNQVSVOF/20NsBQqLA
         AeHtHav9OElU6KU6XfeOxJTybC88RIlOpvgqGs47cs2XD0ULSpBbp5lNCf5J7VKBBg1y
         AX7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697258399; x=1697863199;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZCtkeW/AAlax77ncRvuWSk8ePDTDANoORemX0QeR1v4=;
        b=LpP+c201RXhjnNuuv/zfTIIc2+8srBr1FnYU4H4Il6m4MrG3bgzGe1UtsyuLoYU+Sh
         eNGstKEXeCvRVoFbafeohk7XAGXcl68ngaylFb2rQRPnyN+YvlG2Ib7Y5iN+IqhsUEdc
         sAOuE8lrWmdYvt74yZvyoR47uZznv4IYBTAwVRVtLAAiiKV+MY39u/RuUvMPpCoOfHXN
         lNr0qPCr/6dHTTvtbCL9mZ8bBB48locnSnX0MrfysgV9FsTs3B70LEt6uFi9O3G+P/Gz
         TpZHFGCLkWF9Pny+zdx+rmgmvBFoJNmlkGhyF1VV4iVUSnPQXJ7xgYakFXccFtzVhVB4
         3ABA==
X-Gm-Message-State: AOJu0YyC77CjovOaAi4hMCz0vYNyd7Egt/CXHyp+UWmDmGaFA/Kb+Kwh
        VQ37TFWq1zD8uo+M/FmXtXNYmA==
X-Google-Smtp-Source: AGHT+IHphIW8b8+6BhdaZDdR1ab6dBaJSJcnQh25oz7obhOf7iV0S07peSv/f8hN4VXgQScYwHfB4g==
X-Received: by 2002:a05:6a00:391b:b0:690:3793:17e5 with SMTP id fh27-20020a056a00391b00b00690379317e5mr35048571pfb.4.1697258398993;
        Fri, 13 Oct 2023 21:39:58 -0700 (PDT)
Received: from basil.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id y6-20020aa78046000000b006934350c3absm14271926pfm.109.2023.10.13.21.39.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 21:39:58 -0700 (PDT)
From:   Tree Davies <tdavies@darkphysics.net>
To:     gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com,
        anjan@momi.ca
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 4/4] Staging: rtl8192e: Rename variable pTS
Date:   Fri, 13 Oct 2023 21:44:35 -0700
Message-ID: <20231014044435.11947-5-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231014044435.11947-1-tdavies@darkphysics.net>
References: <20231014044435.11947-1-tdavies@darkphysics.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NO_DNS_FOR_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename variable pTS to ts to fix checkpatch warning
Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtl819x_BAProc.c | 26 +++----
 drivers/staging/rtl8192e/rtl819x_TSProc.c | 94 +++++++++++------------
 drivers/staging/rtl8192e/rtllib.h         |  2 +-
 drivers/staging/rtl8192e/rtllib_tx.c      |  8 +-
 4 files changed, 65 insertions(+), 65 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_BAProc.c b/drivers/staging/rtl8192e/rtl819x_BAProc.c
index 34fc400035c8..93b566482149 100644
--- a/drivers/staging/rtl8192e/rtl819x_BAProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_BAProc.c
@@ -304,7 +304,7 @@ int rtllib_rx_ADDBARsp(struct rtllib_device *ieee, struct sk_buff *skb)
 {
 	struct ieee80211_hdr_3addr *rsp = NULL;
 	struct ba_record *pending_ba, *pAdmittedBA;
-	struct tx_ts_record *pTS = NULL;
+	struct tx_ts_record *ts = NULL;
 	u8 *dst = NULL, *pDialogToken = NULL, *tag = NULL;
 	u16 *status_code = NULL, *pBaTimeoutVal = NULL;
 	union ba_param_set *pBaParamSet = NULL;
@@ -337,16 +337,16 @@ int rtllib_rx_ADDBARsp(struct rtllib_device *ieee, struct sk_buff *skb)
 		goto OnADDBARsp_Reject;
 	}
 
-	if (!rtllib_get_ts(ieee, (struct ts_common_info **)&pTS, dst,
+	if (!rtllib_get_ts(ieee, (struct ts_common_info **)&ts, dst,
 		   (u8)(pBaParamSet->field.tid), TX_DIR, false)) {
 		netdev_warn(ieee->dev, "%s(): can't get TS\n", __func__);
 		reason_code = DELBA_REASON_UNKNOWN_BA;
 		goto OnADDBARsp_Reject;
 	}
 
-	pTS->bAddBaReqInProgress = false;
-	pending_ba = &pTS->TxPendingBARecord;
-	pAdmittedBA = &pTS->TxAdmittedBARecord;
+	ts->bAddBaReqInProgress = false;
+	pending_ba = &ts->TxPendingBARecord;
+	pAdmittedBA = &ts->TxAdmittedBARecord;
 
 	if (pAdmittedBA->b_valid) {
 		netdev_dbg(ieee->dev, "%s(): ADDBA response already admitted\n",
@@ -368,7 +368,7 @@ int rtllib_rx_ADDBARsp(struct rtllib_device *ieee, struct sk_buff *skb)
 
 	if (*status_code == ADDBA_STATUS_SUCCESS) {
 		if (pBaParamSet->field.ba_policy == BA_POLICY_DELAYED) {
-			pTS->bAddBaReqDelayed = true;
+			ts->bAddBaReqDelayed = true;
 			deactivate_ba_entry(ieee, pAdmittedBA);
 			reason_code = DELBA_REASON_END_BA;
 			goto OnADDBARsp_Reject;
@@ -381,8 +381,8 @@ int rtllib_rx_ADDBARsp(struct rtllib_device *ieee, struct sk_buff *skb)
 		deactivate_ba_entry(ieee, pAdmittedBA);
 		activate_ba_entry(pAdmittedBA, *pBaTimeoutVal);
 	} else {
-		pTS->bAddBaReqDelayed = true;
-		pTS->bDisable_AddBa = true;
+		ts->bAddBaReqDelayed = true;
+		ts->bDisable_AddBa = true;
 		reason_code = DELBA_REASON_END_BA;
 		goto OnADDBARsp_Reject;
 	}
@@ -461,10 +461,10 @@ int rtllib_rx_DELBA(struct rtllib_device *ieee, struct sk_buff *skb)
 	return 0;
 }
 
-void rtllib_ts_init_add_ba(struct rtllib_device *ieee, struct tx_ts_record *pTS,
+void rtllib_ts_init_add_ba(struct rtllib_device *ieee, struct tx_ts_record *ts,
 			   u8 policy, u8	bOverwritePending)
 {
-	struct ba_record *ba = &pTS->TxPendingBARecord;
+	struct ba_record *ba = &ts->TxPendingBARecord;
 
 	if (ba->b_valid && !bOverwritePending)
 		return;
@@ -474,14 +474,14 @@ void rtllib_ts_init_add_ba(struct rtllib_device *ieee, struct tx_ts_record *pTS,
 	ba->dialog_token++;
 	ba->ba_param_set.field.amsdu_support = 0;
 	ba->ba_param_set.field.ba_policy = policy;
-	ba->ba_param_set.field.tid = pTS->TsCommonInfo.TSpec.f.ts_info.field.ucTSID;
+	ba->ba_param_set.field.tid = ts->TsCommonInfo.TSpec.f.ts_info.field.ucTSID;
 	ba->ba_param_set.field.buffer_size = 32;
 	ba->ba_timeout_value = 0;
-	ba->ba_start_seq_ctrl.field.seq_num = (pTS->TxCurSeq + 3) % 4096;
+	ba->ba_start_seq_ctrl.field.seq_num = (ts->TxCurSeq + 3) % 4096;
 
 	activate_ba_entry(ba, BA_SETUP_TIMEOUT);
 
-	rtllib_send_ADDBAReq(ieee, pTS->TsCommonInfo.addr, ba);
+	rtllib_send_ADDBAReq(ieee, ts->TsCommonInfo.addr, ba);
 }
 
 void rtllib_ts_init_del_ba(struct rtllib_device *ieee,
diff --git a/drivers/staging/rtl8192e/rtl819x_TSProc.c b/drivers/staging/rtl8192e/rtl819x_TSProc.c
index 16d5164e860d..95e735c078e4 100644
--- a/drivers/staging/rtl8192e/rtl819x_TSProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_TSProc.c
@@ -100,16 +100,16 @@ static void ResetTsCommonInfo(struct ts_common_info *pTsCommonInfo)
 	pTsCommonInfo->TClasNum = 0;
 }
 
-static void ResetTxTsEntry(struct tx_ts_record *pTS)
+static void ResetTxTsEntry(struct tx_ts_record *ts)
 {
-	ResetTsCommonInfo(&pTS->TsCommonInfo);
-	pTS->TxCurSeq = 0;
-	pTS->bAddBaReqInProgress = false;
-	pTS->bAddBaReqDelayed = false;
-	pTS->bUsingBa = false;
-	pTS->bDisable_AddBa = false;
-	rtllib_reset_ba_entry(&pTS->TxAdmittedBARecord);
-	rtllib_reset_ba_entry(&pTS->TxPendingBARecord);
+	ResetTsCommonInfo(&ts->TsCommonInfo);
+	ts->TxCurSeq = 0;
+	ts->bAddBaReqInProgress = false;
+	ts->bAddBaReqDelayed = false;
+	ts->bUsingBa = false;
+	ts->bDisable_AddBa = false;
+	rtllib_reset_ba_entry(&ts->TxAdmittedBARecord);
+	rtllib_reset_ba_entry(&ts->TxPendingBARecord);
 }
 
 static void ResetRxTsEntry(struct rx_ts_record *ts)
@@ -382,41 +382,41 @@ static void RemoveTsEntry(struct rtllib_device *ieee,
 
 void RemovePeerTS(struct rtllib_device *ieee, u8 *addr)
 {
-	struct ts_common_info *pTS, *pTmpTS;
+	struct ts_common_info *ts, *pTmpTS;
 
 	netdev_info(ieee->dev, "===========>%s, %pM\n", __func__, addr);
 
-	list_for_each_entry_safe(pTS, pTmpTS, &ieee->Tx_TS_Pending_List, List) {
-		if (memcmp(pTS->addr, addr, 6) == 0) {
-			RemoveTsEntry(ieee, pTS, TX_DIR);
-			list_del_init(&pTS->List);
-			list_add_tail(&pTS->List, &ieee->Tx_TS_Unused_List);
+	list_for_each_entry_safe(ts, pTmpTS, &ieee->Tx_TS_Pending_List, List) {
+		if (memcmp(ts->addr, addr, 6) == 0) {
+			RemoveTsEntry(ieee, ts, TX_DIR);
+			list_del_init(&ts->List);
+			list_add_tail(&ts->List, &ieee->Tx_TS_Unused_List);
 		}
 	}
 
-	list_for_each_entry_safe(pTS, pTmpTS, &ieee->Tx_TS_Admit_List, List) {
-		if (memcmp(pTS->addr, addr, 6) == 0) {
+	list_for_each_entry_safe(ts, pTmpTS, &ieee->Tx_TS_Admit_List, List) {
+		if (memcmp(ts->addr, addr, 6) == 0) {
 			netdev_info(ieee->dev,
 				    "====>remove Tx_TS_admin_list\n");
-			RemoveTsEntry(ieee, pTS, TX_DIR);
-			list_del_init(&pTS->List);
-			list_add_tail(&pTS->List, &ieee->Tx_TS_Unused_List);
+			RemoveTsEntry(ieee, ts, TX_DIR);
+			list_del_init(&ts->List);
+			list_add_tail(&ts->List, &ieee->Tx_TS_Unused_List);
 		}
 	}
 
-	list_for_each_entry_safe(pTS, pTmpTS, &ieee->Rx_TS_Pending_List, List) {
-		if (memcmp(pTS->addr, addr, 6) == 0) {
-			RemoveTsEntry(ieee, pTS, RX_DIR);
-			list_del_init(&pTS->List);
-			list_add_tail(&pTS->List, &ieee->Rx_TS_Unused_List);
+	list_for_each_entry_safe(ts, pTmpTS, &ieee->Rx_TS_Pending_List, List) {
+		if (memcmp(ts->addr, addr, 6) == 0) {
+			RemoveTsEntry(ieee, ts, RX_DIR);
+			list_del_init(&ts->List);
+			list_add_tail(&ts->List, &ieee->Rx_TS_Unused_List);
 		}
 	}
 
-	list_for_each_entry_safe(pTS, pTmpTS, &ieee->Rx_TS_Admit_List, List) {
-		if (memcmp(pTS->addr, addr, 6) == 0) {
-			RemoveTsEntry(ieee, pTS, RX_DIR);
-			list_del_init(&pTS->List);
-			list_add_tail(&pTS->List, &ieee->Rx_TS_Unused_List);
+	list_for_each_entry_safe(ts, pTmpTS, &ieee->Rx_TS_Admit_List, List) {
+		if (memcmp(ts->addr, addr, 6) == 0) {
+			RemoveTsEntry(ieee, ts, RX_DIR);
+			list_del_init(&ts->List);
+			list_add_tail(&ts->List, &ieee->Rx_TS_Unused_List);
 		}
 	}
 }
@@ -424,30 +424,30 @@ EXPORT_SYMBOL(RemovePeerTS);
 
 void RemoveAllTS(struct rtllib_device *ieee)
 {
-	struct ts_common_info *pTS, *pTmpTS;
+	struct ts_common_info *ts, *pTmpTS;
 
-	list_for_each_entry_safe(pTS, pTmpTS, &ieee->Tx_TS_Pending_List, List) {
-		RemoveTsEntry(ieee, pTS, TX_DIR);
-		list_del_init(&pTS->List);
-		list_add_tail(&pTS->List, &ieee->Tx_TS_Unused_List);
+	list_for_each_entry_safe(ts, pTmpTS, &ieee->Tx_TS_Pending_List, List) {
+		RemoveTsEntry(ieee, ts, TX_DIR);
+		list_del_init(&ts->List);
+		list_add_tail(&ts->List, &ieee->Tx_TS_Unused_List);
 	}
 
-	list_for_each_entry_safe(pTS, pTmpTS, &ieee->Tx_TS_Admit_List, List) {
-		RemoveTsEntry(ieee, pTS, TX_DIR);
-		list_del_init(&pTS->List);
-		list_add_tail(&pTS->List, &ieee->Tx_TS_Unused_List);
+	list_for_each_entry_safe(ts, pTmpTS, &ieee->Tx_TS_Admit_List, List) {
+		RemoveTsEntry(ieee, ts, TX_DIR);
+		list_del_init(&ts->List);
+		list_add_tail(&ts->List, &ieee->Tx_TS_Unused_List);
 	}
 
-	list_for_each_entry_safe(pTS, pTmpTS, &ieee->Rx_TS_Pending_List, List) {
-		RemoveTsEntry(ieee, pTS, RX_DIR);
-		list_del_init(&pTS->List);
-		list_add_tail(&pTS->List, &ieee->Rx_TS_Unused_List);
+	list_for_each_entry_safe(ts, pTmpTS, &ieee->Rx_TS_Pending_List, List) {
+		RemoveTsEntry(ieee, ts, RX_DIR);
+		list_del_init(&ts->List);
+		list_add_tail(&ts->List, &ieee->Rx_TS_Unused_List);
 	}
 
-	list_for_each_entry_safe(pTS, pTmpTS, &ieee->Rx_TS_Admit_List, List) {
-		RemoveTsEntry(ieee, pTS, RX_DIR);
-		list_del_init(&pTS->List);
-		list_add_tail(&pTS->List, &ieee->Rx_TS_Unused_List);
+	list_for_each_entry_safe(ts, pTmpTS, &ieee->Rx_TS_Admit_List, List) {
+		RemoveTsEntry(ieee, ts, RX_DIR);
+		list_del_init(&ts->List);
+		list_add_tail(&ts->List, &ieee->Rx_TS_Unused_List);
 	}
 }
 
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index b12a39ecdd9d..64a846af8679 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1788,7 +1788,7 @@ u16  TxCountToDataRate(struct rtllib_device *ieee, u8 nDataRate);
 int rtllib_rx_ADDBAReq(struct rtllib_device *ieee, struct sk_buff *skb);
 int rtllib_rx_ADDBARsp(struct rtllib_device *ieee, struct sk_buff *skb);
 int rtllib_rx_DELBA(struct rtllib_device *ieee, struct sk_buff *skb);
-void rtllib_ts_init_add_ba(struct rtllib_device *ieee, struct tx_ts_record *pTS,
+void rtllib_ts_init_add_ba(struct rtllib_device *ieee, struct tx_ts_record *ts,
 			   u8 policy, u8 bOverwritePending);
 void rtllib_ts_init_del_ba(struct rtllib_device *ieee,
 			   struct ts_common_info *pTsCommonInfo,
diff --git a/drivers/staging/rtl8192e/rtllib_tx.c b/drivers/staging/rtl8192e/rtllib_tx.c
index 8d8ce22c5f09..9bf679438ad1 100644
--- a/drivers/staging/rtl8192e/rtllib_tx.c
+++ b/drivers/staging/rtl8192e/rtllib_tx.c
@@ -495,13 +495,13 @@ static u16 rtllib_query_seqnum(struct rtllib_device *ieee, struct sk_buff *skb,
 	if (is_multicast_ether_addr(dst))
 		return 0;
 	if (IsQoSDataFrame(skb->data)) {
-		struct tx_ts_record *pTS = NULL;
+		struct tx_ts_record *ts = NULL;
 
-		if (!rtllib_get_ts(ieee, (struct ts_common_info **)(&pTS), dst,
+		if (!rtllib_get_ts(ieee, (struct ts_common_info **)(&ts), dst,
 			   skb->priority, TX_DIR, true))
 			return 0;
-		seqnum = pTS->TxCurSeq;
-		pTS->TxCurSeq = (pTS->TxCurSeq + 1) % 4096;
+		seqnum = ts->TxCurSeq;
+		ts->TxCurSeq = (ts->TxCurSeq + 1) % 4096;
 		return seqnum;
 	}
 	return 0;
-- 
2.39.2

