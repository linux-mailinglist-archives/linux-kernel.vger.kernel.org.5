Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD8637701D9
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 15:35:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231263AbjHDNfS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 09:35:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbjHDNey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 09:34:54 -0400
Received: from mx.skole.hr (mx2.hosting.skole.hr [161.53.165.186])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F8861BD5;
        Fri,  4 Aug 2023 06:34:46 -0700 (PDT)
Received: from mx2.hosting.skole.hr (localhost.localdomain [127.0.0.1])
        by mx.skole.hr (mx.skole.hr) with ESMTP id 6F5948537B;
        Fri,  4 Aug 2023 15:34:45 +0200 (CEST)
From:   =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Date:   Fri, 04 Aug 2023 15:32:36 +0200
Subject: [PATCH v3 6/8] arm64: Kconfig.platforms: Add config for Marvell
 PXA1908 platform
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230804-pxa1908-lkml-v3-6-8e48fca37099@skole.hr>
References: <20230804-pxa1908-lkml-v3-0-8e48fca37099@skole.hr>
In-Reply-To: <20230804-pxa1908-lkml-v3-0-8e48fca37099@skole.hr>
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
 b=owEBbQKS/ZANAwAIAZoRnrBCLZbhAcsmYgBkzP48e5lTAjjCoUAR/5HEQBzBJzdztsqDfxexF
 jYOc5c/x6iJAjMEAAEIAB0WIQRT351NnD/hEPs2LXiaEZ6wQi2W4QUCZMz+PAAKCRCaEZ6wQi2W
 4fikEACh0+8LIgbsoTlr5lxBuNQumDwQB9NG5tkj6ze/c141bkcUrR/oAVGlateOCExL7C+7xM0
 pjSmwXb3M1OxbEgPL5/I9KaFncVEE2/tR4FKA5GoVoRiD87zlt7MPu6tTXR4QxaKE/gOU8G183e
 /PtaCMcNVtXfqkx4OUkbq3Hxtl0JqKLEvsj76cqbFTSiXH74CDreqeY80BAv1c/AyfjQdpvgl5I
 zk/Xex1U4jZLr0kjQs7EOr9qbuUI1KgN34CZVjMilg577FOnMwp+vcBwkkBTkuaWADUHpYae9SR
 JcaIdWK75oslEpzMgJ9xy2c8vLKbM297z/zJcbjI63WvKoliBR2CEknyyMAnflPIjsFqS9XmKpb
 MRvekVcQuxIOrGGzZIcvGrTlKQUNa7Fx3vngvuugfvME0Scsa9SHvh0r1PgBbrRLaw2v90ctM1k
 wO57uqr46LUPN9HyqOlic/FAX6DtGpDYASu0EM64szi6oajmVDK0WZeMOFzGcQerHmWwFcMJyDt
 /w4FL8KjyTQ5eFXdyLF+yxAFiv1j74BcN9jbhaCzgkEkbGB6+FBAbcSq/atToyOJhFcFBOmTXAl
 kV2yODiM+oOrAD5CHKCRR681LPgz/hlpAiSaPyo7mXdDOMkMBWTUyykUEDUaCFhNv2nA6Bu5B7N
 kzWH63mXQmc3reQ==
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


