Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C04E7B71D4
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 21:34:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240982AbjJCTea (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 15:34:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240986AbjJCTe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 15:34:26 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D8B810E
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 12:34:20 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-9b2d64c9307so53346166b.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 12:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696361659; x=1696966459; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UjGjxI6eGVPYNgs9C+/srpj1zkswroX+k2Y9drOlyqk=;
        b=dKVYiu+L+bRmMxF2a+H+rCpLlxxzL5CjiQNQ4+LmTeRBaOOgmGmZihUynJDyf6fjqu
         3808sYCdFuCz+GPutRJ66d/hTOal0uDqRPHPaKNREhTDiDgf9LbDdgSHN2qsVDRRPrSo
         2nMp/kb1a9plWkdGxaG1GAEK6hdfBtW+WkcEHCAtgMnZRZwXqa1WyzYRPhFz54EzwMxa
         WmjjHVdmzsANY1E8oMYYtiWW1fASAN45hnc6y6RmsHjgBlIf8hO4rrhpyP3G4sd+SEsK
         QrNicZUO22eAls083J8CBgQRiWngSThY//p1kPFoPdAiRumvzKJNJ7GGexK5/NQWE7In
         Bu3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696361659; x=1696966459;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UjGjxI6eGVPYNgs9C+/srpj1zkswroX+k2Y9drOlyqk=;
        b=SDBuVQvvcpSrQ4I8iFG/L1ngCHk/Qii8Cb8yM/jUUJ3saMJ1PgmvoU57zzexl1+0O0
         hP90qCH5Cd5EmbGscY9OfTrTlnpR2MPlJ6QGLoySzLYsK/r1KVlGFuja0hne715Iiquy
         DxZWNnSCsqJetNJlpgWoB98crc5WT9k3c6hiab5kjoUBbOU9+dX1P1c/7pwIFawLDSOd
         wF+nMMvrX/oFOUO5hJ31e2mHzbZgOiwlKNcF7ek3e9gGWyc9G13QOiHcvxFNlqXP7OXG
         FXN7iFynFUeJzGmCq1xvMuUjfF2HItGN1kp+L/Cl8XpRRVTvrPBDuvbbCT69NOUO7brC
         S9Vw==
X-Gm-Message-State: AOJu0YxpY4/SSXFoHh5fKFX8S+/1DUTtg8VIGOeJFKXhOi7hTrkLQqEH
        GWPsznYpfgpq82Q5TJcPrm0=
X-Google-Smtp-Source: AGHT+IF5f6V3BxiM+4giXnCOJ083tdoUbEdsneTHhTD5kdVUh7Xh1UVzbHR+pN1wGFW4hfnKvbB6JQ==
X-Received: by 2002:a17:906:7389:b0:9b2:71f2:bd11 with SMTP id f9-20020a170906738900b009b271f2bd11mr98352ejl.4.1696361659029;
        Tue, 03 Oct 2023 12:34:19 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p579356c7.dip0.t-ipconnect.de. [87.147.86.199])
        by smtp.gmail.com with ESMTPSA id v10-20020a1709060b4a00b009ae5e46210asm1528773ejg.99.2023.10.03.12.34.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 12:34:18 -0700 (PDT)
Date:   Tue, 3 Oct 2023 21:34:17 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 11/11] staging: rtl8192e: Remove constant variable bToOtherSTA
Message-ID: <ecfcd8bff80d98a4e9a2797535a274625607c699.1696360404.git.philipp.g.hortmann@gmail.com>
References: <cover.1696360403.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1696360403.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove variable bToOtherSTA as it is set to 0 and unchanged. The equations
result accordingly. Remove dead code.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtllib_rx.c | 32 +++++++++++-----------------
 1 file changed, 12 insertions(+), 20 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_rx.c b/drivers/staging/rtl8192e/rtllib_rx.c
