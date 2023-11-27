Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CF677F98C7
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 06:37:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232378AbjK0FhC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 00:37:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231931AbjK0Fgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 00:36:31 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34A2A184
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 21:36:31 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1cfc2d03b3aso4394025ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 21:36:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1701063390; x=1701668190; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wRGlPinq49hmId5T7GGWMwmGcH6Fr21H2t959wvL11c=;
        b=d/D75T/q56Q6dYrAO3JsUFFmfV70GMi0AHg+PlgO/JxusdNcAH804t3HupoL0GR6Iz
         MFSDb2LyS2tMxJLRLPh6OfQi3y5BJu4KSczjcYGvzIKbsC5hOBCJybkjGKV7jIY9A3F1
         Y5c+67C9bgNu7VyFoMr+DQDfs+v+MC3MGMgS8mETTpJnlRW3qOhdae+WeF6RevMd6tLZ
         3XRYZYbAkz4lGh/lmhIBm6ASrCAiAQJsuPCybtHO8zC+zfabq2mYKRTgtRaxjFujtG1B
         HLICZn6KvSJ1K6F6Tnd/s9Bipm/JfytHQ4r59aHY67ynPXeA/rthQ5dSDcyAf81JeZH7
         zqqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701063390; x=1701668190;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wRGlPinq49hmId5T7GGWMwmGcH6Fr21H2t959wvL11c=;
        b=VB0Np5RKfPcpRG9edjzDfhymIghqSMNy5aq91gvYZZFL4HtW8ailq9/HgFW0kttzm7
         7O/+EkzoHl+Nb+dZsGOsgHsvPQD1FV2OO/1+xWPW04N7B30jdY1SSBq2dwZBfB5SNfoj
         b0osehwKs/Xn04wEGZ696RuNQiOVUObsPZF+7tp4ooqX/HrC7vNh2jCdxzX8AVv7eg34
         /HOD99GG1WI3qNmqstVeFQpTGi8G93hcO9tjULCcuSHWYwd8R43oHmpllaze5hfrt/ox
         Ay7nKHy7I8GnYgmTq7B22VkgPPFOkrA/u6Ni7mnYvIgl/YTUfmHaDaYzbdWijxCqxLml
         ZHFg==
X-Gm-Message-State: AOJu0YxckLZaUGQOaTWQBHW3On0ci+D77T6GOB5phizqH/EOn2QAK4tF
        aG62OMliXMxXgeADY+ZG87tc6Q==
X-Google-Smtp-Source: AGHT+IGALDll4IeJDU4dTVXoQihuuXYJuf0E0LL+K3imBQayxVKQC1VDR8/nm/kaQU8omQQWVgsYxA==
X-Received: by 2002:a17:903:1d2:b0:1cf:ad61:7a67 with SMTP id e18-20020a17090301d200b001cfad617a67mr8258718plh.32.1701063390670;
        Sun, 26 Nov 2023 21:36:30 -0800 (PST)
Received: from basil.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id b6-20020a170902ed0600b001cc3875e658sm7300465pld.303.2023.11.26.21.36.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Nov 2023 21:36:30 -0800 (PST)
From:   Tree Davies <tdavies@darkphysics.net>
To:     gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com,
        anjan@momi.ca
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 12/15] Staging: rtl8192e: Rename variable pBaParamSet
Date:   Sun, 26 Nov 2023 21:43:02 -0800
Message-ID: <20231127054305.148276-13-tdavies@darkphysics.net>
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

Rename variable pBaParamSet to ba_param_set to fix checkpatch
warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtl819x_BAProc.c | 24 +++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_BAProc.c b/drivers/staging/rtl8192e/rtl819x_BAProc.c
index bd037069d4f3..7074a01ad2e8 100644
--- a/drivers/staging/rtl8192e/rtl819x_BAProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_BAProc.c
@@ -217,7 +217,7 @@ int rtllib_rx_ADDBAReq(struct rtllib_device *ieee, struct sk_buff *skb)
 	u16 rc = 0;
 	u8 *dst = NULL, *dialog_token = NULL, *tag = NULL;
 	struct ba_record *ba = NULL;
-	union ba_param_set *pBaParamSet = NULL;
+	union ba_param_set *ba_param_set = NULL;
 	u16 *pBaTimeoutVal = NULL;
 	union sequence_control *pBaStartSeqCtrl = NULL;
 	struct rx_ts_record *ts = NULL;
@@ -239,7 +239,7 @@ int rtllib_rx_ADDBAReq(struct rtllib_device *ieee, struct sk_buff *skb)
 	dst = (u8 *)(&req->addr2[0]);
 	tag += sizeof(struct ieee80211_hdr_3addr);
 	dialog_token = tag + 2;
-	pBaParamSet = (union ba_param_set *)(tag + 3);
+	ba_param_set = (union ba_param_set *)(tag + 3);
 	pBaTimeoutVal = (u16 *)(tag + 5);
 	pBaStartSeqCtrl = (union sequence_control *)(req + 7);
 
