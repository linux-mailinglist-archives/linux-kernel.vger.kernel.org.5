Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6218D791C53
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 20:06:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353389AbjIDSGt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 14:06:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237851AbjIDSGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 14:06:46 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68D7BF9
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 11:06:43 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2bcc4347d2dso24800761fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Sep 2023 11:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1693850801; x=1694455601; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UerQu8X0sDSfgf2+CbpRUuHP8N70bRTmPby/bAIFB0Q=;
        b=lykhD/ZpsWtSMpRAcpJHijekRGF4WIf56DJsdE9vamhQZb9Ovz6T0jS0BQOWaTUvGT
         GkrnK5Fy2fj0h4mJI4qAZGkMTyrcYCO9qNId8MCe3Sin1UjQfHBtiMvRbG0NppAmXioP
         BR0ejdksrPypaZDfFIrC/kGromYu0QjvXJs4k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693850801; x=1694455601;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UerQu8X0sDSfgf2+CbpRUuHP8N70bRTmPby/bAIFB0Q=;
        b=NlSn2FG8iEYDIO8S94o9tdWZkeC6ZIlVDE0s26odU3k4537vCOxWuECfaOMdjWhL4k
         vwmZSWBZ2c1yaW2JpjggF+Rw4uDuOg4W/204TmFUwU0yjpI6vVWj5eP9HUREDCx1gLyH
         5KanVn/nUw2e5+Tb3jAqW3Zo2VzHs+Gqk+PwMBHAXoSKrw8TUoG4IYrMRJG9BG3O6Qd6
         b9OU+VywFxBCvUjnbxAItpvVhkUXqthugGWSBVLQCOIPz+u4/HlpPfh+8gd4JFcna8bZ
         GN2MW2XlMkPbYUSu8tSATzTAiBxJsRCTrKFj9cLBL46PtpkXBsR8AgZDKF055JOTTnXU
         VDyA==
X-Gm-Message-State: AOJu0YwzJyNa7qpSQqWJEk0dMm4hzLSYfEu5IUa3fAjm7o6+EmoGIwfW
        MoGz/Pkn9m0QtzbQ/bj2g0cZhAMEChM/jR8VPmYPAg==
X-Google-Smtp-Source: AGHT+IE/yOwJTB71sCvOOHxNASxN/IQyYmWk7RSn4j6RvAtd5i/3U4nhAxCAXlqEBo6qGeVdzmGmfw==
X-Received: by 2002:a2e:b6c2:0:b0:2bc:da3e:3bda with SMTP id m2-20020a2eb6c2000000b002bcda3e3bdamr6653000ljo.2.1693850801146;
        Mon, 04 Sep 2023 11:06:41 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-79-54-71-141.retail.telecomitalia.it. [79.54.71.141])
        by smtp.gmail.com with ESMTPSA id l13-20020a170906a40d00b0099bc0daf3d7sm6534375ejz.182.2023.09.04.11.06.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Sep 2023 11:06:40 -0700 (PDT)
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
Subject: [RFC PATCH] ARM: dts: stm32f469-disco: use the same 3v3 for SD and DSI nodes
Date:   Mon,  4 Sep 2023 20:06:35 +0200
Message-Id: <20230904180635.923506-1-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
2.34.1

