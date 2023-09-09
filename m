Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15591799A60
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 20:19:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238752AbjIISTz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 14:19:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238467AbjIISTy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 14:19:54 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 703D9CED
        for <linux-kernel@vger.kernel.org>; Sat,  9 Sep 2023 11:19:44 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-401ef656465so9072965e9.1
        for <linux-kernel@vger.kernel.org>; Sat, 09 Sep 2023 11:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694283583; x=1694888383; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IOE6XlBntSncTLlCWMl5brTZ/7LxZLVyWM/OgQDv3Gg=;
        b=eLU2HNIvA9JAyRBFDgbP4kb12qOJF6dg+Qh9sCnqUNDa86uxpnap+khL8CkePAvAJA
         FZj7n92v0Q98NVCT92h3eQTP+Oy5YUIELZLRes/Bkvh09Htc5NSLhA4IE2Mn501bYWMh
         4xn9Q28FZwz+PKTWs+kpMZ0nS5/mpnqAqn/fuaa+Ajo1PpG5ucMPI0ayJ7hQgzqHWp1s
         kTxD0LWiAuPxJ2vJVWqkDwcmc2MyOwXAVP+ZOVSY/S7Jt2HtJwISEf9cp9e2/MGiyAl1
         n3AJBhkuOQiP8Y+15SXLhXba9hvIr/DqN0S/tKiUp92fE/g2gc0pxFM4Z8yt1uWd+aC2
         LniA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694283583; x=1694888383;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IOE6XlBntSncTLlCWMl5brTZ/7LxZLVyWM/OgQDv3Gg=;
        b=Z/uljwDEIKqQhIXmIH6S6nn3+9c2fdQJU/kV21PZkeIKMdElQcn2EwuElfDV9JwfTt
         vjqXGJ79RatU+QUVJu98IXoUbGMjbbtuEogbCRNzSn4bmxnx1j+L9iDco1srAWgi7RKO
         iPNYoO28+b9zurxEmP1KMG+CnhsrhyKKzhd12PmykqGESLh1aVmTMqOaDc7YwrBo0emj
         HmMUnLUGJCArRe3MHRCkgzKYsw+9L8TUfFa8jZdm+oCAjPrk0ysk85vDvBTO07aFZi7O
         XaZPPmDqm4a83DFcs/eo5aeIUBYHHDOhgRFnS1Rz/6ZwzCv1EXolRw35mz0gHF7janVF
         fVSA==
X-Gm-Message-State: AOJu0YxPTnXoXXs4A7suMVHpIJiMI25wbQINtkutwZVNgxvz87bp9xmT
        +dyq2gVu9Yx8qkl4nPOVGZ8=
X-Google-Smtp-Source: AGHT+IFTaKn85G8pHUiSw+ZLVsc2X6tVt+VxCw1j0vbNFp+QI4MF4bXya63MafT83wdsJ3tc09V5yQ==
X-Received: by 2002:a05:600c:3b03:b0:401:7d3b:cc84 with SMTP id m3-20020a05600c3b0300b004017d3bcc84mr5186831wms.0.1694283582616;
        Sat, 09 Sep 2023 11:19:42 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p579356c7.dip0.t-ipconnect.de. [87.147.86.199])
        by smtp.gmail.com with ESMTPSA id n13-20020a5d484d000000b0031f3b04e7cdsm5372378wrs.109.2023.09.09.11.19.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Sep 2023 11:19:42 -0700 (PDT)
Date:   Sat, 9 Sep 2023 20:19:40 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 3/8] staging: rtl8192e: Use standard function in
 rtllib_process_probe_response()
Message-ID: <f06e976555d2f045effabb3ccfea1a2cf133088d.1694282907.git.philipp.g.hortmann@gmail.com>
References: <cover.1694282907.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1694282907.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace proprietary is_beacon() with ieee80211_is_beacon() and
proprietary "WLAN_FC_GET_STYPE(frame_ctl) == RTLLIB_STYPE_PROBE_RESP"
with standard function to increase readability.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtllib_rx.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_rx.c b/drivers/staging/rtl8192e/rtllib_rx.c
index 108238aa61d9..89c8d66765fe 100644
--- a/drivers/staging/rtl8192e/rtllib_rx.c
+++ b/drivers/staging/rtl8192e/rtllib_rx.c
@@ -2448,11 +2448,6 @@ static inline void update_network(struct rtllib_device *ieee,
 	dst->BssCcxVerNumber = src->BssCcxVerNumber;
 }
 
