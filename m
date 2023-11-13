Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDC6C7EA403
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 20:53:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231515AbjKMTxA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 14:53:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231628AbjKMTwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 14:52:55 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12D4F91
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 11:52:52 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1cc3bc5df96so34323185ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 11:52:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1699905171; x=1700509971; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qo3uMaliVRibUrS7KmQM4KSj6CW/jxxQS8TpgfCHn60=;
        b=luX4fFSMvdMb/XOv9LV71t7EsgSfT5hzjjLjJE98cQdDTPC4f/aASAEblBQoRGvvDb
         UcWp9KnLCPMLnqzQO7MjiaXYS/Meuk8t8BX12Wo/yBV/jwKSLFYyfHbIIkMQA+/loFco
         1SBkmZFrb/eqSJIMxxjhgZns0+FGL5UwwyDd2DEC3WTQG8sIoRO1KsaWEi03vr3jwCFw
         8wVKZdCLHWufkdtiB2DIulRiio86tMn1dwY67hWpmobLXXRReJuFgtn772LrrGXYqWq2
         iB7kEZmcVtpXvx0nBhDmxLyeh8pOYfztsYfKWllE8rbmJGD3iB+MlI/E5XhKqfHw9+BZ
         C/jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699905171; x=1700509971;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qo3uMaliVRibUrS7KmQM4KSj6CW/jxxQS8TpgfCHn60=;
        b=GfDZI6Bbh3sjSZIz3JBVowA+URZ2TzS/PBaLxDcP9nrvSOUie8LkBUd5g9MEV3H/Wy
         TwyYEZ3TKBS0aoVBSB8CVc18UXifnTltG2mod0XfAB7mtURyn/vrQguh7DgLdjEnB1yc
         AdxcuLj5gppb8mNeIfNUW0ypmWXEAGvANuAt8YQt4kU/ecNu6xboWttfMZzcVuESTY55
         /ipQicdedUjczFihMPKw0t0+ccqK4DbanV3CHc+7p9Lnn1ui5qObsBBK4vdXaPGNvI75
         gKKXfRRZbdfkm1DtIr0szsIkIAcCMCQ40Il0yJzG1+/s7fBsTdHakbhJ1w69TY98kpVh
         0Blw==
X-Gm-Message-State: AOJu0YyNCM/kVPhYNJyIy2UZoaS5m2hP4jJzbkoRMAr89mAMFdGpVeds
        0z2zNhM2L0sqZte8gbuQLpGwyg==
X-Google-Smtp-Source: AGHT+IG6twGu3WCiI+o8qSf5YyGUuZSMTbYVZ0ePsT9tUJLVt5zMHwsph6NNa6Xd4Lo8UzUSeH3vFg==
X-Received: by 2002:a17:903:244f:b0:1cc:2f9d:6e9b with SMTP id l15-20020a170903244f00b001cc2f9d6e9bmr253595pls.20.1699905171643;
        Mon, 13 Nov 2023 11:52:51 -0800 (PST)
Received: from basil.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id t7-20020a170902bc4700b001c9d968563csm4395815plz.79.2023.11.13.11.52.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 11:52:51 -0800 (PST)
From:   Tree Davies <tdavies@darkphysics.net>
To:     gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com,
        anjan@momi.ca
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 3/7] Staging: rtl8192e: Rename variable bAddBaReqInProgress
Date:   Mon, 13 Nov 2023 11:59:06 -0800
Message-ID: <20231113195910.8423-4-tdavies@darkphysics.net>
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

Rename variable bAddBaReqInProgress to add_ba_req_in_progress to fix
checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtl819x_BAProc.c | 6 +++---
 drivers/staging/rtl8192e/rtl819x_TS.h     | 2 +-
 drivers/staging/rtl8192e/rtl819x_TSProc.c | 6 +++---
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_BAProc.c b/drivers/staging/rtl8192e/rtl819x_BAProc.c
index 404f873455fc..4d51c745e7f2 100644
--- a/drivers/staging/rtl8192e/rtl819x_BAProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_BAProc.c
@@ -344,7 +344,7 @@ int rtllib_rx_ADDBARsp(struct rtllib_device *ieee, struct sk_buff *skb)
 		goto OnADDBARsp_Reject;
 	}
 
-	ts->bAddBaReqInProgress = false;
+	ts->add_ba_req_in_progress = false;
 	pending_ba = &ts->TxPendingBARecord;
 	pAdmittedBA = &ts->TxAdmittedBARecord;
 
@@ -453,7 +453,7 @@ int rtllib_rx_DELBA(struct rtllib_device *ieee, struct sk_buff *skb)
 		}
 
 		pTxTs->bUsingBa = false;
-		pTxTs->bAddBaReqInProgress = false;
+		pTxTs->add_ba_req_in_progress = false;
 		pTxTs->bAddBaReqDelayed = false;
 		del_timer_sync(&pTxTs->TsAddBaTimer);
 		tx_ts_delete_ba(ieee, pTxTs);
@@ -513,7 +513,7 @@ void rtllib_ba_setup_timeout(struct timer_list *t)
 	struct tx_ts_record *pTxTs = from_timer(pTxTs, t,
 					      TxPendingBARecord.timer);
 
-	pTxTs->bAddBaReqInProgress = false;
+	pTxTs->add_ba_req_in_progress = false;
 	pTxTs->bAddBaReqDelayed = true;
 	pTxTs->TxPendingBARecord.b_valid = false;
 }
diff --git a/drivers/staging/rtl8192e/rtl819x_TS.h b/drivers/staging/rtl8192e/rtl819x_TS.h
index fff36315f174..276a50f98781 100644
--- a/drivers/staging/rtl8192e/rtl819x_TS.h
+++ b/drivers/staging/rtl8192e/rtl819x_TS.h
@@ -27,7 +27,7 @@ struct tx_ts_record {
 	u16				TxCurSeq;
 	struct ba_record TxPendingBARecord;
 	struct ba_record TxAdmittedBARecord;
-	u8				bAddBaReqInProgress;
+	u8				add_ba_req_in_progress;
 	u8				bAddBaReqDelayed;
 	u8				bUsingBa;
 	u8				bDisable_AddBa;
diff --git a/drivers/staging/rtl8192e/rtl819x_TSProc.c b/drivers/staging/rtl8192e/rtl819x_TSProc.c
index 3206fdb3e65a..62414e7b8879 100644
--- a/drivers/staging/rtl8192e/rtl819x_TSProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_TSProc.c
@@ -101,7 +101,7 @@ static void ResetTxTsEntry(struct tx_ts_record *ts)
 {
 	ResetTsCommonInfo(&ts->TsCommonInfo);
 	ts->TxCurSeq = 0;
-	ts->bAddBaReqInProgress = false;
+	ts->add_ba_req_in_progress = false;
 	ts->bAddBaReqDelayed = false;
 	ts->bUsingBa = false;
 	ts->bDisable_AddBa = false;
@@ -433,8 +433,8 @@ void RemoveAllTS(struct rtllib_device *ieee)
 
 void TsStartAddBaProcess(struct rtllib_device *ieee, struct tx_ts_record *pTxTS)
 {
-	if (pTxTS->bAddBaReqInProgress == false) {
-		pTxTS->bAddBaReqInProgress = true;
+	if (pTxTS->add_ba_req_in_progress == false) {
+		pTxTS->add_ba_req_in_progress = true;
 
 		if (pTxTS->bAddBaReqDelayed) {
 			netdev_dbg(ieee->dev, "Start ADDBA after 60 sec!!\n");
-- 
2.39.2

