Return-Path: <linux-kernel+bounces-90909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D41438706A2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 17:11:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A1A528CAAE
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 16:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58BC34C62E;
	Mon,  4 Mar 2024 16:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gKPu1Dac"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076B34AED4;
	Mon,  4 Mar 2024 16:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709568656; cv=none; b=oCJdBUZUFYxwy/3vyarPwAVBeyhzU0DuIBm5QJD8DXZqaSmwVOF8dUDDu5KLgUXIBhlZx+gptXiqSaE3sdQKkm8+V4YDn8i3ADFZw5qNg5kjehQdEDLCAvL58B7Ot/dewOlEaypewhSeyQGCcUQvpVB8gVWz+U6hRtrtRsWBSik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709568656; c=relaxed/simple;
	bh=dHq0DKGqX9xEFsFLh6i7JCdWBtfyDQ931akUkFp0FUQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=IrdQXlHc4M+Srk/Scr3ve/gPd7LWpDa+/pN00CMRpeCAlr/ODXau9IcRlamliOLneDw1ckBursqZ4zAqs9R7SvRoS4E4khSzWICQ2yAgMgePpIW+58bODA9wM8iJb+8z76oazpgeR0hlNSuWb63ZsdF5eEKtXzx9ZZooHRCW1W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gKPu1Dac; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-412e6bdd454so5249735e9.1;
        Mon, 04 Mar 2024 08:10:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709568652; x=1710173452; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wwRon3YDC+GD9jnJ5kPZT5CVostWJPWX7LavrbEpoio=;
        b=gKPu1Dac7+rvd3t+8W0t2zaXicL8gGyUbZd5yz05ML9orrySfK8GuJtTvV2FqZ6bp5
         LVkcpFoDLwqz6Zff9Zbk+hdaAYRXAj+tyk4ReLM9IuzB6wXIl7tNLuRA5mtZv7p4Gpz6
         MFVUmsKqMhPcrIZ2Yb2xpMrcqpGF1y4cx5PHSqMtrXQc7yklxiobEv0RLTUAvbbk4bnp
         GcWhuqEequ+6rXG+Z2GZ4V5PscB2iT1KQD4yD89pYg6Br7AW15hGFgPjUV7OFMO9alZd
         uZF0K7qgvBSCidNHg71azA19a+gKdjQtORy9UN+Lr1h9wHQpy0AQc9CH0xDQR1jEpQhi
         HDLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709568652; x=1710173452;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wwRon3YDC+GD9jnJ5kPZT5CVostWJPWX7LavrbEpoio=;
        b=WgUVyR6dtwmrbTs995fjzIVS7/JbuLnC9hCEZOej8HwOF70rpOFEUDbbhrVCK4m7t+
         w6H7IzECvVggitM7Xl5rD23t39ifeh7/cC30dfNNi9sKbdHO8aWu5hfc4DmEhiyU/MLd
         GXK1Z/xzQNzFKjNEkujV/fr4xGZxcqrNKcq8rd0ntsdqssggrdsuH3MndySnEO8JDYY+
         zb6NskTPNWZ6Om5IqJo6h9jS+tuvEMVhG+hUDeVzEZg+JkdW2IWxqFR3Con+XF9+12cM
         YOhGjCp42w/p2N3wMJkJLpVryXRT8kWdeExuUhgvpDmjd/3K9C65wsoOO8H+chBCtJzH
         MlXA==
X-Forwarded-Encrypted: i=1; AJvYcCU0NGGuIN1OjhGe70Nn9mTuyxVg7EbZyfGn8cVeRgAVHK1tGawju4IXwwys43xVGnl3pQVfQyf/lNOFGiqWG1Vvzwqqg8LkPDhwy1dr
X-Gm-Message-State: AOJu0YyNy06dBX9GEMRDTZzwFg9TGKVmhUR5WDeU/b8bXCKUHQghSO2f
	Bo/1Coe3ZzNiL1sLJjAZojMQZT4FQtXkZRIUwCJocxAzsGiV+JZe
