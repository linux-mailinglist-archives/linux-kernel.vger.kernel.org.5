Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1C177A234E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 18:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236491AbjIOQKd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 12:10:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236361AbjIOQKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 12:10:13 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52E682729
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 09:09:40 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-31f85854b9eso319369f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 09:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694794179; x=1695398979; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5e6/GrGXg7ud0y+MSoiSWpfkaO91EExpjUMBSQMSvz0=;
        b=AdrUMNroL/o87kxuS+vJaKgEuoCrLs+HkkI23+0iVpzsUElkkUKZ4h3WXjmCeE4Hqk
         dw0vQ/RAxHg5t5SoaLO1EB1eUMFTaEa5gf//AEa5oESegIcRLKv/5UXhVQVpxCVrLRJ6
         Q3rHgB3UILSn9L26rf3dCaPzcnAzY2j8iXSEw8EqYEcRIACaEfqEZaJBE56HuUkVtGzt
         mM5JV/YL3bRgTevTvRAFZ2YCHUEqRY1NdOrDt8LZLDWFDeftzG73+8cp1BmVpwZqf2PW
         MdKk1ULQ9JNC8PaJEmiCiWgLUcyVbHXJQAeeCqMe9ACPn2t9bfPHRBgRs+kxFRtfuZSy
         1l0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694794179; x=1695398979;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5e6/GrGXg7ud0y+MSoiSWpfkaO91EExpjUMBSQMSvz0=;
        b=vkP3nxBKnFOWtgqIO8nKBU6oGglpefxVlLghSj2l4xv7kS5/SmSD063ta7yOgZQEhR
         04kjeghyxNzMVuyew0q1wUW4z5xrMCtrtJSNKPvex0sS8omUCvopVsU6C58NU7LOmaV4
         eb+narlNYQXzM81BOzqQOZVKWM5YA4O0qDSFJJVQksLo8UiHzFoSv8qz2bBKcqEM5Qaz
         i0i9yLn0Mh8YjNXCtHJ2YzXIjzem4JkNSSNWwwPA/GEAoGO76fbJUA5sJm4YSBlFJJPM
         xRATK433xqNztZCtUUd+iIRJ0hDqT6A6cun20LrglH24yHKnO/UpNmo0PfZJ/yaAfskY
         7zmw==
X-Gm-Message-State: AOJu0YwYxSIPw0zcOdVcUU/jvYJYaSqr8/fFMhQQks3Muy2eQ8YfZ1in
        DnqU4e9PV8L712h2ZHrErLY=
X-Google-Smtp-Source: AGHT+IGosulwWa6AdnlOyCPckCB2PqyDEOZq7ChIqVO2W3o1Nm75eiww4pvZArLxt7btmhCy4SIeyA==
X-Received: by 2002:adf:e903:0:b0:31a:ed75:75e8 with SMTP id f3-20020adfe903000000b0031aed7575e8mr1740067wrm.2.1694794177825;
        Fri, 15 Sep 2023 09:09:37 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p579356c7.dip0.t-ipconnect.de. [87.147.86.199])
        by smtp.gmail.com with ESMTPSA id y14-20020a5d4ace000000b003176eab8868sm4862937wrs.82.2023.09.15.09.09.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 09:09:37 -0700 (PDT)
Date:   Fri, 15 Sep 2023 18:09:36 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 13/16] staging: rtl8192e: Replace management subframe types
 with IEEE80211_STYPE_*
Message-ID: <35ff2758b79f8dadb1d864f3f6d948a76179ad36.1694792595.git.philipp.g.hortmann@gmail.com>
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

Replace management subframe types RTLLIB_STYPE_* with IEEE80211_STYPE_*
to avoid proprietary constant names.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl819x_BAProc.c |  4 +--
 drivers/staging/rtl8192e/rtllib.h         | 14 -----------
 drivers/staging/rtl8192e/rtllib_softmac.c | 30 +++++++++++------------
 3 files changed, 17 insertions(+), 31 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_BAProc.c b/drivers/staging/rtl8192e/rtl819x_BAProc.c
