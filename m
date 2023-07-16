Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1447A75588A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 00:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231327AbjGPWIf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 18:08:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232186AbjGPWIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 18:08:10 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53C05DF;
        Sun, 16 Jul 2023 15:08:09 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4fbbfaacfc1so6038361e87.1;
        Sun, 16 Jul 2023 15:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689545287; x=1692137287;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BRuqOpK0EekPSITqQINTY+JRczLmYXbl+EYLdJCsn+M=;
        b=U7Ty7kCIUKc+y0mYLry2J3cBRyWd44XiBd7tgbCbFJUBnviG+Im4Fq7j732oX/W2kb
         Hyr9GxBO9tO7hPPKABuN4PLaJpDIisAl6JTCpaXPZGz1bIMKsUFrP+FVXNBy7+R3TEUQ
         T3nbSwqP35BicPN6cBn+eyqSBkhnLn3RZrvhIqqyyc3NEhvUYTFGoweO+ahaQc58K7PW
         41WDoiwBJmqbTLIasqkEOGsYFILarVxHaIKVCREgZ7uryuRNP8+VewgKFUB0yQr1kzZq
         s+7bJM1FvFH7cBWPT1lKX+pV8Ky3KGhfQ+yG+qVXOKWs2ehRt+euEZ+P4AN1Oxa4YjFs
         O4Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689545287; x=1692137287;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BRuqOpK0EekPSITqQINTY+JRczLmYXbl+EYLdJCsn+M=;
        b=BmnYNIRDcDIDOiSpChKgC4JnRNgHf5eeb49HdtJ9BFNFlGoKNApq1ByuVzfwJz9LVO
         ChHckj6Zn2/LfSS1+/s9iKiw3QJIBhSkHUvhAxDR65AHSZ4nnR8p0MkSDCXavziTxS/F
         7tDoxw10BL7N5UtrwRWMp01a9mcg9c+amn3bEWlIWyTq0/Owlfd4KhFyQDSTTRumK4H0
         n/F48R3gu+8E95tu6XKS+YKnfkufFALyhFjBzMgCcrtJcg3lcAFlNZ4ta1cgXjVBDO2n
         Sp3y4suDHs1S/81tjvRCGYna1q3eZlTCR3G1giHfxYO2GvQEOuHm4ZK3XSynFKKSzitp
         9j2Q==
X-Gm-Message-State: ABy/qLbucMKaPgUdn+ULi/cttS4by7kf2ZWR/V5e31ojYpNmUZHd1Boh
        fioJOP1foLacvkyjiV9rEzk=
X-Google-Smtp-Source: APBJJlEGrMjcsJb1IJWGNtvK7PtPxfRlh2ETvy31xSMPdNilQykqlVigCiLS59PbC2LH3XWryooYIw==
X-Received: by 2002:a05:6512:2249:b0:4fa:79da:ca8a with SMTP id i9-20020a056512224900b004fa79daca8amr9543736lfu.7.1689545287499;
        Sun, 16 Jul 2023 15:08:07 -0700 (PDT)
Received: from localhost.localdomain ([62.122.67.26])
        by smtp.gmail.com with ESMTPSA id h24-20020a197018000000b004fb9c625b4asm2464091lfc.210.2023.07.16.15.08.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Jul 2023 15:08:07 -0700 (PDT)
From:   Markuss Broks <markuss.broks@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Markuss Broks <markuss.broks@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 6/7] ARM: dts: exynos: k3g: Document the devices which are not supported
Date:   Mon, 17 Jul 2023 01:05:08 +0300
Message-ID: <20230716220644.22158-8-markuss.broks@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716220644.22158-1-markuss.broks@gmail.com>
References: <20230716220644.22158-1-markuss.broks@gmail.com>
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

Add placeholders for peripherals which we currently lack support for.
This includes Maxim MAX86900 heart rate sensor and oximeter, which
seems to be similar to other health sensors by Maxim, but it is not
fully compatible; STM32F401 MCU which acts like a sensor hub,
which can be flashed and controlled via the SPI bus, for which I made
some simple firmware to check if it's possible to program with custom
code, and it appears you can do so, but at the moment kernel lacks
the APIs to either control sensors directly through the MCU or any
standards for a sensor hub, so it's laid off; WM5110 audio codec which
fails to communicate for some reason.

Signed-off-by: Markuss Broks <markuss.broks@gmail.com>
---
 arch/arm/boot/dts/exynos5422-samsung-k3g.dts | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5422-samsung-k3g.dts b/arch/arm/boot/dts/exynos5422-samsung-k3g.dts
index 813dbf0438de..e019b630db94 100644
--- a/arch/arm/boot/dts/exynos5422-samsung-k3g.dts
+++ b/arch/arm/boot/dts/exynos5422-samsung-k3g.dts
@@ -743,6 +743,24 @@ rmi4-f12@12 {
 	};
 };
 
+&i2c_3 {
+	status = "okay";
+
+	/* Maxim MAX86900 heart rate sensor and oximeter on address 0x57 */
+};
+
+&spi_0 {
+	status = "okay";
+
+	/* STMicroelectronics STM32F401 MCU to which sensors are connected */
+};
+
+&spi_2 {
+	status = "okay";
+
+	/* Wolfson WM5110 audio codec */
+};
+
 /* eMMC flash */
 &mmc_0 {
 	status = "okay";
-- 
2.41.0

