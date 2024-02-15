Return-Path: <linux-kernel+bounces-67463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52554856BDE
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 19:02:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8558B1C23427
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 18:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60E9A13957C;
	Thu, 15 Feb 2024 18:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AUwvJFXh"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 036B11386DE;
	Thu, 15 Feb 2024 18:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708020090; cv=none; b=MmUrODagNJzzu9b2WY2whIkx5TleJX/CyPKlQBkqgPMiBmnE5gdBmRH8QBBS9X5DLRC3sW9nxG1D+FaHBecAPb1I/YIdw7Z7ZjukPKcud9OS2MldTZb90LpsLRNquAG7rzxrBijS3emqj+glII0oVQqU1K2TWpxola7GZqKqGes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708020090; c=relaxed/simple;
	bh=F8Y/aairEGyfuvo2EhCMfvxfxlwtJhutuIxOg1R0p08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VqM56v4FXlQmCjZI/pT2dAkLkiFJ/6xyhTbBX5wjVjCI0/NCFPO39oE8A5yLOmxR4VJEZzZo4aET9t/kPKzmsDNupRDU+I4XDMF/uzstRIteNAXiSoeNF+251BIoIT2t5jwKwQOmKZXh7P2CZRZfJRZigo8/p5aGsYBFtQA/IVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AUwvJFXh; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-511acd26befso1438303e87.1;
        Thu, 15 Feb 2024 10:01:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708020087; x=1708624887; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TdhViubu+MQPzCyySbbId4maKldHevwaTkO7BnF3q5g=;
        b=AUwvJFXhXiFYN22auaZiEEPHGvIGgZgOazZDxq8BQ25rVG+RHCd/VB9Xtvpsipao/l
         TdZfuGnhtrtSw7jqIbgS3vN4vvbUe1XXsGhptJTZ+L6wmqgphXi55UCraT7dO92vfz0o
         jA9sTRn/aH3DCHF0dyhXxwR9XjhYnsKuOXQ8U4hPp7h40JnRAJGk3tZ9G/BTo2/Dy4lY
         daU15JkDb0VpmVFSWK876Vkm9hDY+JxfjAlwu9knJwycwgWehZ5stUuOg5nBUKVlmEwD
         UhHrbAVQYh/kbakAtktNO1tToQ4T7aOE0eIjX58UyAJ6wiDe/aI9FkR9NYCkGFyKc7A1
         KjUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708020087; x=1708624887;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TdhViubu+MQPzCyySbbId4maKldHevwaTkO7BnF3q5g=;
        b=F521ACCwCW0xuVlQxgnEfnndqEiPvGG2QY6FgS3Ti2nDqaenj8euv93qAnjPpZhJkG
         f/GtY0H0y26n0411497vzX2SIsQS781xRuIsPTBW5SnNNmtVX7b0i/rW8FMFlrt0AsBz
         JjPFPuYn4/xLBHMoNNwBd204QwXzVSqt70pEP66eTAwlP82VcRw4lw1TSkzM55/us52N
         PNfYqUCazGYn757sSHb76oVjjpnpPBsgbAzH9Z9JOIK8IeKZ7EbQs97B+vulE4FWjujg
         66fIrUGm8oTgUy4bUHawF7UAV2Mx4TTmwl8fzcDXbpMHJou3hirhBUQZYt5ls7c/Zh3a
         zdYw==
X-Forwarded-Encrypted: i=1; AJvYcCUHaDDN5bV2cq8JIEtuxCQ08INklpsyREOO0+EyTm1O+7CYUbceIQRs362ZdRW/cO6QdjW3DN6go480KKfaUNxiMifXunElc+b8ExLE0DX+B9tpiTje9gKr7Hp45g3OAG8ZXglE+O9j
X-Gm-Message-State: AOJu0YxVZKH7rE6sT5M0CGvbwHM4Or5S2r1tYkpGjCN0QUTZIFG6jQwV
	q6B2QmcjqB1DZbd9edfcXHND7+vDyoU2kqHO4tVtMUN6+SFHYTcw
X-Google-Smtp-Source: AGHT+IHSmBrHT1mMnf+cZcOFAB4WcDzDO4pDKGZt3PKVxRtqV+hJfiG+sojUkY7CwMX4uOxWAtGXsA==
X-Received: by 2002:a19:9152:0:b0:511:4824:6718 with SMTP id y18-20020a199152000000b0051148246718mr1991126lfj.56.1708020086584;
        Thu, 15 Feb 2024 10:01:26 -0800 (PST)
Received: from localhost ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id x7-20020a19f607000000b005118c6d6a2fsm322769lfe.305.2024.02.15.10.01.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 10:01:26 -0800 (PST)
From: Serge Semin <fancer.lancer@gmail.com>
To: Serge Semin <fancer.lancer@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] spi: dw: Drop default number of CS setting
Date: Thu, 15 Feb 2024 21:00:48 +0300
Message-ID: <20240215180102.13887-4-fancer.lancer@gmail.com>
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

DW APB/AHB SSI core now supports the procedure which automatically
determines the number of native CS. Thus there is no longer point in
defaulting to four CS if platform doesn't specify the real number.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 drivers/spi/spi-dw-mmio.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c
index cc74cbe03431..eb335fcc8720 100644
--- a/drivers/spi/spi-dw-mmio.c
+++ b/drivers/spi/spi-dw-mmio.c
@@ -364,11 +364,8 @@ static int dw_spi_mmio_probe(struct platform_device *pdev)
 				     &dws->reg_io_width))
 		dws->reg_io_width = 4;
 
-	num_cs = 4;
-
-	device_property_read_u32(&pdev->dev, "num-cs", &num_cs);
-
-	dws->num_cs = num_cs;
+	if (!device_property_read_u32(&pdev->dev, "num-cs", &num_cs))
+		dws->num_cs = num_cs;
 
 	init_func = device_get_match_data(&pdev->dev);
 	if (init_func) {
-- 
2.43.0


