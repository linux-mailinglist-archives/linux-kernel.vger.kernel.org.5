Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B96757AB2B4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 15:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234155AbjIVNaX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 09:30:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234145AbjIVNaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 09:30:11 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 358F51A7
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 06:30:04 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-405101a02bcso7332665e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 06:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695389402; x=1695994202; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IU0umDeRj0qrz0iB2siEvqGentkzeL4EI2Vh5qfUxFY=;
        b=RD+rKfJvD73e033pOuFeQjlPG4yo+CxGK3XQpyChIdhUmMW5H+FVmCTYqwa2FWnwy/
         RfEX1OFB6KPidw5RD2M//D4S8COJDLu224usRoDbswODhtAFQMfA8dKZIzvZXRskCk+4
         mE1rxBEQ7bkVHYhkfhqEGHoqOn/xDSiCoyHK9W/LnyYRAorWd0GJMwlaqpPfMKHeKJIL
         3AjvMxvQmuVSF/rmxvTdiJ92iOj9HTRzpiYGfileTNiBKTASQAwfn1iAqV/fR4gBqRep
         iPchyqyE0ZKDmjV+b2iS9Mn5Pio+lmOWsTcPjc/nui5+HfYjcjU3HIttlrJJAjN95Nw1
         Yj9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695389402; x=1695994202;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IU0umDeRj0qrz0iB2siEvqGentkzeL4EI2Vh5qfUxFY=;
        b=AJRwcHVlxLW7EW88SyEaMvNknTQQUPYLeXyFlxu9gNZkck8AOlmjiRZ/ck3L386tuX
         sOX8cmyGtg8lQhCVTO+ky4nNxfakWh0S05IiX7dnED8gqEqucXjRThSB7esr0rKT0jjo
         F771PVR1mKo+EbpAm9hA2JnorW/YPJZ88ZKXfznx2XU2NFS1XRt7NxNh6avawvOiUOQa
         9y9iEJix9YOvXbvfkdqC65v5eyKehiRi54fTXU6/Dq3cBoteC9yv6VFsrrKr3SVOElIr
         1vgupJ5naDKcsV+/FvzLL4z/wO2p0RIZps4tiM6ZX+rOKor/hLPEpm79RVtzbPGcnxdA
         o5EQ==
X-Gm-Message-State: AOJu0YxBtS3qN/+BtPh7wvlnW8fwZZvk/ZcCDcgiMAnW8PruMXaJLeeQ
        Iinez0GpM4iS+pzkx4gEcvY=
X-Google-Smtp-Source: AGHT+IHKK+OqC1EfcapiU5dz6RVElf341Utdamu3L6MLv629us5ayppbW6MZqlMBDrpTL/rlbOV3tw==
X-Received: by 2002:a05:600c:511e:b0:405:4721:800 with SMTP id o30-20020a05600c511e00b0040547210800mr273667wms.1.1695389402540;
        Fri, 22 Sep 2023 06:30:02 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p579356c7.dip0.t-ipconnect.de. [87.147.86.199])
        by smtp.gmail.com with ESMTPSA id v11-20020a5d610b000000b0031435731dfasm4454699wrt.35.2023.09.22.06.30.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 06:30:02 -0700 (PDT)
Date:   Fri, 22 Sep 2023 15:30:00 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 7/7] staging: rtl8192e: Remove rtllib_stop_send_beacons
Message-ID: <17c5545102ad8f50ca320af17aafa555f8caec2d.1695387832.git.philipp.g.hortmann@gmail.com>
References: <cover.1695387832.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1695387832.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rtllib_start_send_beacons() is removed so no need for
rtllib_stop_send_beacons() anymore.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c |  7 -------
 drivers/staging/rtl8192e/rtllib.h            |  9 ---------
 drivers/staging/rtl8192e/rtllib_softmac.c    | 21 --------------------
 drivers/staging/rtl8192e/rtllib_softmac_wx.c |  1 -
 4 files changed, 38 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index 208c7bfd9bfe..87f5441fbb10 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -458,10 +458,6 @@ static void _rtl92e_prepare_beacon(struct tasklet_struct *t)
 	pdesc->OWN = 1;
 }
 
