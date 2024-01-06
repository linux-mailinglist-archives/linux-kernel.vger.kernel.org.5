Return-Path: <linux-kernel+bounces-18502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC85F825E66
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 06:59:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24C2FB23852
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 05:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B25C7F508;
	Sat,  6 Jan 2024 05:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="cMTUidBi"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC302D2E6
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jan 2024 05:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6d9b2c8e2a4so818892b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jan 2024 21:56:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1704520578; x=1705125378; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DDLqPzRV8MFmThia4xvg1AlPJciUw1HjiTfB27D63xk=;
        b=cMTUidBiQdrhHIwmnbT9E5mDSW8VdV1of7x9c7GTf+AOOMRlXSZfNQEsf+rNuNo6s2
         IxldZ+lG8sO3ya8EmuVC2958TCSUdY0hqFUrPS+4UDqoLfyF7ETa3/T3irBRZDyR5vY6
         NXSMYY6wPfH+0xLtTXPFfqEwAbiErDGC2ElA9KwEgy7zjSfbkgALwFVchkC+T4HghYe4
         5EORYufPxnrPeE2hj4d7M6ml3tXZGvCm4I2ZGZ9RTsmolUMC5GAd+PXet0h6XBHInZrB
         NnES/fwTfORmdFS3zLi1204OsW7hEDCX8Ep+RydIA+W1DlHEJsSg/G3w7Upb/M/Pg68q
         ltlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704520578; x=1705125378;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DDLqPzRV8MFmThia4xvg1AlPJciUw1HjiTfB27D63xk=;
        b=NdzL/fCTcpknMEA7tlwUrbrFAP123J5GqTkBUxTVwEzq3+YPXFUTQ8YrwC4quorFU1
         mZrVmd80k6FvjR79r1IJBFzosQcl2jGObqvM39KnrphJtp6pXuI4daOlTdvyY45LJTW1
         fft01C/eQ6j7DybvozH7OgEQ8e9xOi+AHNEhnccGpMRR4UXU/Uzvh6SarVHDxQCx0ZoL
         ivMr6wzD8qMThTctOB6TeBF5ZqsFN536Kec9eT+vmZXM3aLUl5tbtTw//cnwsOkveyLg
         uo0nkIisDwyD9WYjzg9UrjJRW6G9tH9dasx+tYNQLZNZ5JjPA6Bo9HX1lVKWvcMJKJQ/
         HmkA==
X-Gm-Message-State: AOJu0YxTraro3rqgBUXq/iBVIBtdu0XejPKYbL8BaykJ6tBhhdULpTfc
	kacM80OrgRE3DoHGYNs9NoN5xkWnRYTlL4Toq2ISPXyJ/o8=
X-Google-Smtp-Source: AGHT+IHBJAtvpfpBtwgm8cSeQRkSs9MRlzKqWSB0Hj0JDEq5bNDMfMeA9/VnJQJuOX4PBIKzGJHbQg==
X-Received: by 2002:a05:6a20:729d:b0:199:45bb:3ae8 with SMTP id o29-20020a056a20729d00b0019945bb3ae8mr855234pzk.25.1704520578183;
        Fri, 05 Jan 2024 21:56:18 -0800 (PST)
Received: from oatmeal.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id y29-20020a056a00181d00b006d99d986624sm2280873pfa.151.2024.01.05.21.56.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 21:56:17 -0800 (PST)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 12/21] Staging: rtl8192e: Rename variable NumRxUnicastOkInPeriod
Date: Fri,  5 Jan 2024 21:55:47 -0800
Message-Id: <20240106055556.430948-13-tdavies@darkphysics.net>
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

Rename variable NumRxUnicastOkInPeriod to num_rx_unicast_ok_in_period
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c | 6 +++---
 drivers/staging/rtl8192e/rtllib.h            | 2 +-
 drivers/staging/rtl8192e/rtllib_rx.c         | 6 +++---
 drivers/staging/rtl8192e/rtllib_softmac.c    | 2 +-
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index ac72f7dcd5c1..34e30b03c545 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -984,9 +984,9 @@ static void _rtl92e_watchdog_wq_cb(void *data)
 				bHigherBusyRxTraffic = false;
 		}
 
