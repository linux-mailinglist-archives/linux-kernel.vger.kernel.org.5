Return-Path: <linux-kernel+bounces-82845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7482E868A7B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 09:08:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8D201F23630
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 08:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 520EA5733D;
	Tue, 27 Feb 2024 08:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j4Pt4hfE"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD00C5675D
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 08:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709021292; cv=none; b=FlblgT8IP+s3oPARMXkYBjWaFdzFlseMV2JZJMLin+NONWdZwW5T4LVPOt+/WcCHEd9cXw3r+BocnquhZEFfScK02eqydgeUQEBCsF0irhDBQVyYeeGNSXqkpNPJQ20Mlk4ORtZWqBhkCdQsH3xGourYn4UNTkg0L3lT/q0tMyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709021292; c=relaxed/simple;
	bh=whJn6oRUulaQwJ9k8svjSJYyaK1DlOk/EVrP8cPTcEs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oy4CsYncv9VyETHZdy+I38ADAlVv49zQzLvGCxSQNj/Nl1nVvHRrKKczyyhleMSzYkukT+PSI3gdw3ASgyTFY1M6N21lxPOMivZuZt9nD/ZHnK1ImVDVfB6ZyINH6HOpMstTBm0TXjwuy1NeIv0vFGVDsNkP0uxbvRzLid52ojo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=j4Pt4hfE; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-564fc495d83so4539474a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 00:08:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709021289; x=1709626089; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iiVrva5DwInjSui+Br+HHATpx+xvm6PVi1TQNYfveV8=;
        b=j4Pt4hfEmEZyvRdEZWV4F2+aTOi9CrKhoSmM3KJ6+z7bkljwfLsIq9/ELeKJ67A9Kj
         LzMsZcUtNKs2pRrWOkYa81ww4DD4a81AfkOj5lg9LaGijvDj+elKr9ydFT2q2ClpUZ08
         xtUeqOY4fFXWhC7u/8upPw4AzRzpod6cUpKRmYfeyAsJzyYBpGqZFgTUthAm0LZnzLIj
         5pTlq3VDRUU/ygncc4PTuaTcR4nYjtB1jt+hnfZUZCGZKXQzJYS9kMSW9KaxcBFHwxJw
         IZxdM87sL9M5gPCV+kVUaFpGG9zOzWf0LyfJrTATP+L4SBgQUXffSIAFBrz6g/N9lOAZ
         nCLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709021289; x=1709626089;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iiVrva5DwInjSui+Br+HHATpx+xvm6PVi1TQNYfveV8=;
        b=RcCMbXG0+pSRwnlAmhu+Mk57fMskVj/RpakOlQ99ZEy8SH4V5iy8QQxaeoKWwAqmSk
         hEHJDgKSuXNtjlh66Ec0gvp4fsusEnHPeXkaztluFSsUoaSFu3ulM3C5eqERooDHNjdZ
         wt8Urtwv6PMtLgB1sTy8CBNHiGvCIjvUMJv1cP1sJec9w2wD+UGHSNciqcbswXq+CyB3
         PMWR0opgmHEQJQ/dFN2EOGcxima8phgipWgjPDHfwfb05EujcHBfscf3uvknscNaC68T
         Lng0DNZsTYsGoq4cnjSi+0E95cuZtjZ6NygW7u67fyWO1oC0Ajy1umILJpa1YMyXL9RB
         81ew==
X-Forwarded-Encrypted: i=1; AJvYcCXlO6OPp6OyqaO8xyuIydN1c9AXJilB9LqIcMh4gN3E/pWzlT781j8/2q1OlKc/yvQyjGrlDI1pIdfo8cyjhIPn+p6z5on0XnYLT/hM
X-Gm-Message-State: AOJu0Yyqq1PYdcq8JsaBW+eefkrn9/xxa/CrcmVRG3uX48RZmiYAZTzm
	a5ePByO+OjRAv9/s72DLu3VjJjozXFyv1GprlowK3UhmqcInBe45t7KSXM1kcoRcaCg7Y0yN2c0
	P
X-Google-Smtp-Source: AGHT+IEWM6Nm8SPJY4tlU/DHnXZcjC6HFHDjix8q780UPHj1OCYUYpjhUE82VyM26QICREgDnkRfTQ==
X-Received: by 2002:aa7:d349:0:b0:565:c34f:df4e with SMTP id m9-20020aa7d349000000b00565c34fdf4emr4938085edr.29.1709021289206;
        Tue, 27 Feb 2024 00:08:09 -0800 (PST)
