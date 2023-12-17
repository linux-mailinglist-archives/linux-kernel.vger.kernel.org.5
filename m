Return-Path: <linux-kernel+bounces-2883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2483816399
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 00:56:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E3011F209B7
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 23:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64B754D58B;
	Sun, 17 Dec 2023 23:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="lza6wNKF"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF074BA8D
	for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 23:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-6d9d4193d94so2207552a34.3
        for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 15:55:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1702857328; x=1703462128; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eXLxevf4aUXA3wWWgPdFXar5eXPkWv3zOFKTufedNbo=;
        b=lza6wNKFNCQ4iqr9yt039GW22fEhUKCUgIzk4Pv07tXWYB0aohFLuS82OrKtR6gQN5
         pUWMbAZ9Ds9N3Wk2pyzQuyhA+fEpRBRFmwsZWTRe+L7qqRVds4sk0o0PxQKUVTluZDeB
         NdmKHAvcVqZ0b4UeQP/nk3pLPU62YCFNi2oxFe6rQ0p3/7e5Y3vsncjovbb5zSDJvO7C
         IWfO1RKfE8NWDt++x5OVVaZzGjowrI1GvvI8luhthge1lkor2u+wLDQ+3FqS954rDD6x
         GxTIr1NI4lfhKYf0Xs6ZnqJJISJn+/W3L5J5kpQ5sDu1oY/NX+Dy7gBdZFnQkiLMxHRS
         ZHvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702857328; x=1703462128;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eXLxevf4aUXA3wWWgPdFXar5eXPkWv3zOFKTufedNbo=;
        b=t0BUh8Ej6NV7gA7sbAojIrLuk/nquHO5wb/4+t1hNaOFjoWYRrHxQcDQOQ/1MF9drG
         mszHml3+9ITkifAqRsnAYsEZXoS5tEl+k7wxriHpaiYYJJHT/mr06nRW0G7AWeBZ0Cfg
         C+xSXlxurTG//dP6LlFAIZGjTXAFjKU0A+MrOtszHblku27rPl8G4R+Eo4sPfVWdOBeo
         VWMVGNuOQl4wpMVJ/kAElzlPibaYgTyQNgbjBh709rhl4tAj8rsv6bePVKRemGWO6b6L
         GcNuUtOU/tOEmqexA505fenYP+HVt7GamMVStPKq2I5oFwfENq9eI5wVUei5P5b5oTNY
         4MNA==
X-Gm-Message-State: AOJu0YznSN1yeNwzMiPJUAtn9h6m3mOk+2UFPKDggwnQY34VE+vt04H+
	aCw1BkvgDa3N47FdLYwpMNLVRw==
X-Google-Smtp-Source: AGHT+IFoDEcFFi84M0TkMIePMPCmlNMXHemUSrGClgJxG96jTzzaqKgtRjJRCgD8WpaQ+GxXtCuDbA==
X-Received: by 2002:a05:6358:e48b:b0:172:d78b:d2eb with SMTP id by11-20020a056358e48b00b00172d78bd2ebmr1473446rwb.10.1702857328274;
        Sun, 17 Dec 2023 15:55:28 -0800 (PST)
Received: from oatmeal.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id f11-20020a17090aec8b00b0028ae8284840sm9036176pjy.10.2023.12.17.15.55.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Dec 2023 15:55:27 -0800 (PST)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 5/6] Staging: rtl8192e: Rename variable TxRxSelect
Date: Sun, 17 Dec 2023 15:55:19 -0800
Message-Id: <20231217235520.30377-6-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231217235520.30377-1-tdavies@darkphysics.net>
References: <20231217235520.30377-1-tdavies@darkphysics.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename variable TxRxSelect to tx_rx_select to fix checkpatch
warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtl819x_BAProc.c | 18 ++++++++---------
 drivers/staging/rtl8192e/rtl819x_TSProc.c | 24 +++++++++++------------
 drivers/staging/rtl8192e/rtllib.h         |  4 ++--
 3 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_BAProc.c b/drivers/staging/rtl8192e/rtl819x_BAProc.c