X-Google-Smtp-Source: AGHT+IEdMQwzgNiAneqscWzS9EICOuVeppTy/0OTasXHdy8KD6a7dFoAuwIugLDkT/sqDpRZDhZupA==
X-Received: by 2002:a05:600c:470e:b0:412:c3cf:ee2b with SMTP id v14-20020a05600c470e00b00412c3cfee2bmr7689936wmo.12.1709568652173;
        Mon, 04 Mar 2024 08:10:52 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id g8-20020a05600c310800b00412b0ef22basm15161814wmo.10.2024.03.04.08.10.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 08:10:46 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev,
	Ruan Jinjie <ruanjinjie@huawei.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Atin Bainada <hi@atinb.me>
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] staging: rtl8723bs: remove redundant variable hoffset
Date: Mon,  4 Mar 2024 16:10:45 +0000
Message-Id: <20240304161045.769912-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Variable hoffset in functions hal_EfuseGetCurrentSize_WiFi and
hal_EfuseGetCurrentSize_BT is being assigned a value but it not
being read for any useful reason at all. The variable is redundant
and can be removed.

Cleans up clang scan build warnings for lines 957 and 1050:
drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c:957:5: warning:
variable 'hoffset' set but not used [-Wunused-but-set-variable]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
index c5219a4a4919..7a5c3a98183b 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
@@ -954,7 +954,7 @@ static u16 hal_EfuseGetCurrentSize_WiFi(
 #endif
 	u16 efuse_addr = 0;
 	u16 start_addr = 0; /*  for debug */
-	u8 hoffset = 0, hworden = 0;
+	u8 hworden = 0;
 	u8 efuse_data, word_cnts = 0;
 	u32 count = 0; /*  for debug */
 
@@ -1001,16 +1001,13 @@ static u16 hal_EfuseGetCurrentSize_WiFi(
 		}
 
 		if (EXT_HEADER(efuse_data)) {
-			hoffset = GET_HDR_OFFSET_2_0(efuse_data);
 			efuse_addr++;
 			efuse_OneByteRead(padapter, efuse_addr, &efuse_data, bPseudoTest);
 			if (ALL_WORDS_DISABLED(efuse_data))
 				continue;
 
-			hoffset |= ((efuse_data & 0xF0) >> 1);
 			hworden = efuse_data & 0x0F;
 		} else {
-			hoffset = (efuse_data>>4) & 0x0F;
 			hworden = efuse_data & 0x0F;
 		}
 
@@ -1047,7 +1044,7 @@ static u16 hal_EfuseGetCurrentSize_BT(struct adapter *padapter, u8 bPseudoTest)
 	u16 btusedbytes;
 	u16 efuse_addr;
 	u8 bank, startBank;
-	u8 hoffset = 0, hworden = 0;
+	u8 hworden = 0;
 	u8 efuse_data, word_cnts = 0;
 	u16 retU2 = 0;
 
@@ -1085,7 +1082,6 @@ static u16 hal_EfuseGetCurrentSize_BT(struct adapter *padapter, u8 bPseudoTest)
 				break;
 
 			if (EXT_HEADER(efuse_data)) {
-				hoffset = GET_HDR_OFFSET_2_0(efuse_data);
 				efuse_addr++;
 				efuse_OneByteRead(padapter, efuse_addr, &efuse_data, bPseudoTest);
 
@@ -1094,11 +1090,8 @@ static u16 hal_EfuseGetCurrentSize_BT(struct adapter *padapter, u8 bPseudoTest)
 					continue;
 				}
 
-/* 				hoffset = ((hoffset & 0xE0) >> 5) | ((efuse_data & 0xF0) >> 1); */
-				hoffset |= ((efuse_data & 0xF0) >> 1);
 				hworden = efuse_data & 0x0F;
 			} else {
-				hoffset = (efuse_data>>4) & 0x0F;
 				hworden =  efuse_data & 0x0F;
 			}
 
@@ -1114,18 +1107,15 @@ static u16 hal_EfuseGetCurrentSize_BT(struct adapter *padapter, u8 bPseudoTest)
 	) {
 			if (efuse_data != 0xFF) {
 				if ((efuse_data&0x1F) == 0x0F) { /* extended header */
-					hoffset = efuse_data;
 					efuse_addr++;
 					efuse_OneByteRead(padapter, efuse_addr, &efuse_data, bPseudoTest);
 					if ((efuse_data & 0x0F) == 0x0F) {
 						efuse_addr++;
 						continue;
 					} else {
-						hoffset = ((hoffset & 0xE0) >> 5) | ((efuse_data & 0xF0) >> 1);
 						hworden = efuse_data & 0x0F;
 					}
 				} else {
-					hoffset = (efuse_data>>4) & 0x0F;
 					hworden =  efuse_data & 0x0F;
 				}
 				word_cnts = Efuse_CalculateWordCnts(hworden);
-- 
2.39.2


