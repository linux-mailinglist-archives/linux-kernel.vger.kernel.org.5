Return-Path: <linux-kernel+bounces-2769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1C8181618B
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 19:11:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FF001C212C1
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 18:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD66C47A66;
	Sun, 17 Dec 2023 18:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kqo8cMAK"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17D547A4E;
	Sun, 17 Dec 2023 18:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3b9e2a014e8so1929054b6e.2;
        Sun, 17 Dec 2023 10:11:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702836668; x=1703441468; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WKKLVdjbJtf3sQ1BSlJm02odVYdtxAJaGyP069MKh0M=;
        b=kqo8cMAKiyenea8p1ntDSHckeGRUjJsY+rTt0EwE30+x8fr9Y4IhEPIEbaDW0dDfCf
         NA39VdPTP/LLucBA9qgbwUwj0c1ksiE9eYZhB3ZEI5zAko2pBzmE42wmPlt3+JFgEFUi
         e2jD0wdfREt5hz2ae60yTSRKC4iTXBKW+Twt4JCLnCiys3duOBDAGA2RgZH5Y8iAS/0V
         FiHchvaV4L6yhM5Wr3pK/YHjWOHqnq3FvQqUosgcROS+5um6giIUUg0XVgheYs/FsldW
         0nCvh179n0ul5qzp7k56novO7GPhEk1qeS8mJjUKgkYuU8nZ8nQeg7yEz48a2H5knHax
         aj1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702836668; x=1703441468;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WKKLVdjbJtf3sQ1BSlJm02odVYdtxAJaGyP069MKh0M=;
        b=Nip8M4N+yB0a6vOI6pZBb5R3fuNsm3oVubynUilAEqStgv5JL+y+B4OHMqod8kxpaS
         OUVESSXfQZvSTJviR5J1WRMiFUM7+3yOLH1ftSfsgsrFMoGfF3bGb2wpXqSm19VOffLl
         UazkOraMa5ntDDanaC0cKn6QwkwkEPBdBidR5TXM0SHAfHua0VB0MwYT6Y6t9dQJ2WWs
         bEOKhATujHPmnkeY2cgmWFbpbZhuV7Sznt+QWGLQ6tkF3kwHoPEzhHPcAF9j01dacWvB
         knPRJAzFI19kPxVZFhDNjITT2CyYLdcZScpqccF31FfAXh49UbH5TP6IaoL5u/21ftYK
         uj/g==
X-Gm-Message-State: AOJu0YzWaDcDpGK3MYzpELNOCpRyq9N1d9ak9VeaQAz0VDar0p5o7WA3
	ELolfTpheWbowWuBeCmTVZreJZn1pK8epw==
X-Google-Smtp-Source: AGHT+IGHeqDf3X7JsCZYd7wwSmT66FvjOXVf5TUGRmXNe28TjZl7jB0syB6a/79DCmRSIAFZ6eRx5A==
X-Received: by 2002:a05:6808:13c3:b0:3b9:fc7c:b57d with SMTP id d3-20020a05680813c300b003b9fc7cb57dmr18542453oiw.35.1702836668530;
        Sun, 17 Dec 2023 10:11:08 -0800 (PST)
Received: from localhost.localdomain ([2401:4900:581e:798e:871c:98db:5638:a4])
        by smtp.gmail.com with ESMTPSA id d18-20020aa78692000000b006bdd7cbcf98sm16761286pfo.182.2023.12.17.10.11.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Dec 2023 10:11:08 -0800 (PST)
From: Anshul Dalal <anshulusr@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>,
	devicetree@vger.kernel.org
Cc: Anshul Dalal <anshulusr@gmail.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	linux-kernel-mentees@lists.linuxfoundation.org,
	Shuah Khan <skhan@linuxfoundation.org>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v2 1/2] dt-bindings: iio: dac: add MCP4821
Date: Sun, 17 Dec 2023 23:38:33 +0530
Message-ID: <20231217180836.584828-1-anshulusr@gmail.com>
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
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Anshul Dalal <anshulusr@gmail.com>

---

Changes for v2:
- Changed order in device table to numerical
- Made vdd_supply required
- Added 'Reviewed-by: Conor Dooley'

Previous versions:
v1: https://lore.kernel.org/lkml/20231117073040.685860-1-anshulusr@gmail.com/
---
 .../bindings/iio/dac/microchip,mcp4821.yaml   | 64 +++++++++++++++++++
 1 file changed, 64 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/dac/microchip,mcp4821.yaml

diff --git a/Documentation/devicetree/bindings/iio/dac/microchip,mcp4821.yaml b/Documentation/devicetree/bindings/iio/dac/microchip,mcp4821.yaml
new file mode 100644
index 000000000000..97da9f9ef450
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/dac/microchip,mcp4821.yaml
@@ -0,0 +1,64 @@
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
+  Device supports simplex communication over SPI in Mode 0,1 and Mode 1,1.
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
+required:
+  - compatible
+  - reg
+  - vdd-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        dac@0 {
+            compatible = "microchip,mcp4821";
+            reg = <0>;
+            vdd-supply = <&vdd_regulator>;
+        };
+    };
-- 
2.43.0


