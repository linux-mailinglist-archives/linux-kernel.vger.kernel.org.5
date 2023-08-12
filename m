Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83815779ECB
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 12:09:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236937AbjHLKEI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 06:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236477AbjHLKEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 06:04:00 -0400
Received: from mx.skole.hr (mx2.hosting.skole.hr [161.53.165.186])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3782E2133;
        Sat, 12 Aug 2023 03:04:01 -0700 (PDT)
Received: from mx2.hosting.skole.hr (localhost.localdomain [127.0.0.1])
        by mx.skole.hr (mx.skole.hr) with ESMTP id 2872883E84;
        Sat, 12 Aug 2023 12:03:59 +0200 (CEST)
From:   =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Date:   Sat, 12 Aug 2023 12:02:57 +0200
Subject: [PATCH v2 2/4] clk: pxa168: Move number of clocks to driver source
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230812-mmp-nr-clks-v2-2-f9271bd7eaa5@skole.hr>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1430;
 i=duje.mihanovic@skole.hr; h=from:subject:message-id;
 bh=An6utDAacc3cFI4LMImvW0yjAueMtmC2mjBjATMsvVg=;
 b=owEBbQKS/ZANAwAIAZoRnrBCLZbhAcsmYgBk11jVacXgBMCH8q35Ann7jSg4TfdyzeLHaY9hW
 aq5Nk9+YY+JAjMEAAEIAB0WIQRT351NnD/hEPs2LXiaEZ6wQi2W4QUCZNdY1QAKCRCaEZ6wQi2W
 4W7CD/9tICbRAnT159blHcf0W3+F7HJR4nZQ2+CD2Zas6PoasMq4zkdWmJjScbBSDbDWA3wLehN
 Gf3LCIgtdad8CnUmziNhGXgets10EmMXL3piOofJa8PLr9BPZP41Fr7Q91/xUPO/PgK8foSpGRF
 DdSKvELZz31Y5x+frC0cwpBlmtXpbqLk6onC5ncPu00SpZmU3LZ/hV5bglUOPR6r+h8aw1vcqBX
 B2DEvTmjtJaAh6/Sr6Wu6qCLF3fDvf/kkOINLCCoB0RraC6ekFTjV5v87O51GATFpjPCyYs6GCp
 pfLUAO2NZKZom8PEYBNfOSbzEes/6E5x25ETMCFqB1JtwTIDfRE77AzEjKVtHMD02MXC6Cx1+2S
 6LabpuBmrn/f2KBdzGem4tdIKvdxT2xvfFYpKkfSb6oCqk3BDGVKgQSBKnj8F/Kf3ak1EPZrAKo
 3hQ4WzHxQ9sEaXJ7yutPVTV0r9fDVu1hTJnsgBC3n6h4H70KkXdMql96wWgXqJmAL2JH7izAYIr
 uM68CTOCoHaIk5GMXEwCZ1vkRQeHU5ATj6XesWF3Qa5o5MdhwGvvX4ge84yRxJ/5r6tWGsW+roa
 NZa7ZgdU6HNSsQGIE/rENTIE8x+bhTuCDZgVNsfI2e/gx3HvYZz4fmC1lb3S/4/Grk2E9Ap2hSA
 W0dToQ+tuGKi2Kw==
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
 drivers/clk/mmp/clk-of-pxa168.c            | 4 +++-
 include/dt-bindings/clock/marvell,pxa168.h | 1 -
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/mmp/clk-of-pxa168.c b/drivers/clk/mmp/clk-of-pxa168.c
index 130d1a723879..fb0df64cf053 100644
--- a/drivers/clk/mmp/clk-of-pxa168.c
+++ b/drivers/clk/mmp/clk-of-pxa168.c
@@ -62,6 +62,8 @@
 #define APMU_EPD	0x104
 #define MPMU_UART_PLL	0x14
 
+#define NR_CLKS		200
+
 struct pxa168_clk_unit {
 	struct mmp_clk_unit unit;
 	void __iomem *mpmu_base;
@@ -321,7 +323,7 @@ static void __init pxa168_clk_init(struct device_node *np)
 		return;
 	}
 
-	mmp_clk_init(np, &pxa_unit->unit, PXA168_NR_CLKS);
+	mmp_clk_init(np, &pxa_unit->unit, NR_CLKS);
 
 	pxa168_pll_init(pxa_unit);
 
diff --git a/include/dt-bindings/clock/marvell,pxa168.h b/include/dt-bindings/clock/marvell,pxa168.h
index c92d969ae941..d1bb59187e1d 100644
--- a/include/dt-bindings/clock/marvell,pxa168.h
+++ b/include/dt-bindings/clock/marvell,pxa168.h
@@ -63,5 +63,4 @@
 #define PXA168_CLK_SDH01_AXI		111
 #define PXA168_CLK_SDH23_AXI		112
 
-#define PXA168_NR_CLKS			200
 #endif

-- 
2.41.0


