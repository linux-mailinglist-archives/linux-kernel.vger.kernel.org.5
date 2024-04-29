Return-Path: <linux-kernel+bounces-162994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 880BD8B631C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 22:04:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40B73284365
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 20:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BB941411F1;
	Mon, 29 Apr 2024 20:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lejVN1pm"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4405E13F006
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 20:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714421085; cv=none; b=LFwtNaV00RAkUIWE7MEQjwdbc7v/t2JWdK/Kr6rgwgIxUCrEpE4whWWz9iAQFsFh6PXsCSMYmdVKruYwzXf1Slgpm2ygEtdONkGTzWoEnVrugtcKAqe+rILmkVXuXlHEwH7oWiyKLRIfMmniAiJ1gqHr+jgqiVDR+KIDFcbaGWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714421085; c=relaxed/simple;
	bh=OHbOYwGssa/uRbe/4TDCDGAgML0a+7L1EyAmdQh+g64=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KNzX4+YjnUl9PtvZKMMvFoWKpa+HwpxA6Oor+dPIxtnR+D+oRB8yM1145dRXY1qy1WwYvJI+yIRUoM9gb0b1gJnLF7G9na+YfLO8G0PAlJSixdqp+MswpkxSpjcLorO8LQhIuWQ7hle6eI+gbryzrRg/OEChkPu6zGf6noKnE9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lejVN1pm; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-56e56ee8d5cso6189379a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 13:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714421081; x=1715025881; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RQWtsOUn4uiQZnL3yK4nvk33ev/xiP7OrIVV8S/1ztQ=;
        b=lejVN1pmdCs9djr/uPulAKWG4nL/LH83NUNGxvkQ1YmnxE1eq3ZoI1rGUekKB/zhM+
         he+2gS9YymFw6vCs2g0lH68sdJYSmg7aT3k16yDQ+CNj6OjXB5zlO+PXT85+Y3zMKFtm
         pYbetVbUvJuOpD5t+9pxz/JKQVxAyuFNImxl6yQrTwt0FcNUJQj5SvSHrhi96dIDtr+m
         fLptuB8kPidw+7egxjQL0ry4ymlyjVDOD+JYxfixW0MedSUJ7JHQHdvx7+TRA03/4dQ4
         oTDYWgF42B7ZtdN2OZd9vQDPLYAv7i7iz+oyP84uAzIqvfBH/jIS9fPBZogdBoRA5bQp
         XF9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714421082; x=1715025882;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RQWtsOUn4uiQZnL3yK4nvk33ev/xiP7OrIVV8S/1ztQ=;
        b=prTSgwMqb0xLJ2kHAdzgUSY1KHHLwqjSYDTbnlA827XQXQDhSrM7y4ByesQk87olMW
         Bzrg94jP7HGVfZasIPUskQi0C0+IApPmcb7fAtL4EQpC8t2a0hAmXRxJOpX9xs4zUWXT
         yDQE5CnIPXZBJ0tIYDPgbld6XjL+EnMgILFxI1jomREhjQuNX7vUJ+NV5z30gyKlByZa
         bS97GuVFvIpxrmOD9wqvqzEdl8tvxY4hhGZ5Xl//dHwXPY1zGcKJHnkAbmio7HQ4LWEi
         vfotcOdo9wT4dyoOkQSnrSRTtF1L1ybgudjgG39Qc5fWon1MI/Q5kDj0vES06Ix+eEWw
         1b8A==
X-Forwarded-Encrypted: i=1; AJvYcCVsxvTRP4H1bgCe98g0K/FNWa4PPws6ap+e/ynYRfxe00s8l7GK9NFfp8EL5yAdH9SoMQVm/K+5ZRTc/kNpNl2YEM5BG0iLKaiiuISM
X-Gm-Message-State: AOJu0Yw5hM86Ttf1CoNJeovVkFh6MdnEbZfpDtTuvxMs47nGRgP4Q7ub
	YufgXDhB5FTvNvuRDU2SWvTauGmMbdRwGpUDYr+sDRCoRqQRD+wwkJ0zfwL8jRU=
X-Google-Smtp-Source: AGHT+IFsmQSYOFVjcKWYh/rZ5pUC4+f3wl6DJmPFZQR9y7Tr1ohZh/1ga/miQdBObNWVEFyvQNtsdg==
X-Received: by 2002:a17:906:eb14:b0:a55:63d8:8ab with SMTP id mb20-20020a170906eb1400b00a5563d808abmr7892433ejb.11.1714421081688;
        Mon, 29 Apr 2024 13:04:41 -0700 (PDT)
Received: from puffmais.c.googlers.com (8.239.204.35.bc.googleusercontent.com. [35.204.239.8])
        by smtp.gmail.com with ESMTPSA id ld4-20020a170906f94400b00a5906d14c31sm1140887ejb.64.2024.04.29.13.04.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 13:04:41 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Mon, 29 Apr 2024 21:04:38 +0100
Subject: [PATCH 1/4] arm64: dts: exynos: gs101: specify bus clock for
 pinctrl (far) alive
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240429-samsung-pinctrl-busclock-dts-v1-1-5e935179f3ca@linaro.org>
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
 arch/arm64/boot/dts/exynos/google/gs101.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/exynos/google/gs101.dtsi b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
index e3b068c1a2c1..f2c7c2a4ce1c 100644
--- a/arch/arm64/boot/dts/exynos/google/gs101.dtsi
+++ b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
@@ -1348,6 +1348,8 @@ pmu_system_controller: system-controller@17460000 {
 		pinctrl_gpio_alive: pinctrl@174d0000 {
 			compatible = "google,gs101-pinctrl";
 			reg = <0x174d0000 0x00001000>;
+			clocks = <&cmu_apm CLK_GOUT_APM_APBIF_GPIO_ALIVE_PCLK>;
+			clock-names = "pclk";
 
 			wakeup-interrupt-controller {
 				compatible = "google,gs101-wakeup-eint",
@@ -1359,6 +1361,8 @@ wakeup-interrupt-controller {
 		pinctrl_far_alive: pinctrl@174e0000 {
 			compatible = "google,gs101-pinctrl";
 			reg = <0x174e0000 0x00001000>;
+			clocks = <&cmu_apm CLK_GOUT_APM_APBIF_GPIO_FAR_ALIVE_PCLK>;
+			clock-names = "pclk";
 
 			wakeup-interrupt-controller {
 				compatible = "google,gs101-wakeup-eint",

-- 
2.44.0.769.g3c40516874-goog


