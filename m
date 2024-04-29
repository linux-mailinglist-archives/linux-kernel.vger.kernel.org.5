Return-Path: <linux-kernel+bounces-162998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3B628B6324
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 22:05:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10D201C2032D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 20:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55354143860;
	Mon, 29 Apr 2024 20:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fLjdDryL"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35021411D3
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 20:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714421086; cv=none; b=oKniUH+BPqped5EbiIa6HkCf33XC0AYzXHCYKxq7l3bjXInvPl8jAVph9rErgj3phjc0p2zgNv6xM0Mjzme7unZnE8oqf9AUZZ8aoh/xV4F0tKypW5nwIdhPcJYwPilM6jkamnaWQEFIIvMGLJeVcYsqOWgEfd4i3QJOZxB6egM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714421086; c=relaxed/simple;
	bh=7Fu6Jlbw13SdHa0XnGxn0I2O9i5djBz4seEVD8va7pU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EBCrnhJBrNBzyS8vjD9oo1Mlh3sIQiuZIbuAprHhFyducnyrxbN1yySVz8YHsOSLDJKgfa7XkQTT22RP40TZKOsniHjORYYDBHLKsoL9iHzhY+OMy+6+k4L6fGFUNP+hU0NemTh4LDR961J3EwVFwOMuUh52fURUDewt5JsJdVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fLjdDryL; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a559b919303so643358066b.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 13:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714421083; x=1715025883; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kTIyqFBJPzda0VZW9GqKLhD9vkmHPScIkEvgRsFUKyQ=;
        b=fLjdDryLJC5BSNtMI+aETY+xlgYaPErhHhIyVx0C2no4cyXMw1gKTvdaltuj2YxrhX
         WJtAbo6H4S4+p1MDJIa56SHDOxDl9LOFWuK4dHAo4Y2d9F10f87mvo0jPIWTn4OJQgPq
         Bq4VomiBAEOa1Pt4fGclFUb6IkeOdEXrMTTVXPrxretdAyv+f+QPD7m1kYR6jf6PiHpq
         rjIcs17bR50Jb4jDKQtsKzJ6fH7NgVC7Z9ye0ym1cUZUFjy0gzAjdYQPs6KuNH8DRJvG
         HGBt/XJpT0UKMk1zfg+23Zx39/pV1xeX3Ey3appTBi90fIQcslgeh9gA66W0GOQpD2d+
         zvog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714421083; x=1715025883;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kTIyqFBJPzda0VZW9GqKLhD9vkmHPScIkEvgRsFUKyQ=;
        b=gCbVCDXB4hvK/dJMCUsJkfMMx1+pWqD9QBTF1FKf/R+4yeh3XNg+uvnbavK69Dd4Gw
         xfIieXQxAduHENAeyIo/ZHpY4cHExxjRVwVyIqyHdJOpFpJQoBqyxFGvaf+zBe0Em109
         nMonG1nDKggVSV6KktcQ9qK76aSrOmlR83WYnW/YJz4DtW7yxUC/aNdEoZcFuqv/6i5g
         LPHo6YT2C8E6zAevAm+2aC/lUBI9p7Ag3myi4AXvx01cnI9JobFU+3MveuQxniwZ9AFm
         5Veqq9c0Jo3GKduRbOEeKEAfLPNUpkxpty85IUlE5GDsvzlHhOMcZKfbNPIoHjz9iufb
         YhmA==
X-Forwarded-Encrypted: i=1; AJvYcCWaFgsDZsBscQSJPKMSOkaV/OZ+IeUXbOlu3F7iePQP+hv7D02GnR6abwEXiHBG/o6WMClJp2lFmX2xoD+8LNRuYg2BAvF1m0WLXKvK
X-Gm-Message-State: AOJu0YwYb6k+1Qdw1dmBYcYku2/2JWjnsvj7MBJO6/7S58vEvPf2N0Dg
	mn10iNIBoyZQdl02P0petQMQjeuXZKJVFRnigaEg0HtUFRXP4jExdmQHpfJSAmM=
X-Google-Smtp-Source: AGHT+IFrVmD0xJ3K/FTc8IS9J3OWcv2cL/oVB/L45gv/sPVgmJu3g8vcefS7dlTqaz4W8wKmofNoqQ==
X-Received: by 2002:a17:906:5811:b0:a55:b12c:6589 with SMTP id m17-20020a170906581100b00a55b12c6589mr7274277ejq.36.1714421083177;
        Mon, 29 Apr 2024 13:04:43 -0700 (PDT)
Received: from puffmais.c.googlers.com (8.239.204.35.bc.googleusercontent.com. [35.204.239.8])
        by smtp.gmail.com with ESMTPSA id ld4-20020a170906f94400b00a5906d14c31sm1140887ejb.64.2024.04.29.13.04.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 13:04:42 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Mon, 29 Apr 2024 21:04:41 +0100
Subject: [PATCH 4/4] arm64: dts: exynos: gs101: specify placeholder clocks
 for remaining pinctrl
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240429-samsung-pinctrl-busclock-dts-v1-4-5e935179f3ca@linaro.org>
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

The pinctrl instances hsi1, gsactrl, and gsacore need a clock for
register access to work.

Since we haven't implemented the relevant CMUs for the clocks required
by these instances just add placeholder clocks for now so as to make the
DT pass the validation checks.
Once the clocks are implmented in the gs101 clock driver, these should
be updated then.

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 arch/arm64/boot/dts/exynos/google/gs101.dtsi | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm64/boot/dts/exynos/google/gs101.dtsi b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
index f8fcbbb06e7b..6db2c9bbb371 100644
--- a/arch/arm64/boot/dts/exynos/google/gs101.dtsi
+++ b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
@@ -180,6 +180,14 @@ HERA_CPU_SLEEP: cpu-hera-sleep {
 		};
 	};
 
+	/* TODO: Remove this once all pinctrl clocks are implemented  */
+	clk_placeholder: clock-placeholder {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <0>;
+		clock-output-names = "placeholder_clk";
+	};
+
 	/* ect node is required to be present by bootloader */
 	ect {
 	};
@@ -1309,6 +1317,9 @@ usbdrd31_dwc3: usb@0 {
 		pinctrl_hsi1: pinctrl@11840000 {
 			compatible = "google,gs101-pinctrl";
 			reg = <0x11840000 0x00001000>;
+			/* TODO: update once support for this CMU exists */
+			clocks = <&clk_placeholder>;
+			clock-names = "pclk";
 			interrupts = <GIC_SPI 471 IRQ_TYPE_LEVEL_HIGH 0>;
 		};
 
@@ -1380,11 +1391,17 @@ wakeup-interrupt-controller {
 		pinctrl_gsactrl: pinctrl@17940000 {
 			compatible = "google,gs101-pinctrl";
 			reg = <0x17940000 0x00001000>;
+			/* TODO: update once support for this CMU exists */
+			clocks = <&clk_placeholder>;
+			clock-names = "pclk";
 		};
 
 		pinctrl_gsacore: pinctrl@17a80000 {
 			compatible = "google,gs101-pinctrl";
 			reg = <0x17a80000 0x00001000>;
+			/* TODO: update once support for this CMU exists */
+			clocks = <&clk_placeholder>;
+			clock-names = "pclk";
 		};
 
 		cmu_top: clock-controller@1e080000 {

-- 
2.44.0.769.g3c40516874-goog


