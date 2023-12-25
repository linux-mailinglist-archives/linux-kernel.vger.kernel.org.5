Return-Path: <linux-kernel+bounces-11161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 913D381E249
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 21:23:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C34631C2100D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 20:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F23EC53E20;
	Mon, 25 Dec 2023 20:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="FPBI4vvD"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC845380B
	for <linux-kernel@vger.kernel.org>; Mon, 25 Dec 2023 20:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-28bc870c540so2995138a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Dec 2023 12:23:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1703535800; x=1704140600; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x0BQwgGlchI9j4vF66gvl0jTFAruxLJpJhtJa5sgnO0=;
        b=FPBI4vvDVib46QIuUEjoZhl25+FCjr09RSWiFtgIKIpQm3NkGxZOY4aYdX0eMn4Udx
         BueWADSU9r3PVh8YUKr23za2De8eZLO8/3YMJMh8eXK96EH1b0AnYZfdIrzFkLjmYO30
         ZLPZw1UaEPM9woOQt/oCzZS0bz7rvJgpOI0T/iFs2ADeQiWwn2/jWEFCtruSRSqrzZHu
         Wk0WsHsRKn5zspF444GJeHinBk0cKIkLcrW7dRjLtgwq2BXCxyDXUlsjs1pSqv44D79h
         1pPF9YmhxhOjEbT3b0XD9FBBXDbnauLtPcHnolRIsCS7bh/0bfJcIcqaXtya8arabRUp
         2JOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703535800; x=1704140600;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x0BQwgGlchI9j4vF66gvl0jTFAruxLJpJhtJa5sgnO0=;
        b=GFVK16VfJZVk/554ZhF6RNzdNQsBEjYw6hBGjRL5VFtfAe5eOfe9xM1hVf70KDAXNR
         gm86MPATVrADihvi/hiFNUsjMrZPTc3lgr+VHgCsvpQokdEzeRMVn2NAa1gd57s0PlD8
         yPMUUZ5oQ0JXNIqL9F8i/Scu4RUhd09EE02spP+0QG0CcvRvLmkw8/Gn/ontQgQrRZLy
         c/3n2XaxCFm37RyYx5QsEJMfBw72V5ZLSrSxbahMirzw4jIhuhx3y794jlhATaKde99s
         KnX7+izp+FVB/fnj9DiHnf1GpxoQk91vGXI3OKuJzAybsWTCzwNP3z88ci2/J5NibfBU
         8VrQ==
X-Gm-Message-State: AOJu0YwdFCtlKanH9SfwfuQUYolXs9uIrwB6x4YNnuumnaOLAvlYuYFD
	/RpkvHSAALJyFxi/xCEk/ohsaKDxNPlsmg==
X-Google-Smtp-Source: AGHT+IHBzgPGDtKPtbfiYMnilahBwP5Whg/tOnaxsAejKLrfiqFXHpL0mzLUcz9uR5GPzjGe/j16kA==
X-Received: by 2002:a17:90a:7ac7:b0:286:d6fb:3d4f with SMTP id b7-20020a17090a7ac700b00286d6fb3d4fmr3054422pjl.24.1703535800508;
        Mon, 25 Dec 2023 12:23:20 -0800 (PST)
Received: from oatmeal.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id l17-20020a17090aaa9100b0028be5732f01sm8741246pjq.0.2023.12.25.12.23.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Dec 2023 12:23:20 -0800 (PST)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 3/6] Staging: rtl8192e: Rename variable NumRxOkInPeriod
Date: Mon, 25 Dec 2023 12:23:11 -0800
Message-Id: <20231225202314.31869-4-tdavies@darkphysics.net>
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

