Return-Path: <linux-kernel+bounces-34884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD5D68388C8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 09:22:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2B451C21CC9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 08:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C728B57324;
	Tue, 23 Jan 2024 08:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="khUXRvj0"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66FBF56B73;
	Tue, 23 Jan 2024 08:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705998109; cv=none; b=JoFUs0n7zC9OEPnhzVG8AqCbAautcuOevJ4mvB0tFsWSOikErzHVLIrGJ4zNqsl4HostchWI+ZMzYkTwLNkHA1IoGh3K65PgdEJgB+0tfDQv9TIFajRTFZwJtEXH+UVEK86jg2+IZTokVcP18t1QMDl6u0/ICuCzHMhDpEjihp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705998109; c=relaxed/simple;
	bh=LkV+gvkBqIyRQD5IKrHVX65y2ftsGru9KKJxK5J+9MI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OoMuSFajIHpJQtO8mDKDMys8ZBPi5KX43lX96hAB5Ju0zpn6pqhXiSnNF4C/53irfbn2BtKD/v6CXzf7Os9UHL/qU8JoNxK8CkPfUdJuc/35NMXg1WmKPrh0FRhDBuOH8/Tn0vhI3wK6UVCbV/hxPvWn8g/u9n08XXvrHQ3baLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=khUXRvj0; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-55a5e7fa471so3519590a12.1;
        Tue, 23 Jan 2024 00:21:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705998105; x=1706602905; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H0AEjAgTGGFMtUqCGTJO2UhVRa/rSiFP8yyo/+7uwmo=;
        b=khUXRvj0crHVe91bvzQjfEizc8vxuXjqyxAgxD9ntm8IN1vUw6Wgv8/uOg89+RNqOt
         9TzWSKcpmCphOZw4w1hHMzPs/w2VlKCDDxgxlq1HCt7hLvbJ4aK05j0th3P4WQF4H2ik
         JGJZ1p/OA5M0Ydey8I5fV9MSg2k+oWW6/wLOh8wncL/TD0+6PVfu1EY9QCg8AxInlclA
         0YX4z/nOIFGGlVE0LxjvfQplIfTlmRlOXpAzdhym8tG74eBvB90E579/xml/AOFz4AJh
         l2KZI4nQrySD7+5YeBIenN43NzinvgPP2A2O3PedFRFO+lOu/gVweTTD3lUn8a9fBiph
         5c8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705998105; x=1706602905;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H0AEjAgTGGFMtUqCGTJO2UhVRa/rSiFP8yyo/+7uwmo=;
        b=Hkvsg2QjMDKpQclKNeChSzNgJCWBR0kgNO80j87UlqjE5grveLPYjRQ7lpa2mk5vRn
         LXoOJeBpfN7V5Bpk7gib6luuOGhGrqRz3wd/qJ7WuLtyZ3kFk7LcU7V1DYJnHVb5TK/T
         TnMvmtip5UksB51noh8gl9NlUIhhul/n1WcIZArMHrzPnyr6NaPS0btH8z5P91TE+Rxm
         JvCnF/Yf06pwaEGGZ+hcve4VFmvZjiSErwXMUP4m3JB8DYDWSuccsHzIiEtnhe7cy+PC
         QjHq2tmEmCTMqoT5BPO8Mu4rijpodd1VMGbRuuxrfvbTnHMzm255N/u8MJuHbdZ7f0tw
         bf2w==
X-Gm-Message-State: AOJu0YxI3FqM8dvNkEMiT7TOsm80TBq9/PHyLAxWBDb2OCtaeJ0JrPcx
	TWARHz0U+RwGVrR/ciiSdY3i5+O7EeSmyN6cBZI5MeODnYQIPcSR
X-Google-Smtp-Source: AGHT+IFqyvfBHcMnmtge3pmJlzokQ72yrfVfJpGffdlahMNIUJ7oKdfR2E7/e4UDrY5ANyfC8Q3ESA==
X-Received: by 2002:a05:6402:40cd:b0:55c:876c:ca06 with SMTP id z13-20020a05640240cd00b0055c876cca06mr298074edb.29.1705998105575;
        Tue, 23 Jan 2024 00:21:45 -0800 (PST)
Received: from localhost.lan (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.gmail.com with ESMTPSA id u11-20020a056402110b00b00558aa40f914sm14810435edv.40.2024.01.23.00.21.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 00:21:45 -0800 (PST)
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
Subject: [PATCH 2/3] dt-bindings: arm: mediatek: convert PCIESYS to the json-schema
Date: Tue, 23 Jan 2024 09:20:59 +0100
Message-Id: <20240123082100.7334-3-zajec5@gmail.com>
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
 .../arm/mediatek/mediatek,mt7622-pciesys.yaml | 47 +++++++++++++++++++
 .../arm/mediatek/mediatek,pciesys.txt         | 25 ----------
 2 files changed, 47 insertions(+), 25 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,mt7622-pciesys.yaml
 delete mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,pciesys.txt

diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt7622-pciesys.yaml b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt7622-pciesys.yaml
new file mode 100644
index 000000000000..7340a2512402
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt7622-pciesys.yaml
@@ -0,0 +1,47 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/mediatek/mediatek,mt7622-pciesys.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek PCIESYS controller
+
+description:
+  The MediaTek PCIESYS controller provides various clocks to the system.
+
+maintainers:
+  - Matthias Brugger <matthias.bgg@gmail.com>
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - mediatek,mt7622-pciesys
+          - mediatek,mt7629-pciesys
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
+    pciesys@1a100800 {
+        compatible = "mediatek,mt7622-pciesys", "syscon";
+        reg = <0x1a100800 0x1000>;
+        #clock-cells = <1>;
+        #reset-cells = <1>;
+    };
diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,pciesys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,pciesys.txt
deleted file mode 100644
index d179a61536f4..000000000000
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,pciesys.txt
+++ /dev/null
@@ -1,25 +0,0 @@
-MediaTek PCIESYS controller
-============================
-
-The MediaTek PCIESYS controller provides various clocks to the system.
-
-Required Properties:
-
-- compatible: Should be:
-	- "mediatek,mt7622-pciesys", "syscon"
-	- "mediatek,mt7629-pciesys", "syscon"
-- #clock-cells: Must be 1
-- #reset-cells: Must be 1
-
-The PCIESYS controller uses the common clk binding from
-Documentation/devicetree/bindings/clock/clock-bindings.txt
-The available clocks are defined in dt-bindings/clock/mt*-clk.h.
-
-Example:
-
-pciesys: pciesys@1a100800 {
-	compatible = "mediatek,mt7622-pciesys", "syscon";
-	reg = <0 0x1a100800 0 0x1000>;
-	#clock-cells = <1>;
-	#reset-cells = <1>;
-};
-- 
2.35.3


