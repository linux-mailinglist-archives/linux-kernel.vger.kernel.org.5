Return-Path: <linux-kernel+bounces-18499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 990AB825E63
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 06:58:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9E1EB23400
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 05:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3F4AC12F;
	Sat,  6 Jan 2024 05:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="iWk27wZP"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85848470
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jan 2024 05:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6d99980b2e0so247927b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jan 2024 21:56:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1704520575; x=1705125375; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3ZdkcjJNenR1FH/tfOzFNMs+x8peXIRAxVD9iNNQRUg=;
        b=iWk27wZP7zmkAyCcun5hyk64ZpyyJNoGeahtAqyifKWOQd3TvI772oYIRvd4D9vmMT
         Bsh70LTHPYR6Wq181v/8KWTU3XPjtxLKdmikx+eEu2+xY405IZdhvyRcSD6A0/OsnTbR
         BAewDh3ZxE9xrDqSC0omSQGvriGIifxQ8NT8z4grBDvVJxHn/h9AhyVxmnvt4qG2Vbu2
         uS7Dx2ZPAUpw96KngHrIrV5SEqGGyKGn1MnfNhAWm5kBRUvWt3rafa437t0dkPrVtUQN
         nkDJXLs1wIO08UZlYL73pguGjgXZhoJHmBLI2ysOkZR/v8XpqWdi9HK+emIoPQiAqhhC
         Mmcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704520575; x=1705125375;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3ZdkcjJNenR1FH/tfOzFNMs+x8peXIRAxVD9iNNQRUg=;
        b=LJrTyn4Obrb6h7luUAa8fi1JKJ1cGX+NgYagIzFOlYOSfJuwQvSK2FTlr65189ieaB
         afuMNuI3FhA3kXl7kyLFYuT6lxeEgQWqLW7szFgaDlRwx+Dq5DKrvyzlygltQo6RM/zK
         a263Q4yRtzT0nT5lQzafeiGmZ42lBO1fdorGnGuMqMCKNtDlZ9BLNyQ4zc8sz+8/mS4w
         xnKkItjnPuYTE3ZUXVX+jj2ZUEbZSShbbTbwaBCqSpSsex1strq/SKEsL59AMFg3v34O
         XIR2cAXaI1y/0/iBpK2LtG263sIk8icxVwYvq/kmBmf5QxqdEmcmme52dL9qvTzLJ1gk
         fkpw==
X-Gm-Message-State: AOJu0YxvVEZzpBWtT20TcY7/brTUxKdzfkwwP9t9C28+qz0wK4+v9MI1
	2YPTzupokPGYOel0ggDAtNwu3IJrS8GSTQ==
X-Google-Smtp-Source: AGHT+IFfCeG8c6aNIEvPtknCTwQQ6oy//2eRx0XlMvPPkvigwwIeNc3+k5j97KQqi/+aNXJWKdhB+A==
X-Received: by 2002:a05:6a21:2797:b0:199:1d4:1009 with SMTP id rn23-20020a056a21279700b0019901d41009mr443113pzb.95.1704520575287;
        Fri, 05 Jan 2024 21:56:15 -0800 (PST)
Received: from oatmeal.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id y29-20020a056a00181d00b006d99d986624sm2280873pfa.151.2024.01.05.21.56.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 21:56:15 -0800 (PST)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 09/21] Staging: rtl8192e: Rename function rtllib_MgntDisconnect()
Date: Fri,  5 Jan 2024 21:55:44 -0800
Message-Id: <20240106055556.430948-10-tdavies@darkphysics.net>
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

Rename function rtllib_MgntDisconnect to rtllib_mgnt_disconnect fix checkpatch
warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c | 2 +-
 drivers/staging/rtl8192e/rtllib.h            | 2 +-
 drivers/staging/rtl8192e/rtllib_softmac.c    | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index 16ce207f5bd7..ac72f7dcd5c1 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -172,7 +172,7 @@ bool rtl92e_set_rf_state(struct net_device *dev,
 					priv->blinked_ingpio = true;
 				else
 					priv->blinked_ingpio = false;
-				rtllib_MgntDisconnect(priv->rtllib,
+				rtllib_mgnt_disconnect(priv->rtllib,
 						      WLAN_REASON_DISASSOC_STA_HAS_LEFT);
 			}
 		}
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index d127528e7932..35c66ecd20e6 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1805,7 +1805,7 @@ static inline const char *escape_essid(const char *essid, u8 essid_len)
 }
 
 /* fun with the built-in rtllib stack... */
-bool rtllib_MgntDisconnect(struct rtllib_device *rtllib, u8 asRsn);
+bool rtllib_mgnt_disconnect(struct rtllib_device *rtllib, u8 asRsn);
 
 /* For the function is more related to hardware setting, it's better to use the
  * ieee handler to refer to it.
diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index 40d6ae15b246..3d7fad28c414 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -2278,7 +2278,7 @@ static void rtllib_mgnt_disconnect_ap(struct rtllib_device *rtllib, u8 asRsn)
 	rtllib->link_state = MAC80211_NOLINK;
 }
 
-bool rtllib_MgntDisconnect(struct rtllib_device *rtllib, u8 asRsn)
+bool rtllib_mgnt_disconnect(struct rtllib_device *rtllib, u8 asRsn)
 {
 	if (rtllib->ps != RTLLIB_PS_DISABLED)
 		rtllib->sta_wake_up(rtllib->dev);
@@ -2290,7 +2290,7 @@ bool rtllib_MgntDisconnect(struct rtllib_device *rtllib, u8 asRsn)
 
 	return true;
 }
-EXPORT_SYMBOL(rtllib_MgntDisconnect);
+EXPORT_SYMBOL(rtllib_mgnt_disconnect);
 
 void notify_wx_assoc_event(struct rtllib_device *ieee)
 {
-- 
2.39.2


