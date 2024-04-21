Return-Path: <linux-kernel+bounces-152500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 323E48ABF61
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 15:49:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 600751C20F67
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 13:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BA2D19477;
	Sun, 21 Apr 2024 13:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V6l93vQl"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7E9625;
	Sun, 21 Apr 2024 13:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713707326; cv=none; b=sW/4i6zvanOJJsN/9sFnStgyjeccFJFA8ir75yKNVsAzUOAAna5e55LZFIIBYSsyrsoCBiUzwe6JoXS6TmHc42L9ovc2VCdEMfXua151+DA2Z9bXCK+NorhE8xPeScVfgM5X57ff/+Yi0hEM8tvO3T/rhur6O8AOInBIyq03xP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713707326; c=relaxed/simple;
	bh=0KUGNTeSghqjf4dUuEOi4jQq1uyimggR/5MrEIFNjmk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O9SRfCKa7qQr468pqZ0YxzNfwmN8oLezi7RqwbOdFEQ/+mXJNIh1ggApQ6vW6HdPDTKn+TbpW6CdU/J6umPlkZR1ERt8KC4m4vXkujtY87L1aeQUpE8QqNYT8UfzTjcpbvJRSwecNXF6y5LmjsVX5U85u72+XVDrmT7TuzV/O7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V6l93vQl; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6ece8991654so3388965b3a.3;
        Sun, 21 Apr 2024 06:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713707324; x=1714312124; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CFH817ciebpwZm5RIvkd4+jbnHC/S06VW05vaHkc95Y=;
        b=V6l93vQlx+llOfWYv8HrFM/Ol+cN8nLEdFX64LHlaDow5LFsiXalraRIlmtRVzokRY
         pLDkodSJNJ2231A+2/88Wu7RI7X7yJK23lf0nKJv1GsOzXH9yrXj/3IQ+dtPeO7XR+82
         c6cIetN0UG44Qb2VPJHwZ84LTb6pSyDGieOM0Be0fYc1fhwvY8wbHnOjnVxcniyHbgcW
         EY77LZc5cPewvCWA2WMB4lygwMHrTK3iF5QO8UMyjpyWte/okPVPPxcL5k1pxr5/p1Df
         E4/ylJVrQMtI3EONQhG+9dSk9qxdrK1VU4C/w72JIt/zQfT8kI2JoYGbKcpVnJ2wCscc
         izkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713707324; x=1714312124;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CFH817ciebpwZm5RIvkd4+jbnHC/S06VW05vaHkc95Y=;
        b=nilyqetV6pTGF/C4SIdjWsqhZa7D9/G/JHB/h8CbY3Ze0HCB91qCvsOMqtbsRmFazV
         QGVtNcndTUaHNqmBYqZ33v7Ke/HMEBx7wAmyw/aMVfvJgE2yP1QNbfXmIvflJZU+MVke
         FtAj4Te8VFLKusrS+bWYzpLgKcGwRpZHIqqwyDzxzUd/kx/VVbgRZyCXWZdntrjsaP6U
         YZrc9UfZ7+AuGW91n/tycYGz2RXW0fzWma11E0vxhzqgcB9s7V8UIoJ0tRNoMkRjH2EL
         pJucslIoMPxw1ctSKFGg1ddGyWIjmxjBK29auqE9wsUFVLV9NxmY8XTb9Wc9WxBTrE1H
         eawg==
X-Forwarded-Encrypted: i=1; AJvYcCVwc33NEPnlbgUlBpYH5plXkwI/Rj62Y2BmRoTGZnvbvpWFATDK91qMqHzqwp5kSQs627BfYt3YRg+Xr9WHHFM9At9ph6zUadFjiN3bMPMJc3ls0LJL4cIy1cYm/BWle9UqZZEFA7i+d4DNAgduHXkv1lm+pOfpf+xoZ2hRo1ng7w5g0xNsLPRtK1U=
X-Gm-Message-State: AOJu0YwczOPwOYisdyzneizV3hfXs6KWYsQtH26FqHWj8yDrUbFnU+h0
	1y8dZsWZs9WO4BXcauZjx6tctJN1xtomVIpYMoijmWzmVgRJ5O44
