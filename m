Return-Path: <linux-kernel+bounces-21980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A97F5829773
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 11:25:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E6311F28269
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 10:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F187A482D3;
	Wed, 10 Jan 2024 10:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VTr87Hmy"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7639F47A79
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 10:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40e552dfa5dso7916835e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 02:21:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704882079; x=1705486879; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UmHRPW27RDnkA+g75aUBVezswJMsnzKsK+kYqojzJWA=;
        b=VTr87Hmyz3A7qj6wrmDWmYrJff/uJeZ/J5YX81UDGRjI5zT6a4gyMnmU3a8P9mQU9X
         pnnUEivqFzDZSII1qYkDhlY8h21kppcuPtnS3uoiJpcrz7Tn0c8SwujaOPb+a9ka4sIT
         miH5ivZEf2bdRhEpiq1tTn6wQMD+5s4Ypa9D2j2iF0q3Ki42Vd27cDgXIMnkpzZfYguG
         T15kK3h0VBXnzT9r4eGNYmeoBwwOvkYUi4GFyAmBWLGZ3WqTh002h2lt+wQTM7zHF1fP
         D0395XYBapx3k0/oK5nvdmUWzbOQmXsSvnR2d+mNUfb4Uy7FhKmOuOBn7fPy/dntIH4S
         ZitQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704882079; x=1705486879;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UmHRPW27RDnkA+g75aUBVezswJMsnzKsK+kYqojzJWA=;
        b=b3OJ0hMKEJWvW/MkTWzEaCVkvqqgqn5pn4DbaSh9l6vwvNm/ji2fyhI3tAkj2LcMl5
         hmwg2jCeOjFZu8wyHEVUKnMJa2OWCPIfGKmiF6448b90uCzXG1i6sI4vxxFn8V2LlT5C
         3ROJCHvV5P8jZXJDWCr5yS1hJ/tJNYoxUWjZ5Mmi5KA8OEMyz0Lvjqdd46DCtQemF387
         dnrkDC2f9sN2YOwMjSZEuZf8Y+xPjhb0E2l8y2NjCevHVj6y2vJV8jAnXhOnh/xNxBFO
         aGmjKJzTS1eUrTudwG1fkaiJD1F7G4oj1EKDbh6aMluFS7eNsZROyZTqwFCy6obvXnNv
         1jvg==
X-Gm-Message-State: AOJu0YzM7XlCqOgpsKh80KMryTFpldMlHYpPaePxNSLwQkT9uOyzmDC1
	A+oPnibS2dqeJ0BVbOxKI3MbBRZHYHOtYw==
X-Google-Smtp-Source: AGHT+IF+Oagp4pVfoPn3Qez+PCLQ0H1IzVpFxNqvHn3qcWSqeS9VWnZ6GpgOzUfsQ+2xzQchsRL06w==
X-Received: by 2002:a05:600c:45c6:b0:40d:932b:c4eb with SMTP id s6-20020a05600c45c600b0040d932bc4ebmr405924wmo.176.1704882078926;
        Wed, 10 Jan 2024 02:21:18 -0800 (PST)
Received: from ta2.c.googlers.com.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id j7-20020a05600c190700b0040e52cac976sm1625302wmq.29.2024.01.10.02.21.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 02:21:18 -0800 (PST)
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
Subject: [PATCH 14/18] tty: serial: samsung: return bool for s3c24xx_serial_console_txrdy()
Date: Wed, 10 Jan 2024 10:20:58 +0000
Message-ID: <20240110102102.61587-15-tudor.ambarus@linaro.org>
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

s3c24xx_serial_console_txrdy() returned just 0 or 1 to indicate whether
the TX is empty or not. Change its return type to bool.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/tty/serial/samsung_tty.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index 63e993bed296..37c0ba2a122c 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -2183,7 +2183,7 @@ static const struct dev_pm_ops s3c24xx_serial_pm_ops = {
 
 static struct uart_port *cons_uart;
 
-static int
+static bool
 s3c24xx_serial_console_txrdy(struct uart_port *port, u32 ufcon)
 {
 	const struct s3c24xx_uart_info *info = s3c24xx_port_to_info(port);
@@ -2193,13 +2193,13 @@ s3c24xx_serial_console_txrdy(struct uart_port *port, u32 ufcon)
 		/* fifo mode - check amount of data in fifo registers... */
 
 		ufstat = rd_regl(port, S3C2410_UFSTAT);
-		return (ufstat & info->tx_fifofull) ? 0 : 1;
+		return !(ufstat & info->tx_fifofull);
 	}
 
 	/* in non-fifo mode, we go and use the tx buffer empty */
 
 	utrstat = rd_regl(port, S3C2410_UTRSTAT);
-	return (utrstat & S3C2410_UTRSTAT_TXE) ? 1 : 0;
+	return !!(utrstat & S3C2410_UTRSTAT_TXE);
 }
 
 static bool
-- 
2.43.0.472.g3155946c3a-goog


