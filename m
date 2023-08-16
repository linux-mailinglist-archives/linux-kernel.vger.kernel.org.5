Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1BC277D70C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 02:24:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240823AbjHPAXw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 20:23:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240795AbjHPAXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 20:23:21 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CDF42100;
        Tue, 15 Aug 2023 17:23:20 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id af79cd13be357-766fd5f9536so366543285a.3;
        Tue, 15 Aug 2023 17:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692145399; x=1692750199;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5/8K2QeZwhFqsUJjMS9Z0FDVEgMP4aY8Jq0ZFbU+wFw=;
        b=eJFvD+IcO8uvgiz89WpZ+yFprOak0v2Geg6OUZR86fL2Hyyex2SgTDMvUkdNMz4XXq
         fk/XKuDyEgiNJuoe+v2dKpQXmLS/FX8hA22KKSoOmvYmbRv/9bBNAiQlVEGHbm7F3Mvz
         EuZpcTQksQdFtLzxK63k6kA1dY+2/MKoyVRLVCkqMzFOEf+HRVNsJ8fPTZ/DxEXO2j5S
         6nF14hUF6eVGwDama823C0uHk+LMUeTK7Am2L02uQ1WRL4/q+kNbO7zl8h6mDxvIIlXi
         UGHD2kiC7zOlzjZzLiPqbP4XY5noDF+2hfwlMJDN0fyOSUzWRG762MZxicQjSzBlgECV
         Lfvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692145399; x=1692750199;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5/8K2QeZwhFqsUJjMS9Z0FDVEgMP4aY8Jq0ZFbU+wFw=;
        b=NfzsaLaKy2HyXRekq/lLyj0UlWBE9Z0bLZEdL0eB9bq/ixgEl7QAUeZoeKtEshotl6
         8oanyphENCqMvpPDnQpqwwSLoJLN8P9oSf9zTcj2PVvHCw7PapvCSrb3iS0zBNf/AQdf
         EkjxPlMMz42wPoOABfMSoiHUIi+CJSGfI1SjhVJZ40CTsszBe+m1wJkoogOTxkbptxFw
         kq1S1PQlM0Sz76AyiEF546y2lB+vN4DrAUf5eqM2kij0esp21+1JFWXn4AYINz3Aq1ie
         jHvfMrpmZ2z0Lotp+M5uN60il0X1ybSJUE87nxhBDyRrM48lUZ5gUdgf6e2rEmj58r7b
         5jAA==
X-Gm-Message-State: AOJu0YxvcMpXsH1vmFWtNdQxl8w0/+rvqtgWLHOw5otkbsh+djEp4BV8
        7catc8a9afBuUO9x3iX+yM8=
X-Google-Smtp-Source: AGHT+IEy/k30Pb0SnuXft2UU+8PxSkioYv54YN09Kc1tPlmtFls7ljh3AdSEozuP98R4pc7KjSa1RQ==
X-Received: by 2002:a0c:f187:0:b0:647:42bc:d00b with SMTP id m7-20020a0cf187000000b0064742bcd00bmr274177qvl.63.1692145399542;
        Tue, 15 Aug 2023 17:23:19 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id r11-20020a0ccc0b000000b0063d5c9de720sm4452436qvk.80.2023.08.15.17.23.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 17:23:18 -0700 (PDT)
From:   Trevor Woerner <twoerner@gmail.com>
To:     drew@beagleboard.org,
        =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
Subject: [PATCH 3/3] ARM: dts: am335x-pocketbeagle: add missing GPIO mux
Date:   Tue, 15 Aug 2023 20:23:06 -0400
Message-ID: <20230816002308.36800-4-twoerner@gmail.com>
X-Mailer: git-send-email 2.41.0.327.gaa9166bcc0ba
In-Reply-To: <20230816002308.36800-1-twoerner@gmail.com>
References: <20230816002308.36800-1-twoerner@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the default MODE setting of a GPIO pin that was missing from the device
tree (i.e. P2.20/gpio2_00). This is to ensure the GPIO pins match the
pocketbeagle wiring expectations.

Signed-off-by: Trevor Woerner <twoerner@gmail.com>
---
 arch/arm/boot/dts/ti/omap/am335x-pocketbeagle.dts | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/ti/omap/am335x-pocketbeagle.dts b/arch/arm/boot/dts/ti/omap/am335x-pocketbeagle.dts
index 6d875cf13e09..3d7bad8bfb2f 100644
--- a/arch/arm/boot/dts/ti/omap/am335x-pocketbeagle.dts
+++ b/arch/arm/boot/dts/ti/omap/am335x-pocketbeagle.dts
@@ -214,7 +214,7 @@ &am33xx_pinmux {
 	pinctrl-names = "default";
 
 	pinctrl-0 =   < &P2_03_gpio &P1_34_gpio &P2_19_gpio &P2_24_gpio
-			&P2_33_gpio &P2_22_gpio             &P2_10_gpio
+			&P2_33_gpio &P2_22_gpio &P2_20_gpio &P2_10_gpio
 			&P2_06_gpio &P2_04_gpio &P2_02_gpio &P2_08_gpio
 			&P2_17_gpio >;
 
@@ -272,6 +272,16 @@ AM33XX_PADCONF(AM335X_PIN_GPMC_AD14, PIN_INPUT_PULLUP, MUX_MODE7)
 		pinctrl-single,bias-pulldown   = < 0x10  0x00  0x10  0x18>;
 	};
 
+	/* P2_20 (ZCZ ball T13) gpio2_00 0x888 */
+	P2_20_gpio: P2-20-gpio-pins {
+		pinctrl-single,pins = <
+			AM33XX_PADCONF(AM335X_PIN_GPMC_CSN3, PIN_INPUT_PULLUP, MUX_MODE7)
+		>;
+		pinctrl-single,bias-pullup   =   < 0x10  0x10  0x00  0x18>;
+		pinctrl-single,bias-pulldown   = < 0x10  0x00  0x10  0x18>;
+	};
+
+
 	/* P2_10 (ZCZ ball R14) gpio1_20 0x850 PIN 20 */
 	P2_10_gpio: P2-10-gpio-pins {
 		pinctrl-single,pins = <
-- 
2.41.0.327.gaa9166bcc0ba

