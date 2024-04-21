Return-Path: <linux-kernel+bounces-152443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 76EB58ABE7C
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 05:35:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6964B20E11
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 03:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD36D610B;
	Sun, 21 Apr 2024 03:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SE6E2bew"
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB048205E22;
	Sun, 21 Apr 2024 03:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713670518; cv=none; b=cIA75QptwcsBBk4RYAYGk01PXizqUcK5KGcviMaPd4LgQ9Usiv8pTygQIDUEbwSlaJMqMVEqfNOAB/bjbyitkCOT9mqVIzviZrkWUuZUpO+xevtS2jrVVcY9dQ8lilHrgn4a1JMaZe5n8j26H+45hApbzYzGKkWKfOsVP/4duco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713670518; c=relaxed/simple;
	bh=w3BWd/Mb/cQJxsngUQxpZvCJqYSIFwkMtiPa2dhMohE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Cp629rCXlm6zvTLQnnWOVsxn4te0LnINF5bAZpI44H+oSwDqTdJ6a6RYcw1EmTg/RYSDMnt0bS47jzAx5065hzHIBbfQiIu26bV3ks+6GrcoHCYQhRualLo6TJec/y+3/a9bV+e/SmU8eUYsQ/ritSV/w+1SDkRqI7umczKsuCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SE6E2bew; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3c5ee4ce695so1079364b6e.0;
        Sat, 20 Apr 2024 20:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713670512; x=1714275312; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DqTFUStUgUgHwhHTzA1wLZlhW+xV4wEDyDdTFLtabz0=;
        b=SE6E2bewEJBoRJy6o9B0J3nrA21kZO3PLaE8Wj8G05KO0itYF5782tm8yHUxlHg4Ot
         e7NkC32sXu7Q3Gjb3RAgA7lIS2QxlNP1pUSrYx6M2n2ni6LUHoqJ0ITXE77PKefwHaRK
         ox34ZWIIDGwrMRFXwvMEDhml7MD4IeOpaDFM2xmL3pE0ft7mmQvMQ80vvSr54NcUUfOj
         jdvzUrA/CJeU22e0TxMqXnFrhWJ6PJw1mQ1E80ejU734xfkGb4MSQJfX/x4lsc4h9Mdt
         gw7rVq7ceFh2wSPGSMayREjWp0UioGEon39gAAw3yEFyilBS94xB48nXgLY56ROd48f1
         rGeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713670512; x=1714275312;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DqTFUStUgUgHwhHTzA1wLZlhW+xV4wEDyDdTFLtabz0=;
        b=HlcQwhms+Tf0SsJiJZ6Jjn7Ml9XqEBrB/mFoLHitg6NHWrDwRaUkjTT9D3W9CxPAPv
         1cab49hhomSGaG5rqUpwlq549jT6JCHOdyEflvk9xq0GO069qm6qgv3+axTf9XDqZGzy
         EX2QXhXTSxIgXgATc+qWBO60cdxXHuH2fbsv6muuiVDkxx/+nqq9Cn6zZA8Hv8EM7aBf
         qc4c+7M7S1KdON0ZtGtUj6rTCSwEnucxbbCJwPdh97SYSrhkVaFl9jp5gnRAmFEJq9kS
         MXdQFdyre1t/amd2vg3IeQV5O/FnRcTRImqGNRlWSzZ4YZWsmeZ1gEecueUd5PmhdCK2
         zsPA==
X-Forwarded-Encrypted: i=1; AJvYcCWfBpW359XUPhxMa21AcgybOH8kC/xAslqUGiohluaaSTOW5Lnsk3k3uFZZjixGUozD0oETJUmuj0Ytwx3AqzcnwwKxALXPjTFZlEfoxvlTaO9xVh+pciI0DY1SaZIa/6HqNVmKnBjlVKIQkLRr5yES8BbGGQLrqgy+YbkaUaCdWSiquIYl
X-Gm-Message-State: AOJu0YxGExj9m9LFV5CQDIdES69stICa2RKwpvyC2c70iT7bkDvZlZ8S
	RSdsTlcQ1oj1tBiCfLYu4mWHLbjk7pTMX4Io9MJ/5spAB/Ysj8YB
X-Google-Smtp-Source: AGHT+IEhIi5dpao0M7bfoPbGYTuQ9jJSf6VyRPSAaGoV0oTkl8Eb5w20BzCqE9x96m8tcu3YW0MIkQ==
X-Received: by 2002:a05:6808:6c1:b0:3c6:4d7:abf9 with SMTP id m1-20020a05680806c100b003c604d7abf9mr7562694oih.55.1713670511864;
        Sat, 20 Apr 2024 20:35:11 -0700 (PDT)
