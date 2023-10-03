Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 946667B71D2
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 21:34:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240946AbjJCTeP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 15:34:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240964AbjJCTeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 15:34:09 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1FBFCC
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 12:34:04 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-98273ae42d0so50543666b.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 12:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696361643; x=1696966443; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KcpwhoTF72QmuvfU2aA3vEoxhzziqn/FfyNb0Sy2saM=;
        b=gm2gzl1eB9fJIQCWhSXHRPZGqadtvUJ+ugGPxpLwWhIYCjZWQeTXv+BcgSrYUTFV8f
         tej0iZeasdtoMFvMZO8HpIRjOrVEodhbmwLKpxq4zeIudIgoSWwG84mzFC9P5S+uTUK9
         jvCmeLmW4oFMNgvAFn7iXHMc7kU1yH6nncN/XpgX6C+O5gts3oh32CGZpZqFcjZ1b2Oz
         EAdkchIcY3T8Maq6TlocUXmDeaPsWhvnT+PSFT0br0xX9CU7pTrPQjnMgiNW56UPcgBC
         bHLRuhLpVcB9JgHpSbnSDExNW2i5FoO0/VbQw780wTWnO1DX2NY+UPuuGkOxgsc4NaeN
         xIsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696361643; x=1696966443;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KcpwhoTF72QmuvfU2aA3vEoxhzziqn/FfyNb0Sy2saM=;
        b=xIqkoUFz694Rp6EpSHWJfc8SeERoMvR+HN03wbnlUeFxbJusfhVl3dCOFtxHWCqGR2
         M7qZ5WntY8qMpWakghYLXl2NtKaOWA7cGsJRYdLmRUbU1/6qmje72W8BK+bN7mSujfkD
         +KEYraiIek7BXKxy4Fkdk78wamCaBqoQ3pX3UIp1fmmS1KI3KJr7uE/QkktWBjHUVtdt
         U+nyNRfl6UMcTPz6fBFFBaQ4YKoQ1M4O1JnokOShfjH3wVnGEVryOqzVJdMGPspJaunl
         1L+/o/K/OjaV3dRLD3gCPPn3bn1J01QeXh5dFJGkg1vWKmuX9Bjt2XZ10/FgPfia9bFa
         5njA==
X-Gm-Message-State: AOJu0YyL1wwz4KOXE4mkyMEke9nyeOlBVlkyOEnFiX5ECNHORuDP0vdc
        3XKlDWXjKGx8YKelnAUPvqtb5adABDQ=
X-Google-Smtp-Source: AGHT+IF11dzwlLWibdoHdDk0TOJiYh1+h9dOvseHZbz6e77UFQaFgOVSAlaqZVn4inZlch9EJX2rUQ==
X-Received: by 2002:a17:906:7496:b0:9a5:ce62:6e1a with SMTP id e22-20020a170906749600b009a5ce626e1amr125955ejl.1.1696361642874;
        Tue, 03 Oct 2023 12:34:02 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p579356c7.dip0.t-ipconnect.de. [87.147.86.199])
        by smtp.gmail.com with ESMTPSA id g5-20020a170906594500b009ae6a6451fdsm1530253ejr.35.2023.10.03.12.34.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 12:34:02 -0700 (PDT)
Date:   Tue, 3 Oct 2023 21:34:01 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 09/11] staging: rtl8192e: Remove constant variable
 promiscuous_on
Message-ID: <07936bcc6a426d6f6d74bece2970ab6028abef44.1696360404.git.philipp.g.hortmann@gmail.com>
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

Remove variable promiscuous_on as it is set to 0 and unchanged. The
equation results accordingly. Remove dead code.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 .../staging/rtl8192e/rtl8192e/r8192E_dev.c    |  5 +----
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c  |  1 -
 drivers/staging/rtl8192e/rtllib.h             |  5 -----
 drivers/staging/rtl8192e/rtllib_rx.c          | 22 +++++++++----------
 4 files changed, 11 insertions(+), 22 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
