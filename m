Return-Path: <linux-kernel+bounces-109201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6440C881613
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 18:05:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1920C2845F5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 17:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A6096A325;
	Wed, 20 Mar 2024 17:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J9M7xCZH"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1138DBA45;
	Wed, 20 Mar 2024 17:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710954315; cv=none; b=c9Tbgqi1M9D8b6kAIj6Cg5Q3lzTlhBAQjZ5nMMYEQi5pac+NnCB5pOWavaxRaDQ1Zq2az3sciMbK+DrwAOXPhaI8gdlNb7rT6+fCP6bBGwMLdAIcoLkq/5URGtzaMc1IUDx0NVHbb/8hPP4CV+Lu7nCOQkmMdXS/pT7F8HhKOt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710954315; c=relaxed/simple;
	bh=TjTcKKa669OKcPhVLe09wrmQ2cA8xaDIfGZNCpgTFng=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VBDBAFTFg9wZhAIMCpd+ho9aqs/mBTDEpSsyp41u9xfJl0A3r0CnJYc1hsTlKN7lSjHHfXuAjsn+Lc3TBcrgfW+DQRB8oFWCB0vGwR8PI7BsMbeMPTfr6eKvGF6adA8wQO3lG0QWtWXrbbcb9TRB8x1sUiP7IUQEOezhs7ZSN0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J9M7xCZH; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-513edc88d3cso127264e87.0;
        Wed, 20 Mar 2024 10:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710954311; x=1711559111; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BJIJVaZ1AJVUf194+oMOU0Iy8m7xvdZB41+GUQbshIo=;
        b=J9M7xCZHe3orBjKzrIBbbYlJ/jAxQwXQjQiDaq/N25qnCOQHzBAFXibebDM0fQ9JBE
         pn7l0QUDBHbmhbjMqYlUPwlpSjlgiSLaQs5eqMi/BOkg6HFfZmX0HviegK5F5SwKtZ/q
         mDSUWU7UqHay62t7ON13ZNtADlW9YjGo5qarXI+AhIG9LEiwRMqMo5CUjustH/nKVFcx
         lwscMHy3J7hPLuomAAZaX7UlOeJ5USxtu0lGbUvORQ2tXyFi8OBbMi69UG1v4X/XRWCU
         Sn90pWJsZ3kgzYZxplm9hkHIwWsUHqCPcN4F5xuemXQQd2dE8+hBoJDvxYTB1UOpYUyq
         OFTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710954311; x=1711559111;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BJIJVaZ1AJVUf194+oMOU0Iy8m7xvdZB41+GUQbshIo=;
        b=Vs4Rb0QUzGcvl9x1lF89tz4jNPGHdxJR2Z/U6MdESSjcMWAvRY/lTyWL27alC070hJ
         dBjOiPVWtO59r7//HLPm9rKekdiwjelWCKea4WReIiXgx4abDzLWT4YBF+3VihRoE3eQ
         QoUoeMyMG32E9uqxnfrSPnAEIU5Tb/41UywkMP1xjhXr8mLM/qaZ+rs0R7w3iSpZexVO
         r0chJz8QJAFzZaiHsQDi7nxc9d4HwcZMziJMfilAL1vvpyFf1Ka/chR0GX/vEw9pjb74
         8uPGaMNgeGklueICOEFBLthXY7DCMeQSY5eVvM8S9pL8M1QImifo3dM9KQmIt6L127e2
         yRvA==
X-Forwarded-Encrypted: i=1; AJvYcCV4sV55qDRHOxp57L08di5NLdumvB4yW4t5U/mUYBstWva/9EDgQqtbIqCkF+tLLn4hVV1vz5HEGUN1EYMuYdNbTmLYNYtrKsLV7ArEPIfapzQ4cY2ZPJ/CrrO4KYUzSKGsS1oVbs11FQ==
X-Gm-Message-State: AOJu0Yyiz8omt6TuTBpzR62k+wlcmbmfHQVWlfN3l1sRJJVkZ/nXDH4L
	1ixmXSK0gQ9KVrvjLVqCimteI5QB4RbAPOfUMCjYLnDn+VYDZMd8t0EsdOvlYrTLiQ==
