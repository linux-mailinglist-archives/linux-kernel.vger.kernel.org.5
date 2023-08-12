Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D64A779EF8
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 12:27:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236960AbjHLK03 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 06:26:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234007AbjHLK0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 06:26:10 -0400
Received: from mx.skole.hr (mx2.hosting.skole.hr [161.53.165.186])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E0201704;
        Sat, 12 Aug 2023 03:26:13 -0700 (PDT)
Received: from mx2.hosting.skole.hr (localhost.localdomain [127.0.0.1])
        by mx.skole.hr (mx.skole.hr) with ESMTP id EBCAF837F2;
        Sat, 12 Aug 2023 12:26:11 +0200 (CEST)
From:   =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Date:   Sat, 12 Aug 2023 12:25:10 +0200
Subject: [PATCH v5 6/8] arm64: Kconfig.platforms: Add config for Marvell
 PXA1908 platform
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230812-pxa1908-lkml-v5-6-a5d51937ee34@skole.hr>
References: <20230812-pxa1908-lkml-v5-0-a5d51937ee34@skole.hr>
In-Reply-To: <20230812-pxa1908-lkml-v5-0-a5d51937ee34@skole.hr>
To:     Robert Jarzmik <robert.jarzmik@free.fr>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-hardening@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        afaerber@suse.de
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=848;
 i=duje.mihanovic@skole.hr; h=from:subject:message-id;
 bh=K6I9lXtf30xSOvsxE9fkWjCqX0AGrXtNgHt2czd7+94=;
 b=owEBbQKS/ZANAwAIAZoRnrBCLZbhAcsmYgBk114EO7TqSTw8G9Ebsmlb2JG3Uy1eEEN9sPWbH
 WsMek4PoYCJAjMEAAEIAB0WIQRT351NnD/hEPs2LXiaEZ6wQi2W4QUCZNdeBAAKCRCaEZ6wQi2W
 4VWDD/40ZLaqsFYssomtMGEj/B+GRvNRCtUOxFRjTfiHs0lnBBb8HpOq0sCUK3Wx7GuLPl0F0Vy
 uM90VGckMRWTYPDQ5h/UEoGEFlECV5qkg96gw43B4WN3g1PGRXf2gvrzk1q+V6lPog1xiwCV6Jm
 RFLi9eVn+GEAOPE04NPbXZyeszsaSrKDSwFNagCplxI+YW0mDEuegiG17I92N917R9fKL7cVU/4
 4YhRM4wWQ3OynuuSbHJAPZsCtqwvl1OysRIAZA4zpkWgP2Wvs9J6srUgPCA77oUpGIS7zrItR6e
 egILeJaoC8hbzfcSqwS9KABmpkQHh0U4vjkaqBBizk5rwgxs92NyJGvA2VajAFrquTDhvl88fkQ
 MwjcHkZ2zUCBu33OZnCu8EY/j9rTavuIIZ3npEUEISnGimIbODd25J6veMDm5s+YPSjGEACQRAk
 mF0k/CS50V5dfNwSM+h3RvI0CvSPS0W4/T+iMRJMehQXMX5Ed7XqJqf6rxbFg0b3ICMAvKO+LJi
 nHle5LXibSHYWwVDqqp2wGB7kpAfE/sRFVRj3N+2FPBrjhdkEnr/IjMaRPu/r0AMrrRyzjE42L1
 aHwPoC3vde5uVL6KI5efgbHBr45sdQbbJG4ea0jEmf71p4Vj+rDACFYo1krrco24jxo+nSL49qO
 tVUzvMrBgiBFG/g==
X-Developer-Key: i=duje.mihanovic@skole.hr; a=openpgp;
 fpr=53DF9D4D9C3FE110FB362D789A119EB0422D96E1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add ARCH_MMP configuration option for Marvell PXA1908 SoC.

Signed-off-by: Duje Mihanović <duje.mihanovic@skole.hr>
---
 arch/arm64/Kconfig.platforms | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 6069120199bb..b417cae42c84 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -89,6 +89,17 @@ config ARCH_BERLIN
 	help
 	  This enables support for Marvell Berlin SoC Family
 
+config ARCH_MMP
+	bool "Marvell MMP SoC Family"
+	select ARM_GIC
+	select ARM_ARCH_TIMER
+	select ARM_SMMU
+	select MMP_PDMA
+	select PINCTRL_SINGLE
+	help
+	  This enables support for Marvell MMP SoC family, currently
+	  supporting PXA1908 aka IAP140.
+
 config ARCH_BITMAIN
 	bool "Bitmain SoC Platforms"
 	help

-- 
2.41.0


