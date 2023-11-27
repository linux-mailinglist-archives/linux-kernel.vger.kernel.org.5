Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 890557F98BE
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 06:36:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbjK0Fg0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 00:36:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbjK0FgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 00:36:15 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C71DF0
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 21:36:21 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1ce3084c2d1so30783775ad.3
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 21:36:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1701063381; x=1701668181; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sSWu4uGFFfQhQmuUasXzTA2bl0qaMckYxBPrKB/bvN8=;
        b=CvpfOwzMYYqXBfj9GF6cc+qPaqUnc7bwPJpBOWDopRuqqGxlvq5yBrezF8kxSu7tFM
         UrwJfR3oWrKSgVPYQDIrWRA12v6tsTsL0c3vQ+DFjlgmuKI0sElpBm75cXL6K864jM8M
         Wm355kVgiwLF1q0TjGshRbgpXneRKH5Edw2xN4MkX7zlBataB4AsBUemLf5qo2Q+nF+l
         xWQ086FSBuPV3QbREkNT0fru+8WV2yJBC8AWXNm6fSQMYe/mjUtwGjHk8YPkrT7xtR0m
         b+Y8pddO5BrM+X8do3Loizyyqwebb5nCd4MxrPOimIg1CKJOeAGtOQuIeIwwfBmO1F0V
         p/8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701063381; x=1701668181;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sSWu4uGFFfQhQmuUasXzTA2bl0qaMckYxBPrKB/bvN8=;
        b=esjmYDrxU7s05dDFNn/Nm/0YA+XCOutl1KDLQivl2rrSQ2+qvjyOPWrYX9HTdy+/2I
         Bsq/rtez5Y8341LpkduGP74pPqzrcAO/JKnec4KX6CPwLeyFDfPFqOMVSOihrdNfEuPS
         +zErnwbVaxspkq1UlOt9NamprR/NQwMuLnL3puIiDJzuGAgYHSg2yYruN8o2JEjc2UxC
         paZ5h5LiUjVqIOn/Dxdc/3rF2KpImxUtpWGWVtz8A5Inc6S4k2/dWPED0a0Lev7SLvE4
         kgVpxp0dCrzsKWgNfFN3pjxs7zS543S/oonQC6TBR6IUo7oJWJsKlpcyAzQs+GgL5jL4
         93QA==
X-Gm-Message-State: AOJu0Yy96yDBI4vngKz7Wq/yeOwQl84Sp2R1zPUEjppnbgvrp+R2oumL
        HDCPrNLCUEffREU/apUSoIyP5w==
X-Google-Smtp-Source: AGHT+IG9zsMtaxazmqVWmdOzqH/Oz69e+MfWSKGg/wU+gjSjEdOmvtli7gZHl/eLoW7O1VsLZFXmUQ==
X-Received: by 2002:a17:902:6947:b0:1cf:c2dc:1c1c with SMTP id k7-20020a170902694700b001cfc2dc1c1cmr5407619plt.29.1701063381031;
        Sun, 26 Nov 2023 21:36:21 -0800 (PST)
Received: from basil.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id b6-20020a170902ed0600b001cc3875e658sm7300465pld.303.2023.11.26.21.36.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Nov 2023 21:36:20 -0800 (PST)
From:   Tree Davies <tdavies@darkphysics.net>
To:     gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com,
        anjan@momi.ca
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 04/15] Staging: rtl8192e: Rename variable TSpec
Date:   Sun, 26 Nov 2023 21:42:54 -0800
Message-ID: <20231127054305.148276-5-tdavies@darkphysics.net>
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

