Return-Path: <linux-kernel+bounces-61788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96B7B851688
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 15:09:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B91D1F2409C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 14:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3AAF3D56A;
	Mon, 12 Feb 2024 14:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qhMfyoMh"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 207123D3B9
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 14:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707746629; cv=none; b=PJbrWeTW1HK5mDo4GBh1cop0hcAGP96H+EFHE4qlQzcxiXPX9BsVuT3LxBbyi1DJN0WYDLNNQ9gg8bwSgXayw0c6mQL3j+3YOeKXeIvXBdlnpX+Ml43jEmwsPVupsGIqJhIntcnqqj4zV3Ehh8xDr8fuYzShHxQv6Ji+MCHIv1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707746629; c=relaxed/simple;
	bh=1ZMGRL2bdDrzE8jpO2TRP5Gv5JmPakVuDy7jd5uzp9g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=owqOMQ7xcjiC9YBoAXCC3cbDhYsZzC7/Mz4Mtj6S+viu2LmR90hxh3pA/1FIqPWTTaNuCjCf7zIxA3n50JeALhOqlBWMzWNAkwaR3tV26HA90oIdgicDo9521qiAifQ7thEVMNyqEwQyg9AAWEVAYyEHQfGzdWjSnXS5f+Fg4Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qhMfyoMh; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-33b29b5ea96so1511023f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 06:03:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707746626; x=1708351426; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/YEBZ5QgPmZi1uvEzjonJi8xfKR7wdfW/zkTSEaERIc=;
        b=qhMfyoMhv6kO3y6XvrZHzeQ3EtdSZdIiVNO44hMWpr0tpH/1oLtV4sE69FOE+eCgEi
         q0HPP+X3I2fOy7G11ATwX1zt9QwfZ6UqtUQi8L3Ks57tIPTklpy0SO8QXXR7iL77T1Fa
         G6tecTfAJF27E+bIIO3YBvqzZ6M1kwqU1+kC/jwSY0yPrMlo0NN3hYElPssf9p+hmx6c
         xm59ixdVwA5GqrrRSUTREShuFti9aWfHZ3diwMrsTVL50OjKmlPkQFIc1ubs9T/+r3SB
         +ssEbNMaMJ0rIX6BRi6tK0rBDagtJqanE9PFI9s2GyAPVBEupeAJdaJB1zVnzs2p8h+S
         wlUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707746626; x=1708351426;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/YEBZ5QgPmZi1uvEzjonJi8xfKR7wdfW/zkTSEaERIc=;
        b=wYqH+wPKoJDAVTOgFBj/wrUZmkTM3+sU2yPeumYFxJumA44emVjMX6w/mqJIToTspx
         qVZDMf0glo1OQ/waeHMTDXV3o+vofzVOuIaGG5yQCHF5k+JWmw7H0gxHSYr2nhC9alzY
         DRxTm8jstfoxNH3eURCyrQP7y9SBxEuZXK7VjlN83Uw81qlvu8O6hWTTwvI8JpZzrNri
         B9+18UJADPlA5HJj5XJspsynVs66nBvrfLGLWPohXwL68aVZnUC5zK1IulHaBbfAacwz
         /PJnGKLMw2pMsO4MwkcAPwEU7KZl2taxiAkIh0Wow4I/2zF+C3Nyo8T8ut+GqKCs+cZh
         2uuw==
X-Gm-Message-State: AOJu0YychWw/3NJCO5DYGCsW4i9rpujopG7i9o3J8PWQ2lRDRuoqmC0S
	Oe0x/x3MOQAZv6UnHkHltCLp34rtoP4FAtJHq9JyvrdZZcdFJVP9/PeSsUjcoFY=