X-Google-Smtp-Source: AGHT+IGugjMJM1VIOuWhOA3U805kpwztRjqATv4iCECfL2CUiXOSrAhdeQbZ63iRqUNVdDkzigwT8Q==
X-Received: by 2002:ac2:4db1:0:b0:513:b8a2:8d83 with SMTP id h17-20020ac24db1000000b00513b8a28d83mr13334340lfe.3.1710954311486;
        Wed, 20 Mar 2024 10:05:11 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-3c5a-7cb4-e12c-8223.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:3c5a:7cb4:e12c:8223])
        by smtp.gmail.com with ESMTPSA id af3-20020a170906998300b00a469604c464sm5999019ejc.160.2024.03.20.10.05.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 10:05:10 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Wed, 20 Mar 2024 18:04:57 +0100
Subject: [PATCH 1/2] dt-bindings: hwmon: lm87: convert to dtschema
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240320-hwmon_yaml-v1-1-a349ca21ccab@gmail.com>
References: <20240320-hwmon_yaml-v1-0-a349ca21ccab@gmail.com>
In-Reply-To: <20240320-hwmon_yaml-v1-0-a349ca21ccab@gmail.com>
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, peiyu li <579lpy@gmail.com>
Cc: linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1710954308; l=3573;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=TjTcKKa669OKcPhVLe09wrmQ2cA8xaDIfGZNCpgTFng=;
 b=H3Uv7ycEoEDXVWMGKrmDVVnnLbAQN0+FrQ8HGa1eaZyuibMwUcTSj3q68yGFXU0Mev0NR8WBm
 V/D+/wDeZz/B4tpn4AtWTCHAC9EqIjlMSbiF26T/YIN57stYrkmuS3E
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

Convert existing bindings to dtschema to support validation.

This is a straightforward conversion with no new properties.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 Documentation/devicetree/bindings/hwmon/lm87.txt   | 30 ----------
 .../devicetree/bindings/hwmon/ti,lm87.yaml         | 69 ++++++++++++++++++++++
 2 files changed, 69 insertions(+), 30 deletions(-)

diff --git a/Documentation/devicetree/bindings/hwmon/lm87.txt b/Documentation/devicetree/bindings/hwmon/lm87.txt
deleted file mode 100644
index 758ff398b67b..000000000000
--- a/Documentation/devicetree/bindings/hwmon/lm87.txt
+++ /dev/null
@@ -1,30 +0,0 @@
-*LM87 hwmon sensor.
-
-Required properties:
-- compatible: Should be
-	"ti,lm87"
-
-- reg: I2C address
-
-optional properties:
-- has-temp3: This configures pins 18 and 19 to be used as a second
-             remote temperature sensing channel. By default the pins
-             are configured as voltage input pins in0 and in5.
-
-- has-in6: When set, pin 5 is configured to be used as voltage input
-           in6. Otherwise the pin is set as FAN1 input.
-
-- has-in7: When set, pin 6 is configured to be used as voltage input
-           in7. Otherwise the pin is set as FAN2 input.
-
-- vcc-supply: a Phandle for the regulator supplying power, can be
-              configured to measure 5.0V power supply. Default is 3.3V.
-
-Example:
-
-lm87@2e {
-	compatible = "ti,lm87";
-	reg = <0x2e>;
-	has-temp3;
-	vcc-supply = <&reg_5v0>;
-};
diff --git a/Documentation/devicetree/bindings/hwmon/ti,lm87.yaml b/Documentation/devicetree/bindings/hwmon/ti,lm87.yaml
new file mode 100644
index 000000000000..f553235a7321
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/ti,lm87.yaml
@@ -0,0 +1,69 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+
+$id: http://devicetree.org/schemas/hwmon/ti,lm87.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments LM87 Hardware Monitor
+
+maintainers:
+  - Javier Carrasco <javier.carrasco.cruz@gmail.com>
+
+description: |
+  The LM87 is a serial interface system hardware monitor
+  with remote diode temperature sensing.
+
+  Datasheets:
+    https://www.ti.com/product/LM87
+
+properties:
+  compatible:
+    const: ti,lm87
+
+  reg:
+    maxItems: 1
+
+  has-temp3:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      This configures pins 18 and 19 to be used as a second
+      remote temperature sensing channel. By default the pins
+      are configured as voltage input pins in0 and in5.
+
+  has-in6:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      When set, pin 5 is configured to be used as voltage input
+      in6. Otherwise the pin is set as FAN1 input.
+
+  has-in7:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      When set, pin 6 is configured to be used as voltage input
+      in7. Otherwise the pin is set as FAN2 input.
+
+  vcc-supply:
+    description:
+      Regulator supplying power, can be configured to measure
+      5.0V power supply. Default is 3.3V.
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        hwmon@2e {
+            compatible = "ti,lm87";
+            reg = <0x2e>;
+            has-temp3;
+            vcc-supply = <&reg_5v0>;
+        };
+    };

-- 
2.40.1


