Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E210A77A521
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 08:36:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbjHMGgi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 02:36:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbjHMGgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 02:36:36 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36C30171B
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 23:36:36 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-3174ca258bbso791616f8f.1
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 23:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691908595; x=1692513395;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MEucnOEc//2p9zCFWAC3bUVO8s5v2C6AE63j8gZoug8=;
        b=LBgaooLHmTol65H2wN0N/TIyDsVQl/HS6t9QTIaNXrxnzC8vimbWlyGxZxc9XfmEJG
         4+VsQ+l9mhr6xJ6VULr64AJ/7wGzfr3U4P17+yCCQPKkD4mCo6TwQEDk/ZqqcaFz2HvH
         eKfznCg752BzohwTluy+eyfYUtJH1f5IOLtYU0PTbrj+oksqEnxxma2h0JR880oOlq4d
         f8xw3i2llylcDKCGgpAuUjiLSZXfjWSxQ3TXfNHXfK/Yvp12a7BBmAIpRt2p3Bb8GiaC
         rK/S9uGsAxD+XvrDal2rHugcktGDMdhEgUiQCC0oPgqLAS/k+N5pxywkRc/lc5P07tTD
         KT8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691908595; x=1692513395;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MEucnOEc//2p9zCFWAC3bUVO8s5v2C6AE63j8gZoug8=;
        b=lEaGwVifVSl6GKf8lyOW/Wa0h+zg27A8yKaF6nkVUv6bn1aplAHj8O7xD9O9rUGi2n
         YKCyjTMQT008hURbPVZ66e1q8ZKZiWp9Bvb/2X8YwGewStMCXqkr8laAmPM2wjASKR6L
         ohDUEdb8WeUCFsjPfa4ta9uo4ABgXbtU87u72JLBsrR8U1gLmzjyGK0eLSEuduMcZkgl
         xcQEK3VFvYZJaFkZwi7LU3iKG28uc0wiaNVyKZ8wnW0Fc2FyC9+NCQtOY2t4q5ZA0ja5
         AmFg0eFncIkuBAEcJQw2Pzxw+kkgk089h8qwenix9kGRxTpltQKshYcTEEf9XGi5V0oN
         BVlA==
X-Gm-Message-State: AOJu0YwxsHCcuXho5/rZdHF/BYbRhssw9s5RRsOwJdaEt6IRKujKm66u
        nhxchOyI0iRRCNIEJx93in54osAmf2E=
X-Google-Smtp-Source: AGHT+IG6l3/sviJacSMDxUc4tZaBZceLkQDyBNoczIKXVS6CMvz6jHbRdVrcmxBL04uV/9ijk1I1+w==
X-Received: by 2002:a05:600c:1c22:b0:3fa:97b1:b12d with SMTP id j34-20020a05600c1c2200b003fa97b1b12dmr6133540wms.2.1691908595068;
        Sat, 12 Aug 2023 23:36:35 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p579356c7.dip0.t-ipconnect.de. [87.147.86.199])
        by smtp.gmail.com with ESMTPSA id k1-20020a05600c0b4100b003fbb5506e54sm10356755wmr.29.2023.08.12.23.36.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Aug 2023 23:36:34 -0700 (PDT)
Date:   Sun, 13 Aug 2023 08:36:32 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] staging: rtl8192e: Remove unused function
 rtllib_start_master_bss()
Message-ID: <ac2012d94fe4ff705cc900bb1cf2d58bc81c77f0.1691908402.git.philipp.g.hortmann@gmail.com>
References: <cover.1691908402.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1691908402.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused functions rtllib_start_master_bss(), rtllib_rx_assoc_rq()
and rtllib_rx_auth_rq() and resulting unused functions.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtllib_softmac.c | 180 ----------------------
 1 file changed, 180 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index 6fa1d6a9da28..de1702491191 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -909,85 +909,6 @@ static struct sk_buff *rtllib_probe_resp(struct rtllib_device *ieee,
 	return skb;
 }
 
