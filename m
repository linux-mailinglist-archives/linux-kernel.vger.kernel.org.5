Return-Path: <linux-kernel+bounces-59905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FA7C84FD31
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 20:52:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C39391C217B2
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 19:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E2108612C;
	Fri,  9 Feb 2024 19:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="JMUrxCMs"
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B6B8287F;
	Fri,  9 Feb 2024 19:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707508324; cv=none; b=NTc0IRSwuc2kwiyQBcqQU+HTYP+UjBn1mqwli9dfRzULD3AEtMuyLE+Hrt4DqKe2HU8ngebZjIgtRagOg9FRcR9NjJp9/mn1JA9AiyewArM3ACHrlz2kowMijTuNUOnumW9JIUTZIfOh7CqJEl7PjkI3JP2FcFjduRAU6P8RU9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707508324; c=relaxed/simple;
	bh=unvBtpLHUheErnIKuC5CMeD69T0uQbVY/SGTBdB+g0U=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=UEikkKRMctjDQjyw3QyCKI3p9YReFoiJUb0Yi62U2hSmgsSynk7ZIDIz0H+TUcyGaCtMCGgzz2V5zT8K0I248glN41mpvOSnJPQrvSrCIOrtUGNCTiS9BBfzXZnfda6glKU9OvWYLptFsIEpJbljLnGjnhqpQVCJ+1dIs/8MoEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz; spf=pass smtp.mailfrom=ucw.cz; dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b=JMUrxCMs; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 011EF1C007B; Fri,  9 Feb 2024 20:51:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1707508318;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=Ny+g2e13pmZv7Yo5SjMa3WZIQ31wU3t+J1RaxEjrmqM=;
	b=JMUrxCMsV2ApsnaGENG9H45CYl4pppFwlzdtHgCYMtbqbHZxErktHfdvVHNUMjZdyyXMk4
	xU1XdKr0dMFjHtkIsqBiJEsiVNyE8zbAJTy8n1W34gVc8wuZYAPzt+GeAjoPrYKMU5X61m
	H1r+1MixruzO+x6Re7jxUice9taqy7U=
Date: Fri, 9 Feb 2024 20:51:57 +0100
From: Pavel Machek <pavel@ucw.cz>
To: phone-devel@vger.kernel.org, kernel list <linux-kernel@vger.kernel.org>,
	fiona.klute@gmx.de, martijn@brixit.nl, samuel@sholland.org,
	heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
	megi@xff.cz
Subject: [PATCH] dt-bindings: usb: typec: anx7688: start a binding document
Message-ID: <ZcaCXYOf6o4VNneu@duo.ucw.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="f/OLU4NS4fD0/sqi"
Content-Disposition: inline


--f/OLU4NS4fD0/sqi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Add binding for anx7688 usb type-c bridge. I don't have a datasheet,
but I did best I could.

Signed-off-by: Pavel Machek <pavel@ucw.cz>

