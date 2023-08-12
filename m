Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C15F4779ECF
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 12:09:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236947AbjHLKEL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 06:04:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236795AbjHLKEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 06:04:01 -0400
Received: from mx.skole.hr (mx1.hosting.skole.hr [161.53.165.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57E5E270E;
        Sat, 12 Aug 2023 03:04:01 -0700 (PDT)
Received: from mx1.hosting.skole.hr (localhost.localdomain [127.0.0.1])
        by mx.skole.hr (mx.skole.hr) with ESMTP id DD37982AB3;
        Sat, 12 Aug 2023 12:03:58 +0200 (CEST)
From:   =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Date:   Sat, 12 Aug 2023 12:02:56 +0200
Subject: [PATCH v2 1/4] clk: mmp2: Move number of clocks to driver source
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230812-mmp-nr-clks-v2-1-f9271bd7eaa5@skole.hr>
References: <20230812-mmp-nr-clks-v2-0-f9271bd7eaa5@skole.hr>
In-Reply-To: <20230812-mmp-nr-clks-v2-0-f9271bd7eaa5@skole.hr>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3125;
 i=duje.mihanovic@skole.hr; h=from:subject:message-id;
 bh=OkibwBVVmPOS86JuJy1nP74HMH++zpeePkBpCC9BLWs=;
 b=owEBbQKS/ZANAwAIAZoRnrBCLZbhAcsmYgBk11jVfn9xj4Jow1iguD2wlx7KSJh33+NrXykP1
 6Wet9GBf1OJAjMEAAEIAB0WIQRT351NnD/hEPs2LXiaEZ6wQi2W4QUCZNdY1QAKCRCaEZ6wQi2W
 4frSD/wINp9tKj4DAF5hF0Gkx62Wd1HUBI2wskzhmLBCpIs6VTatt7MIWzjgM9AdFFYlF0xxylB
 BANEFhiY+gMwU4RZtbBopYzfL/r1jHc9WJ6wvis43K0DFTE+uJXrgy1idtkdMCtlqoEvktHGFu5
 +9DodTcE95a3dyfggcxZjKOFg0ODsxhcS82h2tCeL4PwGTsnYILFYY0anyJZCIXNvINwzBXXhbd
 P6Gwphn3rLt9lC0744QEPp4Q9F16n7ZfmTSwHoiVY9yvJor1eoWszRlXUz6b6AAkUjTy8MHKGez
 ZRMMJDCbJVecjo2xVvYM3/2XVRRmKPZBJaTTSSQ6blfl3L20WiMVrPsDHyH5bJWv77tmjkuebpA
 GdFBZqRuqqfFKM/dszRvC0z9hPzgqL035ETDrbXepv8ugruulzlW0ZkFe6mXA/wZYUffe0FpCA/
 Lg53DcCZDKWr9h0ENkuPl/IzQDJLJRSet80kx8G50sJPELhFQ4qHZFpitT8+9x3Tuvc9KGXWJyv
 rJyxFBNdnZhhUeX6n0Edqy/bZTejX3V5gCT54epfDPHsrafXe/GHRX98IqLFNF/04KbvEsXAtAo
 6n3p3OvkE8bzVUXHUwB82xO/3mGlnmDMxnHDECpJFYyF8Z0oDeMjVpVSg4C4mQnGdTmOQRyDC4r
 TgUb8H0HNfI700g==
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

The number of clocks should not be in the dt binding as it is not used
by the respective device tree and thus needlessly bloats the ABI.

Move this number of clocks into the driver source.

Signed-off-by: Duje Mihanović <duje.mihanovic@skole.hr>
---
 drivers/clk/mmp/clk-audio.c                    | 6 ++++--
 drivers/clk/mmp/clk-of-mmp2.c                  | 4 +++-
 include/dt-bindings/clock/marvell,mmp2-audio.h | 1 -
 include/dt-bindings/clock/marvell,mmp2.h       | 1 -
 4 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/mmp/clk-audio.c b/drivers/clk/mmp/clk-audio.c
index 6fb1aa9487b5..ae521aaf8cdc 100644
--- a/drivers/clk/mmp/clk-audio.c
+++ b/drivers/clk/mmp/clk-audio.c
@@ -55,6 +55,8 @@
 #define SSPA_AUD_PLL_CTRL1_DIV_OCLK_PATTERN_MASK (0x7ff << 0)
 #define SSPA_AUD_PLL_CTRL1_DIV_OCLK_PATTERN(x)	((x) << 0)
 
+#define CLK_AUDIO_NR_CLKS			3
+
 struct mmp2_audio_clk {
 	void __iomem *mmio_base;
 
@@ -336,7 +338,7 @@ static int register_clocks(struct mmp2_audio_clk *priv, struct device *dev)
 	priv->clk_data.hws[MMP2_CLK_AUDIO_SYSCLK] = &priv->sysclk_gate.hw;
 	priv->clk_data.hws[MMP2_CLK_AUDIO_SSPA0] = &priv->sspa0_gate.hw;
 	priv->clk_data.hws[MMP2_CLK_AUDIO_SSPA1] = &priv->sspa1_gate.hw;
-	priv->clk_data.num = MMP2_CLK_AUDIO_NR_CLKS;
+	priv->clk_data.num = CLK_AUDIO_NR_CLKS;
 
 	return of_clk_add_hw_provider(dev->of_node, of_clk_hw_onecell_get,
 				      &priv->clk_data);
@@ -349,7 +351,7 @@ static int mmp2_audio_clk_probe(struct platform_device *pdev)
 
 	priv = devm_kzalloc(&pdev->dev,
 			    struct_size(priv, clk_data.hws,
-					MMP2_CLK_AUDIO_NR_CLKS),
+					CLK_AUDIO_NR_CLKS),
 			    GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
diff --git a/drivers/clk/mmp/clk-of-mmp2.c b/drivers/clk/mmp/clk-of-mmp2.c
index bcf60f43aa13..eaad36ee323d 100644
--- a/drivers/clk/mmp/clk-of-mmp2.c
+++ b/drivers/clk/mmp/clk-of-mmp2.c
@@ -78,6 +78,8 @@
 #define MPMU_PLL_DIFF_CTRL	0x68
 #define MPMU_PLL2_CTRL1		0x414
 
+#define NR_CLKS		200
+
 enum mmp2_clk_model {
 	CLK_MODEL_MMP2,
 	CLK_MODEL_MMP3,
@@ -543,7 +545,7 @@ static void __init mmp2_clk_init(struct device_node *np)
 
 	mmp2_pm_domain_init(np, pxa_unit);
 
-	mmp_clk_init(np, &pxa_unit->unit, MMP2_NR_CLKS);
+	mmp_clk_init(np, &pxa_unit->unit, NR_CLKS);
 
 	mmp2_main_clk_init(pxa_unit);
 
diff --git a/include/dt-bindings/clock/marvell,mmp2-audio.h b/include/dt-bindings/clock/marvell,mmp2-audio.h
index 20664776f497..9653e04dedc3 100644
--- a/include/dt-bindings/clock/marvell,mmp2-audio.h
+++ b/include/dt-bindings/clock/marvell,mmp2-audio.h
@@ -6,5 +6,4 @@
 #define MMP2_CLK_AUDIO_SSPA0		1
 #define MMP2_CLK_AUDIO_SSPA1		2
 
-#define MMP2_CLK_AUDIO_NR_CLKS		3
 #endif
diff --git a/include/dt-bindings/clock/marvell,mmp2.h b/include/dt-bindings/clock/marvell,mmp2.h
index f0819d66b230..88c2d716476f 100644
--- a/include/dt-bindings/clock/marvell,mmp2.h
+++ b/include/dt-bindings/clock/marvell,mmp2.h
@@ -91,5 +91,4 @@
 #define MMP3_CLK_SDH4			126
 #define MMP2_CLK_AUDIO			127
 
-#define MMP2_NR_CLKS			200
 #endif

-- 
2.41.0


