Return-Path: <linux-kernel+bounces-56449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6407A84CA4A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 13:06:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 965081C224E6
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 12:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B962B5C5E5;
	Wed,  7 Feb 2024 12:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PvXK7X5o"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD7965B1F5
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 12:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707307494; cv=none; b=UV1uVj00Zf9wGasYlQDgVGGaoj25RVs9EISPEeL3djsWajG0gi+pS9fnwP8ZbiiPst+4UIJU7BuJVU4C8whL4daYG28/CJJ+9XfJ09NlTvLGQLh/54WuZJdGVuRl412/VDUcFV8tV0/HQJl7uuJPVPYegbeNaMOkt7sXXoU0F+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707307494; c=relaxed/simple;
	bh=kdGbLF6iJyDmWdAvnXmpZOdcHLnnYqMOt0A/+Z5JkEA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LWwxpnzYnQenFfe4asWasmlLKPeZ4km//DfB8cPzA0qoTS6N2cj17TDpf7vdpIba3RIEc8IrgIPLGXfXJuj8+T/EpXOVrWaTAA8VNxvpfYqm+ukqP2ZuuGKJ2BQKOtoTvfX1qBw/Dkf/uCxKrAXTfM0Jbxjnn5TTCLcakfPo4JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PvXK7X5o; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-33b0f36b808so412042f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 04:04:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707307490; x=1707912290; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=txkWFjXph9hZknSg86bxlVXLA+ATzTdcjT+xz3ha6R8=;
        b=PvXK7X5oAvFmPhMllHcYsSA3rb50BXRzON1PV+4Avv5jhHBKMhm0AgIOZTcyuPVi5E
         60YPXNRXq+ZEB7sOUeYLCfZaBlvCWBTnU8D7ykiIE7kfYyw/DWXNoyp9udaWMnHyM8Ll
         ogQW9Ke1Kb4bYlZxpLab8mgYQ5ZsLmA8B13wHBJZtxCsZ1IG8YF18Yvw65ycBu4GdikH
         mXpwsb49L/nlszOMY6BZkURjd8fEFUYwpjRuir1QXrTNcwVsTr7YQ79sFmyUBtU4hj4w
         yWlJXmhgNCEMdyYZ/VMckthroyea73QNGy+jxAgFGtJowYGJtmnTnvhvKKjT3Xh9Wkbw
         KsuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707307490; x=1707912290;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=txkWFjXph9hZknSg86bxlVXLA+ATzTdcjT+xz3ha6R8=;
        b=I+2eNrPa0n27YSANT5MmupWSPYOHDmkTJ683LDLhQl6su/KodiMJfaLu9ztLSF62gI
         JWENSEfGQOLoeepzeyq21fqq+vcsrjaQt5gYzugY1OUWJVI0NqPopuIvM/7KMrZVMpdS
         p5KTgFrqm1P4drOfLhteGygDbb9GiO6kx2QMxm7KA0dI7K1PQGY3wx5Ly/X9YKXhVxH6
         Fb/3PWA8+Pr9YBDfR0dN0RG8DuO2ejwNOtTCVCEZsuQCAqXOe7L+NL3r7ciFnCUcQ+Ha
         7AUjcAvag4uVjj1eClodkH+xNFLCQN5ANnGIFPJfRxeRg5gIHtov5ZvgT+NkAegDcSXv
         pd4A==
X-Gm-Message-State: AOJu0Yxhyd8gNYrgbVmFuFYQYYeHzGtf169wwjojXxnlW7pGCTJQfNlm
	RbVSgMib1ns9JLg1QOSaWBv+U2NbQrOS6Q03w5oWA0QVEDpCE1t0hcbBb8EEzvE=