-static void _rtl92e_stop_beacon(struct net_device *dev)
-{
-}
-
 void rtl92e_config_rate(struct net_device *dev, u16 *rate_config)
 {
 	struct r8192_priv *priv = rtllib_priv(dev);
@@ -700,8 +696,6 @@ static void _rtl92e_init_priv_handler(struct net_device *dev)
 	priv->rtllib->set_bw_mode_handler	= rtl92e_set_bw_mode;
 	priv->rf_set_chan			= rtl92e_set_channel;
 
-	priv->rtllib->stop_send_beacons = _rtl92e_stop_beacon;
-
 	priv->rtllib->sta_wake_up = rtl92e_hw_wakeup;
 	priv->rtllib->enter_sleep_state = rtl92e_enter_sleep;
 	priv->rtllib->ps_is_queue_empty = _rtl92e_is_tx_queue_empty;
@@ -1045,7 +1039,6 @@ static void _rtl92e_if_silent_reset(struct net_device *dev)
 		if (ieee->link_state == MAC80211_LINKED) {
 			mutex_lock(&ieee->wx_mutex);
 			netdev_info(dev, "ieee->link_state is MAC80211_LINKED\n");
-			rtllib_stop_send_beacons(priv->rtllib);
 			del_timer_sync(&ieee->associate_timer);
 			cancel_delayed_work(&ieee->associate_retry_wq);
 			rtllib_stop_scan(ieee);
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 410401869ebb..0597dcb759e0 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1495,14 +1495,6 @@ struct rtllib_device {
 	 */
 	void (*link_change)(struct net_device *dev);
 
-	/* these two function indicates to the HW when to start
-	 * and stop to send beacons. This is used when the
-	 * IEEE_SOFTMAC_BEACONS is not set. For now the
-	 * stop_send_bacons is NOT guaranteed to be called only
-	 * after start_send_beacons.
-	 */
-	void (*stop_send_beacons)(struct net_device *dev);
-
 	/* power save mode related */
 	void (*sta_wake_up)(struct net_device *dev);
 	void (*enter_sleep_state)(struct net_device *dev, u64 time);
@@ -1725,7 +1717,6 @@ void rtllib_reset_queue(struct rtllib_device *ieee);
 void rtllib_wake_all_queues(struct rtllib_device *ieee);
 void rtllib_stop_all_queues(struct rtllib_device *ieee);
 struct sk_buff *rtllib_get_beacon(struct rtllib_device *ieee);
-void rtllib_stop_send_beacons(struct rtllib_device *ieee);
 
 void notify_wx_assoc_event(struct rtllib_device *ieee);
 void rtllib_ps_tx_ack(struct rtllib_device *ieee, short success);
diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index 4551071e9f1b..982578e1c0af 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -607,26 +607,6 @@ static void rtllib_softmac_scan_wq(void *data)
 	mutex_unlock(&ieee->scan_mutex);
 }
 
-static void rtllib_beacons_stop(struct rtllib_device *ieee)
-{
-	unsigned long flags;
-
-	spin_lock_irqsave(&ieee->beacon_lock, flags);
-
-	ieee->beacon_txing = 0;
-
-	spin_unlock_irqrestore(&ieee->beacon_lock, flags);
-	del_timer_sync(&ieee->beacon_timer);
-}
-
-void rtllib_stop_send_beacons(struct rtllib_device *ieee)
-{
-	ieee->stop_send_beacons(ieee->dev);
-	if (ieee->softmac_features & IEEE_SOFTMAC_BEACONS)
-		rtllib_beacons_stop(ieee);
-}
-EXPORT_SYMBOL(rtllib_stop_send_beacons);
-
 static void rtllib_softmac_stop_scan(struct rtllib_device *ieee)
 {
 	mutex_lock(&ieee->scan_mutex);
@@ -2326,7 +2306,6 @@ void rtllib_stop_protocol(struct rtllib_device *ieee, u8 shutdown)
 		ieee->rtllib_ips_leave(ieee->dev);
 	}
 
-	rtllib_stop_send_beacons(ieee);
 	del_timer_sync(&ieee->associate_timer);
 	cancel_delayed_work_sync(&ieee->associate_retry_wq);
 	cancel_delayed_work_sync(&ieee->link_change_wq);
diff --git a/drivers/staging/rtl8192e/rtllib_softmac_wx.c b/drivers/staging/rtl8192e/rtllib_softmac_wx.c
index 2b15251201ec..3c7c0f07ab0b 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac_wx.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac_wx.c
@@ -310,7 +310,6 @@ void rtllib_wx_sync_scan_wq(void *data)
 	rtllib_sta_ps_send_null_frame(ieee, 1);
 
 	rtllib_stop_all_queues(ieee);
-	rtllib_stop_send_beacons(ieee);
 	ieee->link_state = MAC80211_LINKED_SCANNING;
 	ieee->link_change(ieee->dev);
 	/* wait for ps packet to be kicked out successfully */
-- 
2.42.0