-static struct sk_buff *rtllib_assoc_resp(struct rtllib_device *ieee, u8 *dest)
-{
-	struct sk_buff *skb;
-	u8 *tag;
-
-	struct lib80211_crypt_data *crypt;
-	struct rtllib_assoc_response_frame *assoc;
-	short encrypt;
-
-	unsigned int rate_len = rtllib_MFIE_rate_len(ieee);
-	int len = sizeof(struct rtllib_assoc_response_frame) + rate_len +
-		  ieee->tx_headroom;
-
-	skb = dev_alloc_skb(len);
-
-	if (!skb)
-		return NULL;
-
-	skb_reserve(skb, ieee->tx_headroom);
-
-	assoc = skb_put(skb, sizeof(struct rtllib_assoc_response_frame));
-
-	assoc->header.frame_ctl = cpu_to_le16(RTLLIB_STYPE_ASSOC_RESP);
-	ether_addr_copy(assoc->header.addr1, dest);
-	ether_addr_copy(assoc->header.addr3, ieee->dev->dev_addr);
-	ether_addr_copy(assoc->header.addr2, ieee->dev->dev_addr);
-	assoc->capability = cpu_to_le16(WLAN_CAPABILITY_IBSS);
-
-	assoc->capability |= cpu_to_le16(WLAN_CAPABILITY_SHORT_SLOT_TIME);
-
-	crypt = ieee->crypt_info.crypt[ieee->crypt_info.tx_keyidx];
-
-	encrypt = (crypt && crypt->ops);
-
-	if (encrypt)
-		assoc->capability |= cpu_to_le16(WLAN_CAPABILITY_PRIVACY);
-
-	assoc->status = 0;
-	assoc->aid = cpu_to_le16(ieee->assoc_id);
-	if (ieee->assoc_id == 0x2007)
-		ieee->assoc_id = 0;
-	else
-		ieee->assoc_id++;
-
-	tag = skb_put(skb, rate_len);
-	rtllib_MFIE_Brate(ieee, &tag);
-	rtllib_MFIE_Grate(ieee, &tag);
-
-	return skb;
-}
-
-static struct sk_buff *rtllib_auth_resp(struct rtllib_device *ieee, int status,
-				 u8 *dest)
-{
-	struct sk_buff *skb = NULL;
-	struct rtllib_authentication *auth;
-	int len = ieee->tx_headroom + sizeof(struct rtllib_authentication) + 1;
-
-	skb = dev_alloc_skb(len);
-	if (!skb)
-		return NULL;
-
-	skb->len = sizeof(struct rtllib_authentication);
-
-	skb_reserve(skb, ieee->tx_headroom);
-
-	auth = skb_put(skb, sizeof(struct rtllib_authentication));
-
-	auth->status = cpu_to_le16(status);
-	auth->transaction = cpu_to_le16(2);
-	auth->algorithm = cpu_to_le16(WLAN_AUTH_OPEN);
-
-	ether_addr_copy(auth->header.addr3, ieee->dev->dev_addr);
-	ether_addr_copy(auth->header.addr2, ieee->dev->dev_addr);
-	ether_addr_copy(auth->header.addr1, dest);
-	auth->header.frame_ctl = cpu_to_le16(RTLLIB_STYPE_AUTH);
-	return skb;
-}
-
 static struct sk_buff *rtllib_null_func(struct rtllib_device *ieee, short pwr)
 {
 	struct sk_buff *skb;
@@ -1035,22 +956,6 @@ static struct sk_buff *rtllib_pspoll_func(struct rtllib_device *ieee)
 	return skb;
 }
 