-static inline int is_beacon(u16 fc)
-{
-	return (WLAN_FC_GET_STYPE(fc) == RTLLIB_STYPE_BEACON);
-}
-
 static int IsPassiveChannel(struct rtllib_device *rtllib, u8 channel)
 {
 	if (channel > MAX_CHANNEL_NUMBER) {
@@ -2491,7 +2486,7 @@ static inline void rtllib_process_probe_response(
 	short renew;
 	struct rtllib_network *network = kzalloc(sizeof(struct rtllib_network),
 						 GFP_ATOMIC);
-	u16 frame_ctl = le16_to_cpu(beacon->header.frame_ctl);
+	__le16 frame_ctl = beacon->header.frame_ctl;
 
 	if (!network)
 		return;
@@ -2521,14 +2516,14 @@ static inline void rtllib_process_probe_response(
 		netdev_dbg(ieee->dev, "Dropped '%s' ( %pM) via %s.\n",
 			   escape_essid(info_element->data, info_element->len),
 			   beacon->header.addr3,
-			   is_beacon(frame_ctl) ? "BEACON" : "PROBE RESPONSE");
+			   ieee80211_is_beacon(frame_ctl) ? "BEACON" : "PROBE RESPONSE");
 		goto free_network;
 	}
 
 	if (!rtllib_legal_channel(ieee, network->channel))
 		goto free_network;
 
-	if (WLAN_FC_GET_STYPE(frame_ctl) == RTLLIB_STYPE_PROBE_RESP) {
+	if (ieee80211_is_probe_resp(frame_ctl)) {
 		if (IsPassiveChannel(ieee, network->channel)) {
 			netdev_info(ieee->dev,
 				    "GetScanInfo(): For Global Domain, filter probe response at channel(%d).\n",
@@ -2561,7 +2556,7 @@ static inline void rtllib_process_probe_response(
 			else
 				ieee->current_network.buseprotection = false;
 		}
-		if (is_beacon(frame_ctl)) {
+		if (ieee80211_is_beacon(frame_ctl)) {
 			if (ieee->link_state >= MAC80211_LINKED)
 				ieee->link_detect_info.NumRecvBcnInPeriod++;
 		}
@@ -2597,7 +2592,7 @@ static inline void rtllib_process_probe_response(
 		netdev_dbg(ieee->dev, "Adding '%s' ( %pM) via %s.\n",
 			   escape_essid(network->ssid, network->ssid_len),
 			   network->bssid,
-			   is_beacon(frame_ctl) ? "BEACON" : "PROBE RESPONSE");
+			   ieee80211_is_beacon(frame_ctl) ? "BEACON" : "PROBE RESPONSE");
 
 		memcpy(target, network, sizeof(*target));
 		list_add_tail(&target->list, &ieee->network_list);
@@ -2607,7 +2602,7 @@ static inline void rtllib_process_probe_response(
 		netdev_dbg(ieee->dev, "Updating '%s' ( %pM) via %s.\n",
 			   escape_essid(target->ssid, target->ssid_len),
 			   target->bssid,
-			   is_beacon(frame_ctl) ? "BEACON" : "PROBE RESPONSE");
+			   ieee80211_is_beacon(frame_ctl) ? "BEACON" : "PROBE RESPONSE");
 
 		/* we have an entry and we are going to update it. But this
 		 *  entry may be already expired. In this case we do the same
@@ -2628,7 +2623,7 @@ static inline void rtllib_process_probe_response(
 	}
 
 	spin_unlock_irqrestore(&ieee->lock, flags);
-	if (is_beacon(frame_ctl) &&
+	if (ieee80211_is_beacon(frame_ctl) &&
 	    is_same_network(&ieee->current_network, network,
 	    (network->ssid_len ? 1 : 0)) &&
 	    (ieee->link_state == MAC80211_LINKED)) {
-- 
2.41.0

