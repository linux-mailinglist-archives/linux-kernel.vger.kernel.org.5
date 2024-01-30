Return-Path: <linux-kernel+bounces-44417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 277248421D0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 11:47:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CB3F1C21255
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 10:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEA946D1CC;
	Tue, 30 Jan 2024 10:44:07 +0000 (UTC)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20446BB53;
	Tue, 30 Jan 2024 10:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706611447; cv=none; b=AIG/IsYbvFIQf1A9PAn8WZMZIDSU6G5yE6WJBJW41PdrXT2o/sB5n2JI14SWFVa5zAscI0zibk4TBZh5T2KzhuHejx40w22XLynCUEc2BPbomTVanFHxVEaweHvuYvw9jv9/0GVzmEYYRRfgUjhTPgfcYf3CxodfRhZ5plRhOK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706611447; c=relaxed/simple;
	bh=AkmHSSa57qN8LZ0yMBT2KyIKhNTq2JgdY2J2bGhIyQE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lH7UHVBAN1Hk4bbCGcnj0fsdVe3snqRLrjwptd1XMEKavsQ3TqGWuJPQpELDgW7wRI+WrZzuF5aCHUw8I/p1Me8DbaIFX+SYa2t5nS4jEW41/w3fPlbRxasxuzFgYNI3V1wp0kCjYT+2CFvfeTQ2p1mVLbcBjqDQXau32Lcl/bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a2f79e79f0cso466834866b.2;
        Tue, 30 Jan 2024 02:44:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706611444; x=1707216244;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hLPR4JADSjWz8gexW9Jm5LzMnbjYKDt+7ixjxT+vbYM=;
        b=INfXeqQ7jQ1+NgdF/6bBssJpSqpBgkRm1d7ACZ0d7ow3kLiD49WcIQm2cpEX7riXw0
         BzTDMbqjjfE4Xab+ZfZfjawIALCvSOACLrivnb7yawgs/vNKK1SRitZ02HEqugEhohhv
         CmVZT8qiIIsnccY3aNh4zyfHV4SWVdTzqTBtNce27mU0AFEsQzYVzVXpgpBHLC1eROqe
         bW9Yc+EhZsTKGuVgpmy4B3GGXn1nE0EkNSy54TdL3JawDC8OiATRDNlogFOJ6Lr5XyNq
         SHeRuiW/Lv5PQ8qikB3Em9m5CDiwD2y7REb1tttX/cH6L5/spk4zzjBHlvcuXPsHpVjT
         IHjw==
X-Gm-Message-State: AOJu0YwFq+w6iMG+yxMdIJlaNRQc/RHWwdbx05Nmm8QCwNuZj4pHklGp
	3TKc3+xwlQiUHckndOa5ZXujYaVYjypT/BIhPp1ZUzCKdkQHvgnl
X-Google-Smtp-Source: AGHT+IENBMr/7QokIHdu+Ye1h7uAkO8emj4VgTq313THJ2DsSIcZnxiw+WLoATzWx+bWx+1FzKoTlw==
X-Received: by 2002:a17:906:a001:b0:a30:70fd:7749 with SMTP id p1-20020a170906a00100b00a3070fd7749mr6798326ejy.47.1706611443969;
        Tue, 30 Jan 2024 02:44:03 -0800 (PST)
Received: from localhost (fwdproxy-lla-120.fbsv.net. [2a03:2880:30ff:78::face:b00c])
        by smtp.gmail.com with ESMTPSA id l5-20020a1709062a8500b00a35922ecbccsm2721181eje.203.2024.01.30.02.44.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 02:44:03 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
To: kuba@kernel.org,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com,
	Ajay Singh <ajay.kathat@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Kalle Valo <kvalo@kernel.org>
Cc: dsahern@kernel.org,
	weiwan@google.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	horms@kernel.org,
	andrew@lunn.ch,
	leit@fb.com,
	linux-wireless@vger.kernel.org (open list:MICROCHIP WILC1000 WIFI DRIVER)
Subject: [PATCH net 8/9] wifi: fill in MODULE_DESCRIPTION()s for wilc1000
Date: Tue, 30 Jan 2024 02:42:42 -0800
Message-Id: <20240130104243.3025393-9-leitao@debian.org>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240130104243.3025393-1-leitao@debian.org>
References: <20240130104243.3025393-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

W=1 builds now warn if module is built without a MODULE_DESCRIPTION().
Add descriptions to the Atmel WILC1000 SPI driver.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/wireless/microchip/wilc1000/netdev.c | 1 +
 drivers/net/wireless/microchip/wilc1000/sdio.c   | 1 +
 drivers/net/wireless/microchip/wilc1000/spi.c    | 1 +
 3 files changed, 3 insertions(+)

diff --git a/drivers/net/wireless/microchip/wilc1000/netdev.c b/drivers/net/wireless/microchip/wilc1000/netdev.c
index 3be3c1754770..ef22bf6bf86a 100644
--- a/drivers/net/wireless/microchip/wilc1000/netdev.c
+++ b/drivers/net/wireless/microchip/wilc1000/netdev.c
@@ -1010,5 +1010,6 @@ struct wilc_vif *wilc_netdev_ifc_init(struct wilc *wl, const char *name,
 	return ERR_PTR(ret);
 }
 
+MODULE_DESCRIPTION("Atmel WILC1000 core wireless driver");
 MODULE_LICENSE("GPL");
 MODULE_FIRMWARE(WILC1000_FW(WILC1000_API_VER));
diff --git a/drivers/net/wireless/microchip/wilc1000/sdio.c b/drivers/net/wireless/microchip/wilc1000/sdio.c
index 0d13e3e46e98..d6d394693090 100644
--- a/drivers/net/wireless/microchip/wilc1000/sdio.c
+++ b/drivers/net/wireless/microchip/wilc1000/sdio.c
@@ -984,4 +984,5 @@ static struct sdio_driver wilc_sdio_driver = {
 module_driver(wilc_sdio_driver,
 	      sdio_register_driver,
 	      sdio_unregister_driver);
+MODULE_DESCRIPTION("Atmel WILC1000 SDIO wireless driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/net/wireless/microchip/wilc1000/spi.c b/drivers/net/wireless/microchip/wilc1000/spi.c
index 77b4cdff73c3..1d8b241ce43c 100644
--- a/drivers/net/wireless/microchip/wilc1000/spi.c
+++ b/drivers/net/wireless/microchip/wilc1000/spi.c
@@ -273,6 +273,7 @@ static struct spi_driver wilc_spi_driver = {
 	.remove = wilc_bus_remove,
 };
 module_spi_driver(wilc_spi_driver);
+MODULE_DESCRIPTION("Atmel WILC1000 SPI wireless driver");
 MODULE_LICENSE("GPL");
 
 static int wilc_spi_tx(struct wilc *wilc, u8 *b, u32 len)
-- 
2.39.3


