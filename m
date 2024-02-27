Return-Path: <linux-kernel+bounces-82843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97B80868A77
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 09:08:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51A94281D96
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 08:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5201D56744;
	Tue, 27 Feb 2024 08:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sCO2m5yo"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09C556473
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 08:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709021289; cv=none; b=Y/up12OI2kpNL7b6/qnBYsNS6bVeNGmlcRKlUlCeJnUdy+oEPsS0kPOAnLGd27SSVRabfh9ZhziiQWWED7czsucj4+EdjbvyGFZhjZgErFVMy6XGcuQEVeqhJwWyo+U99L7V6FmNz5h1uYclpJer1hqxO/fOCtMGVevdqInjpyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709021289; c=relaxed/simple;
	bh=bSOt1LeX5Smqfy3y9LXkqvCS+4z2Xje+3YML8Y4vZzI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RceipEFZn0rHbQS0HtslOJTx6sBzxK/n8YhBy4oGmH2qfwFWfbGzyre1ohTbRcriLP1kqWk3wxXFlPa7ab53LhDR6kQL3G7yp0eewuh+oXCND4IcqQ7VN/eA50rezsiZ5aYYLaJX0e5QLFxYrUNWKxqpGgGDTX7acpyIrSsU6h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sCO2m5yo; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-563f675be29so4139118a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 00:08:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709021286; x=1709626086; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=trQx0OfRMQbxsApd/n3MseZdPGhNtXwXAK07FPTCiBg=;
        b=sCO2m5yo6e95e/DstbYD5SS7iFM/qVpwyg40adRbK3Ip3MOyW3pKnR1RkbCAgn25cI
         KKPVH5JMPXdRe+nK1i5F8jDVbsucZ1hIj8ngSDlOed3DM3RHk4rj6zRGFs7HWLqedOE3
         R/nwAFQHxCP/qWC43YWomNjaVotYqg4e8VSGm1dsOi2e+cjHWk6xT8ltwoOLEzhiTSge
         ph0PPU0xvkc4y4MrsPjvp2y+Pcv9ybzbfiflzyWv5k/x7VX5szWMt6dOo025Xxpx2r3+
         NwrsB2oToXIuEAeDiM1bAymSSQYtmU7jn25HWB4ptDvTfODUXM9aUffveM3gQZswrRU/
         Kojw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709021286; x=1709626086;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=trQx0OfRMQbxsApd/n3MseZdPGhNtXwXAK07FPTCiBg=;
        b=YrZGSI+cwo3P4l8JlXcr+pxYqeFuUqZz+X95SY0F0Xh8cIuLFopPsW7qTXYoEB+Jwf
         ZwRngEBpYn+mceUPPXf1EwJ9bHRiXlVqFAnNP9QrI6v4m3AcJBZaMEjvcUH82bui1BkF
         keaR8cVR4f9Z5r4UpA1i7LhukwFVeCut1wXJAJdEhSB1rHRV/2J5Tem7KlvrsHrF5aU/
         AyiVSNHrDgY3jcpjEq6djFTR2WQPoTB7+3tFWsbphBlZx+OxagX1o6qH9GAbdvaz8kw0
         IiV2l9/eWnPbotN4kGVMZB7VWkg0DnADNEb3RgxuD7QcWpoPtHEiZedLjtjQXJKbNQ8g
         SYDw==
X-Forwarded-Encrypted: i=1; AJvYcCVbTqdcoRhHiOa3/ldFCQVAjKf5PwNSWRfqWhC6OZdY+aLcG7Dy9T9+RGSa2Cl13Qas9y03R059DAPsXPxQq0jqpxBAoOBKa31BQpdB
X-Gm-Message-State: AOJu0YwYRe8zqy0fvnBXpHmDYtgD58jk/yzv2HBhHubEdUcoyWq16qlq
	ezu5ltBleEtbEFuqIv1EJey4iQWOPU/cGPwTEu9n+/8kE4lYlfEcAopGwXvxVPI=
