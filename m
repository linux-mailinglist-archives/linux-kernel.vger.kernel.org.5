Return-Path: <linux-kernel+bounces-21974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D94982975F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 11:23:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 347991F281C7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 10:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 730E84777D;
	Wed, 10 Jan 2024 10:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L6VpBB9c"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4FF041235
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 10:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40d604b4b30so29383145e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 02:21:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704882074; x=1705486874; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uJiSbOx+y9kAD9nYaP7HZ6jgQVEvK0yZ8eFJjkZeaz4=;
        b=L6VpBB9cF0a6G4w3wFJSHiZmBJMqa/hdSG0umDIbKLKyjOIRDkvUG8qQDCDgXSURCj
         6kUE1gvDRIxWsKtzmunBVrhJuTKrhEnTlyfLZRupIPYTKDcab0ZIgDSLf5+96y2ljsDs
         5ylv14ztav+JB7Q0JEyQgfxRL/isV7rIJxp8Zen7UukbRAdmpXHoyKD0BDN+VaLR0N2K
         S8mJT8fx2JF6VC8Gn+Sq6dSPsafef2Fi7J89FTpZednqtlEkQGB60Ke0g6aSrk9EvObE
         8r6ARQtx3ukckfVFhdw7vza83eiNWDtmiIfzmudak0SHkii9TfLTBsm0dsFjPekqhjk6
         6fiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704882074; x=1705486874;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uJiSbOx+y9kAD9nYaP7HZ6jgQVEvK0yZ8eFJjkZeaz4=;
        b=ppOxBvYKgflVrpNYvgH2j4pfDomk8oLyJfHBN2Sl4Ub0eCuQlcNX0XQbmzC3JN7ztl
         lRwXvDtFwLehol2LbC1nO1SRsdoEk3Iw3haGg84py/ZDCtR4ZBFaS4SGOsj90MpSWsMW
         fqM9DXI9PiHmTFFeLSor9ONqki+swFq9EnAq0pUY8xoZZRYF9ievsWangAt+qSRDdwec
         gQypqRh2/6KnlmHUB9Go6aE1WUIPmlvuXSQEBsL7+3TWcCYd5Sgq72CnXDxu9k2V/Wi1
         EzrGrGkOEQiebt1Jn4VVw4M/jNlzdl7yKjrW9ewyXN8N03vaTrG2hgOT1okp2sZJ2FFu
         n/Og==
X-Gm-Message-State: AOJu0YxuoKAGNjn1X6RpnJuJENISWQoPdZ4ow0CEMrVzjxlV2fO3rS63
	cfQBni1Rb39FTm+2XSwOTx++KZEgzaHxrQ==
X-Google-Smtp-Source: AGHT+IF1VVx7NZ4+jYpZe5nZJn+QtrY9rCxcI5pj277eW+yQK3URG35FfJHed1DogBS4MlQyh203yw==
X-Received: by 2002:a05:600c:3b97:b0:40d:94ba:cb8c with SMTP id n23-20020a05600c3b9700b0040d94bacb8cmr489208wms.109.1704882074171;
        Wed, 10 Jan 2024 02:21:14 -0800 (PST)
Received: from ta2.c.googlers.com.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id j7-20020a05600c190700b0040e52cac976sm1625302wmq.29.2024.01.10.02.21.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 02:21:13 -0800 (PST)
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
Subject: [PATCH 08/18] tty: serial: samsung: move open brace '{' on the next line
Date: Wed, 10 Jan 2024 10:20:52 +0000
Message-ID: <20240110102102.61587-9-tudor.ambarus@linaro.org>
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

Move open brace '{' following function definition on the next line.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/tty/serial/samsung_tty.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index 11ae3a1dcdc3..b9d1ef67468c 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -1740,7 +1740,8 @@ static struct uart_driver s3c24xx_uart_drv = {
 
 static struct s3c24xx_uart_port s3c24xx_serial_ports[UART_NR];
 
-static void s3c24xx_serial_init_port_default(int index) {
+static void s3c24xx_serial_init_port_default(int index)
+{
 	struct uart_port *port = &s3c24xx_serial_ports[index].port;
 
 	spin_lock_init(&port->lock);
-- 
2.43.0.472.g3155946c3a-goog


