Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01A877AE0C3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 23:28:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233410AbjIYV2M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 17:28:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233157AbjIYV2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 17:28:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C41AA11C
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 14:28:00 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CFE8C433CA;
        Mon, 25 Sep 2023 21:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695677280;
        bh=/O3CPAN/HC+aJwYPv4Gy4+9esRpB0kLO0vBTmNz9WPc=;
        h=From:To:Cc:Subject:Date:From;
        b=JoJn+1u8Q6A2ET+C1mL8s3BDRWYdDAk6Tzsxyj/GtRfXrq5MQRvGDXrtUOKbSixCc
         U1vg6A4YsNkifiVEL6u1kC/FWTY6wHEwgsVeBQhbUYR5JW3QXmkS6xO9BUJDyN0pOB
         t9sQgTXx/CQRlYucZkgOitprFi4Ttpa26X1EvS1eRGFSXKLjDTTbR46z9NDM+AFJfu
         /VtM0mgb2HdzO0ybi97omBUfEw19cWpCvenkIBQBfdVm/fqk26tbme+fW9jt1WDU6h
         oxxVzDn99Jg3LR8dOBjxw/iTrG3awSXNXc97dgOmHEswX2ydYxAYGKMHAcjHUHQM8g
         zwRB+Ja/jg0Lw==
Received: (nullmailer pid 1976712 invoked by uid 1000);
        Mon, 25 Sep 2023 21:27:53 -0000
From:   Rob Herring <robh@kernel.org>
To:     Lee Jones <lee@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Flora Fu <flora.fu@mediatek.com>,
        Alexandre Mergnat <amergnat@baylibre.com>,
        Chris Zhong <zyw@rock-chips.com>,
        Zhang Qing <zhangqing@rock-chips.com>,
        - Keerthy <j-keerthy@ti.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: [PATCH] dt-bindings: mfd: Add missing unevaluatedProperties on child node schemas
Date:   Mon, 25 Sep 2023 16:27:24 -0500
Message-Id: <20230925212729.1976117-1-robh@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just as unevaluatedProperties or additionalProperties are required at
the top level of schemas, they should (and will) also be required for
child node schemas. That ensures only documented properties are
present for any node.

Add unevaluatedProperties as needed, and then add any missing properties
flagged by the addition.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/mfd/maxim,max5970.yaml   | 5 +++++
 Documentation/devicetree/bindings/mfd/mediatek,mt6357.yaml | 2 ++
 Documentation/devicetree/bindings/mfd/rockchip,rk805.yaml  | 1 +
 Documentation/devicetree/bindings/mfd/rockchip,rk808.yaml  | 1 +
 Documentation/devicetree/bindings/mfd/rockchip,rk809.yaml  | 3 ++-
 Documentation/devicetree/bindings/mfd/rockchip,rk818.yaml  | 1 +
 Documentation/devicetree/bindings/mfd/ti,lp87524-q1.yaml   | 1 +
 Documentation/devicetree/bindings/mfd/ti,lp87561-q1.yaml   | 1 +
 Documentation/devicetree/bindings/mfd/ti,lp87565-q1.yaml   | 1 +
 9 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mfd/maxim,max5970.yaml b/Documentation/devicetree/bindings/mfd/maxim,max5970.yaml
index da67742c5aa9..0da5cae3852e 100644
--- a/Documentation/devicetree/bindings/mfd/maxim,max5970.yaml
+++ b/Documentation/devicetree/bindings/mfd/maxim,max5970.yaml
@@ -45,8 +45,13 @@ properties:
     patternProperties:
       "^led@[0-3]$":
         $ref: /schemas/leds/common.yaml#
+        unevaluatedProperties: false
         type: object
 
+        properties:
+          reg:
+            maximum: 3
+
     additionalProperties: false
 
   vss1-supply:
diff --git a/Documentation/devicetree/bindings/mfd/mediatek,mt6357.yaml b/Documentation/devicetree/bindings/mfd/mediatek,mt6357.yaml
index fc2a53148e1c..37423c2e0fdf 100644
--- a/Documentation/devicetree/bindings/mfd/mediatek,mt6357.yaml
+++ b/Documentation/devicetree/bindings/mfd/mediatek,mt6357.yaml
@@ -40,6 +40,7 @@ properties:
   regulators:
     type: object
     $ref: /schemas/regulator/mediatek,mt6357-regulator.yaml
+    unevaluatedProperties: false
     description:
       List of MT6357 BUCKs and LDOs regulators.
 
@@ -59,6 +60,7 @@ properties:
   keys:
     type: object
     $ref: /schemas/input/mediatek,pmic-keys.yaml
+    unevaluatedProperties: false
     description:
       MT6357 power and home keys.
 
