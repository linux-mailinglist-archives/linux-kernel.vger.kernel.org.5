Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93F117FA458
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 16:25:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233873AbjK0PZK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 10:25:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233863AbjK0PZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 10:25:08 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1917DAA
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 07:25:15 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <auto@pengutronix.de>)
        id 1r7dTr-0001YD-Bb; Mon, 27 Nov 2023 16:25:03 +0100
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <auto@pengutronix.de>)
        id 1r7dTq-00ByRy-2v; Mon, 27 Nov 2023 16:25:02 +0100
Received: from rhi by dude04.red.stw.pengutronix.de with local (Exim 4.96)
        (envelope-from <auto@pengutronix.de>)
        id 1r7dTq-00CvQv-05;
        Mon, 27 Nov 2023 16:25:02 +0100
From:   Roland Hieber <rhi@pengutronix.de>
Date:   Mon, 27 Nov 2023 16:24:44 +0100
Subject: [PATCH] dt-bindings: serial: add assigned-clock-parents and
 assigned-clocks properties
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231127-b4-dt-bindings-serial-v1-1-422a198fd91a@pengutronix.de>
X-B4-Tracking: v=1; b=H4sIALu0ZGUC/x3N0QrCMAyF4VcZuTawtkrFVxEv0jVugRKlcSKMv
 bvRy//Ax9nAuAsbXIYNOr/F5KEe4TDAtJDOjFK9IY4xhRAzliPWFxbRKjob/jg1POc0hpo5xRO
 B20LGWDrptLjWtTUfn53v8vmfXW/7/gWZ3xm3fAAAAA==
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
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

Add the "assigned-clock-parents" and "assigned-clocks" properties used
by board device trees to set the UART root clock source.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Roland Hieber <rhi@pengutronix.de>
---
 Documentation/devicetree/bindings/serial/fsl-imx-uart.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/fsl-imx-uart.yaml b/Documentation/devicetree/bindings/serial/fsl-imx-uart.yaml
index 83035553044a..41bf8264488d 100644
--- a/Documentation/devicetree/bindings/serial/fsl-imx-uart.yaml
+++ b/Documentation/devicetree/bindings/serial/fsl-imx-uart.yaml
@@ -103,6 +103,12 @@ properties:
       are sensible for most use cases. If you need low latency processing on
       slow connections this needs to be configured appropriately.
 
+  assigned-clock-parents:
+    maxItems: 1
+
+  assigned-clocks:
+    maxItems: 1
+
 required:
   - compatible
   - reg

---
base-commit: 2cc14f52aeb78ce3f29677c2de1f06c0e91471ab
change-id: 20231127-b4-dt-bindings-serial-87301d7e325a

Best regards,
-- 
Roland Hieber, Pengutronix e.K.          | r.hieber@pengutronix.de     |
Steuerwalder Str. 21                     | https://www.pengutronix.de/ |
31137 Hildesheim, Germany                | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686         | Fax:   +49-5121-206917-5555 |

