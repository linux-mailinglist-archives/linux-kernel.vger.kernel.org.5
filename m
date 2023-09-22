Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B608E7AB2B2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 15:30:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234081AbjIVNaK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 09:30:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234108AbjIVNaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 09:30:00 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 300161B6
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 06:29:52 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-3200b181b67so194901f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 06:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695389390; x=1695994190; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HcI62QI75qSosGu186RGvSHgdJGB0VnvRx/uN1ATU0o=;
        b=EhaTXkQ2i1PJLdBJJgMUFo2vEdw7hsuZ2EyIaQBtTAGvwyiN+KaOEqNNxJrLRSrcYc
         nUIx/HCyUAx8+AOtKJZIzar6VprdPUJbnBLd58Wt7v6xOOQ9zLXwGB2nSDaL6Vvu2ufn
         PtbETHtbIyQzFZaN585D6C3xvuztPU/tiwL510FIpIFhyGkdPnOeu7KOoGcaPDL4jMkI
         DQ0Ecf5RIg4ecveCxivwDvY4IP+i4sPvmnnmHfI/MCaCpv4CfJMtXtdCYr0eY9GqPGuF
         LBqkEMk/E1F1Ov/J4w2AJDg4mKPVw/x4kXNsmXBVOADP0raaUY0m9+WMUx8wKhJgM7aO
         Uulw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695389390; x=1695994190;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HcI62QI75qSosGu186RGvSHgdJGB0VnvRx/uN1ATU0o=;
        b=JxBCekDk5I25TnLLMqDLq2Ylxoe6qb+3f2jmMRT/OboguQv4o/Ur6CazXcrI7nXHsS
         +CsbExEm9/DOHSjEIQDVkGTfoH+AnaejF6bT2YQdiD36KGq6lP71s9TlvU5fZwDPcMrE
         2DTIDE3A5TXKEdDSMIIimy5wt/NeaTcTYk+CZXk0lppsEgIA9als6pdd4W6wshg/N0yn
         jsdwwN5bPXq8CPI7BSHegrZaNPgum4ddaUUhB5gvYdnaSD8Y5s+zHek/l7QU5t9vPSt6
         B+Q+2u4/KaMDWEk4zlJvZNHG8ulOpxQYiB6uEeFOyR+cXNw0k6YapziEEEK9FG5cPlmm
         lPqg==
X-Gm-Message-State: AOJu0YwN1eWlP74jvPLoeuxuYd6UBsPB+mfatWzrid3P1ZfraxB+VeLU
        FHi9MCzEz3/y4OIeYcLcRmM=
X-Google-Smtp-Source: AGHT+IGQRQFe9jhqT8lg62fGPGY2Cu7F6rL0aH6007Agc6Zo4ZJv0iyyy6y5hM8I+tmjSHPdUV+1Zw==
X-Received: by 2002:a5d:5443:0:b0:317:8fd:f01a with SMTP id w3-20020a5d5443000000b0031708fdf01amr7696229wrv.7.1695389390611;
        Fri, 22 Sep 2023 06:29:50 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p579356c7.dip0.t-ipconnect.de. [87.147.86.199])
        by smtp.gmail.com with ESMTPSA id p5-20020a056000018500b0031c855d52efsm4449243wrx.87.2023.09.22.06.29.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 06:29:50 -0700 (PDT)
Date:   Fri, 22 Sep 2023 15:29:47 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 5/7] staging: rtl8192e: Remove mode IW_MODE_ADHOC from
 rtllib_softmac.c
Message-ID: <4259c06deaf2e3f3cc615e8c55bcf6f70ce4e277.1695387832.git.philipp.g.hortmann@gmail.com>
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

