Return-Path: <linux-kernel+bounces-43228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B41384112C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 18:47:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF1CC1F27B49
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 17:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 121A876C87;
	Mon, 29 Jan 2024 17:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t9icrykO"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8087B3F9CC
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 17:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706550431; cv=none; b=tpky1Zl0bY3Fjx8krGvaWhZq4sSsQZ7RF8TuGVs3LHqHggUv2EE38hUkzoWkmlBV8MqiAQXkVCYd/A6Srsfxo0Rd0XRc2G2uBVBnKxqLnvqwUipHYY0l2JXunj7kF+GuhYJOL0IUsvSQtWB1nNgOMddC/yjJLdt5OW8vImo2Lz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706550431; c=relaxed/simple;
	bh=BynP/TqLMLfBOswfTcC8kC5lE1LXFmDEjeWNmLl9lz8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=byG0aI/NwYX4tKKlM4EOT1LtU3U+GKmjrGaaKXJ6BUfOtjWszSWkAJ26wa1B8+nLtc+2baC5jRa0GWtWo0q5x6YgglFl7EakjUAsC4BuWZYBceHAgU8HPjtfsYMv3dUERV8bhUjKrhx2B0r7wJOCrk+nThCvBi7F2aDIvRRVYcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=t9icrykO; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-55a90a0a1a1so2583756a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 09:47:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706550427; x=1707155227; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jOscdCJLzZ5JXX0e0WvJ8V1LHndgq8+D5+LB5prqHn4=;
        b=t9icrykOuQYAjN3NDVzw6zhy7I6aFheFxtOcuFOV5Zm0rM2ur6NisDplNxC2Ii0lXc
         dhXcq+AGfS3QQG4LMHvLqNv2i3pQ6QVWH/JfzzQ8Fe5EcgZqYjcLiFoS2kYliJT5nIQg
         zE5Ei2SBvCWsG2m75nTHkHIe3NWsTz+VpY7Ex7eH7zn1NGXWO30Xbh/J7iphIIXpHNpt
         pZRBnaopV4R0FpVbSBwB5Q3YNAMYQQokw0XF7vxKZRn+R9WkVFLoONCm9b5gm4514K6N
         cxmZhqE7G3ov7ayUgHNdj723QeyWfLtz+3i0uPlT33N6BJs/VKQKziimvTIg9GA6fEgP
         GgdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706550427; x=1707155227;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jOscdCJLzZ5JXX0e0WvJ8V1LHndgq8+D5+LB5prqHn4=;
        b=E3YKcOAq/fRHEIzPFFgphOqczAEo9utd2rT/QaAD8vihKYQtBF2POK5THPACdOipGK
         LUMu1imiKmISfGxRg9mVA89JmIl4YgE9OycE2JvVfS1Hw+Dtv5yKGmgwrZr1IiT2qsX4
         4qgi0GdrFYH83KfeBWdJe/MIk15ul7OXL0oomSOIQd88/GD1RStFEUUssEzkiQ1XmZs5
         e6afOxpA6YugQwi/FFmBBkm+MJmxX4YLSCYK9AR4DXrffpPyQxj1Yk0qbqnvEvSuq4cq
         6bTe1IMK8ijvszO2SB4O8YbeyLu0Bw10uAMLBxJ7ZqqHb4kKnPA3+X24NA9QXSXIrxic
         iV5Q==
X-Gm-Message-State: AOJu0Yy3+Ou+0TB8sz8HA/W4QJED9TsFc2GYsvMsFTngC5CjVOgE/O6z
	ErJ0Ns4TUUWTnH9jvV2Uo9llNT1e5Azz9PNsEDRv0DyNAEEzVrxFPV7go0ZXRjY=
X-Google-Smtp-Source: AGHT+IFYj6qEhmjznFH5sRPH/JysLmerRvtAXfaQEg/8K2UqFf1zZ/2Rm3XOT1uZQIOgPdbakQe1Lg==
X-Received: by 2002:a05:6402:22d6:b0:55f:13f7:ad18 with SMTP id dm22-20020a05640222d600b0055f13f7ad18mr1412798edb.6.1706550426761;
        Mon, 29 Jan 2024 09:47:06 -0800 (PST)
Received: from puffmais.c.googlers.com.com (94.189.141.34.bc.googleusercontent.com. [34.141.189.94])
        by smtp.gmail.com with ESMTPSA id u10-20020a05640207ca00b0055f08fa9286sm1000999edy.23.2024.01.29.09.47.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 09:47:06 -0800 (PST)
From: =?UTF-8?q?Andr=C3=A9=20Draszik?= <andre.draszik@linaro.org>
To: peter.griffin@linaro.org,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@android.com,
	tudor.ambarus@linaro.org,
	willmcvicker@google.com,
	semen.protsenko@linaro.org,
	alim.akhtar@samsung.com,
	s.nawrocki@samsung.com,
	tomasz.figa@gmail.com,
	cw00.choi@samsung.com,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH v3 0/7] gs101 oriole: peripheral block 1 (peric1) and i2c12 support
Date: Mon, 29 Jan 2024 17:45:59 +0000
Message-ID: <20240129174703.1175426-1-andre.draszik@linaro.org>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This patch series implements support for the 2nd connectivity
peripheral block on gs101.
This block contains an additional 6 USI, 1 I3C and 1 PWM
interfaces/busses.

i2cdetect shows all expected devices on the one i2c bus that this patch
series enables.
Everything that's in scope in this series works also without the
clk_ignore_unused kernel command line argument.

While working on this, I noticed the existing peric0 support for gs101
has a couple issues. That explains why there are differences compared
to it and a separate patch series has been sent to fix up peric0
support.

Cheers,
Andre'

Changes in v3:
drop an invalid email address from recipients list, sorry :-(

Changes in v2:
- squash original patches #3+#9 (Krzysztof)
- move original patch #7 to new #4
- squash original patches #4+#8 and make it #5 (Krzysztof)
- add short summary of devices attached to i2c bus 12 & add TODO (Sam & Peter)
- collect Reviewed-by: tags
- I kept Reviewed-by: tags for the squashed patches. Please shout if
  that wasn't expected

 .../bindings/clock/google,gs101-clock.yaml    |   9 +-
 .../soc/samsung/samsung,exynos-sysreg.yaml    |   1 +
 .../boot/dts/exynos/google/gs101-oriole.dts   |  10 +
 arch/arm64/boot/dts/exynos/google/gs101.dtsi  |  41 ++
 drivers/clk/samsung/clk-gs101.c               | 347 ++++++++++++++++-
 include/dt-bindings/clock/google,gs101.h      |  48 +++
 6 files changed, 452 insertions(+), 4 deletions(-)



