Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B46967EA404
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 20:53:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231842AbjKMTxD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 14:53:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbjKMTw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 14:52:56 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44D4CD68
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 11:52:53 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1ce3084c2d1so6522735ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 11:52:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1699905173; x=1700509973; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eRT/m2rbtV9N0AV2BHjKfpwydERRwEVgVz4ChgsF6I8=;
        b=llnUukS5oFT0kZqq3FNNu8nNlfkfbiZFqn9uINIKS0UsX8UrOIPzG5QvHep1qZAUyO
         +Nzjk8V7Oe+xcjU1zS/4KudwCA3jw/JCc41efnOE3mdlT4TWqp5jNVV3UNkvyiJ+7gBy
         tPrYPw1brBlAhsii15SoXZ4cRQwavEuWtjGizU7YTg6lSq7HwlKFzDvGZHZvxU3CSLBx
         DZZeMPJDXqgXRy4KEpisvlq2n5fHpzLsSEjaGxUuOKZVAC+yVOojF1X+XLZ/wuCP+w4C
         bC0euTetYlq0ZUjrrc3eB+JEDupFcoaLbXJSOU2BRL/+DdFjP+iO380mHkDNue/QZ+W4
         H7gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699905173; x=1700509973;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eRT/m2rbtV9N0AV2BHjKfpwydERRwEVgVz4ChgsF6I8=;
        b=QhBsaFGcP06s2b1+66Y43m4e8mEyzRmiiHby1iUYxPffn7gmc8phjer0Ne0dFkhMyM
         ROlqdStDrogtoqA6MYwWZEw9KVc3juIuhvIP2p0Wo68s69t3/t8aJkMYrPgdpnukNa2z
         Qi4LFdPIdM50I+NlMR9G+RovCte177QvMUvQecxTzYtdyKriN42VIrHU4m2cFgluGAkW
         iElCTvfkljuKjW/BKhasKNHbacWqvD1bME5Rq651zbFOvV7ZXUvk7+x3LKHkzN605del
         BM6rrLOY8DtZBFVo1OntOB+vkAEf2A7n+hr3V6nEMOudQq+1Cy+xmTG5e08OdzuU2lLS
         LMuA==
X-Gm-Message-State: AOJu0YyPUFsqcj9amRYoZp52Jlz5TOX8cXSu7IongzlUb23RO6VtEKbR
        kLWHM244BZ0sTcM62jW1UCxo9w==
X-Google-Smtp-Source: AGHT+IGW3Z5l4zDxvfih2rnr1N48hs2NYZ61EU9CiqxCqmlP10DkK+9ilW39OfiS+HfIfPt1brGVTw==
X-Received: by 2002:a17:903:2308:b0:1ca:29f:4b06 with SMTP id d8-20020a170903230800b001ca029f4b06mr282353plh.2.1699905172824;
        Mon, 13 Nov 2023 11:52:52 -0800 (PST)
Received: from basil.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id t7-20020a170902bc4700b001c9d968563csm4395815plz.79.2023.11.13.11.52.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 11:52:52 -0800 (PST)
From:   Tree Davies <tdavies@darkphysics.net>
To:     gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com,
        anjan@momi.ca
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 4/7] Staging: rtl8192e: Rename variable bAddBaReqDelayed
Date:   Mon, 13 Nov 2023 11:59:07 -0800
Message-ID: <20231113195910.8423-5-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231113195910.8423-1-tdavies@darkphysics.net>
References: <20231113195910.8423-1-tdavies@darkphysics.net>
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

