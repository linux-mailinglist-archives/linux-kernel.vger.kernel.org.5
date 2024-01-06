Return-Path: <linux-kernel+bounces-18492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 53055825E5C
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 06:56:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4962B23255
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 05:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F37D63B6;
	Sat,  6 Jan 2024 05:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="GIMqRW0K"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5913D3FDD
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jan 2024 05:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6dbb7d80df8so217876a34.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jan 2024 21:56:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1704520569; x=1705125369; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=82PpyLqJ1mpDwjtRimrNptwiAlD43VrTcOyeQQStiAY=;
        b=GIMqRW0KpZ13fvkuBxw41LhEs0etu+4ChbLZTVujpSf3YheMzODZgc4nSbV5cZZSIe
         uRpMDHp39g/ZpAMC570Jo+nx0gpg/Wk0aQW51y4wvw+ym5XA7x3OACO2FtSHpH5NacSy
         w3NMAqI3eGHbM0oGpDSuKC+n/GSn02ZBuAakhCNG+2HBXf9pBI2Ya1KPiBwKqrlWm6hy
         DBdxpf2PnJzd9u/KF0TxlM5pTUgy6Qe+5A9R9KOUOLPU36zl4svVF5f1FqllZqTQy7OI
         BpNmAz1+FbAh41LUNfHCXXxP6JcMy64D0x6nsfCxDtDf16FodEohedHT9vhfN+BqA5d7
         7dLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704520569; x=1705125369;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=82PpyLqJ1mpDwjtRimrNptwiAlD43VrTcOyeQQStiAY=;
        b=R/eO0sSowq9+uwnzbTk11licje4PI4tHIGP+bkNHgWYx3E1/b444651hw1JUs1M7ae
         nRc6T1ZnPSFK3naxGCmbGi6hb+bDOZ4p4vu/d2ZvnjtQICG8ByHbYPRwQ4LJ12viYMMi
         eVo4VmLb7jWErrMVAyXq0XVma08spIIUjdj312a2Guq64kRwRmLu+EmdM4YdHZP+woVb
         uBMglBUXYBPImjRXq+AxXKeBIKAWQooNjkIo4jwejUOY8hN5MqwRxTE6agYSS3wceqpH
         qD+Bn/+oPGs1x2te3TALiA3zFQwPEWMOdANY0qoXqrHpYf7qfTLHY5p90JGmOOkxO0tQ
         wN2A==
X-Gm-Message-State: AOJu0YwFZhim3S8A0cVwJO9kDyTd+oDqsPHYRJrTOk7qEZzV4OCgAnaM
	loqin0PCe87CkCLh8okNCK+KIEfobzp1OvTEgt6IgBUW6VQ=
X-Google-Smtp-Source: AGHT+IGVvqzK5R7+SlsTP7YZE7yeWifVQoKLQMjCYMqi6JUnF5016E6UDdoWHcsp6m9+iw/Ugce8vA==
X-Received: by 2002:a05:6808:188c:b0:3bc:8f23:19de with SMTP id bi12-20020a056808188c00b003bc8f2319demr743910oib.96.1704520569218;
        Fri, 05 Jan 2024 21:56:09 -0800 (PST)
Received: from oatmeal.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id y29-20020a056a00181d00b006d99d986624sm2280873pfa.151.2024.01.05.21.56.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 21:56:08 -0800 (PST)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 02/21] Staging: rtl8192e: Rename variable SlotIndex
Date: Fri,  5 Jan 2024 21:55:37 -0800
Message-Id: <20240106055556.430948-3-tdavies@darkphysics.net>
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

Rename variable SlotIndex to slot_index to fix checkpatch
warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c | 8 ++++----
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c   | 8 ++++----
 drivers/staging/rtl8192e/rtllib.h              | 2 +-
 drivers/staging/rtl8192e/rtllib_softmac.c      | 2 +-
 4 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
