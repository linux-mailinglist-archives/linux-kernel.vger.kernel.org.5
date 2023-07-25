Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49148760F8C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 11:40:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232263AbjGYJkz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 05:40:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231954AbjGYJkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 05:40:43 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F7DB19F;
        Tue, 25 Jul 2023 02:40:43 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-66c729f5618so4989842b3a.1;
        Tue, 25 Jul 2023 02:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690278042; x=1690882842;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WDGT67Q+ic1nejZuLGS46+I/MVwpubEr1pR0ugjy0IU=;
        b=cujy8UqGDjuyBZJHn1z+l9lF/kWHcrNYBfxgTOA5WChq5oixPUID8eq47Zn8IWxCq/
         PmoRCyAOv90ccO4UNR85LS2dTxLgmecAMP+s37EVv/KF+5fFO14QK4/uBIcy1dq7lYbv
         naG8u2A/Ve+3BxAZmoTAyU60nWOmKHF9eTJ9RL0EaT06/kDw/3ChOknw/98kpWLHBplq
         2Sle8MMwZgox6Tz2cifS1ORN/SMyC8S1A0nP8mLu3TQg7bjgZmlHW9HJzRbCzF8Bjd7t
         mwoCkT02XhnIKvi2Q1CsiIcqgpNfQt7CqR/SYt7nLzNd1dSEKV0skG8EuMK6wnD7LNZ7
         M2JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690278042; x=1690882842;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WDGT67Q+ic1nejZuLGS46+I/MVwpubEr1pR0ugjy0IU=;
        b=CCrpJWRqbUDJFITqPFh7EYrlBM/QZ82fGpV8E54/YECcXUXr26nYrpsGBqgBlzkCtB
         +IPbyeyjgw+dJ2ejVpw9uhxQE51V2gsmgubRFDkcq5Hq2aplxe1Xl4rG2zkz6GZMjtlo
         kMQoxwZt/+wOavPzFCXkKe23hxaUGcgq92eO5kI6WfvPjJR78BQtB8KMpLVQ5oDRa2pS
         KD7ekkxpP5wvJWBMmbr3bWM14E+omtEgknctWonTBG7bcZxk1sr0CiBFPulApC1oPLUx
         +zyaoBRiaTtocDLvjjH9IhihrMPdWu0JcF+4bfOhiwr+7kHB7Zdm6V+hcVGbOanwq2ON
         P2OA==
X-Gm-Message-State: ABy/qLbYkl9vFG0/uioDh0BrW4rZxHxQtnEas2BsPKD9Wk3NZS1lmyYC
        6bJxWGGXF96sdB4QEs3JCStA55Twra0=
X-Google-Smtp-Source: APBJJlH0N05ZRzXPHsjXaGG8G3yeI+QTct1OR8cDXXiyThVYUCkJPZ4UoOTayAQk3LwqDxWxki0hZQ==
X-Received: by 2002:a05:6a00:15ce:b0:67c:5c21:b430 with SMTP id o14-20020a056a0015ce00b0067c5c21b430mr14332040pfu.33.1690278042621;
        Tue, 25 Jul 2023 02:40:42 -0700 (PDT)
Received: from a28aa0606c51.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id l24-20020a62be18000000b0064f7c56d8b7sm9121132pff.219.2023.07.25.02.40.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 02:40:42 -0700 (PDT)
From:   Jacky Huang <ychuang570808@gmail.com>
To:     a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org
Cc:     linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        soc@kernel.org, mjchen@nuvoton.com, schung@nuvoton.com,
        Jacky Huang <ychuang3@nuvoton.com>
Subject: [PATCH v2 2/3] arm64: dts: nuvoton: Add rtc for ma35d1
Date:   Tue, 25 Jul 2023 09:40:29 +0000
Message-Id: <20230725094030.32877-3-ychuang570808@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230725094030.32877-1-ychuang570808@gmail.com>
References: <20230725094030.32877-1-ychuang570808@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jacky Huang <ychuang3@nuvoton.com>

Add rtc controller support to the dtsi of ma35d1 SoC and
enable rtc on SOM and IoT boards.

Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
---
 arch/arm64/boot/dts/nuvoton/ma35d1-iot-512m.dts | 4 ++++
 arch/arm64/boot/dts/nuvoton/ma35d1-som-256m.dts | 4 ++++
 arch/arm64/boot/dts/nuvoton/ma35d1.dtsi         | 8 ++++++++
 3 files changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/nuvoton/ma35d1-iot-512m.dts b/arch/arm64/boot/dts/nuvoton/ma35d1-iot-512m.dts
index b89e2be6abae..b3be4331abcf 100644
--- a/arch/arm64/boot/dts/nuvoton/ma35d1-iot-512m.dts
+++ b/arch/arm64/boot/dts/nuvoton/ma35d1-iot-512m.dts
@@ -54,3 +54,7 @@ &clk {
 			   "integer",
 			   "integer";
 };
+
+&rtc {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/nuvoton/ma35d1-som-256m.dts b/arch/arm64/boot/dts/nuvoton/ma35d1-som-256m.dts
index a1ebddecb7f8..9858788a589c 100644
--- a/arch/arm64/boot/dts/nuvoton/ma35d1-som-256m.dts
+++ b/arch/arm64/boot/dts/nuvoton/ma35d1-som-256m.dts
@@ -54,3 +54,7 @@ &clk {
 			   "integer",
 			   "integer";
 };
+
+&rtc {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/nuvoton/ma35d1.dtsi b/arch/arm64/boot/dts/nuvoton/ma35d1.dtsi
index 781cdae566a0..394395bfd3ae 100644
--- a/arch/arm64/boot/dts/nuvoton/ma35d1.dtsi
+++ b/arch/arm64/boot/dts/nuvoton/ma35d1.dtsi
@@ -95,6 +95,14 @@ clk: clock-controller@40460200 {
 			clocks = <&clk_hxt>;
 		};
 
+		rtc: rtc@40410000 {
+			compatible = "nuvoton,ma35d1-rtc";
+			reg = <0x0 0x40410000 0x0 0x200>;
+			interrupts = <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clk RTC_GATE>;
+			status = "disabled";
+		};
+
 		uart0: serial@40700000 {
 			compatible = "nuvoton,ma35d1-uart";
 			reg = <0x0 0x40700000 0x0 0x100>;
-- 
2.34.1

