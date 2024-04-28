Return-Path: <linux-kernel+bounces-161613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B01E98B4EAF
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 01:02:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E599DB21046
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 23:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F082F3E497;
	Sun, 28 Apr 2024 23:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="lV6AvB8Q"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D552E3F2
	for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 23:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714345277; cv=none; b=SjJ9ZrMD/278kVfEFMGszix/WVeRFYJ6P0mem75hJwFvIljmKttjAku3d7N+xx/ft2j81QFc5jK8MQgnZJy+rCvFJa+He8FYXC6Fo9Cq1fEqm+S1Y59pzYLvSIXoNXCb5gpXJgsUov6PygvjwlqQr2Wmf7Cik3ZBz3+OGu94RPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714345277; c=relaxed/simple;
	bh=f7XnGoZL7qAneDrjRsAN3LInQTrlVLMQFjBrTp8NZgs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qctiNaVtKgGcbe7BltenBCwyqQ7///IwyYGKv8rlUzh5wZbSyFr0oPaROoJRG3noSUxTTNLcUVdl/K0j04Y+ci0l5e8hMExwdRzT4X4k1wyOI5RvNKwQ+314paU5CVZ0gU+fky8GkNYktpGtGPbGJsjSh8O+6On89Ldy2UZ5P4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=lV6AvB8Q; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1eab699fcddso28951295ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 16:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1714345275; x=1714950075; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zvpx3Vueis7h62thfpx+slORtda+wmNLPzJj/b+4olY=;
        b=lV6AvB8QZmnuwqKsAsd0ZGqyE4lCR9LdOoXAUNY5lAXLvt5kMF3gXCUYHBWaNX2/H3
         4ApUwzbzKgPEn4QAxn/uhs8++qtPcm91ez3zjZW7yvlA9Eky94Bqa7fiRC5eog9n4GdS
         an9ar5mxAWbE0SpyasY/shYQtpzbfzA28v/Kjy6TkwusrigAyj2SknGJbxU8f/xtHoW7
         9UXFcMKla/upOyegWG0FOn5ZEr6dbEpYuzU+/c8brEho/YwmzwRSXKFGJjlS6TakbRvH
         g2rNceLpwAcFN7haDyax27Nr6osCsDyXWy2qu8yfJWM5R9gJ36M6zo8Xo5VU7kjMf7kZ
         T/lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714345275; x=1714950075;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zvpx3Vueis7h62thfpx+slORtda+wmNLPzJj/b+4olY=;
        b=aJXvto/Js5zcsOcb1IFl6m3TAkatIIzcrk2RPAHSTTIBKAEczh5ZlwX9nkvzSqBMMH
         8ZrunZbUyeZVVHnYk9/Ej6gnrPkyeHMaMY1URm+vSwe1epCsW5OzmWrJk5yVYETO83Nm
         xGMAe0dRRmpRYZZkSRBhwNgJCmh0TRPTBmWDEj5k5LECkjWkuYt/He0oq+xUNqq9p91x
         iUjcNA/J34c/tl1CPCs9ntU3d8aQlR4TnDIWbREsELdprzRto1DTQtN9j3AFRxlYSlcg
         8o49wibkbIYKO2s/wUslgXljxU0VUEf6UbTIOR+6Z8x7lmUMaulmv+KzGCHHoX3DhQ06
         HYzw==
X-Forwarded-Encrypted: i=1; AJvYcCVV2Qo/aXT9W1emecbg9vrJbJOLLCzFb0N8ZXq764OKKIVwdmZFvGfUw0Bn7AfOa/o6NjIbNV40FaDC0s7mRcyp2QqXh7S6TeqvQLyY
X-Gm-Message-State: AOJu0Yxh6YEr3T7SxyQCbaj3CYGhwx72lQxulFBPMR0plIPjYh1fF1Y8
	2MXmIhF1pNbsNZle5C63whcy4P8P7e9KabjgbAoYyWABesFgNGePW5flDGICtRU=
X-Google-Smtp-Source: AGHT+IHTP3+GYeyRM/DhpFrx1dmH9butYonF8Yc2gPbUNM3IfbCwkX0jXRkuUCi6v4vA4o+J3QLYGg==
X-Received: by 2002:a17:90a:17eb:b0:2a7:30f6:1aa8 with SMTP id q98-20020a17090a17eb00b002a730f61aa8mr8254943pja.8.1714345275002;
        Sun, 28 Apr 2024 16:01:15 -0700 (PDT)
