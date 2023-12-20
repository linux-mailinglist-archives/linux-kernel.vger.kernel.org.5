Return-Path: <linux-kernel+bounces-7149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CBB2481A24D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 16:25:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86E71282A04
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 15:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23FF947A73;
	Wed, 20 Dec 2023 15:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XRyXUDk3"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3010C47A47;
	Wed, 20 Dec 2023 15:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6d741fb7c8eso3394802b3a.2;
        Wed, 20 Dec 2023 07:22:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703085738; x=1703690538; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wVUS0vagq67iQauaBSQc4zZaCEUauTKoSrv/n4BLa74=;
        b=XRyXUDk3E6+V95HQudKrhYWHi8EfvmzOYom8PetVfZqflYfxKkARAJdd5yxmfbbkfq
         0v0s63fiJwlf3pJ/vFdsyRgWiSU+KQ93gkjGvRRuf78/qWT6IwmCIgrzmk2VTJ+74TTQ
         Vq4O2BojgrJhck1aFpoP1AKVhKvWzK7/ng4GyAIO2Fkd11nqjgXpIltT85y3fj855DVm
         XLoilMvRxpoejBH9apafcrghKMcriN7YVEPZ7oPQt8n5qMHg5oiRRus8jT8DuRxaJlbZ
         z9lnJspgi1vnWOAtdXPWmCBHhu9Cz9v80DcD1oQfMC9oyfG+XXuc1pPNuP8ooM/jP72U
         AFXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703085738; x=1703690538;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wVUS0vagq67iQauaBSQc4zZaCEUauTKoSrv/n4BLa74=;
        b=b41hyzBppckQXS6IeknnoJPCdemZh/3cGVEPsj2rA5URDc6M/Wwj7n0Lz42RkR2rob
         tR07Nn9yillB80b/VapyaGA+AX/amjqPk2PO1dgyBsuaVE5PGK07d5c72jpD+UTnZKt6
         lfMTZkZXX6d0bz/5L48Riccy7YAPR+Uj3R4GgSgcpJchc+YoNiV06WP+hJMxOhNqGhrb
         KFIHtsyZHsr9Fv1JgszgQZfTWMdWwpeacEPwa1nGp2437YA47JVoQA6W+PXjl4eCPqkP
         bzigYmnIclInd+J08c+2uUMAdszPpYLBFqnAYckSuryIYQWKkSCXPgK5CfYDfK9lg0xj
         FwLw==
X-Gm-Message-State: AOJu0YzZMKc0OTt3fMhhAjHomV46Wkih19ChUvESbbuzMMJBRjjRoHjj
	MmkN1Dz8J56P9KSNzr4fTfqZSc6PNtts4w==
X-Google-Smtp-Source: AGHT+IEZ3fFD8mSwd3o8JMOp9QLhh4IEGyS+W60HQrx5oSozEl3WAPIcgdPwpSM9xrtjl8dA5+Wt3A==
X-Received: by 2002:aa7:9092:0:b0:6d9:3de8:cea with SMTP id i18-20020aa79092000000b006d93de80ceamr2389928pfa.22.1703085737835;
        Wed, 20 Dec 2023 07:22:17 -0800 (PST)
Received: from localhost.localdomain ([2401:4900:581e:798e:871c:98db:5638:a4])
        by smtp.gmail.com with ESMTPSA id 13-20020a63164d000000b005cd835182c5sm7304724pgw.79.2023.12.20.07.22.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 07:22:17 -0800 (PST)
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
	Shuah Khan <skhan@linuxfoundation.org>,
	Rob Herring <robh@kernel.org>
Subject: [PATCH v5 1/2] dt-bindings: iio: dac: add MCP4821
Date: Wed, 20 Dec 2023 20:49:52 +0530
Message-ID: <20231220151954.154595-1-anshulusr@gmail.com>
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
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Anshul Dalal <anshulusr@gmail.com>

---

Changes for v5:
- Added 'Reviewed-by: Rob Herring <robh@kernel.org>'

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
v4: https://lore.kernel.org/lkml/20231219090252.818754-1-anshulusr@gmail.com/
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


