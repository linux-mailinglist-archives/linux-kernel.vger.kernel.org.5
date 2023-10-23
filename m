Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52DF97D2A98
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 08:40:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233546AbjJWGke (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 02:40:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233586AbjJWGkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 02:40:23 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 557C510C8
        for <linux-kernel@vger.kernel.org>; Sun, 22 Oct 2023 23:40:21 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-5221bd8f62eso992265a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 22 Oct 2023 23:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698043220; x=1698648020; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/TeDhj4M7bfk1ZuzV/MaUrRjjWL2B2L9H9sMD0IpBps=;
        b=A783w1Ds8Z1GhLTwNRnjw+Jto+Suyq/zVRywWs/1lSByXovup8byxz7HiPlMktHVt7
         UuEgqCgZuOY/yYtEV0nr8+53iAspfq/BTxrFmZOLeh4ng23QgGWpDwFKfP6ipnKOWKQG
         aG8/vX1YO/ssbOA61tLCQbTWKpwXuNbxrlrknbYWXYULbo1HydIggmfbkeUrHlgJ1jJX
         eqGpMalltVyFoSWXueloEIyrSMrT3Pnkq7RiSeRMTk/EXXV8+cWVRZq1cjnbtaPsMh9/
         WR+HJzcpCJrMqp5+aCUgTqgw9UsgZ+JuTWpgBhHjNxXvuDinPMphGRRU1udYo13a3MwI
         K0dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698043220; x=1698648020;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/TeDhj4M7bfk1ZuzV/MaUrRjjWL2B2L9H9sMD0IpBps=;
        b=Qki4+J9DF1nI00QtPFLocba059wU45/FuICa+JZIHsba12faiCvOJINLs4y6d5qhqc
         B2dqxIqEaNN0sSq8Q5bnB0za7v9IxkxVZlyNz9yXbf3fdlL2ZylLpGhKCBILur/0mkHg
         acNp/XmF7MxDjo9K4pZHRzRnktsvZW8fYD+0Os3OjjctBF7rGxjOGsQOecFXN8Dw4vIr
         tubWvxnGYPjUzEn4oJ+84eA3OSGJilUqBry4S/DLDTAGil53K7ke+Vp4UM7de7TKAHSA
         I1OARRvUbXq7I7EPkb5e5ipipdDXDkMvERGA9a6fq1MONMvne4dolyO/Th4FYmwyOjSK
         Edtg==
X-Gm-Message-State: AOJu0YxsKVuVH68GT5QMvEkYmFJPP6b2ftBP2fi2EEbHkUreLve7f4qC
        xh9Buwt+tbfcOHQQrmnVIHo=
X-Google-Smtp-Source: AGHT+IEVl5rNN4V55TPK/F5/vTw4pBk90mC64nnhAXlgmL+QPISSIUKWfCwD+kz26kb6HojEESAXrQ==
X-Received: by 2002:a17:906:225c:b0:9be:f78a:d438 with SMTP id 28-20020a170906225c00b009bef78ad438mr6701960ejr.5.1698043219752;
        Sun, 22 Oct 2023 23:40:19 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p579356c7.dip0.t-ipconnect.de. [87.147.86.199])
        by smtp.gmail.com with ESMTPSA id j21-20020a170906279500b009c7558b39fasm6164323ejc.194.2023.10.22.23.40.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Oct 2023 23:40:19 -0700 (PDT)
Date:   Mon, 23 Oct 2023 08:40:18 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 07/11] staging: rtl8192e: Replace union qos_tsinfo with
 embedded struct
Message-ID: <3bedc504ad678332e4ab2a3d99f2a94ab5aed03a.1698042685.git.philipp.g.hortmann@gmail.com>
References: <cover.1698042685.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1698042685.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace union qos_tsinfo with embedded struct as it has only one element.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl819x_BAProc.c |  2 +-
 drivers/staging/rtl8192e/rtl819x_Qos.h    |  8 +++-----
 drivers/staging/rtl8192e/rtl819x_TS.h     |  2 +-
 drivers/staging/rtl8192e/rtl819x_TSProc.c | 18 +++++++++---------
 4 files changed, 14 insertions(+), 16 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_BAProc.c b/drivers/staging/rtl8192e/rtl819x_BAProc.c
