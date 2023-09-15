Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 068207A2344
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 18:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234903AbjIOQHt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 12:07:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236449AbjIOQHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 12:07:23 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3C3D173A
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 09:07:13 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-40471c054f9so5597985e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 09:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694794032; x=1695398832; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8MAQysHswzKdSn6dt98Oe4Oe6j9LPER8jfsz6Ld6Vfw=;
        b=gEyeD1ilrzbbB9zCfJsPyJCGsKFf4UP5Pn8BrgAoZm+MCHXEkISSAw7hB0jaDpF0+8
         0fhePxjp69+jS57Mramcq55+kCWq4eEw+QD0ErBo1MtGvb3A226WANne2SchdoiFujyt
         vui13qZ5iYheHrZJkWrrk8Ebsda44MKNpqEhPupZY9J76rD3p62z10Z+PCEGnAaWzJyH
         KXH3wRl16lIFZoO3hCqPCL8l/OrxEV8fy/qZ59w9bToCmDlH0MK2U/04Shjb9usjlDgp
         KbK9Y49RFHzKFHbNWxw9RMePP4sYUGiv4G5/OVoUVA4swzd3If0VeWGZ8bscsw8HiDU/
         YHBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694794032; x=1695398832;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8MAQysHswzKdSn6dt98Oe4Oe6j9LPER8jfsz6Ld6Vfw=;
        b=A6fpoCjNvyiNsvXG3+mDm8v+NnGlBngfQSL3FCLQoEUkWaGKfauqhSxLYh0Zx2EZJj
         ker6qYGV6mKuuarxXJZUer/eY0/2WCOo5L6wd0JmRY1IVwiBmvKusDfnf3XkAy69kL++
         rHlJsayqse2Xa4q0t/zYIwFMBuvSujoeWahajuBOraKBrmKc1Q3fJepiYM3qeHg835UW
         gufx+VJ8ksCFUZJEkLC9B/MeCBZ3tnPK2s6r6RQGoh96qSvdl1NwDNJo8sbK0knVXSxp
         2jvtKE9B9SSWBDn9mSdSe7/3/N598bhaDDu+Vg8Ey6+kaJqesAqdUnOLrkXGp9BNq9xH
         BHaQ==
X-Gm-Message-State: AOJu0Yx80mgfxGeF2Gt6XjBeFtPgscUwqQXHQ5eYDWwf/5mflrvDN/Uv
        u59hUilfKufDqDnNa4oSqILqrX3991UJDQ==
X-Google-Smtp-Source: AGHT+IFXqQzfmj5OEscy8clergs2nxHr2/MUqe9l2wpq9rBBOsyxjQVYLVGx0v6OtsmKK87tSUG8wQ==
X-Received: by 2002:a05:6000:1047:b0:31f:a096:6e18 with SMTP id c7-20020a056000104700b0031fa0966e18mr1761609wrx.6.1694794032054;
        Fri, 15 Sep 2023 09:07:12 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p579356c7.dip0.t-ipconnect.de. [87.147.86.199])
        by smtp.gmail.com with ESMTPSA id z4-20020a5d4c84000000b003197c7d08ddsm4759614wrs.71.2023.09.15.09.07.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 09:07:11 -0700 (PDT)
Date:   Fri, 15 Sep 2023 18:07:10 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 03/16] staging: rtl8192e: Replace struct rtllib_hdr_3addr in
 rtl819x_BAProc.c
