Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A4047A2352
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 18:10:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236522AbjIOQKj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 12:10:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236470AbjIOQKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 12:10:22 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 294B7101
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 09:10:01 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-404724ec0dcso4977665e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 09:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694794199; x=1695398999; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=neWwZG9lKgvEuOzYDGCNX4NU4zDEQvDpEll/wDg9ebs=;
        b=ZnBkgAIz4Hv0Y0S64PuuuBWf4KetQ6q+RdydXhrETvXit7oOaUowOavSA36vEXFdGa
         tjK/d0qS6yqx22u1QEJJ0H1ljHmHPQ9CnwsZJx1vL7mRC6dqSPbAy6WA4jLYeWe0qZjy
         tk3dBtOAXwco36jGJh/dOObdjUaaJWl+pD0yeMeSd/dHNfw63jGPN6dWUk9kYw6Pl9Yr
         3xQiEBbTPX6Drz7KJrSR86Yh1sGnGPJDqpBANWzCM7gwY3Ysez+FvWvzFHcdu8lZQ27e
         9Fmy2WZguZCFXaO3VaFHJtEHWWVT2TaduEN06kve233dR/P1yZOJidixnqmm5On2nj1B
         QyMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694794199; x=1695398999;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=neWwZG9lKgvEuOzYDGCNX4NU4zDEQvDpEll/wDg9ebs=;
        b=qJQX9DAOZmrZggKkcNu+3i+rAiMZ0XbkdReTPWRfSvwXZ5Pdjzc9AOyxnfPtRkXwPj
         K/fX+Yr7u+fgDOnGz2KUABENzGfk8vXSGV5jDTGHa04vxWNi+9ZeqoqIV19dXT2+gcCa
         LviFxQmvr2rqRDhWhqiw/bk1Mvi3Xbbl9wxoGr2pg04nURv/fnJMyGXdkOBAr0VQvbTt
         KbKG6xBQi2p8nIwlnzZ/hkEzFIAaLADURjfKGkgt8VIv0NBmmDukZEn36fk8Jotov35j
         vfmIUWfsvooESxfSh12t5ROaUe7B5dNUxAU7jrGLf0LPEHSXYq9K5/vwQCWbq60+fijX
         IEnQ==
X-Gm-Message-State: AOJu0YwbK6lYncjnQQIEQSm5lLL80+jIR9f4PoWYB+1fBziKjaulvDKw
        14hNMemzvjH4bRnj1H3fikY=
X-Google-Smtp-Source: AGHT+IF6QNcLXkG/0zJLOhRXzo1Jy7RkwytE4AHH7Q6Rc8/fXgVXcUoK+wMGs9a3ERG22X45/2wtSg==
X-Received: by 2002:adf:db51:0:b0:319:7624:4ca2 with SMTP id f17-20020adfdb51000000b0031976244ca2mr1733288wrj.0.1694794199381;
        Fri, 15 Sep 2023 09:09:59 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p579356c7.dip0.t-ipconnect.de. [87.147.86.199])
        by smtp.gmail.com with ESMTPSA id i11-20020a0560001acb00b0031fa870d4b3sm4026863wry.60.2023.09.15.09.09.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 09:09:59 -0700 (PDT)
Date:   Fri, 15 Sep 2023 18:09:57 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 16/16] staging: rtl8192e: Replace frame control constants
 with IEEE80211_FCTL_*
Message-ID: <24d195f60ab9aa1d419c81b749c3d64dc8f643e3.1694792595.git.philipp.g.hortmann@gmail.com>
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

Replace frame control fields with IEEE80211_FCTL_* to avoid proprietary
constant names.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 .../staging/rtl8192e/rtl8192e/r8192E_dev.c    |  4 +--
 drivers/staging/rtl8192e/rtllib.h             | 27 ++++----------
 drivers/staging/rtl8192e/rtllib_crypt_tkip.c  |  8 ++---
 drivers/staging/rtl8192e/rtllib_rx.c          | 36 +++++++++----------
 drivers/staging/rtl8192e/rtllib_softmac.c     |  8 ++---
 drivers/staging/rtl8192e/rtllib_tx.c          |  6 ++--
 6 files changed, 38 insertions(+), 51 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
