Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13DD9779EC9
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 12:04:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236901AbjHLKEE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 06:04:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236696AbjHLKEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 06:04:00 -0400
Received: from mx.skole.hr (mx2.hosting.skole.hr [161.53.165.186])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 890BA270F;
        Sat, 12 Aug 2023 03:04:01 -0700 (PDT)
Received: from mx2.hosting.skole.hr (localhost.localdomain [127.0.0.1])
        by mx.skole.hr (mx.skole.hr) with ESMTP id E5D09840B7;
        Sat, 12 Aug 2023 12:03:59 +0200 (CEST)
From:   =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Date:   Sat, 12 Aug 2023 12:02:59 +0200
Subject: [PATCH v2 4/4] clk: pxa910: Move number of clocks to driver source
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230812-mmp-nr-clks-v2-4-f9271bd7eaa5@skole.hr>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1446;
 i=duje.mihanovic@skole.hr; h=from:subject:message-id;
 bh=bly1aASdWUJrlcyrZt3WskO9eN5tVF6cUHmmrzJg8UU=;
 b=owEBbQKS/ZANAwAIAZoRnrBCLZbhAcsmYgBk11jWEzZpwoDieY1YVAjCCH1x1xQXehidFWpgq
 9H8atPlLVyJAjMEAAEIAB0WIQRT351NnD/hEPs2LXiaEZ6wQi2W4QUCZNdY1gAKCRCaEZ6wQi2W
 4aU3EACpydUl/5i56ATj+xlOLPRCc36f2rPxfP21b+/QyAbvWaxA/rXvGLfxK228tosn19KyJJ+
 JGWWdoqUaNJiqGuS3kWtpRSPPgf4xyIPEanXIC88bzPMqWzhhlIlFM4srEnWS6VzF9jW0Oqgtdo
 2mpzowTqJhfMqQ5wRLhLjSPZOE758itKWnqrQablk9Tu6P/aMsm1woeQIcLAQuEnJJ2G/SyS9ZQ
 OVrfONAOgYclLrJmt3j3QoyijRB7nTYVebVhuojA5lwe6JPKMhnE9XmUmm3a8WqNiQs2POuCwKA
 j/XXkgROsNeUr9nxusVyYysq9hujHyZkxDNxh03hqRhz/98oaJ6d+pie4AaOzuG+9hnWX8WSRg6
 m3dftv/PkQBYMbRQpK0fRsuF5EJKJafCrrj9LkgxLfP1urwvy8Oq8PLdUH75OLB8yVUq0LOlW4Q
 i63OBSLMbUHTNSeH9jEJHtUaws4nSpzoJFSyxlCZXd5stfib4MGrzapCeVej5meczyTl/4M3h+a
 YCLWdl3a06UQdALASKps8obG1JJB2wGYLpTZ7zFK9Ua2Z2Yp7HaLXjU8ZxJuizulrliFypptz5H
 8YSPrUcq997X0VIJsWBk4Q8Pm2D6lTHzv+KUSpXe7ishnDAf/slnHyfMIiV/iNWtXB3nH7GNFR8
 Y7/C71m4wMYMCkQ==
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


