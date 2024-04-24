Return-Path: <linux-kernel+bounces-157162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A46A48B0D9B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 17:08:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 460351F2852D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 15:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71A36161301;
	Wed, 24 Apr 2024 15:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OPspMI3f"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA0F15FCE1;
	Wed, 24 Apr 2024 15:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713971244; cv=none; b=XWyD9FF7vFdommE5SwM69utO2O8MuGhGyFeCcSdPjA3b8j9fORSnYCKH+NsziNCcXIgOsLf1N88PMDaSr198/sqvN3vq+jnpzv/n0rxu5WXrtDhBefyV71KxfcJ7zo6LH16sWe/KC1yR1mDqfPAXpDSH0ck6zAXZejt25hLQK60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713971244; c=relaxed/simple;
	bh=0PBo9Of6CNy3BPbkd/tZVfSeHDs2kDzIZaMPAx/MRPk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XzTCMdlYMUtKW59VjBdVqMTssxrPfBrtx66DytIVXxyA3FZ2AskzroinFKsjq4YZFjGahgxFfTIakZ26bKJyOyXneooJ24cigxCcv/sDta9oGTKxrQcso66Ys3YIdct9MgQ37i02ZRE4FT57YHRKwq73sJtoEkg1dRIbayjKFZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OPspMI3f; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2d895e2c6efso104758991fa.0;
        Wed, 24 Apr 2024 08:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713971241; x=1714576041; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dckUSl5z4UaY1zLi6ZaUm7FPVPOD+pWKaRJKmeXicSI=;
        b=OPspMI3fI7edIm7uN2XEaEpJd+l6xqf8iloUE3La6xqjJaiZZgXaxi3jNa+bkAJqBd
         S5yNeKK2KYQCrzWSqGWxlxqTTLkGWQaZJIoZjil4nASfXExYyROAmfXp/wSvWaqjoWiB
         NGM8FAPvUUWTHdzX8bMr/RGGkgzgXNqiw//1p0Ls2dAH0JVztDblGuZrFMNBC/+K3gI0
         Zrm2uCLBJmESXGhZQFu3tWeG3BqqxuuClQI26lg2eQVvUBRuz5gTO+VmJJlABEwkJyNI
         ihMPN8oYn0yGDA/zl/QJ9U07XQbbisvW80S5mzb5Kin6swSXDkezwEBX0WIOYpatmjnB
         UEyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713971241; x=1714576041;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dckUSl5z4UaY1zLi6ZaUm7FPVPOD+pWKaRJKmeXicSI=;
        b=sFyqgd9JmdVfmg4uaSS1ZCcmMakG2W2vcPicRi13ltNC1AsBZH6CX76puE4u9K5yss
         xlkx4VZw9Wk3HWBBP1QeMGOwy5QUXzZySt0F5xWZ1Ky//iU8wig+Z/yF4D0uMEai1QmZ
         opodPifb4zZCao4M4D8Y0BbcqkT3v87BTttRy6Ljsn7+O9/2WqL3ln9/hii54p6lCJb9
         ZSD0tQ5Ecd10eLDjt5eT9/QGrcuMpWPaoEn5tC07MTFHkktj0UQ7FUh94m3ujcsRASxh
         zLWKjaD2K7T64LrpBBXwMBG8+ZGPtazz6cdupJ0SG3tP/KyqIGK0CPOIJLGYce8m+UOl
         Tmxg==
X-Forwarded-Encrypted: i=1; AJvYcCVzmdBVEO7Ajp07Nm+wpLtcuTff04Gpr+udQHTfCDk9j4uLIjVWCc3/45MJav+XExDIHjZ4EFHenYP6k+GTTIJQ2lPYy1+QTmM6l4vRY9M416cJWnk9M+9S/uTW+/IWIebfEIMMqH+0
X-Gm-Message-State: AOJu0YynbuSNwCqr52CxnWYa4A7jJbU/r/n2WOfRNkD0MNKjZdEQ76mE
	he/7goNzLU1G4BNGBgWvqaRUkmJGYXmkzNqbjN+lWHSqCCfFfUK6
X-Google-Smtp-Source: AGHT+IEE4EQyH+7OCx2jiJMXA2ZH8Vw1BDpJTqHiVv49d1ENUeSiB03CIDrUDitizpKbCjVxyKOH+w==
X-Received: by 2002:a2e:9855:0:b0:2d8:144e:c464 with SMTP id e21-20020a2e9855000000b002d8144ec464mr1685917ljj.36.1713971241416;
        Wed, 24 Apr 2024 08:07:21 -0700 (PDT)
Received: from localhost ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id y18-20020a05651c221200b002de02f28ba1sm533935ljq.94.2024.04.24.08.07.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 08:07:21 -0700 (PDT)
From: Serge Semin <fancer.lancer@gmail.com>
To: Serge Semin <fancer.lancer@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Andy Shevchenko <andy@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND v4 4/4] spi: dw: Drop default number of CS setting
Date: Wed, 24 Apr 2024 18:06:45 +0300
Message-ID: <20240424150657.9678-5-fancer.lancer@gmail.com>
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

DW APB/AHB SSI core now supports the procedure automatically detecting the
number of native chip-select lines. Thus there is no longer point in
defaulting to four CS if the platform doesn't specify the real number
especially seeing the default number didn't correspond to any original DW
APB/AHB databook.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
Reviewed-by: Andy Shevchenko <andy@kernel.org>

---

Changelog v2:
- Drop temporal variable and pass dws_spi::num_cs directly.
---
 drivers/spi/spi-dw-mmio.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c
index cc74cbe03431..c56de35eca98 100644
--- a/drivers/spi/spi-dw-mmio.c
+++ b/drivers/spi/spi-dw-mmio.c
@@ -320,7 +320,6 @@ static int dw_spi_mmio_probe(struct platform_device *pdev)
 	struct resource *mem;
 	struct dw_spi *dws;
 	int ret;
-	int num_cs;
 
 	dwsmmio = devm_kzalloc(&pdev->dev, sizeof(struct dw_spi_mmio),
 			GFP_KERNEL);
@@ -364,11 +363,8 @@ static int dw_spi_mmio_probe(struct platform_device *pdev)
 				     &dws->reg_io_width))
 		dws->reg_io_width = 4;
 
-	num_cs = 4;
-
-	device_property_read_u32(&pdev->dev, "num-cs", &num_cs);
-
-	dws->num_cs = num_cs;
+	/* Rely on the auto-detection if no property specified */
+	device_property_read_u32(&pdev->dev, "num-cs", &dws->num_cs);
 
 	init_func = device_get_match_data(&pdev->dev);
 	if (init_func) {
-- 
2.43.0