Rename variable TSpec to tspec to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtl819x_BAProc.c |  2 +-
 drivers/staging/rtl8192e/rtl819x_TS.h     |  2 +-
 drivers/staging/rtl8192e/rtl819x_TSProc.c | 14 +++++++-------
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_BAProc.c b/drivers/staging/rtl8192e/rtl819x_BAProc.c
index 06aaae68aa6a..bf8d42668990 100644
--- a/drivers/staging/rtl8192e/rtl819x_BAProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_BAProc.c
@@ -474,7 +474,7 @@ void rtllib_ts_init_add_ba(struct rtllib_device *ieee, struct tx_ts_record *ts,
 	ba->dialog_token++;
 	ba->ba_param_set.field.amsdu_support = 0;
 	ba->ba_param_set.field.ba_policy = policy;
-	ba->ba_param_set.field.tid = ts->TsCommonInfo.TSpec.ucTSID;
+	ba->ba_param_set.field.tid = ts->TsCommonInfo.tspec.ucTSID;
 	ba->ba_param_set.field.buffer_size = 32;
 	ba->ba_timeout_value = 0;
 	ba->ba_start_seq_ctrl.field.seq_num = (ts->TxCurSeq + 3) % 4096;
diff --git a/drivers/staging/rtl8192e/rtl819x_TS.h b/drivers/staging/rtl8192e/rtl819x_TS.h
index 742f575ea637..f2bd53268e3a 100644
--- a/drivers/staging/rtl8192e/rtl819x_TS.h
+++ b/drivers/staging/rtl8192e/rtl819x_TS.h
@@ -19,7 +19,7 @@ enum tr_select {
 struct ts_common_info {
 	struct list_head		List;
 	u8				addr[ETH_ALEN];
-	struct qos_tsinfo TSpec;
+	struct qos_tsinfo tspec;
 };
 
 struct tx_ts_record {
diff --git a/drivers/staging/rtl8192e/rtl819x_TSProc.c b/drivers/staging/rtl8192e/rtl819x_TSProc.c
index 01d077bf0155..039f070aadd1 100644
--- a/drivers/staging/rtl8192e/rtl819x_TSProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_TSProc.c
@@ -94,7 +94,7 @@ static void TsAddBaProcess(struct timer_list *t)
 static void ResetTsCommonInfo(struct ts_common_info *pTsCommonInfo)
 {
 	eth_zero_addr(pTsCommonInfo->addr);
-	memset(&pTsCommonInfo->TSpec, 0, sizeof(struct qos_tsinfo));
+	memset(&pTsCommonInfo->tspec, 0, sizeof(struct qos_tsinfo));
 }
 
 static void ResetTxTsEntry(struct tx_ts_record *ts)
@@ -198,8 +198,8 @@ static struct ts_common_info *SearchAdmitTRStream(struct rtllib_device *ieee,
 			continue;
 		list_for_each_entry(pRet, psearch_list, List) {
 			if (memcmp(pRet->addr, addr, 6) == 0 &&
-			    pRet->TSpec.ucTSID == TID &&
-			    pRet->TSpec.ucDirection == dir)
+			    pRet->tspec.ucTSID == TID &&
+			    pRet->tspec.ucDirection == dir)
 				break;
 		}
 		if (&pRet->List  != psearch_list)
@@ -220,7 +220,7 @@ static void MakeTSEntry(struct ts_common_info *pTsCommonInfo, u8 *addr,
 	memcpy(pTsCommonInfo->addr, addr, 6);
 
 	if (pTSPEC)
-		memcpy((u8 *)(&(pTsCommonInfo->TSpec)), (u8 *)pTSPEC,
+		memcpy((u8 *)(&(pTsCommonInfo->tspec)), (u8 *)pTSPEC,
 			sizeof(struct qos_tsinfo));
 }
 
@@ -228,8 +228,8 @@ bool rtllib_get_ts(struct rtllib_device *ieee, struct ts_common_info **ppTS,
 	   u8 *addr, u8 TID, enum tr_select TxRxSelect, bool bAddNewTs)
 {
 	u8	UP = 0;
-	struct qos_tsinfo TSpec;
-	struct qos_tsinfo *ts_info = &TSpec;
+	struct qos_tsinfo tspec;
+	struct qos_tsinfo *ts_info = &tspec;
 	struct list_head *pUnusedList;
 	struct list_head *pAddmitList;
 	enum direction_value Dir;
@@ -308,7 +308,7 @@ bool rtllib_get_ts(struct rtllib_device *ieee, struct ts_common_info **ppTS,
 		ts_info->ucTSID = UP;
 		ts_info->ucDirection = Dir;
 
-		MakeTSEntry(*ppTS, addr, &TSpec);
+		MakeTSEntry(*ppTS, addr, &tspec);
 		list_add_tail(&((*ppTS)->List), pAddmitList);
 
 		return true;
-- 
2.39.2

