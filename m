Return-Path: <linux-kernel+bounces-21977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E721B82976A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 11:24:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9611C28D061
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 10:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93B9F47F65;
	Wed, 10 Jan 2024 10:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k7Vb1n5F"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E8E247762
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 10:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-50e67e37661so4962792e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 02:21:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704882076; x=1705486876; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nZqqbWPwYwhLrpcSvI/iFs7tmVPH9J4dNpzf8ql04hU=;
        b=k7Vb1n5F2SEPXIQXisAakST2klRHzgVl6s9Cikn8ta66M4l/aiA/96Hc0Ae+BeCAlq
         DwvsfkTHeb4HbgQf8UWBTlxG/JikGHbDYYzBZzvFRKlTKYehzCrFKVPcyGpxWAMsWrVq
         6zBbTyNY9jiXUwhWOOfua40wCqTuot1ba8q6OAnpZrG3cAxt8/Z1GJ8sizCXIBYcZD4w
         qopt13AtQQMbHjv438CRroXDbp/0uiJ4S/iB6VBVWygoAMk/DtngrasklYAcqkK5TMj4
         xozVhdLF4jfXIQkp4TX3mXCxHFLEcQ3Wtg5VHMX+tdm6IOR7yPa1GV9n86n4IK+9z/4U
         6f3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704882076; x=1705486876;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nZqqbWPwYwhLrpcSvI/iFs7tmVPH9J4dNpzf8ql04hU=;
        b=jyIVKM91xdqKKL9s+URSLnciMRRWrR72UtU7TskUUZvjVBiAZ0BPkuFF2P5/yq5CIi
         dVs5pBf9kYCwXPlniKt3GaUbK3xlO7AHo87jV/jGLvloOpgbFQalcT321ruKeaVY7ylj
         RgNRgnWr23aXqwnBooq1nfxu9foI+DLzJ2fCkYF7QFFIg49u73DS/lqwHSyTk76k/+Jq
         uEFEIlMHHk3+gm2oYmLYNHGrqvznVHBBWMuDHFdmUL2WkB5Eqi9/D+bLueyCSWxaxP79
         Fob9Mxga7PFHNxLPeZK06rl1yBiEJOjzpaFMwxGRZmS7li9Nr0hPYEaS/tW/1sJZVYJI
         rmQw==
X-Gm-Message-State: AOJu0YwF8nenvaBX1EdTcatoGM759QRNblmwNmmYv/2xpZmMJ28D1Yc2
	zmxwBXF52N9OrqVeYpyNGoKmPqZPqVclHg==
X-Google-Smtp-Source: AGHT+IHUDinlorp0iKAoAamRhoFsnXh8pnrCQea2LbnsIeK75SvmBljlO0KL8/orqVUjuZxufpV6mQ==
X-Received: by 2002:ac2:4554:0:b0:50e:8137:9a10 with SMTP id j20-20020ac24554000000b0050e81379a10mr307722lfm.129.1704882076456;
        Wed, 10 Jan 2024 02:21:16 -0800 (PST)
Received: from ta2.c.googlers.com.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id j7-20020a05600c190700b0040e52cac976sm1625302wmq.29.2024.01.10.02.21.15
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
Subject: [PATCH 11/18] tty: serial: samsung: don't compare with zero an if (bitwise expression)
Date: Wed, 10 Jan 2024 10:20:55 +0000
Message-ID: <20240110102102.61587-12-tudor.ambarus@linaro.org>
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

Since an if tests the numeric value of an expression, certain coding
shortcuts can be used. The most obvious one is writing
    if (expression)
instead of
    if (expression != 0)

Since our case is a bitwise expression, it's more natural and clear to
use the ``if (expression)`` shortcut.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/tty/serial/samsung_tty.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index dbbe6b8e3ceb..f2413da14b1d 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -988,8 +988,7 @@ static unsigned int s3c24xx_serial_tx_empty(struct uart_port *port)
 	u32 ufcon = rd_regl(port, S3C2410_UFCON);
 
 	if (ufcon & S3C2410_UFCON_FIFOMODE) {
-		if ((ufstat & info->tx_fifomask) != 0 ||
-		    (ufstat & info->tx_fifofull))
+		if ((ufstat & info->tx_fifomask) || (ufstat & info->tx_fifofull))
 			return 0;
 
 		return 1;
-- 
2.43.0.472.g3155946c3a-goog


