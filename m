Return-Path: <linux-kernel+bounces-135686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95AB489C9B9
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 18:36:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38F4D1F26B4A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 16:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7640E145B3F;
	Mon,  8 Apr 2024 16:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b="h4AmvDjp"
Received: from ahti.lucaweiss.eu (ahti.lucaweiss.eu [128.199.32.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75CB145B0C;
	Mon,  8 Apr 2024 16:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.199.32.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712594090; cv=none; b=oaI7SKe83bCFQuNIERxAvnN/gzqFTU5u39o4iZDpm29JReDr8XPklNnSjUwQh+UXd7VyW5LiWj78Gl1KPIpD9G2HB1J3PwzJ5Ff39U+iaz1vpJYoxrqCcwwkD9BZXANagH/xbremmIicjcDeE3efSuguBcgA1v5qm8lH7EsaoRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712594090; c=relaxed/simple;
	bh=qvnGOQ4wjXBKzINryA0Oef5MwTy2fQxVBq/S+8Agw2Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=adus7K+JDy+7tTjTvxVqV4ICM1zqyaaOqvc0PTgOQpiL7dHdqxy+hhiQMebOvAmt1+KR9rAUNWKUJl1cx2WyfbidgEVMKskoTdWUqOE6BBnEglbMYGvhitf7pUEF2t5AHHTZAuqAFkAXJW9hXw8noHY81w3WM75RViCQGLH1AEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz; spf=pass smtp.mailfrom=z3ntu.xyz; dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b=h4AmvDjp; arc=none smtp.client-ip=128.199.32.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=z3ntu.xyz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=s1;
	t=1712594080; bh=qvnGOQ4wjXBKzINryA0Oef5MwTy2fQxVBq/S+8Agw2Y=;
	h=From:Date:Subject:To:Cc;
	b=h4AmvDjprPpaCHFC3VFnqEHkF7s0Izxi6UkKUa8nRGM76eTH2Zvp/mdeOiiGBPWnI
	 ki6MUrN+CLCDX05zi7cK0Lutay3A3kuVdCH/Ih9JLxPWIZR3P7yT/1bilyOO1SIc8Z
	 Gpa81Itt+BzcId5pj/mhNvuqm4ATMxiUuRHX4s5s=
From: Luca Weiss <luca@z3ntu.xyz>
Date: Mon, 08 Apr 2024 18:34:33 +0200
Subject: [PATCH] dt-bindings: iio: imu: mpu6050: Improve i2c-gate disallow
 list
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240408-mpu6050-i2c-gate-v1-1-621f051ce7de@z3ntu.xyz>
X-B4-Tracking: v=1; b=H4sIAJgcFGYC/x3MSQqAMAxA0atI1gZijeNVxEXRqFk40KoI0rtbX
 L7F/y94cSoe2uQFJ7d63beILE1gWOw2C+oYDYYME1ON63GVVBCqGXC2pyCL5SoXbszEELPDyaT
 Pv+z6ED62G1XZYgAAAA==
To: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Luca Weiss <luca@z3ntu.xyz>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2368; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=qvnGOQ4wjXBKzINryA0Oef5MwTy2fQxVBq/S+8Agw2Y=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBmFBycxBKS0t7+PhZbuZ4QPqgAnd1HaVGlCHuGC
 oHmew1B+IqJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZhQcnAAKCRBy2EO4nU3X
 Vv0ZD/9JNUtWSrR42AK5CKQoOxnEa2zSvCXJu2h3oOeeXjg1UFx7CSH7gG5jm4vd0vHzngHqpYH
 0nRKJ4IyQSLcEIVZjugNvHsSha7qhhoFLPX9iHEVD9RNf+aWrERd1qDVsEfUWhtKkDYVnKkamA2
 ZniDBuGMfnB53mqSG7gUfqqmArP06/lOI2cjC3qfINdz9IOLdZaKy7I7G4cHPEM3Avy29n6GZ+V
 Yg38AdMkwBXvEPEwWsLRq+AwARZWlti9GHuISrEijRD9GOjS3MP5WgoYv620Q25T3ry71BmnfZ3
 PUNHjod7CpUxGHgmwDJyBPepbmK8TbTgly3anKaxWwmKkwDY4bWZwRqevu6KulBGoUbHAqZRc9b
 Vh7Tz7Ku9yo+vABOI2T5umZFj3dsl2QzDpiKEPUJuGawHEqhVkgKo4Lt3b6FxwTJYwk7B1MV2VE
 842q0AJXfmDBY2Y4PtpuIYhBt5NpqIWzKcLt2dP2qyziCywwQI6PTqlWkyT6tSBA+e6GKgfZhef
 d2kb+KaSnm6aKqMiFIpQGS11Z4HkbQQCJhwegvF04EWNwBYSwj49V3lqJi6OGK74XR3M0UqMUlV
 x2686vNZLejkPcVbpHfFvTVKiZRmDuoZHMMjl0SR5/SRBSdWiM7q/X8u6imN1Jy/B4fMthhexSH
 35oIqKaQ69TEaRg==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD

Before all supported sensors except for MPU{9150,9250,9255} were not
allowed to use i2c-gate in the bindings which excluded quite a few
supported sensors where this functionality is supported.

Switch the list of sensors to ones where the Linux driver explicitly
disallows support for the auxiliary bus ("inv_mpu_i2c_aux_bus"). Since
the driver is also based on "default: return true" this should scale
better into the future.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
This fixes dt validation error on qcom-msm8974-lge-nexus5-hammerhead
which uses mpu6515

arch/arm/boot/dts/qcom/qcom-msm8974-lge-nexus5-hammerhead.dtb: mpu6515@68: i2c-gate: False schema does not allow {'#address-cells': [[1]], '#size-cells': [[0]], 'ak8963@f': {'compatible': ['asahi-kasei,ak8963'], 'reg': [[15]], 'gpios': [[40, 67, 0]], 'vid-supply': [[50]], 'vdd-supply': [[49]]}, 'bmp280@76': {'compatible': ['bosch,bmp280'], 'reg': [[118]], 'vdda-supply': [[50]], 'vddd-supply': [[49]]}}
        from schema $id: http://devicetree.org/schemas/iio/imu/invensense,mpu6050.yaml#
---
 .../devicetree/bindings/iio/imu/invensense,mpu6050.yaml | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/imu/invensense,mpu6050.yaml b/Documentation/devicetree/bindings/iio/imu/invensense,mpu6050.yaml
index 297b8a1a7ffb..587ff2bced2d 100644
--- a/Documentation/devicetree/bindings/iio/imu/invensense,mpu6050.yaml
+++ b/Documentation/devicetree/bindings/iio/imu/invensense,mpu6050.yaml
@@ -62,14 +62,15 @@ properties:
 allOf:
   - $ref: /schemas/spi/spi-peripheral-props.yaml#
   - if:
-      not:
-        properties:
-          compatible:
-            contains:
-              enum:
-                - invensense,mpu9150
-                - invensense,mpu9250
-                - invensense,mpu9255
+      properties:
+        compatible:
+          contains:
+            enum:
+              - invensense,iam20680
+              - invensense,icm20602
+              - invensense,icm20608
+              - invensense,icm20609
+              - invensense,icm20689
     then:
       properties:
         i2c-gate: false

---
base-commit: 8568bb2ccc278f344e6ac44af6ed010a90aa88dc
change-id: 20240408-mpu6050-i2c-gate-4ea473e492f4

Best regards,
-- 
Luca Weiss <luca@z3ntu.xyz>


