Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C9CB7E5813
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 14:44:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232000AbjKHNoq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 08:44:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbjKHNoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 08:44:44 -0500
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65B6C1BFE
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 05:44:42 -0800 (PST)
Received: by mail-ej1-x644.google.com with SMTP id a640c23a62f3a-9c53e8b7cf4so1053854566b.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Nov 2023 05:44:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1699451080; x=1700055880; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IVv5mcW5zUgVSiSOauQHcHZhJPg5UCLoWJRDvmkhj7k=;
        b=b1YwFl1N0rh28F9ndwx1VKdwqN7JVkUNnJL2HRiTWVsaqG9xjSomQWBarF3j4Evojx
         lhyUROga4guIUM85JJEScrWyltJwqlw6y2xNAu5hWI33OtNnqyOWu8vxIW0kdrsJ7ni9
         GOEivr5H/1hxC9NtsiFuCsZi71RyZNBqN4AOY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699451080; x=1700055880;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IVv5mcW5zUgVSiSOauQHcHZhJPg5UCLoWJRDvmkhj7k=;
        b=REzYYXMYXDYkiy1TkFU7aW7rQAZKuOQHk4/cKc4CpSCuQRUZ+qMUYQqzszPKNCDt7D
         6ZPVehnYFL/juz+drx/5Q7k8aCWY5Aqlb+d8c9jpMFBfNiuvNkLUc9xZMgHllp2anC/k
         zx6UQC4WXAtjZrC/JTaVAWohhLSgrgZsCQusmQkD3r4tO9m/H1rBX5EqzzLqSj5JSndY
         Da0HtD1fLDDDb0I1+b1yuZu4y3u8QCQ8E5i21szfKcvk7lDLjG33jP42z2g0E1yMxy3R
         WPVVGTaedd8jID+1jFoDGWnLY9GvN/oktXnPdfv75Q4Pzx3SyQeo7DuxxAm2ig7ly7h/
         yaPw==
X-Gm-Message-State: AOJu0YxHwOUoe8DTwiEjFIQdRxZWfEvEX2ZVCjTgpp2saq1qtLulwdry
        1cmBm8aM6LON68gs9yta0zKLZb0hEjtP7tCwpc6s2cj9
X-Google-Smtp-Source: AGHT+IEn/7ehRYp2n2E4vkCWEuoVxQ7nZKTWTIBc8HV+mV3MsZL6jh3kxXkuRcD9ZyWoygMo5iN7MA==
X-Received: by 2002:a17:907:987:b0:9e0:4910:1649 with SMTP id bf7-20020a170907098700b009e049101649mr1775121ejc.8.1699451080611;
        Wed, 08 Nov 2023 05:44:40 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-79-20-97-182.retail.telecomitalia.it. [79.20.97.182])
        by smtp.gmail.com with ESMTPSA id kj3-20020a170907764300b009bf7a4d591csm1091457ejc.11.2023.11.08.05.44.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Nov 2023 05:44:40 -0800 (PST)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-amarula@amarulasolutions.com,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: [RESEND PATCH] ARM: dts: stm32f469-disco: use the same 3v3 for SD and DSI nodes
Date:   Wed,  8 Nov 2023 14:44:06 +0100
Message-ID: <20231108134426.4174699-1-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the board schematic, the power supply for the SD card is the same 3.3
volts used to power the LCD panel and other peripherals. By generalizing
the name of the voltage regulator, it simplifies the device tree and makes
it more readable.

Link: https://www.st.com/en/evaluation-tools/32f469idiscovery.html#cad-resources
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

 arch/arm/boot/dts/st/stm32f469-disco.dts | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/arch/arm/boot/dts/st/stm32f469-disco.dts b/arch/arm/boot/dts/st/stm32f469-disco.dts
index cbbd521bf010..8a4f8ddd083d 100644
--- a/arch/arm/boot/dts/st/stm32f469-disco.dts
+++ b/arch/arm/boot/dts/st/stm32f469-disco.dts
@@ -69,16 +69,9 @@ aliases {
 		serial0 = &usart3;
 	};
 
-	mmc_vcard: mmc_vcard {
+	vcc_3v3: vcc-3v3 {
 		compatible = "regulator-fixed";
-		regulator-name = "mmc_vcard";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-	};
-
-	vdd_dsi: vdd-dsi {
-		compatible = "regulator-fixed";
-		regulator-name = "vdd_dsi";
+		regulator-name = "vcc_3v3";
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
 	};
@@ -164,7 +157,7 @@ panel@0 {
 		compatible = "orisetech,otm8009a";
 		reg = <0>; /* dsi virtual channel (0..3) */
 		reset-gpios = <&gpioh 7 GPIO_ACTIVE_LOW>;
-		power-supply = <&vdd_dsi>;
+		power-supply = <&vcc_3v3>;
 		status = "okay";
 
 		port {
@@ -219,7 +212,7 @@ timer@2 {
 
 &sdio {
 	status = "okay";
-	vmmc-supply = <&mmc_vcard>;
+	vmmc-supply = <&vcc_3v3>;
 	cd-gpios = <&gpiog 2 GPIO_ACTIVE_LOW>;
 	broken-cd;
 	pinctrl-names = "default", "opendrain";
-- 
2.42.0

