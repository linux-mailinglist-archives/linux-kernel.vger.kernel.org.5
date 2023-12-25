Return-Path: <linux-kernel+bounces-11160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A7F9E81E248
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 21:23:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E29DB214E4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 20:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B89CF53E18;
	Mon, 25 Dec 2023 20:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="a1+OFO2u"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A204B53808
	for <linux-kernel@vger.kernel.org>; Mon, 25 Dec 2023 20:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3bbb78d0eb3so100857b6e.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Dec 2023 12:23:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1703535799; x=1704140599; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jRNgt5in1rawwI1Ihf7aE8qeFKHIp2oRP3X2LuU5NhE=;
        b=a1+OFO2uT4b7FwQ7KHXy6yC0gxd/LZH1F+kShUEtw+jzTOnqVSjs/ZIR8B0LKEiKMj
         JSFUwSPl4HKDHMXCmF07HJJprB/BH3DVIfHTyE1ExVvzqfrfVzy+xavPxwQnoyHvZsPn
         aJK/0plxrMj0lU4VZXBS5kF7RZRPVEfDYd9btldBSLzgLMorYXIn+xM1WH2qo1Pb1Lve
         zRcKgcxeruIVZSz0D9ZLfrGmnCn4Zv0r7Uw2aH+cEtyT6ckDJRTHeerd76nzEmWgYDfM
         kOu9WvhyZ/BzzHrlc0k5feJeKAfbY1RAv0RKuHbTvrpBSOQHsMeFhmqGTLKhmzEzp93V
         eqng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703535799; x=1704140599;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jRNgt5in1rawwI1Ihf7aE8qeFKHIp2oRP3X2LuU5NhE=;
        b=NBg4VFbEBPdiTe72AE5icTnRgWx58UTqgum5pTvxDPgIBResE/bOyRKNH+nCYR0MY5
         gNtrk8iKMzju989sr4s9ImMdrVDNq3DNqVFqkyCbaudmHM/1OUGoBLWM4STPfCLf/YSb
         wrfCaU4Ty+o/ufwO4EUtClx3iQUxharqZdTNny5W9Umyq28XVQP6oGf1wfUbEU2byvyT
         y65knQbYc0z8BB6kTVD6WoZ/yeAV7MrouA9gPr4SWlI9thz5iVohOrKv76Cv9jtQx+Mk
         LMvCvf++iKNilYDyZGd3o0ZQRUvpf8woUq7JHb1VAXCe+BcckbNp3J5GAhNsxbBG/xYV
         qsRg==
X-Gm-Message-State: AOJu0YxSxfCOsEpmogRhDphEAeqLVZ59MDBQ95uvP+ZwLuSsDEUS+siH
	qMfsdPy9NWAK4eHgMhWRvu0C2pNmHgWF7Q==
X-Google-Smtp-Source: AGHT+IGRcrm6u0JMPHJWKCUqhE7w8h2cxF1+5nYlprKEs39W2EOhlnY8braepw2LXGqq5M8LEfR9VQ==
X-Received: by 2002:a05:6808:1649:b0:3bb:89d2:4e13 with SMTP id az9-20020a056808164900b003bb89d24e13mr6579254oib.25.1703535799745;
        Mon, 25 Dec 2023 12:23:19 -0800 (PST)
Received: from oatmeal.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id l17-20020a17090aaa9100b0028be5732f01sm8741246pjq.0.2023.12.25.12.23.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Dec 2023 12:23:19 -0800 (PST)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 2/6] Staging: rtl8192e: Rename variable NumTxOkInPeriod
Date: Mon, 25 Dec 2023 12:23:10 -0800
Message-Id: <20231225202314.31869-3-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231225202314.31869-1-tdavies@darkphysics.net>
References: <20231225202314.31869-1-tdavies@darkphysics.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename variable NumTxOkInPeriod to num_tx_ok_in_period to fix checkpatch
warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c | 16 ++++++++--------
 drivers/staging/rtl8192e/rtllib.h            |  2 +-
 drivers/staging/rtl8192e/rtllib_rx.c         |  2 +-
 drivers/staging/rtl8192e/rtllib_softmac.c    |  2 +-
 4 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index 5107d06a9fd0..b2c56e2099ce 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -972,11 +972,11 @@ static void _rtl92e_watchdog_wq_cb(void *data)
 	}
 	if ((ieee->link_state == MAC80211_LINKED) && (ieee->iw_mode == IW_MODE_INFRA)) {
 		if (ieee->link_detect_info.NumRxOkInPeriod > 100 ||
-		ieee->link_detect_info.NumTxOkInPeriod > 100)
+		ieee->link_detect_info.num_tx_ok_in_period > 100)
 			bBusyTraffic = true;
 
 		if (ieee->link_detect_info.NumRxOkInPeriod > 4000 ||
-		    ieee->link_detect_info.NumTxOkInPeriod > 4000) {
+		    ieee->link_detect_info.num_tx_ok_in_period > 4000) {
 			bHigherBusyTraffic = true;
 			if (ieee->link_detect_info.NumRxOkInPeriod > 5000)
 				bHigherBusyRxTraffic = true;
@@ -985,7 +985,7 @@ static void _rtl92e_watchdog_wq_cb(void *data)
 		}
 
 		if (((ieee->link_detect_info.NumRxUnicastOkInPeriod +
-		    ieee->link_detect_info.NumTxOkInPeriod) > 8) ||
+		    ieee->link_detect_info.num_tx_ok_in_period) > 8) ||
 		    (ieee->link_detect_info.NumRxUnicastOkInPeriod > 2))
 			bEnterPS = false;
 		else
