Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB55D7F98C2
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 06:36:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232164AbjK0Fgm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 00:36:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjK0FgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 00:36:21 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C24918E
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 21:36:26 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1cfae5ca719so13902225ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 21:36:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1701063385; x=1701668185; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7IN7Uz/ApgY1f3u5IU30JsgnfKyUE/XtB4TY8u0u2IE=;
        b=d97KayVXdvR/FWwj99cYcoaTjpo3yqJAyXPiwUj/ZKdvRGdWbyeSKx7F2j+PMqVsL8
         +4p+vc876H3barusarVNngIUi6drTbjWvcBgW5MbXYOcvoN7s22DRWSHMzY8XbFA6lNr
         x36d+17mMTdIrQuHdMKIFbNQ/H3RPvM/BBqej0eluIQF4N6fcUyam0y9ybuGJToDfeeH
         8FhmmlfGiwjBIiiZOpdAgMH0tklFB9GQ+JYFNqX/EKXggHulw1xRJW4t7PpHn3Hrn9KV
         jfRWAPt0JlAZ/xHNL01DLsO8k9cIOsR+agPciKeqG3FbMmJqJ7sQW4ob/PF50n8mBTgR
         Fz3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701063385; x=1701668185;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7IN7Uz/ApgY1f3u5IU30JsgnfKyUE/XtB4TY8u0u2IE=;
        b=Rim5BIJOt9O2M4ZEOb7OiryKUK4KQSRWoFTe3y7Ebk/HFW4L2g7O0ywFhPil/uP1Od
         cvI4g+A/s5GZQNtqGcvsBjkIZGu6lTY6PsFr8DD5w5HF5HnAs8bB4hEvOsyt0KX35XxD
         y+RwUzpZrJ2ZdYctrghzG1D5ShOnsWGaNohT5KK9XTDkYSqn1C9ZrbFd/iVJt9XxQqcS
         UdQx9EF+mbbHa6Yf1wd+4Ru5LciWtEB6v66Cfsc8XU9hKxLzDght5lFsnBsToZ0GTMwk
         1jmVZ3+QEWwm3hZWmMiDPG+n/NXs+fleQzz9MrE1TFirNs1kftSxMCq6smOefEftzDLn
         /fDA==
X-Gm-Message-State: AOJu0YxHXOEmNK24hee5WBxQyDehzKezX2NwBHsF6QedjJzR+qtN1MaY
        A4O4h423TPklfD8BchUsfXTp7Q==
X-Google-Smtp-Source: AGHT+IHB8qLA1itApM0KaYIbMULLjPaTaLcTr8nkQl51KE5AUYBOL3RWSteixe/bb0DBDbIRYuEjgw==
X-Received: by 2002:a17:902:d488:b0:1cf:c518:fa3a with SMTP id c8-20020a170902d48800b001cfc518fa3amr2470988plg.23.1701063385660;
        Sun, 26 Nov 2023 21:36:25 -0800 (PST)
Received: from basil.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id b6-20020a170902ed0600b001cc3875e658sm7300465pld.303.2023.11.26.21.36.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Nov 2023 21:36:25 -0800 (PST)
From:   Tree Davies <tdavies@darkphysics.net>
To:     gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com,
        anjan@momi.ca
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 08/15] Staging: rtl8192e: Rename variable pTsCommonInfo
Date:   Sun, 26 Nov 2023 21:42:58 -0800
Message-ID: <20231127054305.148276-9-tdavies@darkphysics.net>
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

Rename variable pTsCommonInfo to ts_common_info to fix checkpatch
warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtl819x_BAProc.c | 10 +++++-----
 drivers/staging/rtl8192e/rtl819x_TSProc.c | 14 +++++++-------
 drivers/staging/rtl8192e/rtllib.h         |  2 +-
 3 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_BAProc.c b/drivers/staging/rtl8192e/rtl819x_BAProc.c
