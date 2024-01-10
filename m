Return-Path: <linux-kernel+bounces-21976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E68FB829764
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 11:23:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83D8328D30E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 10:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8FAB47A73;
	Wed, 10 Jan 2024 10:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DsGBHJmk"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262AC3FB1F
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 10:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40d4f5d902dso42003685e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 02:21:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704882075; x=1705486875; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2v2KRYXA+keXRfq45rf7VwhlRc8wCU8IH+wWuas1Yt0=;
        b=DsGBHJmkSTXlmYapX+3mNu5VB00VVSMxNr1PV05C6V1gK1AwSCNbqdpd5Tb9Hbouup
         +UkgeU+eGgoFgmjL2piF81SbxHtJ3gzQ0Klbbq5V1EVQcykukmnqAAN+XxI1zQ1FebUg
         LXxXY9n+WeCNccYuXcBSwZ81stm2RareyoppqGLi7EX0BMN4rxQCBYOQffe5AqGH5iOh
         lUZ64P6zM9lDrFXNROnZEog/zDlArIgBjUvFmhTILv2wKeTKMsqP4VnK+b+tpXG4MFIV
         wNZG2uW394vYclC232qMoEYfJzLn5+N1f4Cx1Tz6zTZJhqOMW4Zo1K36+RDdForSaz5f
         K2Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704882075; x=1705486875;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2v2KRYXA+keXRfq45rf7VwhlRc8wCU8IH+wWuas1Yt0=;
        b=ZhmRtWxdCzvY3Dq+b9QtAsLF1u2evlEMU2lg8Xe984A2jd6g65sLNQI+Au33/tq8yy
         B6DTnv6cgse9B0jk23sNrvu7Ta5HIybfan65PHike+tjvlYrz1pcVI/KS4dTRObSYccO
         FJEaO+wT/WEOPAtHdn6Ku8rqB7jjaLHavEv8m4bu/HRaY0UtCy7rmQEBQat43d1XoCKK
         JNTd7qVhc+tHrhb38S3oZMwbEfwQwEwv0Gemep0VTRUIWX69E98xGt0bxZwUaGR6zqYQ
         BHvmsrLnm/EoAI61zvYJ1rmgXxTZF0A43WB9eZWxzflDptszuA4wJPwX/A58XV6dxe9C
         QZ3g==
X-Gm-Message-State: AOJu0YxUQ+2u+zUgDPXWhEXZdvqq9JxvOYgMxVtBeNNNVeeVia7MCzpJ
	x+vUhOokPb35QKFB3kUvpzM4PKYcsHlz7w==
X-Google-Smtp-Source: AGHT+IGLeDeKQhsCLP5+R4lOabowbyfiHLzCDX82nYtvoNIupA5AR/1fHezyqisxDb7TJ9bwCXPMhA==
X-Received: by 2002:a05:600c:1d95:b0:40e:4084:b948 with SMTP id p21-20020a05600c1d9500b0040e4084b948mr414155wms.94.1704882075513;
        Wed, 10 Jan 2024 02:21:15 -0800 (PST)
Received: from ta2.c.googlers.com.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id j7-20020a05600c190700b0040e52cac976sm1625302wmq.29.2024.01.10.02.21.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 02:21:15 -0800 (PST)
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
Subject: [PATCH 10/18] tty: serial: samsung: make max_count unsigned int
Date: Wed, 10 Jan 2024 10:20:54 +0000
Message-ID: <20240110102102.61587-11-tudor.ambarus@linaro.org>
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

``max_count`` negative values are not used. Since ``port->fifosize``
is an unsigned int, make ``max_count`` the same.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/tty/serial/samsung_tty.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index 90c49197efc7..dbbe6b8e3ceb 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -760,8 +760,8 @@ static irqreturn_t s3c24xx_serial_rx_chars_dma(void *dev_id)
 static void s3c24xx_serial_rx_drain_fifo(struct s3c24xx_uart_port *ourport)
 {
 	struct uart_port *port = &ourport->port;
+	unsigned int max_count = port->fifosize;
 	unsigned int fifocnt = 0;
-	int max_count = port->fifosize;
 	u32 ufcon, ufstat, uerstat;
 	u8 ch, flag;
 
-- 
2.43.0.472.g3155946c3a-goog


