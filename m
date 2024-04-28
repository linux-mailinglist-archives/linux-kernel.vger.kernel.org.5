Return-Path: <linux-kernel+bounces-161610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 991D08B4EAC
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 01:02:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC7F21C2088B
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 23:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63A5D38F91;
	Sun, 28 Apr 2024 23:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="QYlHnICy"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC0F1A286
	for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 23:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714345275; cv=none; b=k9OeVROITDXFzF7ZD0/IxhAFu81jGOuiG6K50lXus0rlcnm9NWw6DEcIUKeLOWC9Fu5xYjczH/JYltamKrzkuigkoBRdWuIfmhYAZyLJXttsI7dDnOqyYynRCgjXSnOB8GCT4Ts6sJDKoh62Emn7uKg6lVDJpxYYF9qu7TaW1pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714345275; c=relaxed/simple;
	bh=mSPnRrq/jfknyM7vDbdlnNCQBX/d2boz/bfo0ykmPmo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GJt3QeLV0tGHgK14S+fkRwfAiwyFrwEWEtR7zDpEjCYRtsdoqPT/ovEqJHV69lDVlj7U4hGT3p8Rh+g2bSnQ0FoacjMkO0H/CaprVUaInyPfS5MVu/T1BF8qbNog76GXK6+B6210SsPilXlK1QXykRvlzpUce4EgQ8BgnmOg4ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=QYlHnICy; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1eb24e3a2d9so18292605ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 16:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1714345273; x=1714950073; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yok7KNPayK+/A6OeCkYTGOX3VBTa8PBhHKRxItBY7/A=;
        b=QYlHnICyWYrtpnnO+A9DU/WGy3tW3shSYzI7OEEnbn+TCzhqwel8hAJGpGw+R6rMT0
         sHChcNEzUhTyE3j0SUKAMFOCpkt0Iok04gH22Cabclell/OcbRBUsmvLmYSqzlTJXpRM
         ioD4FVTkg3olEQdYqMuUue08pi5iqqIvRqUPDA5+gUWYwbwYx3MzP7kwRgSfS6jy9PFR
         sYmCOQlCLG4nplaOd4cH1c+IBN3JlDLuQUG1aUCvbyMTw2hieOJ9oMuFZzTF96X3CkpG
         q5aElBwN0FYeR3KT3jWQc+tsl1SxRDvyeoOF3738hBs36h68lMvhFzbElB9idbX28fUQ
         wPIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714345273; x=1714950073;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yok7KNPayK+/A6OeCkYTGOX3VBTa8PBhHKRxItBY7/A=;
        b=HzbpWlwKhkdjEsIl9KbsA8aJjX0x2igYgcC0/34JX9R+cS7vAg4Gq+zn+fTNkSPVQz
         YfKXcuWN3BI/hms043yPF2NSU03dWopgOa/CdesEo3g+D2IcRwqJzVllq9YYDhDpPgvg
         F6QXvbKRHkXqeGKfYYF1HJ4/4Q/4mJqU8d10CiOzgymu65SoM0rf5HYwf0J5tieQXYoY
         yj4Hct3Oy32wWNulVEHKEODgqjqLmu7A3SwtwoI99QsC1PXGkaDX2DOGmqpCu1B39St/
         fcrh6LArT6Py8TxgVVt1MvyAwV6oK69rGXtbETTQqfmxkRms/pDRDrLLEr2YOOtQdgSC
         gcRg==
X-Forwarded-Encrypted: i=1; AJvYcCWqXI1EOWy3Wdz3h4YYq/GYMlqRdZHy4+ZFG11EyIkbUq+5uf3sgTRIkfd4GCdoOYvQ/jYUOeN3OVADYwbPubN9Up0YW1IapuNnt4dZ
X-Gm-Message-State: AOJu0YxlsL8jssMlsuidGUQsdtCi9VbS8cUtd5Jjv4aSxaeRAy4y0zit
	064Sll56PtoYCuz1YsS8lmV4AOMXim86bqJswXR4ZBQzGx1IahhJ/vNQ97XKvo0BZGDVpjSKkBx
	/
X-Google-Smtp-Source: AGHT+IFZ/+ekxzGt8VMMAAii8o2bjNBHIf21QOD2ps87Rl55ALZme19/+/orh0Ro6jE9YLVxX/Smnw==
X-Received: by 2002:a17:90a:cc15:b0:2b1:379:b115 with SMTP id b21-20020a17090acc1500b002b10379b115mr4010866pju.11.1714345272888;
        Sun, 28 Apr 2024 16:01:12 -0700 (PDT)
Received: from lunchbox.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id o16-20020a17090aac1000b002a27132ac02sm17860864pjq.2.2024.04.28.16.01.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Apr 2024 16:01:12 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 05/18] Staging: rtl8192e: Rename variable ChlWidth
Date: Sun, 28 Apr 2024 16:00:53 -0700
Message-Id: <20240428230106.6548-6-tdavies@darkphysics.net>
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