index 6cfc2254487b..e343e10e011a 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
@@ -706,10 +706,7 @@ void rtl92e_link_change(struct net_device *dev)
 
 		reg = rtl92e_readl(dev, RCR);
 		if (priv->rtllib->link_state == MAC80211_LINKED) {
-			if (ieee->intel_promiscuous_md_info.promiscuous_on)
-				;
-			else
-				priv->receive_config = reg |= RCR_CBSSID;
+			priv->receive_config = reg |= RCR_CBSSID;
 		} else {
 			priv->receive_config = reg &= ~RCR_CBSSID;
 		}
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index f15f73be41a2..ef17472bea05 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -740,7 +740,6 @@ static void _rtl92e_init_priv_variable(struct net_device *dev)
 	priv->rtllib->mode = WIRELESS_MODE_AUTO;
 	priv->rtllib->iw_mode = IW_MODE_INFRA;
 	priv->rtllib->net_promiscuous_md = false;
-	priv->rtllib->intel_promiscuous_md_info.promiscuous_on = false;
 	priv->rtllib->ieee_up = 0;
 	priv->retry_rts = DEFAULT_RETRY_RTS;
 	priv->retry_data = DEFAULT_RETRY_DATA;
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 748ae8d35c1a..97bb00bdbf4d 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1175,10 +1175,6 @@ struct rt_pmkid_list {
 	u8 bUsed;
 };
 
-struct rt_intel_promisc_mode {
-	bool promiscuous_on;
-};
-
 /*************** DRIVER STATUS   *****/
 #define STATUS_SCANNING			0
 /*************** DRIVER STATUS   *****/
@@ -1258,7 +1254,6 @@ struct rtllib_device {
 
 	int iw_mode; /* operating mode (IW_MODE_*) */
 	bool net_promiscuous_md;
-	struct rt_intel_promisc_mode intel_promiscuous_md_info;
 
 	spinlock_t lock;
 	spinlock_t wpax_suitlist_lock;
diff --git a/drivers/staging/rtl8192e/rtllib_rx.c b/drivers/staging/rtl8192e/rtllib_rx.c
index 1086dd0809be..f03ec5f53b34 100644
--- a/drivers/staging/rtl8192e/rtllib_rx.c
+++ b/drivers/staging/rtl8192e/rtllib_rx.c
@@ -959,18 +959,16 @@ static int rtllib_rx_data_filter(struct rtllib_device *ieee, struct ieee80211_hd
 	/* Nullfunc frames may have PS-bit set, so they must be passed to
 	 * hostap_handle_sta_rx() before being dropped here.
 	 */
-	if (!ieee->intel_promiscuous_md_info.promiscuous_on) {
-		if (stype != IEEE80211_STYPE_DATA &&
-		    stype != IEEE80211_STYPE_DATA_CFACK &&
-		    stype != IEEE80211_STYPE_DATA_CFPOLL &&
-		    stype != IEEE80211_STYPE_DATA_CFACKPOLL &&
-		    stype != IEEE80211_STYPE_QOS_DATA) {
-			if (stype != IEEE80211_STYPE_NULLFUNC)
-				netdev_dbg(ieee->dev,
-					   "RX: dropped data frame with no data (type=0x%02x, subtype=0x%02x)\n",
-					   type, stype);
-			return -1;
-		}
+	if (stype != IEEE80211_STYPE_DATA &&
+	    stype != IEEE80211_STYPE_DATA_CFACK &&
+	    stype != IEEE80211_STYPE_DATA_CFPOLL &&
+	    stype != IEEE80211_STYPE_DATA_CFACKPOLL &&
+	    stype != IEEE80211_STYPE_QOS_DATA) {
+		if (stype != IEEE80211_STYPE_NULLFUNC)
+			netdev_dbg(ieee->dev,
+				   "RX: dropped data frame with no data (type=0x%02x, subtype=0x%02x)\n",
+				   type, stype);
+		return -1;
 	}
 
 	/* packets from our adapter are dropped (echo) */
-- 
2.42.0

