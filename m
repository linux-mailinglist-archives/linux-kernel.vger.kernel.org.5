Return-Path: <linux-kernel+bounces-43515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E608384150A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 22:19:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A493E284BD1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 21:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84FF7157E8F;
	Mon, 29 Jan 2024 21:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gktJrYIX"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C70C157E87
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 21:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706563160; cv=none; b=C0oaOq7xcdVLa0+UQPjsYvL+sriRNgmpV/65pVUrQdUSpRs6AuN7f1qWR9PR4qAQLHXI4sIz7N/TyVvFbLy9kXIBBd4tWkHNfeZmEYNqiEu2xW0ifgElIb/KEWTCuHn2upA3TVBzOG0zDaTsupM3oLNc2ToAta1H5+NyFYt5qhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706563160; c=relaxed/simple;
	bh=S7kUEVYRrtcxtCYQYQOmLM/5DqJ4+ohoiXAUesR5OkM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gikf/xJ6ak2hLHg15vixpQBc8PpkGm3ivxCoZ6D6LmtOekFLwpZ0M9ZuMM+Co6WOSqJ5zHUiKjvpcEGKlI7VnhYBuqO96rXNnyIch+YD3s3v8M5RRCYlrmmBBsZ4oDq/1u8ER1FjaBsM4MQeEYrs//vQJ7w/vHQv6lj0I3LlCbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gktJrYIX; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40e80046246so17700895e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 13:19:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706563157; x=1707167957; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SEnDTJQ10cHWohI79qASBVq5CKad4CLufOCIUd//vZk=;
        b=gktJrYIXcDrs14PWxar/qjssy6UefN/xKemMjB5f7nQinkbNc8jW21q9yZDZVkQ4fd
         7BXeXi+nLL7XbXmq3+aonjbogr4hZbdQESeTRdTMSW6C83IV9mXXDIO/kPl82RsZFbUS
         rJMY/kY+DaGgaEWwi925YdmV+LlLdUUXYPRD5ALVlaQWXQ15iephk2Vbv1iJ0w300y+s
         bIEKMoMGHjjzljPH3oPShu2OAzGgAMS2EqADp07Mr/5hDVSC8IimLJXqoYSG1i3GauHk
         lnLIAZ14CdDNETucWQKg7fnGbAgnnTpyRHEOPle/XMQE4gBhqueBx6tF71GcjSXM3QSx
         nYsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706563157; x=1707167957;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SEnDTJQ10cHWohI79qASBVq5CKad4CLufOCIUd//vZk=;
        b=ZYsmiR9hxNyqiLWegMuB5xezNXy8u7GDFndaSuQFd5rYLZH7D07MDzrZW+ZBa/0lEZ
         qxWz+wu4DiBBYOB4dn4YWkj7ab42JiKEVFJ2DjHWARsABLruHY8p0Zj7PTTmae3B00xs
         Mhp57dKw530e9voA7ehPXIAEsYPwnvzBo+lLGCn1K73jEpppp9C0GwSaOO5DuDBYUOzD
         ucQ4ZwCknp16hZ13tyZgObX1/YVKbGtMH7xd1CTio2jXEnVyPRHHVtieanDCWVwvKR7R
         bhAJKFwfe3MdCCrIgDKg+4th0vbG7eYVBPySPztS3mpuAMX2sfWwnkfshx1RXhpbBDSw
         BVeA==
X-Gm-Message-State: AOJu0Yx8MK3PDnyHqSaqpAbFRbejaE/u0ywkTU1wgeOUsEzw9Fr9LEVT
	oFf3P03eoDZPR/ea2fAU5UcKPl+/fwd4phdiQJFqY33BE8ieAxMFp2Kd7pm8334=
X-Google-Smtp-Source: AGHT+IFkNq23SO1IhrxL7eJ5irIk6JFTG3LogE5X13QXrJom8xVeozvbWG3Hn206Elm5gVcBpdd6lQ==
X-Received: by 2002:a05:600c:5186:b0:40e:e516:3b5b with SMTP id fa6-20020a05600c518600b0040ee5163b5bmr6033244wmb.4.1706563157207;
        Mon, 29 Jan 2024 13:19:17 -0800 (PST)
Received: from gpeter-l.lan (host-92-21-139-67.as13285.net. [92.21.139.67])
        by smtp.gmail.com with ESMTPSA id iv16-20020a05600c549000b0040e3635ca65sm15126928wmb.2.2024.01.29.13.19.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 13:19:16 -0800 (PST)
From: Peter Griffin <peter.griffin@linaro.org>
To: arnd@arndb.de,
	krzysztof.kozlowski@linaro.org,
	linux@roeck-us.net,
	wim@linux-watchdog.org,
	alim.akhtar@samsung.com,
	jaewon02.kim@samsung.com,
	semen.protsenko@linaro.org
Cc: kernel-team@android.com,
	peter.griffin@linaro.org,
	tudor.ambarus@linaro.org,
	andre.draszik@linaro.org,
	saravanak@google.com,
	willmcvicker@google.com,
	linux-fsd@tesla.com,
	linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org
Subject: [PATCH v2 0/2]  Add regmap support to exynos-pmu for protected PMU regs
Date: Mon, 29 Jan 2024 21:19:10 +0000
Message-ID: <20240129211912.3068411-1-peter.griffin@linaro.org>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi folks,

This is a v2 of the series to add support for protected PMU registers found
on gs101 and derivative SoCs. In v2 it has been re-worked to be based on a
regmap abstraction that I think leads to a much neater overall solution.
The advantage of the regmap abstraction is that most leaf drivers that
read/write PMU registers need minimal changes.

Example of Exynos drivers that require PMU register access are:
* watchdog
* usb phy
* mipi phy
* ufs phy

This series has been tested on Pixel 6 / gs101. If the various maintainers/
contributors of other Exynos SoCs like exynos850, exynosautov9 etc can test
these patches on your respective systems that would be most appreciated!

The expectation is this series would be merged via Krzysztofs Samsung Exynos
tree.

regards,

Peter

Changes since v1:
 - Refactor to use custom regmap to abstract SMC register access (Sam / Guenter)
 - Add deferred probing support (Saravana / Krzysztof)

v1 lore: https://lore.kernel.org/all/20240122225710.1952066-1-peter.griffin@linaro.org/

Peter Griffin (2):
  soc: samsung: exynos-pmu: Add regmap support for SoCs that protect PMU
    regs
  watchdog: s3c2410_wdt: use exynos_get_pmu_regmap_by_phandle() for PMU
    regs

 drivers/soc/samsung/exynos-pmu.c       | 227 ++++++++++++++++++++++++-
 drivers/watchdog/Kconfig               |   1 -
 drivers/watchdog/s3c2410_wdt.c         |   9 +-
 include/linux/soc/samsung/exynos-pmu.h |  10 ++
 4 files changed, 241 insertions(+), 6 deletions(-)

-- 
2.43.0.429.g432eaa2c6b-goog


