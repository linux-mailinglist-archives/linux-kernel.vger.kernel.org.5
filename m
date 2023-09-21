Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC9097A9142
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 05:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbjIUDWH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 23:22:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjIUDVn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 23:21:43 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC873125
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 20:21:35 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-690b7cb71aeso293887b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 20:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1695266495; x=1695871295; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k97ZxqGyRQlp8ytYzYtN542lLgKtzNLUkveHOkKODvM=;
        b=a8QmA+6fqBVYi3VmgV24gfaeutXdWOPrUHoICtP6o/JdpZXba2vkVAeUsg7sGVyTxf
         TlPufEcIex+HqzwX1aZRHxQDg2yD6uY7MwluYDODMBWr/hp2kle6sY+eGzd7ChIRej7Q
         dt5APORcy3fHjhtIltl7kRrMLPn/qFkUdla4spfe/DnHm5fC4AH6MtASYPeh36WRyxLo
         Zzi5zsHe1OUnt87Z/K0ipiSMeb8zTDfhimLis/sXeQGynG75jCQmmCcqKEMlWVasMkii
         +pHaRwkhdZtwcEP4g0Eucz5t9/QEksm2hQ/hR8sbLiUNTv4d9baK0Mtwg9kd4z1p0Z61
         Pj4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695266495; x=1695871295;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k97ZxqGyRQlp8ytYzYtN542lLgKtzNLUkveHOkKODvM=;
        b=u5YiHChgwUSr03vXsm3rnJAcLawQqoYbPGXopcTVQ0HHssFMB7WpgoqoqZioN7JIEn
         04NplpUTxIKOcz3k6GaiO/BNQB3kSedbQDqDWpnQ6yXbKaeoEDmvb8QxCZsbkJmNbK9I
         8deD/X77PEJGpJFOzALRGezoP7PcwIVY5KGM0TK7xW426NLxvpVz+UCfSSwFaXqz7NCK
         nC/SUmXxapxL1nZG1yOsr66Z0/qG2GYyDFKI29Ivathpn+H2dWVSYXlixeuLcGXkBSp2
         0nOX5Lfwd+L3/XKU8rIhwPCVVXJIj8yay2tIMijL/ZVyTdFtt2OXHWKQos1ZKt5b1yBM
         Z5qA==
X-Gm-Message-State: AOJu0YyjWClSBTibQLre3gZS2r1Ml99AXnD2L3s/CQXYzc0kVizKQ4PR
        Sa6yzY8KC1x3ZoE03nWCD4CJRQ==
X-Google-Smtp-Source: AGHT+IF7PjCc3SBwnxzk9GPwHeWcsH/ggTr15dAOBNEqDVl8EUg19JJmpRpSjzx3ei6Frx61ZNjimw==
X-Received: by 2002:a05:6a00:1d87:b0:68f:c2f7:cef0 with SMTP id z7-20020a056a001d8700b0068fc2f7cef0mr9671854pfw.4.1695266495242;
        Wed, 20 Sep 2023 20:21:35 -0700 (PDT)
Received: from basil.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id p14-20020a62ab0e000000b0068e49cb1692sm237324pff.1.2023.09.20.20.21.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 20:21:34 -0700 (PDT)
From:   Tree Davies <tdavies@darkphysics.net>
To:     gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com,
        anjan@momi.ca
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 09/11] Staging: rtl8192e: Rename function GetTs()
Date:   Wed, 20 Sep 2023 20:25:13 -0700
Message-ID: <20230921032515.96152-10-tdavies@darkphysics.net>
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

Rename function GetTs to rtllib_get_ts to fix checkpatch warning Avoid
CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtl819x_BAProc.c | 8 ++++----
 drivers/staging/rtl8192e/rtl819x_TSProc.c | 2 +-
 drivers/staging/rtl8192e/rtllib.h         | 2 +-
 drivers/staging/rtl8192e/rtllib_rx.c      | 4 ++--
 drivers/staging/rtl8192e/rtllib_tx.c      | 4 ++--
 5 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_BAProc.c b/drivers/staging/rtl8192e/rtl819x_BAProc.c
