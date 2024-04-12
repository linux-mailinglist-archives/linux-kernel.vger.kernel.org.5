Return-Path: <linux-kernel+bounces-143420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 958708A38AD
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 00:53:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50DB72868B6
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 22:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B65D15099C;
	Fri, 12 Apr 2024 22:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="bd9ksUEN"
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61C61514CB
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 22:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712962380; cv=none; b=gHVXer6/ZQoJr58AEfLEE//PbndNi+BTaAn+AawACCFizf+mxOrEqRsan/7SwiEp3J13fQoI1uKm/wu9RKu9Nlw54+Qbc0LuvUsSebUuMG2Gx7SXS/qWdnFIdGP+zx1fcf497hHecqGlLrUd1VELCdf/Tuhcon3HjRgv6vamwi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712962380; c=relaxed/simple;
	bh=nlYllQc3OeesLara5AXWDxvl2J/1cEj76GK6KvJeHiY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HUy1+c/vkG/yldRPxNcNrZMzj3HmS02ApmCaZ7RfBxvcPcKNk6ohV/6XQ7OuzaYWyjNfZ4fTQbZkHF8S+WasA7aktYxpclBtiCt/Ebod0MdDmtX5a5/WRDq/3NFJzZ2KjSHrexXPepkMyh/59lhWLtdus49YtFXFtTCg/mKS9rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=bd9ksUEN; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3bbd6ea06f5so881400b6e.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 15:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1712962377; x=1713567177; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CSa8cz5wAyIGJBJ5fRcr8/LXYX8g0rZDA9Kkuso4nz0=;
        b=bd9ksUENWE+Ag+zeAUhB+1lYEOBamyYJfNoLdH0uhJF/lEcb49mqR/8Edk0+JOxYm+
         wqQqj0DxKVPvlpoSIB4tT76vzUbDRGpUuM0tkdIzG+0cYerWlhw9s7i8V8UF6gEWiolb
         mTmdG3LVVsEJqXdf+WRnOtyheyFkzq9JZcOl9tu8cnEJE1EDyxUhgTzMyU6DjcayYycI
         +tqEH3ieUPG9dDsh2p4XgXmMXV8Y5uN+BHlBTUC1MEQR6RQZNHe+ydNHhgTaR779ah7y
         62Ll1OzVQsEa6D3pxh48hnWoV0E9vQRjA6msoI9zHGjdHAIDi0BfL5PE4DZM80FKR8RR
         xwKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712962377; x=1713567177;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CSa8cz5wAyIGJBJ5fRcr8/LXYX8g0rZDA9Kkuso4nz0=;
        b=rj74MvIFLLyv1CjQi+aMecY2G94oJK/Gm8JFGPKu53MCbTamZ9yKJjqvd+fRNAfUeo
         KSEvvMWz3LDhNEuWNA4IlfGsk5hTJrpHRjm6j34EXN5q86z6VEh0u7JDQ2/mauU4Dxpb
         EWiDRrn58zbgtUvP7QXdK2cKb+ZTu5bJ4+rbNaYOXElvPvFKigQZVJrBOBhQfkYHPywc
         56XFSezfa6Yjv8nU0QdfX3ZWvWcDzkubd8zlMGMB4xPoDgcrP7uqFLREMOGjhbHHaFmi
         n72bmhrVthQgKBLBLGzLntjv294mlBFR0IYq+SbIT4QTaC20oYdKv2mhpf7SsVLth9Sg
         guJg==
X-Forwarded-Encrypted: i=1; AJvYcCVo0ZvTcWU0VV5JmYW2COpIuPKswV/GV4I923NFSrjFkymwmikhIKetU1md7jnNfrfLE6XFZ2MtEdZjN/cXU9Qw1dZtF62A4t9qF8bJ
X-Gm-Message-State: AOJu0YxS+f/JnGU7OqNWwNEFb9oM56Z7NEGKxOHbe1+KL23N0IF4NqNp
	odloCcV51yO4ulxxg52ErdbtfZKZf4Wr5eLlI6ZyURbuq1gIiA8gpy4s9a0lsr7Hg982QD6prkV
	v
X-Google-Smtp-Source: AGHT+IGekJlhOEt0tsam4M6DaLrsuuJmSsoV3zL8HDHHuQqesXkeFISnKlnDRBs1zFxmeWhr7LeF3g==
X-Received: by 2002:a05:6808:f14:b0:3c6:fe91:1dea with SMTP id m20-20020a0568080f1400b003c6fe911deamr404579oiw.5.1712962376890;
        Fri, 12 Apr 2024 15:52:56 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 22-20020aca1016000000b003c5f3c1895esm749906oiq.49.2024.04.12.15.52.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 15:52:56 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Mark Brown <broonie@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <michael.hennerich@analog.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] spi: axi-spi-engine: fix version format string
Date: Fri, 12 Apr 2024 17:52:48 -0500
Message-ID: <20240412-axi-spi-engine-version-printf-v1-1-95e1e842c1a6@baylibre.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit

The version format string in the AXI SPI Engine driver was probably
intended to print the version number in the same format as the DT
compatible string (e.g. 1.00.a). However, the version just uses
semantic versioning so formatting the patch number as a character
is not correct and would result in printing control characters for
patch numbers less than 32.

Fixes: b1353d1c1d45 ("spi: Add Analog Devices AXI SPI Engine controller support")
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/spi/spi-axi-spi-engine.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-axi-spi-engine.c b/drivers/spi/spi-axi-spi-engine.c
index 7cc219d78551..e358ac5b4509 100644
--- a/drivers/spi/spi-axi-spi-engine.c
+++ b/drivers/spi/spi-axi-spi-engine.c
@@ -623,7 +623,7 @@ static int spi_engine_probe(struct platform_device *pdev)
 
 	version = readl(spi_engine->base + ADI_AXI_REG_VERSION);
 	if (ADI_AXI_PCORE_VER_MAJOR(version) != 1) {
-		dev_err(&pdev->dev, "Unsupported peripheral version %u.%u.%c\n",
+		dev_err(&pdev->dev, "Unsupported peripheral version %u.%u.%u\n",
 			ADI_AXI_PCORE_VER_MAJOR(version),
 			ADI_AXI_PCORE_VER_MINOR(version),
 			ADI_AXI_PCORE_VER_PATCH(version));

---
base-commit: 637ced031d3c490f0c37c1e826574f39909647a5
change-id: 20240412-axi-spi-engine-version-printf-c5204b657a9f

