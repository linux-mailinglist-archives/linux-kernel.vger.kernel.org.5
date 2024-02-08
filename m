Return-Path: <linux-kernel+bounces-58342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A22AE84E4F1
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 17:21:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 598EC28EAC2
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 16:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F76A7EF14;
	Thu,  8 Feb 2024 16:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J7XS626l"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898EF7E790
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 16:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707409290; cv=none; b=J0BXrq/Lo1WDwhWNT4npOJlYMqYbo78hgdYXUePNLq7xy0R00bAKsZTuPJTsDzXkSmgkSWsDOzgSYZI1IAroWMVp9AC7njR1jyZxGCFpRjDQTA7P3Mn6Mup/OOFvJ3XUsu/t/fXGaQznmV8VgD+hwEdVDBIJa/0t0jhdDOu2voI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707409290; c=relaxed/simple;
	bh=4BFXoEKq0dKkvxzn8sylQVAACo62MxLym87l7SMkOww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bhnWEu5fwjwyuBubavP+zy9iz41ivuVPynHIP8zyWVSAg6+GSuc4wrNGjogvZpPvYraXmLFBzDmo1UMBTPoxYY2kY4g69oKlROEjzgCiNAMsA6wFcXmnepmYlNprAW6Lc5DlAOPKC+yIdbRKynEk+d0xINCBiklMXJwPFPUC++0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=J7XS626l; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-33b45e8a670so1108722f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 08:21:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707409287; x=1708014087; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nxb698xf8QkMydB4z0YB9c3r/9JegaMn6kB+mk5+8LA=;
        b=J7XS626lTjGcri5LhjN1kT1BMZlUZlBR1M7U5MFL5DKLmZOlsVtiS1sKRFyIMDkvkh
         Oa5Sms0tfWuLQ1M1q3YR/q/qHvqUE6MHApSzfOKXUMib2VGWhdTiSwBEmE+4I9LcdXEB
         N8V1Ev63db+q2IqOktK3Cz3fYWHhlE5cVhgVT6kKElakAQk/1PWJIYGeaNjCGxoyXvFa
         aPAMnUOgcJeXAeSsZI05ZgNJaoQgyKro9peSF9IVb5H6QUk+O6z1H/v6p731J9O30HnK
         /IWDYJ/tBGe+Q3YFPiBWf994+jDbYThl/241sH/YURQJ+S9c8lxjSGB4ZqL1QGHK5dbm
         NS4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707409287; x=1708014087;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nxb698xf8QkMydB4z0YB9c3r/9JegaMn6kB+mk5+8LA=;
        b=hL9ykl2NZUTTGaqcIeB6ahUjxX03u8Jvjv5B1EIgHz3aDUtHsikuweoW3avXC6DNPC
         8M7f0k/bUqpm+u/TybuK9cy5EsWWAJuWhwBOoB8IVStRoB0fIa0eKNgxwEjXncNQ42cu
         p6Tv2oF2MzhZW44x56Xtsu1hgc8conJDKSOu+tWOUBN3/rk91ysbVVcHYvQd/mXHGxGM
         Zvs4Vj/bshvbu2IAohRAOmsagfF6HeU5X5rn6q7jUj5Tf1nY5P/6g+HmwMO6yWkHUuk3
         3x83n0KuN8dUiUbDfCWrI086QgXvwAtQNyZNpmcxAsh7xov4V01onYrub+jngUuvO0hl
         5PvA==
X-Forwarded-Encrypted: i=1; AJvYcCVIWMEylh5uEC93oKreQIb3iWbfo9rHsmTiyeUIo4rE0i/nKg+5pK5Wg0WzORcf/3amFgFFWr7JRVpdpWVU1YycFaAZrZ4g3AKr7CLZ
X-Gm-Message-State: AOJu0Yz9vnrIQDPqXszPoJnpMfuJ5MpBxpo2G9RuJj4zvElIXkBzK+Tx
	GSv5LLseAm5fjiBR8ZnXznJXe3AK//Tdoh+VsKBjoLxdtT7j1RSnGBlBDL6k4t4=
