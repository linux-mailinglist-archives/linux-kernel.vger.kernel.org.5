Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 173A2760D6F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 10:44:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232295AbjGYIol (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 04:44:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233142AbjGYInp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 04:43:45 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1894A1992
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 01:42:45 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-9928abc11deso885778766b.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 01:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1690274564; x=1690879364;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=z091H1uxzzG2Ns0W57H5Z6nVTJ86c5y6NDL0OobtWeo=;
        b=5MvNmbds2/WhMIoZP2lQ2ZiqcLlntkwKFdW0E6OXbGn3LFxW4gXd/SD+TqWKVaoSfZ
         Jbv2N4gmMLW3+18rR9zLlhC1uVb+L2tqSKjovIvpypGpwnVYmqWndoCCTV9XosG7ee7d
         fDwa3evxB2EvO558bMEMtcdfSFMFhURjp3RQ85nISteo4DgbDanSlKZIjnm1JmfdfW70
         oY7kEe9h/REWsLUPhCGnovJqVkRpd3dFM9EnL2lk4xXkBLDIp4qp15z7bnepG1XdS3mV
         OSgFasAUed+NVb8+V8mSOhlYibEWv5WSSvV1kKOI+jleUWv/S1DfHNIWiAJyvifAO3+W
         5TIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690274564; x=1690879364;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z091H1uxzzG2Ns0W57H5Z6nVTJ86c5y6NDL0OobtWeo=;
        b=Eivd4ejuV0dlbK/TdmDPOwlOvvGw5gGLRjmjwc5HC52MWqkkeyh/TWMTYLwW/Co8Ik
         d8buTwlT8YVcoKMI7zpLIK3zqzRm6rKiCHrnwGkD2ps2OVzMdlKCLpdgpOxCXxly9WsK
         MeLg7fbBSTP6sQZoBhxiouitaet87u0j1gy4Wak8TrqIwJFMjtNZbhxErF0jA6p0gDGH
         Tv1zWqFoXNRpTvcLEUdcb1ZVKoI92bcviKo1Yz5iy4w+Z8JY6ri5B3+9ii5mzkmzebeI
         eZpFk1GxvPceM8ONnKqRXkr4FX4P0j5kf7claCaJV09okO4jRIGKIyl2B8wT/xHl4F+a
         CMBg==
X-Gm-Message-State: ABy/qLaDdol4CoGlVRBlSvD6PSJ/UABkkOT+Ps0UBrpT6AUWozDeIVB/
        R55AHeOkebAyAqm/bWqpVkMb1A==
X-Google-Smtp-Source: APBJJlHXZ1txggUwE3878KiKvpLuaVTJTfsZ7upmISTPW5LzKY3HJXK+5Q2t+sJxhg/3yaUocvtR2g==
X-Received: by 2002:a17:906:7695:b0:994:580c:5049 with SMTP id o21-20020a170906769500b00994580c5049mr12926293ejm.5.1690274564330;
        Tue, 25 Jul 2023 01:42:44 -0700 (PDT)
Received: from [127.0.1.1] ([86.71.62.166])
        by smtp.gmail.com with ESMTPSA id j15-20020a170906254f00b00992d122af63sm7917523ejb.89.2023.07.25.01.42.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 01:42:43 -0700 (PDT)
From:   Julien Panis <jpanis@baylibre.com>
Date:   Tue, 25 Jul 2023 10:42:29 +0200
Subject: [PATCH] ARM: multi_v7_defconfig: Enable support for OMAP
 peripherals
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230725-enable-omap-dev-v1-1-297f6bbb3def@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAPSKv2QC/x2NzQqDMBAGX0X23IU0JfbnVUoPG/2iCzXKpkhBf
 PfGHodhmI0KTFHo0WxkWLXonCucTw11o+QBrH1l8s5f3NUHRpb4Bs+TLNxj5dC6hHuQdBNHtYp
 SwNEkd+PRTVI+sEMshqTf/+r52vcfkSzugHoAAAA=
To:     Russell King <linux@armlinux.org.uk>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        vigneshr@ti.com, Julien Panis <jpanis@baylibre.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1690274562; l=2087;
 i=jpanis@baylibre.com; s=20230526; h=from:subject:message-id;
 bh=cjTIx2YbWq9Hod6dIfDNw2875Nz4pY7YP3b1toTJ3Lc=;
 b=9ZqJI5kqAhzq01TBM2gkjZjNxjOH3TAZob+Bjd2O6Su9e8DM1lme8K47muTEjKUVBc1iVoskf
 G2Q1pZMWXOgBob9WE+TDEaCUm+ePaSNFOZOAijZ7938eQu/mtQxTzKV
X-Developer-Key: i=jpanis@baylibre.com; a=ed25519;
 pk=8eSM4/xkiHWz2M1Cw1U3m2/YfPbsUdEJPCWY3Mh9ekQ=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Increase build and test coverage by enabling support for several
peripherals used on TI OMAP based boards:
- Watchdog
- RTC
- ADC
- CDC Composite Device (ethernet and serial port)

Signed-off-by: Julien Panis <jpanis@baylibre.com>
---
Enable peripherals in multi_v7_defconfig for TI OMAP based boards.

To generate this patch, a previous discussion (related to watchdog activation)
was taken into account:
https://lore.kernel.org/all/20230718-enable-omap-wd-v2-1-921f829bc0a5@baylibre.com/
---
 arch/arm/configs/multi_v7_defconfig | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index f0800f806b5f..45ed7493eaf5 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -553,6 +553,7 @@ CONFIG_AT91SAM9X_WATCHDOG=y
 CONFIG_SAMA5D4_WATCHDOG=y
 CONFIG_S3C2410_WATCHDOG=m
 CONFIG_DW_WATCHDOG=y
+CONFIG_OMAP_WATCHDOG=m
 CONFIG_DAVINCI_WATCHDOG=m
 CONFIG_ORION_WATCHDOG=y
 CONFIG_RN5T618_WATCHDOG=y
@@ -600,6 +601,7 @@ CONFIG_MFD_RK8XX_I2C=y
 CONFIG_MFD_RN5T618=y
 CONFIG_MFD_SEC_CORE=y
 CONFIG_MFD_STMPE=y
+CONFIG_MFD_TI_AM335X_TSCADC=m
 CONFIG_MFD_PALMAS=y
 CONFIG_MFD_TPS65090=y
 CONFIG_MFD_TPS65217=y
@@ -898,6 +900,7 @@ CONFIG_USB_CONFIGFS_F_HID=y
 CONFIG_USB_CONFIGFS_F_UVC=y
 CONFIG_USB_CONFIGFS_F_PRINTER=y
 CONFIG_USB_ETH=m
+CONFIG_USB_CDC_COMPOSITE=m
 CONFIG_TYPEC=m
 CONFIG_TYPEC_UCSI=m
 CONFIG_UCSI_STM32G0=m
@@ -987,6 +990,7 @@ CONFIG_RTC_DRV_S5M=m
 CONFIG_RTC_DRV_DA9063=m
 CONFIG_RTC_DRV_EFI=m
 CONFIG_RTC_DRV_DIGICOLOR=m
+CONFIG_RTC_DRV_OMAP=m
 CONFIG_RTC_DRV_S3C=m
 CONFIG_RTC_DRV_SA1100=m
 CONFIG_RTC_DRV_SH=m
@@ -1143,6 +1147,7 @@ CONFIG_STM32_ADC_CORE=m
 CONFIG_STM32_ADC=m
 CONFIG_STM32_DFSDM_ADC=m
 CONFIG_STMPE_ADC=m
+CONFIG_TI_AM335X_ADC=m
 CONFIG_VF610_ADC=m
 CONFIG_XILINX_XADC=y
 CONFIG_IIO_CROS_EC_SENSORS_CORE=m

---
base-commit: 6eaae198076080886b9e7d57f4ae06fa782f90ef
change-id: 20230725-enable-omap-dev-560fe95af8a0

Best regards,
-- 
Julien Panis <jpanis@baylibre.com>

