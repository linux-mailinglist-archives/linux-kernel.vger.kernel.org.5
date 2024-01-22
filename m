Return-Path: <linux-kernel+bounces-34272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3DD28376E1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 23:59:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64A7A1F258B0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 22:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35C324BAA4;
	Mon, 22 Jan 2024 22:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PqEfn9aQ"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAEF54B5A1
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 22:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705964262; cv=none; b=NexdY+mKBFR3RNHfe+jVhnLUIEkRluUkBUYcfRyeDRxMw9HTIcBtpcDVAMvQEw5f/gEC7ABS+88iHXwJWabcf57IcWFEI1I/3VMqX6icyjwG2WYXOaU4jdjw5aEK3SPbkx0T6XN1fJmEGgdrm3fK3xLStQgtJiM2nlYGMHUgyzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705964262; c=relaxed/simple;
	bh=t8ZhB9Hu7K4Ql69piBPtPrEhaMrRJa2GJ7YXvafwt4A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oCpr3F+JtrtsSvbGQx82UfuRICNnip2PMjACexfbZQYrPEQtMGsEFoEc3BJ20FD9/2OPWRtevpqU8cWlYCzn6d+aMWnG3TPznEIkBFsPNJfHA5x4MsugpZN1E3GIPGuHraP15j4xNRoDaf8La20vsVTbo5I/swa2MNdpgShwO1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PqEfn9aQ; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40eacb4bfa0so16649425e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 14:57:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705964258; x=1706569058; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9+yXcHZUiMblwUqkt8towiLq/bcfaAns/f7tUicypCM=;
        b=PqEfn9aQMDjMpVjxcwU3m06SInZctx95KFmBTKBsntncoscyHDc2lliCVayNpxOYQQ
         SnUEnO6h/F9bl26o4vmJUAbbewhFPTnJ5YybFJYUC83L0RUIswVo3MBNhhYt/fWyPlL+
         HcyAhfzlNdTng9JeUiraWKSWJ1tbi//VRhnXxGc773QVcIxczQKJuHQfD/BgjGgnKMcn
         uVAYpVymfpBIRn5Kj6bbwowYemvkNzgaiRuzl0X/iJGbjrBN3ls8xOXcmIk60hgX/Eyq
         vB1sp/akhwPkY5bKsuA8zxAyxlqgLRbRFPIpHA6duuUl1Yw0vr24hJA86lbWCcxX90Wo
         lrKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705964258; x=1706569058;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9+yXcHZUiMblwUqkt8towiLq/bcfaAns/f7tUicypCM=;
        b=JZyoC+THBq67C0x1s6bBOupKdXg8eFtSiYDs+EdrAkB+RWKhY4KupOy+y4e3FlHwnb
         wBZMcOVx9+GFta3zjyKxGE+lEpYm0D3hWcOOjBKLMX9/Rb2QbMgpnNO/X40xIwNpJqFi
         X/4Y1RUAsYBnnVCWbtMiIrBhW13/4fXNdTk0hYMgyR6DzbnNTmVj4mfGfUNVBGiug+xw
         T9GHnkl8NX0TIIX+zNE3fZLCPYI72DVhUPvGG8en8HhKRd4qRXNZvaia0We4gz+ywRUI
         t6rLRC2KEXZ9Vsd6bSes0mD12sp+IrVzH7uBXq6L6QAIvFeHKPE1K3SWtn7yEjn1ghot
         yphA==
X-Gm-Message-State: AOJu0YwmYu8EoP+vddtQZEeesxurJI7itneBWQ1PQQFVptsn6iOQ5Utf
	ZpEyZ8bq7t/NVZp0pk8gBs6Ca/7uBIrTZwHeQadsxsAlazxQqHNrOt/DLy3mlfI=
X-Google-Smtp-Source: AGHT+IGTxTra3oeT53FfIH97Y2Gx41002Oxx5G+brDmtK77zTRluoeyF5o89lKBl/s6gRCsv7yvONw==
X-Received: by 2002:a05:600c:1ca6:b0:40e:b0a1:b96e with SMTP id k38-20020a05600c1ca600b0040eb0a1b96emr676113wms.69.1705964258092;
        Mon, 22 Jan 2024 14:57:38 -0800 (PST)
Received: from gpeter-l.lan (host-92-18-76-30.as13285.net. [92.18.76.30])
        by smtp.gmail.com with ESMTPSA id fa26-20020a05600c519a00b0040e89ff10f5sm19776847wmb.1.2024.01.22.14.57.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 14:57:37 -0800 (PST)
From: Peter Griffin <peter.griffin@linaro.org>
To: arnd@arndb.de,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	linux@roeck-us.net,
	wim@linux-watchdog.org,
	conor+dt@kernel.org,
	alim.akhtar@samsung.com,
	jaewon02.kim@samsung.com,
	chanho61.park@samsung.com,
	semen.protsenko@linaro.org
Cc: kernel-team@android.com,
	peter.griffin@linaro.org,
	tudor.ambarus@linaro.org,
	andre.draszik@linaro.org,
	saravanak@google.com,
	willmcvicker@google.com,
	linux-fsd@tesla.com,
	linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org
Subject: [PATCH 8/9] ARM: dts: samsung: exynos4: remove deprecated samsung,syscon-phandle
Date: Mon, 22 Jan 2024 22:57:09 +0000
Message-ID: <20240122225710.1952066-9-peter.griffin@linaro.org>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
In-Reply-To: <20240122225710.1952066-1-peter.griffin@linaro.org>
References: <20240122225710.1952066-1-peter.griffin@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

samsung,syscon-phandle is no longer used by the Samsung watchdog driver
to access PMU registers.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
 arch/arm/boot/dts/samsung/exynos4x12.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/samsung/exynos4x12.dtsi b/arch/arm/boot/dts/samsung/exynos4x12.dtsi
index b4b5e769145b..0fea32616c89 100644
--- a/arch/arm/boot/dts/samsung/exynos4x12.dtsi
+++ b/arch/arm/boot/dts/samsung/exynos4x12.dtsi
@@ -311,7 +311,6 @@ watchdog: watchdog@10060000 {
 			interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clock CLK_WDT>;
 			clock-names = "watchdog";
-			samsung,syscon-phandle = <&pmu_system_controller>;
 		};
 
 		adc: adc@126c0000 {
-- 
2.43.0.429.g432eaa2c6b-goog