Received: from lunchbox.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id o16-20020a17090aac1000b002a27132ac02sm17860864pjq.2.2024.04.28.16.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Apr 2024 16:01:14 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 08/18] Staging: rtl8192e: Rename variable ShortGI40Mhz
Date: Sun, 28 Apr 2024 16:00:56 -0700
Message-Id: <20240428230106.6548-9-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240428230106.6548-1-tdavies@darkphysics.net>
References: <20240428230106.6548-1-tdavies@darkphysics.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename variable ShortGI40Mhz to short_gi_40mhz
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtl819x_HT.h     | 2 +-
 drivers/staging/rtl8192e/rtl819x_HTProc.c | 6 +++---
 drivers/staging/rtl8192e/rtllib_wx.c      | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_HT.h b/drivers/staging/rtl8192e/rtl819x_HT.h
index 25cdfdf85991..1b08507cab87 100644
--- a/drivers/staging/rtl8192e/rtl819x_HT.h
+++ b/drivers/staging/rtl8192e/rtl819x_HT.h
@@ -29,7 +29,7 @@ struct ht_capab_ele {
 	u8	mimo_pwr_save:2;
 	u8	GreenField:1;
 	u8	ShortGI20Mhz:1;
-	u8	ShortGI40Mhz:1;
+	u8	short_gi_40mhz:1;
 	u8	TxSTBC:1;
 	u8	RxSTBC:2;
 	u8	DelayBA:1;
diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
index 73d1e19a59ba..6c557717d8af 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -260,7 +260,7 @@ void ht_construct_capability_element(struct rtllib_device *ieee, u8 *pos_ht_cap,
 	cap_ele->mimo_pwr_save		= 3;
 	cap_ele->GreenField		= 0;
 	cap_ele->ShortGI20Mhz		= 1;
-	cap_ele->ShortGI40Mhz		= 1;
+	cap_ele->short_gi_40mhz		= 1;
 
 	cap_ele->TxSTBC			= 1;
 	cap_ele->RxSTBC			= 0;
@@ -299,7 +299,7 @@ void ht_construct_capability_element(struct rtllib_device *ieee, u8 *pos_ht_cap,
 			cap_ele->MCS[1] &= 0x00;
 
 		if (ht->iot_action & HT_IOT_ACT_DISABLE_RX_40MHZ_SHORT_GI)
-			cap_ele->ShortGI40Mhz		= 0;
+			cap_ele->short_gi_40mhz		= 0;
 
 		if (ieee->get_half_nmode_support_by_aps_handler(ieee->dev)) {
 			cap_ele->chl_width = 0;
@@ -458,7 +458,7 @@ void ht_on_assoc_rsp(struct rtllib_device *ieee)
 				 true : false);
 
 	ht_info->cur_short_gi_20mhz = ((pPeerHTCap->ShortGI20Mhz == 1) ? true : false);
-	ht_info->cur_short_gi_40mhz = ((pPeerHTCap->ShortGI40Mhz == 1) ? true : false);
+	ht_info->cur_short_gi_40mhz = ((pPeerHTCap->short_gi_40mhz == 1) ? true : false);
 
 	ht_info->current_ampdu_enable = ht_info->ampdu_enable;
 	if (ieee->rtllib_ap_sec_type &&
diff --git a/drivers/staging/rtl8192e/rtllib_wx.c b/drivers/staging/rtl8192e/rtllib_wx.c
index 1cfd109881ad..71ecfd0c8ed7 100644
--- a/drivers/staging/rtl8192e/rtllib_wx.c
+++ b/drivers/staging/rtl8192e/rtllib_wx.c
@@ -131,7 +131,7 @@ static inline char *rtl819x_translate_scan(struct rtllib_device *ieee,
 				 &network->bssht.bd_ht_cap_buf[0];
 		is40M = (ht_cap->chl_width) ? 1 : 0;
 		isShortGI = (ht_cap->chl_width) ?
-				((ht_cap->ShortGI40Mhz) ? 1 : 0) :
+				((ht_cap->short_gi_40mhz) ? 1 : 0) :
 				((ht_cap->ShortGI20Mhz) ? 1 : 0);
 
 		max_mcs = ht_get_highest_mcs_rate(ieee, ht_cap->MCS,
-- 
2.30.2


