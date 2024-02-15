Return-Path: <linux-kernel+bounces-67461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0367B856BDA
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 19:01:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A99B71F25D8C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 18:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B2301386C7;
	Thu, 15 Feb 2024 18:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XGpGn8ec"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F981369A5;
	Thu, 15 Feb 2024 18:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708020087; cv=none; b=BFKx2XMKgysfCgvQdWGAn2shmcdhEtK3i/hkn4uYEqU4QNZ0raQymnf874YF2mKXlXG8JTVEUoIRDAhBvcvdmUZ2JkeAldQfN32+OqZbKBX/hlWuEhalwPZnKj7BF6UTFRGl1c+onk15XsPf82BUIL/cSlvgaeIAsHAq3wbXjD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708020087; c=relaxed/simple;
	bh=xxvmjWW84hnS6jVrUMwkpVn2pbnGr3EfgjkVUWZRK3U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YRVz2tE8mf6yZKuHK9YRmVBg7J+qZlytw6wBgdfCs9ccRtDhO3i8K7euwi7zCQX9XGpIz4h3dHl+q1V+QQXIrpYsYBvXMkdH+msH8FkqPCqZW3G1kMisrXsd1GLHPa14Q362eDBHzMgCmgnyL5MOmOZKR+JhRq0FtnvXZwB2YuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XGpGn8ec; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-511acd26c2bso1698106e87.2;
        Thu, 15 Feb 2024 10:01:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708020084; x=1708624884; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KLCazRBvduZGAf5Ar9NFgHrrEMFYuzekFNqGJYTp0sg=;
        b=XGpGn8ecojc5NSHb/eGqZTCSEiARH5KDKwNWdtBasRFO+Xa0ui2jXS7cni8cuDYYL2
         di0W9DF1rpKmnLuaT9HbJhj8YGm3soFcKny85iLsfTHYduHJXOTi89AaLfWbzffGxKkx
         W+HFdCwyCsX/DNZbiR0kzOVPb5JF7F/LXFPhPZP0L+8NNlAOuZ2FEECz6Ti+9IWwGT3r
         QkhvAJBduHbGTSkCZgG+Ee6Ter77+9mgxy/0XAvrzgUbdnr4y+laPP7wpy0PqIM6e36b
         lQarqlc7wIZObe9mcRa3tLXPPD9UAf9fhKd42ak8Lh2dBMtnRIJkOWLRc2zR8D/NQowv
         +OrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708020084; x=1708624884;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KLCazRBvduZGAf5Ar9NFgHrrEMFYuzekFNqGJYTp0sg=;
        b=l7ZGsZNQ/Q/2YSLS+3g8ElGA/2jQv0aTpSIM2YHC4ECTNJpwVlWwpnhyO+RkkiN3ff
         WxZZuy7w5N56qnYp/Hi7P9vHlqbWFy6da3Ef3dzJkqJZZp13ZroOldiXaB8/aoSO85Y8
         BLBQnpcBpQsGc85QCCR/on6HEhdthRxF+FeACUfMl92U9IuuxMyHzrL+NOmeEOPZleEh
         jcS9b8isI7yIaBosdpmbRsjkNsjvnZozXI1KHLpXt9GQMdkWvhvSLNVfmmmutfblkmYO
         s1QDPXxE0JsulamlQpq+SxlmoJqgKNkFtKovx5x6hByMaY9FEVcR/g0AmhnC7/oeb1LD
         rMug==
X-Forwarded-Encrypted: i=1; AJvYcCWGGi3HNaAJD6HCnkaakNe/QpuLICMX6nB30drCYPENdT6nAO0PvZXXCBlpklxmfUis1ds2CB2OU/RxiJCaI87k7UDDxm2zAQQ24CW2kOkCFpnBlf+ju9dzcWlyMRq+HmXC5BIw2RIJ
X-Gm-Message-State: AOJu0YykjXo4ZUKRHaxU/9Kf+K82SOlwvCI7w8W7HvLhFixgzSm4jGLk
	inlnXinm1HKf8eA1K2dT0+iFc93Ha0kYtezG+ATxP+DJFzkutsAB
X-Google-Smtp-Source: AGHT+IE2PsiXLadHOxSwqZDMW8Gx80g8l9fmNkSGfT72WedmKy9V/tpN5OLZir30MFjeEA94hn73Aw==
X-Received: by 2002:a05:6512:3e16:b0:511:79ac:2d78 with SMTP id i22-20020a0565123e1600b0051179ac2d78mr2399451lfv.39.1708020083333;
        Thu, 15 Feb 2024 10:01:23 -0800 (PST)
Received: from localhost ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id v22-20020a197416000000b0051181cbea91sm321468lfe.228.2024.02.15.10.01.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 10:01:23 -0800 (PST)
From: Serge Semin <fancer.lancer@gmail.com>
To: Serge Semin <fancer.lancer@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] spi: dw: Convert to using BITS_TO_BYTES() macro
Date: Thu, 15 Feb 2024 21:00:46 +0300
Message-ID: <20240215180102.13887-2-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240215180102.13887-1-fancer.lancer@gmail.com>
References: <20240215180102.13887-1-fancer.lancer@gmail.com>
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


