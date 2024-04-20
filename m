Return-Path: <linux-kernel+bounces-152336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1DEC8ABC94
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 19:50:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0A1D280FB2
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 17:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C4223B1AA;
	Sat, 20 Apr 2024 17:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OSszIAgN"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A3FB669;
	Sat, 20 Apr 2024 17:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713635426; cv=none; b=kpo1xBEUuU4fOjkoesh8y8Otk2Ct3V8/jrvlsvJekHmSXRY+siPGrt2tucPh0/zxovRQusdfR3R0iAw+9yXYAGxc8nN9lbFIbWGNy3/9R6qkxZWOhUZmcvGJm201UWVKoHS8ayE5TOC7CbngBhC7gQCwb8OHUePJJFOOOdu7r1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713635426; c=relaxed/simple;
	bh=bVd2eqTTQlE/lqeXUNJSYbprksBuhxAdRsI9Y4zTEvA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mB6cM9TBpxPkqH9/7nP9RxMBTmMngNmNQtkIbzf1HF0MWEj877CsKXhvREn/vW24SZpuM25q065dgkDxxQD6upqQbYPHTYa/Ea07pGcwhNsskqBksunRaUwLyow9i85Tvy+V5cIRJmLmUq8IhVzZFju9GbW9f9EiPsuPwhY87OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OSszIAgN; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1e3ca4fe4cfso23579775ad.2;
        Sat, 20 Apr 2024 10:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713635424; x=1714240224; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KIYLQlpLMFUl3xE1BrT2UElBskzOTTw5EVqsEEuHPoM=;
        b=OSszIAgNGaNPblVwWpAo/M46PpPOAPdFllLjWy244cngff7bEDGMEMLof7x5xJOYLt
         4Zbe1dZ7XaIxYaQhm1woHI4WG3i22Ivn1wZTxC3uFqlFo3xMwJFT3NkAHjvxRPoLBo6s
         YtS0Y4nbgD9VMi6TqTDa9dZzuUwkFVy4nLTJ8xVvNsCaHrxOSXT6pA8C4X6vJkJmDkt9
         VR8NIg6iTWzezwVQTvWNuLPyfG5o3eMMdXMdjnpjIIuF1tKV79D47zHZIn8KLgqeLBUK
         zYKzH/cWc+jYLG9Qnh8GoQFw7vpOVsB0JlbzE4XN7j1yNRoj2j8nQJamV5EKbPfbXb+5
         htDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713635424; x=1714240224;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KIYLQlpLMFUl3xE1BrT2UElBskzOTTw5EVqsEEuHPoM=;
        b=w3DuXZ0ZTop84rITxbyEnq55wjzOXpxHU4gip8xK/gAW/lc8OsLO8YkZEUH6jUko2S
         kW+HjA2Hm0iEm9zcp9y8Z04iaJLJZWu/2vLCsGSGEVG8s7btAJghvT4BjpisAKBKHgvH
         A6MYDAOpgGhPS1NzSXzUJR+xWWT6eMbUfq9dNTJBYacNJoRIOxudqDiYJyqeG2YAaEah
         Y5FtSEdEJ12YpZ0/RJKbOy2G62KQ6lcfbvWLqEWttpiHCRyS1Rdkqlx5wB51ijyFF90J
         W/MNivbZEkIYx8HNf2W15s5ZUmfcGvtm79LdFQX5jesFeNWT7yR8GKe+R2jkLDrYSwds
         eA2g==
X-Forwarded-Encrypted: i=1; AJvYcCVcJkk0ufL0ezCFcSYLeSi5BYvPp2IQOZPH1qdC111KzP7PPiOptS4EkJ0u75OQAYlSPsQA2UY0NJBUg1mnkE7sQPnrpkCvdGABTG5/d1HziaT0SQAu9ksTPoqCTx59TKh3jlYaCNygE3+GOp4OsR00sU6ITxgsgvTcjCYIDNhgEeoT5V2MvsNur5Hkiut42SUDk2+WE0oKzMdBeAnztjSZINA=
X-Gm-Message-State: AOJu0YyLuvL2k9cNLDmQhzA/VG3aViKSXnDf6b4q0jGcMRw8SFkVbqM3
	NUF68Cg1yU5klvXyHzSSKzncUsdXLXvjQ2x/v5QOLHDJC9biUJiw
X-Google-Smtp-Source: AGHT+IFqChhWQ6i2C7dFaSVGjRE/tc97YyCzXmiS5MEjIM1QDSggqS3S3tgcf3dU66SY3krSEKy3pQ==
X-Received: by 2002:a17:902:760d:b0:1e3:de79:35d1 with SMTP id k13-20020a170902760d00b001e3de7935d1mr5655350pll.23.1713635423960;
        Sat, 20 Apr 2024 10:50:23 -0700 (PDT)