@@ -254,14 +254,14 @@ int rtllib_rx_ADDBAReq(struct rtllib_device *ieee, struct sk_buff *skb)
 		goto OnADDBAReq_Fail;
 	}
 	if (!rtllib_get_ts(ieee, (struct ts_common_info **)&ts, dst,
-		   (u8)(pBaParamSet->field.tid), RX_DIR, true)) {
+		   (u8)(ba_param_set->field.tid), RX_DIR, true)) {
 		rc = ADDBA_STATUS_REFUSED;
 		netdev_warn(ieee->dev, "%s(): can't get TS\n", __func__);
 		goto OnADDBAReq_Fail;
 	}
 	ba = &ts->rx_admitted_ba_record;
 
-	if (pBaParamSet->field.ba_policy == BA_POLICY_DELAYED) {
+	if (ba_param_set->field.ba_policy == BA_POLICY_DELAYED) {
 		rc = ADDBA_STATUS_INVALID_PARAM;
 		netdev_warn(ieee->dev, "%s(): BA Policy is not correct\n",
 			    __func__);
@@ -272,7 +272,7 @@ int rtllib_rx_ADDBAReq(struct rtllib_device *ieee, struct sk_buff *skb)
 
 	deactivate_ba_entry(ieee, ba);
 	ba->dialog_token = *dialog_token;
-	ba->ba_param_set = *pBaParamSet;
+	ba->ba_param_set = *ba_param_set;
 	ba->ba_timeout_value = *pBaTimeoutVal;
 	ba->ba_start_seq_ctrl = *pBaStartSeqCtrl;
 
@@ -291,7 +291,7 @@ int rtllib_rx_ADDBAReq(struct rtllib_device *ieee, struct sk_buff *skb)
 	{
 		struct ba_record BA;
 
-		BA.ba_param_set = *pBaParamSet;
+		BA.ba_param_set = *ba_param_set;
 		BA.ba_timeout_value = *pBaTimeoutVal;
 		BA.dialog_token = *dialog_token;
 		BA.ba_param_set.field.ba_policy = BA_POLICY_IMMEDIATE;
@@ -307,7 +307,7 @@ int rtllib_rx_ADDBARsp(struct rtllib_device *ieee, struct sk_buff *skb)
 	struct tx_ts_record *ts = NULL;
 	u8 *dst = NULL, *dialog_token = NULL, *tag = NULL;
 	u16 *status_code = NULL, *pBaTimeoutVal = NULL;
-	union ba_param_set *pBaParamSet = NULL;
+	union ba_param_set *ba_param_set = NULL;
 	u16			reason_code;
 
 	if (skb->len < sizeof(struct ieee80211_hdr_3addr) + 9) {
@@ -322,7 +322,7 @@ int rtllib_rx_ADDBARsp(struct rtllib_device *ieee, struct sk_buff *skb)
 	tag += sizeof(struct ieee80211_hdr_3addr);
 	dialog_token = tag + 2;
 	status_code = (u16 *)(tag + 3);
-	pBaParamSet = (union ba_param_set *)(tag + 5);
+	ba_param_set = (union ba_param_set *)(tag + 5);
 	pBaTimeoutVal = (u16 *)(tag + 7);
 
 	if (!ieee->current_network.qos_data.active ||
@@ -338,7 +338,7 @@ int rtllib_rx_ADDBARsp(struct rtllib_device *ieee, struct sk_buff *skb)
 	}
 
 	if (!rtllib_get_ts(ieee, (struct ts_common_info **)&ts, dst,
-		   (u8)(pBaParamSet->field.tid), TX_DIR, false)) {
+		   (u8)(ba_param_set->field.tid), TX_DIR, false)) {
 		netdev_warn(ieee->dev, "%s(): can't get TS\n", __func__);
 		reason_code = DELBA_REASON_UNKNOWN_BA;
 		goto OnADDBARsp_Reject;
@@ -367,7 +367,7 @@ int rtllib_rx_ADDBARsp(struct rtllib_device *ieee, struct sk_buff *skb)
 	}
 
 	if (*status_code == ADDBA_STATUS_SUCCESS) {
-		if (pBaParamSet->field.ba_policy == BA_POLICY_DELAYED) {
+		if (ba_param_set->field.ba_policy == BA_POLICY_DELAYED) {
 			ts->add_ba_req_delayed = true;
 			deactivate_ba_entry(ieee, pAdmittedBA);
 			reason_code = DELBA_REASON_END_BA;
@@ -377,7 +377,7 @@ int rtllib_rx_ADDBARsp(struct rtllib_device *ieee, struct sk_buff *skb)
 		pAdmittedBA->dialog_token = *dialog_token;
 		pAdmittedBA->ba_timeout_value = *pBaTimeoutVal;
 		pAdmittedBA->ba_start_seq_ctrl = pending_ba->ba_start_seq_ctrl;
-		pAdmittedBA->ba_param_set = *pBaParamSet;
+		pAdmittedBA->ba_param_set = *ba_param_set;
 		deactivate_ba_entry(ieee, pAdmittedBA);
 		activate_ba_entry(pAdmittedBA, *pBaTimeoutVal);
 	} else {
@@ -393,7 +393,7 @@ int rtllib_rx_ADDBARsp(struct rtllib_device *ieee, struct sk_buff *skb)
 	{
 		struct ba_record BA;
 
-		BA.ba_param_set = *pBaParamSet;
+		BA.ba_param_set = *ba_param_set;
 		rtllib_send_DELBA(ieee, dst, &BA, TX_DIR, reason_code);
 		return 0;
 	}
-- 
2.39.2

