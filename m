Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 913D0775EB5
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 14:19:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231873AbjHIMTh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 08:19:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232113AbjHIMTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 08:19:31 -0400
Received: from mx.skole.hr (mx1.hosting.skole.hr [161.53.165.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DECA2109;
        Wed,  9 Aug 2023 05:19:29 -0700 (PDT)
Received: from mx1.hosting.skole.hr (localhost.localdomain [127.0.0.1])
        by mx.skole.hr (mx.skole.hr) with ESMTP id 25FAB82603;
        Wed,  9 Aug 2023 14:19:18 +0200 (CEST)
From:   =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Date:   Wed, 09 Aug 2023 14:18:22 +0200
Subject: [PATCH 4/4] clk: pxa910: Move number of clocks to driver source
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230809-mmp-nr-clks-v1-4-5f3cdbbb89b8@skole.hr>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1446;
 i=duje.mihanovic@skole.hr; h=from:subject:message-id;
 bh=bly1aASdWUJrlcyrZt3WskO9eN5tVF6cUHmmrzJg8UU=;
 b=owEBbQKS/ZANAwAIAZoRnrBCLZbhAcsmYgBk04QNmYDh7YmjSg5s2ALFQwFpva0+VjPXx+Xpu
 UjoAsNRMNCJAjMEAAEIAB0WIQRT351NnD/hEPs2LXiaEZ6wQi2W4QUCZNOEDQAKCRCaEZ6wQi2W
 4RCDD/4paakr48mXfzlpws91TeOR5Q4WRf+h/9Ca6KwgacTLoAWJYyn+XvZTpSiCqca1ufpvcOc
 b8YKDNsW8sDgdBDqEKBbN54TXz46+EpRSK3Veg0uaRgGGpKjUW1Fw1CprZftn8fXg0HeVw7w9ox
 H5xaje6WWP6IiABVykeCz+GbHMPBJOzoHeneCircT8p/n93lpbkoShDZ+BwI5omQuZS/2TCVpu2
 CccIlM/xH0h3oRIzy0oPRFCkhqxMvkrN9Kb+GJ/wpCT4yhY/iHtpiZMJ6G4JTiPndEdl1iWSwg8
 B+o0FS+DO5LBqrEv3D8ta/9iLf8IycyoiofOLcd1WJ4ybhcIWQ6V/39ESUhd5T72N50CQGtJ6JY
 E7mQgbZ81j89ojslCRatT0NzXrrR4KslwM8du9Y/Rmpn/3ziHVoIlh6igqKm+RzE4o8/4EVLeOj
 mpv+uTxib/fKk0uFXrLUCXbHwce8zQUsLrOrV/yNGitlaxTZGni/n2Ewy0lMC8eUAvFJ3GevBdz
 hcHfwsBZk3rcq2Ow1dK7UTHIw9WU7bVj4YLGZtU+TCF7FwEemY0AxJLXyXKFe5WmbfRL2r+B2wt
 tnB+eVK3NSmI6xdGKJwEGyGlAm20iqtD3dQPxT0MUiy885NSh4xT4JJxRw/GdHwPo2VFzkFv2Rj
 7sLxBtQlgDYlXfg==
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
 drivers/clk/mmp/clk-of-pxa910.c            | 4 +++-
 include/dt-bindings/clock/marvell,pxa910.h | 1 -
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/mmp/clk-of-pxa910.c b/drivers/clk/mmp/clk-of-pxa910.c
index 4d15bac987eb..7a38c424782e 100644
--- a/drivers/clk/mmp/clk-of-pxa910.c
+++ b/drivers/clk/mmp/clk-of-pxa910.c
@@ -44,6 +44,8 @@
 #define APMU_DFC	0x60
 #define MPMU_UART_PLL	0x14
 
+#define NR_CLKS		200
+
 struct pxa910_clk_unit {
 	struct mmp_clk_unit unit;
 	void __iomem *mpmu_base;
@@ -296,7 +298,7 @@ static void __init pxa910_clk_init(struct device_node *np)
 		goto unmap_apbc_region;
 	}
 
-	mmp_clk_init(np, &pxa_unit->unit, PXA910_NR_CLKS);
+	mmp_clk_init(np, &pxa_unit->unit, NR_CLKS);
 
 	pxa910_pll_init(pxa_unit);
 
diff --git a/include/dt-bindings/clock/marvell,pxa910.h b/include/dt-bindings/clock/marvell,pxa910.h
index c9018ab354d0..6caa231de0c1 100644
--- a/include/dt-bindings/clock/marvell,pxa910.h
+++ b/include/dt-bindings/clock/marvell,pxa910.h
@@ -55,5 +55,4 @@
 #define PXA910_CLK_CCIC0_PHY		108
 #define PXA910_CLK_CCIC0_SPHY		109
 
-#define PXA910_NR_CLKS			200
 #endif

-- 
2.41.0


