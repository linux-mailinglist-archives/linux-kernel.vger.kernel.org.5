Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF2467F98C8
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 06:37:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232466AbjK0FhG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 00:37:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232388AbjK0Fgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 00:36:37 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8849D10DA
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 21:36:32 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1cfb4d28c43so10274955ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 21:36:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1701063392; x=1701668192; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8PM44Sv5UeHigK85eZavancsIZjjcHcgvzRmLXENl9Y=;
        b=Q5DcejIxIrZTg5SNwPI3283VvYO8o1XkWrgA6LDyiaOAotV61JCLAqu1vL79DiAKG+
         vv+FGMHRoPisSAwLow80x3qTmTzUddHD88QzZi6Zk8TvsPv0xTdQnkBdzUi+ed41CxU4
         C2PEkF4rh922XP94tsZzbNx5YrfDdISVgS5vuw6XC2vYyB3j3GXyTr8Vn0J3mBkjJL9U
         maj57hiBJbO9iufvmnBgJyihhn0sDRm3uKpkk1l2BbRFsIDkuGvhEqfYv1LySJfXa/fK
         sQ9wVvg+Kjo55VI8Zb5d5oMcoiC93N1pZUcO4bsynGADzuhsGNUI1jA1CDrym8eo8TiF
         YeDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701063392; x=1701668192;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8PM44Sv5UeHigK85eZavancsIZjjcHcgvzRmLXENl9Y=;
        b=ugYnyuhcpNoHcZhVuA5u/gKqXd+XmhZKd6kUAa8ZYD4F0DxeezOKACIfDjz6cqkFwT
         /APRsWQFwHyHUY7tt1Tl84Aju6b8ZJv69XmhGSDLXecH24eYG+//Hh7bD+ff1scI9QJo
         Q32QvqedrNtGUvzoCEB/gfgtI15NfjwDIb7420aV47nanAfev7P8xc6/dpJWPv8UVa/1
         KxZdOUz1yVpy0W/E+E+/XQ/1kuZsf96lHKnEFFAQ8vu3XLCD20C4cusAiUsiodsrsJ3g
         WFOAM7Aalmbm79kQdspIhYUGfMp1dHuLnJP9oE58Gyp7krKDYZOaRizfEMiXNwV33Oy3
         L/DQ==
X-Gm-Message-State: AOJu0YxHRwT9Y14xBCqfa2NeLxeK3hk84brbHO3a+1hAJOQfwESyNNrw
        PGDoh73ZNcat+Se44PsnN5kK0NZUmmPTZioMg00=
X-Google-Smtp-Source: AGHT+IFP7ca8LnS/ff2C5FxTGyRUwr0BTpndq+nmeSNpa6zzaFA2shgCbOSShnZbIQKF3odmIc6JkA==
X-Received: by 2002:a17:902:db0d:b0:1cf:cc0d:9600 with SMTP id m13-20020a170902db0d00b001cfcc0d9600mr2677263plx.24.1701063391864;
        Sun, 26 Nov 2023 21:36:31 -0800 (PST)
Received: from basil.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id b6-20020a170902ed0600b001cc3875e658sm7300465pld.303.2023.11.26.21.36.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Nov 2023 21:36:31 -0800 (PST)
From:   Tree Davies <tdavies@darkphysics.net>
To:     gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com,
        anjan@momi.ca
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 13/15] Staging: rtl8192e: Rename variable pBaTimeoutVal
Date:   Sun, 26 Nov 2023 21:43:03 -0800
Message-ID: <20231127054305.148276-14-tdavies@darkphysics.net>
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

Rename variable pBaTimeoutVal to ba_timeout_value to fix checkpatch
warning Avoid CamelCase, and make the name consistent with variables
of same name/type.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtl819x_BAProc.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_BAProc.c b/drivers/staging/rtl8192e/rtl819x_BAProc.c
index 7074a01ad2e8..964029df310e 100644
--- a/drivers/staging/rtl8192e/rtl819x_BAProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_BAProc.c
@@ -218,7 +218,7 @@ int rtllib_rx_ADDBAReq(struct rtllib_device *ieee, struct sk_buff *skb)
 	u8 *dst = NULL, *dialog_token = NULL, *tag = NULL;
 	struct ba_record *ba = NULL;
 	union ba_param_set *ba_param_set = NULL;