index 2fd54312c04f..b816f94336f0 100644
--- a/drivers/staging/rtl8192e/rtl819x_BAProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_BAProc.c
@@ -125,7 +125,7 @@ static struct sk_buff *rtllib_ADDBA(struct rtllib_device *ieee, u8 *dst,
 
 static struct sk_buff *rtllib_DELBA(struct rtllib_device *ieee, u8 *dst,
 				    struct ba_record *ba,
-				    enum tr_select TxRxSelect, u16 reason_code)
+				    enum tr_select tx_rx_select, u16 reason_code)
 {
 	union delba_param_set del_ba_param_set;
 	struct sk_buff *skb = NULL;
@@ -139,7 +139,7 @@ static struct sk_buff *rtllib_DELBA(struct rtllib_device *ieee, u8 *dst,
 
 	memset(&del_ba_param_set, 0, 2);
 
-	del_ba_param_set.field.initiator = (TxRxSelect == TX_DIR) ? 1 : 0;
+	del_ba_param_set.field.initiator = (tx_rx_select == TX_DIR) ? 1 : 0;
 	del_ba_param_set.field.tid	= ba->ba_param_set.field.tid;
 
 	skb = dev_alloc_skb(len + sizeof(struct ieee80211_hdr_3addr));
@@ -199,12 +199,12 @@ static void rtllib_send_ADDBARsp(struct rtllib_device *ieee, u8 *dst,
 }
 
 static void rtllib_send_DELBA(struct rtllib_device *ieee, u8 *dst,
-			      struct ba_record *ba, enum tr_select TxRxSelect,
+			      struct ba_record *ba, enum tr_select tx_rx_select,
 			      u16 reason_code)
 {
 	struct sk_buff *skb;
 
-	skb = rtllib_DELBA(ieee, dst, ba, TxRxSelect, reason_code);
+	skb = rtllib_DELBA(ieee, dst, ba, tx_rx_select, reason_code);
 	if (skb)
 		softmac_mgmt_xmit(skb, ieee);
 	else
@@ -486,9 +486,9 @@ void rtllib_ts_init_add_ba(struct rtllib_device *ieee, struct tx_ts_record *ts,
 
 void rtllib_ts_init_del_ba(struct rtllib_device *ieee,
 			   struct ts_common_info *ts_common_info,
-			   enum tr_select TxRxSelect)
+			   enum tr_select tx_rx_select)
 {
-	if (TxRxSelect == TX_DIR) {
+	if (tx_rx_select == TX_DIR) {
 		struct tx_ts_record *ts =
 			 (struct tx_ts_record *)ts_common_info;
 
@@ -497,14 +497,14 @@ void rtllib_ts_init_del_ba(struct rtllib_device *ieee,
 					  (ts->tx_admitted_ba_record.b_valid) ?
 					 (&ts->tx_admitted_ba_record) :
 					(&ts->tx_pending_ba_record),
-					 TxRxSelect, DELBA_REASON_END_BA);
-	} else if (TxRxSelect == RX_DIR) {
+					 tx_rx_select, DELBA_REASON_END_BA);
+	} else if (tx_rx_select == RX_DIR) {
 		struct rx_ts_record *ts =
 				 (struct rx_ts_record *)ts_common_info;
 		if (rx_ts_delete_ba(ieee, ts))
 			rtllib_send_DELBA(ieee, ts_common_info->addr,
 					  &ts->rx_admitted_ba_record,
-					  TxRxSelect, DELBA_REASON_END_BA);
+					  tx_rx_select, DELBA_REASON_END_BA);
 	}
 }
 
diff --git a/drivers/staging/rtl8192e/rtl819x_TSProc.c b/drivers/staging/rtl8192e/rtl819x_TSProc.c
index ad4d9e4c9b63..43b1e70b218b 100644
--- a/drivers/staging/rtl8192e/rtl819x_TSProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_TSProc.c
@@ -171,14 +171,14 @@ void rtllib_ts_init(struct rtllib_device *ieee)
 
 static struct ts_common_info *SearchAdmitTRStream(struct rtllib_device *ieee,
 						  u8 *addr, u8 TID,
-						  enum tr_select TxRxSelect)
+						  enum tr_select tx_rx_select)
 {
 	u8	dir;
 	bool	search_dir[4] = {0};
 	struct list_head *psearch_list;
 	struct ts_common_info *pRet = NULL;
 
-	if (TxRxSelect == TX_DIR) {
+	if (tx_rx_select == TX_DIR) {
 		search_dir[DIR_UP] = true;
 		search_dir[DIR_BI_DIR] = true;
 		search_dir[DIR_DIRECT] = true;
@@ -188,7 +188,7 @@ static struct ts_common_info *SearchAdmitTRStream(struct rtllib_device *ieee,
 		search_dir[DIR_DIRECT] = true;
 	}
 
-	if (TxRxSelect == TX_DIR)
+	if (tx_rx_select == TX_DIR)
 		psearch_list = &ieee->Tx_TS_Admit_List;
 	else
 		psearch_list = &ieee->Rx_TS_Admit_List;
@@ -225,7 +225,7 @@ static void MakeTSEntry(struct ts_common_info *ts_common_info, u8 *addr,
 }
 
 bool rtllib_get_ts(struct rtllib_device *ieee, struct ts_common_info **ppTS,
-	   u8 *addr, u8 TID, enum tr_select TxRxSelect, bool bAddNewTs)
+	   u8 *addr, u8 TID, enum tr_select tx_rx_select, bool bAddNewTs)
 {
 	u8	UP = 0;
 	struct qos_tsinfo tspec;
@@ -265,7 +265,7 @@ bool rtllib_get_ts(struct rtllib_device *ieee, struct ts_common_info **ppTS,
 		}
 	}
 
-	*ppTS = SearchAdmitTRStream(ieee, addr, UP, TxRxSelect);
+	*ppTS = SearchAdmitTRStream(ieee, addr, UP, tx_rx_select);
 	if (*ppTS)
 		return true;
 
@@ -274,21 +274,21 @@ bool rtllib_get_ts(struct rtllib_device *ieee, struct ts_common_info **ppTS,
 		return false;
 	}
 
-	pUnusedList = (TxRxSelect == TX_DIR) ?
+	pUnusedList = (tx_rx_select == TX_DIR) ?
 				(&ieee->Tx_TS_Unused_List) :
 				(&ieee->Rx_TS_Unused_List);
 
-	pAddmitList = (TxRxSelect == TX_DIR) ?
+	pAddmitList = (tx_rx_select == TX_DIR) ?
 				(&ieee->Tx_TS_Admit_List) :
 				(&ieee->Rx_TS_Admit_List);
 
-	Dir = ((TxRxSelect == TX_DIR) ? DIR_UP : DIR_DOWN);
+	Dir = ((tx_rx_select == TX_DIR) ? DIR_UP : DIR_DOWN);
 
 	if (!list_empty(pUnusedList)) {
 		(*ppTS) = list_entry(pUnusedList->next,
 			  struct ts_common_info, List);
 		list_del_init(&(*ppTS)->List);
-		if (TxRxSelect == TX_DIR) {
+		if (tx_rx_select == TX_DIR) {
 			struct tx_ts_record *tmp =
 				container_of(*ppTS,
 				struct tx_ts_record,
@@ -321,11 +321,11 @@ bool rtllib_get_ts(struct rtllib_device *ieee, struct ts_common_info **ppTS,
 }
 
 static void RemoveTsEntry(struct rtllib_device *ieee,
-			  struct ts_common_info *pTs, enum tr_select TxRxSelect)
+			  struct ts_common_info *pTs, enum tr_select tx_rx_select)
 {
-	rtllib_ts_init_del_ba(ieee, pTs, TxRxSelect);
+	rtllib_ts_init_del_ba(ieee, pTs, tx_rx_select);
 
-	if (TxRxSelect == RX_DIR) {
+	if (tx_rx_select == RX_DIR) {
 		struct rx_reorder_entry *pRxReorderEntry;
 		struct rx_ts_record *ts = (struct rx_ts_record *)pTs;
 
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index d8da772b0f39..870720a12a48 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1778,13 +1778,13 @@ void rtllib_ts_init_add_ba(struct rtllib_device *ieee, struct tx_ts_record *ts,
 			   u8 policy, u8 overwrite_pending);
 void rtllib_ts_init_del_ba(struct rtllib_device *ieee,
 			   struct ts_common_info *ts_common_info,
-			   enum tr_select TxRxSelect);
+			   enum tr_select tx_rx_select);
 void rtllib_ba_setup_timeout(struct timer_list *t);
 void rtllib_tx_ba_inact_timeout(struct timer_list *t);
 void rtllib_rx_ba_inact_timeout(struct timer_list *t);
 void rtllib_reset_ba_entry(struct ba_record *ba);
 bool rtllib_get_ts(struct rtllib_device *ieee, struct ts_common_info **ppTS, u8 *addr,
-	   u8 TID, enum tr_select TxRxSelect, bool bAddNewTs);
+	   u8 TID, enum tr_select tx_rx_select, bool bAddNewTs);
 void rtllib_ts_init(struct rtllib_device *ieee);
 void TsStartAddBaProcess(struct rtllib_device *ieee,
 			 struct tx_ts_record *pTxTS);
-- 
2.39.2


