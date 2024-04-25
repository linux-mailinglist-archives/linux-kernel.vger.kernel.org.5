Return-Path: <linux-kernel+bounces-158851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 383598B25C9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 17:57:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A5F31C20D58
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 15:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAE3014C5B8;
	Thu, 25 Apr 2024 15:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SHNmKsX9"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E6414B08F;
	Thu, 25 Apr 2024 15:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714060658; cv=none; b=uSti427uWI62Z+KI0DUWUbX3k1uW7drzb7pQ+Q+qsYIgVMLqGXG/hP9AFupIxn4rQjCIuGhj95FeGzvp7dCls24tV7KDFK+/eQlSoVHq1uWzwFMcKi4NKgHpc8h/HIRn14oLBW0+gTgWnp5L/f/9a/KingVCMihiis7kuy+xihw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714060658; c=relaxed/simple;
	bh=xp/u9E8lqrYHDy7ZttytiOWmxGZSKR2QflsGnvBD7Zw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=kJgvnZ+un7ilRIMCybde1Fr++mpW2i1h05SRERDZq2f+e/rPeR082ltMpuRkXbJEWYLvXDme6gEVKKJZfIYUodi9y+xix+IfHcWC5O/j/41+tDOeu5QbViHQw3YR37RpQn8yQDdjud+zzJO52tOMzY5RK5MB+J9GZF84oRPbK60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SHNmKsX9; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-41adf3580dbso7250365e9.0;
        Thu, 25 Apr 2024 08:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714060655; x=1714665455; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZWIDlM3skqmviOGyQzKHYQKwZg26rYhvxBIOzuWaC4M=;
        b=SHNmKsX9c3ju/PD0NAuXt0MnYhuuqqwybxyzYgPlN3/EdhSeO1xHqIqmW1TADMIiqK
         PidPDi3lotkECfBh8BSWfbQXYdG9RqaTDRsnCisMnZVsxAu51haQQ0pjFpmy3pQtON/e
         XS2XMx6eHexSQfQT+251lTfWy6RCCAq7tOkZJTZq7qwtC25k6yoQYGg9pfCc17FluD6Y
         BSRGVtOyAy9XlvUJttf/AGvQUlnoyxbscP/PZVHIEj+rvXR7H2F0UyBDpT8sOWo7CZB0
         wpqYN0sFU79LDHyVheKvvPtI+wLwgz1HIlTwIjexNFGzKNx1bz/cC1rtW9mVAdMnhV2p
         7Rmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714060655; x=1714665455;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZWIDlM3skqmviOGyQzKHYQKwZg26rYhvxBIOzuWaC4M=;
        b=cw7lLXLYo+fdeisqGbM5tWBDhCt57+7poml6Nd58bgqFOprcsFhwKENPznEQrHHcn3
         3L4rKet7qA9ekpnjMSw0pkfzl75ldljO1Kw4bqeMi2Mk8YKfWsfiP5jg+QLKdu0jiaXC
         sn/Cv5J8BhiYYeMbbHopgkKTO2Gf6kbiqfrGq6nsdCYsXM2JD0ZRNMCEl0421M0qr9FP
         WuzOJq6cM2RsOeHWE/HCMzO/BDe2C/3kJVtmGHv+qo+o+2MkGeU08qjEOt527ChAeOxK
         OVQC4AjIXM5A7sAnFw6zJATPD3tqAuSwkQu5OIV+J8Dqec4edYIrZAVjuGBfkJPdCq4T
         G9WA==
X-Forwarded-Encrypted: i=1; AJvYcCWhbC1Y8oET0uI/KDwXLvH9uQmiRDZEI9iwW/8obhRvnnTZe2E9NDU234VlujbVzkbrOO8unouCvHmJTY2aTxAxD+q4PeVI0U7uR4rJr0ePBp/NntDM2RxGC6iY1OJ1T5lSjUW8V1CczGRLyDk=
X-Gm-Message-State: AOJu0YwegSrMxOsumvuMBJ4fkwXDVh01mIC3VGrmBfnSnAwGqoZwds4D
	F71TPcRRS7jdlLToa8VATlpj9A0KU5e+g75oVwylqVjvUHyjRRPY
X-Google-Smtp-Source: AGHT+IGHN98h4hd/cOWqFkCJCVdijy1N1kO6cKmT4goq4/ZvLxsODGUwryYAgd3HoGnHKA6vu+o/GQ==
X-Received: by 2002:a05:600c:3c9e:b0:41b:34d3:42a5 with SMTP id bg30-20020a05600c3c9e00b0041b34d342a5mr186450wmb.1.1714060654705;
        Thu, 25 Apr 2024 08:57:34 -0700 (PDT)
