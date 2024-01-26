Return-Path: <linux-kernel+bounces-40414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0002983DFC4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 18:18:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 841E628425B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 17:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D44D8225DB;
	Fri, 26 Jan 2024 17:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fucHrFmM"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0B522337
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 17:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706289367; cv=none; b=rGwWHr97vtykaNlBSl3adSe/oIdOrEGoqbEjAep6OqGgMx770L7b08T4xTnD0dTI1ruh6pW91jTfqeMRzNHj2AkouRAHtUrRqH764pZtk7FJa5s1p1L+ttvNtssAPu6UFoY4J3EnZR8Tf9T6GK6S+q1kf7aSMxKdixqQo0AG/yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706289367; c=relaxed/simple;
	bh=a6FJG4QFicbHTdcTRUUoXVt6YhxyTv5CKU8sFCbQbwI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LX4Ry+uUj3ALxqlgzGCvwlRGYXsv8xeORiIHymG5SUDkWF1M9pPv9R/ydnp1oP297eeZZtDWgNJlGJAEJj4K7u/gCzJLGAt0BASr3ldZ8uuXhsS3mUKfX78L6cFQPbYDbCqUCUZxoJuskAskY2T4SxSDu/ILmxGbLUn7DGj/ggQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fucHrFmM; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-51022133a84so780791e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 09:16:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706289363; x=1706894163; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ndYor9VIkq6f4pBg/Nd55Aw4wNpXBPkalwBZbSLcCVs=;
        b=fucHrFmMijzQGYvuobb8+LEOf97esmp0UtM9WZ7JIjMtfXWekoq3jG42SbzBcSQEak
         fgi6S6aEtALDgQ19U8na+hlQoxLjgpASB89e9p2u0dxazQgn6gXVUv9rct3DOMyceank
         0nf7F6iTvr6cok7g411Xz4rhbr4zUVmdP41Lqg9rYBdMPBvRHh4vs7cGP7CMZkMSZtA/
         JhgXdV5UXtD3WKfgafPOef1/+QLMMQP7xQHEpCFERTXCdTEE2E9Dy7betaeo8Ft20SF1
         NcgSYT0lhCR/+xdy/AIdNLY9G9Q0l9jpmwa1smJcP4BEdCiaM6CVenoI6Vx3M/75uP6N
         ibeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706289363; x=1706894163;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ndYor9VIkq6f4pBg/Nd55Aw4wNpXBPkalwBZbSLcCVs=;
        b=R/c2j7bICJb4Jn/LlDIFXWnwqr68JWvRwxTxphaMVAdszS3Qg5hbVBi6nIMjH8CJXO
         qhDRpwLTdwt2V15NW9NCW+L07pY8Bg9Uw0eQIOBEUQ2bXAOArkYWWCGGVTDfq6l5Pnyx
         PdoD3tkJXNq/JZ1qQjTJnJbKpAHaUyf6Ycuwm5b5wYXKYe95UF3Y8eVfGx/RXBD/OibN
         SRCQLt4/sMBRbpgfJ/6Ta5kQJyadr/5hnMirv59cRGEVRSqMXbtRJt6aMO110jex1rfX
         98JYgOqJiiqXoPILYU5lEkIbWkskNr/9PAtv3PHIUz4YG4BRLzwAHpb5MIcq5l6Vh7fz
         r7xQ==
X-Gm-Message-State: AOJu0YyBr9KuHJMRAU/DgKHw84u9Mx5RRk+S41zVPntmULofKOVw5pZ1
	MunrDL3Xi9mgUjvLs6OPSxngGCDZCiSaDrwLYiHXJMr7HNwrm1s74ER5XQPtFKE=
X-Google-Smtp-Source: AGHT+IFEtRaaitooDido15ekLBkacrVyqkBTdRgKQbRruG3+KRsCCYWnu1LvbW+f3Xs1EHiodmYnYw==
X-Received: by 2002:ac2:5a11:0:b0:510:272c:d011 with SMTP id q17-20020ac25a11000000b00510272cd011mr187130lfn.69.1706289363696;
        Fri, 26 Jan 2024 09:16:03 -0800 (PST)
Received: from ta2.c.googlers.com.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id k10-20020a05600c1c8a00b0040e451fd602sm6287286wms.33.2024.01.26.09.16.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 09:16:02 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: broonie@kernel.org,
	andi.shyti@kernel.org,
	semen.protsenko@linaro.org
Cc: krzysztof.kozlowski@linaro.org,
	alim.akhtar@samsung.com,
	jassi.brar@samsung.com,
	linux-spi@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	andre.draszik@linaro.org,
	peter.griffin@linaro.org,
	kernel-team@android.com,
	willmcvicker@google.com,
	Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH v3 12/17] spi: s3c64xx: return ETIMEDOUT for wait_for_completion_timeout()
Date: Fri, 26 Jan 2024 17:15:40 +0000
Message-ID: <20240126171546.1233172-13-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
In-Reply-To: <20240126171546.1233172-1-tudor.ambarus@linaro.org>
References: <20240126171546.1233172-1-tudor.ambarus@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ETIMEDOUT is more specific than EIO, use it for
wait_for_completion_timeout().

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/spi/spi-s3c64xx.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 76fa378ab5ab..2f2c4ad35df4 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -526,7 +526,7 @@ static int s3c64xx_wait_for_dma(struct s3c64xx_spi_driver_data *sdd,
 
 	/*
 	 * If the previous xfer was completed within timeout, then
-	 * proceed further else return -EIO.
+	 * proceed further else return -ETIMEDOUT.
 	 * DmaTx returns after simply writing data in the FIFO,
 	 * w/o waiting for real transmission on the bus to finish.
 	 * DmaRx returns only after Dma read data from FIFO which
@@ -547,7 +547,7 @@ static int s3c64xx_wait_for_dma(struct s3c64xx_spi_driver_data *sdd,
 
 	/* If timed out while checking rx/tx status return error */
 	if (!val)
-		return -EIO;
+		return -ETIMEDOUT;
 
 	return 0;
 }
@@ -577,7 +577,7 @@ static int s3c64xx_wait_for_pio(struct s3c64xx_spi_driver_data *sdd,
 	if (use_irq) {
 		val = msecs_to_jiffies(ms);
 		if (!wait_for_completion_timeout(&sdd->xfer_completion, val))
-			return -EIO;
+			return -ETIMEDOUT;
 	}
 
 	val = msecs_to_loops(ms);
-- 
2.43.0.429.g432eaa2c6b-goog


