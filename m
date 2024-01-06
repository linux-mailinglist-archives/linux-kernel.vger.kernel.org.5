Return-Path: <linux-kernel+bounces-18498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ECCF825E62
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 06:58:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A38221C23C44
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 05:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C328BE5A;
	Sat,  6 Jan 2024 05:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="hwzkpFTO"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EBBA79EC
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jan 2024 05:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3bbd6e37a9bso335606b6e.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jan 2024 21:56:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1704520574; x=1705125374; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oCaFmMfTT0KeM0sPMid+19JPonrhplA7ayvF2V4ouF0=;
        b=hwzkpFTOydt82DUcTrnQvl68/sFcKrdcagEBQTWRHOuxoxHqLzbbIVon6vF10ZvwWX
         OFVF2xMSYcGD+r4CXOKPe4SFeDyzFauAS/9TRxIJmz3eRWiJtXKNBlAUqMkGUPXNg30b
         FkLzuQtJDYKt5b4mIoj+D4MwGrC4DiPeSLHyVx879mhiLUbu7eG5hSRlE4av7nFHvPvu
         6Gx8ibmuqHbLCrm9sluEbfH9ewREuxAm9f0QZXJlEEIV4i47nNywZEaT6t2P8SQIXBws
         NljN2CEhTbr4AyxwM1tULGECzv0Jil9QaTswqMXqB4yXjXS4ql6Ysbcod8zGHS4booPl
         m6XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704520574; x=1705125374;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oCaFmMfTT0KeM0sPMid+19JPonrhplA7ayvF2V4ouF0=;
        b=g/igtbpLA3eZzkNNYOGzc825KjS5ImCqd5/0urErLb4HXdcJ6da+4OCM+yjw6QtJ5K
         W+gielLAnYb/DvGk/Yu/OwS4fWL2k/QaM08AXevJpU+bFp7XZvtBb1iHlegUHiRnceQR
         GD6LJEUdh4HtnsxHs37aQvUPwI4zw+QZvqOayaAdGzLPcEkx8wtO6Tz5bIZeEGSo6det
         i4S3yy+Ni8eJsVazOWezyieOKrOSGD/x20r7ax94Eul+9C8Izzj9v3HMq+0Qw/oDHk2s
         +2pDAOZiQBCIGBA4krN+euhfQk5hPSmuACi4Ma2DXGtBVSxf2Pf3X2zLryxpjrmR23wU
         t74w==
X-Gm-Message-State: AOJu0YwcHVGa3kNUpDYlsLIwdBnUPkj0g9ekaf1YAqNjItxeV5DVWUW/
	sf86Hmlxe1rL0faiHXJKegr71OuXO26L4A==
X-Google-Smtp-Source: AGHT+IFrmqa7SBMfBk0qNb4wPdBlq5qkztpRMC2RF0ugZEME+gjlhTRpsZNeeZiXm21q9OTWjxRPrw==
X-Received: by 2002:a05:6808:3088:b0:3bb:bf36:35ae with SMTP id bl8-20020a056808308800b003bbbf3635aemr712500oib.43.1704520574550;
        Fri, 05 Jan 2024 21:56:14 -0800 (PST)
Received: from oatmeal.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id y29-20020a056a00181d00b006d99d986624sm2280873pfa.151.2024.01.05.21.56.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 21:56:14 -0800 (PST)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 08/21] Staging: rtl8192e: Rename variable bBusyTraffic
Date: Fri,  5 Jan 2024 21:55:43 -0800
Message-Id: <20240106055556.430948-9-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240106055556.430948-1-tdavies@darkphysics.net>
References: <20240106055556.430948-1-tdavies@darkphysics.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename variable bBusyTraffic to busy_traffic to fix checkpatch
warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c | 6 +++---
 drivers/staging/rtl8192e/rtl8192e/rtl_wx.c   | 2 +-
 drivers/staging/rtl8192e/rtllib.h            | 2 +-
 drivers/staging/rtl8192e/rtllib_softmac.c    | 2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index c9d7484fe1cd..16ce207f5bd7 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -943,7 +943,7 @@ static void _rtl92e_watchdog_wq_cb(void *data)
 	unsigned long flags;
 	struct rt_pwr_save_ctrl *psc = (struct rt_pwr_save_ctrl *)
 					(&priv->rtllib->pwr_save_ctrl);
-	bool bBusyTraffic = false;
+	bool busy_traffic = false;
 	bool	bHigherBusyTraffic = false;
 	bool	bHigherBusyRxTraffic = false;
 	bool bEnterPS = false;
@@ -973,7 +973,7 @@ static void _rtl92e_watchdog_wq_cb(void *data)
 	if ((ieee->link_state == MAC80211_LINKED) && (ieee->iw_mode == IW_MODE_INFRA)) {
 		if (ieee->link_detect_info.num_rx_ok_in_period > 100 ||
 		ieee->link_detect_info.num_tx_ok_in_period > 100)
-			bBusyTraffic = true;
+			busy_traffic = true;
 
 		if (ieee->link_detect_info.num_rx_ok_in_period > 4000 ||
 		    ieee->link_detect_info.num_tx_ok_in_period > 4000) {
@@ -1006,7 +1006,7 @@ static void _rtl92e_watchdog_wq_cb(void *data)
 	ieee->link_detect_info.num_rx_ok_in_period = 0;
 	ieee->link_detect_info.num_tx_ok_in_period = 0;
 	ieee->link_detect_info.NumRxUnicastOkInPeriod = 0;
-	ieee->link_detect_info.bBusyTraffic = bBusyTraffic;
+	ieee->link_detect_info.busy_traffic = busy_traffic;
 
 	ieee->link_detect_info.bHigherBusyTraffic = bHigherBusyTraffic;
 	ieee->link_detect_info.bHigherBusyRxTraffic = bHigherBusyRxTraffic;
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c b/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
index 4c884c5277f9..5fd44d0c4b1d 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
@@ -253,7 +253,7 @@ static int _rtl92e_wx_set_scan(struct net_device *dev,
 	rt_state = priv->rtllib->rf_power_state;
 	if (!priv->up)
 		return -ENETDOWN;
-	if (priv->rtllib->link_detect_info.bBusyTraffic)
+	if (priv->rtllib->link_detect_info.busy_traffic)
 		return -EAGAIN;
 
 	if (wrqu->data.flags & IW_SCAN_THIS_ESSID) {
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 9d6704fc86ff..d127528e7932 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1121,7 +1121,7 @@ struct rt_link_detect {
 	u32				num_tx_ok_in_period;
 	u32				num_rx_ok_in_period;
 	u32				NumRxUnicastOkInPeriod;
-	bool				bBusyTraffic;
+	bool				busy_traffic;
 	bool				bHigherBusyTraffic;
 	bool				bHigherBusyRxTraffic;
 };
diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index 85e6e727bec7..40d6ae15b246 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -1734,7 +1734,7 @@ rtllib_rx_deauth(struct rtllib_device *ieee, struct sk_buff *skb)
 		ieee->link_state = RTLLIB_ASSOCIATING;
 		ieee->softmac_stats.reassoc++;
 		ieee->is_roaming = true;
-		ieee->link_detect_info.bBusyTraffic = false;
+		ieee->link_detect_info.busy_traffic = false;
 		rtllib_disassociate(ieee);
 		RemovePeerTS(ieee, header->addr2);
 		if (!(ieee->rtllib_ap_sec_type(ieee) &
-- 
2.39.2