Received: from localhost (craw-09-b2-v4wan-169726-cust2117.vm24.cable.virginm.net. [92.238.24.70])
        by smtp.gmail.com with ESMTPSA id t13-20020a05600c450d00b00417f700eaeasm28159076wmo.22.2024.04.25.08.57.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 08:57:34 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Ping-Ke Shih <pkshih@realtek.com>,
	Kalle Valo <kvalo@kernel.org>,
	Su Hui <suhui@nfschina.com>,
	linux-wireless@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] wifi: rtlwifi: rtl8723be: Make read-only arrays static const
Date: Thu, 25 Apr 2024 16:57:33 +0100
Message-Id: <20240425155733.114423-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Don't populate the read-only arrays cck_rates, ofdm_rates, ht_rates_1t and
channel_all on the stack at run time, instead make them static const and
clean up the formatting.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 .../wireless/realtek/rtlwifi/rtl8723be/phy.c  | 45 +++++++++++--------
 1 file changed, 26 insertions(+), 19 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8723be/phy.c b/drivers/net/wireless/realtek/rtlwifi/rtl8723be/phy.c
index 094cb36153f5..13e689037acc 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8723be/phy.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8723be/phy.c
@@ -1110,16 +1110,22 @@ static void _rtl8723be_phy_set_txpower_index(struct ieee80211_hw *hw,
 void rtl8723be_phy_set_txpower_level(struct ieee80211_hw *hw, u8 channel)
 {
 	struct rtl_efuse *rtlefuse = rtl_efuse(rtl_priv(hw));
-	u8 cck_rates[]  = {DESC92C_RATE1M, DESC92C_RATE2M,
-			   DESC92C_RATE5_5M, DESC92C_RATE11M};
-	u8 ofdm_rates[]  = {DESC92C_RATE6M, DESC92C_RATE9M,
-			    DESC92C_RATE12M, DESC92C_RATE18M,
-			    DESC92C_RATE24M, DESC92C_RATE36M,
-			    DESC92C_RATE48M, DESC92C_RATE54M};
-	u8 ht_rates_1t[]  = {DESC92C_RATEMCS0, DESC92C_RATEMCS1,
-			     DESC92C_RATEMCS2, DESC92C_RATEMCS3,
-			     DESC92C_RATEMCS4, DESC92C_RATEMCS5,
-			     DESC92C_RATEMCS6, DESC92C_RATEMCS7};
+	static const u8 cck_rates[]  = {
+		DESC92C_RATE1M, DESC92C_RATE2M,
+		DESC92C_RATE5_5M, DESC92C_RATE11M
+	};
+	static const u8 ofdm_rates[]  = {
+		DESC92C_RATE6M, DESC92C_RATE9M,
+		DESC92C_RATE12M, DESC92C_RATE18M,
+		DESC92C_RATE24M, DESC92C_RATE36M,
+		DESC92C_RATE48M, DESC92C_RATE54M
+	};
+	static const u8 ht_rates_1t[]  = {
+		DESC92C_RATEMCS0, DESC92C_RATEMCS1,
+		DESC92C_RATEMCS2, DESC92C_RATEMCS3,
+		DESC92C_RATEMCS4, DESC92C_RATEMCS5,
+		DESC92C_RATEMCS6, DESC92C_RATEMCS7
+	};
 	u8 i;
 	u8 power_index;
 
@@ -2155,15 +2161,16 @@ static void _rtl8723be_phy_iq_calibrate(struct ieee80211_hw *hw,
 
 static u8 _get_right_chnl_place_for_iqk(u8 chnl)
 {
-	u8 channel_all[TARGET_CHNL_NUM_2G_5G] = {
-			1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12,
-			13, 14, 36, 38, 40, 42, 44, 46,
-			48, 50, 52, 54, 56, 58, 60, 62, 64,
-			100, 102, 104, 106, 108, 110,
-			112, 114, 116, 118, 120, 122,
-			124, 126, 128, 130, 132, 134, 136,
-			138, 140, 149, 151, 153, 155, 157,
-			159, 161, 163, 165};
+	static const u8 channel_all[TARGET_CHNL_NUM_2G_5G] = {
+		1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12,
+		13, 14, 36, 38, 40, 42, 44, 46,
+		48, 50, 52, 54, 56, 58, 60, 62, 64,
+		100, 102, 104, 106, 108, 110,
+		112, 114, 116, 118, 120, 122,
+		124, 126, 128, 130, 132, 134, 136,
+		138, 140, 149, 151, 153, 155, 157,
+		159, 161, 163, 165
+	};
 	u8 place = chnl;
 
 	if (chnl > 14) {
-- 
2.39.2


