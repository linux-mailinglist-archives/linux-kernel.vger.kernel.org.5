Return-Path: <linux-kernel+bounces-158110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 908FC8B1BBF
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 09:19:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54C69286431
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 07:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4C3F6BFD4;
	Thu, 25 Apr 2024 07:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wfPZZ0LM"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68AAF6BB48
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 07:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714029545; cv=none; b=L0tCks2kMztOzQPVZqAtBUnPeHCBf6vvI4n89epMGTU2qryOIcmJNEf9e+RswX58tws+Hs0wTnlLBS6orzyXna326c5DqhBRJBK3c9YjfYSpSpDDNvNPQ1ZDFiHyEGWwiBexPEvm/bTx9Lrfmn+DJfb8iJW+n9zk9l1UnMsIYew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714029545; c=relaxed/simple;
	bh=8ZIuLwdqyRl99K9D+WymS75aTRlcgfTHWE8UcmGPEg4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IySuplPpGNCX1jNCQ3+6mmr9nMmeYrkJ3+YqCune2b4Zv6ciK1rpakPIFempWM5Ynb3qXIY2adhkHvluYZs38W6CiaAaDgwZXEVlvEN6jlFQ5RuI2rl7YytfM4iEKCuxJCY9mfBx1DZ1jnO0aCyGZwVzPkukszLwII0JbArqwO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wfPZZ0LM; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a5544fd07easo83239666b.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 00:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714029541; x=1714634341; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UiWg4ZuYlxN9cQPVnhmdQjPdfi8HEtEf8/z5K2DVwdU=;
        b=wfPZZ0LMykS77q2e8D7mUPxnQiJh2FeMzI22SKLZSGi2cfbDr14r8Vxjj7pKuPXV1T
         SFvSAXpB7A1IDmAYVf0LYCmvU6a4qoLWXUm7ypM/pt0HyN9sgdEgcucoWMteHldq8i3j
         9IO/TD0jMl+A1LXQiXmcTxEzUhxZWKSfRQTbcAX9jNcTZZ79i+rYewGv9e4g5bfrh0TD
         i7/yTHlZT5Uc8uIbnMmXVSXM96gyxCiTAfn8m5wcdbK3jwCNSXSH7F7rUcczweqLN8sf
         Ww+5ntwd2c2UhEsajGUxAL38Ru1nqHDxRCXbRAXqwh0m+k0tDIlYpXFijOIg4vFAcink
         Vq8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714029541; x=1714634341;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UiWg4ZuYlxN9cQPVnhmdQjPdfi8HEtEf8/z5K2DVwdU=;
        b=SsfyxJf7QwMraIYQc1vWHhnpOG3vOLZydrqM5EQNhrfZs5Rl6jKT69t5s2phT0Fill
         NQsX6zcSbGzCV86jD7VNg7BoaQs0awWucL/N7yAX8UdLdnopx3QHrIaIkvx3hjC4779G
         atUV23+OhZAdELxWRrkx9clIoKTf17HMeeDij7LiI4/lI7epNIRDJxtX7pgFcVKR1RUX
         e4APWXI1gA6EAV3ceSSFanQfrDgArFILNqmsNtEENBJcdRYob6l09OWr+3F4af3xXAJh
         bjkH3hFSiXBTA9fX3utphr+4/pC+8dcJgaemX0c5/1wf1pDro/DXBiRsTCm4UayUAm6w
         9gvw==
X-Forwarded-Encrypted: i=1; AJvYcCXFfMoT2nJpCxsb+RGEHlP9lymi/A3x0TGEJU47ePDMlX2yJ20w1GWxrDRjQGsKZ7Bf+S0ZrDoRt5Yq6DKgQ/5HnbXjar41di+nbKBd
X-Gm-Message-State: AOJu0YzFuD+RHlGtNiN8vj2FaM1PoWJCai9VL6HpL4nsCWDHeGS7pqgu
	MdwJSi6TYJLPcdJYQEYIL9PNa+BWYqKeICO/9Q8Ce3qQZNZnn2GLacGEs2PQhxM=
