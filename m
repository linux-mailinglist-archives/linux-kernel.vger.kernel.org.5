Return-Path: <linux-kernel+bounces-67462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 31236856BE0
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 19:02:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B81FBB22E32
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 18:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4433D13957A;
	Thu, 15 Feb 2024 18:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hLijPB+4"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDAA91386C1;
	Thu, 15 Feb 2024 18:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708020090; cv=none; b=sYL1TVLGfbLL03+R0js7H5Iz1AYe912QW0e1nNz68rErs75rNabX0rpbe7oJZatMGB/cHsT3p27SNyQfbLTRLRhv1rA7d+g8NmIs3eWP1C+xxzcN4Ydeuu5qT6I9UGbWd+MH3F/TuD9XdGv4atVk0DFhyTUytFhA0NEArK/Dl4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708020090; c=relaxed/simple;
	bh=KBAkQBgpYdLDaJ5qYLlC9p8SlXhmDfw3UvehvJhSkG8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I5TFkfZCITTvjpoNLnXNAQTIqFSW7fJn06K4pdB7c4Dmws0mM2caOj4+3Q5OxNUWyWg+41cKKaMVg0U4LaHPxwpYOHP2Bsk4T4ehLHjeqCrPiRyN2VjPVtecG8oPuLgfZOEEQDTF9iUDQ68yzbL8F8ZECEa7ZqlKNm5e31Pyyok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hLijPB+4; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-511831801f3so1203100e87.2;
        Thu, 15 Feb 2024 10:01:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708020086; x=1708624886; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ef0c0lkPbUi43MY5AODLBrbnTIwKOtyjY4A1tP/i59I=;
        b=hLijPB+4/4rFFtoTdtnw2fOkvvknMJy5zQa2JWAzVoaUruqBbQDdRrNQQyQ/qsbguP
         CxKzJj3BQrDN3ChRd0ODgflCTHamKWQDoHweML6EO4t2m6Ft/5/zumNljIG03DRxHN7c
         5zDvvKSLPueDayZwEcj5VAE97HSfkwtKdMiffOTIHGhPK7pGcx+7LnB+8Vse32QBVV5u
         ilGqQZGzrK0ljTSV61NzYUCa5jnV7nyBGzDTlFFTEkkzz6SIEqjcPBgIfGuUbst2NFQD
         AZshjoOZhoJcB+YzN5hjOdXymhjyE0pucaW4TcA5CDR6EVmp9qe6hel6T4CxgTu5iVB7
         9/iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708020086; x=1708624886;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ef0c0lkPbUi43MY5AODLBrbnTIwKOtyjY4A1tP/i59I=;
        b=opVCDZ2Hkw3u/o/0JvvQQKJd+5F/baiH9hjDQGrDfULCsi6UCh6GEz9ee4/BoTaVG6
         mLBtkQq9kN3iY5H+OsN4H3h439szjIiN2urwtrhWyPphiftKSqIJ1c0BiO9jXLBouX5b
         hsax+BH5Ero33snd7Zo/PoJJB/lDzNXi4pKozGaoldYjD7YMJOcC3CfsCo7U6qWP2N7M
         pijjrK59ase9JWW0h173o+SNW9dPHX2rXWrsQhBU+UyUz9tF/n6SxIu3fOK0NHJIDgv1
         fa9BLsxyGn+RptiU7OWxHRbkp+00IVQjMoPUcc8cDWoffE4htjqRcuZhb8rdo5kqRw94
         ShyQ==
X-Forwarded-Encrypted: i=1; AJvYcCX8OPJvcE8sGa7r8bIoraQPiEGcpFflrNixHbqMP1S08yyzbxAWRL2vToGuSQl2sHffWdKR1QjS+wkDrwTZtiwNFCvpEosz18IeCZPWASE/6tLBIguE7MWNPu+egyXiCXQLDKut+DyV
X-Gm-Message-State: AOJu0YwC5PoqamiZ1qb8lrS5EsH292TFz3pRg//e5wiRF2BjMXoN4GBG
	cCAbD0KX9oCoFn/7ybGBpzLgJ6MQPtVdn0OLuAiOWEemuFWfDtcs
X-Google-Smtp-Source: AGHT+IE3kjOjBIYNu7pta6dr3IsJP/y0uHdXKvZJgNO8NsrO5bMJJ3ZqnjP0knzCSwR9grPsg/XMZg==
X-Received: by 2002:ac2:59d0:0:b0:512:851d:41c5 with SMTP id x16-20020ac259d0000000b00512851d41c5mr1898427lfn.20.1708020084995;
        Thu, 15 Feb 2024 10:01:24 -0800 (PST)
Received: from localhost ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id k11-20020ac2456b000000b00511ae3225d1sm321197lfm.226.2024.02.15.10.01.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 10:01:24 -0800 (PST)
From: Serge Semin <fancer.lancer@gmail.com>
To: Serge Semin <fancer.lancer@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] spi: dw: Add a number of native CS auto-detection
Date: Thu, 15 Feb 2024 21:00:47 +0300
Message-ID: <20240215180102.13887-3-fancer.lancer@gmail.com>
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