index f01fb7131c7e..4af8055d2489 100644
--- a/drivers/staging/rtl8192e/rtl819x_BAProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_BAProc.c
@@ -474,7 +474,7 @@ void rtllib_ts_init_add_ba(struct rtllib_device *ieee, struct tx_ts_record *ts,
 	ba->dialog_token++;
 	ba->ba_param_set.field.amsdu_support = 0;
 	ba->ba_param_set.field.ba_policy = policy;
-	ba->ba_param_set.field.tid = ts->TsCommonInfo.TSpec.field.ucTSID;
+	ba->ba_param_set.field.tid = ts->TsCommonInfo.TSpec.ucTSID;
 	ba->ba_param_set.field.buffer_size = 32;
 	ba->ba_timeout_value = 0;
 	ba->ba_start_seq_ctrl.field.seq_num = (ts->TxCurSeq + 3) % 4096;
diff --git a/drivers/staging/rtl8192e/rtl819x_Qos.h b/drivers/staging/rtl8192e/rtl819x_Qos.h
index 73fdf6aaed67..64a1e6aa501b 100644
--- a/drivers/staging/rtl8192e/rtl819x_Qos.h
+++ b/drivers/staging/rtl8192e/rtl819x_Qos.h
@@ -7,11 +7,9 @@
 #ifndef __INC_QOS_TYPE_H
 #define __INC_QOS_TYPE_H
 
-union qos_tsinfo {
-	struct {
-		u8		ucTSID:4;
-		u8		ucDirection:2;
-	} field;
+struct qos_tsinfo {
+	u8		ucTSID:4;
+	u8		ucDirection:2;
 };
 
 struct octet_string {
diff --git a/drivers/staging/rtl8192e/rtl819x_TS.h b/drivers/staging/rtl8192e/rtl819x_TS.h
index ed77763bb1fc..b63edb815902 100644
--- a/drivers/staging/rtl8192e/rtl819x_TS.h
+++ b/drivers/staging/rtl8192e/rtl819x_TS.h
@@ -20,7 +20,7 @@ enum tr_select {
 struct ts_common_info {
 	struct list_head		List;
 	u8				addr[ETH_ALEN];
-	union qos_tsinfo TSpec;
+	struct qos_tsinfo TSpec;
 	union qos_tclas TClass[TCLAS_NUM];
 	u8				TClasProc;
 	u8				TClasNum;
diff --git a/drivers/staging/rtl8192e/rtl819x_TSProc.c b/drivers/staging/rtl8192e/rtl819x_TSProc.c
index 969418031f5f..fbbe538f0632 100644
--- a/drivers/staging/rtl8192e/rtl819x_TSProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_TSProc.c
@@ -94,7 +94,7 @@ static void TsAddBaProcess(struct timer_list *t)
 static void ResetTsCommonInfo(struct ts_common_info *pTsCommonInfo)
 {
 	eth_zero_addr(pTsCommonInfo->addr);
-	memset(&pTsCommonInfo->TSpec, 0, sizeof(union qos_tsinfo));
+	memset(&pTsCommonInfo->TSpec, 0, sizeof(struct qos_tsinfo));
 	memset(&pTsCommonInfo->TClass, 0, sizeof(union qos_tclas) * TCLAS_NUM);
 	pTsCommonInfo->TClasProc = 0;
 	pTsCommonInfo->TClasNum = 0;
@@ -201,8 +201,8 @@ static struct ts_common_info *SearchAdmitTRStream(struct rtllib_device *ieee,
 			continue;
 		list_for_each_entry(pRet, psearch_list, List) {
 			if (memcmp(pRet->addr, addr, 6) == 0 &&
-			    pRet->TSpec.field.ucTSID == TID &&
-			    pRet->TSpec.field.ucDirection == dir)
+			    pRet->TSpec.ucTSID == TID &&
+			    pRet->TSpec.ucDirection == dir)
 				break;
 		}
 		if (&pRet->List  != psearch_list)
@@ -215,7 +215,7 @@ static struct ts_common_info *SearchAdmitTRStream(struct rtllib_device *ieee,
 }
 
 static void MakeTSEntry(struct ts_common_info *pTsCommonInfo, u8 *addr,
-			union qos_tsinfo *pTSPEC, union qos_tclas *pTCLAS,
+			struct qos_tsinfo *pTSPEC, union qos_tclas *pTCLAS,
 			u8 TCLAS_Num, u8 TCLAS_Proc)
 {
 	u8	count;
@@ -227,7 +227,7 @@ static void MakeTSEntry(struct ts_common_info *pTsCommonInfo, u8 *addr,
 
 	if (pTSPEC)
 		memcpy((u8 *)(&(pTsCommonInfo->TSpec)), (u8 *)pTSPEC,
-			sizeof(union qos_tsinfo));
+			sizeof(struct qos_tsinfo));
 
 	for (count = 0; count < TCLAS_Num; count++)
 		memcpy((u8 *)(&(pTsCommonInfo->TClass[count])),
@@ -241,8 +241,8 @@ bool rtllib_get_ts(struct rtllib_device *ieee, struct ts_common_info **ppTS,
 	   u8 *addr, u8 TID, enum tr_select TxRxSelect, bool bAddNewTs)
 {
 	u8	UP = 0;
-	union qos_tsinfo TSpec;
-	union qos_tsinfo *ts_info = &TSpec;
+	struct qos_tsinfo TSpec;
+	struct qos_tsinfo *ts_info = &TSpec;
 	struct list_head *pUnusedList;
 	struct list_head *pAddmitList;
 	enum direction_value Dir;
@@ -318,8 +318,8 @@ bool rtllib_get_ts(struct rtllib_device *ieee, struct ts_common_info **ppTS,
 		netdev_dbg(ieee->dev,
 			   "to init current TS, UP:%d, Dir:%d, addr: %pM ppTs=%p\n",
 			   UP, Dir, addr, *ppTS);
-		ts_info->field.ucTSID = UP;
-		ts_info->field.ucDirection = Dir;
+		ts_info->ucTSID = UP;
+		ts_info->ucDirection = Dir;
 
 		MakeTSEntry(*ppTS, addr, &TSpec, NULL, 0, 0);
 		list_add_tail(&((*ppTS)->List), pAddmitList);
-- 
2.42.0