Received: from localhost ([117.239.226.201])
        by smtp.gmail.com with UTF8SMTPSA id b9-20020a056a00114900b006eaaaf5e0a8sm5517386pfm.71.2024.04.20.20.35.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Apr 2024 20:35:11 -0700 (PDT)
From: Kartik Agarwala <agarwala.kartik@gmail.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com
Cc: Kartik Agarwala <agarwala.kartik@gmail.com>,
	linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v2] ASoC: dt-bindings: mt2701-wm8960: Convert to dtschema
Date: Sun, 21 Apr 2024 09:01:31 +0530
Message-Id: <20240421033129.13076-1-agarwala.kartik@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert mt2701-wm890 bindings from text to dtschema. This is used by
MediaTek mt7623a/n SoC.

Signed-off-by: Kartik Agarwala <agarwala.kartik@gmail.com>
---
Changes for v2:
- Do not define pinctrl properties as they are implicitly supported.

Previous versions:
v1: https://lore.kernel.org/all/20240401043505.40972-1-agarwala.kartik@gmail.com/
---
 .../sound/mediatek,mt2701-wm8960.yaml         | 54 +++++++++++++++++++
 .../bindings/sound/mt2701-wm8960.txt          | 24 ---------
 2 files changed, 54 insertions(+), 24 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/mediatek,mt2701-wm8960.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/mt2701-wm8960.txt

diff --git a/Documentation/devicetree/bindings/sound/mediatek,mt2701-wm8960.yaml b/Documentation/devicetree/bindings/sound/mediatek,mt2701-wm8960.yaml
new file mode 100644
index 000000000..cf985461a
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/mediatek,mt2701-wm8960.yaml
@@ -0,0 +1,54 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/mediatek,mt2701-wm8960.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek MT2701 with WM8960 CODEC
+
+maintainers:
+  - Kartik Agarwala <agarwala.kartik@gmail.com>
+
+properties:
+  compatible:
+    const: mediatek,mt2701-wm8960-machine
+
+  mediatek,platform:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: The phandle of MT2701 ASoC platform.
+
+  audio-routing:
+    $ref: /schemas/types.yaml#/definitions/non-unique-string-array
+    description:
+      A list of the connections between audio components. Each entry is a
+      pair of strings, the first being the connection's sink, the second
+      being the connection's source.
+
+  mediatek,audio-codec:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: The phandle of the WM8960 audio codec.
+
+unevaluatedProperties: false
+
+required:
+  - compatible
+  - mediatek,platform
+  - audio-routing
+  - mediatek,audio-codec
+  - pinctrl-names
+  - pinctrl-0
+
+examples:
+  - |
+    sound {
+        compatible = "mediatek,mt2701-wm8960-machine";
+        mediatek,platform = <&afe>;
+        audio-routing =
+            "Headphone", "HP_L",
+            "Headphone", "HP_R",
+            "LINPUT1", "AMIC",
+            "RINPUT1", "AMIC";
+        mediatek,audio-codec = <&wm8960>;
+        pinctrl-names = "default";
+        pinctrl-0 = <&aud_pins_default>;
+    };
diff --git a/Documentation/devicetree/bindings/sound/mt2701-wm8960.txt b/Documentation/devicetree/bindings/sound/mt2701-wm8960.txt
deleted file mode 100644
index 809b609ea..000000000
--- a/Documentation/devicetree/bindings/sound/mt2701-wm8960.txt
+++ /dev/null
@@ -1,24 +0,0 @@
-MT2701 with WM8960 CODEC
-
-Required properties:
-- compatible: "mediatek,mt2701-wm8960-machine"
-- mediatek,platform: the phandle of MT2701 ASoC platform
-- audio-routing: a list of the connections between audio
-- mediatek,audio-codec: the phandles of wm8960 codec
-- pinctrl-names: Should contain only one value - "default"
-- pinctrl-0: Should specify pin control groups used for this controller.
-
-Example:
-
-	sound:sound {
-		compatible = "mediatek,mt2701-wm8960-machine";
-		mediatek,platform = <&afe>;
-		audio-routing =
-			"Headphone", "HP_L",
-			"Headphone", "HP_R",
-			"LINPUT1", "AMIC",
-			"RINPUT1", "AMIC";
-		mediatek,audio-codec = <&wm8960>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&aud_pins_default>;
-	};
-- 
2.34.1


