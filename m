Return-Path: <linux-kernel+bounces-157159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD8398B0D94
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 17:07:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0C601C25123
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 15:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 880C615F3F1;
	Wed, 24 Apr 2024 15:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MlWdgoJE"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B3115ECFA;
	Wed, 24 Apr 2024 15:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713971239; cv=none; b=sHilMXYfrbEI815H9mc8W8eFZ4FuvEyINEH3rSyDhhpUTMCmmMFgs30uhFhvry7out664p6Sc5yOJKA/fn8xIB551U+2XEZJmspfDMGQkICy/8HDdvVsS5uBdvTkxWZE429QUkzjY1apBrHZfm9sEhe5Gty0/A1vdM+mVSLXmV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713971239; c=relaxed/simple;
	bh=K1UkPr+qwrl0AxN89XM75ZcSZhSG0ZNbLMmfwU7qP70=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PfVuKr2taIpVftAXSkx3w7L9AB7GmoHVsywNNU1uVa92C38a31bbIMjNGB0k7X9eLi2JSAFmfgJ5VKSLpPfGniBqIvgtpGwlLakXsm9b7tOR+KWkEza0yJR0EClH4635AaZgwSsewyHMA260oaSVqt/Bzo8ldsXgAEO0LasCHwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MlWdgoJE; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-516d1ecaf25so9110562e87.2;
        Wed, 24 Apr 2024 08:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713971236; x=1714576036; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YkIadt0nAZR1d0O39/7H5hjsJWBN2vmdJ6bdv/9nuZs=;
        b=MlWdgoJEB/yTUESiLLIdjQ+QH/AlJinjpw4qfExO/1XNXCnYUa/Z4pCHTGbSWFxOGr
         reOPfZl4mBkbOITHRm9S8b7fGLikxebb0C6vm/ybKcxZU/pLJ7hMjRi6gI+4jwPy5NQO
         qvyUILN6Hdv3UMvpUMshV0305GH/u5G3gdvdpPBbaaTmzkNk30klJbGa0q0pnUvvhjpW
         TgAAUIWrOcZ2pGTH9HioiZ6ZgKadsFY2hI9h2j6EWQGr2++qHoz11QeqpL7VQMyW4v4g
         8SkXdaQNBukew10s3Eb0BVFYOEpJs1UciJaRooRWLDD5BpmvadtGEdsViYRPJ1X7+jOC
         uaEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713971236; x=1714576036;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YkIadt0nAZR1d0O39/7H5hjsJWBN2vmdJ6bdv/9nuZs=;
        b=XJY3ljeDP6m64YPQKo7rkoo2Dp7xhsSG0Ke0Q1Vkq5wPaKQZXtP6iJdKHy7VjHKDLP
         cSFUDX/u0UCNadlJHg/rSRuW2YNZNMX6lrZV4xiWs8aOhMHB8uNqrHO6ceddOtGXqfLB
         l8PJG0+7JPVRPNwzZB6bMaWXenJqq6Dqv2VBTUKpuYNAkjNw1wnLiwl9/OKd5EHMr4E6
         CrsuVqQrnxOs3R7M5xVTXhDy27DKqSZ0Y3/ybJAo3CeaYGqcL2E2iD3P0XwxUWpPdCsj
         UfyO4g/I9aDT8k7DH/oTaw6ovDDSBYqwfk1Q+KWWyLb0mzfd22AQnjd63sZ2g5ndyKrY
         mlaQ==
X-Forwarded-Encrypted: i=1; AJvYcCVO0IYkGVrhvPwGhaVrLOBIYGVYr6DZDkwbqDEliXGEGQ4GxddPoth+qfZ00gafiDSPNmoulIqmEAo55jtXgS3M2yEKfuwPDik/lFMw167mAUJeLenYYwit0Ijz4dfLak0ge0A103hn
X-Gm-Message-State: AOJu0Yy0hK+XtFBNviHzjgqP4BwmF0eoir7fd0mGEmbMNj3UePQje3Pn
	iyJzYlzSRFXYfxbyFvqjdN1PyeLWihu84ZWxywIIvgdUZrx0lvFX
X-Google-Smtp-Source: AGHT+IFKR3aIMaG4k6RQKdu1uyQ9JThl3xv6DWlgYkNU2HNj7EBr834s94d2fI8WSxe0rvMURCdQZw==
X-Received: by 2002:a19:ee19:0:b0:51b:79b7:8322 with SMTP id g25-20020a19ee19000000b0051b79b78322mr1935006lfb.52.1713971236220;
        Wed, 24 Apr 2024 08:07:16 -0700 (PDT)
Received: from localhost ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id v28-20020a056512049c00b00519558f5d83sm2432171lfq.289.2024.04.24.08.07.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 08:07:15 -0700 (PDT)
From: Serge Semin <fancer.lancer@gmail.com>
To: Serge Semin <fancer.lancer@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Andy Shevchenko <andy@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND v4 1/4] spi: dw: Convert to using BITS_TO_BYTES() macro
Date: Wed, 24 Apr 2024 18:06:42 +0300
Message-ID: <20240424150657.9678-2-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240424150657.9678-1-fancer.lancer@gmail.com>
References: <20240424150657.9678-1-fancer.lancer@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit dd3e7cba1627 ("ocfs2/dlm: move BITS_TO_BYTES() to bitops.h
for wider use") there is a generic helper available to calculate a number
of bytes needed to accommodate the specified number of bits. Let's use it
instead of the hard-coded DIV_ROUND_UP() macro function.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/spi/spi-dw-core.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
index 0274c9295514..722b5eb1f709 100644
--- a/drivers/spi/spi-dw-core.c
+++ b/drivers/spi/spi-dw-core.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/bitfield.h>
+#include <linux/bitops.h>
 #include <linux/dma-mapping.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
@@ -421,10 +422,7 @@ static int dw_spi_transfer_one(struct spi_controller *host,
 	int ret;
 
 	dws->dma_mapped = 0;
-	dws->n_bytes =
-		roundup_pow_of_two(DIV_ROUND_UP(transfer->bits_per_word,
-						BITS_PER_BYTE));
-
+	dws->n_bytes = roundup_pow_of_two(BITS_TO_BYTES(transfer->bits_per_word));
 	dws->tx = (void *)transfer->tx_buf;
 	dws->tx_len = transfer->len / dws->n_bytes;
 	dws->rx = transfer->rx_buf;
-- 
2.43.0


