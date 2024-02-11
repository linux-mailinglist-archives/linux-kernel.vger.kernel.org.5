Return-Path: <linux-kernel+bounces-60962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 26468850BAD
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 22:40:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 629CAB20D6C
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 21:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53F305F85D;
	Sun, 11 Feb 2024 21:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nE17Xa5a"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B235F48A;
	Sun, 11 Feb 2024 21:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707687580; cv=none; b=O+Z1cnqYx/NffrkFUemLz/nCq6MkcLX/zMe7Hocqv5jhtzDE3BnVEvgan4ZGCgn12EM9Bld3sR+sxs6ba/f5d9lEfTPndMJZniTTde8D4c1hZVnF3BlqxsmDGvFz1CSJCNKmRX9eCHnKnMVwumAcuD0PMcG0idHawq7vM/b4Xvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707687580; c=relaxed/simple;
	bh=0fAQCTEnvIpzw1bBuG1bZ9WpLnsKPzuE76f0W4PCsXs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lc/cUuPEve/e0CUUSDLE8P3FcJL9mh7VoyFtWoRmUtfd/hirwasx5Ldkx0Q/NlHCVH2RCa+nkCqY0m1BhMFQBN3iKs1q5c9UHCIPX4JKux8sVbK5Hwwjy6gks2PD9nYaNQEz4s0TbOq7pf0xF9T7UzI4OO4nhwKWrzGWaVwG+3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nE17Xa5a; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-55fcceb5f34so2820102a12.3;
        Sun, 11 Feb 2024 13:39:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707687577; x=1708292377; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FYKNeKCJBPMaI8CwH2vaV/FLvsnFOMIKN5WCojMYSS8=;
        b=nE17Xa5ach2m9MDDJW4NZtDcpPWeD9qLUCIMMvO9+3UTVObwS1iXhw7tXDlolB2+P5
         DaSxOmTydl7BT9LPI/hve/lDGJ9GtpC3gyEim4SecPAzrvSG/0Bz78HdbIx3SF9FhKZT
         KxIVSsXx3WrLHEwL/+KOLsAmJ6kyVjYRtbDa0vH23ntKUh7lIHvpLPVofGdYx1IESGi/
         r97ZLhGcLOkdjMr+GxzzcloHCXBLUxpSBqSVZxf7+AJc26aPJw3SuTSZV8/PszGwLWj3
         AiV//yde9LLv0sOD3vUHHPOON/bvypTT6kM3XynK9DdEebYPC/94v1AoQxrOFECOeERA
         Ipqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707687577; x=1708292377;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FYKNeKCJBPMaI8CwH2vaV/FLvsnFOMIKN5WCojMYSS8=;
        b=af1hiuqlAcDeIFhImE02jqgBf4IEj1gsuaV6ugzkGAN/+kmzGDPCQ6Rbcm1dGGpgOa
         ge+0T8pGwSR8fcP0z1waK2sp8Pd8ZBmg+zDboyDtkTx7dxyst6ctWcO8DbC8ICg5f0Sl
         dofnE8TiWWVc2b1b5ZU4IgCirCpZAMCUfkfTAtDQwRm4C+BFRVXlIOU8I2g9Vup1ukt0
         YNNEEzYfrxfpgKqijOeIrbuCO3DlryAHyNDcsLAnzRFWVIQv8PK3RoexIoIZSSFbrI98
         TlFXJImz1k8eNwD4Jhdnj8a+U4Zr64ButXc5Kov6yJI9KvndOLn3K3pTFr8Y8Uz+kuG4
         wLew==
X-Gm-Message-State: AOJu0Yx8QDOWLlBalosvQId90a4tgd3NvYl2tEjsD7oNWRfVcKqAkjpG
	JDTx0A6ft4aJkGrcu/epKX9aKbk/NTF0lTcd+cnsz7ZfC1eqsNrj
X-Google-Smtp-Source: AGHT+IG/5cwW4J++14BxmVUMP/jSPxcWcunujb3X7L5lX5vr/5UVEMNdWGmYn/0HIs0mIWIGY28X5Q==
X-Received: by 2002:a17:906:6893:b0:a3c:1046:93dd with SMTP id n19-20020a170906689300b00a3c104693ddmr3728410ejr.31.1707687577017;
        Sun, 11 Feb 2024 13:39:37 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV6ocTTNt8sqAUamRUVDpcCivKEIApnJS8hWD/Vek4rtQxvvB44hZTXdvCDVGneRzKAADdJuCqiicf1wDB0O76lPYhakYcAGRMaXzguhihVMA+DxzBeJ6eKsX0WZgzvYTG2yYklqNZx4M2CwU255qCoZEDL8CTb4gsuGxBDdC2jC6sQbUlhua9RiEkt2r6YOZi+f7tiXNs9LcgZN5vODoYSFv+OGmgZ7wkOE1k9jfme5ziCDQcdpPcIlXtIWcL7v1OAIbXWAVPWBoxBmJSxsbmC0DA6bG16IdgBcuxkTNqrT5uyqYaR8M9fOjUHqrCo1xzTwLXcUGDBwXrsAQEqN5VMomFoVa+b3q3owS92waYqZPQJahBaleT6oBnXnw8kTuMZRQGRqAUHx6QAIDRGCs5WKiQTDQplBlgGh/UByLYCiULwwSJixEIPSrSvMQT6NE2urS4CV636u6grjsBq2Heg/G0sEIL6N7IQy0zn0Hn9XnKkaE/aDdQji9EUxz/vhN8AueevxJJvf+otcLFpuhVjw3skv7kZQ+M4YKavqxeR/DyAEQ==
