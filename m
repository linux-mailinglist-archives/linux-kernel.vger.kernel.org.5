Return-Path: <linux-kernel+bounces-67057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6090285657C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 15:11:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D64E293EB3
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 14:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2E4713341A;
	Thu, 15 Feb 2024 14:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="DjiT0rk+"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6613F133400
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 14:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708006153; cv=none; b=GVZgpCicxRdG4vc3xi3j443i4m7PxHm/Vc6RRwUwg6pWPy26uNL4gTDXHLfgxk4VWWX5MRdaXwqTxfj1VeIsmu7s7uxftH5WFeaxaMB9g2I5GAULDStCAR8vfy6s4s+qRVkFRCPTd4Ysw74Gf5QOckYYy8ttnIXhVc+/lzOlNXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708006153; c=relaxed/simple;
	bh=b/dlKiES8flQO1V7kDRxQagNiDwOIUuMR02By8uyldM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fJZtbmxlYVXkeS0mqrArje2IeCE87nr/k8aCWZ1FaNX6aBvhHr1kKZ8IU1yk3NWYTlffbkCUU+xjSbutoUa7LTLzKBL4vMtd6Q/CAymWuc3c+4/N66owg2he6mZX2ofLpy5Wqzd+aI4rUg5j/jomdvhnMbNEX+gURi73CxRhWug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=DjiT0rk+; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-411e71d8a2bso6524415e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 06:09:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1708006150; x=1708610950; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7GMx3oEvdufHoBvmFi6dbwMx9fUDNCWnepPcsld4qxw=;
        b=DjiT0rk+zQmfaS142q7BKYsfwol45IPjbXcAwO/9/h5ASkZThSojCLTBTCFbV7QJcF
         572uMJo2HqGShQwoEmllDH15qnwjTt7ODxReJaQK5D1g5p5yebo4wtEVnBEqRuvE0cyi
         OTqXlgg8lG0Ym0f883AsTBpfHMBq2pamVV941eD2kRc+rnt25BKRoJb9y9SDmgRHFedc
         8VyLZUcZyELJbufeI5V3obUDdKZVTWg9pXmxJ78b1wcr/NaZ/UjUwlKBVRSk+rmcmvcM
         ty20vMKA2F6xQQzlJigW2Lly+mqdHWvthkBNDQEiS6MTD7ES3sXzICRLZbmYc8wSGzHP
         Rlow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708006150; x=1708610950;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7GMx3oEvdufHoBvmFi6dbwMx9fUDNCWnepPcsld4qxw=;
        b=Qu3dqisk8TUkplq6rY14kbzrPfpcys8F4FSpuZH8SCkhKOOIo1uVi6BDRxdgcj/qzw
         absCxUDMw0QuaxweZ8NDggAbfqd+x0apVhYOgluGfmrhdVSkIXnUpBlFT3Ilh61rJ+ER
         CxoGpC9/6/ICJ3hqYLHS30+Ofp6gK79Ka16TqQdUQIpM7uW6BrlqRKFlTbc0tT0HhCHK
         qrYXGOxHQTKe0pbzJ1CYVN5BuzliU8TbVsPsUsAxBQWmThEfYcj7AU2+P9ULual0mxG3
         JtzgV3VKUuyG74scmJeRq43ouAGDy+yDduyFWgNSbVOsTFCWh62TjoKc+j88vq2nL8CU
         Id+w==
X-Forwarded-Encrypted: i=1; AJvYcCUiDErndvDw5JST4QoSPgrztPPIo5rOeEZ/OPfOW9johlrsNrVLxoGBLkt7rjBmF4EmFSe0r2jvAwgD375pOzCghPDv5sKPNuJgZJn6
X-Gm-Message-State: AOJu0YziXEA4bluJl7Rz0TmkVZccJa0b8fntWIu4K4KsuT3rXv0bf4bI
	ubXdXOtsOLBwU1/aXLS5abz8o15yVem2+vmMKWYAfZvdAdhNmq2H7xrADyrrM8s=