X-Google-Smtp-Source: AGHT+IE9GqRr3/H8i68cQfLtU2iGCsiCKO3R5gWttUZU/5XxgjUSyD0tIivpaca4ynGb4xceQrCnNg==
X-Received: by 2002:adf:f70a:0:b0:33b:37fd:eafe with SMTP id r10-20020adff70a000000b0033b37fdeafemr6274601wrp.69.1707409286849;
        Thu, 08 Feb 2024 08:21:26 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW9QSqiihNfbdq7cJ4HSCgq7fx+xjvtIvCIXg1uNCblGGv7Zg6YsinZ5dEMJMj69hMDubW2XrTIRaH6V7oYBE1TZC8bkhHTFZ934qZoXq6oi9iOrCffZd40IW3EcRm+L5xkK57a7Ppt7kZeBlt+Zygiq57SPJdM37Woe2JsiCVeeDVsUZ1PoCHzxHB8fV14T1Y4zjvsLIZZ+dOzFTPdbMFOEqKU0pavc/Lohx+YQypK/LXXMPXfJQzDyOHL7J89SG4dkdanalvgC5BKGvCY/X5vTD1FzWtH9OKWfwkSTGyU1+bYYNm/uPKfETlFW3FDYzcaJTOrhjWXBxAQUxJreX/KIouUaKXP3vlto6kFlc85D4BApqOxAF6y8nrkPNe3Z+CkorGdR1jj67GzDFZ6Oqq+YR7zLHyiwktg8qnrYK9ImbMJEysPJ4Z73rPDIQ6OfMHQU4azQjrWrYCgXQURS3A7kCr0TOuRJAQPZa0jg+zadEv4d0Er4MQzyY840BGFmVxND9EZ7KD5p8b6G8m5mncaAIxZBGl4+h7lils0U0aYEGw9pNJ0HSkEe78rwZNhMgOiH1uZoKT5FOqrBWYXOeVIEIIX2DqWcvhpGGb8H80inclkduhb+myMYQxfQdW3d/Z94mtwlK/CuyzG22kzc2dlxNwiQalosE+9p0E=
Received: from gpeter-l.lan (host-92-21-139-67.as13285.net. [92.21.139.67])
        by smtp.gmail.com with ESMTPSA id v18-20020adfe4d2000000b0033aedaea1b2sm3915846wrm.30.2024.02.08.08.21.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 08:21:26 -0800 (PST)
From: Peter Griffin <peter.griffin@linaro.org>
To: arnd@arndb.de,
	krzysztof.kozlowski@linaro.org,
	linux@roeck-us.net,
	wim@linux-watchdog.org,
	alim.akhtar@samsung.com,
	jaewon02.kim@samsung.com,
	semen.protsenko@linaro.org
Cc: alexey.klimov@linaro.org,
	kernel-team@android.com,
	peter.griffin@linaro.org,
	tudor.ambarus@linaro.org,
	andre.draszik@linaro.org,
	saravanak@google.com,
	willmcvicker@google.com,
	linux-fsd@tesla.com,
	linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org
Subject: [PATCH v4 2/2] watchdog: s3c2410_wdt: use exynos_get_pmu_regmap_by_phandle() for PMU regs
Date: Thu,  8 Feb 2024 16:17:00 +0000
Message-ID: <20240208161700.268570-3-peter.griffin@linaro.org>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
In-Reply-To: <20240208161700.268570-1-peter.griffin@linaro.org>
References: <20240208161700.268570-1-peter.griffin@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Obtain the PMU regmap using the new API added to exynos-pmu driver rather
than syscon_regmap_lookup_by_phandle(). As this driver no longer depends
on mfd syscon remove that header and Kconfig dependency.

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>
Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
 drivers/watchdog/Kconfig       | 1 -
 drivers/watchdog/s3c2410_wdt.c | 8 ++++----
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 7d22051b15a2..d78fe7137799 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -512,7 +512,6 @@ config S3C2410_WATCHDOG
 	tristate "S3C6410/S5Pv210/Exynos Watchdog"
 	depends on ARCH_S3C64XX || ARCH_S5PV210 || ARCH_EXYNOS || COMPILE_TEST
 	select WATCHDOG_CORE
-	select MFD_SYSCON if ARCH_EXYNOS
 	help
 	  Watchdog timer block in the Samsung S3C64xx, S5Pv210 and Exynos
 	  SoCs. This will reboot the system when the timer expires with
diff --git a/drivers/watchdog/s3c2410_wdt.c b/drivers/watchdog/s3c2410_wdt.c
index 349d30462c8c..686cf544d0ae 100644
--- a/drivers/watchdog/s3c2410_wdt.c
+++ b/drivers/watchdog/s3c2410_wdt.c
@@ -24,9 +24,9 @@
 #include <linux/slab.h>
 #include <linux/err.h>
 #include <linux/of.h>
-#include <linux/mfd/syscon.h>
 #include <linux/regmap.h>
 #include <linux/delay.h>
+#include <linux/soc/samsung/exynos-pmu.h>
 
 #define S3C2410_WTCON		0x00
 #define S3C2410_WTDAT		0x04
@@ -699,11 +699,11 @@ static int s3c2410wdt_probe(struct platform_device *pdev)
 		return ret;
 
 	if (wdt->drv_data->quirks & QUIRKS_HAVE_PMUREG) {
-		wdt->pmureg = syscon_regmap_lookup_by_phandle(dev->of_node,
-						"samsung,syscon-phandle");
+		wdt->pmureg = exynos_get_pmu_regmap_by_phandle(dev->of_node,
+						 "samsung,syscon-phandle");
 		if (IS_ERR(wdt->pmureg))
 			return dev_err_probe(dev, PTR_ERR(wdt->pmureg),
-					     "syscon regmap lookup failed.\n");
+					     "PMU regmap lookup failed.\n");
 	}
 
 	wdt_irq = platform_get_irq(pdev, 0);
-- 
2.43.0.594.gd9cf4e227d-goog