Received: from localhost (ec2-3-111-32-5.ap-south-1.compute.amazonaws.com. [3.111.32.5])
        by smtp.gmail.com with UTF8SMTPSA id i18-20020a170902c95200b001e0c5be4e2esm5278704pla.48.2024.04.20.10.50.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Apr 2024 10:50:23 -0700 (PDT)
From: Mohammad Shehar Yaar Tausif <sheharyaar48@gmail.com>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>
Cc: Mohammad Shehar Yaar Tausif <sheharyaar48@gmail.com>,
	Thierry Reding <treding@nvidia.com>,
	linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: dt-bindings: tegra30-i2s: convert to dt schema
Date: Sat, 20 Apr 2024 23:20:07 +0530
Message-ID: <20240420175008.140391-1-sheharyaar48@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert NVIDIA Tegra30 I2S binding to DT schema.

Signed-off-by: Mohammad Shehar Yaar Tausif <sheharyaar48@gmail.com>
---
 .../bindings/sound/nvidia,tegra30-i2s.txt     | 27 --------
 .../bindings/sound/nvidia,tegra30-i2s.yaml    | 68 +++++++++++++++++++
 2 files changed, 68 insertions(+), 27 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/nvidia,tegra30-i2s.txt
 create mode 100644 Documentation/devicetree/bindings/sound/nvidia,tegra30-i2s.yaml

diff --git a/Documentation/devicetree/bindings/sound/nvidia,tegra30-i2s.txt b/Documentation/devicetree/bindings/sound/nvidia,tegra30-i2s.txt
deleted file mode 100644
index 38caa936f6f8..000000000000
--- a/Documentation/devicetree/bindings/sound/nvidia,tegra30-i2s.txt
+++ /dev/null
@@ -1,27 +0,0 @@
-NVIDIA Tegra30 I2S controller
-
-Required properties:
-- compatible : For Tegra30, must contain "nvidia,tegra30-i2s".  For Tegra124,
-  must contain "nvidia,tegra124-i2s".  Otherwise, must contain
-  "nvidia,<chip>-i2s" plus at least one of the above, where <chip> is
-  tegra114 or tegra132.
-- reg : Should contain I2S registers location and length
-- clocks : Must contain one entry, for the module clock.
-  See ../clocks/clock-bindings.txt for details.
-- resets : Must contain an entry for each entry in reset-names.
-  See ../reset/reset.txt for details.
-- reset-names : Must include the following entries:
-  - i2s
-- nvidia,ahub-cif-ids : The list of AHUB CIF IDs for this port, rx (playback)
-  first, tx (capture) second. See nvidia,tegra30-ahub.txt for values.
-
-Example:
-
-i2s@70080300 {
-	compatible = "nvidia,tegra30-i2s";
-	reg = <0x70080300 0x100>;
-	nvidia,ahub-cif-ids = <4 4>;
-	clocks = <&tegra_car 11>;
-	resets = <&tegra_car 11>;
-	reset-names = "i2s";
-};
diff --git a/Documentation/devicetree/bindings/sound/nvidia,tegra30-i2s.yaml b/Documentation/devicetree/bindings/sound/nvidia,tegra30-i2s.yaml
new file mode 100644
index 000000000000..3809e4049fe1
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/nvidia,tegra30-i2s.yaml
@@ -0,0 +1,68 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/nvidia,tegra30-i2s.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NVIDIA Tegra30 I2S controller
+
+maintainers:
+  - Thierry Reding <treding@nvidia.com>
+  - Jon Hunter <jonathanh@nvidia.com>
+
+properties:
+  compatible:
+    oneOf:
+      - enum:
+          - nvidia,tegra124-i2s
+          - nvidia,tegra30-i2s
+      - items:
+          - enum:
+              - nvidia,tegra114-i2s
+              - nvidia,tegra132-i2s
+          - const: nvidia,tegra124-i2s
+          - const: nvidia,tegra30-i2s
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+  reset-names:
+    const: i2s
+
+  nvidia,ahub-cif-ids:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    description: |
+      The list of AHUB CIF IDs for this port, rx (playback)
+      first, tx (capture) second. See nvidia,tegra30-ahub.txt for values.
+    minItems: 2
+    maxItems: 2
+    items:
+      $ref: /schemas/types.yaml#/definitions/uint32
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - resets
+  - reset-names
+  - nvidia,ahub-cif-ids
+
+additionalProperties: false
+
+examples:
+  - |
+    i2s@70080300 {
+            compatible = "nvidia,tegra30-i2s";
+            reg = <0x70080300 0x100>;
+            nvidia,ahub-cif-ids = <4 4>;
+            clocks = <&tegra_car 11>;
+            resets = <&tegra_car 11>;
+            reset-names = "i2s";
+    };
+...
-- 
2.44.0


