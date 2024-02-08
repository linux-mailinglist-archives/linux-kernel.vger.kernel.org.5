Return-Path: <linux-kernel+bounces-58340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FE1D84E4EB
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 17:21:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 771CCB25537
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 16:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 993327EEEF;
	Thu,  8 Feb 2024 16:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OoL2/TIr"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D98B87EEEA
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 16:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707409287; cv=none; b=mDyTCAk7xwJ7WS5GraHkFOHqL21JUTJMNEewhZPDW+VEVaztl3EV1wVayzW+ToigvLAl0ErzM/q0ZEE4xFqrwfh1RjR18J2nIa4k5AUDQI3HeReZkxT2Z3LbKpYfM8bFtn4S3Nka72QeqOJ0Ni5I6PJQGqO205PP6mLbZ3GAB8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707409287; c=relaxed/simple;
	bh=U0uGEH2A3ci7wPLijr9npt5FveIBzfHdtcmd6JdmRNw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P5Ix0Q1EQE1jPujj3iDlcLL3oz1VlAxYBAJhipltrLgv6Uwo7UfhmtvLP/0/4OHYCpcnRLU/8VwOz1q2D9uP1Uj11B97aGjEqdF/z4W5MpRdnxtOZzmE/tx6ix319GYAQSE5T8HbxwyBsQdfkPQ5gDSyPr/+kL2cVyxla1eU5nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OoL2/TIr; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-339289fead2so1411660f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 08:21:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707409284; x=1708014084; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4an9xpeJCw/uJKBtsN9iFQPLTnnjc49mN5XWvlsDwF0=;
        b=OoL2/TIrgggorKI34MlT84bRnUcJ4vq0O88K1uzSeZBxYYXx6SNDMUNnMSu8xcDjAq
         X+1NI4o3z2nnqno4aumrz805T5Dl3PrFRCzAPlFJiZQ3+J/QAyvM7iBuoXGt/YE/HmTe
         seW30cchbL686CQ2gh8ihsGjcH95i7BsQCOjL3g++f4z064KLVJT/ceCArVguRWvzLLy
         27P5rMNlqKnxjgrkg0amNd3/BALm7o5ygCcpuhzORi0rZk7r9ndgRhaVzmFdQ5KD2X94
         Da3ooWkaFPOs2OhnwzDGg3EyhUcmakrJAxWjWjuShJGsTKaw5HbbI17J9uvQAq4X2zpr
         xNlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707409284; x=1708014084;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4an9xpeJCw/uJKBtsN9iFQPLTnnjc49mN5XWvlsDwF0=;
        b=Jl5ejKP8bv0sobE70mh5k3DzSGrUeIUqj85aUzJoBpFbQOu3fwM8voZTGMYO2ylwbO
         blqcwdk5x4SB3WehWAt/6Qjq5uI074GY4Oglh8GUJiu0oRKFXXNv3bfeTDgAxPsoMpNb
         ZHuq0/+Nx32EOQpEMpPnAyu6n+7I/fBYJK9HYCE9fgp73CyjTz/Ik+BaWnPjOh7xdyAs
         L4H6oU15Bq4wICqwOYyxePC3Q8q68l6VTlHPqwy4zTEQH5TnMQ6KyKifumMrrz20iXXT
         PsFheaGNuLs+tCvuQvsA8skUW1kaadvKCJp7O+sBRBnbQEufkLUIp2vNETO6SoALAfDY
         YSaw==
X-Gm-Message-State: AOJu0YxcMzQIr/IA1gbxWXOioKSEK89/7aVzGo9F0WAY0Gqo55Rq5Tr/
	yCv8528CIWkCD076U+Fw3jtGCizccbVgkiFZViSaANWoYNQNQytopJKQJKydQ4U=
