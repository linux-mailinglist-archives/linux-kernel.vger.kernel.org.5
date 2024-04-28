Return-Path: <linux-kernel+bounces-161490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63CA48B4CB1
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 18:33:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2BE11F211CB
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 16:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2E7A7175B;
	Sun, 28 Apr 2024 16:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iQe/YZgk"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E5B710F1
	for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 16:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714322005; cv=none; b=O8gXOJaqDOc1Ai+Z5KXX2VrOPg06KRSwFWFDtgW4OKSSXWgWyuDpKGK7E+MdwvyxBIwT3RgO5mgkGY5AKUj3Yt4OBD8luwn4QTza6XP3R9kEF2HoaNQu167q/1mJMVeJSw3w28KwDvA0ZPrjCEM35ypJyjEzDiFb0rODUV/f61E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714322005; c=relaxed/simple;
	bh=hJwkw1Qe6He0UoOh47oNbcetclyLtp+Ip53ep8cFUls=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r25BGAdn42070v6OPbLaMJG8puOZ8OtbLRRcMp5sb685Y0PW2t/Squcu49QeO6zzpdiLgz9dZwtdTwe/WtrOd3UZBisr3ycvgM0B4Ygtai8KRcYOQzA4J20D9RUe12lr2qYT4R++3ly9Fm3FtFPjXlsHfk+pNnH3LItqSpvsw9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iQe/YZgk; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a5200202c1bso484468566b.0
        for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 09:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714322000; x=1714926800; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bkBehBmM8rJHl9TYbr2TiyM0+uJxcjWlmpw8IC5vBb8=;
        b=iQe/YZgkG3VfRhMfu7oqQ+qhLNl81XSjTEmfY9KNlvZNs/8tTKhwmrlPA1Y6mOOfiv
         U0jq/NelAiO0gMfis7Xn4qsgruRthqDjOIOtStweI6sJLYqQTFGWz2xC3T1Mp2hzsLSx
         IIaNwnUusxdAkDMhPEHQX1zzaJy/6nudFHBW/fTl5io5rbEeN+xvmJYelVlQAh1pZClO
         3ZqeDgO69t2atuisQEmBt0JBbrxlvjMePYLxXYefhQ5x4Yciz9dsAayyUcYalalKBJXy
         0QW55+r7OhADKy/RrcuYLKcLEQ7UCNKY10nG223aj5LahvPohacHRhPOu+3cTj5Y0G3m
         rpuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714322000; x=1714926800;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bkBehBmM8rJHl9TYbr2TiyM0+uJxcjWlmpw8IC5vBb8=;
        b=Z6HdNpn2RyPkPePRI8bWEgKb4LoyLREVb1LncKwfMu0HvBYRIH7oHdXXHAVmIfrxu/
         6+DIU59ZYVKSHHEReClLxypElOfl2peJGSMvpAby9XuDeNQP3udp1UL0OdDhF8Yzwh0T
         tzk57lCQnvY3jaGcapr9cKfD/5OkoT4/sZyQsPqUrxBIr1YlzBJ9bBlKIuvcxkIzoE+L
         eqikMM+D17MiBEKKtuE8W8oMCfrI2rCit0H6z3NWLA1+lMDH3eyiisYiOIMkLRFrzeAd
         N6ECgvj2piGuczI0DBjRwNx57V/z/NXamb7+w+sQwUj5R5Hp1QN2UA0k7Ka8WjxyzfgM
         0AlQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJcorw3p02Xxc5WpgMAlJXclL2TOT+Fxb9cK5AdwhvZMaprBtFaMGEO7T0ev7GiPs0YhX/uvlgII/+mlqkrpqHoQbPlj96mUoAl2cf
X-Gm-Message-State: AOJu0YwAKQVPY0dsvqQ/1k3OgteygeeXnGIa+Az97S6MT9PyjiMXtd/b
	kTIQEGz9jScZoula8QMSB5psvug7gmjs44T9/pVwnBwaVPW2SseubLJnKYTjIq8=
X-Google-Smtp-Source: AGHT+IG2xsOsBb1Q9wusjv7j48e04laj4MhrtGe2fyJZosVzz7UkCTyzwT62xmRR9KcjI6SwTW3mwg==
X-Received: by 2002:a17:906:1c8b:b0:a58:c09d:1484 with SMTP id g11-20020a1709061c8b00b00a58c09d1484mr7831776ejh.7.1714322000448;
        Sun, 28 Apr 2024 09:33:20 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id lb2-20020a170906adc200b00a58f4b3661asm1173623ejb.0.2024.04.28.09.33.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Apr 2024 09:33:19 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Olof Johansson <olof@lixom.net>,
	Arnd Bergmann <arnd@arndb.de>,
	arm@kernel.org,
	soc@kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk@kernel.org>
