Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D10197F98C9
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 06:37:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232493AbjK0FhM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 00:37:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232406AbjK0Fgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 00:36:38 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B32710F6
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 21:36:34 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1cf80a7be0aso31484705ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 21:36:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1701063393; x=1701668193; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AtJK7mZuXOY4guA3qIV1p7LNy/r3mdWBevupreTz+OE=;
        b=WCdMBOCLDEN3u7Qza5dh3iPofgEtv4lfDCqdCo7bHQXD/8r9wblDC0bKmuxIcIhwuQ
         GZuAIRu143UC7VXxN4EV9+f64H9Hd96Of5w5NtrVaed3jiTwjmg//gxdhh7O0zfEr0mF
         qCfHaBbblys0JdFG0678fDcddy5I1J1+1E4gc06GOdhY0Wl/1QAnbuZowh/jpqXkLs1D
         EVmV0QnsC2zW/ewUyhSoUpAiNa9SS1ljSpjG0acOe1Wqz2YrvDK7r+Q844lx0SOoGKDz
         /Fz4zkrK6EBIDACDY50PTw8GbOn5/VoiNPX+gWmXo+MekZ59tubgshzG3VD8+ZC/zk3D
         JCUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701063393; x=1701668193;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AtJK7mZuXOY4guA3qIV1p7LNy/r3mdWBevupreTz+OE=;
        b=nJH8v/ySjdtWrchnR/7z2qm0Asy8ImLNM2V/rwygVpODbPjy9vSgDvtCiAGe7vUncD
         nguT9Bst4ZV4HNAdD00pOW2DAq+MmtHYRcjJAf4zwRFi3mJJFPTgnLuwrUyUe4AwzVeY
         hl3diMZVoCDK3yttRTp2toxJQIBVHVND+ObDrdxv9mf3bKdSE3H21wT4MAWl7GweHTWo
         k/pbs0RDNf6wGQOa56mL5c/0PYK14HLEdydVbpXncwnDARM81MzpVl7lZV2zPqbOS4qP
         uSwDtZtMwnj0hkcUNS8Cf4lnh3HKF01m5ds8vY29q039XC6TU9D5pi5tzLeQSynG+aRS
         +k5g==
X-Gm-Message-State: AOJu0Yx3myI5BbC8aD0G175nWYPoAP5hXnefZ7VaqdxupRIFKrC6mz6E
        SiZI3UFOuG90OOpSN1GpoQ2ccQ==
X-Google-Smtp-Source: AGHT+IFXlVDHEwAHNFRKsqffoUtfvXLUe5l1y2FnOIdBYfL9VJdypsffTSG4o7KRc9BzrmANrieclQ==
X-Received: by 2002:a17:902:e80e:b0:1cf:daca:2b5e with SMTP id u14-20020a170902e80e00b001cfdaca2b5emr134321plg.38.1701063393392;
        Sun, 26 Nov 2023 21:36:33 -0800 (PST)
Received: from basil.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id b6-20020a170902ed0600b001cc3875e658sm7300465pld.303.2023.11.26.21.36.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Nov 2023 21:36:32 -0800 (PST)
From:   Tree Davies <tdavies@darkphysics.net>
To:     gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com,
        anjan@momi.ca
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 14/15] Staging: rtl8192e: Rename variable pAdmittedBA
Date:   Sun, 26 Nov 2023 21:43:04 -0800
Message-ID: <20231127054305.148276-15-tdavies@darkphysics.net>
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

Rename variable pAdmittedBA to admitted_ba to fix checkpatch
warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtl819x_BAProc.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_BAProc.c b/drivers/staging/rtl8192e/rtl819x_BAProc.c
index 964029df310e..b00d0f7c7517 100644
--- a/drivers/staging/rtl8192e/rtl819x_BAProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_BAProc.c
@@ -303,7 +303,7 @@ int rtllib_rx_ADDBAReq(struct rtllib_device *ieee, struct sk_buff *skb)
 int rtllib_rx_ADDBARsp(struct rtllib_device *ieee, struct sk_buff *skb)
 {
 	struct ieee80211_hdr_3addr *rsp = NULL;
-	struct ba_record *pending_ba, *pAdmittedBA;
+	struct ba_record *pending_ba, *admitted_ba;
 	struct tx_ts_record *ts = NULL;
 	u8 *dst = NULL, *dialog_token = NULL, *tag = NULL;
 	u16 *status_code = NULL, *ba_timeout_value = NULL;
@@ -346,9 +346,9 @@ int rtllib_rx_ADDBARsp(struct rtllib_device *ieee, struct sk_buff *skb)
 
 	ts->add_ba_req_in_progress = false;
 	pending_ba = &ts->tx_pending_ba_record;
-	pAdmittedBA = &ts->tx_admitted_ba_record;
+	admitted_ba = &ts->tx_admitted_ba_record;
 
-	if (pAdmittedBA->b_valid) {
+	if (admitted_ba->b_valid) {
 		netdev_dbg(ieee->dev, "%s(): ADDBA response already admitted\n",
 			   __func__);
 		return -1;
@@ -369,17 +369,17 @@ int rtllib_rx_ADDBARsp(struct rtllib_device *ieee, struct sk_buff *skb)
 	if (*status_code == ADDBA_STATUS_SUCCESS) {
 		if (ba_param_set->field.ba_policy == BA_POLICY_DELAYED) {
 			ts->add_ba_req_delayed = true;
-			deactivate_ba_entry(ieee, pAdmittedBA);
+			deactivate_ba_entry(ieee, admitted_ba);
 			reason_code = DELBA_REASON_END_BA;
 			goto OnADDBARsp_Reject;
 		}
 
-		pAdmittedBA->dialog_token = *dialog_token;
-		pAdmittedBA->ba_timeout_value = *ba_timeout_value;
-		pAdmittedBA->ba_start_seq_ctrl = pending_ba->ba_start_seq_ctrl;
-		pAdmittedBA->ba_param_set = *ba_param_set;
-		deactivate_ba_entry(ieee, pAdmittedBA);
-		activate_ba_entry(pAdmittedBA, *ba_timeout_value);
+		admitted_ba->dialog_token = *dialog_token;
+		admitted_ba->ba_timeout_value = *ba_timeout_value;
+		admitted_ba->ba_start_seq_ctrl = pending_ba->ba_start_seq_ctrl;
+		admitted_ba->ba_param_set = *ba_param_set;
+		deactivate_ba_entry(ieee, admitted_ba);
+		activate_ba_entry(admitted_ba, *ba_timeout_value);
 	} else {
 		ts->add_ba_req_delayed = true;
 		ts->disable_add_ba = true;
-- 
2.39.2

