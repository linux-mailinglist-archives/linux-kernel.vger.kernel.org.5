Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEA4D7A913E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 05:21:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbjIUDV4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 23:21:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjIUDVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 23:21:37 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CDB7F4
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 20:21:31 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-6910ea9cddbso228305b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 20:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1695266490; x=1695871290; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bjH6iOpaG+K0VeRik6vkPL3+XconrKzqUHw5TsZ+3TU=;
        b=e6qhTZ1VXsHz0xrj2Ekt8YPwrJt6kg3RN3AK9WtMfFhQDSZnWapgaSmVp1p9cYoB+Q
         y947H0FBYuO0gJXeNlFZoFzZ5MDDiLLabLqv3mhLTCh+TjAUNzLMW8xvGyTnbaVx0IZp
         kwzbAg2vXbkW+xYU+gsujexnpaifiMc+/Lts3wibbqwimnLZ04eZpQ7NR7v/UTpynOZl
         rm4SSsM3pKT33yGBjdiXH9nxvET6Xqke+QA7rxS83GaPrUW5T+vxkCPYRZNSOFBkNgoi
         2vaJ2n/HA6rg6/9Ol4tpUKweviIBiYR+ZwAmPcA9dsfMSAcwDDfGsqtGotbT5hiWWE5d
         aH3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695266490; x=1695871290;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bjH6iOpaG+K0VeRik6vkPL3+XconrKzqUHw5TsZ+3TU=;
        b=ntovXp8mAThCnUDGGhRSU0+WSaACCLr4RJcVY1KKottmXehRi/MD1aBG3kPhlF6LL0
         hJlJjnojszkC2Xf2o22U/zEKrJrQJpSu+APrVhfFGRgO+nNS5rfwzV4+b4ZvmUeExBWr
         1U37T2Dt/NzQyzP2pWygZIi6jx5zvH8qhOOlUcZDq9rAFLjThKuyZMsnIWatsj6GWYpM
         V/yAKKYvB2cCVZptEYIVZ7riGeGLzYD8Wvy+8eB2maWaRttWWX1NROb25drX+6nf8RVc
         Wnunmz21Z6ICebvKbnZVCUyT9HbzmQsJUvxa+0fFqdCnZVulQhd59foJAQ4hKiUjtKqG
         rsTQ==
X-Gm-Message-State: AOJu0Yz8weRxiF5pKw96NUk0BbztSSp0AUtrNIPD8/vnLbNUqBF/pAMM
        AsN5hbi/t3Bnx+CztU43n6c5zw==
X-Google-Smtp-Source: AGHT+IHz6mW/ON4S2/COWzLpnRWQHugM656VgCdGGhnNlW1fNj473a3lOdsiCpzkMfeC5b/Ts2l9kg==
X-Received: by 2002:a05:6a00:2d08:b0:690:ce36:8b00 with SMTP id fa8-20020a056a002d0800b00690ce368b00mr5250152pfb.2.1695266490610;
        Wed, 20 Sep 2023 20:21:30 -0700 (PDT)
Received: from basil.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id p14-20020a62ab0e000000b0068e49cb1692sm237324pff.1.2023.09.20.20.21.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 20:21:30 -0700 (PDT)
From:   Tree Davies <tdavies@darkphysics.net>
To:     gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com,
        anjan@momi.ca
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 05/11] Staging: rtl8192e: Rename variable pPendingBA
Date:   Wed, 20 Sep 2023 20:25:09 -0700
Message-ID: <20230921032515.96152-6-tdavies@darkphysics.net>
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

Rename variable pPendingBA to pending_ba to fix checkpatch warning Avoid
CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtl819x_BAProc.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_BAProc.c b/drivers/staging/rtl8192e/rtl819x_BAProc.c
index 621dbca7716a..e6892bb7958c 100644
--- a/drivers/staging/rtl8192e/rtl819x_BAProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_BAProc.c
@@ -303,7 +303,7 @@ int rtllib_rx_ADDBAReq(struct rtllib_device *ieee, struct sk_buff *skb)
 int rtllib_rx_ADDBARsp(struct rtllib_device *ieee, struct sk_buff *skb)
 {
 	struct ieee80211_hdr_3addr *rsp = NULL;
-	struct ba_record *pPendingBA, *pAdmittedBA;
+	struct ba_record *pending_ba, *pAdmittedBA;
 	struct tx_ts_record *pTS = NULL;
 	u8 *dst = NULL, *pDialogToken = NULL, *tag = NULL;
 	u16 *pStatusCode = NULL, *pBaTimeoutVal = NULL;
@@ -345,15 +345,15 @@ int rtllib_rx_ADDBARsp(struct rtllib_device *ieee, struct sk_buff *skb)
 	}
 
 	pTS->bAddBaReqInProgress = false;
-	pPendingBA = &pTS->TxPendingBARecord;
+	pending_ba = &pTS->TxPendingBARecord;
 	pAdmittedBA = &pTS->TxAdmittedBARecord;
 
 	if (pAdmittedBA->b_valid) {
 		netdev_dbg(ieee->dev, "%s(): ADDBA response already admitted\n",
 			   __func__);
 		return -1;
-	} else if (!pPendingBA->b_valid ||
-		   (*pDialogToken != pPendingBA->dialog_token)) {
+	} else if (!pending_ba->b_valid ||
+		   (*pDialogToken != pending_ba->dialog_token)) {
 		netdev_warn(ieee->dev,
 			    "%s(): ADDBA Rsp. BA invalid, DELBA!\n",
 			    __func__);
@@ -363,7 +363,7 @@ int rtllib_rx_ADDBARsp(struct rtllib_device *ieee, struct sk_buff *skb)
 		netdev_dbg(ieee->dev,
 			   "%s(): Recv ADDBA Rsp. BA is admitted! Status code:%X\n",
 			   __func__, *pStatusCode);
-		deactivate_ba_entry(ieee, pPendingBA);
+		deactivate_ba_entry(ieee, pending_ba);
 	}
 
 	if (*pStatusCode == ADDBA_STATUS_SUCCESS) {
@@ -376,7 +376,7 @@ int rtllib_rx_ADDBARsp(struct rtllib_device *ieee, struct sk_buff *skb)
 
 		pAdmittedBA->dialog_token = *pDialogToken;
 		pAdmittedBA->ba_timeout_value = *pBaTimeoutVal;
-		pAdmittedBA->ba_start_seq_ctrl = pPendingBA->ba_start_seq_ctrl;
+		pAdmittedBA->ba_start_seq_ctrl = pending_ba->ba_start_seq_ctrl;
 		pAdmittedBA->ba_param_set = *pBaParamSet;
 		deactivate_ba_entry(ieee, pAdmittedBA);
 		activate_ba_entry(pAdmittedBA, *pBaTimeoutVal);
-- 
2.39.2

