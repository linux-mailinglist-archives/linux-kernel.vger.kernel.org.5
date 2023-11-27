Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 624AE7F98BF
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 06:36:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232253AbjK0Fgb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 00:36:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbjK0FgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 00:36:16 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7A80134
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 21:36:22 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1cfc2bcffc7so5090255ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 21:36:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1701063382; x=1701668182; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DZZM2c5g/+TPAQIyy7mIwCyenkF8kluxFKUdyumlEzY=;
        b=EBKYhY/UtkXNEcDIsw1jlbMBmYVLlgRMbnOVobr8d1SCu6pG/P6bGhVOOKrfMYyuaz
         KTKkHFR/G5ooWnjXfB86hB4DRLQOVtKPXVSEEs+hv0PCDYcdsPLwU7hHyLGwPEGd+ujN
         PsrUpvIAV3vWhdYSirWcD7XN/+vP5mfSK5qcU/3/sxXuj7tB7RWRdH6Fk8J4a3MW1N4w
         zzINIV0yotrMHpL83HY/AuCvuD7lVGoh1Fcpx9nqsr8+hiav5Gd1GHmxsHLUFuQDTGMI
         NGhPyfUD1ucFDKcfSBzBAD+vPrmdp9Q2581OozsDXHujk2qq0KOAk3hercE/a7il05S0
         BXWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701063382; x=1701668182;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DZZM2c5g/+TPAQIyy7mIwCyenkF8kluxFKUdyumlEzY=;
        b=AkfRCsgjU9NV7QPwtpRtU9xZZEPOIC3DD9yXu2hSszVtMpW2cy3AEiBmTSPyiz+Znj
         zjHK8JrPc2Z3WZeCLRGLG4qyFZDYAvfubw37mhMpoI6O4BNfaWCPG8vZ9zjENDV3C1ad
         Y7SIq94APQV6cJdDNexQvVXxz47r2g98ySgoAY0PnUP1ufvBJq4Eer37lNv8N8t1kBza
         9O1u0RVOCCWS/HC30TRDTIwsNe7vjNZ1h61n4fO/nLhCULHUPewZqRrDbjKl/W5ASg1z
         luTiYqHp26qN2K74BMhAqxsXOBJvzPUAZbALlmdgLMyeJbORqemXkcxylFF7tcI1Vhj6
         6P8w==
X-Gm-Message-State: AOJu0YwrK4FJ2YLNOoPp4zZqE5iXNspAK3u4oMW47hoT97AS5SPuQtA2
        4lseVljZjJpO6ddPSSZ3TpjJpA==
X-Google-Smtp-Source: AGHT+IHCkcRzecB8ILsptMxgN5ky2tpVSiuXnhBEYbPJugtAJYw26N7txXsXCLcOKsZwU4R4h9uY6w==
X-Received: by 2002:a17:902:d48d:b0:1cf:c4d3:f337 with SMTP id c13-20020a170902d48d00b001cfc4d3f337mr2817000plg.30.1701063382241;
        Sun, 26 Nov 2023 21:36:22 -0800 (PST)
Received: from basil.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id b6-20020a170902ed0600b001cc3875e658sm7300465pld.303.2023.11.26.21.36.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Nov 2023 21:36:21 -0800 (PST)
From:   Tree Davies <tdavies@darkphysics.net>
To:     gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com,
        anjan@momi.ca
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 05/15] Staging: rtl8192e: Rename variable TxAdmittedBARecord
Date:   Sun, 26 Nov 2023 21:42:55 -0800
Message-ID: <20231127054305.148276-6-tdavies@darkphysics.net>
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

Rename variable TxAdmittedBARecord to tx_admitted_ba_record to fix checkpatch
warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtl819x_BAProc.c | 12 ++++++------
 drivers/staging/rtl8192e/rtl819x_TS.h     |  2 +-
 drivers/staging/rtl8192e/rtl819x_TSProc.c |  4 ++--
 drivers/staging/rtl8192e/rtllib_tx.c      |  4 ++--
 4 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_BAProc.c b/drivers/staging/rtl8192e/rtl819x_BAProc.c
