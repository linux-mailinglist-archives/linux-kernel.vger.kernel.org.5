Return-Path: <linux-kernel+bounces-38808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 114FC83C63E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 16:16:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B71391F23FDE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 15:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C15516EB6A;
	Thu, 25 Jan 2024 15:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Iw501bHG"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43BD86E2C9
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 15:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706195803; cv=none; b=bKX3LsvA8V8Epeg84j/5UnIkMh48f9MzXJQrdrNLENxLaxXBzaVwcH9VWM7/UcGkVJk84YGLDK5PhimzV3GyF9nmXxmwiTaUQ6iecgnDtHW/sGGNjgd8O0s7svRfAt7ANcl3Bg+sUS5vgRnWxD4jb73yZOxad/bznXn1VTxbaLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706195803; c=relaxed/simple;
	bh=4BxrtBPH2UllVjdx17u9FU/VESUsZNydVxtjXqe+9sA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Hc7J7j1nIzZ+TqHa+EU+LWxNxX5IFMx9IxQCsf28Ov+uXQtCXJGLT9+Oy2h9+wHTWzzuRMJLP0ZZPso2OCeUi4lq/ryK6cYmGQt76Pf1JeeIe5RtLXGVTv4kUKp+xtnKq3OSEM/oWz112xB+y98vC7PlExHp8LxXXESBy/FrlK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Iw501bHG; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3392b12dd21so4578387f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 07:16:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706195799; x=1706800599; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qQoIeZ794qaGVa7O+x2w9XHa6gq/yapDW4Z31do6ZCo=;
        b=Iw501bHGTfzYMCwqniNCE+J9+6PVIIFgfKJ4FPVfbZNJqJIIiljY2GVh2aZ2tSdISc
         QAJMqdKVKCfO9vuyKXY1kx3+N318yUy6sHVS/CNCjN+3pjjhQASIhXoQKOy5G2a3oj+N
         cwKKAiIBU3oJK9eH60KgaSN6htc/aprAzogOL8JiETYIYiZ+RswZWiRyRZg+X2u+JA+c
         5bAqpzMs2vrLAZkQOr3KcaJyFEmlJpSB9AFvTBh5lNcd1kK4bKBYa9JLICIOuyi1idgq
         gGoGNR1uYRtIVVVbRhKi7Diy0AhZpW3XlCnS3+C/ZlyjqCrX/fJ7AmHUi992UBvtBSss
         /ZDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706195799; x=1706800599;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qQoIeZ794qaGVa7O+x2w9XHa6gq/yapDW4Z31do6ZCo=;
        b=KfMVE0MEY66G+gOMY5oWC2BaowVC2ip39rNTSOOaVqtigYB1QJguS2guhqEDgO7o8f
         XcWwzwLeZK/HHlu6VT4Z4f7J+ZH50Ki5Ef+M1FLXzX+dWN0/Yi8kI3KSbbP60SOtTBqm
         L9Yv255W3LI83PFgxTOtTp0x2a0ycztAxno+DNz7FPO0Wsns9/dMrNHYtdlH7GTP0REf
         1u5O1A0KHyblb2MDhusNmA8GgILy3jUcgszMYEdNw79M0imspKsAjqJwBnd4IILm9Ie7
         vsmcHZcC2jsRSPrfLq4zxgAhC4n1S3QYnVKqMAAm1TMu59o4/blEXo35BQPpS6kHFa6q
         mYvg==
X-Gm-Message-State: AOJu0Yz8k6aVdakX1LZCLHJK5glCiFhAPVItO6XmvxTasz4hXgpRP74S
	nmnHOipFlwIg8hAr4Dq/j35QFtEZJIva5qqnlNsa1Ilp75nh0+3aRlwvJXdDTAU=
X-Google-Smtp-Source: AGHT+IHP8rPbXmySZmV4hTwPoeW+IcSMERM2waGJhBWSvZn39MNoFHAqNGw/HYgSokHmRAreNlQqww==
X-Received: by 2002:adf:e9d2:0:b0:337:bba4:6bdd with SMTP id l18-20020adfe9d2000000b00337bba46bddmr664866wrn.54.1706195799478;
        Thu, 25 Jan 2024 07:16:39 -0800 (PST)
Received: from ta2.c.googlers.com.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id q17-20020adfcb91000000b00337d3465997sm3184656wrh.38.2024.01.25.07.16.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 07:16:38 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: krzysztof.kozlowski+dt@linaro.org,
	broonie@kernel.org
Cc: robh+dt@kernel.org,
	conor+dt@kernel.org,
	alim.akhtar@samsung.com,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org,
	andre.draszik@linaro.org,
	peter.griffin@linaro.org,
	semen.protsenko@linaro.org,
	kernel-team@android.com,
	willmcvicker@google.com,
	Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH 0/7] ARM: dts: samsung: specify the SPI fifosize
Date: Thu, 25 Jan 2024 15:16:23 +0000
Message-ID: <20240125151630.753318-1-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

The "samsung,spi-fifosize" was introduced in the following patch set:
https://lore.kernel.org/linux-arm-kernel/20240125145007.748295-1-tudor.ambarus@linaro.org/T/#t

I expect Mark will provide an immutable tag for the bindings so that it
can be merged into the samsung tree. We'll avoid this way using the
property into the device trees without having it defined into the
bindings.

These patches close the circle and break the dependency between the SPI
of_alias ID and the SPI driver. The SPI of_alias ID was used as an index
into the fifo_lvl_mask to determine the FIFO depth of the SPI node.
Changing the alias ID into the device tree would make the driver choose
a wrong FIFO size configuration, if not accessing past the fifo_lvl_mask
array boundaries. Not specifying an SPI alias would make the driver fail
to probe, which was wrong too. Thus I updated the driver and I provided
alternatives to either infer the FIFO size from the compatible, where
the SoC uses the same FIFO size for all the instances of the IP, or by
using the "samsung,spi-fifosize" dt property, where the SoC uses
different FIFO sizes for the instances of the IP. This patch set takes
care of the second case and adds "samsung,spi-fifosize" for all the SoCs
that need it.

Cheers,
ta

Tudor Ambarus (7):
  ARM: dts: samsung: s5pv210: specify the SPI fifosize
  ARM: dts: samsung: exynos3250: specify the SPI fifosize
  ARM: dts: samsung: exynos4: specify the SPI fifosize
  ARM: dts: samsung: exynos5250: specify the SPI fifosize
  ARM: dts: samsung: exynos5450: specify the SPI fifosize
  ARM: dts: samsung: exynos5433: specify the SPI fifosize
  ARM: dts: samsung: exynosautov9: specify the SPI fifosize

 arch/arm/boot/dts/samsung/exynos3250.dtsi    |  2 ++
 arch/arm/boot/dts/samsung/exynos4.dtsi       |  3 +++
 arch/arm/boot/dts/samsung/exynos5250.dtsi    |  3 +++
 arch/arm/boot/dts/samsung/exynos5420.dtsi    |  3 +++
 arch/arm/boot/dts/samsung/s5pv210.dtsi       |  2 ++
 arch/arm64/boot/dts/exynos/exynos5433.dtsi   |  5 +++++
 arch/arm64/boot/dts/exynos/exynosautov9.dtsi | 12 ++++++++++++
 7 files changed, 30 insertions(+)

-- 
2.43.0.429.g432eaa2c6b-goog


