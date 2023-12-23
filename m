Return-Path: <linux-kernel+bounces-10318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 83DAA81D2B2
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 07:38:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF0281C22B4E
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 06:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E5268C13;
	Sat, 23 Dec 2023 06:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yuqd4aW9"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380D979C5;
	Sat, 23 Dec 2023 06:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-1f055438492so1721493fac.3;
        Fri, 22 Dec 2023 22:38:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703313488; x=1703918288; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OVHq5d9Kjbk0ynj3mfmwj6m9SvM97WhxTlyKQpD2zQ4=;
        b=Yuqd4aW9GnN0N/1ZOEoCqFjbKGl5CjHL1DzR23Mo8uuD3N6qbJZM6lIY5m1X5xY40K
         AtpZ8egFuaTMLdeRhQ36V8APu7M+PDtwIt0rx2NUSylADcT6s5Z30fuVN3UZHVd+NQ1C
         cAwxZzeoGMaI384/Y0oYfhlf5aE7uskE7H8MjJpkO2lSZ6yxuZmWXOGJKau3ZDmcdhuK
         KybT4LrsHPXI/7s40e7k1Yu4GEQcxef5yCdSxFjfznvMmaADX+zYXrCpQQnMLnFfJ7SZ
         IQbuwcBwLOatyioviUP290H8x32YRFu3mG64TDVyEGpzz/tGzQ1xkoqsLsVUo6wGo3s9
         kKQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703313488; x=1703918288;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OVHq5d9Kjbk0ynj3mfmwj6m9SvM97WhxTlyKQpD2zQ4=;
        b=QCylKYooPItryV3ANYg4pahW6QVuTIvpsvBfuBYQ43gIZW/JKLxRlt8Ye3r/87Dfha
         Df4hjQU/LtU067r5Drbnf0vWm7CUpqiPgSidyKTk+g0zJegBvc4hOQlUxH4KLCZazh4H
         nv1RjTN+SZAdQD8yyzRAZevprDwWSuY8/KdLKAd/KPOEPSmIWJf+Y8ZzIR12ZF7orvSb
         jDsUH0Btu51GEvO4Q9Nl0Ej/UE36L4JB47cIoEqT9MVhRQXvc5drGd1AZpBa341GdZSt
         jBIR2LOh6Kj5jZ9m5Oy27WG80T7uw9UxCWNhB62u/RL1naH0ZvJu0U/3iV++ytSnFFue
         Hl7w==
X-Gm-Message-State: AOJu0YxVe1qBEJro3GK0MvyW/W4oKd8wPil36MG1jstSsstAN7R3Dj7T
	8grcS+rv8bmCeinC4iQH1HU=
X-Google-Smtp-Source: AGHT+IHgQllJ/OIVjCOklRHwNQ3GZGitZR8jV2AbmAP3ncB5SWqwyxgJLTXlVLKutEUFHRv8aty8lw==
X-Received: by 2002:a05:6870:f142:b0:203:ede9:79f9 with SMTP id l2-20020a056870f14200b00203ede979f9mr3164384oac.10.1703313486143;
        Fri, 22 Dec 2023 22:38:06 -0800 (PST)
Received: from firetower.tail34f67.ts.net ([2601:647:5700:d20:b942:471c:6355:25fb])
        by smtp.gmail.com with ESMTPSA id h16-20020a635310000000b005c200d6486asm4580258pgb.72.2023.12.22.22.38.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 22:38:05 -0800 (PST)
From: Dacio Romero <dacioromero@gmail.com>
To: Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>
Cc: Shayne Chen <shayne.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dacioromero@gmail.com
Subject: [PATCH] wifi: mt76: mt76x2u: add netgear wdna3100v3 to device table
Date: Fri, 22 Dec 2023 22:32:25 -0800
Message-ID: <20231223063711.487002-1-dacioromero@gmail.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Netgear WDNA3100v3 has a chipset that's compatible with the mt76x2u driver and works without modification with the mainline kernel by writing to sysfs.

Signed-off-by: Dacio Romero <dacioromero@gmail.com>
---
 drivers/net/wireless/mediatek/mt76/mt76x2/usb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/usb.c b/drivers/net/wireless/mediatek/mt76/mt76x2/usb.c
index 55068f3252ef..e0643b0dfdc5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/usb.c
@@ -18,6 +18,7 @@ static const struct usb_device_id mt76x2u_device_table[] = {
 	{ USB_DEVICE(0x7392, 0xb711) },	/* Edimax EW 7722 UAC */
 	{ USB_DEVICE(0x0e8d, 0x7632) },	/* HC-M7662BU1 */
 	{ USB_DEVICE(0x2c4e, 0x0103) },	/* Mercury UD13 */
+	{ USB_DEVICE(0x0846, 0x9014) },	/* Netgear WNDA3100v3 */
 	{ USB_DEVICE(0x0846, 0x9053) },	/* Netgear A6210 */
 	{ USB_DEVICE(0x045e, 0x02e6) },	/* XBox One Wireless Adapter */
 	{ USB_DEVICE(0x045e, 0x02fe) },	/* XBox One Wireless Adapter */
--
2.42.0