index 78da79ebd775..d11cbe3bbb31 100644
--- a/drivers/staging/rtl8192e/rtl819x_BAProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_BAProc.c
@@ -485,24 +485,24 @@ void rtllib_ts_init_add_ba(struct rtllib_device *ieee, struct tx_ts_record *ts,
 }
 
 void rtllib_ts_init_del_ba(struct rtllib_device *ieee,
-			   struct ts_common_info *pTsCommonInfo,
+			   struct ts_common_info *ts_common_info,
 			   enum tr_select TxRxSelect)
 {
 	if (TxRxSelect == TX_DIR) {
 		struct tx_ts_record *ts =
-			 (struct tx_ts_record *)pTsCommonInfo;
+			 (struct tx_ts_record *)ts_common_info;
 
 		if (tx_ts_delete_ba(ieee, ts))
-			rtllib_send_DELBA(ieee, pTsCommonInfo->addr,
+			rtllib_send_DELBA(ieee, ts_common_info->addr,
 					  (ts->tx_admitted_ba_record.b_valid) ?
 					 (&ts->tx_admitted_ba_record) :
 					(&ts->tx_pending_ba_record),
 					 TxRxSelect, DELBA_REASON_END_BA);
 	} else if (TxRxSelect == RX_DIR) {
 		struct rx_ts_record *ts =
-				 (struct rx_ts_record *)pTsCommonInfo;
+				 (struct rx_ts_record *)ts_common_info;
 		if (rx_ts_delete_ba(ieee, ts))
-			rtllib_send_DELBA(ieee, pTsCommonInfo->addr,
+			rtllib_send_DELBA(ieee, ts_common_info->addr,
 					  &ts->rx_admitted_ba_record,
 					  TxRxSelect, DELBA_REASON_END_BA);
 	}
diff --git a/drivers/staging/rtl8192e/rtl819x_TSProc.c b/drivers/staging/rtl8192e/rtl819x_TSProc.c
index ed14e8e1ed93..2e6b705437d9 100644
--- a/drivers/staging/rtl8192e/rtl819x_TSProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_TSProc.c
@@ -91,10 +91,10 @@ static void TsAddBaProcess(struct timer_list *t)
 	netdev_dbg(ieee->dev, "%s(): ADDBA Req is started\n", __func__);
 }
 
-static void ResetTsCommonInfo(struct ts_common_info *pTsCommonInfo)
+static void ResetTsCommonInfo(struct ts_common_info *ts_common_info)
 {
-	eth_zero_addr(pTsCommonInfo->addr);
-	memset(&pTsCommonInfo->tspec, 0, sizeof(struct qos_tsinfo));
+	eth_zero_addr(ts_common_info->addr);
+	memset(&ts_common_info->tspec, 0, sizeof(struct qos_tsinfo));
 }
 
 static void ResetTxTsEntry(struct tx_ts_record *ts)
@@ -211,16 +211,16 @@ static struct ts_common_info *SearchAdmitTRStream(struct rtllib_device *ieee,
 	return NULL;
 }
 
-static void MakeTSEntry(struct ts_common_info *pTsCommonInfo, u8 *addr,
+static void MakeTSEntry(struct ts_common_info *ts_common_info, u8 *addr,
 			struct qos_tsinfo *pTSPEC)
 {
-	if (!pTsCommonInfo)
+	if (!ts_common_info)
 		return;
 
-	memcpy(pTsCommonInfo->addr, addr, 6);
+	memcpy(ts_common_info->addr, addr, 6);
 
 	if (pTSPEC)
-		memcpy((u8 *)(&(pTsCommonInfo->tspec)), (u8 *)pTSPEC,
+		memcpy((u8 *)(&(ts_common_info->tspec)), (u8 *)pTSPEC,
 			sizeof(struct qos_tsinfo));
 }
 
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 77ae259eab35..5f372554d424 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1787,7 +1787,7 @@ int rtllib_rx_DELBA(struct rtllib_device *ieee, struct sk_buff *skb);
 void rtllib_ts_init_add_ba(struct rtllib_device *ieee, struct tx_ts_record *ts,
 			   u8 policy, u8 overwrite_pending);
 void rtllib_ts_init_del_ba(struct rtllib_device *ieee,
-			   struct ts_common_info *pTsCommonInfo,
+			   struct ts_common_info *ts_common_info,
 			   enum tr_select TxRxSelect);
 void rtllib_ba_setup_timeout(struct timer_list *t);
 void rtllib_tx_ba_inact_timeout(struct timer_list *t);
-- 
2.39.2

