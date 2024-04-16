Return-Path: <linux-kernel+bounces-147160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49BBB8A7046
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 17:53:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B2D31C2146C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 15:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C8581327EB;
	Tue, 16 Apr 2024 15:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J6UDNPaB"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96A7131749;
	Tue, 16 Apr 2024 15:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713282789; cv=none; b=QO4CfpvYq5XtJO9fwYTv8PqmkCTDLJnbkDUjdwZlRPoVLtq/fkIG1/8RsIEThG8YGF05YBw2p7h4w4Awde/g1oBt4W4JUpdFQs/sFjOsV2uvNSBxszyFrpA2NUanlUc39p9mIDtUUMgMuLQLyY8z0BwiswLwQpRc2bCWMi5favo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713282789; c=relaxed/simple;
	bh=wn6duOFR0By1a9rcZwmatu6QiLy3rmMNGIJzk+ktlD4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PyyK2tu9zLg+gC4UuyCgfzfESrpktYRJG+L7vCw18QKnPIccNFwDQQQ4AAaWjtMhwYDbSP6b+mgsFduOkBuyFnfDXwxYtDPsuTGvkK3pk+Uv0UySbwqL99wXmfBOf0uyh6fQAUmI4j5551tu9/EJ/3UfNsl3LkxKQ+pCtLTY3mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J6UDNPaB; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-518d98b9620so3179290e87.3;
        Tue, 16 Apr 2024 08:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713282786; x=1713887586; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IXtT3vdT1DlOmZWPolm6flA8JD62wpxOz2LSc4zAwz4=;
        b=J6UDNPaBmTCFwlqdx5HafhDwVbm2qBEeakPxCXVLbk/4lEhSUYhrl3Y8xsX3VlvRoG
         sEAwZ5Uw/3c+eIHCAe2g3QlzSnlz4PRrpzwUxGjcrCAbh7KUA+10z9h/shWvihfNOxWp
         2iqVgucF4FASOSwI7kXH+JxcBvT6MKpybqqMNzjfCeKeDuYvxwrmuXPcv5jPNS29e3gH
         Y9kDZvqT912UvVw7ek7XyILnepQ/3JUnq7aNjDWm+fF3kYaZc4y0tqeJJ7cS/t+MGonv
         U9flfpdfz4yG8MYnAGNno0MLgcdjeTJIPtRb+YOegoZX+bgh5fn/y4DRXYOjXRhZadFQ
         OHew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713282786; x=1713887586;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IXtT3vdT1DlOmZWPolm6flA8JD62wpxOz2LSc4zAwz4=;
        b=IQeopw8y9dLqPaWZvYvhqltU2UBIpVq0LuYXQLtLH1u5L6dFVmfnsRHhGqsCJ506JN
         /FTsWmXvmEKh9VHqAMyHQUVVoaPpH9eBxYCC0vQBsoPS5USTu/hBj1XE1rIxm3HiN/EV
         EmdlVdtdqQudHXy+m8fTooaO2ITn+gjktxgG7iUj2prmcE55BaCFfX1TRZ2Di/sv465Q
         8srYvM+GknkGNLxMxWKznDbxAl+qtv84FeCbF+UZs0pY+pr9GrZztlu03D2bxQqGYgws
         9yV0oo2y+j/9pRtlFAPCsSRGeQHHEZ16HSqh3/kxN3xBtNJbQs5TwgHQJnRXgKxjrwWO
         aHvg==
X-Forwarded-Encrypted: i=1; AJvYcCX8S9IAd5v25SQblNFGrb4CKT5/+y/qLK4GfRl6YmlCmyLQaUoUiMIB6SFtYQ54xzhrttr22rrckk1YhK6ljW8kl5H0LnQVJuSKg7UILBA7lzxn80bWKZizu2UXg/1fVzw+T+EuQAO/
X-Gm-Message-State: AOJu0YzhhsAoJn+kwd9GwDcKL3jtxgiVQu2a9XQD8bm3hXOfwF7WGFdq
	UM6+/xzhQq80VZ1Htwj8kFlvcxTcKKwBHtkHTRSnemhn+SJE+FrwoIyzPfeW
X-Google-Smtp-Source: AGHT+IEM7mHWopWAZZypWiCNUUUTE9ZOT3mcesQT3O6XqnlpLVsiPpWLOnh0rO743E0ShUM8ZQJY0A==
X-Received: by 2002:ac2:51b7:0:b0:516:c099:e785 with SMTP id f23-20020ac251b7000000b00516c099e785mr8253881lfk.20.1713282786032;
        Tue, 16 Apr 2024 08:53:06 -0700 (PDT)
Received: from localhost (srv1.baikalchip.ru. [87.245.175.227])
        by smtp.gmail.com with ESMTPSA id m13-20020a0565120a8d00b00518bfad5ac6sm898349lfu.108.2024.04.16.08.53.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 08:53:05 -0700 (PDT)
From: Serge Semin <fancer.lancer@gmail.com>
To: Serge Semin <fancer.lancer@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND v3 2/4] spi: dw: Add a number of native CS auto-detection
Date: Tue, 16 Apr 2024 18:52:32 +0300
Message-ID: <20240416155257.22429-3-fancer.lancer@gmail.com>
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

Aside with the FIFO depth and DFS field size it's possible to auto-detect
a number of native chip-select synthesized in the DW APB/AHB SSI IP-core.
It can be done just by writing ones to the SER register. The number of
writable flags in the register is limited by the SSI_NUM_SLAVES IP-core
synthesize parameter. All the upper flags are read-only and wired to zero.
Based on that let's add the number of native CS auto-detection procedure
so the low-level platform drivers wouldn't need to manually set it up
unless it's required to set a constraint due to platform-specific reasons
(for instance, due to a hardware bug).

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
Reviewed-by: Andy Shevchenko <andy@kernel.org>
---
 drivers/spi/spi-dw-core.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
index 722b5eb1f709..ddfdb903047a 100644
--- a/drivers/spi/spi-dw-core.c
+++ b/drivers/spi/spi-dw-core.c
@@ -834,6 +834,20 @@ static void dw_spi_hw_init(struct device *dev, struct dw_spi *dws)
 			DW_SPI_GET_BYTE(dws->ver, 1));
 	}
 
+	/*
+	 * Try to detect the number of native chip-selects if the platform
+	 * driver didn't set it up. There can be up to 16 lines configured.
+	 */
+	if (!dws->num_cs) {
+		u32 ser;
+
+		dw_writel(dws, DW_SPI_SER, 0xffff);
+		ser = dw_readl(dws, DW_SPI_SER);
+		dw_writel(dws, DW_SPI_SER, 0);
+
+		dws->num_cs = hweight16(ser);
+	}
+
 	/*
 	 * Try to detect the FIFO depth if not set by interface driver,
 	 * the depth could be from 2 to 256 from HW spec
-- 
2.43.0


