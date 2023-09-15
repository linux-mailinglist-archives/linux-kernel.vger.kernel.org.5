Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 508A17A2345
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 18:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236439AbjIOQHy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 12:07:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236489AbjIOQHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 12:07:32 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2427CC1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 09:07:27 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-4047ef37f55so1659135e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 09:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694794045; x=1695398845; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TvG4f3NcsI8Xfv36MOL6iAucxTOlBE34b3xcrtfbeuU=;
        b=dS9BY1oziitpDt+d4kJZHtRF7TX8pYP1TOAZp+6tjWi+3Vbzi+rHnihokjBVI5G6D+
         lw7QnNT0qmwHW5OmqEENdx9WLeAtXbFUnyoDSRWt8gRetvaVZk9vDOuexKkJcxS3Dk+z
         MXuqZOkX8DRpLu65U22uwdNtwTr4XuEnPdb/hQFVzF8lAI5OXIgpZoDL+UwIsXMSBoxc
         2MsBKPgYJK3XABxyW+nnCux8ycX5pyS0Hu0fAzHi7INeQD1rIcom6KDmQzUYAoeS/idJ
         F33MezWffkN8Qi2VkEPcjS5j+uvZCirjFi3rUq9xmCyMBJ4r4eD2W/6KFoXB99/9Af0R
         ZLBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694794045; x=1695398845;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TvG4f3NcsI8Xfv36MOL6iAucxTOlBE34b3xcrtfbeuU=;
        b=ZOPoM87umzHwt7rupLb8xnIsh76pvJuj03Gv8StUAseum75nzRR4kvDD4RXuTesnle
         QQXBMivSBrRlPKnw8VbK0K6cbiLhf7RpIHKdUiV8lsfmoTwaSDyTeX0W5MRQ2YSBBH/4
         qr5Su/AqXmxmOXazv1QkH/aa1iocpNwnYjURRZu3um8GvimVmiyIh5Ja1fOQMJsOrhwA
         lE8RZFyK4L81q/AsyWoINM19vMPBwgRfyIelr+bbWHfgO1KlrGJktuDhVmLFK1dOjif+
         rR8eXoYVIivMerTVwN2Iw0MLdgXWDsHwIIqkhD3wFKVD0IghnwP3D6WQDha5RLLvNIN0
         uVow==
X-Gm-Message-State: AOJu0YxLUJgzvRCRPkHWkHTSJuoXYBjDsj84pNf+/ItzowTpIeFIXxGk
        l1ml6tL0tVx8DQwr6fx2euM=
X-Google-Smtp-Source: AGHT+IHpBqjfNyt9FrXLR3IvrIElvMmMCFxj5FnVrXW+k+S450qF5huVzeUb8FvQDfR7OIkpvJrTfA==
X-Received: by 2002:a1c:7507:0:b0:401:b0f8:c26a with SMTP id o7-20020a1c7507000000b00401b0f8c26amr1894999wmc.4.1694794045460;
        Fri, 15 Sep 2023 09:07:25 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p579356c7.dip0.t-ipconnect.de. [87.147.86.199])
        by smtp.gmail.com with ESMTPSA id v13-20020a05600c214d00b00401dc20a070sm7871465wml.43.2023.09.15.09.07.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 09:07:25 -0700 (PDT)
Date:   Fri, 15 Sep 2023 18:07:23 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 05/16] staging: rtl8192e: Replace struct rtllib_hdr_3addr in
 r8192E_dev.c