X-Google-Smtp-Source: AGHT+IEnn4ZoBLr6QN1qXuyx3mJBtk/c9WxXrNxt6iO7Yiw9JjvAPGEUB00W3B8S2Fmrpo7bhflTVg==
X-Received: by 2002:aa7:cd4c:0:b0:566:4895:c582 with SMTP id v12-20020aa7cd4c000000b005664895c582mr146303edw.15.1709021286457;
        Tue, 27 Feb 2024 00:08:06 -0800 (PST)
Received: from krzk-bin.. ([178.197.222.116])
        by smtp.gmail.com with ESMTPSA id b22-20020aa7dc16000000b00564d7d23919sm509662edu.67.2024.02.27.00.08.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 00:08:06 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Olof Johansson <olof@lixom.net>,
	Arnd Bergmann <arnd@arndb.de>,
	arm@kernel.org,
	soc@kernel.org
Cc: =?UTF-8?q?Martin=20J=C3=BCcker?= <martin.juecker@gmail.com>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Peter Griffin <peter.griffin@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH PULL v6.9 2/3] ARM: defconfig: enable STMicroelectronics accelerometer and gyro for Exynos
Date: Tue, 27 Feb 2024 09:07:54 +0100
Message-Id: <20240227080755.34170-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240227080755.34170-1-krzysztof.kozlowski@linaro.org>
References: <20240227080755.34170-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Martin Jücker <martin.juecker@gmail.com>

Enable STMicroelectronics accelerometer and gyro drivers for the Samsung
P4note device family in exynos and multi_v7 defconfigs.

Signed-off-by: Martin Jücker <martin.juecker@gmail.com>
Link: https://lore.kernel.org/r/20231221230258.56272-2-martin.juecker@gmail.com
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/configs/exynos_defconfig   | 3 +++
 arch/arm/configs/multi_v7_defconfig | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_defconfig
index c98d5ff8a1ed..7ad48fdda1da 100644
--- a/arch/arm/configs/exynos_defconfig
+++ b/arch/arm/configs/exynos_defconfig
@@ -318,8 +318,11 @@ CONFIG_EXTCON_MAX77693=y
 CONFIG_EXTCON_MAX8997=y
 CONFIG_EXYNOS5422_DMC=y
 CONFIG_IIO=y
+CONFIG_IIO_ST_ACCEL_3AXIS=m
+# CONFIG_IIO_ST_ACCEL_SPI_3AXIS is not set
 CONFIG_EXYNOS_ADC=y
 CONFIG_STMPE_ADC=y
+CONFIG_IIO_ST_GYRO_3AXIS=m
 CONFIG_CM36651=y
 CONFIG_AK8975=y
 CONFIG_SENSORS_ISL29018=y
diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index ecb3e286107a..0d885cb61206 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -1150,6 +1150,8 @@ CONFIG_STM32_FMC2_EBI=y
 CONFIG_EXYNOS5422_DMC=m
 CONFIG_IIO=y
 CONFIG_IIO_SW_TRIGGER=y
+CONFIG_IIO_ST_ACCEL_3AXIS=m
+# CONFIG_IIO_ST_ACCEL_SPI_3AXIS is not set
 CONFIG_ASPEED_ADC=m
 CONFIG_AT91_ADC=m
 CONFIG_AT91_SAMA5D2_ADC=m
@@ -1169,6 +1171,7 @@ CONFIG_IIO_CROS_EC_SENSORS_CORE=m
 CONFIG_IIO_CROS_EC_SENSORS=m
 CONFIG_STM32_DAC=m
 CONFIG_MPU3050_I2C=y
+CONFIG_IIO_ST_GYRO_3AXIS=m
 CONFIG_CM36651=m
 CONFIG_IIO_CROS_EC_LIGHT_PROX=m
 CONFIG_SENSORS_ISL29018=y
-- 
2.34.1