X-Google-Smtp-Source: AGHT+IGBTkJIFfQemhLvAqEPk4jeBsCkiyNthhoIPYS3OEp203fcQuznnALtMlwF0yGaNj9W4OwFNQ==
X-Received: by 2002:a05:6a00:10d1:b0:6ea:9252:435 with SMTP id d17-20020a056a0010d100b006ea92520435mr9937740pfu.30.1713707324572;
        Sun, 21 Apr 2024 06:48:44 -0700 (PDT)
Received: from localhost.localdomain ([113.30.217.222])
        by smtp.gmail.com with ESMTPSA id o13-20020a056a001b4d00b006e6c733bde9sm6175043pfv.155.2024.04.21.06.48.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Apr 2024 06:48:44 -0700 (PDT)
From: Anand Moon <linux.amoon@gmail.com>
To: Alan Stern <stern@rowland.harvard.edu>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>
Cc: Anand Moon <linux.amoon@gmail.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Johan Hovold <johan@kernel.org>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	linux-usb@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/5] usb: ohci-exynos: Use devm_clk_get_enabled() helpers
Date: Sun, 21 Apr 2024 19:17:32 +0530
Message-ID: <20240421134752.2652-4-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240421134752.2652-1-linux.amoon@gmail.com>
References: <20240421134752.2652-1-linux.amoon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The devm_clk_get_enabled() helpers:
    - call devm_clk_get()
    - call clk_prepare_enable() and register what is needed in order to
      call clk_disable_unprepare() when needed, as a managed resource.

This simplifies the code and avoids the calls to clk_disable_unprepare().

Reviewed-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
v4 : Add  reviewed by  Alan Stern

v3: drop dev_err_probe to simplify the error handle.

v2: new patch in this series
---
 drivers/usb/host/ohci-exynos.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/usb/host/ohci-exynos.c b/drivers/usb/host/ohci-exynos.c
index 20e26a474591..89e6587c089b 100644
--- a/drivers/usb/host/ohci-exynos.c
+++ b/drivers/usb/host/ohci-exynos.c
@@ -135,20 +135,16 @@ static int exynos_ohci_probe(struct platform_device *pdev)
 
 	err = exynos_ohci_get_phy(&pdev->dev, exynos_ohci);
 	if (err)
-		goto fail_clk;
+		goto fail_io;
 
-	exynos_ohci->clk = devm_clk_get(&pdev->dev, "usbhost");
+	exynos_ohci->clk = devm_clk_get_enabled(&pdev->dev, "usbhost");
 
 	if (IS_ERR(exynos_ohci->clk)) {
 		dev_err(&pdev->dev, "Failed to get usbhost clock\n");
 		err = PTR_ERR(exynos_ohci->clk);
-		goto fail_clk;
+		goto fail_io;
 	}
 
-	err = clk_prepare_enable(exynos_ohci->clk);
-	if (err)
-		goto fail_clk;
-
 	hcd->regs = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(hcd->regs)) {
 		err = PTR_ERR(hcd->regs);
@@ -191,8 +187,6 @@ static int exynos_ohci_probe(struct platform_device *pdev)
 	exynos_ohci_phy_disable(&pdev->dev);
 	pdev->dev.of_node = exynos_ohci->of_node;
 fail_io:
-	clk_disable_unprepare(exynos_ohci->clk);
-fail_clk:
 	usb_put_hcd(hcd);
 	return err;
 }
@@ -208,8 +202,6 @@ static void exynos_ohci_remove(struct platform_device *pdev)
 
 	exynos_ohci_phy_disable(&pdev->dev);
 
-	clk_disable_unprepare(exynos_ohci->clk);
-
 	usb_put_hcd(hcd);
 }
 
-- 
2.44.0