X-Google-Smtp-Source: AGHT+IHIPqKC4UKrFERHT+wWEYW/Paz6CXd8QxzmTWJl10ZcPGrFWZEyzu2/SlGkUFW1fQN5nzOzBg==
X-Received: by 2002:a17:906:cec7:b0:a58:7edb:f4be with SMTP id si7-20020a170906cec700b00a587edbf4bemr3172637ejb.46.1714029541042;
        Thu, 25 Apr 2024 00:19:01 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id hd38-20020a17090796a600b00a556f41c68asm9091174ejc.182.2024.04.25.00.18.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 00:19:00 -0700 (PDT)
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
Subject: [GIT PULL 1/2] ARM: dts: samsung: dts for v6.10
Date: Thu, 25 Apr 2024 09:18:54 +0200
Message-ID: <20240425071856.9235-1-krzysztof.kozlowski@linaro.org>
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

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-dt-6.10

for you to fetch changes up to 7bff1d35c1294c011b0269b8eaeb8f930df386fe:

  ARM: dts: exynos4212-tab3: limit usable memory range (2024-03-26 10:06:05 +0100)

----------------------------------------------------------------
Samsung DTS ARM changes for v6.10

1. Few cleanups of deprecated properties and node names pointed out by
   bindings newly converted to DT schema.
2. Fix S5PV210 NAND node size-cells, pointed out by DT schema.
3. Add FIFO depth to each SPI node so we can avoid matching this through
   DTS alias.  Difference SPI instances on given SoC have different FIFO
   depths.
4. Fix Exynos4212 Galaxy Tab3 usable memory, because stock bootloader is
   not telling us truth.

----------------------------------------------------------------
Artur Weber (1):
      ARM: dts: exynos4212-tab3: limit usable memory range

Krzysztof Kozlowski (7):
      ARM: dts: samsung: smdkv310: fix keypad no-autorepeat
      ARM: dts: samsung: exynos4412-origen: fix keypad no-autorepeat
      ARM: dts: samsung: smdk4412: fix keypad no-autorepeat
      ARM: dts: samsung: smdk4412: align keypad node names with dtschema
      ARM: dts: samsung: exynos5800-peach-pi: switch to undeprecated DP HPD GPIOs
      ARM: dts: samsung: s5pv210: align onenand node name with bindings
      ARM: dts: samsung: s5pv210: correct onenand size-cells

Tudor Ambarus (5):
      ARM: dts: samsung: exynos3250: specify the SPI FIFO depth
      ARM: dts: samsung: exynos4: specify the SPI FIFO depth
      ARM: dts: samsung: exynos5250: specify the SPI FIFO depth
      ARM: dts: samsung: exynos5420: specify the SPI FIFO depth
      ARM: dts: samsung: s5pv210: specify the SPI FIFO depth

 arch/arm/boot/dts/samsung/exynos3250.dtsi         |  2 ++
 arch/arm/boot/dts/samsung/exynos4.dtsi            |  3 +++
 arch/arm/boot/dts/samsung/exynos4210-smdkv310.dts |  2 +-
 arch/arm/boot/dts/samsung/exynos4212-tab3.dtsi    |  6 ++++++
 arch/arm/boot/dts/samsung/exynos4412-origen.dts   |  2 +-
 arch/arm/boot/dts/samsung/exynos4412-smdk4412.dts | 12 ++++++------
 arch/arm/boot/dts/samsung/exynos5250.dtsi         |  3 +++
 arch/arm/boot/dts/samsung/exynos5420.dtsi         |  3 +++
 arch/arm/boot/dts/samsung/exynos5800-peach-pi.dts |  2 +-
 arch/arm/boot/dts/samsung/s5pv210.dtsi            |  6 ++++--
 10 files changed, 30 insertions(+), 11 deletions(-)