Subject: [GIT PULL 1/2] arm64: dts: cleanup and fixes for v6.10
Date: Sun, 28 Apr 2024 18:33:13 +0200
Message-ID: <20240428163316.28955-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit 4cece764965020c22cff7665b18a012006359095:

  Linux 6.9-rc1 (2024-03-24 14:10:05 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux-dt.git tags/dt64-cleanup-6.10

for you to fetch changes up to de2ba5bd3607a5e5442a5fcbdea6ee2823b72fb9:

  arm64: dts: cavium: thunder2-99xx: drop redundant reg-names (2024-04-24 09:23:56 +0200)

----------------------------------------------------------------
Minor improvements in ARM64 DTS for v6.10

Fixes, which might have practical impact, however things were broken for
long enough to justify pushing it regular path:
1. ARM Juno: shorten node names for thermal zones, because Linux drivers
   have strict limit of 20 characters.
2. HiSilicon: correct size of GIC GICC address space and add missing
   GICH and GICV spaces, add cache info to properly describe cache
   topology and solve kernel boot warning.

Several cleanups:
1. Use capital "OR" for multiple licenses in SPDX.
2. Correct white-spaces for code readability.
3. Fix W=1 dtc compiler warnings, which should not have practical
   impact for Amazon, APM, Cavium, Realtek, Socionext Uniphier and
   Spreadtrum like:
    - missing unit addresses,
    - nodes not belonging to soc node,
    - not using generic node names,
    - few incorrect unit addresses.

----------------------------------------------------------------
Krzysztof Kozlowski (25):
      arm64: dts: juno: fix thermal zone node names
      arm64: dts: amd: use capital "OR" for multiple licenses in SPDX
      arm64: dts: sprd: minor whitespace cleanup
      arm64: dts: sc9860: add missing aon-prediv unit address
      arm64: dts: sc9860: move GPIO keys to board
      arm64: dts: sc9860: move GIC to soc node
      arm64: dts: whale2: add missing ap-apb unit address
      arm64: dts: sharkl3: add missing unit addresses
      arm64: dts: uniphier: ld11-global: use generic node name for audio-codec
      arm64: dts: uniphier: ld11-global: drop audio codec port unit address
      arm64: dts: uniphier: ld20-global: use generic node name for audio-codec
      arm64: dts: uniphier: ld20-global: drop audio codec port unit address
      arm64: dts: realtek: rtd129x: add missing unit address to soc node
      arm64: dts: realtek: rtd139x: add missing unit address to soc node
      arm64: dts: realtek: rtc16xx: add missing unit address to soc node
      arm64: dts: cavium: move non-MMIO node out of soc
      arm64: dts: cavium: correct unit addresses
      arm64: dts: apm: storm: move non-MMIO node out of soc
      arm64: dts: apm: shadowcat: move non-MMIO node out of soc
      arm64: dts: amazon: alpine-v2: add missing io-fabric unit addresses
      arm64: dts: amazon: alpine-v2: move non-MMIO node out of soc
      arm64: dts: amazon: alpine-v3: add missing io-fabric unit addresses
      arm64: dts: amazon: alpine-v3: drop cache nodes unit addresses
      arm64: dts: amazon: alpine-v3: correct gic unit addresses
      arm64: dts: cavium: thunder2-99xx: drop redundant reg-names

Yang Xiwen (3):
      arm64: dts: hi3798cv200: fix the size of GICR
      arm64: dts: hi3798cv200: add GICH, GICV register space and irq
      arm64: dts: hi3798cv200: add cache info

 arch/arm64/boot/dts/amazon/alpine-v2.dtsi          | 35 +++++++-------
 arch/arm64/boot/dts/amazon/alpine-v3.dtsi          | 12 ++---
 arch/arm64/boot/dts/amd/elba-16core.dtsi           |  2 +-
 arch/arm64/boot/dts/amd/elba-asic-common.dtsi      |  2 +-
 arch/arm64/boot/dts/amd/elba-asic.dts              |  2 +-
 arch/arm64/boot/dts/amd/elba-flash-parts.dtsi      |  2 +-
 arch/arm64/boot/dts/amd/elba.dtsi                  |  2 +-
 arch/arm64/boot/dts/apm/apm-shadowcat.dtsi         | 14 +++---
 arch/arm64/boot/dts/apm/apm-storm.dtsi             | 13 ++---
 arch/arm64/boot/dts/arm/juno-base.dtsi             |  4 +-
 arch/arm64/boot/dts/arm/juno-scmi.dtsi             |  4 +-
 arch/arm64/boot/dts/cavium/thunder-88xx.dtsi       | 20 ++++----
 arch/arm64/boot/dts/cavium/thunder2-99xx.dtsi      |  1 -
 arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi     | 43 ++++++++++++++++-
 arch/arm64/boot/dts/realtek/rtd129x.dtsi           |  2 +-
 arch/arm64/boot/dts/realtek/rtd139x.dtsi           |  2 +-
 arch/arm64/boot/dts/realtek/rtd16xx.dtsi           |  2 +-
 .../boot/dts/socionext/uniphier-ld11-global.dts    |  4 +-
 .../boot/dts/socionext/uniphier-ld20-global.dts    |  4 +-
 arch/arm64/boot/dts/sprd/sc9860.dtsi               | 56 ++++++----------------
 arch/arm64/boot/dts/sprd/sharkl3.dtsi              | 18 +++----
 arch/arm64/boot/dts/sprd/sp9860g-1h10.dts          | 30 +++++++++++-
 arch/arm64/boot/dts/sprd/whale2.dtsi               |  2 +-
 23 files changed, 159 insertions(+), 117 deletions(-)

