Return-Path: <linux-kernel+bounces-95666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 206AC8750F7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 14:53:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF6DD28C8C3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 13:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69DB712DDA2;
	Thu,  7 Mar 2024 13:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ib5cTV4W"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0ED112D765
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 13:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709819584; cv=none; b=V/T6HdTXXrLV0ZAv5jRZM0KO0foqRHgaxIkn5h6Hpx6KxGGl8sesoR5a3RPK9CRySzZwgtCYtRW/hIpjV5QxpUVjrkok8dCEScYxrz4UphgEj9YGR+aV5a0xP6U42VFTUQKoaZXmY1aFggmIjCGKSKPkEkxTSMcnhX7AOCf03Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709819584; c=relaxed/simple;
	bh=iS/ZnjaK6TRmcPu9aNMP+C8wqkwmDYhlm+2dQy+Pr3c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RIj/P13DvzvPAcquCHenacDNqqXmvZUlLbScmaL/5yKn03w2X7FBe0UNtXO3yob84TSwXM1m7GpDbaSk5hEiKf8kcgoBChv8XDBICIpG9xkottfR3GVzNv9foIFftqI/rubaO+jQbtsYGnvv/IKNQHB4Gq4Xgl3Evy14ecgi8LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ib5cTV4W; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-412e96284b9so7450995e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 05:53:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709819581; x=1710424381; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OFRg8xB5AgYKtJRkOv35muuJJ49OzwPBSX7Kgc4LZhI=;
        b=Ib5cTV4W/J578+YD7JHYv5shZo+gtyE2wHZyMkZDShl1l9YINlBY/kzWgUHTNR1a1h
         OrZ7tDS3PsWct1gaWTDbPLmY2Hgv3gxaNb+FON3gyPj5dIBfUZUY+9UOH/YTw8vxHjMt
         leyFHypkkw11gE8T0fJ+aev65nWg/nn03Yk73r3jEUsVjYXq4UuAleIgLylnZ16M0EeU
         nTTrOXQn4VA/orTFVXLYHfqLjGvQH7roL/RvoXxRdbKcuDb/di62zOfqq64YW9lwokIs
         VK5hyZJ32cdUDE7A6fmfPJAUNpILn5uEon+ny8lT4NoGWYFUADFeTpN1OT1e6X+fEKdb
         2F3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709819581; x=1710424381;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OFRg8xB5AgYKtJRkOv35muuJJ49OzwPBSX7Kgc4LZhI=;
        b=c4xwvtvKaW8AnoUfWQ6eUpHRhBLQQ7NZdOGGdT9vMnqrJ1H5MuHqv8PCQC9k2b7oDU
         c0m1LJ8csY3QmXJpx7RLaxeHWdXBaxf4hkTPRMj3altbvV9fZseFQYqGhSEOLFcAea0O
         6kXYowIwxrwk9w1bxFRqmVASopD01Tk37ngP4ldXO175dO1CWtUEr8Uby1g5syFjAKtE
         y5Upou+3he6JU5Bmkv2TksBzCgO94q3cQldD3f0GhqvKIYfElpmlH9S5eY6v+gHC6EuG
         kdbe2IHA82CDI4WC+xpBVvk2sIc7X1TTRhwFLnZ0BgGQhGYLo2Jd+YpFwUNKBSe0akjy
         gJiA==
X-Forwarded-Encrypted: i=1; AJvYcCWOmw28Xwowb+ofExt26XbBf0Rgj7+z/4iqJdfjud92qpa50X36m6kNQkpyWp6S/Zvkt+Wca0GpNbwiFoSKHdEIX1FAP3BR38H6SEfd
X-Gm-Message-State: AOJu0YwBh9WjYrofm9TjbgIWP99nFFGlVhrsxBtv3sXZEw3h448kquU4
	OCe0he4HhV3wmbvN+MOe/GIO+H5JXLT5Ez40eJZvcUI/UUSYiGkAraIWuPBMygI=
X-Google-Smtp-Source: AGHT+IF61AYutPgwA+UreNymAxWtde+Fu4g6cP5ZGMQQlNDE95ba8fYYdanfVRTO7jXImAkq32LYRA==
X-Received: by 2002:a05:600c:3596:b0:411:a94a:1ee with SMTP id p22-20020a05600c359600b00411a94a01eemr15040054wmq.21.1709819581260;
        Thu, 07 Mar 2024 05:53:01 -0800 (PST)
Received: from ta2.c.googlers.com.com (110.121.148.146.bc.googleusercontent.com. [146.148.121.110])
        by smtp.gmail.com with ESMTPSA id l8-20020a05600c4f0800b0041312cf472fsm1112390wmq.25.2024.03.07.05.53.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 05:53:00 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: peter.griffin@linaro.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org
Cc: alim.akhtar@samsung.com,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	andre.draszik@linaro.org,
	willmcvicker@google.com,
	kernel-team@android.com,
	Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH] arm64: dts: exynos: gs101: move serial_0 pinctrl-0/names to dtsi
Date: Thu,  7 Mar 2024 13:52:48 +0000
Message-ID: <20240307135248.162752-1-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The pinctrl nodes are coming from the shared gs101-pinctrl.dtsi,
thus the pinctrl-0/names shall stay in dtsi. Move them.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 arch/arm64/boot/dts/exynos/google/gs101-oriole.dts | 2 --
 arch/arm64/boot/dts/exynos/google/gs101.dtsi       | 2 ++
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/exynos/google/gs101-oriole.dts b/arch/arm64/boot/dts/exynos/google/gs101-oriole.dts
index 6ccade2c8cb4..9dc0f47ef646 100644
--- a/arch/arm64/boot/dts/exynos/google/gs101-oriole.dts
+++ b/arch/arm64/boot/dts/exynos/google/gs101-oriole.dts
@@ -103,8 +103,6 @@ key_power: key-power-pins {
 };
 
 &serial_0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&uart0_bus>;
 	status = "okay";
 };
 
diff --git a/arch/arm64/boot/dts/exynos/google/gs101.dtsi b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
index 55e6bcb3689e..ee65ed9d2cfc 100644
--- a/arch/arm64/boot/dts/exynos/google/gs101.dtsi
+++ b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
@@ -421,6 +421,8 @@ serial_0: serial@10a00000 {
 				reg = <0x10a00000 0xc0>;
 				interrupts = <GIC_SPI 634
 					      IRQ_TYPE_LEVEL_HIGH 0>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&uart0_bus>;
 				clocks = <&cmu_peric0 CLK_GOUT_PERIC0_PERIC0_TOP1_PCLK_0>,
 					 <&cmu_peric0 CLK_GOUT_PERIC0_PERIC0_TOP1_IPCLK_0>;
 				clock-names = "uart", "clk_uart_baud0";
-- 
2.44.0.278.ge034bb2e1d-goog


