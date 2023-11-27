Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C65D7F98C1
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 06:36:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232413AbjK0Fgj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 00:36:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231314AbjK0FgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 00:36:20 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42D86189
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 21:36:25 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1cfae5ca719so13902145ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 21:36:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1701063385; x=1701668185; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tVZx2znymTutkOywVzUkt2j2sn+uTemk2vkexBlkB8A=;
        b=lXtH+WCTPNK3SmWE65BNYyNLduRpJx2uRYYQ95vbOQch4/go5rmy+K/rT5FZ7g8lUT
         A+aenF8Dg1rJUbSUAIWwPLZ3iLc5jAQJCrbz5PxTNTokyeacDp90VN10ugZ4JvQjsjMb
         P0vNvzedBa0fahDmmzDBinXTuUr2idTRhgLb96arIWRqy8UzzZEoIJNaLvSjZZQWhU20
         retcC4C628eL9+1D43YrrAGyjlw+uYn8ZOcmXPW46Ibz/C0FPIRneyah/XuVEfvKrZsI
         DQNjIZ/2MSuAMOy3TTLlY7AetUonfZQYfDB3WdlBAm9K3XXXPMqVvSfEftq0DEb68y8I
         tvYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701063385; x=1701668185;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tVZx2znymTutkOywVzUkt2j2sn+uTemk2vkexBlkB8A=;
        b=mPeDq4011MnHSB6w/wUj+EQp/pQ7yQOD8gseZ1m4mW60Tfswi/TfT2Gyr+bOtrSke/
         aabztaDG7v9k5F4ZsvW5og1DvigDKitFSGDMWrwpY+3FVrqmqFg8aNyMjKLBqqnL+2xv
         IRTdwHYgxu9kTFffJG6h9UFZQ53pJh5gB1f0gi4DMq2NSn/vflv5/sfz+8UEPm+xN4/K
         +M19g3mNN5+fA+f66FNsoZuuIWd/wKIyvUmEcSSpdKRrj/eRP/ipMVuoAoOVh20hLYZ2
         piZe33qrqnCf+nZBPPWFLcQ68srWdTjNEJ3aAa5QZPOg3u+qpxNjBFRan0kHEarS1iq3
         brew==
X-Gm-Message-State: AOJu0Yz7qaNUFMk83JPuQUTrWdR0BV09+t4a7g+10ALRZzqA3Vf1DeXV
        yZLkbA16b4J3wPEP+BBZi3EDXw==
X-Google-Smtp-Source: AGHT+IFgTjNmDfa98uCeE9DnBvPC5kZubca/TiaCBOiEBfJvfJgqdUncaAbgjCkb8hDdxr4iO7033A==
X-Received: by 2002:a17:902:ec85:b0:1cf:a9c4:7f4b with SMTP id x5-20020a170902ec8500b001cfa9c47f4bmr9325205plg.24.1701063384760;
        Sun, 26 Nov 2023 21:36:24 -0800 (PST)
Received: from basil.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id b6-20020a170902ed0600b001cc3875e658sm7300465pld.303.2023.11.26.21.36.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Nov 2023 21:36:24 -0800 (PST)
From:   Tree Davies <tdavies@darkphysics.net>
To:     gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com,
        anjan@momi.ca
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 07/15] Staging: rtl8192e: Rename variable pDialogToken
Date:   Sun, 26 Nov 2023 21:42:57 -0800
Message-ID: <20231127054305.148276-8-tdavies@darkphysics.net>
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

