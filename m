Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80C677E9F64
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 15:59:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231225AbjKMO7g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 09:59:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbjKMO7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 09:59:35 -0500
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B650CD68;
        Mon, 13 Nov 2023 06:59:30 -0800 (PST)
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
        by mail11.truemail.it (Postfix) with ESMTPA id B0C57207BF;
        Mon, 13 Nov 2023 15:59:26 +0100 (CET)
From:   Francesco Dolcini <francesco@dolcini.it>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Piyush Mehta <piyush.mehta@amd.com>,
        Michal Simek <michal.simek@amd.com>
Cc:     Stefan Eichenberger <stefan.eichenberger@toradex.com>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: [PATCH v1 1/2] dt-bindings: usb: microchip,usb5744: Add second supply
Date:   Mon, 13 Nov 2023 15:59:20 +0100
Message-Id: <20231113145921.30104-2-francesco@dolcini.it>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231113145921.30104-1-francesco@dolcini.it>
References: <20231113145921.30104-1-francesco@dolcini.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Eichenberger <stefan.eichenberger@toradex.com>

The USB5744 has two power supplies one for 3V3 and one for 1V2. Add the
second supply to the USB5744 DT binding.

Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
 .../devicetree/bindings/usb/microchip,usb5744.yaml         | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/usb/microchip,usb5744.yaml b/Documentation/devicetree/bindings/usb/microchip,usb5744.yaml
index ff3a1707ef57..6d4cfd943f58 100644
--- a/Documentation/devicetree/bindings/usb/microchip,usb5744.yaml
+++ b/Documentation/devicetree/bindings/usb/microchip,usb5744.yaml
@@ -36,7 +36,11 @@ properties:
 
   vdd-supply:
     description:
-      VDD power supply to the hub
+      3V3 power supply to the hub
+
+  vdd2-supply:
+    description:
+      1V2 power supply to the hub
 
   peer-hub:
     $ref: /schemas/types.yaml#/definitions/phandle
@@ -62,6 +66,7 @@ allOf:
       properties:
         reset-gpios: false
         vdd-supply: false
+        vdd2-supply: false
         peer-hub: false
         i2c-bus: false
     else:
-- 
2.25.1

