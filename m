Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 544037EFE8F
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 09:51:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232611AbjKRIvQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 03:51:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjKRIvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 03:51:12 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C3BEB9
        for <linux-kernel@vger.kernel.org>; Sat, 18 Nov 2023 00:51:09 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9e28215db77so83272066b.1
        for <linux-kernel@vger.kernel.org>; Sat, 18 Nov 2023 00:51:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700297467; x=1700902267; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=paSTu0WaDDknunnGESBB1JuMqk8D4OMu6cj43zrhMCg=;
        b=SSP43ptEtrJeSh45OWa51R3ezZ828u3p6v4H8Isp+brVSw5iKEhPaP7FavYCxOS4df
         yhoPFbPCsZ7J+DT8FC8z76llOUf+r6J3Wo6dU+F/6PKWaDuLd1DpIT0F+7WbztHrlOy/
         v4cynCu/E8ZquEFCH1pwgDVVGkdEcH+oX8Whu85b02KSVDtPn3fuX4nEXjcXpm2MDuSB
         rhFTA3bqZ1vWHL5TudY9bisIziaz4i2ZUefM+bYtboB2ZGyPqOq+WBtHudl+ANAijpN5
         3MzA/cEvZihOxAYVG3GCKVGb9HIb4+KnZrcE+z9QtNWcW7C6hLn1eXZYU6yBirKTiYGp
         zPMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700297467; x=1700902267;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=paSTu0WaDDknunnGESBB1JuMqk8D4OMu6cj43zrhMCg=;
        b=a4e6fWNa/s9XzmrJIe6HlV1RvSJ/FUsfSwyK/1frs9Sgi2QUVS+PQ4oEfFlLxjjs2/
         36lLwqFatNWZ6dtxR7L7qkNSF7Y/2oWTiV3KmNuMtwjgtspZIscLrQut5c9/4I0/gHkZ
         XBL7EHc1dj7ka7dY2BqKStuv4pL/GetEPd5BPV0Lwre7UX7r4UBDCwwLgue8QbDqA7fm
         XoodE18wI2qYHq79EmJImWRl3kS2yZ3gsTsWgOzzU42/X/k6oxKVeJ5COrJWiYdrNqFk
         8Q69TRI5KUHkmw49oGH+ooDO4TI27JgSBqZvRyEjOiQHtOgKf4MXd94CROMIxngVY2A2
         HAwA==
X-Gm-Message-State: AOJu0Ywh/a/gvoT+VmjUKPBivSxkTZepN+HEc7Z7PJ86LSJ8HSO5WOgx
        vowha066ym3vseePO5q6qSY=
X-Google-Smtp-Source: AGHT+IEWpkgxkoy1xOUSJLtY2Vdy5FLz88TbjdaC1hbBUqnyKhSWmglq4dEfcaubqhyNZsM203tWFw==
X-Received: by 2002:a05:6402:22a2:b0:548:15d1:4ac with SMTP id cx2-20020a05640222a200b0054815d104acmr1154348edb.4.1700297467345;
        Sat, 18 Nov 2023 00:51:07 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p57ba2f20.dip0.t-ipconnect.de. [87.186.47.32])
        by smtp.gmail.com with ESMTPSA id n6-20020aa7c786000000b005434095b179sm1493207eds.92.2023.11.18.00.51.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Nov 2023 00:51:07 -0800 (PST)
Date:   Sat, 18 Nov 2023 09:51:05 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 01/10] staging: rtl8192e: Remove unused return value of
 rtl92e_set_channel()
Message-ID: <0c0e7c72a10731ae7ed49c8161136b0f0b63d7a0.1700296319.git.philipp.g.hortmann@gmail.com>
References: <cover.1700296319.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1700296319.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused return value of rtl92e_set_channel().

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c | 12 ++++++------
 drivers/staging/rtl8192e/rtl8192e/r8192E_phy.h |  2 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_core.h   |  2 +-
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
index 4d12d7385041..e1bd4d67e862 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
@@ -671,16 +671,16 @@ static void _rtl92e_phy_switch_channel_work_item(struct net_device *dev)
 	_rtl92e_phy_switch_channel(dev, priv->chan);
 }
 
-u8 rtl92e_set_channel(struct net_device *dev, u8 channel)
+void rtl92e_set_channel(struct net_device *dev, u8 channel)
 {
 	struct r8192_priv *priv = rtllib_priv(dev);
 
 	if (!priv->up) {
 		netdev_err(dev, "%s(): Driver is not initialized\n", __func__);
-		return false;
+		return;
 	}
 	if (priv->sw_chnl_in_progress)
-		return false;
+		return;
 
 	switch (priv->rtllib->mode) {
 	case WIRELESS_MODE_B:
@@ -688,7 +688,7 @@ u8 rtl92e_set_channel(struct net_device *dev, u8 channel)
 			netdev_warn(dev,
 				    "Channel %d not available in 802.11b.\n",
 				    channel);
-			return false;
+			return;
 		}
 		break;
 	case WIRELESS_MODE_G:
@@ -697,7 +697,7 @@ u8 rtl92e_set_channel(struct net_device *dev, u8 channel)
 			netdev_warn(dev,
 				    "Channel %d not available in 802.11g.\n",
 				    channel);
-			return false;
+			return;
 		}
 		break;
 	}
@@ -714,7 +714,7 @@ u8 rtl92e_set_channel(struct net_device *dev, u8 channel)
 	if (priv->up)
 		_rtl92e_phy_switch_channel_work_item(dev);
 	priv->sw_chnl_in_progress = false;
-	return true;
+	return;
 }
 
 static void _rtl92e_cck_tx_power_track_bw_switch_tssi(struct net_device *dev)
diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.h b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.h
index 6c4c33ded6a9..ff4b4004b0d0 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.h
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.h
@@ -41,7 +41,7 @@ void rtl92e_get_tx_power(struct net_device *dev);
 void rtl92e_set_tx_power(struct net_device *dev, u8 channel);
 u8 rtl92e_config_rf_path(struct net_device *dev, enum rf90_radio_path eRFPath);
 
-u8 rtl92e_set_channel(struct net_device *dev, u8 channel);
+void rtl92e_set_channel(struct net_device *dev, u8 channel);
 void rtl92e_set_bw_mode(struct net_device *dev,
 			enum ht_channel_width bandwidth,
 			enum ht_extchnl_offset Offset);
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
index a4afbf3e934d..9b0be6dff627 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
@@ -228,7 +228,7 @@ struct r8192_priv {
 	struct rt_stats stats;
 	struct iw_statistics			wstats;
 
-	u8 (*rf_set_chan)(struct net_device *dev, u8 ch);
+	void (*rf_set_chan)(struct net_device *dev, u8 ch);
 
 	struct rx_desc *rx_ring;
 	struct sk_buff	*rx_buf[MAX_RX_COUNT];
-- 
2.42.0

