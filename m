Return-Path: <linux-kernel+bounces-82842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3AA3868A73
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 09:08:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A177E1F24124
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 08:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70D3756440;
	Tue, 27 Feb 2024 08:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cmDbc12x"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D6A54F96
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 08:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709021283; cv=none; b=CGRm27R+DDM09/HcfhbbxGl/B6g1TfcqUpHWSq1zjuPELgW7z+BhhSFwWr0wxJMZm6QdGtRkSaoqXoo5zSS0DITTgwKnDBhj/55NIaj7O4ZNZOKeYfcpCzK4JUmEI232xrHxyKo9eirRnfds1Qha2LPD2g1W8/+meif5wjqEI/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709021283; c=relaxed/simple;
	bh=n1CqIB7HxwTIaN27h/cGfKFJJyQtYXmpjcrb3kKzZac=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VsUe/So7ziA/15Bg8qRynYxYTwkmZlbyE/qi7LzgdQrTt9iPb5A7XVnlYhBZuchnJuXoVTMOTHBcLd//a0AbAgkt4F5EhgiQ7j8S3SPvDVxmK7udl/difiRMfIJ8nnfmBHBI3s0tlecm0Q1+7ORM1AOoF48Yj2M/PkRJ1tEI6O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cmDbc12x; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5643ae47cd3so5119499a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 00:08:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709021280; x=1709626080; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3X6X6/tz50wnZDUvbb5WN4nVEsnFWe25Xdt4g8Ugnig=;
        b=cmDbc12xg7tUTv4OQ1H4ooGKndYbq0L5EX+HMy3ZiSORjIQkVJiXssADxWiEBs03UJ
         REWhXQA9XpQAYRdaziPbUcBNZWkZDBgxgqgI3Zokrp2bP+sVWD/zBZNQNj16dPnjL7EK
         +urufMSz12D4F+oId3y5Z5IIyAVbaYovUK4nu++q5PjQUoSAb+W9tGC7ObWnnrqYvaMz
         SX4Su54UeMxxLzBfRHEI3fP9lo9oAk7Qq17JNpJjYBwQ9+C1y7V944maGbH6PdmfIRfu
         HxUJqh6AVoZ1r517nAlJC5Tb/riiHuhDGhOgWYo47qy4R3oOxN6bzcng7rwVxEN+xDDd
         wuuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709021280; x=1709626080;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3X6X6/tz50wnZDUvbb5WN4nVEsnFWe25Xdt4g8Ugnig=;
        b=WhIf/ImuT7TcqTrkyICgRcVbRAsen7VhzM3jDfL/ls0RjnY3drmy4kIAkWX/oC60pt
         yUj3flyr4Bg/3YyW4KA7FMS5d+SnUX5nFcrNDihOja6Malr7OP4PM8Su14rqCGd1F66H
         JcO91MacNVYWQvviady8VBf39UK8QO9xzN6vuJ76eqMoWxHWnWzXl3A/A/XIkNewbdni
         1dKv+fooppfe84JGxzg9LHEx+oSE7yNOrMzICMfO0ARE6ShtCnh/RaI/nA6PfvHfhk48
         O9SeMGXVfl88SsXajwMYvVw1vg/2Bq4LsxMCDnkKtyOor30xPI0HDZzRcbF6uH/HVVSX
         WWKw==
X-Forwarded-Encrypted: i=1; AJvYcCVHw2D19qhBOubvT+osO14nuNzawSFUfxx1NxWzWyZYrd/o9N0Esc6RIW/QDFnFOMluMdjzE/zEOfT7ao9wWc7qLYROX1aMJGv3WgIN
X-Gm-Message-State: AOJu0YzEYYcjb8nr70itxLgIWaDeQEYvQl0yiw8VN0m9EJGdwUp7Dypf
	wmQidahHL/tGhka/y+mc9TluuJUahCc3BPtacWMJ7yi6jNKPoM/hz2XjxpKOeSs=
X-Google-Smtp-Source: AGHT+IFaapiS/FFG8BskCGhtgplEMxtjTEE3oU8cJgGqNh5gbBgUjZ/8L7PXjg1DmlNnflpw/Pm3Qw==
X-Received: by 2002:a05:6402:b2d:b0:564:87c1:a1e8 with SMTP id bo13-20020a0564020b2d00b0056487c1a1e8mr6917441edb.13.1709021280356;
        Tue, 27 Feb 2024 00:08:00 -0800 (PST)
Received: from krzk-bin.. ([178.197.222.116])
        by smtp.gmail.com with ESMTPSA id b22-20020aa7dc16000000b00564d7d23919sm509662edu.67.2024.02.27.00.07.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 00:07:59 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Olof Johansson <olof@lixom.net>,
	Arnd Bergmann <arnd@arndb.de>,
	arm@kernel.org,
	soc@kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Peter Griffin <peter.griffin@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk@kernel.org>
Subject: [GIT PULL 1/3] samsung: drivers for v6.9, part two
Date: Tue, 27 Feb 2024 09:07:53 +0100
Message-Id: <20240227080755.34170-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

On top of previous pull request.

Best regards,
Krzysztof


The following changes since commit 97d4b55111efd72926eb92cbd81c5ad8e6a7b3b1:

  MAINTAINERS: Remove Tomasz from Samsung clock and pinctrl entries (2024-02-07 16:35:26 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-drivers-6.9-2

for you to fetch changes up to 746f0770f916e6c48e422d6a34e67eae16707f0e:

  watchdog: s3c2410_wdt: use exynos_get_pmu_regmap_by_phandle() for PMU regs (2024-02-25 11:39:25 +0100)

----------------------------------------------------------------
Samsung SoC driver changes for v6.9, part two

1. Extend Exynos PMU (Power Management Unit) driver being also the
   syscon to main system controller registers block, to support Google
   GS101.  The Google GS101 has PMU registers protected and writing is
   available only via SMC.  The Exynos PMU will register its own custom
   regmap for such case of mixed MMIO+SMC.

2. Rework Samsung watchdog driver to get the regmap to PMU block not
   via syscon API, but from the Exynos PMU driver.  This is necessary
   for the watchdog driver to work on Google GS101.

----------------------------------------------------------------
Krzysztof Kozlowski (1):
      MAINTAINERS: samsung: gs101: match patches touching Google Tensor SoC

Peter Griffin (2):
      soc: samsung: exynos-pmu: Add regmap support for SoCs that protect PMU regs
      watchdog: s3c2410_wdt: use exynos_get_pmu_regmap_by_phandle() for PMU regs

 MAINTAINERS                            |   1 +
 drivers/soc/samsung/Kconfig            |   1 +
 drivers/soc/samsung/exynos-pmu.c       | 235 ++++++++++++++++++++++++++++++++-
 drivers/soc/samsung/exynos-pmu.h       |   1 +
 drivers/watchdog/Kconfig               |   1 -
 drivers/watchdog/s3c2410_wdt.c         |   8 +-
 include/linux/soc/samsung/exynos-pmu.h |  11 +-
 7 files changed, 250 insertions(+), 8 deletions(-)

