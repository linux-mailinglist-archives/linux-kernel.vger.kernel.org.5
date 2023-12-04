Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37E1380375D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 15:46:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236005AbjLDOpy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 09:45:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236091AbjLDOp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 09:45:29 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A7C811A;
        Mon,  4 Dec 2023 06:44:54 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1d04c097e34so22914875ad.0;
        Mon, 04 Dec 2023 06:44:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701701093; x=1702305893; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mr+hGVgKYHho74r9Sx7X0qX3CfwxBFy5+SbXUpW0SOc=;
        b=Y+F1yFneH4pImBvGjSM2mUy8q7TSAuIi1uzLkNViECxQBuce23e2quAyn998cp072f
         BGn6UJJ3BgVqbc/LkMjwNzp4E8gWvB+LhFA2M1MoIpw9qcomhn7Y0FsEXSAyy/5jIcIh
         o5vtz+PR8RL/BEQNM7+T+5V5njdCPmMja8plrgFDi6aQCsBSAFDYSbywV4fD7GD5HxuU
         YTWLZEK45+j3SmyFYcLCcCpGtwHFy8f7e/Wv6YIBOv3GxTSE63ooSYt4z8b9QH/6ktw8
         +ylINmvX0Mf0e8cN/6B5GF3SjPXYm083hxf09DmZcOEhHNyYNo9SADvgoHJDlCQjbOLV
         k1RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701701093; x=1702305893;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mr+hGVgKYHho74r9Sx7X0qX3CfwxBFy5+SbXUpW0SOc=;
        b=LhsG6ocfeT6AxgGF5OscD2/FTVArH1idZRwq0r0bVsY30S1JP4Ych6QA8fLoqsewjv
         kQx5+UoyDqw+UNUZHNGRLVdbeVyeaH4vP11LF1+4t7d1qLBIxwrT9LvnYJMguLNeHY06
         FfZtQSecE7WHTIYYIjMPJLmCoHBxtP9I5t0IOqDw6I/JKLzecJfkwDbvnRvPlBVOkR/H
         5bjWZ9D1mzzlooYXX/WZ59sGkd+0vHEhnFxF4tVfAMe5sqQeE2v90wVri64LqzrsRzQq
         4GgKO9C4OuxHQFZ/CvnMgKIF6XVXXZBkP9KUMn+Ehjx0ewomTs6nRyX2ZRJ+WMUtmxos
         rV0Q==
X-Gm-Message-State: AOJu0YwI7UPKNEGQARG0mBMfJuFTGiZfpDoUbcMZfay9OdwKb7Rwxiil
        ohUILc32PwBnPuSjkNq09P8=
X-Google-Smtp-Source: AGHT+IHGfqxKkWM24FH6lMaewZHVoejZM4kN49I5j0/eGqPj4SfnwIrxljFk/WuUSR53XiDmDqdXbw==
X-Received: by 2002:a17:902:dac8:b0:1d0:700b:3f78 with SMTP id q8-20020a170902dac800b001d0700b3f78mr4602429plx.50.1701701093156;
        Mon, 04 Dec 2023 06:44:53 -0800 (PST)
Received: from localhost.localdomain ([49.205.242.26])
        by smtp.gmail.com with ESMTPSA id l6-20020a170902d34600b001cfb99d8b82sm6446815plk.136.2023.12.04.06.44.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 06:44:52 -0800 (PST)
From:   Anand Moon <linux.amoon@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     Anand Moon <linux.amoon@gmail.com>,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 2/2] arm64: dts: amlogic: Used onboard usb hub reset on odroid n2
Date:   Mon,  4 Dec 2023 20:14:26 +0530
Message-ID: <20231204144429.45197-3-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231204144429.45197-1-linux.amoon@gmail.com>
References: <20231204144429.45197-1-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Odroid n2/n2+ previously use gpio-hog to reset the usb hub,
switch to used on-board usb hub reset to enable the usb hub
and enable power to hub.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
V6:none
V5:none
V4:none
V3:none
V2:none
V1:none
---
 .../dts/amlogic/meson-g12b-odroid-n2.dtsi     | 36 ++++++++++++-------
 1 file changed, 24 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dtsi
index 91c9769fda20..9e671444eca6 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dtsi
@@ -31,6 +31,30 @@ hub_5v: regulator-hub_5v {
 		enable-active-high;
 	};
 
+	/* USB hub supports both USB 2.0 and USB 3.0 root hub */
+	usb-hub {
+		dr_mode = "host";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		/* 2.0 hub on port 1 */
+		hub_2_0: hub@1 {
+			compatible = "usb5e3,610";
+			reg = <1>;
+			peer-hub = <&hub_3_0>;
+			vdd-supply = <&usb_pwr_en>;
+		};
+
+		/* 3.0 hub on port 4 */
+		hub_3_0: hub@2 {
+			compatible = "usb5e3,620";
+			reg = <2>;
+			peer-hub = <&hub_2_0>;
+			reset-gpios = <&gpio GPIOH_4 GPIO_ACTIVE_LOW>;
+			vdd-supply = <&vcc_5v>;
+		};
+	};
+
 	sound {
 		compatible = "amlogic,axg-sound-card";
 		model = "ODROID-N2";
@@ -234,18 +258,6 @@ &gpio {
 		"PIN_3",  /* GPIOX_17 */
 		"PIN_5",  /* GPIOX_18 */
 		"PIN_36"; /* GPIOX_19 */
-	/*
-	 * WARNING: The USB Hub on the Odroid-N2 needs a reset signal
-	 * to be turned high in order to be detected by the USB Controller
-	 * This signal should be handled by a USB specific power sequence
-	 * in order to reset the Hub when USB bus is powered down.
-	 */
-	usb-hub-hog {
-		gpio-hog;
-		gpios = <GPIOH_4 GPIO_ACTIVE_HIGH>;
-		output-high;
-		line-name = "usb-hub-reset";
-	};
 };
 
 &i2c3 {
-- 
2.42.0