Rename variable pDialogToken to dialog_token to fix checkpatch
warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtl819x_BAProc.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_BAProc.c b/drivers/staging/rtl8192e/rtl819x_BAProc.c
index 51deab720e76..78da79ebd775 100644
--- a/drivers/staging/rtl8192e/rtl819x_BAProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_BAProc.c
@@ -215,7 +215,7 @@ int rtllib_rx_ADDBAReq(struct rtllib_device *ieee, struct sk_buff *skb)
 {
 	struct ieee80211_hdr_3addr *req = NULL;
 	u16 rc = 0;
-	u8 *dst = NULL, *pDialogToken = NULL, *tag = NULL;
+	u8 *dst = NULL, *dialog_token = NULL, *tag = NULL;
 	struct ba_record *ba = NULL;
 	union ba_param_set *pBaParamSet = NULL;
 	u16 *pBaTimeoutVal = NULL;
@@ -238,7 +238,7 @@ int rtllib_rx_ADDBAReq(struct rtllib_device *ieee, struct sk_buff *skb)
 	tag = (u8 *)req;
 	dst = (u8 *)(&req->addr2[0]);
 	tag += sizeof(struct ieee80211_hdr_3addr);
-	pDialogToken = tag + 2;
+	dialog_token = tag + 2;
 	pBaParamSet = (union ba_param_set *)(tag + 3);
 	pBaTimeoutVal = (u16 *)(tag + 5);
 	pBaStartSeqCtrl = (union sequence_control *)(req + 7);
@@ -271,7 +271,7 @@ int rtllib_rx_ADDBAReq(struct rtllib_device *ieee, struct sk_buff *skb)
 	rtllib_FlushRxTsPendingPkts(ieee, ts);
 
 	deactivate_ba_entry(ieee, ba);
-	ba->dialog_token = *pDialogToken;
+	ba->dialog_token = *dialog_token;
 	ba->ba_param_set = *pBaParamSet;
 	ba->ba_timeout_value = *pBaTimeoutVal;
 	ba->ba_start_seq_ctrl = *pBaStartSeqCtrl;
@@ -293,7 +293,7 @@ int rtllib_rx_ADDBAReq(struct rtllib_device *ieee, struct sk_buff *skb)
 
 		BA.ba_param_set = *pBaParamSet;
 		BA.ba_timeout_value = *pBaTimeoutVal;
-		BA.dialog_token = *pDialogToken;
+		BA.dialog_token = *dialog_token;
 		BA.ba_param_set.field.ba_policy = BA_POLICY_IMMEDIATE;
 		rtllib_send_ADDBARsp(ieee, dst, &BA, rc);
 		return 0;
@@ -305,7 +305,7 @@ int rtllib_rx_ADDBARsp(struct rtllib_device *ieee, struct sk_buff *skb)
 	struct ieee80211_hdr_3addr *rsp = NULL;
 	struct ba_record *pending_ba, *pAdmittedBA;
 	struct tx_ts_record *ts = NULL;
-	u8 *dst = NULL, *pDialogToken = NULL, *tag = NULL;
+	u8 *dst = NULL, *dialog_token = NULL, *tag = NULL;
 	u16 *status_code = NULL, *pBaTimeoutVal = NULL;
 	union ba_param_set *pBaParamSet = NULL;
 	u16			reason_code;
@@ -320,7 +320,7 @@ int rtllib_rx_ADDBARsp(struct rtllib_device *ieee, struct sk_buff *skb)
 	tag = (u8 *)rsp;
 	dst = (u8 *)(&rsp->addr2[0]);
 	tag += sizeof(struct ieee80211_hdr_3addr);
-	pDialogToken = tag + 2;
+	dialog_token = tag + 2;
 	status_code = (u16 *)(tag + 3);
 	pBaParamSet = (union ba_param_set *)(tag + 5);
 	pBaTimeoutVal = (u16 *)(tag + 7);
@@ -353,7 +353,7 @@ int rtllib_rx_ADDBARsp(struct rtllib_device *ieee, struct sk_buff *skb)
 			   __func__);
 		return -1;
 	} else if (!pending_ba->b_valid ||
-		   (*pDialogToken != pending_ba->dialog_token)) {
+		   (*dialog_token != pending_ba->dialog_token)) {
 		netdev_warn(ieee->dev,
 			    "%s(): ADDBA Rsp. BA invalid, DELBA!\n",
 			    __func__);
@@ -374,7 +374,7 @@ int rtllib_rx_ADDBARsp(struct rtllib_device *ieee, struct sk_buff *skb)
 			goto OnADDBARsp_Reject;
 		}
 
-		pAdmittedBA->dialog_token = *pDialogToken;
+		pAdmittedBA->dialog_token = *dialog_token;
 		pAdmittedBA->ba_timeout_value = *pBaTimeoutVal;
 		pAdmittedBA->ba_start_seq_ctrl = pending_ba->ba_start_seq_ctrl;
 		pAdmittedBA->ba_param_set = *pBaParamSet;
-- 
2.39.2