diff --git a/Documentation/devicetree/bindings/usb/analogix,anx7688.yaml b/=
Documentation/devicetree/bindings/usb/analogix,anx7688.yaml
new file mode 100644
index 000000000000..b9d60586937f
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/analogix,anx7688.yaml
@@ -0,0 +1,140 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/usb/analogix,anx7688.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analogix ANX7688 Type-C controller
+
+maintainers:
+  - Pavel Machek <pavel@ucw.cz>
+
+properties:
+  compatible:
+    enum:
+      - analogix,anx7688
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  reset-gpios:
+    maxItems: 1
+  enable-gpios:
+    maxItems: 1
+  cabledet-gpios:
+    maxItems: 1
+
+  avdd10-supply:
+    description:
+      1.0V power supply
+  dvdd10-supply:
+    description:
+      1.0V power supply
+  avdd18-supply:
+    description:
+      1.8V power supply
+  dvdd18-supply:
+    description:
+      1.8V power supply
+  avdd33-supply:
+    description:
+      3.3V power supply
+  i2c-supply:
+    description:
+      Power supply
+  vconn-supply:
+    description:
+      Power supply
+  hdmi_vt-supply:
+    description:
+      Power supply
+
+  vbus-supply:
+    description:
+      Power supply
+  vbus_in-supply:
+    description:
+      Power supply
+
+  connector:
+    type: object
+    $ref: ../connector/usb-connector.yaml
+    unevaluatedProperties: false
+
+    description:
+      Properties for usb c connector.
+
+    properties:
+      compatible:
+        const: usb-c-connector
+
+      power-role: true
+
+      data-role: true
+
+      try-power-role: true
+
+    required:
+      - compatible
+
+required:
+  - compatible
+  - reg
+  - connector
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/gpio/gpio.h>
+
+    i2c {
+        #address-cells =3D <1>;
+        #size-cells =3D <0>;
+
+        typec@2c {
+            compatible =3D "analogix,anx7688";
+            reg =3D <0x2c>;
+            interrupts =3D <8 IRQ_TYPE_EDGE_FALLING>;
+            interrupt-parent =3D <&gpio0>;
+
+            enable-gpios =3D <&pio 3 10 GPIO_ACTIVE_LOW>; /* PD10 */
+            reset-gpios =3D <&pio 3 6 GPIO_ACTIVE_HIGH>; /* PD6 */
+            cabledet-gpios =3D <&r_pio 0 8 GPIO_ACTIVE_HIGH>; /* PL8 */
+
+            avdd10-supply =3D <&reg_anx1v0>;
+            dvdd10-supply =3D <&reg_anx1v0>;
+            avdd18-supply =3D <&reg_ldo_io1>;
+            dvdd18-supply =3D <&reg_ldo_io1>;
+            avdd33-supply =3D <&reg_dcdc1>;
+            i2c-supply =3D <&reg_ldo_io0>;
+            vconn-supply =3D <&reg_vconn5v0>;
+            hdmi_vt-supply =3D <&reg_dldo1>;
+
+            vbus-supply =3D <&reg_usb_5v>;
+            vbus_in-supply =3D <&usb_power_supply>;
+
+            typec_con: connector {
+                compatible =3D "usb-c-connector";
+                power-role =3D "dual";
+                data-role =3D "dual";
+                try-power-role =3D "source";
+
+                ports {
+                    #address-cells =3D <1>;
+                    #size-cells =3D <0>;
+                    port@0 {
+                        reg =3D <0>;
+                        typec_con_ep: endpoint {
+                            remote-endpoint =3D <&usbotg_hs_ep>;
+                        };
+                    };
+                };
+            };
+        };
+    };
+...
diff --git a/Documentation/devicetree/bindings/usb/generic-xhci.yaml b/Docu=
mentation/devicetree/bindings/usb/generic-xhci.yaml
index 594ebb3ee432..6ceafa4af292 100644
--- a/Documentation/devicetree/bindings/usb/generic-xhci.yaml
+++ b/Documentation/devicetree/bindings/usb/generic-xhci.yaml
@@ -9,9 +9,6 @@ title: USB xHCI Controller
 maintainers:
   - Mathias Nyman <mathias.nyman@intel.com>
=20
-allOf:
-  - $ref: usb-xhci.yaml#
-
 properties:
   compatible:
     oneOf:
@@ -25,6 +22,11 @@ properties:
               - marvell,armada-380-xhci
               - marvell,armada-8k-xhci
           - const: generic-xhci
+      - description: Broadcom SoCs with power domains
+        items:
+          - enum:
+              - brcm,bcm2711-xhci
+          - const: brcm,xhci-brcm-v2
       - description: Broadcom STB SoCs with xHCI
         enum:
           - brcm,xhci-brcm-v2
@@ -49,6 +51,9 @@ properties:
       - const: core
       - const: reg
=20
+  power-domains:
+    maxItems: 1
+
 unevaluatedProperties: false
=20
 required:
@@ -56,6 +61,20 @@ required:
   - reg
   - interrupts
