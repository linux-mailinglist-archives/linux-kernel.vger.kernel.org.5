Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 737DB7FA4EA
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 16:39:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233999AbjK0PjN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 10:39:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233957AbjK0PjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 10:39:08 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8328518F
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 07:39:14 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <auto@pengutronix.de>)
        id 1r7dhV-0004F0-BH; Mon, 27 Nov 2023 16:39:09 +0100
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <auto@pengutronix.de>)
        id 1r7dhT-00ByVl-5u; Mon, 27 Nov 2023 16:39:07 +0100
Received: from rhi by dude04.red.stw.pengutronix.de with local (Exim 4.96)
        (envelope-from <auto@pengutronix.de>)
        id 1r7dhT-00Cwfc-0O;
        Mon, 27 Nov 2023 16:39:07 +0100
From:   Roland Hieber <rhi@pengutronix.de>
Date:   Mon, 27 Nov 2023 16:38:24 +0100
Subject: [PATCH] dt-bindings: timer: fsl,imxgpt: Add fsl,imx7d-gpt
 compatible
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231127-b4-dt-bindings-timer-v1-1-e06bd6b2370b@pengutronix.de>
X-B4-Tracking: v=1; b=H4sIAO+3ZGUC/x2NQQqDQAwAvyI5N9Ddaq39Sulh10QN2LRsrAji3
 xt6nIFhdjAuwgb3aofCq5i81SGcKuinpCOjkDPEc7yEEFvMNdKCWZRER8NFXlywa+prpIG6trm
 BpzkZYy5J+8lj/c6zy0/hQbb/6/E8jh8kSc3XewAAAA==
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Roland Hieber <rhi@pengutronix.de>
X-Mailer: b4 0.12.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: auto@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Philipp Zabel <p.zabel@pengutronix.de>

Add "fsl,imx7d-gpt", "fsl,imx31-gpt", used in imx7s.dtsi, to the list of
valid compatibles.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Roland Hieber <rhi@pengutronix.de>
---
 Documentation/devicetree/bindings/timer/fsl,imxgpt.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/timer/fsl,imxgpt.yaml b/Documentation/devicetree/bindings/timer/fsl,imxgpt.yaml
index e2607377cbae..2006043b8335 100644
--- a/Documentation/devicetree/bindings/timer/fsl,imxgpt.yaml
+++ b/Documentation/devicetree/bindings/timer/fsl,imxgpt.yaml
@@ -31,6 +31,7 @@ properties:
           - enum:
               - fsl,imx6sl-gpt
               - fsl,imx6sx-gpt
+              - fsl,imx7d-gpt
               - fsl,imx8mp-gpt
               - fsl,imxrt1050-gpt
               - fsl,imxrt1170-gpt

---
base-commit: 2cc14f52aeb78ce3f29677c2de1f06c0e91471ab
change-id: 20231127-b4-dt-bindings-timer-95462dfd9758

Best regards,
-- 
Roland Hieber, Pengutronix e.K.          | rhi@pengutronix.de          |
Steuerwalder Str. 21                     | https://www.pengutronix.de/ |
31137 Hildesheim, Germany                | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686         | Fax:   +49-5121-206917-5555 |

