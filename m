Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44C997F98CA
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 06:37:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232527AbjK0FhX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 00:37:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231849AbjK0Fgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 00:36:39 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A4BF1733
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 21:36:35 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1cfcc9b3b5cso4477885ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 21:36:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1701063394; x=1701668194; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zrOmN5h7Hp9zhTp9GrVqL3qhDYZcamqD4piT786f28U=;
        b=H8TTMSYSjcugVaakFKpf0qqR/bOnLLRsEuSXhQTtdM5Pzk406MiuK3tvU2y0lBBh48
         EcC+ElQkgnlfBdRHeIUJODzVkrMb+m3PjC/1e8rsX3FAB8jaKrdhXnnFRLZ3bPAj5yeE
         dbNZ3kEzs4VAquvN5lgPZ9WLsSZqb75hZQ2pKlAUVtBgo3rKAOiaDwYQYbVqCD7YV8V2
         SpTIc8YTEigB0vnHDYQBMFZDLQj69UzHiqofNGFaObvjcR6k/pMRfU3rL/7cuqc/j6vM
         Lr1nmU0upEDuXfzrGWjN4qCKkRZmB2thDTwRE7uhhvIIDQxFWSqcO+P6jk+wlhCaz2Sa
         ZtuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701063394; x=1701668194;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zrOmN5h7Hp9zhTp9GrVqL3qhDYZcamqD4piT786f28U=;
        b=HTj6cq5k48UljsU4Mu65DQv/PFocl3LZF13ieuyvhsOxOTTI0P7QCwtg7+CRRVgk0d
         HzKcFZlICILjFAQxVBfCuLD4zbNeynOzBAHHpqM7W0wY6wD9FvoKWG+bWgWxYVT2+ozj
         JJWlJxpKdqMRYIGNr/J192YH2JHsdL/e6+lbbn1qbyuS4VjDpACMvXsES+hlGmS7O2l9
         aPjXQJgo32MOruwmH8jStvZ5mD51ALYcTF0z/NqEQyOlcDBXrXtb8WxEmhsrRIFeui9u
         zSbu4oXD9pBLDEMktQcLFuejuHlxGFt+YtMxPhyNrOTMJwSYwR/3/VMqdAPGon31Oyhk
         vDYg==
X-Gm-Message-State: AOJu0YxgIJnIqsMm8cAb+04Cn0cQm15cma55/zLl5ll2vwVcc7BUPwU/
        Nl6KD/I62uQLY7TWMsD9SEmFEw==
X-Google-Smtp-Source: AGHT+IHKWM5PNkHMdgW7GOMibQDlx4FTE9/Ju8V8e7vWg7P8uTMRAzIYK0dviMay6bdBd9R6o3ewfw==
X-Received: by 2002:a17:903:11c8:b0:1cc:511d:eb43 with SMTP id q8-20020a17090311c800b001cc511deb43mr13690297plh.61.1701063394559;
        Sun, 26 Nov 2023 21:36:34 -0800 (PST)
Received: from basil.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id b6-20020a170902ed0600b001cc3875e658sm7300465pld.303.2023.11.26.21.36.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Nov 2023 21:36:34 -0800 (PST)
From:   Tree Davies <tdavies@darkphysics.net>
To:     gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com,
        anjan@momi.ca
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 15/15] Staging: rtl8192e: Rename variable TsCommonInfo
Date:   Sun, 26 Nov 2023 21:43:05 -0800
Message-ID: <20231127054305.148276-16-tdavies@darkphysics.net>
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