@@ -1004,7 +1004,7 @@ static void _rtl92e_watchdog_wq_cb(void *data)
 	}
 
 	ieee->link_detect_info.NumRxOkInPeriod = 0;
-	ieee->link_detect_info.NumTxOkInPeriod = 0;
+	ieee->link_detect_info.num_tx_ok_in_period = 0;
 	ieee->link_detect_info.NumRxUnicastOkInPeriod = 0;
 	ieee->link_detect_info.bBusyTraffic = bBusyTraffic;
 
@@ -1773,22 +1773,22 @@ static irqreturn_t _rtl92e_irq(int irq, void *netdev)
 		tasklet_schedule(&priv->irq_rx_tasklet);
 
 	if (inta & IMR_BKDOK) {
-		priv->rtllib->link_detect_info.NumTxOkInPeriod++;
+		priv->rtllib->link_detect_info.num_tx_ok_in_period++;
 		_rtl92e_tx_isr(dev, BK_QUEUE);
 	}
 
 	if (inta & IMR_BEDOK) {
-		priv->rtllib->link_detect_info.NumTxOkInPeriod++;
+		priv->rtllib->link_detect_info.num_tx_ok_in_period++;
 		_rtl92e_tx_isr(dev, BE_QUEUE);
 	}
 
 	if (inta & IMR_VIDOK) {
-		priv->rtllib->link_detect_info.NumTxOkInPeriod++;
+		priv->rtllib->link_detect_info.num_tx_ok_in_period++;
 		_rtl92e_tx_isr(dev, VI_QUEUE);
 	}
 
 	if (inta & IMR_VODOK) {
-		priv->rtllib->link_detect_info.NumTxOkInPeriod++;
+		priv->rtllib->link_detect_info.num_tx_ok_in_period++;
 		_rtl92e_tx_isr(dev, VO_QUEUE);
 	}
 
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index bace5dabf860..b56a8e1ce474 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1118,7 +1118,7 @@ struct rt_link_detect {
 	u16				SlotNum;
 	u16				SlotIndex;
 
-	u32				NumTxOkInPeriod;
+	u32				num_tx_ok_in_period;
 	u32				NumRxOkInPeriod;
 	u32				NumRxUnicastOkInPeriod;
 	bool				bBusyTraffic;
diff --git a/drivers/staging/rtl8192e/rtllib_rx.c b/drivers/staging/rtl8192e/rtllib_rx.c
index 196eacc7a768..80e4e5b8de89 100644
--- a/drivers/staging/rtl8192e/rtllib_rx.c
+++ b/drivers/staging/rtl8192e/rtllib_rx.c
@@ -1150,7 +1150,7 @@ static void rtllib_rx_check_leave_lps(struct rtllib_device *ieee, u8 unicast,
 	if (unicast) {
 		if (ieee->link_state == MAC80211_LINKED) {
 			if (((ieee->link_detect_info.NumRxUnicastOkInPeriod +
-			    ieee->link_detect_info.NumTxOkInPeriod) > 8) ||
+			    ieee->link_detect_info.num_tx_ok_in_period) > 8) ||
 			    (ieee->link_detect_info.NumRxUnicastOkInPeriod > 2)) {
 				ieee->leisure_ps_leave(ieee->dev);
 			}
diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index 3bff95a93650..b30533f92b53 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -2076,7 +2076,7 @@ int rtllib_softmac_init(struct rtllib_device *ieee)
 	ieee->link_detect_info.SlotNum = 2;
 	ieee->link_detect_info.NumRecvBcnInPeriod = 0;
 	ieee->link_detect_info.NumRecvDataInPeriod = 0;
-	ieee->link_detect_info.NumTxOkInPeriod = 0;
+	ieee->link_detect_info.num_tx_ok_in_period = 0;
 	ieee->link_detect_info.NumRxOkInPeriod = 0;
 	ieee->link_detect_info.NumRxUnicastOkInPeriod = 0;
 	ieee->bIsAggregateFrame = false;
-- 
2.39.2


