Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5550A775EB3
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 14:19:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231924AbjHIMTX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 08:19:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbjHIMTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 08:19:22 -0400
Received: from mx.skole.hr (mx2.hosting.skole.hr [161.53.165.186])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECAAE1BF7;
        Wed,  9 Aug 2023 05:19:19 -0700 (PDT)
Received: from mx2.hosting.skole.hr (localhost.localdomain [127.0.0.1])
        by mx.skole.hr (mx.skole.hr) with ESMTP id C8B1783F5D;
        Wed,  9 Aug 2023 14:19:17 +0200 (CEST)
From:   =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Date:   Wed, 09 Aug 2023 14:18:21 +0200
Subject: [PATCH 3/4] clk: pxa1928: Move number of clocks to driver source
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230809-mmp-nr-clks-v1-3-5f3cdbbb89b8@skole.hr>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1992;
 i=duje.mihanovic@skole.hr; h=from:subject:message-id;
 bh=vj5z83mXAuP8rLNNCZ7zCFdduTpLvT0Y/0PeXHVxG9c=;
 b=owEBbQKS/ZANAwAIAZoRnrBCLZbhAcsmYgBk04QN4DPOcksfQN1gHtXTGtV42+LmKHM8ZFlac
 2wZJbxxaFSJAjMEAAEIAB0WIQRT351NnD/hEPs2LXiaEZ6wQi2W4QUCZNOEDQAKCRCaEZ6wQi2W
 4fPlEACJdM+yAEY20T/jBY5c8Rjo0lr9xJY+wRM9oVvSgMp+/z24JC5TKM7+tAi5YAZbC9R1JfL
 dAafLE9setQy3CdSbVUkWncgpWK2qA5OoP7VUh8kbqR5JMPQ/W68mU1uPNb81/nb8L8uxdDwjgy
 sID1eP/I7QSwpEKtVlGAYMd8C3lTlMVbdt3jLL1+iulNxmrFGieG48VGkmxttoq6HtkMLkaFZ3s
 Wl6i/24WFK1PAQybk6YYEEk0chdd8GwBVVEyikqkvQdgB573jsURMR+QM2EYQrk0I5rD0bSpF3t
 /NGYCR6UthmowqUwUFwnOa/rCbVfmTJkevGablipUIm7kES29dNpu3XJWySZEyLx3csAk2dliXI
 96w7l6hXG6bdfrmbHBI0+EKo+E/8GQ1or0CyDEs41exqOdITBi7AVyJAPM0fMYyVoU5nTlV7ll2
 2JQBNb1VutQawZW0tFmu23DtDlYv2RZ8CgNWxFlaBuii1VR51EK6m5lieWgWwlmj/SL1bZCTsmz
 uJmADINBGQdbYjkGnWkewvKqGmpnsYLQYbT1LwRg+/X2vw2eaQRkXvJNSjLTqTyoxJLnxMkhCmu
 6zUAs/NzU0F7ZOyINDrmnDodzseKLFUHgh7S/e7EB+3l3HB1VW/GgBLsc5gLBG2Y5WHci75IMmc
 oKlIDR72iSftwLg==
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
 drivers/clk/mmp/clk-of-pxa1928.c            | 7 +++++--
 include/dt-bindings/clock/marvell,pxa1928.h | 3 ---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/mmp/clk-of-pxa1928.c b/drivers/clk/mmp/clk-of-pxa1928.c
index 2508a0d795f8..9def4b5f10e9 100644
--- a/drivers/clk/mmp/clk-of-pxa1928.c
+++ b/drivers/clk/mmp/clk-of-pxa1928.c
@@ -22,6 +22,9 @@
 
 #define MPMU_UART_PLL	0x14
 
+#define APBC_NR_CLKS	48
+#define APMU_NR_CLKS	96
+
 struct pxa1928_clk_unit {
 	struct mmp_clk_unit unit;
 	void __iomem *mpmu_base;
@@ -235,7 +238,7 @@ static void __init pxa1928_apmu_clk_init(struct device_node *np)
 		return;
 	}
 
-	mmp_clk_init(np, &pxa_unit->unit, PXA1928_APMU_NR_CLKS);
+	mmp_clk_init(np, &pxa_unit->unit, APMU_NR_CLKS);
 
 	pxa1928_axi_periph_clk_init(pxa_unit);
 }
@@ -256,7 +259,7 @@ static void __init pxa1928_apbc_clk_init(struct device_node *np)
 		return;
 	}
 
-	mmp_clk_init(np, &pxa_unit->unit, PXA1928_APBC_NR_CLKS);
+	mmp_clk_init(np, &pxa_unit->unit, APBC_NR_CLKS);
 
 	pxa1928_apb_periph_clk_init(pxa_unit);
 	pxa1928_clk_reset_init(np, pxa_unit);
diff --git a/include/dt-bindings/clock/marvell,pxa1928.h b/include/dt-bindings/clock/marvell,pxa1928.h
index 5dca4820297f..0c708d3d3314 100644
--- a/include/dt-bindings/clock/marvell,pxa1928.h
+++ b/include/dt-bindings/clock/marvell,pxa1928.h
@@ -36,7 +36,6 @@
 #define PXA1928_CLK_THSENS_CPU		0x26
 #define PXA1928_CLK_THSENS_VPU		0x27
 #define PXA1928_CLK_THSENS_GC		0x28
-#define PXA1928_APBC_NR_CLKS		0x30
 
 
 /* axi peripherals */
@@ -53,6 +52,4 @@
 #define PXA1928_CLK_GC3D		0x5d
 #define PXA1928_CLK_GC2D		0x5f
 
-#define PXA1928_APMU_NR_CLKS		0x60
-
 #endif

-- 
2.41.0