X-Google-Smtp-Source: AGHT+IEMUn/Ujlv8/99OYN9W93mnczYnQYRRrEaW3In2VMr/6ZWLFAs8f8nYbCIs3nWugXOejnzsxA==
X-Received: by 2002:a5d:6388:0:b0:33b:8604:5068 with SMTP id p8-20020a5d6388000000b0033b86045068mr1747857wru.14.1707746625898;
        Mon, 12 Feb 2024 06:03:45 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU+avd8wL8iuEOUD3YPGF+15CK03P0cMjdZum0FGwAAFhBEXXM8bcsjtPURQ+6z2liFzq4eodzK1auoo5Q3JYv/PdEKLDtyJzaOjX5EZOUxC3hUcXyz5J6AJBEeVbrRKek2MaBBETDKc0GPmJSG3fdAUpvmsSIgmOlIBpComLX4JWaCLaNU3GIhjR2nmPqwY6hp3wpaiotOLOQFA7ymTcaZtYpqt5wfnJDkhhnjsPYgNDgo6ebbf0VThnJs+83vsKZBe1gIyB9bzhivHNCUFQKotEI/rqlAZrhyHeJPL1NVNoIdgJ17Cyd+jj7SHtE7VBU6x7VPFkAruymYIKUVoUlgax0uWFtAFFVtD5Q5AgwVfcMkR/IRpujPBRn27Xkd8Abb61qxvfZOfe+wxHciX9o9MxXHM6cgGAFQ+A6OdUFhWGLbt9n0cLXZ2aLW2xzn60WEBJznrlbSY96JSrm0s7pGz2xLqAlcLRQDBQHufKZWANCRNcbw5+MsxpWsrKcLIGyrPCmmv0+F187ecNSQeOhLD1e+frqyOzQH1q084u+IKoy2fNRUL/cF8VXbPr4KRr2F3S4nBraBQGjgbOpMJHx0RRGQjrYnj/jZU6CVt6eaSe/BVxE=
Received: from ta2.c.googlers.com.com (105.168.195.35.bc.googleusercontent.com. [35.195.168.105])
        by smtp.gmail.com with ESMTPSA id v9-20020a5d4b09000000b0033b843786e1sm2135356wrq.51.2024.02.12.06.03.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 06:03:43 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: broonie@kernel.org,
	robh@kernel.org,
	andi.shyti@kernel.org,
	krzysztof.kozlowski@linaro.org,
	semen.protsenko@linaro.org,
	conor+dt@kernel.org
Cc: alim.akhtar@samsung.com,
	linux-spi@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	andre.draszik@linaro.org,
	peter.griffin@linaro.org,
	kernel-team@android.com,
	willmcvicker@google.com,
	devicetree@vger.kernel.org,
	arnd@arndb.de,
	Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH v2 02/12] spi: s3c64xx: define a magic value
Date: Mon, 12 Feb 2024 14:03:21 +0000
Message-ID: <20240212140331.915498-3-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
In-Reply-To: <20240212140331.915498-1-tudor.ambarus@linaro.org>
References: <20240212140331.915498-1-tudor.ambarus@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Define a magic value, it will be used in the next patch as well.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/spi/spi-s3c64xx.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 6f29dca68491..6ff3b25b6feb 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -78,6 +78,7 @@
 #define S3C64XX_SPI_INT_RX_FIFORDY_EN		(1<<1)
 #define S3C64XX_SPI_INT_TX_FIFORDY_EN		(1<<0)
 
+#define S3C64XX_SPI_ST_TX_FIFO_LVL_SHIFT	6
 #define S3C64XX_SPI_ST_RX_OVERRUN_ERR		(1<<5)
 #define S3C64XX_SPI_ST_RX_UNDERRUN_ERR		(1<<4)
 #define S3C64XX_SPI_ST_TX_OVERRUN_ERR		(1<<3)
@@ -108,7 +109,8 @@
 #define FIFO_LVL_MASK(i) ((i)->port_conf->fifo_lvl_mask[i->port_id])
 #define S3C64XX_SPI_ST_TX_DONE(v, i) (((v) & \
 				(1 << (i)->port_conf->tx_st_done)) ? 1 : 0)
-#define TX_FIFO_LVL(v, i) (((v) >> 6) & FIFO_LVL_MASK(i))
+#define TX_FIFO_LVL(v, i) (((v) >> S3C64XX_SPI_ST_TX_FIFO_LVL_SHIFT) &	\
+			   FIFO_LVL_MASK(i))
 #define RX_FIFO_LVL(v, i) (((v) >> (i)->port_conf->rx_lvl_offset) & \
 					FIFO_LVL_MASK(i))
 #define FIFO_DEPTH(i) ((FIFO_LVL_MASK(i) >> 1) + 1)
-- 
2.43.0.687.g38aa6559b0-goog