index bf8d42668990..db529559592b 100644
--- a/drivers/staging/rtl8192e/rtl819x_BAProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_BAProc.c
@@ -25,7 +25,7 @@ static void deactivate_ba_entry(struct rtllib_device *ieee, struct ba_record *ba
 
 static u8 tx_ts_delete_ba(struct rtllib_device *ieee, struct tx_ts_record *ts)
 {
-	struct ba_record *admitted_ba = &ts->TxAdmittedBARecord;
+	struct ba_record *admitted_ba = &ts->tx_admitted_ba_record;
 	struct ba_record *pending_ba = &ts->TxPendingBARecord;
 	u8 send_del_ba = false;
 
@@ -346,7 +346,7 @@ int rtllib_rx_ADDBARsp(struct rtllib_device *ieee, struct sk_buff *skb)
 
 	ts->add_ba_req_in_progress = false;
 	pending_ba = &ts->TxPendingBARecord;
-	pAdmittedBA = &ts->TxAdmittedBARecord;
+	pAdmittedBA = &ts->tx_admitted_ba_record;
 
 	if (pAdmittedBA->b_valid) {
 		netdev_dbg(ieee->dev, "%s(): ADDBA response already admitted\n",
@@ -494,8 +494,8 @@ void rtllib_ts_init_del_ba(struct rtllib_device *ieee,
 
 		if (tx_ts_delete_ba(ieee, ts))
 			rtllib_send_DELBA(ieee, pTsCommonInfo->addr,
-					  (ts->TxAdmittedBARecord.b_valid) ?
-					 (&ts->TxAdmittedBARecord) :
+					  (ts->tx_admitted_ba_record.b_valid) ?
+					 (&ts->tx_admitted_ba_record) :
 					(&ts->TxPendingBARecord),
 					 TxRxSelect, DELBA_REASON_END_BA);
 	} else if (TxRxSelect == RX_DIR) {
@@ -521,12 +521,12 @@ void rtllib_ba_setup_timeout(struct timer_list *t)
 void rtllib_tx_ba_inact_timeout(struct timer_list *t)
 {
 	struct tx_ts_record *ts = from_timer(ts, t,
-					      TxAdmittedBARecord.timer);
+					      tx_admitted_ba_record.timer);
 	struct rtllib_device *ieee = container_of(ts, struct rtllib_device,
 				     TxTsRecord[ts->num]);
 	tx_ts_delete_ba(ieee, ts);
 	rtllib_send_DELBA(ieee, ts->TsCommonInfo.addr,
-			  &ts->TxAdmittedBARecord, TX_DIR,
+			  &ts->tx_admitted_ba_record, TX_DIR,
 			  DELBA_REASON_TIMEOUT);
 }
 
diff --git a/drivers/staging/rtl8192e/rtl819x_TS.h b/drivers/staging/rtl8192e/rtl819x_TS.h
index f2bd53268e3a..40b0ed4fefaf 100644
--- a/drivers/staging/rtl8192e/rtl819x_TS.h
+++ b/drivers/staging/rtl8192e/rtl819x_TS.h
@@ -26,7 +26,7 @@ struct tx_ts_record {
 	struct ts_common_info TsCommonInfo;
 	u16				TxCurSeq;
 	struct ba_record TxPendingBARecord;
-	struct ba_record TxAdmittedBARecord;
+	struct ba_record tx_admitted_ba_record;
 	u8				add_ba_req_in_progress;
 	u8				add_ba_req_delayed;
 	u8				using_ba;
diff --git a/drivers/staging/rtl8192e/rtl819x_TSProc.c b/drivers/staging/rtl8192e/rtl819x_TSProc.c
index 039f070aadd1..0e59a3155c4a 100644
--- a/drivers/staging/rtl8192e/rtl819x_TSProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_TSProc.c
@@ -105,7 +105,7 @@ static void ResetTxTsEntry(struct tx_ts_record *ts)
 	ts->add_ba_req_delayed = false;
 	ts->using_ba = false;
 	ts->disable_add_ba = false;
-	rtllib_reset_ba_entry(&ts->TxAdmittedBARecord);
+	rtllib_reset_ba_entry(&ts->tx_admitted_ba_record);
 	rtllib_reset_ba_entry(&ts->TxPendingBARecord);
 }
 
@@ -134,7 +134,7 @@ void rtllib_ts_init(struct rtllib_device *ieee)
 
 		timer_setup(&pTxTS->TxPendingBARecord.timer, rtllib_ba_setup_timeout,
 			    0);
-		timer_setup(&pTxTS->TxAdmittedBARecord.timer,
+		timer_setup(&pTxTS->tx_admitted_ba_record.timer,
 			    rtllib_tx_ba_inact_timeout, 0);
 
 		ResetTxTsEntry(pTxTS);
diff --git a/drivers/staging/rtl8192e/rtllib_tx.c b/drivers/staging/rtl8192e/rtllib_tx.c
index 2ef617a55995..51a8286abd18 100644
--- a/drivers/staging/rtl8192e/rtllib_tx.c
+++ b/drivers/staging/rtl8192e/rtllib_tx.c
@@ -294,7 +294,7 @@ static void rtllib_tx_query_agg_cap(struct rtllib_device *ieee,
 			netdev_info(ieee->dev, "%s: can't get TS\n", __func__);
 			return;
 		}
-		if (!ts->TxAdmittedBARecord.b_valid) {
+		if (!ts->tx_admitted_ba_record.b_valid) {
 			if (ieee->wpa_ie_len && (ieee->pairwise_key_type ==
 			    KEY_TYPE_NA)) {
 				;
@@ -305,7 +305,7 @@ static void rtllib_tx_query_agg_cap(struct rtllib_device *ieee,
 			}
 			goto FORCED_AGG_SETTING;
 		} else if (!ts->using_ba) {
-			if (SN_LESS(ts->TxAdmittedBARecord.ba_start_seq_ctrl.field.seq_num,
+			if (SN_LESS(ts->tx_admitted_ba_record.ba_start_seq_ctrl.field.seq_num,
 				    (ts->TxCurSeq + 1) % 4096))
 				ts->using_ba = true;
 			else
-- 
2.39.2