index 4cadbf549933..a57673ecf791 100644
--- a/drivers/staging/rtl8192e/rtl819x_BAProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_BAProc.c
@@ -93,7 +93,7 @@ static struct sk_buff *rtllib_ADDBA(struct rtllib_device *ieee, u8 *Dst,
 	ether_addr_copy(BAReq->addr2, ieee->dev->dev_addr);
 
 	ether_addr_copy(BAReq->addr3, ieee->current_network.bssid);
-	BAReq->frame_control = cpu_to_le16(RTLLIB_STYPE_MANAGE_ACT);
+	BAReq->frame_control = cpu_to_le16(IEEE80211_STYPE_ACTION);
 
 	tag = skb_put(skb, 9);
 	*tag++ = ACT_CAT_BA;
@@ -153,7 +153,7 @@ static struct sk_buff *rtllib_DELBA(struct rtllib_device *ieee, u8 *dst,
 	ether_addr_copy(Delba->addr1, dst);
 	ether_addr_copy(Delba->addr2, ieee->dev->dev_addr);
 	ether_addr_copy(Delba->addr3, ieee->current_network.bssid);
-	Delba->frame_control = cpu_to_le16(RTLLIB_STYPE_MANAGE_ACT);
+	Delba->frame_control = cpu_to_le16(IEEE80211_STYPE_ACTION);
 
 	tag = skb_put(skb, 6);
 
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index ef6e2187f847..3cf171a70974 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -350,20 +350,6 @@ enum rt_op_mode {
 #define RTLLIB_FTYPE_CTL		0x0004
 #define RTLLIB_FTYPE_DATA		0x0008
 
-/* management */
-#define RTLLIB_STYPE_ASSOC_REQ	0x0000
-#define RTLLIB_STYPE_ASSOC_RESP		0x0010
-#define RTLLIB_STYPE_REASSOC_REQ	0x0020
-#define RTLLIB_STYPE_REASSOC_RESP	0x0030
-#define RTLLIB_STYPE_PROBE_REQ	0x0040
-#define RTLLIB_STYPE_PROBE_RESP	0x0050
-#define RTLLIB_STYPE_BEACON		0x0080
-#define RTLLIB_STYPE_ATIM		0x0090
-#define RTLLIB_STYPE_DISASSOC	0x00A0
-#define RTLLIB_STYPE_AUTH		0x00B0
-#define RTLLIB_STYPE_DEAUTH		0x00C0
-#define RTLLIB_STYPE_MANAGE_ACT	0x00D0
-
 /* control */
 #define RTLLIB_STYPE_PSPOLL		0x00A0
 #define RTLLIB_STYPE_RTS		0x00B0
diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index e51bdfd847d2..14f402308ecd 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -331,7 +331,7 @@ static inline struct sk_buff *rtllib_probe_req(struct rtllib_device *ieee)
 	skb_reserve(skb, ieee->tx_headroom);
 
 	req = skb_put(skb, sizeof(struct rtllib_probe_request));
-	req->header.frame_control = cpu_to_le16(RTLLIB_STYPE_PROBE_REQ);
+	req->header.frame_control = cpu_to_le16(IEEE80211_STYPE_PROBE_REQ);
 	req->header.duration_id = 0;
 
 	eth_broadcast_addr(req->header.addr1);
@@ -739,7 +739,7 @@ rtllib_authentication_req(struct rtllib_network *beacon,
 
 	auth = skb_put(skb, sizeof(struct rtllib_authentication));
 
-	auth->header.frame_control = cpu_to_le16(RTLLIB_STYPE_AUTH);
+	auth->header.frame_control = cpu_to_le16(IEEE80211_STYPE_AUTH);
 	if (challengelen)
 		auth->header.frame_control |= cpu_to_le16(RTLLIB_FCTL_WEP);
 
@@ -860,7 +860,7 @@ static struct sk_buff *rtllib_probe_resp(struct rtllib_device *ieee,
 	if (encrypt)
 		beacon_buf->capability |= cpu_to_le16(WLAN_CAPABILITY_PRIVACY);
 
-	beacon_buf->header.frame_control = cpu_to_le16(RTLLIB_STYPE_PROBE_RESP);
+	beacon_buf->header.frame_control = cpu_to_le16(IEEE80211_STYPE_PROBE_RESP);
 	beacon_buf->info_element[0].id = MFIE_TYPE_SSID;
 	beacon_buf->info_element[0].len = ssid_len;
 
@@ -1076,7 +1076,7 @@ rtllib_association_req(struct rtllib_network *beacon,
 
 	hdr = skb_put(skb, sizeof(struct rtllib_assoc_request_frame) + 2);
 
-	hdr->header.frame_control = cpu_to_le16(RTLLIB_STYPE_ASSOC_REQ);
+	hdr->header.frame_control = cpu_to_le16(IEEE80211_STYPE_ASSOC_REQ);
 	hdr->header.duration_id = cpu_to_le16(37);
 	ether_addr_copy(hdr->header.addr1, beacon->bssid);
 	ether_addr_copy(hdr->header.addr2, ieee->dev->dev_addr);
@@ -2136,22 +2136,22 @@ inline int rtllib_rx_frame_softmac(struct rtllib_device *ieee,
 
 	frame_ctl = le16_to_cpu(header->frame_control);
 	switch (WLAN_FC_GET_STYPE(frame_ctl)) {
-	case RTLLIB_STYPE_ASSOC_RESP:
-	case RTLLIB_STYPE_REASSOC_RESP:
+	case IEEE80211_STYPE_ASSOC_RESP:
+	case IEEE80211_STYPE_REASSOC_RESP:
 		if (rtllib_rx_assoc_resp(ieee, skb, rx_stats) == 1)
 			return 1;
 		break;
-	case RTLLIB_STYPE_ASSOC_REQ:
-	case RTLLIB_STYPE_REASSOC_REQ:
+	case IEEE80211_STYPE_ASSOC_REQ:
+	case IEEE80211_STYPE_REASSOC_REQ:
 		break;
-	case RTLLIB_STYPE_AUTH:
+	case IEEE80211_STYPE_AUTH:
 		rtllib_rx_auth(ieee, skb, rx_stats);
 		break;
-	case RTLLIB_STYPE_DISASSOC:
-	case RTLLIB_STYPE_DEAUTH:
+	case IEEE80211_STYPE_DISASSOC:
+	case IEEE80211_STYPE_DEAUTH:
 		rtllib_rx_deauth(ieee, skb);
 		break;
-	case RTLLIB_STYPE_MANAGE_ACT:
+	case IEEE80211_STYPE_ACTION:
 		rtllib_process_action(ieee, skb);
 		break;
 	default:
@@ -2488,7 +2488,7 @@ static struct sk_buff *rtllib_get_beacon_(struct rtllib_device *ieee)
 		return NULL;
 
 	b = (struct rtllib_probe_response *)skb->data;
-	b->header.frame_control = cpu_to_le16(RTLLIB_STYPE_BEACON);
+	b->header.frame_control = cpu_to_le16(IEEE80211_STYPE_BEACON);
 
 	return skb;
 }
@@ -2730,7 +2730,7 @@ rtllib_disauth_skb(struct rtllib_network *beacon,
 	skb_reserve(skb, ieee->tx_headroom);
 
 	disauth = skb_put(skb, sizeof(struct rtllib_disauth));
-	disauth->header.frame_control = cpu_to_le16(RTLLIB_STYPE_DEAUTH);
+	disauth->header.frame_control = cpu_to_le16(IEEE80211_STYPE_DEAUTH);
 	disauth->header.duration_id = 0;
 
 	ether_addr_copy(disauth->header.addr1, beacon->bssid);
@@ -2757,7 +2757,7 @@ rtllib_disassociate_skb(struct rtllib_network *beacon,
 	skb_reserve(skb, ieee->tx_headroom);
 
 	disass = skb_put(skb, sizeof(struct rtllib_disassoc));
-	disass->header.frame_control = cpu_to_le16(RTLLIB_STYPE_DISASSOC);
+	disass->header.frame_control = cpu_to_le16(IEEE80211_STYPE_DISASSOC);
 	disass->header.duration_id = 0;
 
 	ether_addr_copy(disass->header.addr1, beacon->bssid);
-- 
2.42.0