index 6528807311ba..95be6fb043dd 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
@@ -1578,8 +1578,8 @@ static void _rtl92e_translate_rx_signal_stats(struct net_device *dev,
 	bpacket_match_bssid =
 		((type != RTLLIB_FTYPE_CTL) &&
 		 ether_addr_equal(priv->rtllib->current_network.bssid,
-				  (fc & RTLLIB_FCTL_TODS) ? hdr->addr1 :
-				  (fc & RTLLIB_FCTL_FROMDS) ? hdr->addr2 :
+				  (fc & IEEE80211_FCTL_TODS) ? hdr->addr1 :
+				  (fc & IEEE80211_FCTL_FROMDS) ? hdr->addr2 :
 				  hdr->addr3) &&
 		 (!pstats->bHwError) && (!pstats->bCRC) && (!pstats->bICV));
 	bpacket_toself = bpacket_match_bssid &&		/* check this */
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 9179c3c14ab3..5517b9df65be 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -332,19 +332,6 @@ enum rt_op_mode {
 #define MIN_FRAG_THRESHOLD     256U
 #define MAX_FRAG_THRESHOLD     2346U
 
-/* Frame control field constants */
-#define RTLLIB_FCTL_FTYPE		0x000c
-#define RTLLIB_FCTL_STYPE		0x00f0
-#define RTLLIB_FCTL_FRAMETYPE	0x00fc
-#define RTLLIB_FCTL_TODS		0x0100
-#define RTLLIB_FCTL_FROMDS		0x0200
-#define RTLLIB_FCTL_MOREFRAGS	0x0400
-#define RTLLIB_FCTL_RETRY		0x0800
-#define RTLLIB_FCTL_PM		0x1000
-#define RTLLIB_FCTL_MOREDATA		0x2000
-#define RTLLIB_FCTL_WEP		0x4000
-#define RTLLIB_FCTL_ORDER		0x8000
-
 #define RTLLIB_FTYPE_MGMT		0x0000
 #define RTLLIB_FTYPE_CTL		0x0004
 #define RTLLIB_FTYPE_DATA		0x0008
@@ -361,7 +348,7 @@ enum rt_op_mode {
 #define IsQoSDataFrame(pframe)			\
 	((*(u16 *)pframe&(IEEE80211_STYPE_QOS_DATA|RTLLIB_FTYPE_DATA)) ==	\
 	(IEEE80211_STYPE_QOS_DATA|RTLLIB_FTYPE_DATA))
-#define Frame_Order(pframe)     (*(u16 *)pframe&RTLLIB_FCTL_ORDER)
+#define Frame_Order(pframe)     (*(u16 *)pframe&IEEE80211_FCTL_ORDER)
 #define SN_LESS(a, b)		(((a-b)&0x800) != 0)
 #define SN_EQUAL(a, b)	(a == b)
 #define MAX_DEV_ADDR_SIZE 8
@@ -425,9 +412,9 @@ enum _REG_PREAMBLE_MODE {
 
 #define SNAP_SIZE sizeof(struct rtllib_snap_hdr)
 
-#define WLAN_FC_GET_TYPE(fc) ((fc) & RTLLIB_FCTL_FTYPE)
-#define WLAN_FC_GET_STYPE(fc) ((fc) & RTLLIB_FCTL_STYPE)
-#define WLAN_FC_MORE_DATA(fc) ((fc) & RTLLIB_FCTL_MOREDATA)
+#define WLAN_FC_GET_TYPE(fc) ((fc) & IEEE80211_FCTL_FTYPE)
+#define WLAN_FC_GET_STYPE(fc) ((fc) & IEEE80211_FCTL_STYPE)
+#define WLAN_FC_MORE_DATA(fc) ((fc) & IEEE80211_FCTL_MOREDATA)
 
 #define WLAN_GET_SEQ_FRAG(seq) ((seq) & RTLLIB_SCTL_FRAG)
 #define WLAN_GET_SEQ_SEQ(seq)  (((seq) & RTLLIB_SCTL_SEQ) >> 4)
@@ -849,8 +836,8 @@ static inline u8 Frame_QoSTID(u8 *buf)
 
 	hdr = (struct ieee80211_hdr_3addr *)buf;
 	fc = le16_to_cpu(hdr->frame_control);
-	return (u8)((union frameqos *)(buf + (((fc & RTLLIB_FCTL_TODS) &&
-		    (fc & RTLLIB_FCTL_FROMDS)) ? 30 : 24)))->field.tid;
+	return (u8)((union frameqos *)(buf + (((fc & IEEE80211_FCTL_TODS) &&
+		    (fc & IEEE80211_FCTL_FROMDS)) ? 30 : 24)))->field.tid;
 }
 
 struct eapol {
@@ -1624,7 +1611,7 @@ static inline int rtllib_get_hdrlen(u16 fc)
 
 	switch (WLAN_FC_GET_TYPE(fc)) {
 	case RTLLIB_FTYPE_DATA:
-		if ((fc & RTLLIB_FCTL_FROMDS) && (fc & RTLLIB_FCTL_TODS))
+		if ((fc & IEEE80211_FCTL_FROMDS) && (fc & IEEE80211_FCTL_TODS))
 			hdrlen = RTLLIB_4ADDR_LEN; /* Addr4 */
 		if (RTLLIB_QOS_HAS_SEQ(fc))
 			hdrlen += 2; /* QOS ctrl*/
diff --git a/drivers/staging/rtl8192e/rtllib_crypt_tkip.c b/drivers/staging/rtl8192e/rtllib_crypt_tkip.c
index b7f9ea0e4f51..0244b524a7d4 100644
--- a/drivers/staging/rtl8192e/rtllib_crypt_tkip.c
+++ b/drivers/staging/rtl8192e/rtllib_crypt_tkip.c
@@ -469,16 +469,16 @@ static void michael_mic_hdr(struct sk_buff *skb, u8 *hdr)
 
 	hdr11 = (struct ieee80211_hdr *)skb->data;
 	switch (le16_to_cpu(hdr11->frame_control) &
-		(RTLLIB_FCTL_FROMDS | RTLLIB_FCTL_TODS)) {
-	case RTLLIB_FCTL_TODS:
+		(IEEE80211_FCTL_FROMDS | IEEE80211_FCTL_TODS)) {
+	case IEEE80211_FCTL_TODS:
 		ether_addr_copy(hdr, hdr11->addr3); /* DA */
 		ether_addr_copy(hdr + ETH_ALEN, hdr11->addr2); /* SA */
 		break;
-	case RTLLIB_FCTL_FROMDS:
+	case IEEE80211_FCTL_FROMDS:
 		ether_addr_copy(hdr, hdr11->addr1); /* DA */
 		ether_addr_copy(hdr + ETH_ALEN, hdr11->addr3); /* SA */
 		break;
-	case RTLLIB_FCTL_FROMDS | RTLLIB_FCTL_TODS:
+	case IEEE80211_FCTL_FROMDS | IEEE80211_FCTL_TODS:
 		ether_addr_copy(hdr, hdr11->addr3); /* DA */
 		ether_addr_copy(hdr + ETH_ALEN, hdr11->addr4); /* SA */
 		break;
diff --git a/drivers/staging/rtl8192e/rtllib_rx.c b/drivers/staging/rtl8192e/rtllib_rx.c
index ef042dfd89cb..21cde99bb24d 100644
--- a/drivers/staging/rtl8192e/rtllib_rx.c
+++ b/drivers/staging/rtl8192e/rtllib_rx.c
@@ -243,13 +243,13 @@ static int rtllib_is_eapol_frame(struct rtllib_device *ieee,
 	fc = le16_to_cpu(hdr->frame_control);
 
 	/* check that the frame is unicast frame to us */
-	if ((fc & (RTLLIB_FCTL_TODS | RTLLIB_FCTL_FROMDS)) ==
-	    RTLLIB_FCTL_TODS &&
+	if ((fc & (IEEE80211_FCTL_TODS | IEEE80211_FCTL_FROMDS)) ==
+	    IEEE80211_FCTL_TODS &&
 	    memcmp(hdr->addr1, dev->dev_addr, ETH_ALEN) == 0 &&
 	    memcmp(hdr->addr3, dev->dev_addr, ETH_ALEN) == 0) {
 		/* ToDS frame with own addr BSSID and DA */
-	} else if ((fc & (RTLLIB_FCTL_TODS | RTLLIB_FCTL_FROMDS)) ==
-		   RTLLIB_FCTL_FROMDS &&
+	} else if ((fc & (IEEE80211_FCTL_TODS | IEEE80211_FCTL_FROMDS)) ==
+		   IEEE80211_FCTL_FROMDS &&
 		   memcmp(hdr->addr1, dev->dev_addr, ETH_ALEN) == 0) {
 		/* FromDS frame with own addr as DA */
 	} else {
@@ -944,18 +944,18 @@ static void rtllib_rx_extract_addr(struct rtllib_device *ieee,
 {
 	u16 fc = le16_to_cpu(hdr->frame_control);
 
-	switch (fc & (RTLLIB_FCTL_FROMDS | RTLLIB_FCTL_TODS)) {
-	case RTLLIB_FCTL_FROMDS:
+	switch (fc & (IEEE80211_FCTL_FROMDS | IEEE80211_FCTL_TODS)) {
+	case IEEE80211_FCTL_FROMDS:
 		ether_addr_copy(dst, hdr->addr1);
 		ether_addr_copy(src, hdr->addr3);
 		ether_addr_copy(bssid, hdr->addr2);
 		break;
-	case RTLLIB_FCTL_TODS:
+	case IEEE80211_FCTL_TODS:
 		ether_addr_copy(dst, hdr->addr3);
 		ether_addr_copy(src, hdr->addr2);
 		ether_addr_copy(bssid, hdr->addr1);
 		break;
-	case RTLLIB_FCTL_FROMDS | RTLLIB_FCTL_TODS:
+	case IEEE80211_FCTL_FROMDS | IEEE80211_FCTL_TODS:
 		ether_addr_copy(dst, hdr->addr3);
 		ether_addr_copy(src, hdr->addr4);
 		ether_addr_copy(bssid, ieee->current_network.bssid);
@@ -986,7 +986,7 @@ static int rtllib_rx_data_filter(struct rtllib_device *ieee, struct ieee80211_hd
 	/* Filter packets sent by an STA that will be forwarded by AP */
 	if (ieee->intel_promiscuous_md_info.promiscuous_on  &&
 		ieee->intel_promiscuous_md_info.fltr_src_sta_frame) {
-		if ((fc & RTLLIB_FCTL_TODS) && !(fc & RTLLIB_FCTL_FROMDS) &&
+		if ((fc & IEEE80211_FCTL_TODS) && !(fc & IEEE80211_FCTL_FROMDS) &&
 		    !ether_addr_equal(dst, ieee->current_network.bssid) &&
 		    ether_addr_equal(bssid, ieee->current_network.bssid)) {
 			return -1;
@@ -1041,7 +1041,7 @@ static int rtllib_rx_get_crypt(struct rtllib_device *ieee, struct sk_buff *skb,
 		      (*crypt)->ops->decrypt_mpdu == NULL))
 		*crypt = NULL;
 
-	if (!*crypt && (fc & RTLLIB_FCTL_WEP)) {
+	if (!*crypt && (fc & IEEE80211_FCTL_PROTECTED)) {
 		/* This seems to be triggered by some (multicast?)
 		 * frames from other than current BSS, so just drop the
 		 * frames silently instead of filling system log with
@@ -1076,13 +1076,13 @@ static int rtllib_rx_decrypt(struct rtllib_device *ieee, struct sk_buff *skb,
 		ieee->need_sw_enc = 0;
 
 	keyidx = rtllib_rx_frame_decrypt(ieee, skb, crypt);
-	if ((fc & RTLLIB_FCTL_WEP) && (keyidx < 0)) {
+	if ((fc & IEEE80211_FCTL_PROTECTED) && (keyidx < 0)) {
 		netdev_info(ieee->dev, "%s: decrypt frame error\n", __func__);
 		return -1;
 	}
 
 	hdr = (struct ieee80211_hdr *)skb->data;
-	if ((frag != 0 || (fc & RTLLIB_FCTL_MOREFRAGS))) {
+	if ((frag != 0 || (fc & IEEE80211_FCTL_MOREFRAGS))) {
 		int flen;
 		struct sk_buff *frag_skb = rtllib_frag_cache_get(ieee, hdr);
 
@@ -1091,7 +1091,7 @@ static int rtllib_rx_decrypt(struct rtllib_device *ieee, struct sk_buff *skb,
 		if (!frag_skb) {
 			netdev_dbg(ieee->dev,
 				   "Rx cannot get skb from fragment cache (morefrag=%d seq=%u frag=%u)\n",
-				   (fc & RTLLIB_FCTL_MOREFRAGS) != 0,
+				   (fc & IEEE80211_FCTL_MOREFRAGS) != 0,
 				   WLAN_GET_SEQ_SEQ(sc), frag);
 			return -1;
 		}
@@ -1121,7 +1121,7 @@ static int rtllib_rx_decrypt(struct rtllib_device *ieee, struct sk_buff *skb,
 		dev_kfree_skb_any(skb);
 		skb = NULL;
 
-		if (fc & RTLLIB_FCTL_MOREFRAGS) {
+		if (fc & IEEE80211_FCTL_MOREFRAGS) {
 			/* more fragments expected - leave the skb in fragment
 			 * cache for now; it will be delivered to upper layers
 			 * after all fragments have been received
@@ -1140,14 +1140,14 @@ static int rtllib_rx_decrypt(struct rtllib_device *ieee, struct sk_buff *skb,
 	/* skb: hdr + (possible reassembled) full MSDU payload; possibly still
 	 * encrypted/authenticated
 	 */
-	if ((fc & RTLLIB_FCTL_WEP) &&
+	if ((fc & IEEE80211_FCTL_PROTECTED) &&
 		rtllib_rx_frame_decrypt_msdu(ieee, skb, keyidx, crypt)) {
 		netdev_info(ieee->dev, "%s: ==>decrypt msdu error\n", __func__);
 		return -1;
 	}
 
 	hdr = (struct ieee80211_hdr *)skb->data;
-	if (crypt && !(fc & RTLLIB_FCTL_WEP) && !ieee->open_wep) {
+	if (crypt && !(fc & IEEE80211_FCTL_PROTECTED) && !ieee->open_wep) {
 		if (/*ieee->ieee802_1x &&*/
 		    rtllib_is_eapol_frame(ieee, skb, hdrlen)) {
 			/* pass unencrypted EAPOL frames even if encryption is
@@ -1166,7 +1166,7 @@ static int rtllib_rx_decrypt(struct rtllib_device *ieee, struct sk_buff *skb,
 		}
 	}
 
-	if (crypt && !(fc & RTLLIB_FCTL_WEP) &&
+	if (crypt && !(fc & IEEE80211_FCTL_PROTECTED) &&
 	    rtllib_is_eapol_frame(ieee, skb, hdrlen)) {
 		struct eapol *eap = (struct eapol *)(skb->data + 24);
 
@@ -1174,7 +1174,7 @@ static int rtllib_rx_decrypt(struct rtllib_device *ieee, struct sk_buff *skb,
 			   eap_get_type(eap->type));
 	}
 
-	if (crypt && !(fc & RTLLIB_FCTL_WEP) && !ieee->open_wep &&
+	if (crypt && !(fc & IEEE80211_FCTL_PROTECTED) && !ieee->open_wep &&
 	    !rtllib_is_eapol_frame(ieee, skb, hdrlen)) {
 		netdev_dbg(ieee->dev,
 			   "dropped unencrypted RX data frame from %pM (drop_unencrypted=1)\n",
diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index 87626c15d0d6..61afce587812 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -741,7 +741,7 @@ rtllib_authentication_req(struct rtllib_network *beacon,
 
 	auth->header.frame_control = cpu_to_le16(IEEE80211_STYPE_AUTH);
 	if (challengelen)
-		auth->header.frame_control |= cpu_to_le16(RTLLIB_FCTL_WEP);
+		auth->header.frame_control |= cpu_to_le16(IEEE80211_FCTL_PROTECTED);
 
 	auth->header.duration_id = cpu_to_le16(0x013a);
 	ether_addr_copy(auth->header.addr1, beacon->bssid);
@@ -927,8 +927,8 @@ static struct sk_buff *rtllib_null_func(struct rtllib_device *ieee, short pwr)
 	ether_addr_copy(hdr->addr3, ieee->current_network.bssid);
 
 	hdr->frame_control = cpu_to_le16(RTLLIB_FTYPE_DATA |
-		IEEE80211_STYPE_NULLFUNC | RTLLIB_FCTL_TODS |
-		(pwr ? RTLLIB_FCTL_PM : 0));
+		IEEE80211_STYPE_NULLFUNC | IEEE80211_FCTL_TODS |
+		(pwr ? IEEE80211_FCTL_PM : 0));
 
 	return skb;
 }
@@ -951,7 +951,7 @@ static struct sk_buff *rtllib_pspoll_func(struct rtllib_device *ieee)
 
 	hdr->aid = cpu_to_le16(ieee->assoc_id | 0xc000);
 	hdr->frame_control = cpu_to_le16(RTLLIB_FTYPE_CTL | IEEE80211_STYPE_PSPOLL |
-			 RTLLIB_FCTL_PM);
+			 IEEE80211_FCTL_PM);
 
 	return skb;
 }
diff --git a/drivers/staging/rtl8192e/rtllib_tx.c b/drivers/staging/rtl8192e/rtllib_tx.c
index 8b8f4f90ea35..ca13df080242 100644
--- a/drivers/staging/rtl8192e/rtllib_tx.c
+++ b/drivers/staging/rtl8192e/rtllib_tx.c
@@ -655,7 +655,7 @@ static int rtllib_xmit_inter(struct sk_buff *skb, struct net_device *dev)
 		bytes = skb->len + SNAP_SIZE + sizeof(u16);
 
 		if (encrypt)
-			fc = RTLLIB_FTYPE_DATA | RTLLIB_FCTL_WEP;
+			fc = RTLLIB_FTYPE_DATA | IEEE80211_FCTL_PROTECTED;
 		else
 			fc = RTLLIB_FTYPE_DATA;
 
@@ -665,7 +665,7 @@ static int rtllib_xmit_inter(struct sk_buff *skb, struct net_device *dev)
 			fc |= IEEE80211_STYPE_DATA;
 
 		if (ieee->iw_mode == IW_MODE_INFRA) {
-			fc |= RTLLIB_FCTL_TODS;
+			fc |= IEEE80211_FCTL_TODS;
 			/* To DS: Addr1 = BSSID, Addr2 = SA,
 			 * Addr3 = DA
 			 */
@@ -799,7 +799,7 @@ static int rtllib_xmit_inter(struct sk_buff *skb, struct net_device *dev)
 			 */
 			if (i != nr_frags - 1) {
 				frag_hdr->frame_control = cpu_to_le16(fc |
-								  RTLLIB_FCTL_MOREFRAGS);
+								  IEEE80211_FCTL_MOREFRAGS);
 				bytes = bytes_per_frag;
 
 			} else {
-- 
2.42.0

