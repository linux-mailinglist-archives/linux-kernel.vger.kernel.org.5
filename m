Return-Path: <linux-kernel+bounces-36065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 884F1839AFB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 22:22:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F1B11F2C1C3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 21:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 106362C1AE;
	Tue, 23 Jan 2024 21:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="qMky1VZ/"
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B792C687
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 21:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706044925; cv=none; b=KC0hb6KiRcZMOh1HDjT7X2lrfg96mcTMSlo4zhLqgBotpRBg2l22YdW/7VjtIUaB6PaLv/UaH7sdErQlNG7Ir2gI05SQfLW19MK8aS4893uB4Q/MuSXeaopiXgATbTHI1i67ff+uYsk/UVTIaEh0cEVpNFTLzG3raTuH/4Ok4nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706044925; c=relaxed/simple;
	bh=4w+/pKmo//04pEsJ98iuq7+niZPX58YxkMoakHI3Mgg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M/rCmeq7oWLNuLg5SgEMsKdXXWzOWkPMrL+igZe4IZYyRlh+Zu7mrXZdli8V/GwXMZrTYYhhSkAPhBJzy8YeEZFPr2C6voKoNY8Lv4bWi3jp3b1bBTpVT3NYgxcypFW05aKX8/+9D2jGf7mkxDFdosVhdtcC1N9SclYzIghEFeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=qMky1VZ/; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-6e0cc84fe4dso2597643a34.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 13:22:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1706044921; x=1706649721; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9d9zCcWnDzg+o0QU+7nE0r1DZt5AAGROvQWBifNc6IE=;
        b=qMky1VZ/wS+OIMB2+6kVXyeTdpJt6fjtGnulY6SObS4xan03z2+dOmqNIrBHRkL5/G
         QfA7XzvCChNbCWOlOkX/eb6qSqc17xrDOrRGzE4pszGL8PCh8oEH3E+758hGGGMmuZUK
         GJW00gIBXJ8Az9zpqYowUTBLr7PKUXBv+0k4fpRmqbehnXEzt8D3T1DlwcS39iCFBYgw
         /QLuuAuA0UEsOnCGtBYt7vQoCc0GfuW9BaNfj5Qoa4JnF+wOq8D4zrkrVUX4EXWI5D9t
         /cJBT91xx18jixZnoUTlWdTxmtNHetOexuAeopqoaOArsEiZ3BbbpB1EFrPGm+GNRnbm
         dI8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706044921; x=1706649721;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9d9zCcWnDzg+o0QU+7nE0r1DZt5AAGROvQWBifNc6IE=;
        b=F2lhGr/rK8M+GR5fw4Ngjd0VRTRFXaWb9Y4k1enLhk7/Y4kMfkm6hd8ebPuwSwsyte
         NTbNp6UsmJM6ZtA2Z76uaE4PygLt69XPLJAY9UXHkKJgkN46AHQsOmVs4ZpN0XXeJdwh
         zP9gJre97n+2xOMWVaSwAR70Vb1QS07nKdoQiomznF8m4XXOHJQ6eqID7Px4VTA+VM1y
         F5oVYMazUMtGf8+tFCTndDWcmuwH+PLd4i4qUgKGof+sN+/g7ZZWsr84F8rmceb2yZMH
         cyERHPNjmS9HjdUc5oFuBlSs0seUajEONINIjEhQm2usRZf7q2aAAR2mYF4PkGS+JJXi
         Lt/g==
X-Gm-Message-State: AOJu0YzcRE4R4kRE/09qeqTeFd2JXWA2etCqqJVZJecCqzzJTVGjyW7V
	olR7vlMpr5Er4d25a77wWlhIepXa5WbQBmCLouY+l/9s7nCIRci1l76qgoePpXs=
X-Google-Smtp-Source: AGHT+IHC0ijnMStdFYRpd2dBzE9obNwvpQZcPF3lkXpNlgZgm6R9xZQkhPLh4gOMl6loHiQWcSUgZQ==
X-Received: by 2002:a05:6830:116:b0:6dd:f01a:b27a with SMTP id i22-20020a056830011600b006ddf01ab27amr592514otp.31.1706044921266;
        Tue, 23 Jan 2024 13:22:01 -0800 (PST)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id bn11-20020a0568300c8b00b006ce28044207sm2293497otb.58.2024.01.23.13.22.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 13:22:00 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
To: Kalle Valo <kvalo@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Ajay Singh <ajay.kathat@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] wifi: wilc1000: remove setting msg.spi
Date: Tue, 23 Jan 2024 15:21:29 -0600
Message-ID: <20240123212135.2607178-1-dlechner@baylibre.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

(spi_message_add_tail() does not access this field.)

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/net/wireless/microchip/wilc1000/spi.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/spi.c b/drivers/net/wireless/microchip/wilc1000/spi.c
index 77b4cdff73c3..7eb0f8a421a3 100644
--- a/drivers/net/wireless/microchip/wilc1000/spi.c
+++ b/drivers/net/wireless/microchip/wilc1000/spi.c
@@ -300,7 +300,6 @@ static int wilc_spi_tx(struct wilc *wilc, u8 *b, u32 len)
 
 		memset(&msg, 0, sizeof(msg));
 		spi_message_init(&msg);
-		msg.spi = spi;
 		spi_message_add_tail(&tr, &msg);
 
 		ret = spi_sync(spi, &msg);
@@ -343,7 +342,6 @@ static int wilc_spi_rx(struct wilc *wilc, u8 *rb, u32 rlen)
 
 		memset(&msg, 0, sizeof(msg));
 		spi_message_init(&msg);
-		msg.spi = spi;
 		spi_message_add_tail(&tr, &msg);
 
 		ret = spi_sync(spi, &msg);
@@ -381,8 +379,6 @@ static int wilc_spi_tx_rx(struct wilc *wilc, u8 *wb, u8 *rb, u32 rlen)
 
 		memset(&msg, 0, sizeof(msg));
 		spi_message_init(&msg);
-		msg.spi = spi;
-
 		spi_message_add_tail(&tr, &msg);
 		ret = spi_sync(spi, &msg);
 		if (ret < 0)
-- 
2.43.0


