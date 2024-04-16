Return-Path: <linux-kernel+bounces-147159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38DD08A703E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 17:53:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC52F1F2182A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 15:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A647D131BB9;
	Tue, 16 Apr 2024 15:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E/m0ZLnN"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7834A131726;
	Tue, 16 Apr 2024 15:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713282788; cv=none; b=k3k6V0U8mG/xXbOqs3M+TOUq+I6FbOyePxMZH2ODhOTyZryG4TggLP5ZXpV/miKZTVKxz69prseWSyldbcGgrzgL1xQEVHni8m/phUV5JOQ1B+pVwmrJMudecaZ4mol7xaqQVSdcY0WJ2eKwek2zkHMCIFtpqUoW0hdtRzNnbIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713282788; c=relaxed/simple;
	bh=K1UkPr+qwrl0AxN89XM75ZcSZhSG0ZNbLMmfwU7qP70=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u73qIvPgtcum6EXwswR7Bm1xfwfWEX4uz+K/ZVMcrNyw+50vX7VOKWko9bBg4O60CmwNZYvSU0a5vjUcYsWzLo9rx5OXstqqhIUXAPcSq1lRuEqjodtVeLlvMX/E5hfIyIiwjVPy9PyYGqv8/f3O9Y6jB4xF4qDZJgxURjevDdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E/m0ZLnN; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-518a3e0d2e4so2912593e87.0;
        Tue, 16 Apr 2024 08:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713282785; x=1713887585; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YkIadt0nAZR1d0O39/7H5hjsJWBN2vmdJ6bdv/9nuZs=;
        b=E/m0ZLnNABqKxFA6IrKK9TzkdnKmL5Md9nuSf506ukTSx9ILAzcl5JyMtNNFphNomM
         FUbtDuMdvMwwtefXEluoVkkulgNvuPAG0mqKCnuWhX+Xh5Btzlo0BQYMgl7O7wxu5o4X
         kAyEQVIh/XfNZE1estVBDnZ+CU7TQv1t69BcdaorBWe+FaZZoikPf3IFoQvwyd6dD/v+
         RV+SMj2X1pSbAi1Dzl5eW7lwuIje8vYdU2JKPypifz08hfoRGZSMQHjHLtORawdD2LPa
         IAxSZedJIXiVodEmHcDnspywV63faqssuedb8Y4ZNI5SLdFg1qXX+W0ACcG4ex96Lzax
         PdNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713282785; x=1713887585;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YkIadt0nAZR1d0O39/7H5hjsJWBN2vmdJ6bdv/9nuZs=;
        b=ah+1GrdUMvyDb0q0gnhE7WQ9bKpq3E8ftt10hTMvjecQvdFO8VAPSEx8RcQLGfE+WE
         6I9TRjzopLqQ7ShZb3ULhnFo0Ow9LpS89wAE6QnVg6zvvWO9zgPpZJywEACUBhRHDYzp
         Eqfb2laYPwdVe2bRP9hGJvPgSsBqnoF8i0C7UzebjjQr0KW5ijfFuBLa309StkNcnptt
         fFQOf+Kim5GP0EmDRg0BzgT8K5OSbXrZc3argDuL94BEI/MRmMq0prppKKI5MbobflIe
         X1ckD6IYqHeYb2ClZ4f//6OFpTl6hus5g2bRnUFuQbW+QXkWbl/tfMiFj8hDxmRd8vXk
         bSsA==
X-Forwarded-Encrypted: i=1; AJvYcCXmW8RTP9V+ZqMbzw07orhDqG6PwvgRDcF9YotWn+TR+AcK6PfQoJb4AAttHWJmV0TCTRkJmJ0lXfb1u88YE7pfXfF3wWRWwmS9JiUE8sfQApa0Ew6HhZIJxjT+yOF4gooeeSYAusdk
X-Gm-Message-State: AOJu0YzOxwc7YCXZQBtwv2hrJO4fDnn2sIbkvnKe61sZOBBgX6uXkyyb
	Ibj/Cslv5+KZ3JOwBaduuJN5D4Q7+n5sxugmgBW8DeApUfSpWqEK
X-Google-Smtp-Source: AGHT+IEmlsKuTvv29AZcjbm2jgINk5kqSdt8EBTvnGKkpTK8/cz3AsyabAHVN49eico5elcIoVkQAg==
X-Received: by 2002:ac2:4216:0:b0:519:16cc:aa72 with SMTP id y22-20020ac24216000000b0051916ccaa72mr752455lfh.13.1713282784376;
        Tue, 16 Apr 2024 08:53:04 -0700 (PDT)
Received: from localhost (srv1.baikalchip.ru. [87.245.175.227])
        by smtp.gmail.com with ESMTPSA id t4-20020a056512068400b00518b3b1b0ddsm979082lfe.259.2024.04.16.08.53.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 08:53:03 -0700 (PDT)
From: Serge Semin <fancer.lancer@gmail.com>
To: Serge Semin <fancer.lancer@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND v3 1/4] spi: dw: Convert to using BITS_TO_BYTES() macro
Date: Tue, 16 Apr 2024 18:52:31 +0300
Message-ID: <20240416155257.22429-2-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240416155257.22429-1-fancer.lancer@gmail.com>
References: <20240416155257.22429-1-fancer.lancer@gmail.com>
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