Rename variable NumRxOkInPeriod to num_rx_ok_in_period to fix checkpatch
warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c | 8 ++++----
 drivers/staging/rtl8192e/rtllib.h            | 2 +-
 drivers/staging/rtl8192e/rtllib_rx.c         | 2 +-
 drivers/staging/rtl8192e/rtllib_softmac.c    | 2 +-
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index b2c56e2099ce..6815d18a7919 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -971,14 +971,14 @@ static void _rtl92e_watchdog_wq_cb(void *data)
 		}
 	}
 	if ((ieee->link_state == MAC80211_LINKED) && (ieee->iw_mode == IW_MODE_INFRA)) {
-		if (ieee->link_detect_info.NumRxOkInPeriod > 100 ||
+		if (ieee->link_detect_info.num_rx_ok_in_period > 100 ||
 		ieee->link_detect_info.num_tx_ok_in_period > 100)
 			bBusyTraffic = true;
 
-		if (ieee->link_detect_info.NumRxOkInPeriod > 4000 ||
+		if (ieee->link_detect_info.num_rx_ok_in_period > 4000 ||
 		    ieee->link_detect_info.num_tx_ok_in_period > 4000) {
 			bHigherBusyTraffic = true;
-			if (ieee->link_detect_info.NumRxOkInPeriod > 5000)
+			if (ieee->link_detect_info.num_rx_ok_in_period > 5000)
 				bHigherBusyRxTraffic = true;
 			else
 				bHigherBusyRxTraffic = false;
@@ -1003,7 +1003,7 @@ static void _rtl92e_watchdog_wq_cb(void *data)
 		rtl92e_leisure_ps_leave(dev);
 	}
 
-	ieee->link_detect_info.NumRxOkInPeriod = 0;
+	ieee->link_detect_info.num_rx_ok_in_period = 0;
 	ieee->link_detect_info.num_tx_ok_in_period = 0;
 	ieee->link_detect_info.NumRxUnicastOkInPeriod = 0;
 	ieee->link_detect_info.bBusyTraffic = bBusyTraffic;
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index b56a8e1ce474..42690b3d03bd 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1119,7 +1119,7 @@ struct rt_link_detect {
 	u16				SlotIndex;
 
 	u32				num_tx_ok_in_period;
-	u32				NumRxOkInPeriod;
+	u32				num_rx_ok_in_period;
 	u32				NumRxUnicastOkInPeriod;
 	bool				bBusyTraffic;
 	bool				bHigherBusyTraffic;
diff --git a/drivers/staging/rtl8192e/rtllib_rx.c b/drivers/staging/rtl8192e/rtllib_rx.c
index 80e4e5b8de89..d346380fd1d1 100644
--- a/drivers/staging/rtl8192e/rtllib_rx.c
+++ b/drivers/staging/rtl8192e/rtllib_rx.c
@@ -1285,7 +1285,7 @@ static int rtllib_rx_InfraAdhoc(struct rtllib_device *ieee, struct sk_buff *skb,
 
 	/* Update statstics for AP roaming */
 	ieee->link_detect_info.NumRecvDataInPeriod++;
-	ieee->link_detect_info.NumRxOkInPeriod++;
+	ieee->link_detect_info.num_rx_ok_in_period++;
 
 	/* Data frame - extract src/dst addresses */
 	rtllib_rx_extract_addr(ieee, hdr, dst, src, bssid);
diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index b30533f92b53..9b00fb68f1a4 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -2077,7 +2077,7 @@ int rtllib_softmac_init(struct rtllib_device *ieee)
 	ieee->link_detect_info.NumRecvBcnInPeriod = 0;
 	ieee->link_detect_info.NumRecvDataInPeriod = 0;
 	ieee->link_detect_info.num_tx_ok_in_period = 0;
-	ieee->link_detect_info.NumRxOkInPeriod = 0;
+	ieee->link_detect_info.num_rx_ok_in_period = 0;
 	ieee->link_detect_info.NumRxUnicastOkInPeriod = 0;
 	ieee->bIsAggregateFrame = false;
 	ieee->assoc_id = 0;
-- 
2.39.2


