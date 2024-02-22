Return-Path: <linux-kernel+bounces-76978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1773485FF58
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:29:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7C23286C8F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 17:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B170415699F;
	Thu, 22 Feb 2024 17:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lIqlTrNj"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E98155A55;
	Thu, 22 Feb 2024 17:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708622943; cv=none; b=dvd+L+Y7K60X1xDlzzcj/CSJlgKgULSoKC1tQPxnb8X8ZJ93rNsaX0fvuc/kmkh1nfiHfmNSVO+M22TUBKKtO4+93wDW5KwFS4ksSYhNlr1no1S00h16Rnje3BKkqJh5e5Tes9rKpRPfclWFvplVrQY564Uca8R3F+5GNVo6Gzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708622943; c=relaxed/simple;
	bh=KBAkQBgpYdLDaJ5qYLlC9p8SlXhmDfw3UvehvJhSkG8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u+pisaQI8pih62gCYHhWyjn2lNDRP3uAUi6uUUknrFLHe/YzYmj68AJc8lPw1CdhVh4C8utHCEpxYm7vfoU8SSKlnsRP4BM134PhiYzzWvDN4wmZiM30zchsaZhPrvak0mQSs9Xfu7lc3b3clIpoimq7li1mxClINKFjLa6gVeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lIqlTrNj; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-512db550e3fso30086e87.2;
        Thu, 22 Feb 2024 09:29:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708622939; x=1709227739; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ef0c0lkPbUi43MY5AODLBrbnTIwKOtyjY4A1tP/i59I=;
        b=lIqlTrNjAjkGJyaZDYrXGO9lA9431n2C5MZK+bbU5LyaJginG/3Xv1HWvL1IGnolio
         6ikG93Z00M/GPndkYZqmcBal964GCAiasSHRXAdgVA1oXMevr8CFobPEai88oeyvkiNE
         cPm/BCv3LNN9wnPxuUEjmEcC/JBNaVfkA+aM0C5043bLUr+yiJyFQJAHU5dtmNZXS0Re
         CEbH/F0wDSmBkb61CaKweguA9b2+fe2tOM8Ewl+RboHXI1b4+ETvzbfNx69ZHwHNFWM0
         hzm/z1eVJtnvO+hoEGtXvWUzejNro80YJOWKYrm4vCp/OuyyiOwEc4aYBE7o0LJjUnJc
         pUTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708622939; x=1709227739;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ef0c0lkPbUi43MY5AODLBrbnTIwKOtyjY4A1tP/i59I=;
        b=tHFYktiof+sp+nzJjPaZ3dVDHSA3hvuDsXk1RBstAtHGt4rM0l42p81jjiQEggbsAP
         9VW+BGlrBiPDHdlmVkYuLN33CoTAWqLhGGO8HwfkUw14gA2Il0OFZZGAV4GmtTMwKxWZ
         ksk3WNW9G/dv2BfbWl/s/1Lrjwk8FxbAK3ym5/cOzQLodN3QOelEDlzLt3ytbruNNYiA
         mXCytUip0obToKNiro5PDLep1buHIZrK2hzs14AJLMLTaZl/3rbsodo1bJcKfoEa1MRF
         MATSDNmhH4vjiQv8YWtwploqDwsY5qk9TS97MHwYkcX8vxU23MlkTFWk8Skt3H6vNViJ
         wVlQ==
X-Forwarded-Encrypted: i=1; AJvYcCX5iJtVSQGHCFTJwyqp4Bk/AxdEhCHpRPLXiwMi5CuMm9S5gMtQrm4IAZJ5ICsugTBSwsDqEoS/xGRUUiYUX1HdMRQV4C0PhmHY5OnhXlPMEujh1IxoY0v+l19UV6g5TTEZ6EJULJfN
X-Gm-Message-State: AOJu0YyywSbHBEWjBInLyKUOvTJMByqaRIPB6eqBuoVKBEu8Suc/RxTx
	UyFWJzpoIVZg+uBcmNxlCFCxPMMflVj4p6H1GAgfAPyBSTmecLUz
X-Google-Smtp-Source: AGHT+IGMx/+bKadvMHlHqX6J5/LNuTKVLFP12Pa7fpozYPU5Wq9oHbEIXywVddZLcBZ4aymZ23u09A==
X-Received: by 2002:ac2:520d:0:b0:512:aa89:961f with SMTP id a13-20020ac2520d000000b00512aa89961fmr7923206lfl.25.1708622938960;
        Thu, 22 Feb 2024 09:28:58 -0800 (PST)
Received: from localhost ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id d20-20020ac24c94000000b00512b2ffb007sm1656537lfl.246.2024.02.22.09.28.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 09:28:58 -0800 (PST)
From: Serge Semin <fancer.lancer@gmail.com>
To: Serge Semin <fancer.lancer@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/4] spi: dw: Add a number of native CS auto-detection
Date: Thu, 22 Feb 2024 20:28:45 +0300
Message-ID: <20240222172853.25082-3-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240222172853.25082-1-fancer.lancer@gmail.com>
References: <20240222172853.25082-1-fancer.lancer@gmail.com>
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