Message-ID: <aa6d81b6a8bc0f126d174ccbee25fd93d072fa59.1694792595.git.philipp.g.hortmann@gmail.com>
References: <cover.1694792595.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1694792595.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace struct rtllib_hdr_3addr with struct ieee80211_hdr_3addr to avoid
proprietary struct.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl819x_BAProc.c | 48 +++++++++++------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_BAProc.c b/drivers/staging/rtl8192e/rtl819x_BAProc.c
index bc6f9e8c5dd8..4cadbf549933 100644
--- a/drivers/staging/rtl8192e/rtl819x_BAProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_BAProc.c
@@ -68,7 +68,7 @@ static struct sk_buff *rtllib_ADDBA(struct rtllib_device *ieee, u8 *Dst,
 				    u16 StatusCode, u8 type)
 {
 	struct sk_buff *skb = NULL;
-	struct rtllib_hdr_3addr *BAReq = NULL;
+	struct ieee80211_hdr_3addr *BAReq = NULL;
 	u8 *tag = NULL;
 	u16 len = ieee->tx_headroom + 9;
 
@@ -79,21 +79,21 @@ static struct sk_buff *rtllib_ADDBA(struct rtllib_device *ieee, u8 *Dst,
 		netdev_warn(ieee->dev, "pBA is NULL\n");
 		return NULL;
 	}
-	skb = dev_alloc_skb(len + sizeof(struct rtllib_hdr_3addr));
+	skb = dev_alloc_skb(len + sizeof(struct ieee80211_hdr_3addr));
 	if (!skb)
 		return NULL;
 
-	memset(skb->data, 0, sizeof(struct rtllib_hdr_3addr));
+	memset(skb->data, 0, sizeof(struct ieee80211_hdr_3addr));
 
 	skb_reserve(skb, ieee->tx_headroom);
 
-	BAReq = skb_put(skb, sizeof(struct rtllib_hdr_3addr));
+	BAReq = skb_put(skb, sizeof(struct ieee80211_hdr_3addr));
 
 	ether_addr_copy(BAReq->addr1, Dst);
 	ether_addr_copy(BAReq->addr2, ieee->dev->dev_addr);
 
 	ether_addr_copy(BAReq->addr3, ieee->current_network.bssid);
-	BAReq->frame_ctl = cpu_to_le16(RTLLIB_STYPE_MANAGE_ACT);
+	BAReq->frame_control = cpu_to_le16(RTLLIB_STYPE_MANAGE_ACT);
 
 	tag = skb_put(skb, 9);
 	*tag++ = ACT_CAT_BA;
@@ -129,7 +129,7 @@ static struct sk_buff *rtllib_DELBA(struct rtllib_device *ieee, u8 *dst,
 {
 	union delba_param_set DelbaParamSet;
 	struct sk_buff *skb = NULL;
-	struct rtllib_hdr_3addr *Delba = NULL;
+	struct ieee80211_hdr_3addr *Delba = NULL;
 	u8 *tag = NULL;
 	u16 len = 6 + ieee->tx_headroom;
 
@@ -142,18 +142,18 @@ static struct sk_buff *rtllib_DELBA(struct rtllib_device *ieee, u8 *dst,
 	DelbaParamSet.field.initiator = (TxRxSelect == TX_DIR) ? 1 : 0;
 	DelbaParamSet.field.tid	= pBA->ba_param_set.field.tid;
 
-	skb = dev_alloc_skb(len + sizeof(struct rtllib_hdr_3addr));
+	skb = dev_alloc_skb(len + sizeof(struct ieee80211_hdr_3addr));
 	if (!skb)
 		return NULL;
 
 	skb_reserve(skb, ieee->tx_headroom);
 
-	Delba = skb_put(skb, sizeof(struct rtllib_hdr_3addr));
+	Delba = skb_put(skb, sizeof(struct ieee80211_hdr_3addr));
 
 	ether_addr_copy(Delba->addr1, dst);
 	ether_addr_copy(Delba->addr2, ieee->dev->dev_addr);
 	ether_addr_copy(Delba->addr3, ieee->current_network.bssid);
-	Delba->frame_ctl = cpu_to_le16(RTLLIB_STYPE_MANAGE_ACT);
+	Delba->frame_control = cpu_to_le16(RTLLIB_STYPE_MANAGE_ACT);
 
 	tag = skb_put(skb, 6);
 
@@ -213,7 +213,7 @@ static void rtllib_send_DELBA(struct rtllib_device *ieee, u8 *dst,
 
 int rtllib_rx_ADDBAReq(struct rtllib_device *ieee, struct sk_buff *skb)
 {
-	struct rtllib_hdr_3addr *req = NULL;
+	struct ieee80211_hdr_3addr *req = NULL;
 	u16 rc = 0;
 	u8 *dst = NULL, *pDialogToken = NULL, *tag = NULL;
 	struct ba_record *pBA = NULL;
@@ -222,10 +222,10 @@ int rtllib_rx_ADDBAReq(struct rtllib_device *ieee, struct sk_buff *skb)
 	union sequence_control *pBaStartSeqCtrl = NULL;
 	struct rx_ts_record *ts = NULL;
 
-	if (skb->len < sizeof(struct rtllib_hdr_3addr) + 9) {
+	if (skb->len < sizeof(struct ieee80211_hdr_3addr) + 9) {
 		netdev_warn(ieee->dev, "Invalid skb len in BAREQ(%d / %d)\n",
 			    (int)skb->len,
-			    (int)(sizeof(struct rtllib_hdr_3addr) + 9));
+			    (int)(sizeof(struct ieee80211_hdr_3addr) + 9));
 		return -1;
 	}
 
@@ -234,10 +234,10 @@ int rtllib_rx_ADDBAReq(struct rtllib_device *ieee, struct sk_buff *skb)
 			     skb->data, skb->len);
 #endif
 
-	req = (struct rtllib_hdr_3addr *)skb->data;
+	req = (struct ieee80211_hdr_3addr *)skb->data;
 	tag = (u8 *)req;
 	dst = (u8 *)(&req->addr2[0]);
-	tag += sizeof(struct rtllib_hdr_3addr);
+	tag += sizeof(struct ieee80211_hdr_3addr);
 	pDialogToken = tag + 2;
 	pBaParamSet = (union ba_param_set *)(tag + 3);
 	pBaTimeoutVal = (u16 *)(tag + 5);
@@ -302,7 +302,7 @@ int rtllib_rx_ADDBAReq(struct rtllib_device *ieee, struct sk_buff *skb)
 
 int rtllib_rx_ADDBARsp(struct rtllib_device *ieee, struct sk_buff *skb)
 {
-	struct rtllib_hdr_3addr *rsp = NULL;
+	struct ieee80211_hdr_3addr *rsp = NULL;
 	struct ba_record *pPendingBA, *pAdmittedBA;
 	struct tx_ts_record *pTS = NULL;
 	u8 *dst = NULL, *pDialogToken = NULL, *tag = NULL;
@@ -310,16 +310,16 @@ int rtllib_rx_ADDBARsp(struct rtllib_device *ieee, struct sk_buff *skb)
 	union ba_param_set *pBaParamSet = NULL;
 	u16			ReasonCode;
 
-	if (skb->len < sizeof(struct rtllib_hdr_3addr) + 9) {
+	if (skb->len < sizeof(struct ieee80211_hdr_3addr) + 9) {
 		netdev_warn(ieee->dev, "Invalid skb len in BARSP(%d / %d)\n",
 			    (int)skb->len,
-			    (int)(sizeof(struct rtllib_hdr_3addr) + 9));
+			    (int)(sizeof(struct ieee80211_hdr_3addr) + 9));
 		return -1;
 	}
-	rsp = (struct rtllib_hdr_3addr *)skb->data;
+	rsp = (struct ieee80211_hdr_3addr *)skb->data;
 	tag = (u8 *)rsp;
 	dst = (u8 *)(&rsp->addr2[0]);
-	tag += sizeof(struct rtllib_hdr_3addr);
+	tag += sizeof(struct ieee80211_hdr_3addr);
 	pDialogToken = tag + 2;
 	pStatusCode = (u16 *)(tag + 3);
 	pBaParamSet = (union ba_param_set *)(tag + 5);
@@ -401,14 +401,14 @@ int rtllib_rx_ADDBARsp(struct rtllib_device *ieee, struct sk_buff *skb)
 
 int rtllib_rx_DELBA(struct rtllib_device *ieee, struct sk_buff *skb)
 {
-	struct rtllib_hdr_3addr *delba = NULL;
+	struct ieee80211_hdr_3addr *delba = NULL;
 	union delba_param_set *pDelBaParamSet = NULL;
 	u8 *dst = NULL;
 
-	if (skb->len < sizeof(struct rtllib_hdr_3addr) + 6) {
+	if (skb->len < sizeof(struct ieee80211_hdr_3addr) + 6) {
 		netdev_warn(ieee->dev, "Invalid skb len in DELBA(%d / %d)\n",
 			    (int)skb->len,
-			    (int)(sizeof(struct rtllib_hdr_3addr) + 6));
+			    (int)(sizeof(struct ieee80211_hdr_3addr) + 6));
 		return -1;
 	}
 
@@ -425,9 +425,9 @@ int rtllib_rx_DELBA(struct rtllib_device *ieee, struct sk_buff *skb)
 	print_hex_dump_bytes("%s: ", DUMP_PREFIX_NONE, skb->data,
 			     __func__, skb->len);
 #endif
-	delba = (struct rtllib_hdr_3addr *)skb->data;
+	delba = (struct ieee80211_hdr_3addr *)skb->data;
 	dst = (u8 *)(&delba->addr2[0]);
-	pDelBaParamSet = (union delba_param_set *)&delba->payload[2];
+	pDelBaParamSet = (union delba_param_set *)&delba->seq_ctrl + 2;
 
 	if (pDelBaParamSet->field.initiator == 1) {
 		struct rx_ts_record *ts;
-- 
2.42.0

