Return-Path: <linux-kernel+bounces-11162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D09581E24A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 21:24:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2001B219FC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 20:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 896BC5467B;
	Mon, 25 Dec 2023 20:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="KgkcUrwv"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C82053E0E
	for <linux-kernel@vger.kernel.org>; Mon, 25 Dec 2023 20:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-58dd3528497so2304762eaf.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Dec 2023 12:23:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1703535801; x=1704140601; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cz8hG91T0FVlhJJL7ezEdRKii6A5vAGbqjcOF3Xr0Yo=;
        b=KgkcUrwvuNi7chmOuJb/3+zFp9nw63Tmy0R59yq/8xa6PgeoBJt6FQ8ZQ0h7IjoMl7
         c1aDfV+8Wr979Y1aZEny6Su2amuaf1NAGHO47gJ+Rb9/1d1oJmm0lFhqRRrBrinCx4ol
         RD9Oqc3CiNiS2xBtO2pZU1DD9TG9mqg2113xNGj9BCQ4EO1Lq0XW7H5Po0Ouww8YqfOV
         79x+X+msr+gKiHb1q6v+xGQXsISahKxRQWrjX7FOd6TcsYuTsVUc5CU5wHy/dKAQVaN9
         D8LLBolmUBVS35Xw4GB7bFLTrv5R59ciSPS/N9SKUpwNMLsKK/n7lk3YSGS9rEKjdGjv
         9S8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703535801; x=1704140601;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cz8hG91T0FVlhJJL7ezEdRKii6A5vAGbqjcOF3Xr0Yo=;
        b=VFYRq+tuF0M4p1KTo1OH1ppwcTdO9ksK/fiUplwx94TV14aLF+6U/ZqMQY2oNTsbE0
         zXR+EKNFB61Qw3sVPPpOPIYsVSra+1pbc034T63b3c6bpZ1dl8Blt9wGvAX5g4Q/qXSN
         BKtHDVURcrclZ8lalCQ+m8MCQOTgLeOP8wrrpO5EOE6jVxLmhBHACfctizHKpVTAso1+
         xMcBB0YJtlJD7JFRMadhoWyxO9FMly8HhvB9LDOeuvSU7+79gmt+ecVbMm43SMpYQPc0
         wSoPsprJJZ6KsmqRH4GW4MGIYbpMpBmFJgn8dx59P/aU7uZ0imeU8t/urUHOzK8Y1d4c
         pohw==
X-Gm-Message-State: AOJu0YyZxgt0cXMObU/8d4X1pfB/4KmIxvQULLcxwB7mPlps8wL3o4Df
	tJouSEZRrpO2O9WfSki8LphB6FJ6Bsx1JA==
X-Google-Smtp-Source: AGHT+IF5aN1SmkVBKdNildtbgH7ZCUqUVEwwO5CvpL/TbdHrjZmOhcf9IEsYuOuFcl+8xBvuLajwrA==
X-Received: by 2002:a05:6358:6f8d:b0:170:e2dc:3e19 with SMTP id s13-20020a0563586f8d00b00170e2dc3e19mr5009259rwn.43.1703535801553;
        Mon, 25 Dec 2023 12:23:21 -0800 (PST)
Received: from oatmeal.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id l17-20020a17090aaa9100b0028be5732f01sm8741246pjq.0.2023.12.25.12.23.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Dec 2023 12:23:20 -0800 (PST)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 4/6] Staging: rtl8192e: Rename function rtllib_EnableNetMonitorMode()
Date: Mon, 25 Dec 2023 12:23:12 -0800
Message-Id: <20231225202314.31869-5-tdavies@darkphysics.net>
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

Rename function rtllib_EnableNetMonitorModeto to rtllib_enable_net_monitor_mode
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtllib.h            | 2 +-
 drivers/staging/rtl8192e/rtllib_softmac.c    | 2 +-
 drivers/staging/rtl8192e/rtllib_softmac_wx.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 42690b3d03bd..a2148bf0cea3 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1677,7 +1677,7 @@ void rtllib_sta_ps_send_pspoll_frame(struct rtllib_device *ieee);
 void rtllib_start_protocol(struct rtllib_device *ieee);
 void rtllib_stop_protocol(struct rtllib_device *ieee);
 
-void rtllib_EnableNetMonitorMode(struct net_device *dev, bool init_state);
+void rtllib_enable_net_monitor_mode(struct net_device *dev, bool init_state);
 void rtllib_disable_net_monitor_mode(struct net_device *dev, bool init_state);
 
 void rtllib_softmac_stop_protocol(struct rtllib_device *ieee);
diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index 9b00fb68f1a4..c0c33ae06908 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -348,7 +348,7 @@ static inline struct sk_buff *rtllib_probe_req(struct rtllib_device *ieee)
 }
 
 /* Enables network monitor mode, all rx packets will be received. */
-void rtllib_EnableNetMonitorMode(struct net_device *dev,
+void rtllib_enable_net_monitor_mode(struct net_device *dev,
 		bool init_state)
 {
 	struct rtllib_device *ieee = netdev_priv_rsl(dev);
diff --git a/drivers/staging/rtl8192e/rtllib_softmac_wx.c b/drivers/staging/rtl8192e/rtllib_softmac_wx.c
index eb331cbb9850..2afa701e5445 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac_wx.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac_wx.c
@@ -266,7 +266,7 @@ int rtllib_wx_set_mode(struct rtllib_device *ieee, struct iw_request_info *a,
 
 	if (wrqu->mode == IW_MODE_MONITOR) {
 		ieee->dev->type = ARPHRD_IEEE80211;
-		rtllib_EnableNetMonitorMode(ieee->dev, false);
+		rtllib_enable_net_monitor_mode(ieee->dev, false);
 	} else {
 		ieee->dev->type = ARPHRD_ETHER;
 		if (ieee->iw_mode == IW_MODE_MONITOR)
-- 
2.39.2


