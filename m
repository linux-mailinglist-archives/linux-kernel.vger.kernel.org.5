Return-Path: <linux-kernel+bounces-13029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 054BD81FE9F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 10:25:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 635ED281E62
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 09:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F733111AA;
	Fri, 29 Dec 2023 09:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="Bs3f2hKK"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.subdimension.ro (skycaves.subdimension.ro [172.104.132.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5373810A18;
	Fri, 29 Dec 2023 09:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from localhost.localdomain (unknown [188.24.94.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id 9608728B53A;
	Fri, 29 Dec 2023 09:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=subdimension.ro;
	s=skycaves; t=1703841906;
	bh=YfYGIoUsTI6RzgUmUkVBpE+dj6lFzao+jS0AmTGN81E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Bs3f2hKKzk/GN5rdiRahccBHXedBZeaRMfYOijRNv3atFnfBu0vgHc0bpf429z+/U
	 /afaatpwBitxDxOuFQy/kTM5Gw72BNCdunkg6F4QZqg3UxoUA0EuUPamNn1cP/rmxt
	 G3OuSnQQpleEN/3Eco7Z0H18znauBia+WVL4U9nI=
From: Petre Rodan <petre.rodan@subdimension.ro>
To: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Petre Rodan <petre.rodan@subdimension.ro>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Andreas Klinger <ak@it-klinger.de>
Subject: [PATCH v3 03/10] dt-bindings: iio: pressure: honeywell,mprls0025pa.yaml add spi bus
Date: Fri, 29 Dec 2023 11:24:31 +0200
Message-ID: <20231229092445.30180-4-petre.rodan@subdimension.ro>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231229092445.30180-1-petre.rodan@subdimension.ro>
References: <20231229092445.30180-1-petre.rodan@subdimension.ro>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add spi based example.

Add spi-max-frequency property required by chip specifications.

Add additional maintainer.

Co-developed-by: Andreas Klinger <ak@it-klinger.de>
Signed-off-by: Andreas Klinger <ak@it-klinger.de>
Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
---
v2 -> v3 add $ref: /schemas/spi/spi-peripheral-props.yaml

 .../iio/pressure/honeywell,mprls0025pa.yaml   | 27 +++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/pressure/honeywell,mprls0025pa.yaml b/Documentation/devicetree/bindings/iio/pressure/honeywell,mprls0025pa.yaml
index 6643e51c481d..6994b30015bd 100644
--- a/Documentation/devicetree/bindings/iio/pressure/honeywell,mprls0025pa.yaml
+++ b/Documentation/devicetree/bindings/iio/pressure/honeywell,mprls0025pa.yaml
@@ -8,12 +8,12 @@ title: Honeywell mprls0025pa pressure sensor

 maintainers:
   - Andreas Klinger <ak@it-klinger.de>
+  - Petre Rodan <petre.rodan@subdimension.ro>

 description: |
   Honeywell pressure sensor of model mprls0025pa.

-  This sensor has an I2C and SPI interface. Only the I2C interface is
-  implemented.
+  This sensor has an I2C and SPI interface.

   There are many models with different pressure ranges available. The vendor
   calls them "mpr series". All of them have the identical programming model and
@@ -86,6 +86,9 @@ properties:
     description:
       Maximum pressure value the sensor can measure in pascal.

+  spi-max-frequency:
+    maximum: 800000
+
   vdd-supply:
     description: provide VDD power to the sensor.

@@ -103,6 +106,7 @@ oneOf:
       - honeywell,pmax-pascal

 allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml
   - if:
       required:
         - honeywell,pressure-triplet
@@ -133,3 +137,22 @@ examples:
             vdd-supply = <&vcc_3v3>;
         };
     };
+  - |
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        pressure@0 {
+            compatible = "honeywell,mprls0025pa";
+            reg = <0>;
+            spi-max-frequency = <800000>;
+            reset-gpios = <&gpio1 28 GPIO_ACTIVE_HIGH>;
+            interrupt-parent = <&gpio0>;
+            interrupts = <30 IRQ_TYPE_EDGE_RISING>;
+
+            honeywell,pressure-triplet = "0015PA";
+            honeywell,transfer-function = <1>;
+            vdd-supply = <&vcc_3v3>;
+        };
+    };
+...
--
2.41.0