Rename variable TsCommonInfo to ts_common_info to fix checkpatch
warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtl819x_BAProc.c | 6 +++---
 drivers/staging/rtl8192e/rtl819x_TS.h     | 2 +-
 drivers/staging/rtl8192e/rtl819x_TSProc.c | 6 +++---
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_BAProc.c b/drivers/staging/rtl8192e/rtl819x_BAProc.c
index b00d0f7c7517..58a950ef77ce 100644
--- a/drivers/staging/rtl8192e/rtl819x_BAProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_BAProc.c
@@ -474,14 +474,14 @@ void rtllib_ts_init_add_ba(struct rtllib_device *ieee, struct tx_ts_record *ts,
 	ba->dialog_token++;
 	ba->ba_param_set.field.amsdu_support = 0;
 	ba->ba_param_set.field.ba_policy = policy;
-	ba->ba_param_set.field.tid = ts->TsCommonInfo.tspec.ucTSID;
+	ba->ba_param_set.field.tid = ts->ts_common_info.tspec.ucTSID;
 	ba->ba_param_set.field.buffer_size = 32;
 	ba->ba_timeout_value = 0;
 	ba->ba_start_seq_ctrl.field.seq_num = (ts->tx_cur_seq + 3) % 4096;
 
 	activate_ba_entry(ba, BA_SETUP_TIMEOUT);
 
-	rtllib_send_ADDBAReq(ieee, ts->TsCommonInfo.addr, ba);
+	rtllib_send_ADDBAReq(ieee, ts->ts_common_info.addr, ba);
 }
 
 void rtllib_ts_init_del_ba(struct rtllib_device *ieee,
@@ -525,7 +525,7 @@ void rtllib_tx_ba_inact_timeout(struct timer_list *t)
 	struct rtllib_device *ieee = container_of(ts, struct rtllib_device,
 				     TxTsRecord[ts->num]);
 	tx_ts_delete_ba(ieee, ts);
-	rtllib_send_DELBA(ieee, ts->TsCommonInfo.addr,
+	rtllib_send_DELBA(ieee, ts->ts_common_info.addr,
 			  &ts->tx_admitted_ba_record, TX_DIR,
 			  DELBA_REASON_TIMEOUT);
 }
diff --git a/drivers/staging/rtl8192e/rtl819x_TS.h b/drivers/staging/rtl8192e/rtl819x_TS.h
index 8e22c717fb27..31f7cfbb3aa5 100644
--- a/drivers/staging/rtl8192e/rtl819x_TS.h
+++ b/drivers/staging/rtl8192e/rtl819x_TS.h
@@ -23,7 +23,7 @@ struct ts_common_info {
 };
 
 struct tx_ts_record {
-	struct ts_common_info TsCommonInfo;
+	struct ts_common_info ts_common_info;
 	u16				tx_cur_seq;
 	struct ba_record tx_pending_ba_record;
 	struct ba_record tx_admitted_ba_record;
diff --git a/drivers/staging/rtl8192e/rtl819x_TSProc.c b/drivers/staging/rtl8192e/rtl819x_TSProc.c
index f96538f3e4ee..bec73bc53dd0 100644
--- a/drivers/staging/rtl8192e/rtl819x_TSProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_TSProc.c
@@ -99,7 +99,7 @@ static void ResetTsCommonInfo(struct ts_common_info *ts_common_info)
 
 static void ResetTxTsEntry(struct tx_ts_record *ts)
 {
-	ResetTsCommonInfo(&ts->TsCommonInfo);
+	ResetTsCommonInfo(&ts->ts_common_info);
 	ts->tx_cur_seq = 0;
 	ts->add_ba_req_in_progress = false;
 	ts->add_ba_req_delayed = false;
@@ -138,7 +138,7 @@ void rtllib_ts_init(struct rtllib_device *ieee)
 			    rtllib_tx_ba_inact_timeout, 0);
 
 		ResetTxTsEntry(pTxTS);
-		list_add_tail(&pTxTS->TsCommonInfo.List,
+		list_add_tail(&pTxTS->ts_common_info.List,
 				&ieee->Tx_TS_Unused_List);
 		pTxTS++;
 	}
@@ -292,7 +292,7 @@ bool rtllib_get_ts(struct rtllib_device *ieee, struct ts_common_info **ppTS,
 			struct tx_ts_record *tmp =
 				container_of(*ppTS,
 				struct tx_ts_record,
-				TsCommonInfo);
+				ts_common_info);
 			ResetTxTsEntry(tmp);
 		} else {
 			struct rx_ts_record *ts =
-- 
2.39.2

