Return-Path: <linux-kernel+bounces-4936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7C6C818413
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 10:05:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 405872814B7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 09:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EAAA134A8;
	Tue, 19 Dec 2023 09:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NHtTC9nO"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F74134A5;
	Tue, 19 Dec 2023 09:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-28b4d7bf8bdso1092184a91.3;
        Tue, 19 Dec 2023 01:05:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702976722; x=1703581522; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WNy5WamLV4+pReBU2afVcdS0VJmrLwZ/s8baVj2zs4o=;
        b=NHtTC9nOmRLYTb0NWqTECNYydeGHq3LAOxgopRR7btCEiDjAvrlPWsu3ZzZgAmMALX
         2fJk1VoAOQHn+jjT5xQnR82qalAasBfFbXv3vN1/K1VWBtPKGF/C4Kc9Oiw4YoUr3iX1
         o9WmPK1JsY0x8tS5q+lq8ZodckHTN8vMcxMs3tN/LKaDFXtJ93JLkUotEG54GJuwy7A1
         bB8TDjY711WUkUiaNxmw+73WBqUelQ40BLywf98HQKOXrkAFNX2QqNC/bVEzEjGzmtLI
         /kqf1AQkAMEkt/RgoV389rDr6s9cWmO+07nKFGZw3EnEZpschhsMr7UUOSX7LRgg8HSK
         wbcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702976722; x=1703581522;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WNy5WamLV4+pReBU2afVcdS0VJmrLwZ/s8baVj2zs4o=;
        b=r8tAWWQzZSU4Xz7tgYz3WAquwpGAy0d/znbfCmnjbpYYx3pP3vq2+R0uldc2HkTwVA
         RiuPj12KnnlVWrTgvKelVIhONMoEk2epm3Oubms86TxaAkKK2OF7VBmsDqDF9HR/Z+S3
         THCZnQ+O6x1LZ2YOcxk61G3DnKE+MaQb1+no2EF2mlhzvdftUbrDWW+PisIrKl2xsnWw
         g+CsunOulk9ApAa+NL8on5u7SeOi9UaM995Uv6n4LQ34f5PvzlmbacK8GXPDvYp5p2vt
         mM7ccXIbQVmzD99MnLitaWnGoNC/AVBupCMcnW8+C+wInKKqjrF5PvTmkcJyjWcnTK1R
         C+qw==
X-Gm-Message-State: AOJu0YyfTRghfsd6tETf2A5G6nnVp1HOsgszmXWSMZ14kTwvg9iSGmDg
	QAap+u8Fu/Ij1iO66Mt1uir0ZaBKtKKh5c5y
X-Google-Smtp-Source: AGHT+IEMK6Hy9dqCjKeNExgiUXdY/93jSMI8a4xxZS/JTwjBR1rPlOkm8F3+WVrMx4LfRCM0M9eYLw==
X-Received: by 2002:a17:90a:702:b0:286:db1e:f8fc with SMTP id l2-20020a17090a070200b00286db1ef8fcmr7960776pjl.92.1702976722577;
        Tue, 19 Dec 2023 01:05:22 -0800 (PST)
Received: from localhost.localdomain ([2401:4900:581e:798e:871c:98db:5638:a4])
        by smtp.gmail.com with ESMTPSA id f4-20020a17090aec8400b0028bbd9872d5sm806776pjy.12.2023.12.19.01.05.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 01:05:22 -0800 (PST)
From: Anshul Dalal <anshulusr@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: Anshul Dalal <anshulusr@gmail.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	linux-kernel-mentees@lists.linuxfoundation.org,
	Shuah Khan <skhan@linuxfoundation.org>
Subject: [PATCH v4 1/2] dt-bindings: iio: dac: add MCP4821
Date: Tue, 19 Dec 2023 14:32:50 +0530
Message-ID: <20231219090252.818754-1-anshulusr@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adds support for MCP48xx series of DACs.

