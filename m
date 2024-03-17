Return-Path: <linux-kernel+bounces-105539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3A1187DFE5
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 21:03:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CBB01F2137A
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 20:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3042C1CFBD;
	Sun, 17 Mar 2024 20:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UA0zPJ4F"
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147F41F932;
	Sun, 17 Mar 2024 20:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710705787; cv=none; b=ISf0l9WoPNfJZBrb5hJR8gr4rhYCxRL+HRp7JYle0R6LC8+xRmjKGgulKzcyjmbv8YZK0hEAy+OuEgvBztI0EO4DJK4s9F+o7tlQ2s2hs5SrMHPfI1lKj1NSybj7nI1OmE1ScP0W/u07aoV9SCoT8pAMWBqloZVtPknyfQY/V0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710705787; c=relaxed/simple;
	bh=b+klqnyfe0YnC/TL4XDDqg3dXWyUC+H1iO4435OmZps=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NlcnvhaU0ZjGEkf+9wU/CXZyougyvo4R29zDuY4Ae6cgToHcDD5SRX/uP2qx3vPFfUuipl8xBVG/X46X8PNTK+BlVvCdAKtdfv59HmcS4YYCrx/4Qf3yiRhyiLnj1bxYrGpmgsR6Gagi/Uk8+ovsQjJEJxA2bPwg7f1EHaS+Grs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UA0zPJ4F; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3c1a2f7e1d2so2402575b6e.1;
        Sun, 17 Mar 2024 13:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710705785; x=1711310585; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AAhhHrdfiqKB/PMEr6cjMivPoonxiX0+EO7CFoEWz6Y=;
        b=UA0zPJ4FEUfNBMMgKUkUJlwbFrQJ/qbzfaQ4Z7V+mErfZKo/RN69MOf7SOBYF1pFem
         ZFx7yRhc2Fd+Hq9aRuylO8kQXHRfl5Mw2RNwM1sFQZtUg04Z4nJS3ex6rEBPqs0YslN9
         B673R8jtuLAqdF4Lkz8lDaOJ7Xors3dbqB6tHXl0GhDorVQQB+uFkgyokqbE8i9tPbWt
         C1OljgWaHPq92Ed6uD1RvdQfC90sgC16F06QRqQOh4EA1Kmlbn9z3c0CFhlQ3VsO1cXM
         SBbf/DZZJQ98JsuM/xvLSlQbVGo0X7NPUsoCsQQJ3fw5ls2lpqEPhHiD0U+MRXMQ8P38
         WDMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710705785; x=1711310585;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AAhhHrdfiqKB/PMEr6cjMivPoonxiX0+EO7CFoEWz6Y=;
        b=DqHN76gH+AnGHpKnMkZ/wkBKW5jtsNQGzQuK3mbHmYbuh7KM8fR4kgGH3EFsCLqPs8
         LJVKOzp2p1fOicwlFHLg4eppIIuMA6StmoMyCnAZW000odTSI3wghm2yFbZ5500a06ny
         eKXeXCj0HFdWu3TgJi5sxa6Ws3Gfk1ujcpEBVLt+Ad0VcEV4Sieh/iHo0Yf0fljDyg5m
         d0GCpi1Jz+8cYnlnGeGQ9TuLpsEZ5tsrIYdCNIQoP05b7LIXaXFQn1I9ZF1MIAoFTLBm
         Th3FUbfwrhFBVU+BY8lZf1pCPv9KcPVGkWL76ncLK/p+V3Zmoi6qL3H3AV1vgpvgf7VK
         FXKg==
X-Forwarded-Encrypted: i=1; AJvYcCWQzAIq2XicLmjQbYwJHSmmzLjaZrUovkqWbQfKqcF57Me6eWsZcr80rNIWTkD8tr2liUJIq5ftztTFmQ9HoN8HjnT0+QEerPRVTVKK09pvayD1yJGd7W1drO39QRgrWHqTpc+yFl8AKZ+NPUL1SlJuBBHdxeCbaiNqoUTmYJg9aSkLXjb5
X-Gm-Message-State: AOJu0YyAukbVHOn3LzEytuXN2b/BBf3+ECefabfUalw+sfuWKgvX++e9
	FexVN97t7FC02Yf5COEqqHWPW9sgCSK/LCQeIj5PTNO4yYnaZ8bhcAfM2Hba0C0=
X-Google-Smtp-Source: AGHT+IEfJD9ZJLagGvHrTHh+cd0puaQb2fxMo6CrYuJX4xlnbSK44LQM/BTQj8KbLEVjXIATxanmBw==
X-Received: by 2002:a05:6359:310f:b0:17e:bb52:927f with SMTP id rh15-20020a056359310f00b0017ebb52927fmr6091981rwb.1.1710705784975;
        Sun, 17 Mar 2024 13:03:04 -0700 (PDT)
Received: from localhost ([103.139.191.219])
        by smtp.gmail.com with UTF8SMTPSA id 4-20020a056a00070400b006e71d70c795sm1320856pfl.96.2024.03.17.13.03.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Mar 2024 13:03:04 -0700 (PDT)
From: Kartik Agarwala <agarwala.kartik@gmail.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org
Cc: Kartik Agarwala <agarwala.kartik@gmail.com>,
	patches@opensource.cirrus.com,
	linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	javier.carrasco.cruz@gmail.com
Subject: [PATCH] ASoC: dt-bindings: wm8776: Convert to dtschema
Date: Mon, 18 Mar 2024 01:32:02 +0530
Message-Id: <20240317200201.119233-1-agarwala.kartik@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert WM8776 audio CODEC bindings from text to dtschema.

Signed-off-by: Kartik Agarwala <agarwala.kartik@gmail.com>
---
 .../devicetree/bindings/sound/wlf,wm8776.yaml | 41 +++++++++++++++++++
 .../devicetree/bindings/sound/wm8776.txt      | 18 --------
 2 files changed, 41 insertions(+), 18 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/wlf,wm8776.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/wm8776.txt

diff --git a/Documentation/devicetree/bindings/sound/wlf,wm8776.yaml b/Documentation/devicetree/bindings/sound/wlf,wm8776.yaml
new file mode 100644
index 000000000..7bbc96ee8
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/wlf,wm8776.yaml
@@ -0,0 +1,41 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/wlf,wm8776.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: WM8776 audio CODEC
+
+maintainers:
+  - patches@opensource.cirrus.com
+
+allOf:
+  - $ref: dai-common.yaml#
+
+properties:
+  compatible:
+    const: wlf,wm8776
+
+  reg:
+    maxItems: 1
+
+  "#sound-dai-cells":
+    const: 0
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        codec@1a {
+            compatible = "wlf,wm8776";
+            reg = <0x1a>;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/sound/wm8776.txt b/Documentation/devicetree/bindings/sound/wm8776.txt
deleted file mode 100644
index 01173369c..000000000
--- a/Documentation/devicetree/bindings/sound/wm8776.txt
+++ /dev/null
@@ -1,18 +0,0 @@
-WM8776 audio CODEC
-
-This device supports both I2C and SPI (configured with pin strapping
-on the board).
-
-Required properties:
-
-  - compatible : "wlf,wm8776"
-
-  - reg : the I2C address of the device for I2C, the chip select
-          number for SPI.
-
-Example:
-
-wm8776: codec@1a {
-	compatible = "wlf,wm8776";
-	reg = <0x1a>;
-};
-- 
2.34.1


