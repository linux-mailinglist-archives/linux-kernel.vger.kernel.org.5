Return-Path: <linux-kernel+bounces-79214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FB5E861F0E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 22:29:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0143EB242CF
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 21:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AF3C1493BB;
	Fri, 23 Feb 2024 21:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="DMcfwQ1r"
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4E3149388;
	Fri, 23 Feb 2024 21:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708723727; cv=none; b=V+PFmri9mGObCWEYRDDOUGbfaQhhe3aZCFHvKDrJz6A4Jm48YhfrcFa4t+LxdLrCI/QBeaPyGp9pB6VR13jTGmGJ8BaAh3sGhcEBVuI4VzxlXQJJsInC2cHhUgNUn2daVGK5gh5leEWG3Oi9FWLNG6KB6O192edYToJdtGik1uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708723727; c=relaxed/simple;
	bh=DxNJF2HfobJndwwGNuoV3A/j+HNdIf1M2fN5HyV89UU=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition; b=ktrIol+xmth1KnhlDqhwXgHLs5yVNAwK3Elbnvu5pb+Ym6LUtvE9cEWu0wBNKNRpKfOnOIs9KABVowsA+pgnKset7DNd3Jl1MiMNdGITz9if639+HfeIlPa+EoIvrCQIIntsi9Exlg01w1bHQSPzCSaOSQQQ8gRnnPwdhRCeFcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz; spf=pass smtp.mailfrom=ucw.cz; dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b=DMcfwQ1r; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 9A52A1C006B; Fri, 23 Feb 2024 22:28:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1708723722;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=6xEIm2edK68HPN0TzWfyCgFMgXaReyr4GncU+XTIWD8=;
	b=DMcfwQ1r+t1JybfpFlCJHuyYBt6MEIzKeb2mkpYJ2QO6ipE6xUsGnF/bU5KyGUOJ3NGprB
	u5/Il0c/+l/OODRyjhQERLN/Nzr3u1wrYJBbF0GtYxWE50lyQDIaIPISAvcUOic1ynAYAF
	fcBBlUUoVOof1v5ET6HQjXQx0ao9GMo=
Date: Fri, 23 Feb 2024 22:28:42 +0100
From: Pavel Machek <pavel@ucw.cz>
To: phone-devel@vger.kernel.org, kernel list <linux-kernel@vger.kernel.org>,
	fiona.klute@gmx.de, martijn@brixit.nl, samuel@sholland.org,
	heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
	megi@xff.cz
Subject: [PATCHv2 1/2] dt-bindings: usb: typec: anx7688: start a binding
 document
Message-ID: <ZdkOCqPKqa/u9Ftb@duo.ucw.cz>
References: <ZcaCXYOf6o4VNneu@duo.ucw.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jCLN6xU/n9iIU9zP"
Content-Disposition: inline


--jCLN6xU/n9iIU9zP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Add binding for anx7688 usb type-c bridge. I don't have a datasheet,
but I did best I could.

Signed-off-by: Pavel Machek <pavel@ucw.cz>

---

v2: implement review feedback

diff --git a/Documentation/devicetree/bindings/usb/analogix,anx7688.yaml b/=
Documentation/devicetree/bindings/usb/analogix,anx7688.yaml
new file mode 100644
index 000000000000..9e887eafb5fc
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/analogix,anx7688.yaml
@@ -0,0 +1,127 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/usb/analogix,anx7688.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+# Pin names can be deduced from
+# https://files.pine64.org/doc/PinePhone/PinePhone%20v1.2b%20Released%20Sc=
hematic.pdf
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
+    description: GPIO controlling RESET_N (B7) pin.
+
+  enable-gpios:
+    maxItems: 1
+    description: GPIO controlling POWER_EN (D2) pin.
+
+  cabledet-gpios:
+    maxItems: 1
+    description: GPIO controlling CABLE_DET (C3) pin.
+
+  avdd10-supply:
+    description: 1.0V power supply going to AVDD10 (A4, ...) pins
+
+  dvdd10-supply:
+    description: 1.0V power supply going to DVDD10 (D6, ...) pins
+
+  avdd18-supply:
+    description: 1.8V power supply going to AVDD18 (E3, ...) pins
+
+  dvdd18-supply:
+    description: 1.8V power supply going to DVDD18 (G4, ...) pins
+
+  avdd33-supply:
+    description: 3.3V power supply going to AVDD33 (C4, ...) pins
+
+  i2c-supply: true
+  vconn-supply: true
+  hdmi-vt-supply: true
+  vbus-supply: true
+  vbus-in-supply: true
+
+  connector:
+    type: object
+    $ref: /schemas/connector/usb-connector.yaml
+
+    description:
+      Properties for usb c connector.
+
+    properties:
+      compatible:
+        const: usb-c-connector
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
+            vbus-in-supply =3D <&usb_power_supply>;
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

--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--jCLN6xU/n9iIU9zP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZdkOCgAKCRAw5/Bqldv6
8k4ZAKCyacCwwDMiQJfpB92pVwG7Ep6PFwCglGOsVgCKKM15n+AZgQHGOn/a+1I=
=AcFn
-----END PGP SIGNATURE-----

--jCLN6xU/n9iIU9zP--

