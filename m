Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C522779EC2
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 12:04:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236861AbjHLKEC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 06:04:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjHLKEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 06:04:00 -0400
Received: from mx.skole.hr (mx1.hosting.skole.hr [161.53.165.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53B20270C;
        Sat, 12 Aug 2023 03:04:01 -0700 (PDT)
Received: from mx1.hosting.skole.hr (localhost.localdomain [127.0.0.1])
        by mx.skole.hr (mx.skole.hr) with ESMTP id A6FF882AB0;
        Sat, 12 Aug 2023 12:03:59 +0200 (CEST)
From:   =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Date:   Sat, 12 Aug 2023 12:02:58 +0200
Subject: [PATCH v2 3/4] clk: pxa1928: Move number of clocks to driver
 source
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230812-mmp-nr-clks-v2-3-f9271bd7eaa5@skole.hr>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1992;
 i=duje.mihanovic@skole.hr; h=from:subject:message-id;
 bh=vj5z83mXAuP8rLNNCZ7zCFdduTpLvT0Y/0PeXHVxG9c=;
 b=owEBbQKS/ZANAwAIAZoRnrBCLZbhAcsmYgBk11jV9whohEZlGCSdDYIjemFxugN5NczZpN1ZA
 CKnMNJC34KJAjMEAAEIAB0WIQRT351NnD/hEPs2LXiaEZ6wQi2W4QUCZNdY1QAKCRCaEZ6wQi2W
 4ZRUEACE6nVHtpRqZdkY4HQcfyRo2UT+c4yTTQMzMedutz8+YAfRsMc9fkbiFs4V31oAi4VoFye
 RAmXBCWrbvBQ6SJo28/y8fweKU7V11YynE/vCZpVtfgx6dT0p62mFeIl2xOpRkdHYbnknQbGdg/
 S8dn8HuGsiy+7sIGKeVZ2FoIJh42jYEfIUtj0V2EVSGrKX7laiV7UCbCFqsRU/7DiXP2rjUY/gC
 hvIyMosuxXBMyqqPqw4sDXMTXTG/ov4A0fMiBSiSJ+qz+gyS6gHkSNs3tudwsldUDiVDfI+5daS
 qxPUsdkMbnBY4TZX1p0oq3NocMXR6gFhTsflKozEpyCxwW30vShp0Y5/v0OsrMTGWwYNAF47SD6
 FkCCxQBDiTSwjftVK/uvguZYkbhUQAqJ9FmO2NpcCLfjwVW7ezbQ3FylrVjKE1Fsmf8+78edFZO
 7xe0rj1a3ebEr4+ePdgf38G9TbmPYXz2UKHthHqwhs3QFWZhMzOA+7e+IP7VBQSXaAALQZ+qWbd
 XnHTHREncrr1upIl2xlEuu0hanK/3hEMcJvy8Eadb/lgMXsBB+oI2CXQQc+fCOWkUliHdnFqiq9
 fFGj+Ll1KWfoM9arXOHRnkMB5u5jnERIHlaE87RsvpoTHn3O+JNf/Q/S1YipnRIFb/sH+dyJnzH
 kSv/wNNUrNf35fw==
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


