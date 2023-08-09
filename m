Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19A65775EBD
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 14:19:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231727AbjHIMT0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 08:19:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbjHIMTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 08:19:22 -0400
Received: from mx.skole.hr (mx2.hosting.skole.hr [161.53.165.186])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC3DD1BF0;
        Wed,  9 Aug 2023 05:19:19 -0700 (PDT)
Received: from mx2.hosting.skole.hr (localhost.localdomain [127.0.0.1])
        by mx.skole.hr (mx.skole.hr) with ESMTP id 8AC5D84170;
        Wed,  9 Aug 2023 14:19:17 +0200 (CEST)
From:   =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Date:   Wed, 09 Aug 2023 14:18:19 +0200
Subject: [PATCH 1/4] clk: mmp2: Move number of clocks into driver source
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230809-mmp-nr-clks-v1-1-5f3cdbbb89b8@skole.hr>
References: <20230809-mmp-nr-clks-v1-0-5f3cdbbb89b8@skole.hr>
In-Reply-To: <20230809-mmp-nr-clks-v1-0-5f3cdbbb89b8@skole.hr>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2846;
 i=duje.mihanovic@skole.hr; h=from:subject:message-id;
 bh=jzio94bMPZE326BZBJ//kdSwZfjLWKOcmB3+UHo+Y6I=;
 b=owEBbQKS/ZANAwAIAZoRnrBCLZbhAcsmYgBk04QNW+bCaL13Qo6Q3f6WTyS/ST3aIFGeMhv+H
 KXGPzNx2hiJAjMEAAEIAB0WIQRT351NnD/hEPs2LXiaEZ6wQi2W4QUCZNOEDQAKCRCaEZ6wQi2W
 4bjfD/40e/vQlW1KsWjOrmzM66PS+vGJOoBkdr1jghZMKOuHDgkfUI9ugV1DO3oJnnJy13l6Met
 Oa9KKMbUCWFVBjUG2jAJOb8iiT/mzMOI4unO2KSLsdsU25tmzrbDxHmFHIwV+tgEz0J00p87xue
 sDh82pG+GxJx6qkXMFFQU7Qgr68QzVHBJ/G7S07Cp0rl/uC/Eux7ZD1neWsjF/QwuGzvE+c9Zqc
 DAPObkRFNhTVdhFVEF/WUOX8mRElC3mPEkGFQzgkS2OZRFHChL2MLUacVAOMcNAOGeRrJ64V1L2
 f8UDs+HB1SqtVN9ksnA8+wcoe4vkwX49Nlu957vz/rlsF/VfWLt2W0OjCA66KQTSBqcEXNTiF49
 aORkmgIS1CksbmUphU8Ub8aY3E4MdlARDtnxU/w6WxAQYbsEcBjGQqStBYidHZNQeQ/eAtuPLv5
 OfLl7Sctposb76uq/Nj1Q2M8WXY5vaYM6tN0IXLNDJ/A59hi1rLDMvTXw6GhBAKr5xnlFna91jJ
 MxqBoOjd/FnrjEOeEjVI7G2jYP+MDrpz8XLKRWRaDWAbaC5itIVUAagapbfSS7vNmle9i4jLz5u
 8GM2n3+KIQHssHZoXsNY13NR2UGokGgmRFhNRHj94cgm7Xq+WLAgLOVv5pihrIH35qewgDO+yo9
 hEoBX2R/niAbp6Q==
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
 drivers/clk/mmp/clk-audio.c                    | 4 +++-
 drivers/clk/mmp/clk-of-mmp2.c                  | 4 +++-
 include/dt-bindings/clock/marvell,mmp2-audio.h | 1 -
 include/dt-bindings/clock/marvell,mmp2.h       | 1 -
 4 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/mmp/clk-audio.c b/drivers/clk/mmp/clk-audio.c
index 6fb1aa9487b5..0faa02dcb96a 100644
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


