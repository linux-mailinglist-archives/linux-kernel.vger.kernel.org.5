Return-Path: <linux-kernel+bounces-2361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2A39815BA4
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 21:20:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C06D285C62
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 20:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80E6D32C64;
	Sat, 16 Dec 2023 20:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="MsNvkgOJ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C9D328D6
	for <linux-kernel@vger.kernel.org>; Sat, 16 Dec 2023 20:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-20308664c13so1312436fac.3
        for <linux-kernel@vger.kernel.org>; Sat, 16 Dec 2023 12:20:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1702758042; x=1703362842; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CuhQHUQnlivRHSzEkdfbgbZucS3zTdYH+eKCFrlSDN8=;
        b=MsNvkgOJR27UO3SI89m1yw2wLTK8esE+GHJ1Xvd1OawGtQBszM634kTmbzu9jDydkg
         Rw/9JH9c0nX44SSLR0TBKMyyBiIxcA6eCHLzDR8qGj2V6aP1K/76v5hBg7gePWJfDIo0
         9LL8zh7H71KJtRHgHGZFYtIIYjXJnofqY6Fp3jfD0oAEev0GVhzVTRr7G5Vws1z9SUM1
         DsOabPBWeQLdsZ643P0JM+XP6GjDGSPBy0V1etYmA7iD/y7UXcr5E0j6Q3y9JrUv4xty
         B93PgM5aDqoIEyPujsLn+Na52SOSQHuSDoFYeRog2OrKu4Di3QCwf8Sj0eJfVRQ0CJuO
         2zlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702758042; x=1703362842;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CuhQHUQnlivRHSzEkdfbgbZucS3zTdYH+eKCFrlSDN8=;
        b=WWiMHwm2OrWXc13BHe6T5I1lNpbJEweMLLfkcuuguY2GSQGsgNjGwVDczBSSRqXPJY
         /5Fip/yNCb2AxtIyIzotB8syXfqrJlBktA4aYNj9ctd4p//jbn1Oz1PrK46kf4+PC6kN
         EVgCMnd9TV8Vb8tTwNbwAL/WMyPB8QuMrHqx+NEWfisUvFUWxuAuXJUSvCPPXNyXBjAI
         Vgi/IKv4B3Asxxe2KYJb6eId06hs3sPE/4gqqR6SwmBx7mNZpXBhe58Pin8iKxOJ5BC2
         YBJcvVhVSfS9IdIXOjlrQXl3XpzRskDH3Wy1UkOB7G87vPq3/oCvvO0CXhRej8riT3TF
         DQxQ==
X-Gm-Message-State: AOJu0YxH96CGI9sezQmgfp92TohOl1xTgPTiNVSGesRAfCUvjqwyWuK5
	GeOR7uNhhpidosOOFJOBCKJcog==
X-Google-Smtp-Source: AGHT+IEnOiAT5YNlKUhyhhrWU3gBwiBXWTWom39K0PExRfwGHtngAGqurnlqTRJFDJGMHlatQccVIw==
X-Received: by 2002:a05:6870:ac10:b0:1fa:f152:9f70 with SMTP id kw16-20020a056870ac1000b001faf1529f70mr16621093oab.54.1702758042576;
        Sat, 16 Dec 2023 12:20:42 -0800 (PST)
Received: from oatmeal.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id 29-20020a17090a005d00b0028b470be8b6sm2085317pjb.8.2023.12.16.12.20.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Dec 2023 12:20:42 -0800 (PST)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH] Staging: rtl8192e: rename linked list reference: List
Date: Sat, 16 Dec 2023 12:20:38 -0800
Message-Id: <20231216202038.10777-1-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename variable List to list, to fix Avoid CamelCase checkpatch warning.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtl819x_TS.h     |  2 +-
 drivers/staging/rtl8192e/rtl819x_TSProc.c | 78 +++++++++++------------
 drivers/staging/rtl8192e/rtllib.h         |  2 +-
 drivers/staging/rtl8192e/rtllib_rx.c      | 30 ++++-----
 4 files changed, 56 insertions(+), 56 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_TS.h b/drivers/staging/rtl8192e/rtl819x_TS.h