Rename variable ChlWidth to chl_width
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtl819x_HT.h     |  2 +-
 drivers/staging/rtl8192e/rtl819x_HTProc.c | 10 +++++-----
 drivers/staging/rtl8192e/rtllib_rx.c      |  2 +-
 drivers/staging/rtl8192e/rtllib_wx.c      |  4 ++--
 4 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_HT.h b/drivers/staging/rtl8192e/rtl819x_HT.h
index 7e0f64df01ea..938be9c27e0b 100644
--- a/drivers/staging/rtl8192e/rtl819x_HT.h
+++ b/drivers/staging/rtl8192e/rtl819x_HT.h
@@ -25,7 +25,7 @@ enum ht_extchnl_offset {
 
 struct ht_capab_ele {
 	u8	AdvCoding:1;
-	u8	ChlWidth:1;
+	u8	chl_width:1;
 	u8	MimoPwrSave:2;
 	u8	GreenField:1;
 	u8	ShortGI20Mhz:1;
diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
index 503ea1e92a7d..b79ea0b42e44 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -253,9 +253,9 @@ void ht_construct_capability_element(struct rtllib_device *ieee, u8 *pos_ht_cap,
 
 	cap_ele->AdvCoding		= 0;
 	if (ieee->get_half_nmode_support_by_aps_handler(ieee->dev))
-		cap_ele->ChlWidth = 0;
+		cap_ele->chl_width = 0;
 	else
-		cap_ele->ChlWidth = 1;
+		cap_ele->chl_width = 1;
 
 	cap_ele->MimoPwrSave		= 3;
 	cap_ele->GreenField		= 0;
@@ -272,7 +272,7 @@ void ht_construct_capability_element(struct rtllib_device *ieee, u8 *pos_ht_cap,
 
 	netdev_dbg(ieee->dev,
 		   "TX HT cap/info ele BW=%d MaxAMSDUSize:%d DssCCk:%d\n",
-		   cap_ele->ChlWidth, cap_ele->MaxAMSDUSize, cap_ele->DssCCk);
+		   cap_ele->chl_width, cap_ele->MaxAMSDUSize, cap_ele->DssCCk);
 
 	if (is_encrypt) {
 		cap_ele->MPDUDensity	= 7;
@@ -302,7 +302,7 @@ void ht_construct_capability_element(struct rtllib_device *ieee, u8 *pos_ht_cap,
 			cap_ele->ShortGI40Mhz		= 0;
 
 		if (ieee->get_half_nmode_support_by_aps_handler(ieee->dev)) {
-			cap_ele->ChlWidth = 0;
+			cap_ele->chl_width = 0;
 			cap_ele->MCS[1] = 0;
 		}
 	}
@@ -452,7 +452,7 @@ void ht_on_assoc_rsp(struct rtllib_device *ieee)
 	print_hex_dump_bytes("%s: ", __func__, DUMP_PREFIX_NONE,
 			     pPeerHTCap, sizeof(struct ht_capab_ele));
 #endif
-	ht_set_connect_bw_mode(ieee, (enum ht_channel_width)(pPeerHTCap->ChlWidth),
+	ht_set_connect_bw_mode(ieee, (enum ht_channel_width)(pPeerHTCap->chl_width),
 			   (enum ht_extchnl_offset)(pPeerHTInfo->ExtChlOffset));
 	ht_info->cur_tx_bw40mhz = ((pPeerHTInfo->RecommemdedTxWidth == 1) ?
 				 true : false);
diff --git a/drivers/staging/rtl8192e/rtllib_rx.c b/drivers/staging/rtl8192e/rtllib_rx.c
index ebf8a2fd36d3..ee469c9118b8 100644
--- a/drivers/staging/rtl8192e/rtllib_rx.c
+++ b/drivers/staging/rtl8192e/rtllib_rx.c
@@ -1877,7 +1877,7 @@ static void rtllib_parse_mfie_ht_cap(struct rtllib_info_element *info_element,
 
 		ht->bd_bandwidth = (enum ht_channel_width)
 					     (((struct ht_capab_ele *)
-					     (ht->bd_ht_cap_buf))->ChlWidth);
+					     (ht->bd_ht_cap_buf))->chl_width);
 	} else {
 		ht->bd_support_ht = false;
 		ht->bd_ht_1r = false;
diff --git a/drivers/staging/rtl8192e/rtllib_wx.c b/drivers/staging/rtl8192e/rtllib_wx.c
index 55a3e4222cd6..1cfd109881ad 100644
--- a/drivers/staging/rtl8192e/rtllib_wx.c
+++ b/drivers/staging/rtl8192e/rtllib_wx.c
@@ -129,8 +129,8 @@ static inline char *rtl819x_translate_scan(struct rtllib_device *ieee,
 		else
 			ht_cap = (struct ht_capab_ele *)
 				 &network->bssht.bd_ht_cap_buf[0];
-		is40M = (ht_cap->ChlWidth) ? 1 : 0;
-		isShortGI = (ht_cap->ChlWidth) ?
+		is40M = (ht_cap->chl_width) ? 1 : 0;
+		isShortGI = (ht_cap->chl_width) ?
 				((ht_cap->ShortGI40Mhz) ? 1 : 0) :
 				((ht_cap->ShortGI20Mhz) ? 1 : 0);
 
-- 
2.30.2


