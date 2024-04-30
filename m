Return-Path: <linux-kernel+bounces-163723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C06A8B6ECC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 11:50:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38E2A283E86
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 09:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EB27129E86;
	Tue, 30 Apr 2024 09:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YEzPlRbK"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC22129E7C
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 09:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714470593; cv=none; b=UxqzPBTJbKWBFW7BQT7IEUJrBKFCm8Whg8sePUcU0UM8jEfGGEbTLmwmoSsx1g7WTwHF3RcfZcP9zW5rz8m3WA+XrRH7oIrTWkJepwQHKhkzXk0F65/u/tC31S9s6xpu2RE+YRu5Ol/BavU9FY91rfwA+lqzG+PdpskhCsF5Cfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714470593; c=relaxed/simple;
	bh=6EPfWTqm/lFaZs1kyJ73zKT+bkJLAEfvahvw8Cv8KkU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PAeeCVyjBlR4HzfVvImUJv+bSZPPJ3ziVCYVr2Ys30IXp+Gipijawf0PqLME73XSD1Q5916rC7vU0SiZyoit97Zuiq6IvfcAbEG50tFrXXx6L7vkil8r+WRiRbI1SU+ceqG1jDVRC9A1ZbE6AK7dZPiKv75VKq5bkfhsyP4dZCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YEzPlRbK; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-57230faeb81so3254843a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 02:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714470591; x=1715075391; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F8gW4wGr4HSLlzWyo25Ekg/cBo+LkQV9cqhppDRnOws=;
        b=YEzPlRbKJDyg47YeWH4dSrB3ivagEfs3rn5dCq5Ly3qgb+q0LrZiErlbbhehtZIhtF
         sMA3nMV/561SdY7rz1zatcqNo4SMmO/iQmznK4zOr8CoY64Hh3l1xQ5nH3wpSvo0jIXv
         mDByOjJemlt1UJlc17OXYbiDYcjqjJigueQX0KylqWsiFwWe4oI3ZRD+jt68U9R+nPKk
         Eb5pkdm9m/rVKXuIu/LLJBWQl9/WcmoGe3fyJTIAsPwUPSeLjhDuHj4mvK05y+9eTRqg
         6wGDVbCw1VUuD516GiIuSKM6YnttQ3Jecz14ROJXhIBx/f0WlzufelWy7iToWOI6KyQp
         Gjsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714470591; x=1715075391;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F8gW4wGr4HSLlzWyo25Ekg/cBo+LkQV9cqhppDRnOws=;
        b=NcKW7bWyISPNJvRJDCCeVpDYv38TQmhSSNu29YMPue82lF+9ksBz2yoQ/UgDxLKDv6
         cvpE8q35qS/C5PkqtY5XdiPIT+vw114w3nnwyEBWTl7kGTaOydjxvuUftiCc3NkWtulU
         EqSdVswslEg1pefVPyeW/tGAymMgft3ISREk3fyxTuwocnVNSR6oKAbdG3LYyDAthl9v
         8nZyCJ6tFUU02CzqlBnw7lWFtatoYVgOH1IA+gLmYQ1puFTxesPEB9PdSoja71b3D5Jd
         3yFHOAM0MILV+0xpVjhUFZNqM2xkpjIGTSPmczyBrpwdMURFZRPG46cGatq/Y+HYdAID
         gQyQ==
X-Forwarded-Encrypted: i=1; AJvYcCXAA65mLHhdCCOemPxmD3acAbVQn4GEfsoMB0YJ5rwxmbAut32qHzeTQSjae+pEQEtIIpRLKWA1IPWKUQnujPtp69OVsF2S2NSXohIM
X-Gm-Message-State: AOJu0Yz4aT5MoLu2tZPX8WKUfw36PjJspTGFbmYh7P1LhLHXkQgfAURa
	SeY0HWC8AOobcLrj7TZ+cE6wvAt9Cu+l5odKexrjqgX4KUJkw1+MC97AdtlDICA=
X-Google-Smtp-Source: AGHT+IFEPu0i5ueU8PBJF1LFQN690pXMf0YIKw4rNgvmabF16RNW5n71cyetXv/nDePGBSZtm2u4qg==
X-Received: by 2002:a05:6402:50c9:b0:572:6aaf:e0d0 with SMTP id h9-20020a05640250c900b005726aafe0d0mr7836085edb.40.1714470588818;
        Tue, 30 Apr 2024 02:49:48 -0700 (PDT)
Received: from puffmais.c.googlers.com (8.239.204.35.bc.googleusercontent.com. [35.204.239.8])
        by smtp.gmail.com with ESMTPSA id dk21-20020a170907941500b00a55aee4bf74sm10981024ejc.79.2024.04.30.02.49.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 02:49:48 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Tue, 30 Apr 2024 10:49:48 +0100
Subject: [PATCH v2 3/4] arm64: dts: exynos: gs101: specify bus clock for
 pinctrl_hsi2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240430-samsung-pinctrl-busclock-dts-v2-3-14fc988139dd@linaro.org>
References: <20240430-samsung-pinctrl-busclock-dts-v2-0-14fc988139dd@linaro.org>
In-Reply-To: <20240430-samsung-pinctrl-busclock-dts-v2-0-14fc988139dd@linaro.org>
To: Peter Griffin <peter.griffin@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, kernel-team@android.com, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.12.4

This bus clock is needed for pinctrl register access to work. Add it.

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 arch/arm64/boot/dts/exynos/google/gs101.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/exynos/google/gs101.dtsi b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
index 8d4216cbab2e..f8fcbbb06e7b 100644
--- a/arch/arm64/boot/dts/exynos/google/gs101.dtsi
+++ b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
@@ -1327,6 +1327,8 @@ cmu_hsi2: clock-controller@14400000 {
 		pinctrl_hsi2: pinctrl@14440000 {
 			compatible = "google,gs101-pinctrl";
 			reg = <0x14440000 0x00001000>;
+			clocks = <&cmu_hsi2 CLK_GOUT_HSI2_GPIO_HSI2_PCLK>;
+			clock-names = "pclk";
 			interrupts = <GIC_SPI 503 IRQ_TYPE_LEVEL_HIGH 0>;
 		};
 

-- 
2.44.0.769.g3c40516874-goog


