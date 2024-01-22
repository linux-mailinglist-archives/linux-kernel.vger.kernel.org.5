Return-Path: <linux-kernel+bounces-34018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC9988371F3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 20:10:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90DDB1F2CB80
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD88A60259;
	Mon, 22 Jan 2024 18:47:12 +0000 (UTC)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC80757315;
	Mon, 22 Jan 2024 18:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705949232; cv=none; b=TiISQVAPC9eSn/GFDksiosx3+q8kfdk1ZTGX5Vlqyc3thrsPhD7b1oHdPElZfqmDpEUjj8/NghVajkevayjnJ4rwS9Lj4RILmIE+oFHwf08TbjxuYk6ud8zM3G1jGii/dT8dC/H8iyBd2zxnBD9vursbcsdwif2IuktIhiH+8vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705949232; c=relaxed/simple;
	bh=fHwSHtyS+Ae32U+VJHIB1SyQ1Y11MqWJ1Tc5+V9uLKc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iTEwcVDbOcO1YVRZaw8jHRVrYL63TfbQR24yzuAliGAlZawT/aWrzrGBYN9+F8syEGNXi45IzvDktapJ96i9ULI/LFUigG/SZi4pmsmzv61Yj42lM5qOmRkxAlWhi3Il7NlxUB2oifVVunZZlxlAleD00Pki1S/R0KzJB39ctnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a298accc440so380784166b.1;
        Mon, 22 Jan 2024 10:47:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705949228; x=1706554028;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0bxXP9hb+wGol48I9tuIGv5VZz1FhzE6QjqOapHhm0I=;
        b=L+zfkvcSCeRPixOHcrU1//SCqjoES5lokSvJoZGPKsZPzyZpMxDj/QkOcAWYcRW1D0
         h9w/fJjVYsooQWk2o1dJld1m2rWArgvxKJanAtFVyz227VvHirluQBJdW45HSEOok6F7
         cD0kxI0B9WnpZJ1XwDdxovwrBAyMHiUYafgSC5lQvP22a7f245IgNjFcxRSmGdiP5A1b
         DXzrR396sFwIoNudHwwi31yqaHj8PtaqJjJzGvD3kPAUCPEFs0w/LxQK5jI8vulOKGNa
         PyPH4YugQVlDXqz5tuPjxbESakOjpM4g2JGL7CMWsmbSucUicIFMeLVEmqID8sTQiTw2
         TDfw==
X-Gm-Message-State: AOJu0YwkOQs7EqWh2P/E4jKLDhe/vLwUZFSKFsfntksrhRFAAis4XfCV
	3fKqrNylQZOGvw8QTvia+0kdtSu94qmDN+9rV9P/MTE50YgSoTg1n5xEF/uISdVDcB9M
X-Google-Smtp-Source: AGHT+IFW2vQmjwNC8i1dr59E689qcvSXPRtkZVTzNQpySnLZfFXoRnR4xSS8lAeehXDOKgXma0Amhg==
X-Received: by 2002:a17:907:d308:b0:a30:25e0:8faf with SMTP id vg8-20020a170907d30800b00a3025e08fafmr1236598ejc.29.1705949228111;
        Mon, 22 Jan 2024 10:47:08 -0800 (PST)
Received: from localhost (fwdproxy-lla-006.fbsv.net. [2a03:2880:30ff:6::face:b00c])
        by smtp.gmail.com with ESMTPSA id c3-20020a17090654c300b00a2a2426728bsm13761501ejp.178.2024.01.22.10.47.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 10:47:07 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
To: kuba@kernel.org,
	davem@davemloft.net,
	abeni@redhat.com,
	edumazet@google.com,
	Kalle Valo <kvalo@kernel.org>
Cc: dsahern@kernel.org,
	weiwan@google.com,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-wireless@vger.kernel.org (open list:TI WILINK WIRELESS DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next 19/22] net: fill in MODULE_DESCRIPTION()s for wl1251 and wl12xx
Date: Mon, 22 Jan 2024 10:45:40 -0800
Message-Id: <20240122184543.2501493-20-leitao@debian.org>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240122184543.2501493-1-leitao@debian.org>
References: <20240122184543.2501493-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

W=1 builds now warn if module is built without a MODULE_DESCRIPTION().
Add descriptions to the TI wireless drivers wl12xx and wl1251.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/wireless/ti/wl1251/sdio.c | 1 +
 drivers/net/wireless/ti/wl1251/spi.c  | 1 +
 drivers/net/wireless/ti/wl12xx/main.c | 1 +
 3 files changed, 3 insertions(+)

diff --git a/drivers/net/wireless/ti/wl1251/sdio.c b/drivers/net/wireless/ti/wl1251/sdio.c
index 301bd0043a43..4e5b351f80f0 100644
--- a/drivers/net/wireless/ti/wl1251/sdio.c
+++ b/drivers/net/wireless/ti/wl1251/sdio.c
@@ -343,5 +343,6 @@ static void __exit wl1251_sdio_exit(void)
 module_init(wl1251_sdio_init);
 module_exit(wl1251_sdio_exit);
 
+MODULE_DESCRIPTION("TI WL1251 SDIO helpers");
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Kalle Valo <kvalo@adurom.com>");
diff --git a/drivers/net/wireless/ti/wl1251/spi.c b/drivers/net/wireless/ti/wl1251/spi.c
index 29292f06bd3d..1936bb3af54a 100644
--- a/drivers/net/wireless/ti/wl1251/spi.c
+++ b/drivers/net/wireless/ti/wl1251/spi.c
@@ -342,6 +342,7 @@ static struct spi_driver wl1251_spi_driver = {
 
 module_spi_driver(wl1251_spi_driver);
 
+MODULE_DESCRIPTION("TI WL1251 SPI helpers");
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Kalle Valo <kvalo@adurom.com>");
 MODULE_ALIAS("spi:wl1251");
diff --git a/drivers/net/wireless/ti/wl12xx/main.c b/drivers/net/wireless/ti/wl12xx/main.c
index de045fe4ca1e..9a12ce453f8d 100644
--- a/drivers/net/wireless/ti/wl12xx/main.c
+++ b/drivers/net/wireless/ti/wl12xx/main.c
@@ -1955,6 +1955,7 @@ module_param_named(tcxo, tcxo_param, charp, 0);
 MODULE_PARM_DESC(tcxo,
 		 "TCXO clock: 19.2, 26, 38.4, 52, 16.368, 32.736, 16.8, 33.6");
 
+MODULE_DESCRIPTION("TI WL12xx Wireless driver");
 MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("Luciano Coelho <coelho@ti.com>");
 MODULE_FIRMWARE(WL127X_FW_NAME_SINGLE);
-- 
2.39.3


