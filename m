Return-Path: <linux-kernel+bounces-10725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9700781DAF0
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 15:36:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A97B1F217E6
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 14:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C2EFE554;
	Sun, 24 Dec 2023 14:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="AADHLrC3"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.subdimension.ro (skycaves.subdimension.ro [172.104.132.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D63C568C;
	Sun, 24 Dec 2023 14:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from localhost.localdomain (unknown [188.24.94.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id B437E28B53A;
	Sun, 24 Dec 2023 14:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=subdimension.ro;
	s=skycaves; t=1703428511;
	bh=FYSVyc6a7gii4XVzcpbGbqQQ/0VcN0hGzmBnFOnWCwg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AADHLrC3QN1GkN+tXoceO2jYNkiS/M17KCoF4UyPfPmanJkoyLdPrYmVX/951q+Ob
	 z7b7T4Ujxa1UglFABi+t4y0Ht4SRzyFrIBTPzoBiyDZ4TpAZQPLpTKzr+GL+HQoSSK
	 Rf0y94yYuKLMKlSnKiQT8v1uGsFCy6YwNAwrwxQk=
From: Petre Rodan <petre.rodan@subdimension.ro>
To: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Petre Rodan <petre.rodan@subdimension.ro>,
	Andreas Klinger <ak@it-klinger.de>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: [PATCH v2 03/10] dt-bindings: iio: pressure: honeywell,mprls0025pa.yaml add spi bus
Date: Sun, 24 Dec 2023 16:34:48 +0200
Message-ID: <20231224143500.10940-4-petre.rodan@subdimension.ro>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231224143500.10940-1-petre.rodan@subdimension.ro>
References: <20231224143500.10940-1-petre.rodan@subdimension.ro>
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

Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
Signed-off-by: Andreas Klinger <ak@it-klinger.de>
---
 .../iio/pressure/honeywell,mprls0025pa.yaml   | 26 +++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/pressure/honeywell,mprls0025pa.yaml b/Documentation/devicetree/bindings/iio/pressure/honeywell,mprls0025pa.yaml
index e4021306d187..430496b047c7 100644
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
+  This sensor has an I2C and SPI interface. Both are supported.

   There are many models with different pressure ranges available. The vendor
   calls them "mpr series". All of them have the identical programming model and
@@ -88,6 +88,9 @@ properties:
       Maximum pressure value the sensor can measure in pascal.
       To be specified only if honeywell,pressure-triplet is not set.

+  spi-max-frequency:
+    maximum: 800000
+
   vdd-supply:
     description: provide VDD power to the sensor.

@@ -135,3 +138,22 @@ examples:
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