Received: from localhost.lan (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.gmail.com with ESMTPSA id ps6-20020a170906bf4600b00a3c66ac512asm1206344ejb.214.2024.02.11.13.39.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Feb 2024 13:39:36 -0800 (PST)
From: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To: Russell King <linux@armlinux.org.uk>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	devicetree@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH V3 1/3] dt-bindings: arm: mediatek: convert HIFSYS to the json-schema clock
Date: Sun, 11 Feb 2024 22:39:23 +0100
Message-Id: <20240211213925.18348-2-zajec5@gmail.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240211213925.18348-1-zajec5@gmail.com>
References: <20240211213925.18348-1-zajec5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Rafał Miłecki <rafal@milecki.pl>

This helps validating DTS files. Introduced changes:
1. Documented "reg" property
2. Documented "#reset-cells" property
3. Dropped "syscon" as it was incorrectly used
4. Adjusted "compatible" and "reg" in example

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../bindings/arm/mediatek/mediatek,hifsys.txt | 26 ----------
 .../clock/mediatek,mt2701-hifsys.yaml         | 50 +++++++++++++++++++
 2 files changed, 50 insertions(+), 26 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,hifsys.txt
 create mode 100644 Documentation/devicetree/bindings/clock/mediatek,mt2701-hifsys.yaml

diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,hifsys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,hifsys.txt
deleted file mode 100644
index 323905af82c3..000000000000
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,hifsys.txt
+++ /dev/null
@@ -1,26 +0,0 @@
-Mediatek hifsys controller
-============================
-
-The Mediatek hifsys controller provides various clocks and reset
-outputs to the system.
-
-Required Properties:
-
-- compatible: Should be:
-	- "mediatek,mt2701-hifsys", "syscon"
-	- "mediatek,mt7622-hifsys", "syscon"
-	- "mediatek,mt7623-hifsys", "mediatek,mt2701-hifsys", "syscon"
-- #clock-cells: Must be 1
-
-The hifsys controller uses the common clk binding from
-Documentation/devicetree/bindings/clock/clock-bindings.txt
-The available clocks are defined in dt-bindings/clock/mt*-clk.h.
-
-Example:
-
-hifsys: clock-controller@1a000000 {
-	compatible = "mediatek,mt2701-hifsys", "syscon";
-	reg = <0 0x1a000000 0 0x1000>;
-	#clock-cells = <1>;
-	#reset-cells = <1>;
-};
diff --git a/Documentation/devicetree/bindings/clock/mediatek,mt2701-hifsys.yaml b/Documentation/devicetree/bindings/clock/mediatek,mt2701-hifsys.yaml
new file mode 100644
index 000000000000..9e7c725093aa
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/mediatek,mt2701-hifsys.yaml
@@ -0,0 +1,50 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/mediatek,mt2701-hifsys.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek HIFSYS clock and reset controller
+
+description:
+  The MediaTek HIFSYS controller provides various clocks and reset outputs to
+  the system.
+
+maintainers:
+  - Matthias Brugger <matthias.bgg@gmail.com>
+
+properties:
+  compatible:
+    oneOf:
+      - enum:
+          - mediatek,mt2701-hifsys
+          - mediatek,mt7622-hifsys
+      - items:
+          - enum:
+              - mediatek,mt7623-hifsys
+          - const: mediatek,mt2701-hifsys
+
+  reg:
+    maxItems: 1
+
+  "#clock-cells":
+    const: 1
+    description: The available clocks are defined in dt-bindings/clock/mt*-clk.h
+
+  "#reset-cells":
+    const: 1
+
+required:
+  - reg
+  - "#clock-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    clock-controller@1a000000 {
+        compatible = "mediatek,mt2701-hifsys";
+        reg = <0x1a000000 0x1000>;
+        #clock-cells = <1>;
+        #reset-cells = <1>;
+    };
-- 
2.35.3


