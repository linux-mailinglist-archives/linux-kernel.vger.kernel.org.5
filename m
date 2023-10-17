Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37A007CBC01
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 09:07:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234403AbjJQHHh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 03:07:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234522AbjJQHHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 03:07:35 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62474FF
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 00:07:32 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-5a7afd45199so67868007b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 00:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697526451; x=1698131251; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j+MME868h1wd91xe1rhnn2WNwXkREseRwBcc3YMwtj0=;
        b=lySMhirqIx6zaGWiTNMdBA2Tnjie3SzMRwC55v5LkjfSDH90NMKkWvrWPoNfPf0mqq
         MICf8JWOBZ80SYP+egQiwW9beTc4v3MOD9AWr+oqsSCtvxEVz47y1PPUpgzJ5YSXLUNx
         9cD+yBjIDDuFd7yHXqtuFV/YLD+huDDa0gQGe6GvIDBwbg4OQ0pDfLLZSH+vSz1XY9ai
         MhZ7Qj2WqfAN5CPcqtVoHkVG1Uc1JfMtIcRcvdzXFkIMniMFdlDnYpO1v8RtTZLevIHL
         imOd72t4eBsQp+I+AJOkxsnFhs1QTAAR569HNK4oWh4jSMZVH4jynb3lX3/XRQPWLsyj
         DN1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697526451; x=1698131251;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j+MME868h1wd91xe1rhnn2WNwXkREseRwBcc3YMwtj0=;
        b=T22Zhe4W7jbmJgKCACZ8Eetw5NOzxKDWvBQgMmQmGOpw/DEh0QPUOhms4+Osw09A/X
         nhwr46l8gwB8WEEKMz98o+PIhKaHCRYpm51mlppI3FoXWULByT/FWf6lpvRVJ1LL4QZs
         7ThxLcTa/7HE7yQZUneS4lu6AidSEY/5JF7oqUmAVzLGX3W5FReoKtDovc9ddyNm84UB
         IlZqjxftZ/iovSVtqKrzSvt9UAu7TrT/e+URAbF+2e51QHvF8dSElKxifBHAC1TcG+0/
         0xXAc5cqNEn/zXa+obZIpFmx5Irldf6rcPjtASwVh1umS3e/Ot9u60VlTfij+/q4+WoS
         tH6g==
X-Gm-Message-State: AOJu0Yyqr6Iab7G3NBI0dQ/Zj8Lb2p1XxcBxj+95uWxFrA0hSXMuMflM
        3CD53Bmolk+uKkSpQrySnH1QEqjhjqvKVA==
X-Google-Smtp-Source: AGHT+IFl1M3MVlLvmISOHUQp89Rw4sS008RqeqUKJeBtDT6cez8RBeiVuZU9bURBTYL37a8+UzkZkA==
X-Received: by 2002:a81:5e02:0:b0:589:b3c6:95ff with SMTP id s2-20020a815e02000000b00589b3c695ffmr1967398ywb.36.1697526451097;
        Tue, 17 Oct 2023 00:07:31 -0700 (PDT)
Received: from lab-ubuntu ([41.90.67.11])
        by smtp.gmail.com with ESMTPSA id w131-20020a0dd489000000b00594fff48796sm384895ywd.75.2023.10.17.00.07.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 00:07:30 -0700 (PDT)
Date:   Tue, 17 Oct 2023 10:07:28 +0300
From:   Calvince Otieno <calvncce@gmail.com>
To:     gustavo@embeddedor.com, outreachy@lists.linux.dev
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Calvince Otieno <calvncce@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Deepak R Varma <drv@mailo.com>,
        Simon Horman <horms@kernel.org>, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: wlan-ng: coding style corrections
Message-ID: <ZS4ysMWnjvWmnPvI@lab-ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch brings the codebase in compliance with the Linux kernel coding
style guidelines, as outlined in the document at
https://www.kernel.org/doc/html/latest/process/coding-style.html.

Changes Made:
- Adjusted line lengths to a maximum of 80 characters

The guide states that the preferred limit on the length of a single
line is 80 columns. Statements longer than 80 columns should be broken
into sensible chunks, unless exceeding 80 columns significantly increases
readability and does not hide information.

Signed-off-by: Calvince Otieno <calvncce@gmail.com>
---
 drivers/staging/wlan-ng/p80211netdev.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/wlan-ng/p80211netdev.c b/drivers/staging/wlan-ng/p80211netdev.c
index 8634fc89a6c2..caa8dd0ab8c2 100644
--- a/drivers/staging/wlan-ng/p80211netdev.c
+++ b/drivers/staging/wlan-ng/p80211netdev.c
@@ -77,10 +77,11 @@ static int p80211knetdev_stop(struct net_device *netdev);
 static netdev_tx_t p80211knetdev_hard_start_xmit(struct sk_buff *skb,
 						 struct net_device *netdev);
 static void p80211knetdev_set_multicast_list(struct net_device *dev);
-static int p80211knetdev_siocdevprivate(struct net_device *dev, struct ifreq *ifr,
-					void __user *data, int cmd);
+static int p80211knetdev_siocdevprivate(struct net_device *dev,
+					struct ifreq *ifr, void __user *data, int cmd);
 static int p80211knetdev_set_mac_address(struct net_device *dev, void *addr);
-static void p80211knetdev_tx_timeout(struct net_device *netdev, unsigned int txqueue);
+static void p80211knetdev_tx_timeout(struct net_device *netdev,
+				     unsigned int txqueue);
 static int p80211_rx_typedrop(struct wlandevice *wlandev, u16 fc);
 
 int wlan_watchdog = 5000;
@@ -343,7 +344,8 @@ static netdev_tx_t p80211knetdev_hard_start_xmit(struct sk_buff *skb,
 		 */
 		if (be16_to_cpu(skb->protocol) != ETH_P_80211_RAW) {
 			netif_start_queue(wlandev->netdev);
-			netdev_notice(netdev, "Tx attempt prior to association, frame dropped.\n");
+			netdev_notice(netdev,
+				      "Tx attempt prior to association, frame dropped.\n");
 			netdev->stats.tx_dropped++;
 			result = 0;
 			goto failed;
@@ -591,7 +593,8 @@ static int p80211knetdev_set_mac_address(struct net_device *dev, void *addr)
 	 * change the netdev address
 	 */
 	if (result != 0 || resultcode->data != P80211ENUM_resultcode_success) {
-		netdev_err(dev, "Low-level driver failed dot11req_mibset(dot11MACAddress).\n");
+		netdev_err(dev,
+			   "Low-level driver failed dot11req_mibset(dot11MACAddress).\n");
 		result = -EADDRNOTAVAIL;
 	} else {
 		/* everything's ok, change the addr in netdev */
@@ -974,7 +977,8 @@ static int p80211_rx_typedrop(struct wlandevice *wlandev, u16 fc)
 	return drop;
 }
 
-static void p80211knetdev_tx_timeout(struct net_device *netdev, unsigned int txqueue)
+static void p80211knetdev_tx_timeout(struct net_device *netdev,
+				     unsigned int txqueue)
 {
 	struct wlandevice *wlandev = netdev->ml_priv;
 
-- 
2.34.1