X-Google-Smtp-Source: AGHT+IFeTN6wfhaVpSblA8kzgrtFG9R6BE/gQX+sizE+n5nfcFk6BEFcG9gAge0rSlWZksqj6bg/EQ==
X-Received: by 2002:a5d:64eb:0:b0:33b:48f5:b5c7 with SMTP id g11-20020a5d64eb000000b0033b48f5b5c7mr4711508wri.11.1707307489970;
        Wed, 07 Feb 2024 04:04:49 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW0S+0NvDpeYaqtK0kX4HKNTyeuKIoCbhT9JX2zrhoZtTAFLxzrio96HJOnqS/xPkTRnyrxxlaximNFjgK0d5eoLo/TAsq6pAG7RPkopLgXTje2TNr5s0Qw9K/1iblYAJT/Nvul/kMncvzBRAeefTXyGaFlIUO5dopvRxyBlxo5pgvA6JsaD8NxCdiBmhy8xvaNRnXyTG5Dcrw1iavjn2VLscWZyMN7rqJ9Vv6aT4vh5WW6kSGU2Ts3zR/ECU8/6/q93PRn3jfUWHTSJm71953zzYld/METrS5ApsxPuxK9cxWLP73dzADRtRj0mn39jBRG6B7q7NUVouU0KHPok7gYmFZL+9urqZ9yJDk13hMoqMJWowfTiiywP1o9m595/rLEHzbOPvZG82mkUt0JzdAyKicjJW4WJimVp6IyU1qTIDAj8UHkD37w1C89HdLmYMuL0L36Ik68Pp+7F3dp2h0HL6tGPs9Nt9J97KDtlMOg4kgcS3IRUFKXRm769Q==
Received: from ta2.c.googlers.com.com (105.168.195.35.bc.googleusercontent.com. [35.195.168.105])
        by smtp.gmail.com with ESMTPSA id d15-20020a5d644f000000b0033b44a349e1sm1349967wrw.38.2024.02.07.04.04.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 04:04:49 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: broonie@kernel.org,
	andi.shyti@kernel.org,
	semen.protsenko@linaro.org
Cc: krzysztof.kozlowski@linaro.org,
	alim.akhtar@samsung.com,
	linux-spi@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	andre.draszik@linaro.org,
	peter.griffin@linaro.org,
	kernel-team@android.com,
	willmcvicker@google.com,
	Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH v5 12/17] spi: s3c64xx: rename prepare_dma() to s3c64xx_prepare_dma()
Date: Wed,  7 Feb 2024 12:04:26 +0000
Message-ID: <20240207120431.2766269-13-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
In-Reply-To: <20240207120431.2766269-1-tudor.ambarus@linaro.org>
References: <20240207120431.2766269-1-tudor.ambarus@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Don't monopolize the name. Prepend the driver prefix to the function
name.

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/spi/spi-s3c64xx.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index ba17c5a04eef..4cafec877931 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -281,8 +281,8 @@ static void s3c64xx_spi_dmacb(void *data)
 	spin_unlock_irqrestore(&sdd->lock, flags);
 }
 
-static int prepare_dma(struct s3c64xx_spi_dma_data *dma,
-			struct sg_table *sgt)
+static int s3c64xx_prepare_dma(struct s3c64xx_spi_dma_data *dma,
+			       struct sg_table *sgt)
 {
 	struct s3c64xx_spi_driver_data *sdd;
 	struct dma_slave_config config;
@@ -497,7 +497,7 @@ static int s3c64xx_enable_datapath(struct s3c64xx_spi_driver_data *sdd,
 		chcfg |= S3C64XX_SPI_CH_TXCH_ON;
 		if (dma_mode) {
 			modecfg |= S3C64XX_SPI_MODE_TXDMA_ON;
-			ret = prepare_dma(&sdd->tx_dma, &xfer->tx_sg);
+			ret = s3c64xx_prepare_dma(&sdd->tx_dma, &xfer->tx_sg);
 		} else {
 			s3c64xx_iowrite_rep(sdd, xfer);
 		}
@@ -516,7 +516,7 @@ static int s3c64xx_enable_datapath(struct s3c64xx_spi_driver_data *sdd,
 			writel(((xfer->len * 8 / sdd->cur_bpw) & 0xffff)
 					| S3C64XX_SPI_PACKET_CNT_EN,
 					regs + S3C64XX_SPI_PACKET_CNT);
-			ret = prepare_dma(&sdd->rx_dma, &xfer->rx_sg);
+			ret = s3c64xx_prepare_dma(&sdd->rx_dma, &xfer->rx_sg);
 		}
 	}
 
-- 
2.43.0.687.g38aa6559b0-goog


