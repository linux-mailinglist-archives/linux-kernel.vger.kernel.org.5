Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E82880826A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 09:02:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231202AbjLGICa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 03:02:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378186AbjLGIC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 03:02:26 -0500
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9441ED59;
        Thu,  7 Dec 2023 00:02:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=NQYua
        6NYZFLIzUxdntBqoze6tV/XkUJBpYCTvdrdfWk=; b=Ww97ZnkePx5Myr1PUbBR3
        LibFvWOrunTT4V+ZtoO6TOiUe0UKXwff/sLhPh+g6d8pgUREYdgZRQB4rNDfvRe9
        bcJHPtA9+8ngSQF754vkZQ5H0z50PdHfiXuMkdEjFaLgPDKnGr7QZIz6CGgsqbQB
        h3EXf2RTs0G/hkF1PYfyzQ=
Received: from ProDesk.. (unknown [58.22.7.114])
        by zwqz-smtp-mta-g5-3 (Coremail) with SMTP id _____wCnj4zee3FlR6OuEw--.39228S2;
        Thu, 07 Dec 2023 16:01:37 +0800 (CST)
From:   Andy Yan <andyshrk@163.com>
To:     heiko@sntech.de
Cc:     hjc@rock-chips.com, dri-devel@lists.freedesktop.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, sebastian.reichel@collabora.com,
        kever.yang@rock-chips.com, chris.obbard@collabora.com,
        Andy Yan <andy.yan@rock-chips.com>
Subject: [PATCH v4 10/17] dt-bindings: display: vop2: Add rk3588 support
Date:   Thu,  7 Dec 2023 16:01:33 +0800
Message-Id: <20231207080133.652417-1-andyshrk@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231207075906.651771-1-andyshrk@163.com>
References: <20231207075906.651771-1-andyshrk@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wCnj4zee3FlR6OuEw--.39228S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxCr13WFy7XrWxWr18uF15Jwb_yoWrtw1xpa
        s3Ca18JrZ7Gr13Xr4kt3WrCw4SgF95Aw4jyrs7Xr43ta1aqFW0vF4akwn8XayUCFn7Zay2
        9FWUua4xJ3W7ZF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jw4SOUUUUU=
X-Originating-IP: [58.22.7.114]
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/xtbBEgY-XmVOA0W52QAAs4
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_BL,RCVD_IN_MSPIKE_L4,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andy Yan <andy.yan@rock-chips.com>

The vop2 on rk3588 is similar to which on rk356x
but with 4 video ports and need to reference
more grf modules.

Signed-off-by: Andy Yan <andy.yan@rock-chips.com>

---

Changes in v4:
- drop redundant description.
- use full stop at all the description's end.
- address Krzysztof's review in v3

Changes in v3:
- constrain properties in allOf:if:then
- some description updates

Changes in v2:
- fix errors when running 'make DT_CHECKER_FLAGS=-m dt_binding_check'

 .../display/rockchip/rockchip-vop2.yaml       | 100 ++++++++++++++----
 1 file changed, 81 insertions(+), 19 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/rockchip/rockchip-vop2.yaml b/Documentation/devicetree/bindings/display/rockchip/rockchip-vop2.yaml
index b60b90472d42..2531726af306 100644
--- a/Documentation/devicetree/bindings/display/rockchip/rockchip-vop2.yaml
+++ b/Documentation/devicetree/bindings/display/rockchip/rockchip-vop2.yaml
@@ -8,8 +8,8 @@ title: Rockchip SoC display controller (VOP2)
 
 description:
   VOP2 (Video Output Processor v2) is the display controller for the Rockchip
-  series of SoCs which transfers the image data from a video memory
-  buffer to an external LCD interface.
+  series of SoCs which transfers the image data from a video memory buffer to
+  an external LCD interface.
 
 maintainers:
   - Sandy Huang <hjc@rock-chips.com>
@@ -20,6 +20,7 @@ properties:
     enum:
       - rockchip,rk3566-vop
       - rockchip,rk3568-vop
+      - rockchip,rk3588-vop
 
   reg:
     items:
@@ -27,8 +28,8 @@ properties:
           Must contain one entry corresponding to the base address and length
           of the register space.
       - description:
-          Can optionally contain a second entry corresponding to
-          the CRTC gamma LUT address.
+          Can optionally contain a second entry corresponding to the CRTC gamma
+          LUT address.
 
   reg-names:
     items:
@@ -41,45 +42,63 @@ properties:
       The VOP interrupt is shared by several interrupt sources, such as
       frame start (VSYNC), line flag and other status interrupts.
 
+  # See compatible-specific constraints below.
   clocks:
+    minItems: 5
     items:
-      - description: Clock for ddr buffer transfer.
-      - description: Clock for the ahb bus to R/W the phy regs.
+      - description: Clock for ddr buffer transfer via axi.
+      - description: Clock for the ahb bus to R/W the regs.
       - description: Pixel clock for video port 0.
       - description: Pixel clock for video port 1.
       - description: Pixel clock for video port 2.
+      - description: Pixel clock for video port 3.
+      - description: Peripheral(vop grf/dsi) clock.
 
   clock-names:
+    minItems: 5
     items:
       - const: aclk
       - const: hclk
       - const: dclk_vp0
       - const: dclk_vp1
       - const: dclk_vp2
+      - const: dclk_vp3
+      - const: pclk_vop
 
   rockchip,grf:
     $ref: /schemas/types.yaml#/definitions/phandle
     description:
-      Phandle to GRF regs used for misc control
+      Phandle to GRF regs used for control the polarity of dclk/hsync/vsync of DPI,
+      also used for query vop memory bisr enable status, etc.
+
+  rockchip,vo1-grf:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Phandle to VO GRF regs used for control the polarity of dclk/hsync/vsync of hdmi
+      on rk3588.
+
+  rockchip,vop-grf:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Phandle to VOP GRF regs used for control data path between vopr and hdmi/edp.
+
+  rockchip,pmu:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Phandle to PMU GRF used for query vop memory bisr status on rk3588.
 
   ports:
     $ref: /schemas/graph.yaml#/properties/ports
 
-    properties:
-      port@0:
+    patternProperties:
+      "^port@[0-3]$":
         $ref: /schemas/graph.yaml#/properties/port
-        description:
-          Output endpoint of VP0
+        description: Output endpoint of VP0/1/2/3.
 
-      port@1:
-        $ref: /schemas/graph.yaml#/properties/port
-        description:
-          Output endpoint of VP1
+    required:
+      - port@0
 
-      port@2:
-        $ref: /schemas/graph.yaml#/properties/port
-        description:
-          Output endpoint of VP2
+    unevaluatedProperties: false
 
   iommus:
     maxItems: 1
@@ -96,6 +115,49 @@ required:
   - clock-names
   - ports
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: rockchip,rk3588-vop
+    then:
+      properties:
+        clocks:
+          minItems: 7
+        clock-names:
+          minItems: 7
+
+        ports:
+          required:
+            - port@0
+            - port@1
+            - port@2
+            - port@3
+
+      required:
+        - rockchip,grf
+        - rockchip,vo1-grf
+        - rockchip,vop-grf
+        - rockchip,pmu
+
+    else:
+      properties:
+        rockchip,vo1-grf: false
+        rockchip,vop-grf: false
+        rockchip,pmu: false
+
+        clocks:
+          maxItems: 5
+        clock-names:
+          maxItems: 5
+
+        ports:
+          required:
+            - port@0
+            - port@1
+            - port@2
+
 additionalProperties: false
 
 examples:
-- 
2.34.1