-static void rtllib_resp_to_assoc_rq(struct rtllib_device *ieee, u8 *dest)
-{
-	struct sk_buff *buf = rtllib_assoc_resp(ieee, dest);
-
-	if (buf)
-		softmac_mgmt_xmit(buf, ieee);
-}
-
-static void rtllib_resp_to_auth(struct rtllib_device *ieee, int s, u8 *dest)
-{
-	struct sk_buff *buf = rtllib_auth_resp(ieee, s, dest);
-
-	if (buf)
-		softmac_mgmt_xmit(buf, ieee);
-}
-
 static void rtllib_resp_to_probe(struct rtllib_device *ieee, u8 *dest)
 {
 	struct sk_buff *buf = rtllib_probe_resp(ieee, dest);
@@ -1708,25 +1613,6 @@ static inline int auth_parse(struct net_device *dev, struct sk_buff *skb,
 	return 0;
 }
 
-static int auth_rq_parse(struct net_device *dev, struct sk_buff *skb, u8 *dest)
-{
-	struct rtllib_authentication *a;
-
-	if (skb->len <  (sizeof(struct rtllib_authentication) -
-	    sizeof(struct rtllib_info_element))) {
-		netdev_dbg(dev, "invalid len in auth request: %d\n", skb->len);
-		return -1;
-	}
-	a = (struct rtllib_authentication *)skb->data;
-
-	ether_addr_copy(dest, a->header.addr2);
-
-	if (le16_to_cpu(a->algorithm) != WLAN_AUTH_OPEN)
-		return  WLAN_STATUS_NOT_SUPPORTED_AUTH_ALG;
-
-	return WLAN_STATUS_SUCCESS;
-}
-
 static short probe_rq_parse(struct rtllib_device *ieee, struct sk_buff *skb,
 			    u8 *src)
 {
@@ -1773,23 +1659,6 @@ static short probe_rq_parse(struct rtllib_device *ieee, struct sk_buff *skb,
 	return !strncmp(ssid, ieee->current_network.ssid, ssidlen);
 }
 
-static int assoc_rq_parse(struct net_device *dev, struct sk_buff *skb, u8 *dest)
-{
-	struct rtllib_assoc_request_frame *a;
-
-	if (skb->len < (sizeof(struct rtllib_assoc_request_frame) -
-		sizeof(struct rtllib_info_element))) {
-		netdev_dbg(dev, "invalid len in auth request:%d\n", skb->len);
-		return -1;
-	}
-
-	a = (struct rtllib_assoc_request_frame *)skb->data;
-
-	ether_addr_copy(dest, a->header.addr2);
-
-	return 0;
-}
-
 static inline u16 assoc_parse(struct rtllib_device *ieee, struct sk_buff *skb,
 			      int *aid)
 {
@@ -1830,31 +1699,6 @@ void rtllib_rx_probe_rq(struct rtllib_device *ieee, struct sk_buff *skb)
 	}
 }
 
-static inline void rtllib_rx_auth_rq(struct rtllib_device *ieee,
-				     struct sk_buff *skb)
-{
-	u8 dest[ETH_ALEN];
-	int status;
-
-	ieee->softmac_stats.rx_auth_rq++;
-
-	status = auth_rq_parse(ieee->dev, skb, dest);
-	if (status != -1)
-		rtllib_resp_to_auth(ieee, status, dest);
-}
-
-static inline void rtllib_rx_assoc_rq(struct rtllib_device *ieee,
-				      struct sk_buff *skb)
-{
-	u8 dest[ETH_ALEN];
-
-	ieee->softmac_stats.rx_ass_rq++;
-	if (assoc_rq_parse(ieee->dev, skb, dest) != -1)
-		rtllib_resp_to_assoc_rq(ieee, dest);
-
-	netdev_info(ieee->dev, "New client associated: %pM\n", dest);
-}
-
 void rtllib_sta_ps_send_null_frame(struct rtllib_device *ieee, short pwr)
 {
 	struct sk_buff *buf = rtllib_null_func(ieee, pwr);
@@ -2419,30 +2263,6 @@ void rtllib_wake_all_queues(struct rtllib_device *ieee)
 	netif_tx_wake_all_queues(ieee->dev);
 }
 
-/* called in user context only */
-static void rtllib_start_master_bss(struct rtllib_device *ieee)
-{
-	ieee->assoc_id = 1;
-
-	if (ieee->current_network.ssid_len == 0) {
-		strncpy(ieee->current_network.ssid,
-			RTLLIB_DEFAULT_TX_ESSID,
-			IW_ESSID_MAX_SIZE);
-
-		ieee->current_network.ssid_len =
-				 strlen(RTLLIB_DEFAULT_TX_ESSID);
-		ieee->ssid_set = 1;
-	}
-
-	ether_addr_copy(ieee->current_network.bssid, ieee->dev->dev_addr);
-
-	ieee->set_chan(ieee->dev, ieee->current_network.channel);
-	ieee->link_state = MAC80211_LINKED;
-	ieee->link_change(ieee->dev);
-	notify_wx_assoc_event(ieee);
-	netif_carrier_on(ieee->dev);
-}
-
 static void rtllib_start_monitor_mode(struct rtllib_device *ieee)
 {
 	/* reset hardware status */
-- 
2.41.0

