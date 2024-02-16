Return-Path: <linux-kernel+bounces-68147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C1E185767A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 08:07:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C02C9B225E1
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 07:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B9C31BC2D;
	Fri, 16 Feb 2024 07:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nbZDNiHr"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4A71B28D
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 07:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708067171; cv=none; b=nEHJ0bp98P19sypC0xC1Iro3ishpMkkU63druqWnJ1ndhxIpC3rKJ9pEyGSZNa4XOUVu4dU4Nu+7ToRxCKJi/fJu+fGsKiGJod3cXAR+23rdhibi5ouNhHHOo9+5mnc9x46tM29MOezpwE2MASof5Hu3/fINhDGIVnYnwR+qN7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708067171; c=relaxed/simple;
	bh=20H7Hn9r4pQjhyhiiMcQlcmQ8QYArnsE20vA7b79kLk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mb+d6FJQ+YLfXkRTQ2b5LFO3AxK8a0P+p5UmGNQ4n5cVIK7JjD4g4VwmDdGozNNedPoVJTCyrVgKMCKR7pnlrHSd8D7VKgbgtI0QtRJTLg5mfFjA54V97SupOnMt/EP0EU1f1n5f/QyE9lfGgEhva8sMD7ENQb5r2vl1C1BpqEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nbZDNiHr; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-412191ed8aaso10663785e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 23:06:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708067167; x=1708671967; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Le6XNl1MSpW8ND9xafZ+XDYHu2w9i8pp90k+8toYjg=;
        b=nbZDNiHrS8PFUiMDVZz9lgYKiYzGyehGCFo4ZtXzvpEKEKn8hHaOp2TTOSmmw9FP5v
         STj6bvz+ns/tmtGdLTy3w0SvSTCGZ43sa/2YW2PltUAa2oi5OXJnGT9TZey2Pyzks06n
         T/9uLEPGKXZCPOGyA7c8zP+wjHXOfrpjJPmS2IRPSJ28f5PAZJX9NUR5qc0pYnw1KjU0
         +s+jAd4Gq+uzja36Nl1Qfvx2Wz2aUNWlBoeegGRsgRVWXpP5oDpMV+YB6x8lfzyWFh2Q
         oPKJE11F25gMYlLtP32AqsGAlRaqqLCLOYg0u8YcgjsWnUfCJIPWEZkl9R0CBH4Yusp2
         O45Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708067167; x=1708671967;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Le6XNl1MSpW8ND9xafZ+XDYHu2w9i8pp90k+8toYjg=;
        b=eAGpy+Yif0fzrxdvDC6j1BWK1M/ropt8gfeLK8xq8sf9e1XGw5T3wYKSQdwok3+6/n
         vyo9PsP66/2IFFgAGwVDEwVVWFSmKRAWJ5i49kQ52/gzU/E8WDSmkh/f1jpTnhZCszrx
         vW7A0EnUAXVaiDLfdgjBSO8CJ832uFAIPwD94WlLblADJ0vQJCPU2VPWNroh+0MGFAz4
         JAGObsiWTScOu2fUryoYWj3RRvm6MDTG+blAxfqj56XLqtFr9iLpj2NaXTNLp9Lhd8Ho
         XtwUTxJuya06tU4dUI28z4CiZt8jeAGOInN2OOjAdH74KnBodez/Hcx8QZc5iZo7IV0T
         hS8g==
X-Forwarded-Encrypted: i=1; AJvYcCXDjozaL73To8Zi5linY9rm/QeHbyE00u5WrBKDAujsONtxuRbd7lJF/mZfTD2u7xmqtjKjsAJtT/tox/TNUyGjlFcH6qagAgi9OV0q
X-Gm-Message-State: AOJu0YyW8CwJ7s7hRrroigV2G4JAvpD8kvaK4k0SsvKxB/qs8EOS9ohr
	SYN2GxtJBCKS3KJNfLGkcIdLhGJ4VlfTzAUP123NYcfcR/SmeeyyNAbbYi1FCWE=
X-Google-Smtp-Source: AGHT+IGkiLaE+HZu8zlPglHiZL4OI53GAHWVvXP9fkAiSIGe1ORL1wzzW6K7wetMNBb2aYy3bf9WWw==
X-Received: by 2002:a5d:4a49:0:b0:33d:11a2:42 with SMTP id v9-20020a5d4a49000000b0033d11a20042mr1761501wrs.47.1708067167573;
        Thu, 15 Feb 2024 23:06:07 -0800 (PST)
Received: from ta2.c.googlers.com.com (105.168.195.35.bc.googleusercontent.com. [35.195.168.105])
        by smtp.gmail.com with ESMTPSA id k18-20020a5d66d2000000b0033940016d6esm1298839wrw.93.2024.02.15.23.06.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 23:06:07 -0800 (PST)
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
	Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH v3 07/12] spi: s3c64xx: let the SPI core determine the bus number
Date: Fri, 16 Feb 2024 07:05:50 +0000
Message-ID: <20240216070555.2483977-8-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
In-Reply-To: <20240216070555.2483977-1-tudor.ambarus@linaro.org>
References: <20240216070555.2483977-1-tudor.ambarus@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Let the core determine the bus number, either by getting the alias ID
(as the driver forces now), or by allocating a dynamic bus number when
the alias is absent. Prepare the driver to allow dt aliases to be
absent.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/spi/spi-s3c64xx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 68f95c04d092..ac47755beb02 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -1279,7 +1279,7 @@ static int s3c64xx_spi_probe(struct platform_device *pdev)
 	sdd->rx_dma.direction = DMA_DEV_TO_MEM;
 
 	host->dev.of_node = pdev->dev.of_node;
-	host->bus_num = sdd->port_id;
+	host->bus_num = -1;
 	host->setup = s3c64xx_spi_setup;
 	host->cleanup = s3c64xx_spi_cleanup;
 	host->prepare_transfer_hardware = s3c64xx_spi_prepare_transfer;
@@ -1360,7 +1360,7 @@ static int s3c64xx_spi_probe(struct platform_device *pdev)
 	}
 
 	dev_dbg(&pdev->dev, "Samsung SoC SPI Driver loaded for Bus SPI-%d with %d Targets attached\n",
-					sdd->port_id, host->num_chipselect);
+		host->bus_num, host->num_chipselect);
 	dev_dbg(&pdev->dev, "\tIOmem=[%pR]\tFIFO %dbytes\n",
 		mem_res, sdd->fifo_depth);
 
-- 
2.44.0.rc0.258.g7320e95886-goog


