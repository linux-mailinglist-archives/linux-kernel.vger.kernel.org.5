Return-Path: <linux-kernel+bounces-34883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA00D8388C4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 09:22:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE6B7B24B73
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 08:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C371156B81;
	Tue, 23 Jan 2024 08:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AqvjUQ/T"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541EC5675F;
	Tue, 23 Jan 2024 08:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705998107; cv=none; b=Q8JQzdU4ZSqxIqY55BTWV4EZctN2Aqm3d4Lx+IFyEjp/BqvSShyrBJ507GW5XiPCKy6gipOwiyYQzZGvbvgEfc6aE2/9y56J2LxoNR5ktlxxbM0DuH1BZq9xlmt2fuu4QV2JoSHGt++tcQ313DnTxsvN7jwALds8qwTDlf0d70c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705998107; c=relaxed/simple;
	bh=h9NzIypt+ErDMOb+T+NaWp7PEJ42pnIkt25bqJnPYVg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=quhSN4sGqynSz+CDUWK9GZXE0TTygyOmxy3hGVoaUfL7SQ4b3u1mJYtyYqt7fOwMZWqrKVkkc1MVtadMiKPHMP3n8PhjOi9xayMi0mR+OE2XmHqAnj1g1G/f5LzpY1+nYfwCMhZPMBewWz8psjchyBtEK52ub7h8A6hT04xtGh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AqvjUQ/T; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-55c6bc3dd54so1719506a12.1;
        Tue, 23 Jan 2024 00:21:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705998103; x=1706602903; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nhtLzN2peOVLFpsd1om60a/LkFzwt1x9izkXcUJXVvE=;
        b=AqvjUQ/TNiBqRQ9W8jInbWKe4PqKovYbGI+kIwxsrzcMIx/QiDORlQjZMbxXg/RMix
         fsxv9skCBGy3eprrajtis1rXPlkVp5hU5JSLqa3uKfmxUkGEseHRD+soMwpIWMnTUWWR
         HCcjC4R2Z2YtPxatrCahGlnOwlJ/SgoGPxEUi5PH0Lbt6jLWTzsj9G2aIVwZc/7+X/Gt
         2Q9g+teNa/GkL6Oz6/bo2zkjx/n3sj55F897Yg2U+iUDjmFJmXQbL6XgkmRHy628PZVb
         30Yb/ZeDOfJL2CEmIUpYBUHNM8+TavUM/66TFqiCFb4xJXluB3sDf40YVeq+RydYlXhu
         MVBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705998103; x=1706602903;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nhtLzN2peOVLFpsd1om60a/LkFzwt1x9izkXcUJXVvE=;
        b=uTMVqMENwrd9UOIl3FBZXKSRn+EoDAu/04rfUbTcaWRVSk6nI0Yh0rNNN0yEKvxtM2
         /0ymH1ZanpLSCbfi7Hgz2OOfsnza1sUvfs0clk/4T3DRBiYUBry/PsQBQ1A/rXAMbXU8
         DbaxaSnbo1aKfxl0S4Zdw2v4K1Bs5glP+DLwlyUhcb62wuHRi05GkP+Iw2Kgo9PtR1Wy
         Qxpb8i4Tx9ViM0RjYTR/r+CjyYorZV1oTihFPgib+J2aeMJIEmqQQGFJnXgogFedtZHq
         1EBPtrojT/b8DQL5P9q/1dF5rJxNPuL/VGs+aVuOYgfNpi3H0r6wVDwR0cH4m/9uY1a3
         CnWg==
X-Gm-Message-State: AOJu0Yy+zpsoJwX2A5dCTLbqo49+8IbDPfh5nTtjSpoXCSGSM/kc/1vs
	sC61Sxw2spsDljNNNzM4lSmc9cXpqfRi5WAsVgm6leaLSTkSCgg9
X-Google-Smtp-Source: AGHT+IFeT+fo7zdhLsWc7f2e9OUeawo1w/aO0aT4blSPx9Q4BKgzyaYapF2Et1MrqUvz7urpg1k9LA==
X-Received: by 2002:a05:6402:268f:b0:55c:828e:4bfa with SMTP id w15-20020a056402268f00b0055c828e4bfamr715282edd.12.1705998103286;
        Tue, 23 Jan 2024 00:21:43 -0800 (PST)
Received: from localhost.lan (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.gmail.com with ESMTPSA id u11-20020a056402110b00b00558aa40f914sm14810435edv.40.2024.01.23.00.21.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 00:21:42 -0800 (PST)
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
Subject: [PATCH 1/3] dt-bindings: arm: mediatek: convert hifsys to the json-schema
Date: Tue, 23 Jan 2024 09:20:58 +0100
Message-Id: <20240123082100.7334-2-zajec5@gmail.com>
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
2. Documented "#reset-cells" property
3. Adjusted "reg" in example

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 .../bindings/arm/mediatek/mediatek,hifsys.txt | 26 ---------
 .../arm/mediatek/mediatek,mt2701-hifsys.yaml  | 54 +++++++++++++++++++
 2 files changed, 54 insertions(+), 26 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,hifsys.txt
 create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,mt2701-hifsys.yaml

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
diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt2701-hifsys.yaml b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt2701-hifsys.yaml
new file mode 100644
index 000000000000..7c7b7b7b1142
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt2701-hifsys.yaml
@@ -0,0 +1,54 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/mediatek/mediatek,mt2701-hifsys.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Mediatek hifsys controller
+
+description:
+  The Mediatek hifsys controller provides various clocks and reset outputs to
+  the system.
+
+maintainers:
+  - Matthias Brugger <matthias.bgg@gmail.com>
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - const: mediatek,mt2701-hifsys
+          - const: syscon
+      - items:
+          - enum:
+              - mediatek,mt7623-hifsys
+          - const: mediatek,mt2701-hifsys
+          - const: syscon
+      - items:
+          - const: mediatek,mt7622-hifsys
+          - const: syscon
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
+        compatible = "mediatek,mt2701-hifsys", "syscon";
+        reg = <0x1a000000 0x1000>;
+        #clock-cells = <1>;
+        #reset-cells = <1>;
+    };
-- 
2.35.3