-	u16 *pBaTimeoutVal = NULL;
+	u16 *ba_timeout_value = NULL;
 	union sequence_control *pBaStartSeqCtrl = NULL;
 	struct rx_ts_record *ts = NULL;
 
@@ -240,7 +240,7 @@ int rtllib_rx_ADDBAReq(struct rtllib_device *ieee, struct sk_buff *skb)
 	tag += sizeof(struct ieee80211_hdr_3addr);
 	dialog_token = tag + 2;
 	ba_param_set = (union ba_param_set *)(tag + 3);
-	pBaTimeoutVal = (u16 *)(tag + 5);
+	ba_timeout_value = (u16 *)(tag + 5);
 	pBaStartSeqCtrl = (union sequence_control *)(req + 7);
 
 	if (!ieee->current_network.qos_data.active ||
@@ -273,7 +273,7 @@ int rtllib_rx_ADDBAReq(struct rtllib_device *ieee, struct sk_buff *skb)
 	deactivate_ba_entry(ieee, ba);
 	ba->dialog_token = *dialog_token;
 	ba->ba_param_set = *ba_param_set;
-	ba->ba_timeout_value = *pBaTimeoutVal;
+	ba->ba_timeout_value = *ba_timeout_value;
 	ba->ba_start_seq_ctrl = *pBaStartSeqCtrl;
 
 	if (ieee->GetHalfNmodeSupportByAPsHandler(ieee->dev) ||
@@ -292,7 +292,7 @@ int rtllib_rx_ADDBAReq(struct rtllib_device *ieee, struct sk_buff *skb)
 		struct ba_record BA;
 
 		BA.ba_param_set = *ba_param_set;
-		BA.ba_timeout_value = *pBaTimeoutVal;
+		BA.ba_timeout_value = *ba_timeout_value;
 		BA.dialog_token = *dialog_token;
 		BA.ba_param_set.field.ba_policy = BA_POLICY_IMMEDIATE;
 		rtllib_send_ADDBARsp(ieee, dst, &BA, rc);
@@ -306,7 +306,7 @@ int rtllib_rx_ADDBARsp(struct rtllib_device *ieee, struct sk_buff *skb)
 	struct ba_record *pending_ba, *pAdmittedBA;
 	struct tx_ts_record *ts = NULL;
 	u8 *dst = NULL, *dialog_token = NULL, *tag = NULL;
-	u16 *status_code = NULL, *pBaTimeoutVal = NULL;
+	u16 *status_code = NULL, *ba_timeout_value = NULL;
 	union ba_param_set *ba_param_set = NULL;
 	u16			reason_code;
 
@@ -323,7 +323,7 @@ int rtllib_rx_ADDBARsp(struct rtllib_device *ieee, struct sk_buff *skb)
 	dialog_token = tag + 2;
 	status_code = (u16 *)(tag + 3);
 	ba_param_set = (union ba_param_set *)(tag + 5);
-	pBaTimeoutVal = (u16 *)(tag + 7);
+	ba_timeout_value = (u16 *)(tag + 7);
 
 	if (!ieee->current_network.qos_data.active ||
 	    !ieee->ht_info->current_ht_support ||
@@ -375,11 +375,11 @@ int rtllib_rx_ADDBARsp(struct rtllib_device *ieee, struct sk_buff *skb)
 		}
 
 		pAdmittedBA->dialog_token = *dialog_token;
-		pAdmittedBA->ba_timeout_value = *pBaTimeoutVal;
+		pAdmittedBA->ba_timeout_value = *ba_timeout_value;
 		pAdmittedBA->ba_start_seq_ctrl = pending_ba->ba_start_seq_ctrl;
 		pAdmittedBA->ba_param_set = *ba_param_set;
 		deactivate_ba_entry(ieee, pAdmittedBA);
-		activate_ba_entry(pAdmittedBA, *pBaTimeoutVal);
+		activate_ba_entry(pAdmittedBA, *ba_timeout_value);
 	} else {
 		ts->add_ba_req_delayed = true;
 		ts->disable_add_ba = true;
-- 
2.39.2

