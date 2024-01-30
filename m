Return-Path: <linux-kernel+bounces-44409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EE288421B9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 11:44:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5BBEB23B27
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 10:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9919767728;
	Tue, 30 Jan 2024 10:43:40 +0000 (UTC)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7937D66B3E;
	Tue, 30 Jan 2024 10:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706611420; cv=none; b=kel82Oe+glVYJqz6/rJCPBVXE+jJtovlAJxEUMm0P0dyfXK61NT9BGhKXtVTew2MAi/1xMUWT/rQ8NeB6mnxyvqtlOjtaGWZ45x3Xyehe6/TaDmt3KUs8mePmKAGiqYRcf7i7XSJZhM5UTT5ROrtCzdroQpRezwU2RvLfRBQhAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706611420; c=relaxed/simple;
	bh=nywrLQlGPh6nEooDV682/+69XpU75liacZCCI7YZP70=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fChWC8TSuggx0v2XPSoLrHEjnBTgClaMC9+gZnQaEwk8lgxyG0aKFfMOK9PRVQgWyWaZnHd51Vfix3manMcgSgNayXDGi5WuYoijkEP9iLYZCBnTmheMJ7KA4mqYd4Xv3Hzzm9rIk6qJi7cG4fHe1GmuvZ/T325GaWo3ZeyRDbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a359446b57dso279079166b.3;
        Tue, 30 Jan 2024 02:43:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706611416; x=1707216216;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LZWPklz4V2or93x77kLaamHTv28BvI0mJJK9voflkyM=;
        b=MqG5fsFfrcQ1GVfhShfDUps/OJbvyMJ+KekSz0a7qKMQNlQhXXIFT4qjAVyvjoIjYS
         FLdsxOo/WlaCauIVLdAuNv7qGroyK8GzT7rgaiHIXmMJZ3/6CyzxFdb8AhkI9JYU2sF0
         PG9LTQW77PjPKIdr+v3PMoNMmzs1qBKPg5PT/b20TelZLleIfZSUhIsB85qV3dW04nMG
         kgfFU7LK/vJ+SEFgnMS0wwClwBpUiSFI4F8q+0+MlQIO+IfhfBR2H10eat1Ex6h/xWZu
         EG2FstWENheMvtu+rsmc2DFTEZ5ngQw7PVw7P/XHP+V5miIJVGGA+q0AjQQ8jvt78y9N
         bgvQ==
X-Gm-Message-State: AOJu0YzxskUqF+qdkSblDMOGEkeKeG6SPnQQE7cNXC6E0ob821fVByvA
	xrUL/Hxv1VbUIdbHYTKG5eP9WQHXHotz5VLikW9VRsyI6UsjDozo
X-Google-Smtp-Source: AGHT+IGcsGqljo2YtFpelsspLrQjRVqs37quG0lsqbxu+t1X1Q/w2i8kAdLPafIB9ZA1vZa4yLyE2g==
X-Received: by 2002:a17:906:2e95:b0:a35:8bbd:5ba9 with SMTP id o21-20020a1709062e9500b00a358bbd5ba9mr5011759eji.27.1706611416472;
        Tue, 30 Jan 2024 02:43:36 -0800 (PST)
Received: from localhost (fwdproxy-lla-119.fbsv.net. [2a03:2880:30ff:77::face:b00c])
        by smtp.gmail.com with ESMTPSA id vi4-20020a170907d40400b00a35981e30desm2660552ejc.106.2024.01.30.02.43.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 02:43:36 -0800 (PST)
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
	Kees Cook <keescook@chromium.org>,
	Johannes Berg <johannes.berg@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Justin Stitt <justinstitt@google.com>,
	Li Zetao <lizetao1@huawei.com>,
	Francois Romieu <romieu@fr.zoreil.com>,
	Rob Herring <robh@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Ruan Jinjie <ruanjinjie@huawei.com>,
	linux-wireless@vger.kernel.org (open list:TI WILINK WIRELESS DRIVERS)
Subject: [PATCH net 1/9] wifi: fill in MODULE_DESCRIPTION()s for wlcore
Date: Tue, 30 Jan 2024 02:42:35 -0800
Message-Id: <20240130104243.3025393-2-leitao@debian.org>
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
Add descriptions to the TI WLAN wlcore drivers.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/wireless/ti/wlcore/main.c | 1 +
 drivers/net/wireless/ti/wlcore/sdio.c | 1 +
 drivers/net/wireless/ti/wlcore/spi.c  | 1 +
 3 files changed, 3 insertions(+)

diff --git a/drivers/net/wireless/ti/wlcore/main.c b/drivers/net/wireless/ti/wlcore/main.c
index fb9ed97774c7..5736acb4d206 100644
--- a/drivers/net/wireless/ti/wlcore/main.c
+++ b/drivers/net/wireless/ti/wlcore/main.c
@@ -6793,6 +6793,7 @@ MODULE_PARM_DESC(bug_on_recovery, "BUG() on fw recovery");
 module_param(no_recovery, int, 0600);
 MODULE_PARM_DESC(no_recovery, "Prevent HW recovery. FW will remain stuck.");
 
+MODULE_DESCRIPTION("TI WLAN core driver");
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Luciano Coelho <coelho@ti.com>");
 MODULE_AUTHOR("Juuso Oikarinen <juuso.oikarinen@nokia.com>");
diff --git a/drivers/net/wireless/ti/wlcore/sdio.c b/drivers/net/wireless/ti/wlcore/sdio.c
index f0686635db46..eb5482ed76ae 100644
--- a/drivers/net/wireless/ti/wlcore/sdio.c
+++ b/drivers/net/wireless/ti/wlcore/sdio.c
@@ -447,6 +447,7 @@ module_sdio_driver(wl1271_sdio_driver);
 module_param(dump, bool, 0600);
 MODULE_PARM_DESC(dump, "Enable sdio read/write dumps.");
 
+MODULE_DESCRIPTION("TI WLAN SDIO helpers");
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Luciano Coelho <coelho@ti.com>");
 MODULE_AUTHOR("Juuso Oikarinen <juuso.oikarinen@nokia.com>");
diff --git a/drivers/net/wireless/ti/wlcore/spi.c b/drivers/net/wireless/ti/wlcore/spi.c
index 7d9a139db59e..0aa2b2f3c5c9 100644
--- a/drivers/net/wireless/ti/wlcore/spi.c
+++ b/drivers/net/wireless/ti/wlcore/spi.c
@@ -562,6 +562,7 @@ static struct spi_driver wl1271_spi_driver = {
 };
 
 module_spi_driver(wl1271_spi_driver);
+MODULE_DESCRIPTION("TI WLAN SPI helpers");
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Luciano Coelho <coelho@ti.com>");
 MODULE_AUTHOR("Juuso Oikarinen <juuso.oikarinen@nokia.com>");
-- 
2.39.3