=20
+allOf:
+  - $ref: usb-xhci.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: brcm,bcm2711-xhci
+    then:
+      required:
+        - power-domains
+    else:
+      properties:
+        power-domains: false
+
 examples:
   - |
     usb@f0931000 {
diff --git a/Documentation/devicetree/bindings/usb/genesys,gl850g.yaml b/Do=
cumentation/devicetree/bindings/usb/genesys,gl850g.yaml
index ee08b9c3721f..37cf5249e526 100644
--- a/Documentation/devicetree/bindings/usb/genesys,gl850g.yaml
+++ b/Documentation/devicetree/bindings/usb/genesys,gl850g.yaml
@@ -29,6 +29,11 @@ properties:
     description:
       the regulator that provides 3.3V core power to the hub.
=20
+  peer-hub:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      phandle to the peer hub on the controller.
+
 required:
   - compatible
   - reg
diff --git a/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml b=
/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml
index e9644e333d78..924fd3d748a8 100644
--- a/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml
+++ b/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml
@@ -124,6 +124,17 @@ properties:
       defined in the xHCI spec on MTK's controller.
     default: 5000
=20
+  rx-fifo-depth:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      It is a quirk used to work around Gen1 isoc-in endpoint transfer iss=
ue
+      that still send out unexpected ACK after device finishes the burst
+      transfer with a short packet and cause an exception, specially on a =
4K
+      camera device, it happens on controller before about IPM v1.6.0;
+      the side-effect is that it may cause performance drop about 10%,
+      including bulk transfer, prefer to use 3k here. The size is in bytes.
+    enum: [1024, 2048, 3072, 4096]
+
   # the following properties are only used for case 1
   wakeup-source:
     description: enable USB remote wakeup, see power/wakeup-source.txt
diff --git a/Documentation/devicetree/bindings/usb/nxp,ptn5110.yaml b/Docum=
entation/devicetree/bindings/usb/nxp,ptn5110.yaml
index 28eb25ecba74..eaedb4cc6b6c 100644
--- a/Documentation/devicetree/bindings/usb/nxp,ptn5110.yaml
+++ b/Documentation/devicetree/bindings/usb/nxp,ptn5110.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/usb/nxp,ptn5110.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
=20
-title: NXP PTN5110 Typec Port Cotroller
+title: NXP PTN5110 Type-C Port Controller
=20
 maintainers:
   - Li Jun <jun.li@nxp.com>
diff --git a/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml b/Documen=
tation/devicetree/bindings/usb/qcom,dwc3.yaml
index 915c8205623b..63d150b216c5 100644
--- a/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
+++ b/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
@@ -46,6 +46,8 @@ properties:
           - qcom,sm8350-dwc3
           - qcom,sm8450-dwc3
           - qcom,sm8550-dwc3
+          - qcom,sm8650-dwc3
+          - qcom,x1e80100-dwc3
       - const: qcom,dwc3
=20
   reg:
@@ -97,12 +99,29 @@ properties:
       - const: apps-usb
=20
   interrupts:
-    minItems: 1
-    maxItems: 4
+    description: |
+      Different types of interrupts are used based on HS PHY used on targe=
t:
+        - pwr_event: Used for wakeup based on other power events.
+        - hs_phY_irq: Apart from DP/DM/QUSB2 PHY interrupts, there is
+                       hs_phy_irq which is not triggered by default and its
+                       functionality is mutually exclusive to that of
+                       {dp/dm}_hs_phy_irq and qusb2_phy_irq.
+        - qusb2_phy: SoCs with QUSB2 PHY do not have separate DP/DM IRQs a=
nd
+                      expose only a single IRQ whose behavior can be modif=
ied
+                      by the QUSB2PHY_INTR_CTRL register. The required DPS=
E/
+                      DMSE configuration is done in QUSB2PHY_INTR_CTRL reg=
ister
+                      of PHY address space.
+        - {dp/dm}_hs_phy_irq: These IRQ's directly reflect changes on the =
DP/
+                               DM pads of the SoC. These are used for wake=
up
+                               only on SoCs with non-QUSB2 targets with
+                               exception of SDM670/SDM845/SM6350.
+        - ss_phy_irq: Used for remote wakeup in Super Speed mode of operat=
ion.
+    minItems: 2
+    maxItems: 5
=20
   interrupt-names:
-    minItems: 1
-    maxItems: 4
+    minItems: 2
+    maxItems: 5
=20
   qcom,select-utmi-as-pipe-clk:
     description:
@@ -263,6 +282,7 @@ allOf:
           contains:
             enum:
               - qcom,sc8280xp-dwc3
+              - qcom,x1e80100-dwc3
     then:
       properties:
         clocks:
@@ -288,8 +308,8 @@ allOf:
     then:
       properties:
         clocks:
-          minItems: 5
-          maxItems: 6
+          minItems: 4
+          maxItems: 5
         clock-names:
           oneOf:
             - items:
@@ -298,13 +318,11 @@ allOf:
                 - const: iface
                 - const: sleep
                 - const: mock_utmi
-                - const: bus
             - items:
                 - const: cfg_noc
                 - const: core
                 - const: sleep
                 - const: mock_utmi
-                - const: bus
=20
   - if:
       properties:
@@ -318,6 +336,7 @@ allOf:
               - qcom,sm8250-dwc3
               - qcom,sm8450-dwc3
               - qcom,sm8550-dwc3
+              - qcom,sm8650-dwc3
     then:
       properties:
         clocks:
@@ -357,131 +376,96 @@ allOf:
         compatible:
           contains:
             enum:
-              - qcom,ipq4019-dwc3
+              - qcom,ipq5018-dwc3
               - qcom,ipq6018-dwc3
-              - qcom,ipq8064-dwc3
               - qcom,ipq8074-dwc3
-              - qcom,msm8994-dwc3
+              - qcom,msm8953-dwc3
+              - qcom,msm8998-dwc3
+    then:
+      properties:
+        interrupts:
+          minItems: 2
+          maxItems: 3
+        interrupt-names:
+          items:
+            - const: pwr_event
+            - const: qusb2_phy
+            - const: ss_phy_irq
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,msm8996-dwc3
               - qcom,qcs404-dwc3
+              - qcom,sdm660-dwc3
+              - qcom,sm6115-dwc3
+              - qcom,sm6125-dwc3
+    then:
+      properties:
+        interrupts:
+          minItems: 3
+          maxItems: 4
+        interrupt-names:
+          items:
+            - const: pwr_event
+            - const: qusb2_phy
+            - const: hs_phy_irq
+            - const: ss_phy_irq
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,ipq5332-dwc3
+              - qcom,x1e80100-dwc3
+    then:
+      properties:
+        interrupts:
+          maxItems: 4
+        interrupt-names:
+          items:
+            - const: pwr_event
+            - const: dp_hs_phy_irq
+            - const: dm_hs_phy_irq
+            - const: ss_phy_irq
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,ipq4019-dwc3
+              - qcom,ipq8064-dwc3
+              - qcom,msm8994-dwc3
+              - qcom,sa8775p-dwc3
               - qcom,sc7180-dwc3
+              - qcom,sc7280-dwc3
+              - qcom,sc8280xp-dwc3
               - qcom,sdm670-dwc3
               - qcom,sdm845-dwc3
               - qcom,sdx55-dwc3
               - qcom,sdx65-dwc3
               - qcom,sdx75-dwc3
               - qcom,sm4250-dwc3
-              - qcom,sm6125-dwc3
               - qcom,sm6350-dwc3
               - qcom,sm8150-dwc3
               - qcom,sm8250-dwc3
               - qcom,sm8350-dwc3
               - qcom,sm8450-dwc3
               - qcom,sm8550-dwc3
+              - qcom,sm8650-dwc3
     then:
       properties:
         interrupts:
-          items:
-            - description: The interrupt that is asserted
-                when a wakeup event is received on USB2 bus.
-            - description: The interrupt that is asserted
-                when a wakeup event is received on USB3 bus.
-            - description: Wakeup event on DM line.
-            - description: Wakeup event on DP line.
-        interrupt-names:
-          items:
-            - const: hs_phy_irq
-            - const: ss_phy_irq
-            - const: dm_hs_phy_irq
-            - const: dp_hs_phy_irq
-
-  - if:
-      properties:
-        compatible:
-          contains:
-            enum:
-              - qcom,msm8953-dwc3
-              - qcom,msm8996-dwc3
-              - qcom,msm8998-dwc3
-              - qcom,sm6115-dwc3
-    then:
-      properties:
-        interrupts:
-          maxItems: 2
-        interrupt-names:
-          items:
-            - const: hs_phy_irq
-            - const: ss_phy_irq
-
-  - if:
-      properties:
-        compatible:
-          contains:
-            enum:
-              - qcom,ipq5018-dwc3
-              - qcom,ipq5332-dwc3
-              - qcom,sdm660-dwc3
-    then:
-      properties:
-        interrupts:
-          minItems: 1
-          maxItems: 2
-        interrupt-names:
-          minItems: 1
-          items:
-            - const: hs_phy_irq
-            - const: ss_phy_irq
-
-  - if:
-      properties:
-        compatible:
-          contains:
-            enum:
-              - qcom,sc7280-dwc3
-    then:
-      properties:
-        interrupts:
-          minItems: 3
-          maxItems: 4
-        interrupt-names:
-          minItems: 3
-          items:
-            - const: hs_phy_irq
-            - const: dp_hs_phy_irq
-            - const: dm_hs_phy_irq
-            - const: ss_phy_irq
-
-  - if:
-      properties:
-        compatible:
-          contains:
-            enum:
-              - qcom,sc8280xp-dwc3
-    then:
-      properties:
-        interrupts:
-          maxItems: 4
+          minItems: 4
+          maxItems: 5
         interrupt-names:
           items:
             - const: pwr_event
-            - const: dp_hs_phy_irq
-            - const: dm_hs_phy_irq
-            - const: ss_phy_irq
-
-  - if:
-      properties:
-        compatible:
-          contains:
-            enum:
-              - qcom,sa8775p-dwc3
-    then:
-      properties:
-        interrupts:
-          minItems: 3
-          maxItems: 4
-        interrupt-names:
-          minItems: 3
-          items:
-            - const: pwr_event
+            - const: hs_phy_irq
             - const: dp_hs_phy_irq
             - const: dm_hs_phy_irq
             - const: ss_phy_irq
@@ -519,12 +503,13 @@ examples:
                           <&gcc GCC_USB30_PRIM_MASTER_CLK>;
             assigned-clock-rates =3D <19200000>, <150000000>;
=20
-            interrupts =3D <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 486 IRQ_TYPE_LEVEL_HIGH>,
+            interrupts =3D <GIC_SPI 130 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 489 IRQ_TYPE_EDGE_BOTH>,
                          <GIC_SPI 488 IRQ_TYPE_EDGE_BOTH>,
-                         <GIC_SPI 489 IRQ_TYPE_EDGE_BOTH>;
-            interrupt-names =3D "hs_phy_irq", "ss_phy_irq",
-                          "dm_hs_phy_irq", "dp_hs_phy_irq";
+                         <GIC_SPI 486 IRQ_TYPE_LEVEL_HIGH>;
+            interrupt-names =3D "pwr_event", "hs_phy_irq",
+                          "dp_hs_phy_irq", "dm_hs_phy_irq", "ss_phy_irq";
=20
             power-domains =3D <&gcc USB30_PRIM_GDSC>;
=20
diff --git a/Documentation/devicetree/bindings/usb/qcom,wcd939x-usbss.yaml =
b/Documentation/devicetree/bindings/usb/qcom,wcd939x-usbss.yaml
new file mode 100644
index 000000000000..7ddfd3313a18
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/qcom,wcd939x-usbss.yaml
@@ -0,0 +1,102 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/usb/qcom,wcd939x-usbss.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm WCD9380/WCD9385 USB SubSystem Altmode/Analog Audio Switch
+
+maintainers:
+  - Neil Armstrong <neil.armstrong@linaro.org>
+
+description:
+  Qualcomm WCD9390/WCD9395 is a standalone Hi-Fi audio codec IC with a
+  functionally separate USB SubSystem for Altmode/Analog Audio Switch
+  accessible over an I2C interface.
+  The Audio Headphone and Microphone data path between the Codec and the
+  USB-C Mux subsystems are external to the IC, thus requiring DT port-endp=
oint
+  graph description to handle USB-C altmode & orientation switching for Au=
dio
+  Accessory Mode.
+
+properties:
+  compatible:
+    oneOf:
+      - const: qcom,wcd9390-usbss
+      - items:
+          - const: qcom,wcd9395-usbss
+          - const: qcom,wcd9390-usbss
+
+  reg:
+    maxItems: 1
+
+  reset-gpios:
+    maxItems: 1
+
+  vdd-supply:
+    description: USBSS VDD power supply
+
+  mode-switch:
+    description: Flag the port as possible handle of altmode switching
+    type: boolean
+
+  orientation-switch:
+    description: Flag the port as possible handler of orientation switching
+    type: boolean
+
+  ports:
+    $ref: /schemas/graph.yaml#/properties/ports
+    properties:
+      port@0:
+        $ref: /schemas/graph.yaml#/properties/port
+        description:
+          A port node to link the WCD939x USB SubSystem to a TypeC control=
ler for the
+          purpose of handling altmode muxing and orientation switching.
+
+      port@1:
+        $ref: /schemas/graph.yaml#/properties/port
+        description:
+          A port node to link the WCD939x USB SubSystem to the Codec SubSy=
stem for the
+          purpose of handling USB-C Audio Accessory Mode muxing and orient=
ation switching.
+
+required:
+  - compatible
+  - reg
+  - ports
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells =3D <1>;
+        #size-cells =3D <0>;
+
+        typec-mux@42 {
+            compatible =3D "qcom,wcd9390-usbss";
+            reg =3D <0x42>;
+
+            vdd-supply =3D <&vreg_bob>;
+
+            mode-switch;
+            orientation-switch;
+
+            ports {
+                #address-cells =3D <1>;
+                #size-cells =3D <0>;
+
+                port@0 {
+                    reg =3D <0>;
+                    wcd9390_usbss_sbu: endpoint {
+                        remote-endpoint =3D <&typec_sbu>;
+                    };
+                };
+                port@1 {
+                    reg =3D <1>;
+                    wcd9390_usbss_codec: endpoint {
+                        remote-endpoint =3D <&wcd9390_codec_usbss>;
+                    };
+                };
+            };
+        };
+    };
+...
diff --git a/Documentation/devicetree/bindings/usb/renesas,usbhs.yaml b/Doc=
umentation/devicetree/bindings/usb/renesas,usbhs.yaml
index bad55dfb2fa0..40ada78f2328 100644
--- a/Documentation/devicetree/bindings/usb/renesas,usbhs.yaml
+++ b/Documentation/devicetree/bindings/usb/renesas,usbhs.yaml
@@ -19,7 +19,7 @@ properties:
       - items:
           - enum:
               - renesas,usbhs-r7s9210   # RZ/A2
