Return-Path: <linux-kernel+bounces-126437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A7D0893803
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 06:36:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5CB31C20B05
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 04:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 911338C1D;
	Mon,  1 Apr 2024 04:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IXK6MtPK"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F9FB2581;
	Mon,  1 Apr 2024 04:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711946180; cv=none; b=VX55o/VJqUr6tXQvf6DVP1aNOuPQl1FGYfIHL4s9RdagDseu+44jSzSNS9HUAT5dkHJRrRhMDOWYnoqBtpZU0RY5uhBX8XUogOiGor9h4gWhLmIoY5Jj5jTsKw6Ous/PgL8PKMsXregU89HT1Z7kIrhSDaVilZ+8JwMeVZJr2XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711946180; c=relaxed/simple;
	bh=+xnRB0MXYbWcOTORh8ezVjlkf9Npugu/WHWEWqiFl4k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FdVff+6Vskn+/MvesnZ1uvGIRE1FQnh98vnbOMVmuJsQSJOHO/DfU+Oo6o/w0T+RB5/4NbSMr0CNo2/w11kYhR9E2EevhtwzXahv1jhSTyDFeebVBupyf14l+iL8NvaPaeYvI2q5303h+HNLNTbXEGtHnpiqlGHj2j9pY/axfmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IXK6MtPK; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1dee27acf7aso25826535ad.2;
        Sun, 31 Mar 2024 21:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711946179; x=1712550979; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wwE/tImZaiEw269ZV6D7aAgEnYEgHKfSAFMQ257qCzM=;
        b=IXK6MtPKD8JSIrIZXWoWqc8F3U6XVHOe09FvuPNK9CWr5CTcMYAr9tt+JW5r+R7WGN
         +pG6nSTC12uUWYfZGaCAdB1du5u2moEUNsp5WJ2zntUQny+kswT6ysoYAqT7vsYwL3fT
         cMEu58DLHaT8CtKJYDeFeII6zzmSOk8MxYTpowk5RgFzyHJMe6ztDkdRryWZJv9GZq0n
         OlOfcRzvCIEBbA3hZFUgTGQoihVFPFfyHO5mDPtfO1jKMlqXx9U1C1HXyaxbvO1sO47r
         n67wpYz6O7DSDUh+50+e49j+5A91QF8Q3Zc4MydC1ee/lB6RREhETTBe17gbQ5xScjxP
         wWUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711946179; x=1712550979;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wwE/tImZaiEw269ZV6D7aAgEnYEgHKfSAFMQ257qCzM=;
        b=K0ziUVk6ODBAVB+wpdxPSxhYxJp/afTTY3YO19yUZY3J9jtCW8u1DDJHcfzcAaDQz9
         DCX/iVTuu8nLfE2VfjEaNKgZVzkEOeRG8KA+zwaNGi/yL/BaWh7aiJEgI7qAXNAi2XFe
         gXMQEt35RL8msR5+5r56NAb6DDb8B91i77yjCSMGk13x4XmSt7oWf/+BJF0AvdDjEel9
         PyeknOT12Pa0Em1YP4rwYGQWDghuse1rxcpxP6gWz0Vs9OvYxxW+MnHF8CKy9gmPtBa+
         /cWibQSz5tOcrKcc9Bl3G33mYhzQ+rKc/22GWSTNsjEPQ0ERdqLTbr9lnWSDts+V2eXY
         bmFQ==
X-Forwarded-Encrypted: i=1; AJvYcCVTsVMLWux2wB6WcavUhAUCb1/wov78lu5ydI0JrviaYPa2LNLp6RRb+x+VbNTCHje7ZywoJKVYO+dj1BbJMPB37b8AtQGiGObrUjy/x2p81s8vxxcPjkWRbbbsQwO1oqjc9AMiycaiJ/CUnC9ZoZwv8FWVdUcXt8eUuS9s7aAIk15ajRwk
X-Gm-Message-State: AOJu0YwzjjK0SrJe0MBbi4KJxPT534BFRDT3XHik8Rq+/qEW5QVrtofM
	8Oh1wCQsKHGS2be0hFmXwDKoGjM7oMfAMwnBgA/mFuU4/+JiaNk4
X-Google-Smtp-Source: AGHT+IEPrRPcssxLAqfAranfcyHY9xgJrUdh96WohAZXPVnDF8gY+cKfMUA1ablelrfiFyNBcdPxHg==
X-Received: by 2002:a17:902:db0e:b0:1e0:b5ee:e806 with SMTP id m14-20020a170902db0e00b001e0b5eee806mr10295230plx.10.1711946178553;
        Sun, 31 Mar 2024 21:36:18 -0700 (PDT)
Received: from localhost ([103.139.191.219])
        by smtp.gmail.com with UTF8SMTPSA id t4-20020a170902e84400b001d8be6d1ec4sm7748324plg.39.2024.03.31.21.35.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Mar 2024 21:36:01 -0700 (PDT)
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
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH] ASoC: dt-bindings: mt2701-wm8960: Convert to dtschema
Date: Mon,  1 Apr 2024 10:05:05 +0530
Message-Id: <20240401043505.40972-1-agarwala.kartik@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert mt2701-wm890 bindings from text to dtschema. This is used by MediaTek mt77623a/n SoC.

Signed-off-by: Kartik Agarwala <agarwala.kartik@gmail.com>
---
 .../sound/mediatek,mt2701-wm8960.yaml         | 59 +++++++++++++++++++
 .../bindings/sound/mt2701-wm8960.txt          | 24 --------
 2 files changed, 59 insertions(+), 24 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/mediatek,mt2701-wm8960.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/mt2701-wm8960.txt

diff --git a/Documentation/devicetree/bindings/sound/mediatek,mt2701-wm8960.yaml b/Documentation/devicetree/bindings/sound/mediatek,mt2701-wm8960.yaml
new file mode 100644
index 000000000..771f14a59
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/mediatek,mt2701-wm8960.yaml
@@ -0,0 +1,59 @@
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
+    description: |
+      A list of the connections between audio components. Each entry is a
+      pair of strings, the first being the connection's sink, the second
+      being the connection's source.
+
+  mediatek,audio-codec:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: The phandle of the WM8960 audio codec.
+  
+  pinctrl-names:
+    const: default
+
+  pinctrl-0: true
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


