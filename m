Return-Path: <linux-kernel+bounces-606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D779B814378
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 09:22:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85C8F1F24417
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 08:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DCB8171CB;
	Fri, 15 Dec 2023 08:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HrhuLvCg"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E53E13FE1
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 08:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40c3fe6c08fso4599665e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 00:21:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702628503; x=1703233303; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WE4J9sdEbAWjadlcgrRDtUX7vxkIo3SYHmREd1D2LhY=;
        b=HrhuLvCgAyvJKjS4PHjeQWvboAWMZ5PXakURmnPSXSfNkX3V8oN9juOOtbVVYpqopW
         LnBjvENpj9FzRc2A4eBOq06nD7CUsmQb6AATbsxv/S8qO4sTKgV3/+dA5ZBSQTsLKsS5
         NeaTnUw5TQ1t90/Bj/y+ZLuprkuAuOEjwPpvGVfjfaaTDM9TO0q2PKC6hpXABzPXQYDP
         Qc+gknVD2J7SpEZRDM7pgG894nwWo9UHy2Zvz0qTyDBlJ4Z/fA9uHVbDRChMFqoruV2u
         /ZB+03jsJXd0zFMq2Oejr/Pn37zXX2zPETC+EtT3vfUfotJaDtpo5vYNl+eRbEWvmu6Q
         FSWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702628503; x=1703233303;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WE4J9sdEbAWjadlcgrRDtUX7vxkIo3SYHmREd1D2LhY=;
        b=I58M0zdcAnHXeoz7ZgrXeZLWBDPhdwUXZ+3LgOegylkgmtozLkJz1tw9HSRgk+h19a
         6gs1FqJU26iTCnL8oEnPUn6JyVRi513cCqEI0sg1xfNj2hrmFNHS5Xiv/JYy2piLkphm
         Ob+G7OivPrIRpfccg8gPjuuBDiUkzvmcDPtpIRFqZsTDknKuTtFq/pUI324kSVdrxxVU
         geVzmT3ReEv8xMGDtJ7K7pkDQqt/pY3AmszSruQOhvOXIf8UkHBSQp6nqOuCG+xMeZGL
         lW67hYnMJedYXy+mNYVvM8DBQ2sGtTyo1QoazOCvVFN9rL1v+zGoQ+V4Pzijy9elPL4d
         qHcw==
X-Gm-Message-State: AOJu0Yzt/iZTyENmEF4HQexgdgcLBYoMtsxZ8N20E5SxmG6YeRZC1zKY
	v7n+1kUkq8cOpbKfvYfqOW0jMQ==
X-Google-Smtp-Source: AGHT+IGxkZNgiuICrNCLFJ3rZoeDIcqctyrcaLzvdZrAndm8llSBFigGkDTnFtdo2gynrVR2w/tUaA==
X-Received: by 2002:a05:600c:249:b0:40b:5e59:99bf with SMTP id 9-20020a05600c024900b0040b5e5999bfmr4088179wmj.223.1702628503704;
        Fri, 15 Dec 2023 00:21:43 -0800 (PST)
Received: from 1.. ([79.115.63.202])
        by smtp.gmail.com with ESMTPSA id p1-20020a05600c1d8100b0040b47c69d08sm30365570wms.18.2023.12.15.00.21.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 00:21:43 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: pratyush@kernel.org,
	michael@walle.cc,
	miquel.raynal@bootlin.com
Cc: richard@nod.at,
	jaimeliao@mxic.com.tw,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH 1/4] mtd: spi-nor: print flash ID instead of name
Date: Fri, 15 Dec 2023 10:21:35 +0200
Message-Id: <20231215082138.16063-2-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231215082138.16063-1-tudor.ambarus@linaro.org>
References: <20231215082138.16063-1-tudor.ambarus@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1014; i=tudor.ambarus@linaro.org; h=from:subject; bh=fRyfzko8la0oCOG0RX2CCXFxXMrr7i/8B7atPKhz260=; b=owEBbQGS/pANAwAKAUtVT0eljRTpAcsmYgBlfAyRihKH+RI8/qRe0hK1IhGDHTic6pMxXPYs5 LnRM+P/4lCJATMEAAEKAB0WIQQdQirKzw7IbV4d/t9LVU9HpY0U6QUCZXwMkQAKCRBLVU9HpY0U 6XD6CACyrcB+g8TzFuiWVZUQywzLCBw9n8J1TZkKlPXDSge9SYaMxQWXrisUVJRyp4TPFDckCcq g+Ogvbm8MrdTNXYi/rZHjVxYxQQ2nF9Dhrwd5tMNv0Y8MlqgIIV7jN2d7BGiBYzyat2z2+LszYE jX1HuX/mcZvyLxPPTZBGP/YXUOzwGr91zgRQE/bOJ1f56TEGN+0tU+MA8J+QjfUyuj8jeowM6V4 YJZCpPqxk/V3XxKTV5S+r2bZDAz81yj+p3coY3DjhNuKvOXec3yzFJPOiIap3byp9xa6+WfA7If 4DC5Q4PsepRygwyOPgCUhGDsdCmPQsrrE4KCTnZ3PBdngr+W
X-Developer-Key: i=tudor.ambarus@linaro.org; a=openpgp; fpr=280B06FD4CAAD2980C46DDDF4DB1B079AD29CF3D
Content-Transfer-Encoding: 8bit

We saw flash ID collisions which make the flash name unreliable. Print
the manufacgturer and device ID instead of the flash name.

Lower the print to dev_dbg to stop polluting the kernel log.

Suggested-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/mtd/spi-nor/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 503fed90c2fa..ca5bd93d1f17 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -3558,8 +3558,8 @@ int spi_nor_scan(struct spi_nor *nor, const char *name,
 	/* No mtd_info fields should be used up to this point. */
 	spi_nor_set_mtd_info(nor);
 
-	dev_info(dev, "%s (%lld Kbytes)\n", info->name,
-			(long long)mtd->size >> 10);
+	dev_dbg(dev, "Manufacturer and device ID: %*phN\n",
+		SPI_NOR_MAX_ID_LEN, nor->id);
 
 	dev_dbg(dev,
 		"mtd .name = %s, .size = 0x%llx (%lldMiB), "
-- 
2.34.1


