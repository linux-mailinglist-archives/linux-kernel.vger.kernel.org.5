Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DC947729A9
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 17:45:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231282AbjHGPpB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 11:45:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231197AbjHGPot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 11:44:49 -0400
Received: from mx.skole.hr (mx2.hosting.skole.hr [161.53.165.186])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7E3BC2;
        Mon,  7 Aug 2023 08:44:47 -0700 (PDT)
Received: from mx2.hosting.skole.hr (localhost.localdomain [127.0.0.1])
        by mx.skole.hr (mx.skole.hr) with ESMTP id 48F5384B48;
        Mon,  7 Aug 2023 17:44:46 +0200 (CEST)
From:   =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Date:   Mon, 07 Aug 2023 17:42:40 +0200
Subject: [PATCH v4 6/8] arm64: Kconfig.platforms: Add config for Marvell
 PXA1908 platform
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230807-pxa1908-lkml-v4-6-cb387d73b452@skole.hr>
References: <20230807-pxa1908-lkml-v4-0-cb387d73b452@skole.hr>
In-Reply-To: <20230807-pxa1908-lkml-v4-0-cb387d73b452@skole.hr>
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
 b=owEBbQKS/ZANAwAIAZoRnrBCLZbhAcsmYgBk0REyf3v7NJ8uiNSdfF3a3XGBKVMkrb4TLSLGk
 iEjzPNHqxaJAjMEAAEIAB0WIQRT351NnD/hEPs2LXiaEZ6wQi2W4QUCZNERMgAKCRCaEZ6wQi2W
 4WFND/4/alEbq0lBtJZLtUo95LQspP5GWeofCQfGu5mSvtBFdbValbvFr5Ri1oIB0p9aR2J0UwT
 XqOiXgC8GhDBu/UrKrskK7M8PnuzMvMdnTc3gegNXjy4KJS09Oo8/7xAOAskjynzqBTZUpL00oS
 Ic7y6dHPo+HPbHDt5FSAVd2LMKcmCzHTUFPlF8HeeEnNYVagwFOGytSV0sjF8h/m81sKIoHeLoA
 KFBkTuUsGWXTEUhC1Xa+Zqex3Ci4T8yHavM1pgkvFVdMj3Kux95jmX7J0z9DiGEtbozadXjpw3H
 sdGSR+2W6ykiJ5j4W6mOpNsEmwyr+OCfKy16fa7Rf7W3wA1L8vWOje4VtvleJlwJF+fazp0LgzO
 9K3Ju5KiUmZTHGs7H3GKbrHkW8UVBzFdVZB/ODi9t92L2kvbHUM7tNbVtfSx32F24CQyuHn3yWj
 aDx/phVE9w7kOMOQd7LDy9zifwjQUyC5EKD8TzeP7T9pmozKZQvZ5ts2f2IcAw6lBBnoVhOypMC
 3Xede8tNH1xUdG8hTErsptA50Ytt+37P6/EJZ36EWend5cS7qtZ75VezgWWy/vLXUSL5dFXiLP3
 rjUfs/JEECKwAGPiOe4Jxawfg2RflxcA52ncgDvzVBvzoNPMf/LF/DHxlxC4m7vwD++7YLPuhvf
 LZOzlu4PbUSYQcA==
X-Developer-Key: i=duje.mihanovic@skole.hr; a=openpgp;
 fpr=53DF9D4D9C3FE110FB362D789A119EB0422D96E1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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