X-Google-Smtp-Source: AGHT+IEETsuWPiWOmhwbyUPfS8M7sqK6BNvg1xBpmW3gntZu7lRO0Xn5XVq0yNqgOpVGjOFLei7whw==
X-Received: by 2002:a05:600c:5342:b0:410:8db2:d5ec with SMTP id hi2-20020a05600c534200b004108db2d5ecmr1478045wmb.38.1708006149702;
        Thu, 15 Feb 2024 06:09:09 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.20])
        by smtp.gmail.com with ESMTPSA id h17-20020a05600c261100b0040fe4b733f4sm5120950wma.26.2024.02.15.06.09.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 06:09:09 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: wim@linux-watchdog.org,
	linux@roeck-us.net,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	p.zabel@pengutronix.de,
	geert+renesas@glider.be,
	magnus.damm@gmail.com,
	biju.das.jz@bp.renesas.com
Cc: linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	claudiu.beznea@tuxon.dev,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v7 8/9] watchdog: rzg2l_wdt: Add suspend/resume support
Date: Thu, 15 Feb 2024 16:08:40 +0200
Message-Id: <20240215140841.2278657-9-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240215140841.2278657-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240215140841.2278657-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

The RZ/G3S supports deep sleep states where power to most of the IP blocks
is cut off. To ensure proper working of the watchdog when resuming from
such states, the suspend function is stopping the watchdog and the resume
function is starting it. There is no need to configure the watchdog
in case the watchdog was stopped prior to starting suspend.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v7:
- none

Changes in v6:
- none

Changes in v5:
- none

Changes in v4:
- none

Changes in v3:
- none

Changes in v2:
- remove the usage of pm_ptr()


 drivers/watchdog/rzg2l_wdt.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/watchdog/rzg2l_wdt.c b/drivers/watchdog/rzg2l_wdt.c
index 42f1d5d6f07e..c8c20cfb97a3 100644
--- a/drivers/watchdog/rzg2l_wdt.c
+++ b/drivers/watchdog/rzg2l_wdt.c
@@ -284,6 +284,7 @@ static int rzg2l_wdt_probe(struct platform_device *pdev)
 	priv->wdev.timeout = WDT_DEFAULT_TIMEOUT;
 
 	watchdog_set_drvdata(&priv->wdev, priv);
+	dev_set_drvdata(dev, priv);
 	ret = devm_add_action_or_reset(&pdev->dev, rzg2l_wdt_pm_disable, &priv->wdev);
 	if (ret)
 		return ret;
@@ -305,10 +306,35 @@ static const struct of_device_id rzg2l_wdt_ids[] = {
 };
 MODULE_DEVICE_TABLE(of, rzg2l_wdt_ids);
 
+static int rzg2l_wdt_suspend_late(struct device *dev)
+{
+	struct rzg2l_wdt_priv *priv = dev_get_drvdata(dev);
+
+	if (!watchdog_active(&priv->wdev))
+		return 0;
+
+	return rzg2l_wdt_stop(&priv->wdev);
+}
+
+static int rzg2l_wdt_resume_early(struct device *dev)
+{
+	struct rzg2l_wdt_priv *priv = dev_get_drvdata(dev);
+
+	if (!watchdog_active(&priv->wdev))
+		return 0;
+
+	return rzg2l_wdt_start(&priv->wdev);
+}
+
+static const struct dev_pm_ops rzg2l_wdt_pm_ops = {
+	LATE_SYSTEM_SLEEP_PM_OPS(rzg2l_wdt_suspend_late, rzg2l_wdt_resume_early)
+};
+
 static struct platform_driver rzg2l_wdt_driver = {
 	.driver = {
 		.name = "rzg2l_wdt",
 		.of_match_table = rzg2l_wdt_ids,
+		.pm = &rzg2l_wdt_pm_ops,
 	},
 	.probe = rzg2l_wdt_probe,
 };
-- 
2.39.2


