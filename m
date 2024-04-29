Return-Path: <linux-kernel+bounces-162997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 019058B6323
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 22:05:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32C631C21D55
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 20:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10F521428F6;
	Mon, 29 Apr 2024 20:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CpdCVPYE"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A236014039D
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 20:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714421086; cv=none; b=i4y2IZ7Pjn85uHClj1TYPb6irRZKFg+v7SIQxIgLqg2pJw1UibkE6wBlOyWqZrEzDMcFaugpy4r9VKTyiT/rzf1ngow+vaZ1S/ToGhws5Z/a8+840tdsRBWXRIqYlJMJ31ZVBN6optYN2X2S7a42cmCeasDn/1mUXMkYrEdU080=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714421086; c=relaxed/simple;
	bh=6EPfWTqm/lFaZs1kyJ73zKT+bkJLAEfvahvw8Cv8KkU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rKUydqPIJVIKSWygbYx6+j6GiiNaZ5LzC8EgdfpKetkDapzz+V638O6CiJFAiVCMwbiAAeaTWEosu8aIh17RPpglOXxGgTqVBT/eRrSueh+tSmtMsS9NAHITcTuYg2tptHBzk0U5AuFbVCGdHnz2VoffxTfV6uq/65GjX1+2i1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CpdCVPYE; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5176f217b7bso8533157e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 13:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714421083; x=1715025883; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F8gW4wGr4HSLlzWyo25Ekg/cBo+LkQV9cqhppDRnOws=;
        b=CpdCVPYE/frxUrSfNZ3TZH94Snlxm9d500/Tw9mo7gLI4Oi3nCIPy32F1A0Mb7rdmO
         zLAhGIzjkKHXJ2bWMHe0z/WFIcf6xGuSoPOSMcLJ9uQvHBdXlXMT6CwBiBpIHsFhyB0c
         Pj6N0QMIwhbsx4Rg1pHJml34k6pZ7lEtbyxqR73D21qoNs05JUENpWB7W4ZPAoji1KHH
         R2DPCQdzwg+61Fsgqq2nC7Xp7w4ADgctAiNYEq8azZQUYIpJEg7D4uvhzDfZBF9t5Hwc
         6eFzZs8u1wcaNcWqbnyIpK2Yh14z+N7aNC5db+2EJRw0qW518WA5NE2B6bLzQVA2BM8D
         w25w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714421083; x=1715025883;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F8gW4wGr4HSLlzWyo25Ekg/cBo+LkQV9cqhppDRnOws=;
        b=odmmB5lA/HxIyE92EORz6cUFTJ0AzK2BXi/XtWS5crj6t/qtaugZ3fXhyQQpeTkARR
         bnzZ25nkDQquScyX71fydQTTiZw6Cr1OMO/uDiu8j53GyclcAvp53FG8mTh8Kqu/9tQj
         Xt6IydVcO+hkJ8eeSoVJW6/zNZpTaIO2628C9BrxBEmcXIqrsoI+2WVgimC/oK6R/FBt
         Coaarn0N4N31PGXZLHmXmkrKhjf9su79mMsuBWwi8FEpVg8qTRrySLdJDnsY2eJgHtWu
         r72vh83OKDuwpvFwFSMnW2K/DuKPowXzwt9eSR+fY/NhiTD0GmSpJ3caP8krtRySzLBK
         k6oQ==
X-Forwarded-Encrypted: i=1; AJvYcCVbYLnNmsRocZe1E+/+ZmUWdkAkU8dFR+DqZbhvpHRE4TGthatPkusIz3yQ+uzywC2lkoFIEl3yf3ve9OLe739QbiJ4DPvfq/qmjtzO
X-Gm-Message-State: AOJu0YxddGtmC1GNT7AJYRwOayXNjlHQlAiJlZY6R2dtWv1k4zsA0/8k
	BRJAgYeg6O6fM7pcW8aE6qYBKcSpg7XOCWDe7FrWDb6X1vM/pT4DYPZCdNJysi8=
X-Google-Smtp-Source: AGHT+IHGis5wF8t1ESX8RAjQs/EY1YGbXFP/Qh8xO6fNNNxeWUWMjywlketexpvy9RfUj+AypoUtcQ==
X-Received: by 2002:a05:6512:20ce:b0:51c:71cf:efc9 with SMTP id u14-20020a05651220ce00b0051c71cfefc9mr8666331lfr.49.1714421082734;
        Mon, 29 Apr 2024 13:04:42 -0700 (PDT)
Received: from puffmais.c.googlers.com (8.239.204.35.bc.googleusercontent.com. [35.204.239.8])
        by smtp.gmail.com with ESMTPSA id ld4-20020a170906f94400b00a5906d14c31sm1140887ejb.64.2024.04.29.13.04.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 13:04:42 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Mon, 29 Apr 2024 21:04:40 +0100
Subject: [PATCH 3/4] arm64: dts: exynos: gs101: specify bus clock for
 pinctrl_hsi2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240429-samsung-pinctrl-busclock-dts-v1-3-5e935179f3ca@linaro.org>
References: <20240429-samsung-pinctrl-busclock-dts-v1-0-5e935179f3ca@linaro.org>
In-Reply-To: <20240429-samsung-pinctrl-busclock-dts-v1-0-5e935179f3ca@linaro.org>
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


