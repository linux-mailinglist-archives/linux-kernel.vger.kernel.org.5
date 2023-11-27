Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8C667F98C0
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 06:36:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232344AbjK0Fgd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 00:36:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231144AbjK0FgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 00:36:19 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C4C9181
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 21:36:24 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1ce28faa92dso27611085ad.2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 21:36:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1701063383; x=1701668183; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7t+OYK182Y2YaDvus2aSQWjkkPId6oQnfxA8XGPoAC0=;
        b=YZJ5SHcl7aUmFDcJULk+rV3l+J4R4IeqMqvWwXlgCLxt4LaQ5YhOb2V+BClr6H7LrR
         Fkfy0/VZKEWt3eX3HDLJgOvZAazWm2DQH7Wn2RDEkHOvrAxPCrtcsknF1wlgw1fuyBQK
         ELbFS5+mOWL+WXyOgu5VFa9eOwtCo9MHcOu8DtMbFJzMlH+R4nEg/OhOzJDDdVrsx1+i
         MZowScH6oiU+sHhGLgdN8mNSHZcy1MW3auaInPzUH0TzqydlsDwJPWvFw9PanlfZ3nkW
         x/MzvzVoX4kmgrmqgfHBWT/1d4pp3HPFxEIyp/lo2QGPQcVgB0WZB8MJ1uiGg+c5DlFW
         DQ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701063383; x=1701668183;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7t+OYK182Y2YaDvus2aSQWjkkPId6oQnfxA8XGPoAC0=;
        b=UqZGd9cMunC1GiR77CQwNz4j5UfLB7qHRJUjixOxQ5phFFX7GK93Dp3xOHqujChigD
         eN2ja89PKQ5OdRJySvoDvKMSWONTp7MlXjM+duJ6358hwboafHVhFYCH6oE1xd8PfBnu
         pBe+Hn3wuJNT+T1H5y3jmRcqoQ1vCkyHWj5VFrg1rK1KlWJusDQonQZKz8AD2U190FoD
         Md/0c+SooHHTsq8sICaQW3XJqOygX07agpX1p7v8V79mQkH4RfOjnUMb5O7VUhutvDFh
         XKxQ+5sv3bvcZcvnrUv/YMEToFYM0NdfrvFNZXX45vvU76sJjWu1JhzOLUdBO0tISwJP
         /FAw==
X-Gm-Message-State: AOJu0Yx7ZVME2TEmaIM0rxu6sbCDQWvVn3S5bCSRZkzJOoqtYLxhddKz
        gNNvQeve0lY8+ZaeNwP/zh1+MQ==
X-Google-Smtp-Source: AGHT+IE57QNdCEPZbFQdAjj4hB6nPCp4P/v3sfj6qw9fmnuQ8lkMcFbQ3JqOoxc7Wvl2rp47jrRATw==
X-Received: by 2002:a17:902:a9c5:b0:1cf:b55d:a11d with SMTP id b5-20020a170902a9c500b001cfb55da11dmr4353516plr.24.1701063383569;
        Sun, 26 Nov 2023 21:36:23 -0800 (PST)
Received: from basil.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id b6-20020a170902ed0600b001cc3875e658sm7300465pld.303.2023.11.26.21.36.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Nov 2023 21:36:23 -0800 (PST)
From:   Tree Davies <tdavies@darkphysics.net>
To:     gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com,
        anjan@momi.ca
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 06/15] Staging: rtl8192e: Rename variable TxPendingBARecord
Date:   Sun, 26 Nov 2023 21:42:56 -0800
Message-ID: <20231127054305.148276-7-tdavies@darkphysics.net>
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

