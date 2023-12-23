Return-Path: <linux-kernel+bounces-10202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C89781D128
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 03:04:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 058EE285A60
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 02:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4929728370;
	Sat, 23 Dec 2023 02:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="LqWMG9lR"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598222557D
	for <linux-kernel@vger.kernel.org>; Sat, 23 Dec 2023 02:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-594019698b8so1656877eaf.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 18:00:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1703296802; x=1703901602; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5cMw9uPLWTNNtgp8qyV233zk0hgUTq1NsfnpGqgse+s=;
        b=LqWMG9lRSLj+TPwxA6IxTDrqtLcXes08c4yvphzF1wiSSsKTu48x0GjjtdBC44RCc7
         cqEtNbTUNhK7/9WCBQuJpWRoBKe+NSVi1d48DYPsi1Dd41UQJJLt/oR+y9Ng5ccht/53
         +7IOEgjYj0lzwoi78Sov0Mii0gel0u1636U4Qr/kuOdbslUJ9k1adpYQBUFYpk7mjNDY
         Y6uT9HanUxPa3m/5am18JFHzi5wlEH2KW1VXvMbf4nUD7kuHxKOmi5yBLSLwcqVWQDRL
         +5benV4E7xy1eEfD6MVm6Y1KHANlal2X5HPT5w/S+IlZYJw7HASJH23nALOFVyPWSQch
         bS/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703296802; x=1703901602;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5cMw9uPLWTNNtgp8qyV233zk0hgUTq1NsfnpGqgse+s=;
        b=oDQLuo9+CAwrUHHcBjGPqbz8cty1H6h/ACvIFsIIDLScGfGQ/L0Ubx2hRiDfMbNY1X
         uhGCawNV0Zp2HCfg4oubwlzVfuXQXwmkNmNHT6QfjeZlk3MD+qxgLgH2Q6/ejPmz0Rhp
         p20t37jPKZ0v57n/rCh7m7VU2XIIKEmW7xtZFOFN0SANPMkeaYHbhVCTrchbJE9zM9pq
         wsFgl3NTddWDKDr3hT1Mni/P2uSX+Blg2MRXOZAZT4tv2VmV/cojwyqgKMAiO9yOFWWL
         Z1vm7T5QtJfjjY7oSrUmKt5vlcj1ynUvW0giIg+HqP0qxV/JAfR14WA1/+NfldyCsZNK
         RnFQ==
X-Gm-Message-State: AOJu0Yxly2DuovRtaWnkV4b0C/dKPS2gsODDdDPiMalL/PWXmrdBUFEA
	FRTA37qguI6NoLvWJSnfwk7R/RC0jD4wUw==
X-Google-Smtp-Source: AGHT+IFcCtJelhgjn5S5sHibmlozgH5RuhGV56MxhtIKmbB1P2bMSt992tFWN5qJSkXO56IjxQs4wA==
X-Received: by 2002:a05:6358:52c2:b0:16d:edaa:921c with SMTP id z2-20020a05635852c200b0016dedaa921cmr2205422rwz.12.1703296802301;
        Fri, 22 Dec 2023 18:00:02 -0800 (PST)
Received: from oatmeal.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id kg15-20020a170903060f00b001d3edef115dsm4106546plb.20.2023.12.22.18.00.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 18:00:01 -0800 (PST)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 19/20] Staging: rtl8192e: Rename variable bInitState
Date: Fri, 22 Dec 2023 17:59:41 -0800
Message-Id: <20231223015942.418263-20-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231223015942.418263-1-tdavies@darkphysics.net>
References: <20231223015942.418263-1-tdavies@darkphysics.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename variable bInitState to init_state to fix checkpatch
warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtllib.h         | 4 ++--
 drivers/staging/rtl8192e/rtllib_softmac.c | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 9fd8a7199ee0..0158b5595c3c 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1677,8 +1677,8 @@ void rtllib_sta_ps_send_pspoll_frame(struct rtllib_device *ieee);
 void rtllib_start_protocol(struct rtllib_device *ieee);
 void rtllib_stop_protocol(struct rtllib_device *ieee);
 
-void rtllib_EnableNetMonitorMode(struct net_device *dev, bool bInitState);
-void rtllib_DisableNetMonitorMode(struct net_device *dev, bool bInitState);
+void rtllib_EnableNetMonitorMode(struct net_device *dev, bool init_state);
+void rtllib_DisableNetMonitorMode(struct net_device *dev, bool init_state);
 
 void rtllib_softmac_stop_protocol(struct rtllib_device *ieee);
 void rtllib_softmac_start_protocol(struct rtllib_device *ieee);
diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index e4e1a84932ba..ec7bf27820c6 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -349,26 +349,26 @@ static inline struct sk_buff *rtllib_probe_req(struct rtllib_device *ieee)
 
 /* Enables network monitor mode, all rx packets will be received. */
 void rtllib_EnableNetMonitorMode(struct net_device *dev,
-		bool bInitState)
+		bool init_state)
 {
 	struct rtllib_device *ieee = netdev_priv_rsl(dev);
 
 	netdev_info(dev, "========>Enter Monitor Mode\n");
 
-	ieee->AllowAllDestAddrHandler(dev, true, !bInitState);
+	ieee->AllowAllDestAddrHandler(dev, true, !init_state);
 }
 
 /* Disables network monitor mode. Only packets destinated to
  * us will be received.
  */
 void rtllib_DisableNetMonitorMode(struct net_device *dev,
-		bool bInitState)
+		bool init_state)
 {
 	struct rtllib_device *ieee = netdev_priv_rsl(dev);
 
 	netdev_info(dev, "========>Exit Monitor Mode\n");
 
-	ieee->AllowAllDestAddrHandler(dev, false, !bInitState);
+	ieee->AllowAllDestAddrHandler(dev, false, !init_state);
 }
 
 static void rtllib_send_probe(struct rtllib_device *ieee)
-- 
2.39.2


