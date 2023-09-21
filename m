Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CF457A913F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 05:21:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbjIUDV6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 23:21:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjIUDVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 23:21:38 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6CD5F7
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 20:21:32 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-59c00b5c8b2so6174077b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 20:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1695266492; x=1695871292; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sVi5XTsc2kiTuYoQoZkEz6aZVmR8nv1VQ4FqXeg+0PE=;
        b=hg7druaZ4FFPCQNhdYr4TtFrW4x/bMK1ZMRHbADDy7tF+zzFtm75tuHVOtZsi40ssf
         Aj+p64kxYwyul1o0YVp6X1HSe94vSyNJdH81NCiDD3KFrrH8fuNvAiKhc9YNLvG8bgbl
         dLZKBGEp7qj3Ap1eKraES+52mw9PNXB/sl9POvABtBnn+iPyjp/NbGo2qRbAzr81HZTG
         TZ0/g82+P71EHwHW69hl9C3IPptktpcMUV6ZnssUMIbYXA0tqoMENd14AcGjOzXAZiKo
         0X6WHHA9Ucu2/Poj5G6RdpcM49ACLLDCIeqTS7NWvTonBPAdGSMa2NsbO6CkSFCB7gXb
         qgBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695266492; x=1695871292;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sVi5XTsc2kiTuYoQoZkEz6aZVmR8nv1VQ4FqXeg+0PE=;
        b=tASMuOcDMYeu26Bo9EzPwlRWRD7NLGH5zhygKK+BgfHENtefE7Iw03nzyDNJe8qBpx
         GH7dgIvTY49OLBEiMl1GtggChm5YZlsITdMPG0IQCNopBvt3UgHViKUYD2qYeGX9q0Xb
         kOHFo+LznUfnZNFdw6M+XgP3F6UjOsatBHmqBDoI+8QtNIkMjXodandhBJt1J9W0o9DP
         iAq0zntOCh2vGPBSHOohgnChcrllhMo9q1ftwGuLMl7y/IQ/A4iKI5arBNhWA+X6V1J9
         60KXz2UvZYRVKdqy1UfZv7B8z939/77tC8EY6dgyZ4e5s4n5ua4VFxNA3AVRWDBB2QBW
         YWsw==
X-Gm-Message-State: AOJu0Yw5OTRp1R1mWcjJU5+JGTMY+HI4GwiWdAueOh8wpY6oc1/Yl/Qc
        uPzry1WvmetlWsINWEbgUqpZkg==
X-Google-Smtp-Source: AGHT+IGrFr6AZ9BvGBTRPvD0jFAw5HM2faRyDv/ejRoRuRC/qaE98vNqmyUV6xj3yB0gvdakwGe61g==
X-Received: by 2002:a0d:e609:0:b0:58f:ae13:462b with SMTP id p9-20020a0de609000000b0058fae13462bmr4631868ywe.4.1695266491684;
        Wed, 20 Sep 2023 20:21:31 -0700 (PDT)
Received: from basil.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id p14-20020a62ab0e000000b0068e49cb1692sm237324pff.1.2023.09.20.20.21.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 20:21:31 -0700 (PDT)
From:   Tree Davies <tdavies@darkphysics.net>
To:     gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com,
        anjan@momi.ca
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 06/11] Staging: rtl8192e: Rename variable Addr
Date:   Wed, 20 Sep 2023 20:25:10 -0700
Message-ID: <20230921032515.96152-7-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230921032515.96152-1-tdavies@darkphysics.net>
References: <20230921032515.96152-1-tdavies@darkphysics.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NO_DNS_FOR_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename variable Addr to addr to fix checkpatch warning Avoid
CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtl819x_BAProc.c | 10 +++----
 drivers/staging/rtl8192e/rtl819x_TS.h     |  2 +-
 drivers/staging/rtl8192e/rtl819x_TSProc.c | 32 +++++++++++------------
 drivers/staging/rtl8192e/rtllib.h         |  4 +--
 4 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_BAProc.c b/drivers/staging/rtl8192e/rtl819x_BAProc.c
