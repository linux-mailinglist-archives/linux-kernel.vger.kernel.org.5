Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E7B97A2341
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 18:07:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236379AbjIOQHQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 12:07:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236490AbjIOQHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 12:07:04 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19D44E78
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 09:06:50 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-4046f7d49a9so5746625e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 09:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694794008; x=1695398808; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KeiJqYC5IhS4kOqWx8D/S1NwhxMKF1MRIBn49UWSENs=;
        b=Ow8EgHrMPv9HQX8WQn2NH6tZfe4382nr8t86ZgzEhTGcU00I2l6RHpjRl8YkWjnP/p
         lJDccW+hUsWUxrNDvOkzcxmqFj6PhPotiqL6nVn9tEFn4X8TR+CAPnoaGAqZPrpgkBBr
         r1dbhexIgLCe5xX9H7wAkmxniJ3fPTaUwEc/OtigqsG6naOskI5D0kjr2EsoyO+qvCXn
         8JGX4xIw75DbC0X0Gzk4+oJhEa3qx6Pmbs+S/BiUsVQ+CfDEGGlt/xfpyjNHM2XQba0o
         WVkJUvmLcF4t+sI5Y+IyGlIXxIpWtwjRokx7qMiipFUPe6XLQINenPs/Vhs8l/fR2ZjV
         sKjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694794008; x=1695398808;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KeiJqYC5IhS4kOqWx8D/S1NwhxMKF1MRIBn49UWSENs=;
        b=F9g5Lxs0ZMPAd7VebFHg2cv7WAjWFn36VTJI4eNJY4EuY32ssQmDaXEhv4Yoe4Cl43
         WFyymWpl6c9MT7I2OcTJx9Lgp4srNlK+vet+Kh3we3cBsnPqZQJsbdXiVxAlvwQR898V
         Jk8KLwTgnfMmhr9oUzCfA2AH/k6d5VaVxvldvVVRO65J7l3yNIeEmiut8+95F9W9/Nun
         PKYcNfl86CBcm+q6zlKhxIsuBg815lahr4mvbgz0s5wl/klM//pFZ4s+2YXu9R6z6GDE
         HbndZ6H2wU6w1St3RAHS3diYZPt+h0Tb4JvIHQHCtwhj4m52RokmyjekMLqp2VkT0SOk
         i13A==
X-Gm-Message-State: AOJu0YzF9lAwjZiLQ8yN7pARhBlhkuLag4l4VY1jJJpmLA+sgGTg3iKt
        ZcRJ0TT+BIKz9y1DXtkPjumqU68lKbCQUg==
X-Google-Smtp-Source: AGHT+IHTkLjJA0Hddi7cEh1JlaSoUWaWFrrEJpCAOiwf00DdKBYlZLOdO3XdNW7DXvngom2bHtHn8g==
X-Received: by 2002:adf:ec4f:0:b0:31f:edc3:c5fb with SMTP id w15-20020adfec4f000000b0031fedc3c5fbmr1799445wrn.5.1694794008233;
        Fri, 15 Sep 2023 09:06:48 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p579356c7.dip0.t-ipconnect.de. [87.147.86.199])
        by smtp.gmail.com with ESMTPSA id ba13-20020a0560001c0d00b0031ddf6cc89csm2056332wrb.98.2023.09.15.09.06.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 09:06:47 -0700 (PDT)
Date:   Fri, 15 Sep 2023 18:06:46 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 01/16] staging: rtl8192e: Replace struct rtllib_hdr_1addr
 with ieee80211_hdr
Message-ID: <84aa25fec8e29199970df37b1671f0252d12374e.1694792595.git.philipp.g.hortmann@gmail.com>
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

Replace struct rtllib_hdr_1addr with struct ieee80211_hdr to avoid
proprietary struct.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c | 8 ++++----
 drivers/staging/rtl8192e/rtllib.h            | 7 -------
 drivers/staging/rtl8192e/rtllib_tx.c         | 2 +-
 3 files changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index 63bf8be3fda5..cbb082d8b89f 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -1470,7 +1470,7 @@ static short _rtl92e_tx(struct net_device *dev, struct sk_buff *skb)
 	struct cb_desc *tcb_desc = (struct cb_desc *)(skb->cb +
 				    MAX_DEV_ADDR_SIZE);
 	struct tx_desc *pdesc = NULL;
-	struct rtllib_hdr_1addr *header = NULL;
+	struct ieee80211_hdr *header = NULL;
 	u8 *pda_addr = NULL;
 	int   idx;
 	u32 fwinfo_size = 0;
@@ -1479,7 +1479,7 @@ static short _rtl92e_tx(struct net_device *dev, struct sk_buff *skb)
 
 	fwinfo_size = sizeof(struct tx_fwinfo_8190pci);
 
-	header = (struct rtllib_hdr_1addr *)(((u8 *)skb->data) + fwinfo_size);
+	header = (struct ieee80211_hdr *)(((u8 *)skb->data) + fwinfo_size);
 	pda_addr = header->addr1;
 
 	if (!is_broadcast_ether_addr(pda_addr) && !is_multicast_ether_addr(pda_addr))
@@ -1725,7 +1725,7 @@ void rtl92e_copy_mpdu_stats(struct rtllib_rx_stats *psrc_stats,
 static void _rtl92e_rx_normal(struct net_device *dev)
 {
 	struct r8192_priv *priv = rtllib_priv(dev);
-	struct rtllib_hdr_1addr *rtllib_hdr = NULL;
+	struct ieee80211_hdr *rtllib_hdr = NULL;
 	bool unicast_packet = false;
 	u32 skb_len = 0;
 	int rx_queue_idx = RX_MPDU_QUEUE;
@@ -1764,7 +1764,7 @@ static void _rtl92e_rx_normal(struct net_device *dev)
 		skb_reserve(skb, stats.RxDrvInfoSize +
 			stats.RxBufShift);
 		skb_trim(skb, skb->len - S_CRC_LEN);
-		rtllib_hdr = (struct rtllib_hdr_1addr *)skb->data;
+		rtllib_hdr = (struct ieee80211_hdr *)skb->data;
 		if (!is_multicast_ether_addr(rtllib_hdr->addr1)) {
 			/* unicast packet */
 			unicast_packet = true;
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 565a6e41b982..3ffebe12e279 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -685,13 +685,6 @@ struct rtllib_hdr {
 	u8 payload[];
 } __packed;
 
-struct rtllib_hdr_1addr {
-	__le16 frame_ctl;
-	__le16 duration_id;
-	u8 addr1[ETH_ALEN];
-	u8 payload[];
-} __packed;
-
 struct rtllib_hdr_3addr {
 	__le16 frame_ctl;
 	__le16 duration_id;
diff --git a/drivers/staging/rtl8192e/rtllib_tx.c b/drivers/staging/rtl8192e/rtllib_tx.c
index 4199aee930f0..53eaf6330a98 100644
--- a/drivers/staging/rtl8192e/rtllib_tx.c
+++ b/drivers/staging/rtl8192e/rtllib_tx.c
@@ -268,7 +268,7 @@ static void rtllib_tx_query_agg_cap(struct rtllib_device *ieee,
 {
 	struct rt_hi_throughput *ht_info = ieee->ht_info;
 	struct tx_ts_record *pTxTs = NULL;
-	struct rtllib_hdr_1addr *hdr = (struct rtllib_hdr_1addr *)skb->data;
+	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
 
 	if (rtllib_act_scanning(ieee, false))
 		return;
-- 
2.42.0

