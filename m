Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 725F3775EBB
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 14:19:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232202AbjHIMTf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 08:19:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232091AbjHIMTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 08:19:31 -0400
Received: from mx.skole.hr (mx1.hosting.skole.hr [161.53.165.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E092210B;
        Wed,  9 Aug 2023 05:19:29 -0700 (PDT)
Received: from mx1.hosting.skole.hr (localhost.localdomain [127.0.0.1])
        by mx.skole.hr (mx.skole.hr) with ESMTP id 68FCF8204C;
        Wed,  9 Aug 2023 14:19:17 +0200 (CEST)
From:   =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Date:   Wed, 09 Aug 2023 14:18:20 +0200
Subject: [PATCH 2/4] clk: pxa168: Move number of clocks to driver source
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230809-mmp-nr-clks-v1-2-5f3cdbbb89b8@skole.hr>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1430;
 i=duje.mihanovic@skole.hr; h=from:subject:message-id;
 bh=An6utDAacc3cFI4LMImvW0yjAueMtmC2mjBjATMsvVg=;
 b=owEBbQKS/ZANAwAIAZoRnrBCLZbhAcsmYgBk04QNpWdvajP/z7XySnWfGr9UXKA9459TP6c/s
 bNeutL+DAqJAjMEAAEIAB0WIQRT351NnD/hEPs2LXiaEZ6wQi2W4QUCZNOEDQAKCRCaEZ6wQi2W
 4dbzD/9velvKcYOjizs1meWWtviWo5O4HXhnGdw8t3g2zg1vQLImABN5JUwYU2/fxSW8cI1jmUn
 l12X3UttA1jPsEJuD8InsOBYO0CQuVVvMpLcDgD1kxdoZ/wDKrFw3v7nlG6ZUeJKBYPVah7ZB0F
 DoTwbRz7gvcjDE4XRePvGYEkqzjbKDoT+Ok/dzIYz85/RHY9wWj565mPI+8dcsbBUNkZjCz8+v0
 4h0vlA+EBWUDphmNuYpzefiS5LymuHAqoQROd0/FGiqg2sjMBp9CznrvMTcUcd5Gz4IbF6jihqn
 b3Hl6s4ESksNeSrODW32plVsG/NiAqBB9bRvZjmFZwQr6kDlWZ0nKd0wbWLTpBAqTAUn6ylMXOM
 DhlCutMlAV15joBXY1d13fANsxtu7gyN8TPF7+BUSOJb9lXac2Sxj96oVKETcrun9IaY2wYiJO8
 00r1EmhWIFVbpSlvwMe49sHJeWhVhdMGCcAdoxeAIvGdHqeb5cidZA+obgWIKnI+iRwyQ1LAUlw
 2Xfw23+r8M1tKUyyYAKBDDXTJYCSXoFBwBRzrfv42kEDJbqOjmYcmVv+zrcVDkTTAzsS9N74XOR
 0GI2VqRQn4ch0cI5JAwPKmw9e95RbjrRS4NuZO+EJRucEQmamDMCBylBSXD9mxTpnhBCEJK1YJS
 cjnJGvGnOziIvKw==
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