-		if (((ieee->link_detect_info.NumRxUnicastOkInPeriod +
+		if (((ieee->link_detect_info.num_rx_unicast_ok_in_period +
 		    ieee->link_detect_info.num_tx_ok_in_period) > 8) ||
-		    (ieee->link_detect_info.NumRxUnicastOkInPeriod > 2))
+		    (ieee->link_detect_info.num_rx_unicast_ok_in_period > 2))
 			bEnterPS = false;
 		else
 			bEnterPS = true;
@@ -1005,7 +1005,7 @@ static void _rtl92e_watchdog_wq_cb(void *data)
 
 	ieee->link_detect_info.num_rx_ok_in_period = 0;
 	ieee->link_detect_info.num_tx_ok_in_period = 0;
-	ieee->link_detect_info.NumRxUnicastOkInPeriod = 0;
+	ieee->link_detect_info.num_rx_unicast_ok_in_period = 0;
 	ieee->link_detect_info.busy_traffic = busy_traffic;
 
 	ieee->link_detect_info.bHigherBusyTraffic = bHigherBusyTraffic;
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index f379819287b4..5cab1aa6455a 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1120,7 +1120,7 @@ struct rt_link_detect {
 
 	u32				num_tx_ok_in_period;
 	u32				num_rx_ok_in_period;
-	u32				NumRxUnicastOkInPeriod;
+	u32				num_rx_unicast_ok_in_period;
 	bool				busy_traffic;
 	bool				bHigherBusyTraffic;
 	bool				bHigherBusyRxTraffic;
diff --git a/drivers/staging/rtl8192e/rtllib_rx.c b/drivers/staging/rtl8192e/rtllib_rx.c
index 4df20f4d6bf9..f777febcfe3b 100644
--- a/drivers/staging/rtl8192e/rtllib_rx.c
+++ b/drivers/staging/rtl8192e/rtllib_rx.c
@@ -1149,9 +1149,9 @@ static void rtllib_rx_check_leave_lps(struct rtllib_device *ieee, u8 unicast,
 {
 	if (unicast) {
 		if (ieee->link_state == MAC80211_LINKED) {
-			if (((ieee->link_detect_info.NumRxUnicastOkInPeriod +
+			if (((ieee->link_detect_info.num_rx_unicast_ok_in_period +
 			    ieee->link_detect_info.num_tx_ok_in_period) > 8) ||
-			    (ieee->link_detect_info.NumRxUnicastOkInPeriod > 2)) {
+			    (ieee->link_detect_info.num_rx_unicast_ok_in_period > 2)) {
 				ieee->leisure_ps_leave(ieee->dev);
 			}
 		}
@@ -1363,7 +1363,7 @@ static int rtllib_rx_InfraAdhoc(struct rtllib_device *ieee, struct sk_buff *skb,
 	else
 		nr_subframes = 1;
 	if (unicast)
-		ieee->link_detect_info.NumRxUnicastOkInPeriod += nr_subframes;
+		ieee->link_detect_info.num_rx_unicast_ok_in_period += nr_subframes;
 	rtllib_rx_check_leave_lps(ieee, unicast, nr_subframes);
 
 	/* Indicate packets to upper layer or Rx Reorder */
diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index 8fb69fa09cc2..9a9b8f63218b 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -2078,7 +2078,7 @@ int rtllib_softmac_init(struct rtllib_device *ieee)
 	ieee->link_detect_info.NumRecvDataInPeriod = 0;
 	ieee->link_detect_info.num_tx_ok_in_period = 0;
 	ieee->link_detect_info.num_rx_ok_in_period = 0;
-	ieee->link_detect_info.NumRxUnicastOkInPeriod = 0;
+	ieee->link_detect_info.num_rx_unicast_ok_in_period = 0;
 	ieee->is_aggregate_frame = false;
 	ieee->assoc_id = 0;
 	ieee->queue_stop = 0;
-- 
2.39.2