index 31f7cfbb3aa5..5b0e4cb572d2 100644
--- a/drivers/staging/rtl8192e/rtl819x_TS.h
+++ b/drivers/staging/rtl8192e/rtl819x_TS.h
@@ -17,7 +17,7 @@ enum tr_select {
 };
 
 struct ts_common_info {
-	struct list_head		List;
+	struct list_head		list;
 	u8				addr[ETH_ALEN];
 	struct qos_tsinfo tspec;
 };
diff --git a/drivers/staging/rtl8192e/rtl819x_TSProc.c b/drivers/staging/rtl8192e/rtl819x_TSProc.c
index bec73bc53dd0..86db56f3900d 100644
--- a/drivers/staging/rtl8192e/rtl819x_TSProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_TSProc.c
@@ -25,7 +25,7 @@ static void RxPktPendingTimeout(struct timer_list *t)
 		while (!list_empty(&ts->rx_pending_pkt_list)) {
 			pReorderEntry = (struct rx_reorder_entry *)
 					list_entry(ts->rx_pending_pkt_list.prev,
-					struct rx_reorder_entry, List);
+					struct rx_reorder_entry, list);
 			if (index == 0)
 				ts->rx_indicate_seq = pReorderEntry->SeqNum;
 
@@ -33,7 +33,7 @@ static void RxPktPendingTimeout(struct timer_list *t)
 				    ts->rx_indicate_seq) ||
 			    SN_EQUAL(pReorderEntry->SeqNum,
 				     ts->rx_indicate_seq)) {
-				list_del_init(&pReorderEntry->List);
+				list_del_init(&pReorderEntry->list);
 
 				if (SN_EQUAL(pReorderEntry->SeqNum,
 				    ts->rx_indicate_seq))
@@ -47,7 +47,7 @@ static void RxPktPendingTimeout(struct timer_list *t)
 							 pReorderEntry->prxb;
 				index++;
 
-				list_add_tail(&pReorderEntry->List,
+				list_add_tail(&pReorderEntry->list,
 					      &ieee->RxReorder_Unused_List);
 			} else {
 				bPktInBuf = true;
@@ -138,7 +138,7 @@ void rtllib_ts_init(struct rtllib_device *ieee)
 			    rtllib_tx_ba_inact_timeout, 0);
 
 		ResetTxTsEntry(pTxTS);
-		list_add_tail(&pTxTS->ts_common_info.List,
+		list_add_tail(&pTxTS->ts_common_info.list,
 				&ieee->Tx_TS_Unused_List);
 		pTxTS++;
 	}
@@ -155,13 +155,13 @@ void rtllib_ts_init(struct rtllib_device *ieee)
 		timer_setup(&rxts->rx_pkt_pending_timer, RxPktPendingTimeout, 0);
 
 		ResetRxTsEntry(rxts);
-		list_add_tail(&rxts->ts_common_info.List,
+		list_add_tail(&rxts->ts_common_info.list,
 			      &ieee->Rx_TS_Unused_List);
 		rxts++;
 	}
 	INIT_LIST_HEAD(&ieee->RxReorder_Unused_List);
 	for (count = 0; count < REORDER_ENTRY_NUM; count++) {
-		list_add_tail(&pRxReorderEntry->List,
+		list_add_tail(&pRxReorderEntry->list,
 			      &ieee->RxReorder_Unused_List);
 		if (count == (REORDER_ENTRY_NUM - 1))
 			break;
@@ -196,17 +196,17 @@ static struct ts_common_info *SearchAdmitTRStream(struct rtllib_device *ieee,
 	for (dir = 0; dir <= DIR_BI_DIR; dir++) {
 		if (!search_dir[dir])
 			continue;
-		list_for_each_entry(pRet, psearch_list, List) {
+		list_for_each_entry(pRet, psearch_list, list) {
 			if (memcmp(pRet->addr, addr, 6) == 0 &&
 			    pRet->tspec.ucTSID == TID &&
 			    pRet->tspec.ucDirection == dir)
 				break;
 		}
-		if (&pRet->List  != psearch_list)
+		if (&pRet->list  != psearch_list)
 			break;
 	}
 
-	if (pRet && &pRet->List  != psearch_list)
+	if (pRet && &pRet->list  != psearch_list)
 		return pRet;
 	return NULL;
 }
@@ -286,8 +286,8 @@ bool rtllib_get_ts(struct rtllib_device *ieee, struct ts_common_info **ppTS,
 
 	if (!list_empty(pUnusedList)) {
 		(*ppTS) = list_entry(pUnusedList->next,
-			  struct ts_common_info, List);
-		list_del_init(&(*ppTS)->List);
+			  struct ts_common_info, list);
+		list_del_init(&(*ppTS)->list);
 		if (TxRxSelect == TX_DIR) {
 			struct tx_ts_record *tmp =
 				container_of(*ppTS,
@@ -309,7 +309,7 @@ bool rtllib_get_ts(struct rtllib_device *ieee, struct ts_common_info **ppTS,
 		ts_info->ucDirection = Dir;
 
 		MakeTSEntry(*ppTS, addr, &tspec);
-		list_add_tail(&((*ppTS)->List), pAddmitList);
+		list_add_tail(&((*ppTS)->list), pAddmitList);
 
 		return true;
 	}
@@ -335,10 +335,10 @@ static void RemoveTsEntry(struct rtllib_device *ieee,
 		while (!list_empty(&ts->rx_pending_pkt_list)) {
 			pRxReorderEntry = (struct rx_reorder_entry *)
 					list_entry(ts->rx_pending_pkt_list.prev,
-					struct rx_reorder_entry, List);
+					struct rx_reorder_entry, list);
 			netdev_dbg(ieee->dev,  "%s(): Delete SeqNum %d!\n",
 				   __func__, pRxReorderEntry->SeqNum);
-			list_del_init(&pRxReorderEntry->List);
+			list_del_init(&pRxReorderEntry->list);
 			{
 				int i = 0;
 				struct rtllib_rxb *prxb = pRxReorderEntry->prxb;
@@ -350,7 +350,7 @@ static void RemoveTsEntry(struct rtllib_device *ieee,
 				kfree(prxb);
 				prxb = NULL;
 			}
-			list_add_tail(&pRxReorderEntry->List,
+			list_add_tail(&pRxReorderEntry->list,
 				      &ieee->RxReorder_Unused_List);
 		}
 	} else {
@@ -366,37 +366,37 @@ void RemovePeerTS(struct rtllib_device *ieee, u8 *addr)
 
 	netdev_info(ieee->dev, "===========>%s, %pM\n", __func__, addr);
 
-	list_for_each_entry_safe(ts, pTmpTS, &ieee->Tx_TS_Pending_List, List) {
+	list_for_each_entry_safe(ts, pTmpTS, &ieee->Tx_TS_Pending_List, list) {
 		if (memcmp(ts->addr, addr, 6) == 0) {
 			RemoveTsEntry(ieee, ts, TX_DIR);
-			list_del_init(&ts->List);
-			list_add_tail(&ts->List, &ieee->Tx_TS_Unused_List);
+			list_del_init(&ts->list);
+			list_add_tail(&ts->list, &ieee->Tx_TS_Unused_List);
 		}
 	}
 
-	list_for_each_entry_safe(ts, pTmpTS, &ieee->Tx_TS_Admit_List, List) {
+	list_for_each_entry_safe(ts, pTmpTS, &ieee->Tx_TS_Admit_List, list) {
 		if (memcmp(ts->addr, addr, 6) == 0) {
 			netdev_info(ieee->dev,
 				    "====>remove Tx_TS_admin_list\n");
 			RemoveTsEntry(ieee, ts, TX_DIR);
-			list_del_init(&ts->List);
-			list_add_tail(&ts->List, &ieee->Tx_TS_Unused_List);
+			list_del_init(&ts->list);
+			list_add_tail(&ts->list, &ieee->Tx_TS_Unused_List);
 		}
 	}
 
-	list_for_each_entry_safe(ts, pTmpTS, &ieee->Rx_TS_Pending_List, List) {
+	list_for_each_entry_safe(ts, pTmpTS, &ieee->Rx_TS_Pending_List, list) {
 		if (memcmp(ts->addr, addr, 6) == 0) {
 			RemoveTsEntry(ieee, ts, RX_DIR);
-			list_del_init(&ts->List);
-			list_add_tail(&ts->List, &ieee->Rx_TS_Unused_List);
+			list_del_init(&ts->list);
+			list_add_tail(&ts->list, &ieee->Rx_TS_Unused_List);
 		}
 	}
 
-	list_for_each_entry_safe(ts, pTmpTS, &ieee->Rx_TS_Admit_List, List) {
+	list_for_each_entry_safe(ts, pTmpTS, &ieee->Rx_TS_Admit_List, list) {
 		if (memcmp(ts->addr, addr, 6) == 0) {
 			RemoveTsEntry(ieee, ts, RX_DIR);
-			list_del_init(&ts->List);
-			list_add_tail(&ts->List, &ieee->Rx_TS_Unused_List);
+			list_del_init(&ts->list);
+			list_add_tail(&ts->list, &ieee->Rx_TS_Unused_List);
 		}
 	}
 }
@@ -406,28 +406,28 @@ void RemoveAllTS(struct rtllib_device *ieee)
 {
 	struct ts_common_info *ts, *pTmpTS;
 
-	list_for_each_entry_safe(ts, pTmpTS, &ieee->Tx_TS_Pending_List, List) {
+	list_for_each_entry_safe(ts, pTmpTS, &ieee->Tx_TS_Pending_List, list) {
 		RemoveTsEntry(ieee, ts, TX_DIR);
-		list_del_init(&ts->List);
-		list_add_tail(&ts->List, &ieee->Tx_TS_Unused_List);
+		list_del_init(&ts->list);
+		list_add_tail(&ts->list, &ieee->Tx_TS_Unused_List);
 	}
 
-	list_for_each_entry_safe(ts, pTmpTS, &ieee->Tx_TS_Admit_List, List) {
+	list_for_each_entry_safe(ts, pTmpTS, &ieee->Tx_TS_Admit_List, list) {
 		RemoveTsEntry(ieee, ts, TX_DIR);
-		list_del_init(&ts->List);
-		list_add_tail(&ts->List, &ieee->Tx_TS_Unused_List);
+		list_del_init(&ts->list);
+		list_add_tail(&ts->list, &ieee->Tx_TS_Unused_List);
 	}
 
-	list_for_each_entry_safe(ts, pTmpTS, &ieee->Rx_TS_Pending_List, List) {
+	list_for_each_entry_safe(ts, pTmpTS, &ieee->Rx_TS_Pending_List, list) {
 		RemoveTsEntry(ieee, ts, RX_DIR);
-		list_del_init(&ts->List);
-		list_add_tail(&ts->List, &ieee->Rx_TS_Unused_List);
+		list_del_init(&ts->list);
+		list_add_tail(&ts->list, &ieee->Rx_TS_Unused_List);
 	}
 
-	list_for_each_entry_safe(ts, pTmpTS, &ieee->Rx_TS_Admit_List, List) {
+	list_for_each_entry_safe(ts, pTmpTS, &ieee->Rx_TS_Admit_List, list) {
 		RemoveTsEntry(ieee, ts, RX_DIR);
-		list_del_init(&ts->List);
-		list_add_tail(&ts->List, &ieee->Rx_TS_Unused_List);
+		list_del_init(&ts->list);
+		list_add_tail(&ts->list, &ieee->Rx_TS_Unused_List);
 	}
 }
 
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 0b4a6ded257a..303a2d279e86 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1042,7 +1042,7 @@ struct bandwidth_autoswitch {
 #define REORDER_WIN_SIZE	128
 #define REORDER_ENTRY_NUM	128
 struct rx_reorder_entry {
-	struct list_head	List;
+	struct list_head	list;
 	u16			SeqNum;
 	struct rtllib_rxb *prxb;
 };
diff --git a/drivers/staging/rtl8192e/rtllib_rx.c b/drivers/staging/rtl8192e/rtllib_rx.c
index d9517dbc5593..b22ae40fb71b 100644
--- a/drivers/staging/rtl8192e/rtllib_rx.c
+++ b/drivers/staging/rtl8192e/rtllib_rx.c
@@ -412,19 +412,19 @@ static bool AddReorderEntry(struct rx_ts_record *ts,
 	while (pList->next != &ts->rx_pending_pkt_list) {
 		if (SN_LESS(pReorderEntry->SeqNum, ((struct rx_reorder_entry *)
 		    list_entry(pList->next, struct rx_reorder_entry,
-		    List))->SeqNum))
+		    list))->SeqNum))
 			pList = pList->next;
 		else if (SN_EQUAL(pReorderEntry->SeqNum,
 			((struct rx_reorder_entry *)list_entry(pList->next,
-			struct rx_reorder_entry, List))->SeqNum))
+			struct rx_reorder_entry, list))->SeqNum))
 			return false;
 		else
 			break;
 	}
-	pReorderEntry->List.next = pList->next;
-	pReorderEntry->List.next->prev = &pReorderEntry->List;
-	pReorderEntry->List.prev = pList;
-	pList->next = &pReorderEntry->List;
+	pReorderEntry->list.next = pList->next;
+	pReorderEntry->list.next->prev = &pReorderEntry->list;
+	pReorderEntry->list.prev = pList;
+	pList->next = &pReorderEntry->list;
 
 	return true;
 }
@@ -505,15 +505,15 @@ void rtllib_FlushRxTsPendingPkts(struct rtllib_device *ieee,
 
 		pRxReorderEntry = (struct rx_reorder_entry *)
 				  list_entry(ts->rx_pending_pkt_list.prev,
-					     struct rx_reorder_entry, List);
+					     struct rx_reorder_entry, list);
 		netdev_dbg(ieee->dev, "%s(): Indicate SeqNum %d!\n", __func__,
 			   pRxReorderEntry->SeqNum);
-		list_del_init(&pRxReorderEntry->List);
+		list_del_init(&pRxReorderEntry->list);
 
 		ieee->RfdArray[RfdCnt] = pRxReorderEntry->prxb;
 
 		RfdCnt = RfdCnt + 1;
-		list_add_tail(&pRxReorderEntry->List,
+		list_add_tail(&pRxReorderEntry->list,
 			      &ieee->RxReorder_Unused_List);
 	}
 	rtllib_indicate_packets(ieee, ieee->RfdArray, RfdCnt);
@@ -602,8 +602,8 @@ static void RxReorderIndicatePacket(struct rtllib_device *ieee,
 		if (!list_empty(&ieee->RxReorder_Unused_List)) {
 			pReorderEntry = (struct rx_reorder_entry *)
 					list_entry(ieee->RxReorder_Unused_List.next,
-					struct rx_reorder_entry, List);
-			list_del_init(&pReorderEntry->List);
+					struct rx_reorder_entry, list);
+			list_del_init(&pReorderEntry->list);
 
 			/* Make a reorder entry and insert
 			 * into a the packet list.
@@ -618,7 +618,7 @@ static void RxReorderIndicatePacket(struct rtllib_device *ieee,
 					   "%s(): Duplicate packet is dropped. IndicateSeq: %d, NewSeq: %d\n",
 					   __func__, ts->rx_indicate_seq,
 					   SeqNum);
-				list_add_tail(&pReorderEntry->List,
+				list_add_tail(&pReorderEntry->list,
 					      &ieee->RxReorder_Unused_List);
 
 				for (i = 0; i < prxb->nr_subframes; i++)
@@ -658,7 +658,7 @@ static void RxReorderIndicatePacket(struct rtllib_device *ieee,
 		pReorderEntry = (struct rx_reorder_entry *)
 					list_entry(ts->rx_pending_pkt_list.prev,
 						   struct rx_reorder_entry,
-						   List);
+						   list);
 		if (SN_LESS(pReorderEntry->SeqNum, ts->rx_indicate_seq) ||
 		    SN_EQUAL(pReorderEntry->SeqNum, ts->rx_indicate_seq)) {
 			/* This protect struct buffer from overflow. */
@@ -670,7 +670,7 @@ static void RxReorderIndicatePacket(struct rtllib_device *ieee,
 				break;
 			}
 
-			list_del_init(&pReorderEntry->List);
+			list_del_init(&pReorderEntry->list);
 
 			if (SN_EQUAL(pReorderEntry->SeqNum, ts->rx_indicate_seq))
 				ts->rx_indicate_seq = (ts->rx_indicate_seq + 1) %
@@ -681,7 +681,7 @@ static void RxReorderIndicatePacket(struct rtllib_device *ieee,
 				   __func__, pReorderEntry->SeqNum);
 			index++;
 
-			list_add_tail(&pReorderEntry->List,
+			list_add_tail(&pReorderEntry->list,
 				      &ieee->RxReorder_Unused_List);
 		} else {
 			bPktInBuf = true;
-- 
2.39.2