index c7a2eae2fdb9..9b9d95ba06df 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
@@ -1852,7 +1852,7 @@ bool rtl92e_is_rx_stuck(struct net_device *dev)
 	u16		  RegRxCounter = rtl92e_readw(dev, 0x130);
 	bool		  bStuck = false;
 	static u8	  rx_chk_cnt;
-	u32		SlotIndex = 0, TotalRxStuckCount = 0;
+	u32		slot_index = 0, TotalRxStuckCount = 0;
 	u8		i;
 	u8		SilentResetRxSoltNum = 4;
 
@@ -1882,10 +1882,10 @@ bool rtl92e_is_rx_stuck(struct net_device *dev)
 	}
 
 
-	SlotIndex = (priv->silent_reset_rx_slot_index++) % SilentResetRxSoltNum;
+	slot_index = (priv->silent_reset_rx_slot_index++) % SilentResetRxSoltNum;
 
 	if (priv->rx_ctr == RegRxCounter) {
-		priv->silent_reset_rx_stuck_event[SlotIndex] = 1;
+		priv->silent_reset_rx_stuck_event[slot_index] = 1;
 
 		for (i = 0; i < SilentResetRxSoltNum; i++)
 			TotalRxStuckCount += priv->silent_reset_rx_stuck_event[i];
@@ -1897,7 +1897,7 @@ bool rtl92e_is_rx_stuck(struct net_device *dev)
 					 priv->silent_reset_rx_stuck_event[i];
 		}
 	} else {
-		priv->silent_reset_rx_stuck_event[SlotIndex] = 0;
+		priv->silent_reset_rx_stuck_event[slot_index] = 0;
 	}
 
 	priv->rx_ctr = RegRxCounter;
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index 6815d18a7919..67938e212db1 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -915,17 +915,17 @@ static void _rtl92e_if_check_reset(struct net_device *dev)
 static void _rtl92e_update_rxcounts(struct r8192_priv *priv, u32 *TotalRxBcnNum,
 				    u32 *TotalRxDataNum)
 {
-	u16	SlotIndex;
+	u16	slot_index;
 	u8	i;
 
 	*TotalRxBcnNum = 0;
 	*TotalRxDataNum = 0;
 
-	SlotIndex = (priv->rtllib->link_detect_info.SlotIndex++) %
+	slot_index = (priv->rtllib->link_detect_info.slot_index++) %
 			(priv->rtllib->link_detect_info.SlotNum);
-	priv->rtllib->link_detect_info.RxBcnNum[SlotIndex] =
+	priv->rtllib->link_detect_info.RxBcnNum[slot_index] =
 			priv->rtllib->link_detect_info.NumRecvBcnInPeriod;
-	priv->rtllib->link_detect_info.RxDataNum[SlotIndex] =
+	priv->rtllib->link_detect_info.RxDataNum[slot_index] =
 			priv->rtllib->link_detect_info.NumRecvDataInPeriod;
 	for (i = 0; i < priv->rtllib->link_detect_info.SlotNum; i++) {
 		*TotalRxBcnNum += priv->rtllib->link_detect_info.RxBcnNum[i];
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 7b39a1987fdd..37bcd968a542 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1116,7 +1116,7 @@ struct rt_link_detect {
 	u32				RxBcnNum[RT_MAX_LD_SLOT_NUM];
 	u32				RxDataNum[RT_MAX_LD_SLOT_NUM];
 	u16				SlotNum;
-	u16				SlotIndex;
+	u16				slot_index;
 
 	u32				num_tx_ok_in_period;
 	u32				num_rx_ok_in_period;
diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index 520b90abcde7..1d490704389e 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -2072,7 +2072,7 @@ int rtllib_softmac_init(struct rtllib_device *ieee)
 	for (i = 0; i < 5; i++)
 		ieee->seq_ctrl[i] = 0;
 
-	ieee->link_detect_info.SlotIndex = 0;
+	ieee->link_detect_info.slot_index = 0;
 	ieee->link_detect_info.SlotNum = 2;
 	ieee->link_detect_info.NumRecvBcnInPeriod = 0;
 	ieee->link_detect_info.NumRecvDataInPeriod = 0;
-- 
2.39.2


