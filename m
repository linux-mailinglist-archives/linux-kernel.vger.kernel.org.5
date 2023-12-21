Return-Path: <linux-kernel+bounces-9148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2760981C19A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 00:03:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 593231C2493C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 23:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9CC779941;
	Thu, 21 Dec 2023 23:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VGOnsMbc"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C810D79490;
	Thu, 21 Dec 2023 23:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40c236624edso13416485e9.1;
        Thu, 21 Dec 2023 15:03:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703199788; x=1703804588; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+QPd5UC5wjwrd312bUyvXjAszGjHn9J8dktI9Ob4QrE=;
        b=VGOnsMbcDamccZ014SijFm64qGtpTnWrKv1QcB1VlHj60iyDPfclwut3WyN//lFu6n
         kVHgjkIhRxbdoLLiWlcM2OpNfLHo3xA64yZe6/0LW6CNOkKqW88oirUmpoRYefhO8ye3
         IifnsRPHxbnSWG58luPHIO+pWCbItppAdvbGmT9wgrS6ZCOnse9OOa3/fU2aFiuDIKxM
         zMMhlo9X66cey/Eckxekf//xQvwpY44H7Q1nb03+kvRFAB/sO3QLqDSoSnYd6CSGHtbX
         THRsOOUszdGaZZuk36ZCu3Oe4SLlJc6MPqikRvNQwA8y8gmTbo0hRHIXevofJrxOgI84
         +57A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703199788; x=1703804588;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+QPd5UC5wjwrd312bUyvXjAszGjHn9J8dktI9Ob4QrE=;
        b=hZxBO+KKMrJFry0xY18DqtjCW1oXcVaA3eA0KQBmKt6IgJiLJcbXLyovTTnlFYH1c/
         xBuDznHM6ngfOEAhet/SLgDYSnchXXbytidSf1DttmC4YKSU7FT+W2dJDp5D5hPmc0JD
         4NnR0mSbjsM1twxx6uYVyPUnhSILfmwlnuD+kvTwy2XdCe+0KYQbPhyx5O0tgnzoEP4J
         i09g3WukaZed7W2TvyrvSBBSHtEiLcthZLP7aia78WzIqzMS8jCx++T2/Uy1r+XLau4T
         e7ko3gYR/jL/WzxHxLzqFQLYXXNa06SHYV4fWFAq94Hje7ePirx62mIvrGyIhsylPYg2
         UNtw==
X-Gm-Message-State: AOJu0YyqMSIacoFvK8+HyxL11MFzTn+eBD7iwQWLDsWA/2StUr6Tt6Ra
	GkZb26oK+akrXfrxPUhsV2Ip5UgAl2Y/sqbs
X-Google-Smtp-Source: AGHT+IFEJC9uQWHqv2NZj0Zu29vtqGDT3x+e0WfrlNsFLjKBkJuxdZUVg1YePvWVLsWjPgd0BGGJJQ==
X-Received: by 2002:a05:600c:198c:b0:40d:40e5:4b0c with SMTP id t12-20020a05600c198c00b0040d40e54b0cmr231448wmq.134.1703199787696;
        Thu, 21 Dec 2023 15:03:07 -0800 (PST)
Received: from adroid ([2a02:2c60:f18b:5f60:b2a3:31e6:bf5b:266a])
        by smtp.gmail.com with ESMTPSA id k4-20020a5d66c4000000b00336755f15b0sm2968647wrw.68.2023.12.21.15.03.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 15:03:07 -0800 (PST)
From: =?UTF-8?q?Martin=20J=C3=BCcker?= <martin.juecker@gmail.com>
To: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: robh+dt@kernel.org,
	conor+dt@kernel.org,
	alim.akhtar@samsung.com,
	martin.juecker@gmail.com,
	linux@armlinux.org.uk,
	krzysztof.kozlowski@linaro.org
Subject: [PATCH 2/2] ARM: defconfig: enable STMicroelectronics accelerometer and gyro
Date: Fri, 22 Dec 2023 00:02:58 +0100
Message-Id: <20231221230258.56272-2-martin.juecker@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231221230258.56272-1-martin.juecker@gmail.com>
References: <20231221230258.56272-1-martin.juecker@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Enable STMicroelectronics accelerometer and gyro drivers for the p4note
device family in exynos and multi_v7 defconfigs.

Signed-off-by: Martin Jücker <martin.juecker@gmail.com>
---
 arch/arm/configs/exynos_defconfig   | 3 +++
 arch/arm/configs/multi_v7_defconfig | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_defconfig
index 7483d7be23a66..0b64ce9be9aca 100644
--- a/arch/arm/configs/exynos_defconfig
+++ b/arch/arm/configs/exynos_defconfig
@@ -320,8 +320,11 @@ CONFIG_EXTCON_MAX77693=y
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
index a4260c9e600d4..2e4a732420a21 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -1146,6 +1146,8 @@ CONFIG_STM32_FMC2_EBI=y
 CONFIG_EXYNOS5422_DMC=m
 CONFIG_IIO=y
 CONFIG_IIO_SW_TRIGGER=y
+CONFIG_IIO_ST_ACCEL_3AXIS=m
+# CONFIG_IIO_ST_ACCEL_SPI_3AXIS is not set
 CONFIG_ASPEED_ADC=m
 CONFIG_AT91_ADC=m
 CONFIG_AT91_SAMA5D2_ADC=m
@@ -1165,6 +1167,7 @@ CONFIG_IIO_CROS_EC_SENSORS_CORE=m
 CONFIG_IIO_CROS_EC_SENSORS=m
 CONFIG_STM32_DAC=m
 CONFIG_MPU3050_I2C=y
+CONFIG_IIO_ST_GYRO_3AXIS=m
 CONFIG_CM36651=m
 CONFIG_IIO_CROS_EC_LIGHT_PROX=m
 CONFIG_SENSORS_ISL29018=y
-- 
2.34.1