-              - renesas,usbhs-r9a07g043 # RZ/G2UL
+              - renesas,usbhs-r9a07g043 # RZ/G2UL and RZ/Five
               - renesas,usbhs-r9a07g044 # RZ/G2{L,LC}
               - renesas,usbhs-r9a07g054 # RZ/V2L
           - const: renesas,rza2-usbhs
diff --git a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml b/Documen=
tation/devicetree/bindings/usb/snps,dwc3.yaml
index ee5af4b381b1..203a1eb66691 100644
--- a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
+++ b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
@@ -432,6 +432,10 @@ properties:
     items:
       enum: [1, 4, 8, 16, 32, 64, 128, 256]
=20
+  num-hc-interrupters:
+    maximum: 8
+    default: 1
+
   port:
     $ref: /schemas/graph.yaml#/properties/port
     description:
diff --git a/Documentation/devicetree/bindings/usb/ti,tps6598x.yaml b/Docum=
entation/devicetree/bindings/usb/ti,tps6598x.yaml
index 323d664ae06a..1745e28b3110 100644
--- a/Documentation/devicetree/bindings/usb/ti,tps6598x.yaml
+++ b/Documentation/devicetree/bindings/usb/ti,tps6598x.yaml
@@ -38,6 +38,10 @@ properties:
       - const: main
       - const: patch-address