Received: from krzk-bin.. ([178.197.222.116])
        by smtp.gmail.com with ESMTPSA id b22-20020aa7dc16000000b00564d7d23919sm509662edu.67.2024.02.27.00.08.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 00:08:08 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Olof Johansson <olof@lixom.net>,
	Arnd Bergmann <arnd@arndb.de>,
	arm@kernel.org,
	soc@kernel.org
Cc: Artur Weber <aweber.kernel@gmail.com>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Peter Griffin <peter.griffin@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Henrik Grimler <henrik@grimler.se>
Subject: [PATCH PULL v6.9 3/3] ARM: dts: samsung: exynos4412: decrease memory to account for unusable region
Date: Tue, 27 Feb 2024 09:07:55 +0100
Message-Id: <20240227080755.34170-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240227080755.34170-1-krzysztof.kozlowski@linaro.org>
References: <20240227080755.34170-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Artur Weber <aweber.kernel@gmail.com>

The last 4 MiB of RAM on those devices is likely used by trustzone
firmware, and is unusable under Linux. Change the device tree memory
node accordingly.

The proprietary bootloader (S-BOOT) passes these memory ranges through
ATAG_MEM; this change allows us to have the correct memory ranges
without relying on ATAG_MEM.

Tested-by: Henrik Grimler <henrik@grimler.se> # i9300, i9305
Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
Link: https://lore.kernel.org/r/20240217-exynos4-memsize-fix-v1-1-7858e9c5f844@gmail.com
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/samsung/exynos4412-i9300.dts   | 2 +-
 arch/arm/boot/dts/samsung/exynos4412-i9305.dts   | 2 +-
 arch/arm/boot/dts/samsung/exynos4412-n710x.dts   | 2 +-
 arch/arm/boot/dts/samsung/exynos4412-p4note.dtsi | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/samsung/exynos4412-i9300.dts b/arch/arm/boot/dts/samsung/exynos4412-i9300.dts
index 61aca5798f38..b79d456e976d 100644
--- a/arch/arm/boot/dts/samsung/exynos4412-i9300.dts
+++ b/arch/arm/boot/dts/samsung/exynos4412-i9300.dts
@@ -18,7 +18,7 @@ / {
 
 	memory@40000000 {
 		device_type = "memory";
-		reg = <0x40000000 0x40000000>;
+		reg = <0x40000000 0x3fc00000>;
 	};
 };
 
diff --git a/arch/arm/boot/dts/samsung/exynos4412-i9305.dts b/arch/arm/boot/dts/samsung/exynos4412-i9305.dts
index 77083f1a8273..1048ef5d9bc3 100644
--- a/arch/arm/boot/dts/samsung/exynos4412-i9305.dts
+++ b/arch/arm/boot/dts/samsung/exynos4412-i9305.dts
@@ -11,7 +11,7 @@ / {
 
 	memory@40000000 {
 		device_type = "memory";
-		reg = <0x40000000 0x80000000>;
+		reg = <0x40000000 0x7fc00000>;
 	};
 };
 
diff --git a/arch/arm/boot/dts/samsung/exynos4412-n710x.dts b/arch/arm/boot/dts/samsung/exynos4412-n710x.dts
index 0a151437fc73..eee1000dea92 100644
--- a/arch/arm/boot/dts/samsung/exynos4412-n710x.dts
+++ b/arch/arm/boot/dts/samsung/exynos4412-n710x.dts
@@ -9,7 +9,7 @@ / {
 
 	memory@40000000 {
 		device_type = "memory";
-		reg = <0x40000000 0x80000000>;
+		reg = <0x40000000 0x7fc00000>;
 	};
 
 	/* bootargs are passed in by bootloader */
diff --git a/arch/arm/boot/dts/samsung/exynos4412-p4note.dtsi b/arch/arm/boot/dts/samsung/exynos4412-p4note.dtsi
index 39a3d1cbe4c3..28a605802733 100644
--- a/arch/arm/boot/dts/samsung/exynos4412-p4note.dtsi
+++ b/arch/arm/boot/dts/samsung/exynos4412-p4note.dtsi
@@ -23,7 +23,7 @@ / {
 
 	memory@40000000 {
 		device_type = "memory";
-		reg = <0x40000000 0x80000000>;
+		reg = <0x40000000 0x7fc00000>;
 	};
 
 	aliases {
-- 
2.34.1