index e6892bb7958c..3468bdcea7fc 100644
--- a/drivers/staging/rtl8192e/rtl819x_BAProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_BAProc.c
@@ -481,7 +481,7 @@ void rtllib_ts_init_add_ba(struct rtllib_device *ieee, struct tx_ts_record *pTS,
 
 	activate_ba_entry(pBA, BA_SETUP_TIMEOUT);
 
-	rtllib_send_ADDBAReq(ieee, pTS->TsCommonInfo.Addr, pBA);
+	rtllib_send_ADDBAReq(ieee, pTS->TsCommonInfo.addr, pBA);
 }
 
 void rtllib_ts_init_del_ba(struct rtllib_device *ieee,
@@ -493,7 +493,7 @@ void rtllib_ts_init_del_ba(struct rtllib_device *ieee,
 			 (struct tx_ts_record *)pTsCommonInfo;
 
 		if (tx_ts_delete_ba(ieee, pTxTs))
-			rtllib_send_DELBA(ieee, pTsCommonInfo->Addr,
+			rtllib_send_DELBA(ieee, pTsCommonInfo->addr,
 					  (pTxTs->TxAdmittedBARecord.b_valid) ?
 					 (&pTxTs->TxAdmittedBARecord) :
 					(&pTxTs->TxPendingBARecord),
@@ -502,7 +502,7 @@ void rtllib_ts_init_del_ba(struct rtllib_device *ieee,
 		struct rx_ts_record *ts =
 				 (struct rx_ts_record *)pTsCommonInfo;
 		if (rx_ts_delete_ba(ieee, ts))
-			rtllib_send_DELBA(ieee, pTsCommonInfo->Addr,
+			rtllib_send_DELBA(ieee, pTsCommonInfo->addr,
 					  &ts->rx_admitted_ba_record,
 					  TxRxSelect, DELBA_REASON_END_BA);
 	}
@@ -525,7 +525,7 @@ void rtllib_tx_ba_inact_timeout(struct timer_list *t)
 	struct rtllib_device *ieee = container_of(pTxTs, struct rtllib_device,
 				     TxTsRecord[pTxTs->num]);
 	tx_ts_delete_ba(ieee, pTxTs);
-	rtllib_send_DELBA(ieee, pTxTs->TsCommonInfo.Addr,
+	rtllib_send_DELBA(ieee, pTxTs->TsCommonInfo.addr,
 			  &pTxTs->TxAdmittedBARecord, TX_DIR,
 			  DELBA_REASON_TIMEOUT);
 }
@@ -538,7 +538,7 @@ void rtllib_rx_ba_inact_timeout(struct timer_list *t)
 				     RxTsRecord[ts->num]);
 
 	rx_ts_delete_ba(ieee, ts);
-	rtllib_send_DELBA(ieee, ts->ts_common_info.Addr,
+	rtllib_send_DELBA(ieee, ts->ts_common_info.addr,
 			  &ts->rx_admitted_ba_record, RX_DIR,
 			  DELBA_REASON_TIMEOUT);
 }
diff --git a/drivers/staging/rtl8192e/rtl819x_TS.h b/drivers/staging/rtl8192e/rtl819x_TS.h
index 0e851d4221a7..a9770592a8c9 100644
--- a/drivers/staging/rtl8192e/rtl819x_TS.h
+++ b/drivers/staging/rtl8192e/rtl819x_TS.h
@@ -19,7 +19,7 @@ enum tr_select {
 
 struct ts_common_info {
 	struct list_head		List;
-	u8				Addr[ETH_ALEN];
+	u8				addr[ETH_ALEN];
 	union tspec_body TSpec;
 	union qos_tclas TClass[TCLAS_NUM];
 	u8				TClasProc;
diff --git a/drivers/staging/rtl8192e/rtl819x_TSProc.c b/drivers/staging/rtl8192e/rtl819x_TSProc.c
index 9f93186b5ed5..f7682f11dc65 100644
--- a/drivers/staging/rtl8192e/rtl819x_TSProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_TSProc.c
@@ -93,7 +93,7 @@ static void TsAddBaProcess(struct timer_list *t)
 
 static void ResetTsCommonInfo(struct ts_common_info *pTsCommonInfo)
 {
-	eth_zero_addr(pTsCommonInfo->Addr);
+	eth_zero_addr(pTsCommonInfo->addr);
 	memset(&pTsCommonInfo->TSpec, 0, sizeof(union tspec_body));
 	memset(&pTsCommonInfo->TClass, 0, sizeof(union qos_tclas) * TCLAS_NUM);
 	pTsCommonInfo->TClasProc = 0;
@@ -173,7 +173,7 @@ void TSInitialize(struct rtllib_device *ieee)
 }
 
 static struct ts_common_info *SearchAdmitTRStream(struct rtllib_device *ieee,
-						  u8 *Addr, u8 TID,
+						  u8 *addr, u8 TID,
 						  enum tr_select TxRxSelect)
 {
 	u8	dir;
@@ -207,7 +207,7 @@ static struct ts_common_info *SearchAdmitTRStream(struct rtllib_device *ieee,
 		if (!search_dir[dir])
 			continue;
 		list_for_each_entry(pRet, psearch_list, List) {
-			if (memcmp(pRet->Addr, Addr, 6) == 0 &&
+			if (memcmp(pRet->addr, addr, 6) == 0 &&
 			    pRet->TSpec.f.TSInfo.field.ucTSID == TID &&
 			    pRet->TSpec.f.TSInfo.field.ucDirection == dir)
 				break;
@@ -221,7 +221,7 @@ static struct ts_common_info *SearchAdmitTRStream(struct rtllib_device *ieee,
 	return NULL;
 }
 
-static void MakeTSEntry(struct ts_common_info *pTsCommonInfo, u8 *Addr,
+static void MakeTSEntry(struct ts_common_info *pTsCommonInfo, u8 *addr,
 			union tspec_body *pTSPEC, union qos_tclas *pTCLAS,
 			u8 TCLAS_Num, u8 TCLAS_Proc)
 {
@@ -230,7 +230,7 @@ static void MakeTSEntry(struct ts_common_info *pTsCommonInfo, u8 *Addr,
 	if (!pTsCommonInfo)
 		return;
 
-	memcpy(pTsCommonInfo->Addr, Addr, 6);
+	memcpy(pTsCommonInfo->addr, addr, 6);
 
 	if (pTSPEC)
 		memcpy((u8 *)(&(pTsCommonInfo->TSpec)), (u8 *)pTSPEC,
@@ -245,7 +245,7 @@ static void MakeTSEntry(struct ts_common_info *pTsCommonInfo, u8 *Addr,
 }
 
 bool GetTs(struct rtllib_device *ieee, struct ts_common_info **ppTS,
-	   u8 *Addr, u8 TID, enum tr_select TxRxSelect, bool bAddNewTs)
+	   u8 *addr, u8 TID, enum tr_select TxRxSelect, bool bAddNewTs)
 {
 	u8	UP = 0;
 	union tspec_body TSpec;
@@ -254,7 +254,7 @@ bool GetTs(struct rtllib_device *ieee, struct ts_common_info **ppTS,
 	struct list_head *pAddmitList;
 	enum direction_value Dir;
 
-	if (is_multicast_ether_addr(Addr)) {
+	if (is_multicast_ether_addr(addr)) {
 		netdev_warn(ieee->dev, "Get TS for Broadcast or Multicast\n");
 		return false;
 	}
@@ -285,7 +285,7 @@ bool GetTs(struct rtllib_device *ieee, struct ts_common_info **ppTS,
 		}
 	}
 
-	*ppTS = SearchAdmitTRStream(ieee, Addr, UP, TxRxSelect);
+	*ppTS = SearchAdmitTRStream(ieee, addr, UP, TxRxSelect);
 	if (*ppTS)
 		return true;
 
@@ -324,7 +324,7 @@ bool GetTs(struct rtllib_device *ieee, struct ts_common_info **ppTS,
 
 		netdev_dbg(ieee->dev,
 			   "to init current TS, UP:%d, Dir:%d, addr: %pM ppTs=%p\n",
-			   UP, Dir, Addr, *ppTS);
+			   UP, Dir, addr, *ppTS);
 		pTSInfo->field.ucTrafficType = 0;
 		pTSInfo->field.ucTSID = UP;
 		pTSInfo->field.ucDirection = Dir;
@@ -335,7 +335,7 @@ bool GetTs(struct rtllib_device *ieee, struct ts_common_info **ppTS,
 		pTSInfo->field.ucTSInfoAckPolicy = 0;
 		pTSInfo->field.ucSchedule = 0;
 
-		MakeTSEntry(*ppTS, Addr, &TSpec, NULL, 0, 0);
+		MakeTSEntry(*ppTS, addr, &TSpec, NULL, 0, 0);
 		list_add_tail(&((*ppTS)->List), pAddmitList);
 
 		return true;
@@ -387,14 +387,14 @@ static void RemoveTsEntry(struct rtllib_device *ieee,
 	}
 }
 
-void RemovePeerTS(struct rtllib_device *ieee, u8 *Addr)
+void RemovePeerTS(struct rtllib_device *ieee, u8 *addr)
 {
 	struct ts_common_info *pTS, *pTmpTS;
 
-	netdev_info(ieee->dev, "===========>%s, %pM\n", __func__, Addr);
+	netdev_info(ieee->dev, "===========>%s, %pM\n", __func__, addr);
 
 	list_for_each_entry_safe(pTS, pTmpTS, &ieee->Tx_TS_Pending_List, List) {
-		if (memcmp(pTS->Addr, Addr, 6) == 0) {
+		if (memcmp(pTS->addr, addr, 6) == 0) {
 			RemoveTsEntry(ieee, pTS, TX_DIR);
 			list_del_init(&pTS->List);
 			list_add_tail(&pTS->List, &ieee->Tx_TS_Unused_List);
@@ -402,7 +402,7 @@ void RemovePeerTS(struct rtllib_device *ieee, u8 *Addr)
 	}
 
 	list_for_each_entry_safe(pTS, pTmpTS, &ieee->Tx_TS_Admit_List, List) {
-		if (memcmp(pTS->Addr, Addr, 6) == 0) {
+		if (memcmp(pTS->addr, addr, 6) == 0) {
 			netdev_info(ieee->dev,
 				    "====>remove Tx_TS_admin_list\n");
 			RemoveTsEntry(ieee, pTS, TX_DIR);
@@ -412,7 +412,7 @@ void RemovePeerTS(struct rtllib_device *ieee, u8 *Addr)
 	}
 
 	list_for_each_entry_safe(pTS, pTmpTS, &ieee->Rx_TS_Pending_List, List) {
-		if (memcmp(pTS->Addr, Addr, 6) == 0) {
+		if (memcmp(pTS->addr, addr, 6) == 0) {
 			RemoveTsEntry(ieee, pTS, RX_DIR);
 			list_del_init(&pTS->List);
 			list_add_tail(&pTS->List, &ieee->Rx_TS_Unused_List);
@@ -420,7 +420,7 @@ void RemovePeerTS(struct rtllib_device *ieee, u8 *Addr)
 	}
 
 	list_for_each_entry_safe(pTS, pTmpTS, &ieee->Rx_TS_Admit_List, List) {
-		if (memcmp(pTS->Addr, Addr, 6) == 0) {
+		if (memcmp(pTS->addr, addr, 6) == 0) {
 			RemoveTsEntry(ieee, pTS, RX_DIR);
 			list_del_init(&pTS->List);
 			list_add_tail(&pTS->List, &ieee->Rx_TS_Unused_List);
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 5517b9df65be..b518e23ff558 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1842,12 +1842,12 @@ void rtllib_ba_setup_timeout(struct timer_list *t);
 void rtllib_tx_ba_inact_timeout(struct timer_list *t);
 void rtllib_rx_ba_inact_timeout(struct timer_list *t);
 void rtllib_reset_ba_entry(struct ba_record *pBA);
-bool GetTs(struct rtllib_device *ieee, struct ts_common_info **ppTS, u8 *Addr,
+bool GetTs(struct rtllib_device *ieee, struct ts_common_info **ppTS, u8 *addr,
 	   u8 TID, enum tr_select TxRxSelect, bool bAddNewTs);
 void TSInitialize(struct rtllib_device *ieee);
 void TsStartAddBaProcess(struct rtllib_device *ieee,
 			 struct tx_ts_record *pTxTS);
-void RemovePeerTS(struct rtllib_device *ieee, u8 *Addr);
+void RemovePeerTS(struct rtllib_device *ieee, u8 *addr);
 void RemoveAllTS(struct rtllib_device *ieee);
 
 static inline const char *escape_essid(const char *essid, u8 essid_len)
-- 
2.39.2