Rename variable bAddBaReqDelayed to add_ba_req_delayed to fix
checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtl819x_BAProc.c | 8 ++++----
 drivers/staging/rtl8192e/rtl819x_TS.h     | 2 +-
 drivers/staging/rtl8192e/rtl819x_TSProc.c | 4 ++--
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_BAProc.c b/drivers/staging/rtl8192e/rtl819x_BAProc.c
index 4d51c745e7f2..631c857c508f 100644
--- a/drivers/staging/rtl8192e/rtl819x_BAProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_BAProc.c
@@ -368,7 +368,7 @@ int rtllib_rx_ADDBARsp(struct rtllib_device *ieee, struct sk_buff *skb)
 
 	if (*status_code == ADDBA_STATUS_SUCCESS) {
 		if (pBaParamSet->field.ba_policy == BA_POLICY_DELAYED) {
-			ts->bAddBaReqDelayed = true;
+			ts->add_ba_req_delayed = true;
 			deactivate_ba_entry(ieee, pAdmittedBA);
 			reason_code = DELBA_REASON_END_BA;
 			goto OnADDBARsp_Reject;
@@ -381,7 +381,7 @@ int rtllib_rx_ADDBARsp(struct rtllib_device *ieee, struct sk_buff *skb)
 		deactivate_ba_entry(ieee, pAdmittedBA);
 		activate_ba_entry(pAdmittedBA, *pBaTimeoutVal);
 	} else {
-		ts->bAddBaReqDelayed = true;
+		ts->add_ba_req_delayed = true;
 		ts->bDisable_AddBa = true;
 		reason_code = DELBA_REASON_END_BA;
 		goto OnADDBARsp_Reject;
@@ -454,7 +454,7 @@ int rtllib_rx_DELBA(struct rtllib_device *ieee, struct sk_buff *skb)
 
 		pTxTs->bUsingBa = false;
 		pTxTs->add_ba_req_in_progress = false;
-		pTxTs->bAddBaReqDelayed = false;
+		pTxTs->add_ba_req_delayed = false;
 		del_timer_sync(&pTxTs->TsAddBaTimer);
 		tx_ts_delete_ba(ieee, pTxTs);
 	}
@@ -514,7 +514,7 @@ void rtllib_ba_setup_timeout(struct timer_list *t)
 					      TxPendingBARecord.timer);
 
 	pTxTs->add_ba_req_in_progress = false;
-	pTxTs->bAddBaReqDelayed = true;
+	pTxTs->add_ba_req_delayed = true;
 	pTxTs->TxPendingBARecord.b_valid = false;
 }
 
diff --git a/drivers/staging/rtl8192e/rtl819x_TS.h b/drivers/staging/rtl8192e/rtl819x_TS.h
index 276a50f98781..0bf73b625708 100644
--- a/drivers/staging/rtl8192e/rtl819x_TS.h
+++ b/drivers/staging/rtl8192e/rtl819x_TS.h
@@ -28,7 +28,7 @@ struct tx_ts_record {
 	struct ba_record TxPendingBARecord;
 	struct ba_record TxAdmittedBARecord;
 	u8				add_ba_req_in_progress;
-	u8				bAddBaReqDelayed;
+	u8				add_ba_req_delayed;
 	u8				bUsingBa;
 	u8				bDisable_AddBa;
 	struct timer_list		TsAddBaTimer;
diff --git a/drivers/staging/rtl8192e/rtl819x_TSProc.c b/drivers/staging/rtl8192e/rtl819x_TSProc.c
index 62414e7b8879..3a1bb512ca69 100644
--- a/drivers/staging/rtl8192e/rtl819x_TSProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_TSProc.c
@@ -102,7 +102,7 @@ static void ResetTxTsEntry(struct tx_ts_record *ts)
 	ResetTsCommonInfo(&ts->TsCommonInfo);
 	ts->TxCurSeq = 0;
 	ts->add_ba_req_in_progress = false;
-	ts->bAddBaReqDelayed = false;
+	ts->add_ba_req_delayed = false;
 	ts->bUsingBa = false;
 	ts->bDisable_AddBa = false;
 	rtllib_reset_ba_entry(&ts->TxAdmittedBARecord);
@@ -436,7 +436,7 @@ void TsStartAddBaProcess(struct rtllib_device *ieee, struct tx_ts_record *pTxTS)
 	if (pTxTS->add_ba_req_in_progress == false) {
 		pTxTS->add_ba_req_in_progress = true;
 
-		if (pTxTS->bAddBaReqDelayed) {
+		if (pTxTS->add_ba_req_delayed) {
 			netdev_dbg(ieee->dev, "Start ADDBA after 60 sec!!\n");
 			mod_timer(&pTxTS->TsAddBaTimer, jiffies +
 				  msecs_to_jiffies(TS_ADDBA_DELAY));
-- 
2.39.2

