Return-Path: <linux-kernel+bounces-80502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DF1D8668F5
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 05:01:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54B321F247B7
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 04:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0822C364A5;
	Mon, 26 Feb 2024 03:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="a0Shknek"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D971F22EF8
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 03:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708919807; cv=none; b=REC8qh0qnbWlqvfx1zoxhpdYx5UgzRSsN+M8cSCOXuv3vm5OCcxjejLUFd3UVRG2tmmsW3RyQPVnxWzhWF4uxpSSyanzOEUtoTeN2rzW7EyKql/s6LL/C1ftRCIpoVOb7jcUubCnks44tB2WOdHp3v9bVvmWVG0h2ii7QhBA0nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708919807; c=relaxed/simple;
	bh=bb2b3oSMK0DNg02UK1+jjSWnIX/epnr8WF+BqHgHszA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fcFHTrCjLPNXm2QoFPQGC/UfNn4KGG5EDCf2YoxTB5GI0rOZS+NdLZfc7N3Eju/XcR1s5q9BgEsWeZF3bSePLFwKcpyNH1IM7h4ZLJMFs6RvFKPKfGC2kL+NSxcBoV8RWaaUWwQptA309+e4g2EzPw0iYbRBQldjh5DapSVWgdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=a0Shknek; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1dc98892850so6624355ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 19:56:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1708919805; x=1709524605; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mLI/FHiNfb+I57NxVeZ7c/ye1Dp4Vh2QKadh0HWO85c=;
        b=a0ShknekrsjBjsLcQWpSRafsZ2JChVPced3ZNOPH5I+69i0+aquNj+z2ko1WYNZiT2
         IANJxJ1t8Ok65oKwoBF2sd2CMHY8qdFnsdlg5aTBe8NjcmbGB191o9h75Z6EXfij7DZN
         KDyiJA0+8Gq+zyKG/8/xCDh0XQlNm7Nv0HBJC31lNU+e6Vm/OKofSySfaxxAeGZDsBV3
         X2lwQz0XE7qhNsoPmThmsTLcAumfEfN8fGGzHguaV0zVGTGgiPK6riPaaMazsK4KntAr
         GwmFm6VHS1lk9riysgpp+Jc7QL5UJfDYoaq3nTMbFmHFzTlzktOQCp3Npx/LezhuUNDG
         iE/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708919805; x=1709524605;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mLI/FHiNfb+I57NxVeZ7c/ye1Dp4Vh2QKadh0HWO85c=;
        b=JZLdsAeI0oBbbOk8RL86rxBt5uBf+Huhb22CYn88o7iTk4wGpgEI2rmmreF/mA+J5O
         Ni0u0mEd9lkNBgbf1fccWTlVSo0V6EZc0fE/C4+wnWWKfatTumOdpo0vc7tOOraEg9yj
         i71QAEVcyL0D9cPfInISzmqUPi26NuJSAkLV0f0G1w4aSxiDAx/JhT9ZLSu3xG367iRn
         1JyF/57rPeNLxsI7spDOjcku4w/XtQhW2kFH49rYy3nelTTD1T3a4NraqUAlGQChjafb
         M8zurUfHi+0VpxjcjpGN3QLCAurbc7OoJgb4MTcU4xSuL9Mkmav6mWLp0ccLyuo9BIMN
         O/vQ==
X-Forwarded-Encrypted: i=1; AJvYcCVLog0Z0ejBQHvmoY4AQIbGR4E1tV5bS5BjSz0G4aI1tzzkOVX0Ep7hPam2FEHV9Z1PKhatWMIv8duhzoFYNBOxtVEN0gSw2Ww+sCdN
X-Gm-Message-State: AOJu0YznL9XQ1yZRwPW/8DuFYhRIqEywc7NoceIMAyE9MMDtcZfH7S9U
	JKYNfYtYvKhFfCTTs/rZ03fUT+XJeycLzsxwieFvr9duCthB16tWOMjHLrudYYI=
X-Google-Smtp-Source: AGHT+IF/vqfj/rgrk5O7lHfnT7alhQlOlfoIckREXu2cm5x+J2z40Mj4ent46Tas7EhKMKxl9ZsjKQ==
X-Received: by 2002:a17:902:e548:b0:1dc:1391:e074 with SMTP id n8-20020a170902e54800b001dc1391e074mr7755722plf.49.1708919805377;
        Sun, 25 Feb 2024 19:56:45 -0800 (PST)
Received: from oatmeal.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id kh5-20020a170903064500b001d8a93fa5b1sm2897615plb.131.2024.02.25.19.56.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Feb 2024 19:56:45 -0800 (PST)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 20/20] Staging: rtl8192e: Rename function MgntQuery_MgntFrameTxRate
Date: Sun, 25 Feb 2024 19:56:24 -0800
Message-Id: <20240226035624.370443-21-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240226035624.370443-1-tdavies@darkphysics.net>
References: <20240226035624.370443-1-tdavies@darkphysics.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename function MgntQuery_MgntFrameTxRate to mgnt_query_mgnt_frame_tx_rate
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtllib_softmac.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index 933672ac8546..adfada92495b 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -163,7 +163,7 @@ u8 mgnt_query_tx_rate_exclude_cck_rates(struct rtllib_device *ieee)
 	return query_rate;
 }
 
-static u8 MgntQuery_MgntFrameTxRate(struct rtllib_device *ieee)
+static u8 mgnt_query_mgnt_frame_tx_rate(struct rtllib_device *ieee)
 {
 	struct rt_hi_throughput *ht_info = ieee->ht_info;
 	u8 rate;
@@ -201,7 +201,7 @@ inline void softmac_mgmt_xmit(struct sk_buff *skb, struct rtllib_device *ieee)
 	if (ieee->disable_mgnt_queue)
 		tcb_desc->queue_index = HIGH_QUEUE;
 
-	tcb_desc->data_rate = MgntQuery_MgntFrameTxRate(ieee);
+	tcb_desc->data_rate = mgnt_query_mgnt_frame_tx_rate(ieee);
 	tcb_desc->ratr_index = 7;
 	tcb_desc->tx_dis_rate_fallback = 1;
 	tcb_desc->tx_use_drv_assinged_rate = 1;
@@ -277,7 +277,7 @@ softmac_ps_mgmt_xmit(struct sk_buff *skb,
 	if (ieee->disable_mgnt_queue)
 		tcb_desc->queue_index = HIGH_QUEUE;
 
-	tcb_desc->data_rate = MgntQuery_MgntFrameTxRate(ieee);
+	tcb_desc->data_rate = mgnt_query_mgnt_frame_tx_rate(ieee);
 	tcb_desc->ratr_index = 7;
 	tcb_desc->tx_dis_rate_fallback = 1;
 	tcb_desc->tx_use_drv_assinged_rate = 1;
-- 
2.39.2