Message-ID: <8e5901c4ecb0961374610f627deb6a6ad9bc53df.1694792595.git.philipp.g.hortmann@gmail.com>
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
proprietary struct in r8192E_dev.c, rtllib_tx.c and in functions of
rtllib.h.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c | 14 +++++++-------
 drivers/staging/rtl8192e/rtllib.h              |  6 +++---
 drivers/staging/rtl8192e/rtllib_tx.c           |  2 +-
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
index 70e1eff9c600..6528807311ba 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
@@ -1411,12 +1411,12 @@ static void _rtl92e_process_phyinfo(struct r8192_priv *priv, u8 *buffer,
 	static u32 slide_beacon_adc_pwdb_index;
 	static u32 slide_beacon_adc_pwdb_statistics;
 	static u32 last_beacon_adc_pwdb;
-	struct rtllib_hdr_3addr *hdr;
+	struct ieee80211_hdr_3addr *hdr;
 	u16 sc;
 	unsigned int seq;
 
-	hdr = (struct rtllib_hdr_3addr *)buffer;
-	sc = le16_to_cpu(hdr->seq_ctl);
+	hdr = (struct ieee80211_hdr_3addr *)buffer;
+	sc = le16_to_cpu(hdr->seq_ctrl);
 	seq = WLAN_GET_SEQ_SEQ(sc);
 	curr_st->Seq_Num = seq;
 	if (!prev_st->bIsAMPDU)
@@ -1561,7 +1561,7 @@ static void _rtl92e_translate_rx_signal_stats(struct net_device *dev,
 	struct r8192_priv *priv = (struct r8192_priv *)rtllib_priv(dev);
 	bool bpacket_match_bssid, bpacket_toself;
 	bool bPacketBeacon = false;
-	struct rtllib_hdr_3addr *hdr;
+	struct ieee80211_hdr_3addr *hdr;
 	bool bToSelfBA = false;
 	static struct rtllib_rx_stats  previous_stats;
 	u16 fc, type;
@@ -1570,8 +1570,8 @@ static void _rtl92e_translate_rx_signal_stats(struct net_device *dev,
 
 	tmp_buf = skb->data + pstats->RxDrvInfoSize + pstats->RxBufShift;
 
-	hdr = (struct rtllib_hdr_3addr *)tmp_buf;
-	fc = le16_to_cpu(hdr->frame_ctl);
+	hdr = (struct ieee80211_hdr_3addr *)tmp_buf;
+	fc = le16_to_cpu(hdr->frame_control);
 	type = WLAN_FC_GET_TYPE(fc);
 	praddr = hdr->addr1;
 
@@ -1584,7 +1584,7 @@ static void _rtl92e_translate_rx_signal_stats(struct net_device *dev,
 		 (!pstats->bHwError) && (!pstats->bCRC) && (!pstats->bICV));
 	bpacket_toself = bpacket_match_bssid &&		/* check this */
 			 ether_addr_equal(praddr, priv->rtllib->dev->dev_addr);
-	if (ieee80211_is_beacon(hdr->frame_ctl))
+	if (ieee80211_is_beacon(hdr->frame_control))
 		bPacketBeacon = true;
 	_rtl92e_process_phyinfo(priv, tmp_buf, &previous_stats, pstats);
 	_rtl92e_query_rxphystatus(priv, pstats, pdesc, pdrvinfo,
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 3ffebe12e279..c13268ad6b56 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -931,11 +931,11 @@ static inline const char *eap_get_type(int type)
 
 static inline u8 Frame_QoSTID(u8 *buf)
 {
-	struct rtllib_hdr_3addr *hdr;
+	struct ieee80211_hdr_3addr *hdr;
 	u16 fc;
 
-	hdr = (struct rtllib_hdr_3addr *)buf;
-	fc = le16_to_cpu(hdr->frame_ctl);
+	hdr = (struct ieee80211_hdr_3addr *)buf;
+	fc = le16_to_cpu(hdr->frame_control);
 	return (u8)((union frameqos *)(buf + (((fc & RTLLIB_FCTL_TODS) &&
 		    (fc & RTLLIB_FCTL_FROMDS)) ? 30 : 24)))->field.tid;
 }
diff --git a/drivers/staging/rtl8192e/rtllib_tx.c b/drivers/staging/rtl8192e/rtllib_tx.c
index 53eaf6330a98..a244a072e551 100644
--- a/drivers/staging/rtl8192e/rtllib_tx.c
+++ b/drivers/staging/rtl8192e/rtllib_tx.c
@@ -853,7 +853,7 @@ static int rtllib_xmit_inter(struct sk_buff *skb, struct net_device *dev)
 				ieee->seq_ctrl[0]++;
 		}
 	} else {
-		if (unlikely(skb->len < sizeof(struct rtllib_hdr_3addr))) {
+		if (unlikely(skb->len < sizeof(struct ieee80211_hdr_3addr))) {
 			netdev_warn(ieee->dev, "skb too small (%d).\n",
 				    skb->len);
 			goto success;
-- 
2.42.0

