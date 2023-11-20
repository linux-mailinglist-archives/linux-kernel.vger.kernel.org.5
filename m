Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 618627F1FCD
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 22:56:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231745AbjKTV47 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 16:56:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjKTV45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 16:56:57 -0500
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a02:c205:3004:2154::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BD5DBB;
        Mon, 20 Nov 2023 13:56:52 -0800 (PST)
Received: from p200300ccff2027001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff20:2700:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <andreas@kemnade.info>)
        id 1r5CFx-006RZ7-MZ; Mon, 20 Nov 2023 22:56:37 +0100
Received: from andi by aktux with local (Exim 4.96)
        (envelope-from <andreas@kemnade.info>)
        id 1r5CFx-00HZKu-06;
        Mon, 20 Nov 2023 22:56:37 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     tony@atomide.com, linux@armlinux.org.uk,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH] ARM: omap2plus_defconfig: enable I2C devcies of bt200
Date:   Mon, 20 Nov 2023 22:56:35 +0100
Message-Id: <20231120215635.4187399-1-andreas@kemnade.info>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable all available I2C drivers needed for the Epson Moverio BT200,
that are:
- LED
- Subdevs of the TWL6032 PMIC
- IMU sensors

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 arch/arm/configs/omap2plus_defconfig | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index 7b1b41b4b1609..3a166c2f02bd8 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -607,6 +607,7 @@ CONFIG_LEDS_LP55XX_COMMON=m
 CONFIG_LEDS_LP5523=m
 CONFIG_LEDS_PCA963X=m
 CONFIG_LEDS_PWM=m
+CONFIG_LEDS_BD2606MVV=m
 CONFIG_LEDS_TRIGGERS=y
 CONFIG_LEDS_TRIGGER_TIMER=m
 CONFIG_LEDS_TRIGGER_ONESHOT=m
@@ -624,6 +625,7 @@ CONFIG_RTC_DRV_PALMAS=m
 CONFIG_RTC_DRV_OMAP=m
 CONFIG_RTC_DRV_CPCAP=m
 CONFIG_DMADEVICES=y
+CONFIG_CLK_TWL=m
 CONFIG_CLK_TWL6040=m
 CONFIG_COMMON_CLK_PALMAS=m
 CONFIG_OMAP_IOMMU=y
@@ -646,6 +648,9 @@ CONFIG_CPCAP_ADC=m
 CONFIG_INA2XX_ADC=m
 CONFIG_TI_AM335X_ADC=m
 CONFIG_TWL4030_MADC=m
+CONFIG_TWL6030_GPADC=m
+CONFIG_MPU3050_I2C=m
+CONFIG_INV_MPU6050_I2C=m
 CONFIG_SENSORS_ISL29028=m
 CONFIG_AK8975=m
 CONFIG_BMP280=m
-- 
2.39.2

