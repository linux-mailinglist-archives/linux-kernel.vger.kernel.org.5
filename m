Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43EF4783D9D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 12:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234650AbjHVKKD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 06:10:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234641AbjHVKKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 06:10:01 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0653518B;
        Tue, 22 Aug 2023 03:10:00 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-1c4d8eaa8ebso2790615fac.0;
        Tue, 22 Aug 2023 03:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692698999; x=1693303799;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WDGT67Q+ic1nejZuLGS46+I/MVwpubEr1pR0ugjy0IU=;
        b=LG4MRSC7npmqM5v4ypEN2DwtIDGV9Ah4DOUM6MEVZUMKX9OK5uOLIj/PDYxLIPGVjd
         GTvzBbr8pp5v3vEJ38Q7gcAROE1ZW67QxdkltOtD0EBgqz/alqB06NKas/nzdN025zcf
         FIjH7z7RZbNfUZXTndqURJVV8j+kLD8HI6WrSreP5D7mUaQJffWZi+oNHo8j07WI8PXD
         SnxYAHHpptdO/k2Q+okKoKoEjA+79yDs3jWJGgxVqTqvYZ8f4kKSOAHn6fH2e+HbqWvO
         brzatVPWh9JRF6IxnY5y5oOwxV/ENlUcQyzTBqZBp70K2aOugnVo0u4iNgaTLpy47uFd
         O2Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692698999; x=1693303799;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WDGT67Q+ic1nejZuLGS46+I/MVwpubEr1pR0ugjy0IU=;
        b=B1MQE8jq5TT1FoOhrBF9bzIjxhanepuFbpt/ELlwCxlfglzpHRR7rlLEYO6N/SSxEE
         UNj07FA5MEDMPp579n9ayiPrPDadXIh3jkMbzma6ZaERhrRgZkXYZUJ1dclla4KlT1xI
         eWiWbIULUdaTZu/O8mYK13mWlTtIFs03aZwpZBLzWWeWDVX271wZ3YRQduEST7sCbdbl
         BBRh5gJEaFEuKnCnzV4amX3sLCRdwAcJzLFQg+ZwFEPU9Qa3Tu2omCO3vD7f1Gbwse9k
         RyPYBRmiU8XW5FR17FTHzwQTeWBeu+3OV2tHkwqImDHsP8LntDuRP0qKJokzAXl0jY1w
         g5lA==
X-Gm-Message-State: AOJu0YwrV4xZrqJgyEv6or4sbOk9dhozFHBwic5Au72TJAXUwmTbSRHH
        V98PCfjJ4JhGW8k15jspFVY=
X-Google-Smtp-Source: AGHT+IFqJs+8P0h5g5uFmdxTSWtrDryAe+2Ys7rZBcG+dYooxilXoWmF0cXX8oPdCL+ghCLEOrnOHg==
X-Received: by 2002:a05:6870:610a:b0:1bb:7f9f:2fc5 with SMTP id s10-20020a056870610a00b001bb7f9f2fc5mr11455924oae.17.1692698999223;
        Tue, 22 Aug 2023 03:09:59 -0700 (PDT)
Received: from a28aa0606c51.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id s10-20020a17090a948a00b00263cca08d95sm9278975pjo.55.2023.08.22.03.09.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 03:09:59 -0700 (PDT)
From:   Jacky Huang <ychuang570808@gmail.com>
To:     a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org
Cc:     linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        mjchen@nuvoton.com, schung@nuvoton.com,
        Jacky Huang <ychuang3@nuvoton.com>
Subject: [PATCH v3 2/3] arm64: dts: nuvoton: Add rtc for ma35d1
Date:   Tue, 22 Aug 2023 10:09:47 +0000
Message-Id: <20230822100948.1366487-3-ychuang570808@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230822100948.1366487-1-ychuang570808@gmail.com>
References: <20230822100948.1366487-1-ychuang570808@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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

