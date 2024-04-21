Return-Path: <linux-kernel+bounces-152488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45B398ABF30
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 14:31:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7A8C1F21068
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 12:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B03FF134BD;
	Sun, 21 Apr 2024 12:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RKtV56s5"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855C0205E18;
	Sun, 21 Apr 2024 12:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713702661; cv=none; b=qv4xmVCXudUBbuJHkcRvkEq7q0XXc9zX+aEAxYpdNfZ9N4JcF206BfZaK3YW+wkMkxZc98Lhz+uKWKPIvQIM1h1rXEFXoh4+dgOTx73wVveFEp4wDZrWM91S4zG/hvsKW8v2HACmrKwDS5MZmS+37wGrqgDB5dLIvG20qQYI/aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713702661; c=relaxed/simple;
	bh=06sFOl5ohwtaNo8qfOnaHnPVZ28G3zYTy+BtWhWBGMg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KArdNNOi9xy3kThUUmWyjcHSbxu2LhrRl9sacz/ikqmdYuCIixFjpHvIEhff+RQer29LBLJYbVwxMT+YUqI/f2QY5Ag6HmdhdLJTwX2/vbvYej5TtKldcpdnMILJRUAOrwev/h/jHaoIECsQdfJhjw2CtuilwfJxOpFUNt3S/eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RKtV56s5; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1e86d56b3bcso17363895ad.1;
        Sun, 21 Apr 2024 05:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713702660; x=1714307460; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/To2mh0xy1179mX+lPmXvdjYhM/RRr80q5+FRh6M3IM=;
        b=RKtV56s5XKnAHajzJE32ww2fmgF7RIZZFuKm3DrMfuSEoN04FVgexkwxPAj32Aj65h
         cFsO0skprLTCnLHU63STgkcAG1fgv5OwZMsFj3mhJYrCJtzKh7AibrSL2iwVGNG+CLWq
         MLKswfXsBQvcNpnFia7nN1kE+tDxJ+qKyc7bFhGZZBIOg3FB21EigFiB+tki7qyggL7b
         CPaESEAK0sR4SAiPLFD0A+yEu2MARDmcNqd4m9URvFORfFnFoslH7V5x4v50CpkQDPrE
         4N8MMACgxkl5DlIcU8XOIv1xXeUYXdmzsVnd3zn3k1m06tWeH9+nWfl8mibj5MlukleA
         pFqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713702660; x=1714307460;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/To2mh0xy1179mX+lPmXvdjYhM/RRr80q5+FRh6M3IM=;
        b=jZrcz+4/lGZgi42n2r/hzOnBbV+P3x/kJCs6Qc32xjyb8R9ZHbYwO6HsQTMLVQMO37
         2cJyG1zwHIhZJvd2+E6ZMTG7xGUhpV2N4gvcRTiLi6IMCfC71SuJ80uYzO2dp3Jzy8l+
         7K4Nc15liW1cO1e6bgDJjjAnlGixZdXCiSJEurKR6gJhfWJR5kfn2u3FegF1zLd62Z8F
         b/rjimblaKGiPQIcE1SPRSgSQ6kbWyCdb6anCo9J8e3EGIbEQgO/YuqSBq3sA4+0z1U6
         VJvIZq4pv+0EmPt/FbJwwCQ7vdAauXXFh3j+WL4Wvuj0LxYkzXMAt5v1aw7P0ZSw3teR
         BuUA==
X-Forwarded-Encrypted: i=1; AJvYcCVEpdVdsWMEGupAt6+kAHEnmLatnHCzFIrqCVjdnoRpVYzYbG8sTh0jGWP9pTv1VpkoNYqf6PovzrPYCjEmP8GRcx5KptF8isPCUzTukCOG/G7jY0xsTSiROfXVT1/6hkRxLBJ8tW3dZmfFXkPFCMAvozkBJ1cx0ENszwi9zi3Qmef9lfri2HFVhjM5RGqPy872CVfjWLIb+AacugARZerCOdM=
X-Gm-Message-State: AOJu0YzVWNttWNIk6OWJQyRFoTYMiFPAh8Y/CJZRW6mUpA6wLM6owQX8
	Ym/AslKEvsUb4aKrxKih3D6lUwYUzJ0nm+M+TziZBlXV6mG9wA/a
X-Google-Smtp-Source: AGHT+IFtgsMaaTW0DXJr5JYwdTaxNvm5WBBvDlLhc+OwonVkrFTawW2SURXrYebAbrdDQxkYqLBILA==
X-Received: by 2002:a17:902:f542:b0:1e4:3386:349f with SMTP id h2-20020a170902f54200b001e43386349fmr10210269plf.51.1713702659606;
        Sun, 21 Apr 2024 05:30:59 -0700 (PDT)
Received: from localhost (ec2-3-111-32-5.ap-south-1.compute.amazonaws.com. [3.111.32.5])
        by smtp.gmail.com with UTF8SMTPSA id c11-20020a170903234b00b001e87c6aaf33sm6159552plh.76.2024.04.21.05.30.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Apr 2024 05:30:59 -0700 (PDT)
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
Subject: [PATCH v2] ASoC: dt-bindings: tegra30-i2s: convert to dt schema
Date: Sun, 21 Apr 2024 18:00:36 +0530
Message-ID: <20240421123037.75680-1-sheharyaar48@gmail.com>
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
v1->v2:
- Removed incorrect item ref definition

Previous versions:
v1:
https://lore.kernel.org/all/20240420175008.140391-1-sheharyaar48@gmail.com/
---
 .../bindings/sound/nvidia,tegra30-i2s.txt     | 27 --------
 .../bindings/sound/nvidia,tegra30-i2s.yaml    | 66 +++++++++++++++++++
 2 files changed, 66 insertions(+), 27 deletions(-)
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
index 000000000000..b4cc0b0abfb8
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/nvidia,tegra30-i2s.yaml
@@ -0,0 +1,66 @@
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