Remove unsupported mode IW_MODE_ADHOC from rtllib_softmac.c.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtllib.h         |  1 -
 drivers/staging/rtl8192e/rtllib_softmac.c | 45 +----------------------
 2 files changed, 1 insertion(+), 45 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 7dde428313c9..d10fddd4f9ad 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1702,7 +1702,6 @@ void rtllib_softmac_new_net(struct rtllib_device *ieee,
 void SendDisassociation(struct rtllib_device *ieee, bool deauth, u16 asRsn);
 void rtllib_softmac_xmit(struct rtllib_txb *txb, struct rtllib_device *ieee);
 
-void rtllib_start_ibss(struct rtllib_device *ieee);
 int rtllib_softmac_init(struct rtllib_device *ieee);
 void rtllib_softmac_free(struct rtllib_device *ieee);
 void rtllib_disassociate(struct rtllib_device *ieee);
diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index d8d9d59664ed..434690eeed5c 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -901,8 +901,6 @@ static struct sk_buff *rtllib_probe_resp(struct rtllib_device *ieee,
 	}
 
 	if (wpa_ie_len) {
-		if (ieee->iw_mode == IW_MODE_ADHOC)
-			memcpy(&ieee->wpa_ie[14], &ieee->wpa_ie[8], 4);
 		memcpy(tag, ieee->wpa_ie, ieee->wpa_ie_len);
 		tag += ieee->wpa_ie_len;
 	}
@@ -1437,14 +1435,7 @@ inline void rtllib_softmac_new_net(struct rtllib_device *ieee,
 	    WLAN_CAPABILITY_ESS))
 		return;
 
-	if ((ieee->iw_mode == IW_MODE_ADHOC) && !(net->capability &
-	     WLAN_CAPABILITY_IBSS))
-		return;
-
-	if ((ieee->iw_mode == IW_MODE_ADHOC) &&
-	    (net->channel > ieee->ibss_maxjoin_chal))
-		return;
-	if (ieee->iw_mode == IW_MODE_INFRA || ieee->iw_mode == IW_MODE_ADHOC) {
+	if (ieee->iw_mode == IW_MODE_INFRA) {
 		/* if the user specified the AP MAC, we need also the essid
 		 * This could be obtained by beacons or, if the network does not
 		 * broadcast it, it can be put manually.
@@ -2308,11 +2299,6 @@ static void rtllib_start_ibss_wq(void *data)
 	mutex_unlock(&ieee->wx_mutex);
 }
 
-inline void rtllib_start_ibss(struct rtllib_device *ieee)
-{
-	schedule_delayed_work(&ieee->start_ibss_wq, msecs_to_jiffies(150));
-}
-
 /* this is called only in user context, with wx_mutex held */
 static void rtllib_start_bss(struct rtllib_device *ieee)
 {
@@ -2546,9 +2532,6 @@ void rtllib_start_protocol(struct rtllib_device *ieee)
 	case IW_MODE_INFRA:
 		rtllib_start_bss(ieee);
 		break;
-	case IW_MODE_ADHOC:
-		rtllib_start_ibss(ieee);
-		break;
 	case IW_MODE_MONITOR:
 		rtllib_start_monitor_mode(ieee);
 		break;
@@ -2745,30 +2728,6 @@ u8 rtllib_ap_sec_type(struct rtllib_device *ieee)
 	}
 }
 
-static void rtllib_MgntDisconnectIBSS(struct rtllib_device *rtllib)
-{
-	u8	OpMode;
-	u8	i;
-	bool	bFilterOutNonAssociatedBSSID = false;
-
-	rtllib->link_state = MAC80211_NOLINK;
-
-	for (i = 0; i < 6; i++)
-		rtllib->current_network.bssid[i] = 0x55;
-
-	rtllib->OpMode = RT_OP_MODE_NO_LINK;
-	rtllib->SetHwRegHandler(rtllib->dev, HW_VAR_BSSID,
-				rtllib->current_network.bssid);
-	OpMode = RT_OP_MODE_NO_LINK;
-	rtllib->SetHwRegHandler(rtllib->dev, HW_VAR_MEDIA_STATUS, &OpMode);
-	rtllib_stop_send_beacons(rtllib);
-
-	bFilterOutNonAssociatedBSSID = false;
-	rtllib->SetHwRegHandler(rtllib->dev, HW_VAR_CECHK_BSSID,
-				(u8 *)(&bFilterOutNonAssociatedBSSID));
-	notify_wx_assoc_event(rtllib);
-}
-
 static void rtllib_MlmeDisassociateRequest(struct rtllib_device *rtllib,
 					   u8 *asSta, u8 asRsn)
 {
@@ -2816,8 +2775,6 @@ bool rtllib_MgntDisconnect(struct rtllib_device *rtllib, u8 asRsn)
 		rtllib->sta_wake_up(rtllib->dev);
 
 	if (rtllib->link_state == MAC80211_LINKED) {
-		if (rtllib->iw_mode == IW_MODE_ADHOC)
-			rtllib_MgntDisconnectIBSS(rtllib);
 		if (rtllib->iw_mode == IW_MODE_INFRA)
 			rtllib_MgntDisconnectAP(rtllib, asRsn);
 	}
-- 
2.42.0

