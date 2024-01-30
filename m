Return-Path: <linux-kernel+bounces-44410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA0498421B8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 11:44:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66E2F292415
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 10:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44CBD67759;
	Tue, 30 Jan 2024 10:43:48 +0000 (UTC)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E146774C;
	Tue, 30 Jan 2024 10:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706611427; cv=none; b=CtV/bpqnxVkB0CKW7V0UQLaZmb/y5TShSPSZcMrL+ZhVOfvKduL3jkTtKZS8iRbF0Ne7tivDneH2TOpYX2npYBYArWTzKqYilv5pTIzWn5Dpjsj3yqSp6jyDLxcvfRKM03oFxAr4YMcMqEfCnmMPr/WVFvGDHXrcXzbu3ZmvrUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706611427; c=relaxed/simple;
	bh=khudRYvY1Ernl644zwe4g5O708IiZWZiqn7aLrh/mro=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LFA3I8Oc+rddxGkRaD+5DDItev9SdLDWozQUnEeTBBpb90KZg2DLuGKB3+olOYFU+gmRr3/DYt6V3Kx+o7MkKzJwCO8+F29vg9jEjHTpELU7Tsi/SSRkA0LNvb9fn5P62phTt9rXklo3Uxe8D5U+fLywLXvP5VJUiBmSNdMUlGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-55817a12ad8so3861713a12.2;
        Tue, 30 Jan 2024 02:43:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706611424; x=1707216224;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5IkNDld3fEL7/sJIigAgPWgoW1+KSm/grosXpGcm1HI=;
        b=lkJB0WBv5MMtta0IGvnS7yh7cXWLyjIFe6WbzD1xw/86oQhsaAUMEVtrQpimA4V+HY
         B0LMvOMmRZEu/dzzBs9sLOMmUAmn/piU0Er6Of5aexOD08WKtoqTkoXGCQzBBYAFx5jT
         ZEZm2kPAJLygdWkEFiLiccuIkEj8oAI7RXk0liV/1b/AKT4pzGdyu/U0Lo166uFzgunR
         dVaRpUR/sG8xzHGltLcmGddBEjJl+rYGXPKe21zqSLQTwfz5QQD8HxRHuCZqg0Phf+2B
         RxLW53mjfl97wloivFPo6G0OWYec7w3IZZQ7JQ//nUEMW/MpYCmIWGbteRrFGrWy8V6V
         l/fQ==
X-Gm-Message-State: AOJu0YxucVOe/xrkvs2vEQ4tJ6WZkAg4IGn2l5CLuJ7vXTXULs0QYzLJ
	fpZ3bI+CIjmXhkgMqPVZ7PFFLPJ0YAG+uRVb6FmySDYhm53tlMbTo/RkwzhD0IFpYw==
X-Google-Smtp-Source: AGHT+IGdSuveK4jUSeWHKLXLc70DvED/OGLr+IzT/5Zpd2NLIXwvWMu/18yFiyIihyxOem+uZVA0WA==
X-Received: by 2002:aa7:da8a:0:b0:55f:36fd:4378 with SMTP id q10-20020aa7da8a000000b0055f36fd4378mr1098400eds.19.1706611424040;
        Tue, 30 Jan 2024 02:43:44 -0800 (PST)
Received: from localhost (fwdproxy-lla-006.fbsv.net. [2a03:2880:30ff:6::face:b00c])
        by smtp.gmail.com with ESMTPSA id cf25-20020a0564020b9900b0055f070dc061sm1831275edb.4.2024.01.30.02.43.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 02:43:43 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
To: kuba@kernel.org,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com,
	Kalle Valo <kvalo@kernel.org>
Cc: dsahern@kernel.org,
	weiwan@google.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	horms@kernel.org,
	andrew@lunn.ch,
	leit@fb.com,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-wireless@vger.kernel.org (open list:TI WILINK WIRELESS DRIVERS)
Subject: [PATCH net 2/9] wifi: fill in MODULE_DESCRIPTION()s for wl1251 and wl12xx
Date: Tue, 30 Jan 2024 02:42:36 -0800
Message-Id: <20240130104243.3025393-3-leitao@debian.org>
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
index de045fe4ca1e..b26d42b4e3cc 100644
--- a/drivers/net/wireless/ti/wl12xx/main.c
+++ b/drivers/net/wireless/ti/wl12xx/main.c
@@ -1955,6 +1955,7 @@ module_param_named(tcxo, tcxo_param, charp, 0);
 MODULE_PARM_DESC(tcxo,
 		 "TCXO clock: 19.2, 26, 38.4, 52, 16.368, 32.736, 16.8, 33.6");
 
+MODULE_DESCRIPTION("TI WL12xx wireless driver");
 MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("Luciano Coelho <coelho@ti.com>");
 MODULE_FIRMWARE(WL127X_FW_NAME_SINGLE);
-- 
2.39.3


