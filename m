Return-Path: <linux-kernel+bounces-21978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22E0982976B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 11:24:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C654728DA8A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 10:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32D5E481A4;
	Wed, 10 Jan 2024 10:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XiaxeP1F"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80AB3FB27
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 10:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40e4d64a431so18438355e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 02:21:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704882077; x=1705486877; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X4OrxluJS1Dxt0QsygYV4JA7ss0pHdXLycYpqP8S/nY=;
        b=XiaxeP1F/NrMhXsnnLE7Hr2pHbh298NywDAybFLZmrWm632DevmscaQ+QMWERiOvby
         XGtbUetrkmiFlSiM9wLA+UqdgnLXsroAnsJ21jjBuU2Ko7CuZVb5Fgb2MK5+nVpy9ujQ
         e1tZzL41uyarHCe9d3kcphhPjfUS9jVf4xVwB8tkaLka2kquTlbixIzFt5IGfXJIFJ//
         8Poofs3EJCBg5Adu4UQOJdqaO/rpp3YNlgqLIDQucmev/hWnrO8McsoB9jepyfvruQwh
         A9xacRXOOsDENxKLPzwwjBxhLLveuh4ALxrANCMAYSw1pbSmgyqsESohQmRWjJ3G7alR
         DfFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704882077; x=1705486877;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X4OrxluJS1Dxt0QsygYV4JA7ss0pHdXLycYpqP8S/nY=;
        b=QxbX/s0sbF81E8MvXwAkWceQehhgEEeZvJDJ+wnOMT+54axtuTJl49aW6JHnUUUQyI
         Us74t05hFmYn6zMo3fAgtp3lIGTWgsjlAGf9sFcU1UMRmEL5VY5TuHlE2z1WJTyc9g40
         f95TdmRb2bazcRGybZfDzmadNsH6ixmTwwymvXgXxx+gyJ32YEVdMtouOQdfIFBfsxAI
         UYZXVoTrw1NC5WwhadKWcPgBMXplsDfFXFivcfkz/9sD/W4D6cPlIneHHWmAMWg0yuOX
         wLe11wQJqmhZ5BoNsOEaGiIxrxj3RPS+bWntA/5GVnSBA5J3Ayj2aGLNF4i7iyI7ZA2p
         Fwsg==
X-Gm-Message-State: AOJu0YwmPtT6/acSqAHFzILGU7J4has6oZDqvnMg83ACOKXsne7VYKcR
	wcjpXimpVR6mFtArR2HC62yx/X59K9oZfQ==
X-Google-Smtp-Source: AGHT+IH2pHpqQ2IvcL8mLqW4mDIBGBWO/XFWarVigmK91FlJxQn+wyWXYGgkF4J4hdXMLY2WPdpvQQ==
X-Received: by 2002:a05:600c:511e:b0:40e:42b4:23b6 with SMTP id o30-20020a05600c511e00b0040e42b423b6mr498393wms.55.1704882077261;
        Wed, 10 Jan 2024 02:21:17 -0800 (PST)
Received: from ta2.c.googlers.com.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id j7-20020a05600c190700b0040e52cac976sm1625302wmq.29.2024.01.10.02.21.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 02:21:16 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: krzysztof.kozlowski@linaro.org,
	alim.akhtar@samsung.com,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	andre.draszik@linaro.org,
	peter.griffin@linaro.org,
	kernel-team@android.com,
	willmcvicker@google.com,
	Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH 12/18] tty: serial: samsung: use TIOCSER_TEMT for tx_empty()
Date: Wed, 10 Jan 2024 10:20:56 +0000
Message-ID: <20240110102102.61587-13-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20240110102102.61587-1-tudor.ambarus@linaro.org>
References: <20240110102102.61587-1-tudor.ambarus@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The core expects for tx_empty() either TIOCSER_TEMT when the tx is
empty or 0 otherwise. Respect the core and use TIOCSER_TEMT.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/tty/serial/samsung_tty.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index f2413da14b1d..46fba70f3d77 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -990,11 +990,10 @@ static unsigned int s3c24xx_serial_tx_empty(struct uart_port *port)
 	if (ufcon & S3C2410_UFCON_FIFOMODE) {
 		if ((ufstat & info->tx_fifomask) || (ufstat & info->tx_fifofull))
 			return 0;
-
-		return 1;
+		return TIOCSER_TEMT;
 	}
 
-	return s3c24xx_serial_txempty_nofifo(port);
+	return s3c24xx_serial_txempty_nofifo(port) ? TIOCSER_TEMT : 0;
 }
 
 /* no modem control lines */
-- 
2.43.0.472.g3155946c3a-goog