=20
+  reset-gpios:
+    description: GPIO used for the HRESET pin.
+    maxItems: 1
+
   wakeup-source: true
=20
   interrupts:
@@ -90,6 +94,7 @@ additionalProperties: false
=20
 examples:
   - |
+    #include <dt-bindings/gpio/gpio.h>
     #include <dt-bindings/interrupt-controller/irq.h>
     i2c {
         #address-cells =3D <1>;
@@ -106,6 +111,7 @@ examples:
=20
             pinctrl-names =3D "default";
             pinctrl-0 =3D <&typec_pins>;
+            reset-gpios =3D <&gpio1 6 GPIO_ACTIVE_HIGH>;
=20
             typec_con: connector {
                 compatible =3D "usb-c-connector";
diff --git a/Documentation/devicetree/bindings/usb/usb-xhci.yaml b/Document=
ation/devicetree/bindings/usb/usb-xhci.yaml
index 180a261c3e8f..4238ae896ef6 100644
--- a/Documentation/devicetree/bindings/usb/usb-xhci.yaml
+++ b/Documentation/devicetree/bindings/usb/usb-xhci.yaml
@@ -29,6 +29,12 @@ properties:
     description: Interrupt moderation interval
     default: 5000
=20
+  num-hc-interrupters:
+    description: Maximum number of interrupters to allocate
+    $ref: /schemas/types.yaml#/definitions/uint16
+    minimum: 1
+    maximum: 1024
+
 additionalProperties: true
=20
 examples:

--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--f/OLU4NS4fD0/sqi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZcaCXQAKCRAw5/Bqldv6
8gV0AJ9sw7Qr6VGeMmiXsTjX2ocLa0QdrwCfeH4n6zRcBaRknkOlvpX9oiuK9D0=
=1VDK
-----END PGP SIGNATURE-----

--f/OLU4NS4fD0/sqi--