diff --git a/Documentation/devicetree/bindings/mfd/rockchip,rk805.yaml b/Documentation/devicetree/bindings/mfd/rockchip,rk805.yaml
index 4992f71b6fc3..af6cd1969c22 100644
--- a/Documentation/devicetree/bindings/mfd/rockchip,rk805.yaml
+++ b/Documentation/devicetree/bindings/mfd/rockchip,rk805.yaml
@@ -80,6 +80,7 @@ properties:
       "^(DCDC_REG[1-4]|LDO_REG[1-3])$":
         type: object
         $ref: ../regulator/regulator.yaml#
+        unevaluatedProperties: false
     unevaluatedProperties: false
 
 allOf:
diff --git a/Documentation/devicetree/bindings/mfd/rockchip,rk808.yaml b/Documentation/devicetree/bindings/mfd/rockchip,rk808.yaml
index f5908fa01a61..8a16d651c2a3 100644
--- a/Documentation/devicetree/bindings/mfd/rockchip,rk808.yaml
+++ b/Documentation/devicetree/bindings/mfd/rockchip,rk808.yaml
@@ -107,6 +107,7 @@ properties:
       "^(DCDC_REG[1-4]|LDO_REG[1-8]|SWITCH_REG[1-2])$":
         type: object
         $ref: ../regulator/regulator.yaml#
+        unevaluatedProperties: false
     unevaluatedProperties: false
 
 required:
diff --git a/Documentation/devicetree/bindings/mfd/rockchip,rk809.yaml b/Documentation/devicetree/bindings/mfd/rockchip,rk809.yaml
index 7fb849ac74a7..e922e0176ee7 100644
--- a/Documentation/devicetree/bindings/mfd/rockchip,rk809.yaml
+++ b/Documentation/devicetree/bindings/mfd/rockchip,rk809.yaml
@@ -86,7 +86,8 @@ properties:
     patternProperties:
       "^(LDO_REG[1-9]|DCDC_REG[1-5]|SWITCH_REG[1-2])$":
         type: object
-        $ref: ../regulator/regulator.yaml#
+        $ref: /schemas/regulator/regulator.yaml#
+        unevaluatedProperties: false
     unevaluatedProperties: false
 
 allOf:
diff --git a/Documentation/devicetree/bindings/mfd/rockchip,rk818.yaml b/Documentation/devicetree/bindings/mfd/rockchip,rk818.yaml
index b57c4b005cf4..ee5bca6e75df 100644
--- a/Documentation/devicetree/bindings/mfd/rockchip,rk818.yaml
+++ b/Documentation/devicetree/bindings/mfd/rockchip,rk818.yaml
@@ -99,6 +99,7 @@ properties:
       "^(DCDC_REG[1-4]|DCDC_BOOST|LDO_REG[1-9]|SWITCH_REG|HDMI_SWITCH|OTG_SWITCH)$":
         type: object
         $ref: ../regulator/regulator.yaml#
+        unevaluatedProperties: false
     unevaluatedProperties: false
 
 required:
diff --git a/Documentation/devicetree/bindings/mfd/ti,lp87524-q1.yaml b/Documentation/devicetree/bindings/mfd/ti,lp87524-q1.yaml
index f6cac4b1079c..ae149eb8593d 100644
--- a/Documentation/devicetree/bindings/mfd/ti,lp87524-q1.yaml
+++ b/Documentation/devicetree/bindings/mfd/ti,lp87524-q1.yaml
@@ -37,6 +37,7 @@ properties:
       "^buck[0123]$":
         type: object
         $ref: /schemas/regulator/regulator.yaml#
+        unevaluatedProperties: false
 
     required:
       - buck0
diff --git a/Documentation/devicetree/bindings/mfd/ti,lp87561-q1.yaml b/Documentation/devicetree/bindings/mfd/ti,lp87561-q1.yaml
index dc5a29b5ef7d..5167d6eb904a 100644
--- a/Documentation/devicetree/bindings/mfd/ti,lp87561-q1.yaml
+++ b/Documentation/devicetree/bindings/mfd/ti,lp87561-q1.yaml
@@ -41,6 +41,7 @@ properties:
       buck3210:
         type: object
         $ref: /schemas/regulator/regulator.yaml#
+        unevaluatedProperties: false
 
     required:
       - buck3210
diff --git a/Documentation/devicetree/bindings/mfd/ti,lp87565-q1.yaml b/Documentation/devicetree/bindings/mfd/ti,lp87565-q1.yaml
index 012d25111054..eca430edf608 100644
--- a/Documentation/devicetree/bindings/mfd/ti,lp87565-q1.yaml
+++ b/Documentation/devicetree/bindings/mfd/ti,lp87565-q1.yaml
@@ -47,6 +47,7 @@ properties:
       "^buck(10|23)$":
         type: object
         $ref: /schemas/regulator/regulator.yaml#
+        unevaluatedProperties: false
 
     required:
       - buck10
-- 
2.40.1