X-Google-Smtp-Source: AGHT+IEhIUssuh6f0tZ4cr8pY2KG5IU7kuCv0jWoMHYcV22kLSQkQnaQt7DRk8W9DfJgN2r32G0JUw==
X-Received: by 2002:a5d:4576:0:b0:33b:2da1:fdd8 with SMTP id a22-20020a5d4576000000b0033b2da1fdd8mr6681327wrc.20.1707409284030;
        Thu, 08 Feb 2024 08:21:24 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV03+8aVgx3AKPeTM7x+RaYghRyeTXMnpSXRgOrezPcwD4hs7+JjRP9fwFoxlj6fI0QEBHiqc82gDir2eFacWQIGQCc/bf2wKSm/RfHfRBatTRwP9bFuzpjKFl0jDzNf4HoGnhfjBkmgrr+pTzcrEvS8C3s82cng+4TFyB+wBtWmn8KuPbROZwON0EXWvY/ac03JpRj6kZ8Ma/dbMZccRjyXBhd5bRl4WoUKtaau3xRgwau0MW4iVW6xdFXz1NQaUoEPhJGVyILLauZdVmzBexjQ2Y0nJ9N9h7giwFXYtj6/FoSGbUSLooGypl5CmcFr7NJtQFUkfSSdhlzhlajGRSWSt9l8p5eguyKTRnDisoEe8K/39AWKzqg9CzdOYto/LlcgC+3lRA21PIX/MrtBtnqc9eZbjsXwHItWDdkRCQcZGPg8AYruTQfLvZZrC5xMDytduIvcZTa+9Jw9K5npcAy4/JDzRIx5JydXrxcZhkHIQ6MSm0oIUGDViR5YnyHW0IyZ17aEIalc+FeZ4HLXBLvw18uaQKPZqWurwDqz9u6KmuPGLlGEAUjMlUu1w+SQPDGKArbfTcJiteSGn5o49a/mlyHknRtWqj+29pGbaWWg9Svpvs9WYp1SX+OT4W0975vzF1YmId3mwAg/4d6Ccgc9JWSx1PDZtAprW0=
Received: from gpeter-l.lan (host-92-21-139-67.as13285.net. [92.21.139.67])
        by smtp.gmail.com with ESMTPSA id v18-20020adfe4d2000000b0033aedaea1b2sm3915846wrm.30.2024.02.08.08.21.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 08:21:23 -0800 (PST)
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
Subject: [PATCH v4 0/2] Add regmap support to exynos-pmu for protected PMU regs
Date: Thu,  8 Feb 2024 16:16:58 +0000
Message-ID: <20240208161700.268570-1-peter.griffin@linaro.org>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi folks,

This is a v4 of the series to add support for protected PMU registers found
on gs101 and derivative SoCs. In v2 and later it was re-worked to be based
on a regmap abstraction that I think leads to a much neater overall
solution.

The advantage of the regmap abstraction is that most leaf drivers that
read/write PMU registers need minimal changes.

Example of Exynos drivers that require PMU register access are:
* watchdog
* usb phy
* mipi phy
* ufs phy

This series has been tested on Pixel 6 / gs101. If the various maintainers/
contributors of other Exynos SoCs like exynos850, exynosautov9, exynos5422
etc can test these patches on your respective systems that would be most
appreciated.

The expectation is this series would be merged via Krzysztofs Samsung
Exynos tree.

regards,

Peter

Changes since v3:
 - Fix PMUALIVE_MASK
 - Add TENSOR_ prefix
 - clear SET_BITS bits on each loop iteration
 - change set_bit to set_bits func name
 - Fix some alignment
 - Add missing return on dev_err_probe
 - Reduce indentation in loop

Changes since v2
 - Add select REGMAP to Kconfig
 - Add constant for SET/CLEAR bits
 - Replace kerneldoc with one line comment
 - Fix kerneldoc for EXPORT_SYMBOL_GPL funcs
 - remove superfluous extern keyword
 - dev_err_probe() on probe error
 - shorten regmcfg name
 - no compatibles inside probe, use match data
 - don't mix declarations with/without initializations
 - tensor_sec_reg_read() use mmio to avoid access restrictions
 - Collect up Reviewed-by
 - const for regmap_config structs

Changes since v1:
 - Refactor to use custom regmap to abstract SMC register access
   (Sam / Guenter)
 - Add deferred probing support (Saravana / Krzysztof)

v3 lore: https://lore.kernel.org/linux-arm-kernel/20240202145731.4082033-1-peter.griffin@linaro.org/
v2 lore: https://lore.kernel.org/lkml/20240129211912.3068411-1-peter.griffin@linaro.org/
v1 lore: https://lore.kernel.org/all/20240122225710.1952066-1-peter.griffin@linaro.org/

Peter Griffin (2):
  soc: samsung: exynos-pmu: Add regmap support for SoCs that protect PMU
    regs
  watchdog: s3c2410_wdt: use exynos_get_pmu_regmap_by_phandle() for PMU
    regs

 drivers/soc/samsung/Kconfig            |   1 +
 drivers/soc/samsung/exynos-pmu.c       | 235 ++++++++++++++++++++++++-
 drivers/soc/samsung/exynos-pmu.h       |   1 +
 drivers/watchdog/Kconfig               |   1 -
 drivers/watchdog/s3c2410_wdt.c         |   8 +-
 include/linux/soc/samsung/exynos-pmu.h |  11 +-
 6 files changed, 247 insertions(+), 10 deletions(-)

-- 
2.43.0.594.gd9cf4e227d-goog


