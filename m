Return-Path: <linux-kernel+bounces-76980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A755F85FF61
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:30:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D6681F235F4
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 17:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1ABF157E93;
	Thu, 22 Feb 2024 17:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aNphZxL0"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3CA156996;
	Thu, 22 Feb 2024 17:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708622946; cv=none; b=j5P67ve0zM8rAs5rho6Alikxh9Wxg1xTep0AczCuTuuHwLwWgjvUDfxVNbmsD8yHeE7/RsVRnung6uAiMxyNw8v2FRrXh/s2YcgQ74s25EvaBZnUK7S/XrPi7FvCa5XJ8X1Tv2KkTXLDslQ917M8QPOg5czXIVI9vle+scLxRS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708622946; c=relaxed/simple;
	bh=dYJgTChdgJOJkHz2iKj/s8ZaCL8CFt3VgKsr1t0sTfA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pxsZUB5hAVu1qhq2bK6OJe/tU4vzOKLFytzqCuMLHypkP4nHocwdYfPuMfqdXD/B08OMAh0QJ15KsALFIFVY7PCydxBLyu/HldZCFECNiOsamJDUiRMWV9lP9QJlJ1eeM6lVwRTH/v8gLuDxe7NBwpsiRdezD7x3oqcwK3xGuoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aNphZxL0; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-512d5744290so26670e87.2;
        Thu, 22 Feb 2024 09:29:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708622942; x=1709227742; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kleuODmxCYyEFzznYD1sQ1n9j2n/3CqsHs6HaC1c8NI=;
        b=aNphZxL0v0k/zHS0RrJ4rWf20GIh8k33hYKKSMwmSu0PGBiRoIUx7Cq108NcZA4amX
         IriMzMEQwSJrmbG7Ia9H/eUHpw9w3mhgjI4EQoDaQz9wG9ITrxUz3uQwqgWycik1E8/Q
         CRIs9paVBd7V4kTOxZgXdEVSDMPuNppJGb/Fixv/K/IIbTJhMENFb4PXRhUWe++UDbYH
         j0noJ8g7jPjASGFAmqzdiOeOPTwLMvIh041Elgefy5DpHmWeEXEj8Gv9FOKhikQFARfT
         Y1BrRLdwiXVodlkj6X2VPbcw2/PGELZhQ351WXA0sA3qSgzxmQ2BNw3r9cMksXFRvLPr
         BcSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708622942; x=1709227742;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kleuODmxCYyEFzznYD1sQ1n9j2n/3CqsHs6HaC1c8NI=;
        b=KkrikvMzw1ZnpWGr05IKD/ndvk7xUjJv9M3QCaFViI6R7S4MZnmna6koDMva685RCV
         1kGscAPOgn9lO6CdHFHueVDBPQyjd/V39+GImfGXBzYn0TqdCpDHVr5H5pcHRizHNeei
         1mpVzEMQYK0WjvY2AXCYzZ3Vu/sq6SOgSV8E6kKISSfbIStx/a4LawEfgMgkYyJnXP/c
         cAytn7iH5Q07nYk673Vwar4bcZFWAcjFXCH3nk80SCBcNjCRn0uit+obk+SBzGFZFgbX
         DjHNmDABVb6hXAU9+BNIXKvmRyGsg6PtfU2T7/hxBIjDuf5woxLIQVI1GevdCK3wzfmj
         vbfw==
X-Forwarded-Encrypted: i=1; AJvYcCWKpfhCPVzow19ygAdyjPDEs8yoiE/wZGOO5UN88CehBw5akb1T3sbQKhn42O6bioWc4CG/tlPSYXp9yUQRuZg5pxk9LNCzgRxZKpTrZ8w0NM1bFKVGVGLmT8KVDhHZZ8x5qPud2eXV
X-Gm-Message-State: AOJu0Yxa7qnw0zLr80aV34bHTYx40waCtMdrGbDK5uythoN2DZay8bSe
	L4XEKD9l4dQU5i09B32zwE50nDAsw5BffDnPObG1UaJd7vCiq9j1FDXP3oCaQ6k=
X-Google-Smtp-Source: AGHT+IETpd4ZguYLp5vVtxrCopYEHB3OeNgESpMy63hVg8FTDBHOKN5KOTlEjjqjo3M4EE7SSO5AJg==
X-Received: by 2002:ac2:4d1b:0:b0:512:da6e:7719 with SMTP id r27-20020ac24d1b000000b00512da6e7719mr2090221lfi.4.1708622942293;
        Thu, 22 Feb 2024 09:29:02 -0800 (PST)
Received: from localhost ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id i19-20020ac25233000000b00512cc96c403sm898561lfl.238.2024.02.22.09.29.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 09:29:01 -0800 (PST)
From: Serge Semin <fancer.lancer@gmail.com>
To: Serge Semin <fancer.lancer@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/4] spi: dw: Drop default number of CS setting
Date: Thu, 22 Feb 2024 20:28:47 +0300
Message-ID: <20240222172853.25082-5-fancer.lancer@gmail.com>
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

DW APB/AHB SSI core now supports the procedure automatically detecting the
number of native chip-select lines. Thus there is no longer point in
defaulting to four CS if the platform doesn't specify the real number
especially seeing the default number didn't correspond to any original DW
APB/AHB databook.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>

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


