Return-Path: <linux-kernel+bounces-34885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2427C8388CD
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 09:22:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46710B25396
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 08:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88BC158116;
	Tue, 23 Jan 2024 08:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SgYG78iL"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1431857306;
	Tue, 23 Jan 2024 08:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705998110; cv=none; b=nAUKH3GdnpDVkWLLh9Unif5Od8E0E2jkZdl4ycAVj/HOHty36ItusdAVoono64jQ6jofHgz43bCpoKCHB7gMCc7KiR3jdUfkDvfwOsiQeMq3W6W/oRG0KytALN+Ofb3qOXiYQ4L/dJ8D72XkkVDMWAGLUAiJzvdwPFp6LqBRvzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705998110; c=relaxed/simple;
	bh=E7RRp9S8O9GUe0hGW5IZaZwOOYkyBJFuAwnZqYZwZPM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MIT50JLAGN9V4yIryyyEazp0+DX8UvpyIhfDwU2d79hofBqCWYgNDoNNIkWL9XMGBE3tfaXLBgpkygnf0nCYHBe3WSarMo4N+KTa/AKMv3RQ+2F8tHmis8e0KgCzx1HqdJ1vMu0Pog2HhbTedg90Lubjh93tVHzsTFK7PdaW82I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SgYG78iL; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-55a6833c21eso2858982a12.2;
        Tue, 23 Jan 2024 00:21:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705998107; x=1706602907; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r9YKyvRBtWfutykiie3fQAavhzcW2AS6pKksKHu05ys=;
        b=SgYG78iL2NcIhFRz7uONL9OrXQaWilSsR7WGPFl2GJB3Rg+bQY+exogp492lkSfcdy
         6ZLu+WhHbBMieLZzjXSqVQ7Dv21a+/eS0QokjpZd2K0splwbMtpXjxLlF1BCufv0oDFQ
         48Dgw/qZ7G4uINbRHv27knqetWlHwJMkLkLx/ShoLy8YqHgsewwUA5pdfDIeAWZCM3HE
         5oXmR2Tl05F9o8fndsjHkX2jz406UTL5RFZRyfqbuYNmIkHUwIVb42RcuAqfTBZejBaA
         rsVuhqijLL9gXM7zj5xnTV810+8o71OOhiMeXrF0S3x12+ehg2usMWzdAI1svxgQTbFE
         /N7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705998107; x=1706602907;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r9YKyvRBtWfutykiie3fQAavhzcW2AS6pKksKHu05ys=;
        b=ujDG2iyPYhSn51zEKYZjq6pSqfUc9+mip7Wh9h2Nb1fjWz0OlZOqINcIyIA5caZh/a
         azvRidC44CWg5TIg5dDh/gAwvpKVnl2pgLswmrmPdkYVV+BD73GZHRy0JJYFW8LuoD/0
         d6gYa5b49PZiYB8/8EZGE385oduhsP+rn1AiPILLjdb6h4TkHASArkWpdp163VoIVRhq
         moAYa9j1qfs/e8UWYIkP/ejXCAV3zjQ7ruT3Hs2XbEBcWc28Mex/Mgm0U57w76ZJcJYH
         nGA9JX1vRnvXL45D5i4D1G1EtPPab05lMNpuGw2BICsmXROLKpo3NaPsl3DTh5bOzWXH
         Ugmg==
X-Gm-Message-State: AOJu0Yzbx9vj3Jr6JNMOFQUKSfy33ar0h8yBKCOFW0EDrgsdvZD8qcf1
	sdtw1AKOlNYzWGP7kE40lkUNtTcLa/wg0D2ockGFLFc6knw1xRLG28Ew7yhf
X-Google-Smtp-Source: AGHT+IFqBjCm38TDwMPz7ittv6kiKxIxDBv5sr4avSsf45RUj4/Dfsfek1x27WclHwGOxCYFnKSAiA==
X-Received: by 2002:a05:6402:290b:b0:55a:7191:b301 with SMTP id ee11-20020a056402290b00b0055a7191b301mr681287edb.48.1705998107113;
        Tue, 23 Jan 2024 00:21:47 -0800 (PST)
Received: from localhost.lan (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.gmail.com with ESMTPSA id u11-20020a056402110b00b00558aa40f914sm14810435edv.40.2024.01.23.00.21.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 00:21:46 -0800 (PST)
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
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH 3/3] dt-bindings: arm: mediatek: convert SSUSBSYS to the json-schema
Date: Tue, 23 Jan 2024 09:21:00 +0100
Message-Id: <20240123082100.7334-4-zajec5@gmail.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240123082100.7334-1-zajec5@gmail.com>
References: <20240123082100.7334-1-zajec5@gmail.com>
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
2. Adjusted "reg" in example

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 .../mediatek/mediatek,mt7622-ssusbsys.yaml    | 47 +++++++++++++++++++
 .../arm/mediatek/mediatek,ssusbsys.txt        | 25 ----------
 2 files changed, 47 insertions(+), 25 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,mt7622-ssusbsys.yaml
 delete mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,ssusbsys.txt

diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt7622-ssusbsys.yaml b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt7622-ssusbsys.yaml
new file mode 100644
index 000000000000..7a5343e4fcf4
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt7622-ssusbsys.yaml
@@ -0,0 +1,47 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/mediatek/mediatek,mt7622-ssusbsys.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek SSUSBSYS controller
+
+description:
+  The MediaTek SSUSBSYS controller provides various clocks to the system.
+
+maintainers:
+  - Matthias Brugger <matthias.bgg@gmail.com>
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - mediatek,mt7622-ssusbsys
+          - mediatek,mt7629-ssusbsys
+      - const: syscon
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
+  - "#reset-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    ssusbsys@1a000000 {
+        compatible = "mediatek,mt7622-ssusbsys", "syscon";
+        reg = <0x1a000000 0x1000>;
+        #clock-cells = <1>;
+        #reset-cells = <1>;
+    };
diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,ssusbsys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,ssusbsys.txt
deleted file mode 100644
index 7cb02c930613..000000000000
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,ssusbsys.txt
+++ /dev/null
@@ -1,25 +0,0 @@
-MediaTek SSUSBSYS controller
-============================
-
-The MediaTek SSUSBSYS controller provides various clocks to the system.
-
-Required Properties:
-
-- compatible: Should be:
-	- "mediatek,mt7622-ssusbsys", "syscon"
-	- "mediatek,mt7629-ssusbsys", "syscon"
-- #clock-cells: Must be 1
-- #reset-cells: Must be 1
-
-The SSUSBSYS controller uses the common clk binding from
-Documentation/devicetree/bindings/clock/clock-bindings.txt
-The available clocks are defined in dt-bindings/clock/mt*-clk.h.
-
-Example:
-
-ssusbsys: ssusbsys@1a000000 {
-	compatible = "mediatek,mt7622-ssusbsys", "syscon";
-	reg = <0 0x1a000000 0 0x1000>;
-	#clock-cells = <1>;
-	#reset-cells = <1>;
-};
-- 
2.35.3