Datasheet: https://ww1.microchip.com/downloads/en/DeviceDoc/22244B.pdf #MCP48x1
Datasheet: https://ww1.microchip.com/downloads/en/DeviceDoc/20002249B.pdf #MCP48x2
Signed-off-by: Anshul Dalal <anshulusr@gmail.com>

---

Changes for v4:
- Removed 'Reviewed-by: Conor Dooley' due to changes
- Renamed shdn-gpios to powerdown-gpios to conform to
  gpio-consumer-common.yaml

Changes for v3:
- Added gpios for ldac and shutdown pins
- Added spi-cpha and spi-cpol for the SPI mode 0 and 3

Changes for v2:
- Changed order in device table to numerical
- Made vdd_supply required
- Added 'Reviewed-by: Conor Dooley'

Previous versions:
v3: https://lore.kernel.org/lkml/20231218164735.787199-1-anshulusr@gmail.com/
v2: https://lore.kernel.org/lkml/20231217180836.584828-1-anshulusr@gmail.com/
v1: https://lore.kernel.org/lkml/20231117073040.685860-1-anshulusr@gmail.com/
---
 .../bindings/iio/dac/microchip,mcp4821.yaml   | 86 +++++++++++++++++++
 1 file changed, 86 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/dac/microchip,mcp4821.yaml

diff --git a/Documentation/devicetree/bindings/iio/dac/microchip,mcp4821.yaml b/Documentation/devicetree/bindings/iio/dac/microchip,mcp4821.yaml
new file mode 100644
index 000000000000..0dc577c33918
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/dac/microchip,mcp4821.yaml
@@ -0,0 +1,86 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/dac/microchip,mcp4821.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Microchip MCP4821 and similar DACs
+
+description: |
+  Supports MCP48x1 (single channel) and MCP48x2 (dual channel) series of DACs.
+  Device supports simplex communication over SPI in Mode 0 and Mode 3.
+
+  +---------+--------------+-------------+
+  | Device  |  Resolution  |   Channels  |
+  |---------|--------------|-------------|
+  | MCP4801 |     8-bit    |      1      |
+  | MCP4802 |     8-bit    |      2      |
+  | MCP4811 |    10-bit    |      1      |
+  | MCP4812 |    10-bit    |      2      |
+  | MCP4821 |    12-bit    |      1      |
+  | MCP4822 |    12-bit    |      2      |
+  +---------+--------------+-------------+
+
+  Datasheet:
+    MCP48x1: https://ww1.microchip.com/downloads/en/DeviceDoc/22244B.pdf
+    MCP48x2: https://ww1.microchip.com/downloads/en/DeviceDoc/20002249B.pdf
+
+maintainers:
+  - Anshul Dalal <anshulusr@gmail.com>
+
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+properties:
+  compatible:
+    enum:
+      - microchip,mcp4801
+      - microchip,mcp4802
+      - microchip,mcp4811
+      - microchip,mcp4812
+      - microchip,mcp4821
+      - microchip,mcp4822
+
+  reg:
+    maxItems: 1
+
+  vdd-supply: true
+
+  ldac-gpios:
+    description: |
+      Active Low LDAC (Latch DAC Input) pin used to update the DAC output.
+    maxItems: 1
+
+  powerdown-gpios:
+    description: |
+      Active Low SHDN pin used to enter the shutdown mode.
+    maxItems: 1
+
+  spi-cpha: true
+  spi-cpol: true
+
+required:
+  - compatible
+  - reg
+  - vdd-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        dac@0 {
+            compatible = "microchip,mcp4821";
+            reg = <0>;
+            vdd-supply = <&vdd_regulator>;
+            ldac-gpios = <&gpio0 1 GPIO_ACTIVE_HIGH>;
+            powerdown-gpios = <&gpio0 2 GPIO_ACTIVE_HIGH>;
+            spi-cpha;
+            spi-cpol;
+        };
+    };
-- 
2.43.0


