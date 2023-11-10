Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CF207E75F2
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 01:30:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345493AbjKJAai (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 19:30:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbjKJAag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 19:30:36 -0500
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40E542D7C;
        Thu,  9 Nov 2023 16:30:34 -0800 (PST)
Received: from local
        by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.96.2)
        (envelope-from <daniel@makrotopia.org>)
        id 1r1FPd-00041W-2M;
        Fri, 10 Nov 2023 00:30:17 +0000
Date:   Fri, 10 Nov 2023 00:30:13 +0000
From:   Daniel Golle <daniel@makrotopia.org>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH 1/2] dt-bindings: watchdog: mediatek,mtk-wdt: add MT7988
 watchdog and toprgu
Message-ID: <6912f6f406bc45674020681184f3eeca2f2cb63f.1699576174.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding description for mediatek,mt7988-wdt.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 .../bindings/watchdog/mediatek,mtk-wdt.yaml          |  1 +
 include/dt-bindings/reset/mediatek,mt7988-resets.h   | 12 ++++++++++++
 2 files changed, 13 insertions(+)
 create mode 100644 include/dt-bindings/reset/mediatek,mt7988-resets.h

diff --git a/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml b/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml
index cc502838bc398..8d2520241e37f 100644
--- a/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml
+++ b/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml
@@ -25,6 +25,7 @@ properties:
           - mediatek,mt6735-wdt
           - mediatek,mt6795-wdt
           - mediatek,mt7986-wdt
+          - mediatek,mt7988-wdt
           - mediatek,mt8183-wdt
           - mediatek,mt8186-wdt
           - mediatek,mt8188-wdt
diff --git a/include/dt-bindings/reset/mediatek,mt7988-resets.h b/include/dt-bindings/reset/mediatek,mt7988-resets.h
new file mode 100644
index 0000000000000..fa7c937505e08
--- /dev/null
+++ b/include/dt-bindings/reset/mediatek,mt7988-resets.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+
+/* TOPRGU resets */
+#define MT7988_TOPRGU_SGMII0_GRST		1
+#define MT7988_TOPRGU_SGMII1_GRST		2
+#define MT7988_TOPRGU_XFI0_GRST			12
+#define MT7988_TOPRGU_XFI1_GRST			13
+#define MT7988_TOPRGU_XFI_PEXTP0_GRST		14
+#define MT7988_TOPRGU_XFI_PEXTP1_GRST		15
+#define MT7988_TOPRGU_XFI_PLL_GRST		16
+
+#define MT7988_TOPRGU_SW_RST_NUM		24
-- 
2.42.1