index 9a5fdf16f6a1..124c1651856b 100644
--- a/drivers/staging/rtl8192e/rtllib_rx.c
+++ b/drivers/staging/rtl8192e/rtllib_rx.c
@@ -1244,7 +1244,6 @@ static int rtllib_rx_InfraAdhoc(struct rtllib_device *ieee, struct sk_buff *skb,
 	u8 bssid[ETH_ALEN] = {0};
 
 	size_t hdrlen = 0;
-	bool bToOtherSTA = false;
 	int ret = 0, i = 0;
 
 	fc = le16_to_cpu(hdr->frame_control);
@@ -1278,8 +1277,6 @@ static int rtllib_rx_InfraAdhoc(struct rtllib_device *ieee, struct sk_buff *skb,
 
 	/* Filter MGNT Frame */
 	if (type == RTLLIB_FTYPE_MGMT) {
-		if (bToOtherSTA)
-			goto rx_dropped;
 		if (rtllib_rx_frame_mgmt(ieee, skb, rx_stats, type, stype))
 			goto rx_dropped;
 		else
@@ -1289,10 +1286,8 @@ static int rtllib_rx_InfraAdhoc(struct rtllib_device *ieee, struct sk_buff *skb,
 	/* Filter WAPI DATA Frame */
 
 	/* Update statstics for AP roaming */
-	if (!bToOtherSTA) {
-		ieee->link_detect_info.NumRecvDataInPeriod++;
-		ieee->link_detect_info.NumRxOkInPeriod++;
-	}
+	ieee->link_detect_info.NumRecvDataInPeriod++;
+	ieee->link_detect_info.NumRxOkInPeriod++;
 
 	/* Data frame - extract src/dst addresses */
 	rtllib_rx_extract_addr(ieee, hdr, dst, src, bssid);
@@ -1308,7 +1303,7 @@ static int rtllib_rx_InfraAdhoc(struct rtllib_device *ieee, struct sk_buff *skb,
 	/* Send pspoll based on moredata */
 	if ((ieee->iw_mode == IW_MODE_INFRA)  &&
 	    (ieee->sta_sleep == LPS_IS_SLEEP) &&
-	    (ieee->polling) && (!bToOtherSTA)) {
+	    (ieee->polling)) {
 		if (WLAN_FC_MORE_DATA(fc)) {
 			/* more data bit is set, let's request a new frame
 			 * from the AP
@@ -1334,8 +1329,7 @@ static int rtllib_rx_InfraAdhoc(struct rtllib_device *ieee, struct sk_buff *skb,
 	/* Get TS for Rx Reorder  */
 	hdr = (struct ieee80211_hdr *)skb->data;
 	if (ieee->current_network.qos_data.active && IsQoSDataFrame(skb->data)
-		&& !is_multicast_ether_addr(hdr->addr1)
-		&& (!bToOtherSTA)) {
+		&& !is_multicast_ether_addr(hdr->addr1)) {
 		TID = Frame_QoSTID(skb->data);
 		SeqNum = WLAN_GET_SEQ_SEQ(sc);
 		rtllib_get_ts(ieee, (struct ts_common_info **)&ts, hdr->addr2, TID,
@@ -1366,18 +1360,16 @@ static int rtllib_rx_InfraAdhoc(struct rtllib_device *ieee, struct sk_buff *skb,
 	/* Update WAPI PN */
 
 	/* Check if leave LPS */
-	if (!bToOtherSTA) {
-		if (ieee->bIsAggregateFrame)
-			nr_subframes = rxb->nr_subframes;
-		else
-			nr_subframes = 1;
-		if (unicast)
-			ieee->link_detect_info.NumRxUnicastOkInPeriod += nr_subframes;
-		rtllib_rx_check_leave_lps(ieee, unicast, nr_subframes);
-	}
+	if (ieee->bIsAggregateFrame)
+		nr_subframes = rxb->nr_subframes;
+	else
+		nr_subframes = 1;
+	if (unicast)
+		ieee->link_detect_info.NumRxUnicastOkInPeriod += nr_subframes;
+	rtllib_rx_check_leave_lps(ieee, unicast, nr_subframes);
 
 	/* Indicate packets to upper layer or Rx Reorder */
-	if (!ieee->ht_info->cur_rx_reorder_enable || ts == NULL || bToOtherSTA)
+	if (!ieee->ht_info->cur_rx_reorder_enable || ts == NULL)
 		rtllib_rx_indicate_pkt_legacy(ieee, rx_stats, rxb, dst, src);
 	else
 		RxReorderIndicatePacket(ieee, rxb, ts, SeqNum);
-- 
2.42.0