index 5fc4038708b6..b3a8a6959622 100644
--- a/drivers/staging/rtl8192e/rtl819x_BAProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_BAProc.c
@@ -253,7 +253,7 @@ int rtllib_rx_ADDBAReq(struct rtllib_device *ieee, struct sk_buff *skb)
 			    ieee->ht_info->bCurrentHTSupport);
 		goto OnADDBAReq_Fail;
 	}
-	if (!GetTs(ieee, (struct ts_common_info **)&ts, dst,
+	if (!rtllib_get_ts(ieee, (struct ts_common_info **)&ts, dst,
 		   (u8)(pBaParamSet->field.tid), RX_DIR, true)) {
 		rc = ADDBA_STATUS_REFUSED;
 		netdev_warn(ieee->dev, "%s(): can't get TS\n", __func__);
@@ -337,7 +337,7 @@ int rtllib_rx_ADDBARsp(struct rtllib_device *ieee, struct sk_buff *skb)
 		goto OnADDBARsp_Reject;
 	}
 
-	if (!GetTs(ieee, (struct ts_common_info **)&pTS, dst,
+	if (!rtllib_get_ts(ieee, (struct ts_common_info **)&pTS, dst,
 		   (u8)(pBaParamSet->field.tid), TX_DIR, false)) {
 		netdev_warn(ieee->dev, "%s(): can't get TS\n", __func__);
 		ReasonCode = DELBA_REASON_UNKNOWN_BA;
@@ -432,7 +432,7 @@ int rtllib_rx_DELBA(struct rtllib_device *ieee, struct sk_buff *skb)
 	if (pDelBaParamSet->field.initiator == 1) {
 		struct rx_ts_record *ts;
 
-		if (!GetTs(ieee, (struct ts_common_info **)&ts, dst,
+		if (!rtllib_get_ts(ieee, (struct ts_common_info **)&ts, dst,
 			   (u8)pDelBaParamSet->field.tid, RX_DIR, false)) {
 			netdev_warn(ieee->dev,
 				    "%s(): can't get TS for RXTS. dst:%pM TID:%d\n",
@@ -445,7 +445,7 @@ int rtllib_rx_DELBA(struct rtllib_device *ieee, struct sk_buff *skb)
 	} else {
 		struct tx_ts_record *pTxTs;
 
-		if (!GetTs(ieee, (struct ts_common_info **)&pTxTs, dst,
+		if (!rtllib_get_ts(ieee, (struct ts_common_info **)&pTxTs, dst,
 			   (u8)pDelBaParamSet->field.tid, TX_DIR, false)) {
 			netdev_warn(ieee->dev, "%s(): can't get TS for TXTS\n",
 				    __func__);
diff --git a/drivers/staging/rtl8192e/rtl819x_TSProc.c b/drivers/staging/rtl8192e/rtl819x_TSProc.c
index f7682f11dc65..d52deba1f20e 100644
--- a/drivers/staging/rtl8192e/rtl819x_TSProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_TSProc.c
@@ -244,7 +244,7 @@ static void MakeTSEntry(struct ts_common_info *pTsCommonInfo, u8 *addr,
 	pTsCommonInfo->TClasNum = TCLAS_Num;
 }
 
-bool GetTs(struct rtllib_device *ieee, struct ts_common_info **ppTS,
+bool rtllib_get_ts(struct rtllib_device *ieee, struct ts_common_info **ppTS,
 	   u8 *addr, u8 TID, enum tr_select TxRxSelect, bool bAddNewTs)
 {
 	u8	UP = 0;
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 427f97325e87..727bdcf7455d 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1842,7 +1842,7 @@ void rtllib_ba_setup_timeout(struct timer_list *t);
 void rtllib_tx_ba_inact_timeout(struct timer_list *t);
 void rtllib_rx_ba_inact_timeout(struct timer_list *t);
 void rtllib_reset_ba_entry(struct ba_record *pBA);
-bool GetTs(struct rtllib_device *ieee, struct ts_common_info **ppTS, u8 *addr,
+bool rtllib_get_ts(struct rtllib_device *ieee, struct ts_common_info **ppTS, u8 *addr,
 	   u8 TID, enum tr_select TxRxSelect, bool bAddNewTs);
 void TSInitialize(struct rtllib_device *ieee);
 void TsStartAddBaProcess(struct rtllib_device *ieee,
diff --git a/drivers/staging/rtl8192e/rtllib_rx.c b/drivers/staging/rtl8192e/rtllib_rx.c
index 21cde99bb24d..cba460c46285 100644
--- a/drivers/staging/rtl8192e/rtllib_rx.c
+++ b/drivers/staging/rtl8192e/rtllib_rx.c
@@ -921,7 +921,7 @@ static int rtllib_rx_check_duplicate(struct rtllib_device *ieee,
 	} else {
 		struct rx_ts_record *ts = NULL;
 
-		if (GetTs(ieee, (struct ts_common_info **)&ts, hdr->addr2,
+		if (rtllib_get_ts(ieee, (struct ts_common_info **)&ts, hdr->addr2,
 			(u8)Frame_QoSTID((u8 *)(skb->data)), RX_DIR, true)) {
 			if ((fc & (1 << 11)) && (frag == ts->rx_last_frag_num) &&
 			    (WLAN_GET_SEQ_SEQ(sc) == ts->rx_last_seq_num))
@@ -1381,7 +1381,7 @@ static int rtllib_rx_InfraAdhoc(struct rtllib_device *ieee, struct sk_buff *skb,
 		&& (!bToOtherSTA)) {
 		TID = Frame_QoSTID(skb->data);
 		SeqNum = WLAN_GET_SEQ_SEQ(sc);
-		GetTs(ieee, (struct ts_common_info **)&ts, hdr->addr2, TID,
+		rtllib_get_ts(ieee, (struct ts_common_info **)&ts, hdr->addr2, TID,
 		      RX_DIR, true);
 		if (TID != 0 && TID != 3)
 			ieee->bis_any_nonbepkts = true;
diff --git a/drivers/staging/rtl8192e/rtllib_tx.c b/drivers/staging/rtl8192e/rtllib_tx.c
index ca13df080242..9b77d6fa7954 100644
--- a/drivers/staging/rtl8192e/rtllib_tx.c
+++ b/drivers/staging/rtl8192e/rtllib_tx.c
@@ -289,7 +289,7 @@ static void rtllib_tx_query_agg_cap(struct rtllib_device *ieee,
 	if (!ieee->GetNmodeSupportBySecCfg(ieee->dev))
 		return;
 	if (ht_info->bCurrentAMPDUEnable) {
-		if (!GetTs(ieee, (struct ts_common_info **)(&pTxTs), hdr->addr1,
+		if (!rtllib_get_ts(ieee, (struct ts_common_info **)(&pTxTs), hdr->addr1,
 			   skb->priority, TX_DIR, true)) {
 			netdev_info(ieee->dev, "%s: can't get TS\n", __func__);
 			return;
@@ -498,7 +498,7 @@ static u16 rtllib_query_seqnum(struct rtllib_device *ieee, struct sk_buff *skb,
 	if (IsQoSDataFrame(skb->data)) {
 		struct tx_ts_record *pTS = NULL;
 
-		if (!GetTs(ieee, (struct ts_common_info **)(&pTS), dst,
+		if (!rtllib_get_ts(ieee, (struct ts_common_info **)(&pTS), dst,
 			   skb->priority, TX_DIR, true))
 			return 0;
 		seqnum = pTS->TxCurSeq;
-- 
2.39.2