Rename variable TxPendingBARecord to tx_pending_ba_record to fix checkpatch
warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtl819x_BAProc.c | 12 ++++++------
 drivers/staging/rtl8192e/rtl819x_TS.h     |  2 +-
 drivers/staging/rtl8192e/rtl819x_TSProc.c |  4 ++--
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_BAProc.c b/drivers/staging/rtl8192e/rtl819x_BAProc.c
index db529559592b..51deab720e76 100644
--- a/drivers/staging/rtl8192e/rtl819x_BAProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_BAProc.c
@@ -26,7 +26,7 @@ static void deactivate_ba_entry(struct rtllib_device *ieee, struct ba_record *ba
 static u8 tx_ts_delete_ba(struct rtllib_device *ieee, struct tx_ts_record *ts)
 {
 	struct ba_record *admitted_ba = &ts->tx_admitted_ba_record;
-	struct ba_record *pending_ba = &ts->TxPendingBARecord;
+	struct ba_record *pending_ba = &ts->tx_pending_ba_record;
 	u8 send_del_ba = false;
 
 	if (pending_ba->b_valid) {
@@ -345,7 +345,7 @@ int rtllib_rx_ADDBARsp(struct rtllib_device *ieee, struct sk_buff *skb)
 	}
 
 	ts->add_ba_req_in_progress = false;
-	pending_ba = &ts->TxPendingBARecord;
+	pending_ba = &ts->tx_pending_ba_record;
 	pAdmittedBA = &ts->tx_admitted_ba_record;
 
 	if (pAdmittedBA->b_valid) {
@@ -464,7 +464,7 @@ int rtllib_rx_DELBA(struct rtllib_device *ieee, struct sk_buff *skb)
 void rtllib_ts_init_add_ba(struct rtllib_device *ieee, struct tx_ts_record *ts,
 			   u8 policy, u8	overwrite_pending)
 {
-	struct ba_record *ba = &ts->TxPendingBARecord;
+	struct ba_record *ba = &ts->tx_pending_ba_record;
 
 	if (ba->b_valid && !overwrite_pending)
 		return;
@@ -496,7 +496,7 @@ void rtllib_ts_init_del_ba(struct rtllib_device *ieee,
 			rtllib_send_DELBA(ieee, pTsCommonInfo->addr,
 					  (ts->tx_admitted_ba_record.b_valid) ?
 					 (&ts->tx_admitted_ba_record) :
-					(&ts->TxPendingBARecord),
+					(&ts->tx_pending_ba_record),
 					 TxRxSelect, DELBA_REASON_END_BA);
 	} else if (TxRxSelect == RX_DIR) {
 		struct rx_ts_record *ts =
@@ -511,11 +511,11 @@ void rtllib_ts_init_del_ba(struct rtllib_device *ieee,
 void rtllib_ba_setup_timeout(struct timer_list *t)
 {
 	struct tx_ts_record *ts = from_timer(ts, t,
-					      TxPendingBARecord.timer);
+					      tx_pending_ba_record.timer);
 
 	ts->add_ba_req_in_progress = false;
 	ts->add_ba_req_delayed = true;
-	ts->TxPendingBARecord.b_valid = false;
+	ts->tx_pending_ba_record.b_valid = false;
 }
 
 void rtllib_tx_ba_inact_timeout(struct timer_list *t)
diff --git a/drivers/staging/rtl8192e/rtl819x_TS.h b/drivers/staging/rtl8192e/rtl819x_TS.h
index 40b0ed4fefaf..fdd5f1a2e835 100644
--- a/drivers/staging/rtl8192e/rtl819x_TS.h
+++ b/drivers/staging/rtl8192e/rtl819x_TS.h
@@ -25,7 +25,7 @@ struct ts_common_info {
 struct tx_ts_record {
 	struct ts_common_info TsCommonInfo;
 	u16				TxCurSeq;
-	struct ba_record TxPendingBARecord;
+	struct ba_record tx_pending_ba_record;
 	struct ba_record tx_admitted_ba_record;
 	u8				add_ba_req_in_progress;
 	u8				add_ba_req_delayed;
diff --git a/drivers/staging/rtl8192e/rtl819x_TSProc.c b/drivers/staging/rtl8192e/rtl819x_TSProc.c
index 0e59a3155c4a..ed14e8e1ed93 100644
--- a/drivers/staging/rtl8192e/rtl819x_TSProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_TSProc.c
@@ -106,7 +106,7 @@ static void ResetTxTsEntry(struct tx_ts_record *ts)
 	ts->using_ba = false;
 	ts->disable_add_ba = false;
 	rtllib_reset_ba_entry(&ts->tx_admitted_ba_record);
-	rtllib_reset_ba_entry(&ts->TxPendingBARecord);
+	rtllib_reset_ba_entry(&ts->tx_pending_ba_record);
 }
 
 static void ResetRxTsEntry(struct rx_ts_record *ts)
@@ -132,7 +132,7 @@ void rtllib_ts_init(struct rtllib_device *ieee)
 		pTxTS->num = count;
 		timer_setup(&pTxTS->TsAddBaTimer, TsAddBaProcess, 0);
 
-		timer_setup(&pTxTS->TxPendingBARecord.timer, rtllib_ba_setup_timeout,
+		timer_setup(&pTxTS->tx_pending_ba_record.timer, rtllib_ba_setup_timeout,
 			    0);
 		timer_setup(&pTxTS->tx_admitted_ba_record.timer,
 			    rtllib_tx_ba_inact_timeout, 0);
-- 
2.39.2

