Return-Path: <linux-kernel+bounces-148610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8152D8A850B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 15:43:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34C9B1F220F7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 13:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FA4A140380;
	Wed, 17 Apr 2024 13:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mzr1YN7d"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67CEF13F00A;
	Wed, 17 Apr 2024 13:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713361369; cv=none; b=pNzCqwTn+LsVyTTfnSgED06yMMInDBl0Ilbp9eTGyvYxPoE7+/Y+eWVd27I/bKqo90azcWB4njCLQYeksqeX3nhXtfejrKfIKHbshm3GJQ4JZFCAog3wcsN5AlQhkTZD5pYqQJnvkBiqeCPSNSMBkbFcvhZQe6LJb5gSORKvh1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713361369; c=relaxed/simple;
	bh=Z6KTTpXbkxPN1Coo6PV3hmulcZTzMQIXfC8cpd/fduw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SQFOxgv6M7lveuUUr7iX8GyibTX62fJ13eMT4P/K3HY5sK9rmCSNlSU376nApV4ro0dwOEpBNca5Croy19hFmCZdH262DiHxnKTFThHrjhD1EQsvap0edGdZ4w9HKU4vjBtvi1Vm4K20fqq6Q1cSqGV6PEXlJemM5BxgCVIN4Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mzr1YN7d; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1e2c725e234so6615465ad.1;
        Wed, 17 Apr 2024 06:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713361368; x=1713966168; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mKUxn1aArk3LQL9fXJQSAOcunhIx4UjEZdsUQAPhyi8=;
        b=Mzr1YN7d54s745MkSl29PI4QpTX8fEAyvEt/KqweKzzrogqp0j756kFdSv3JRsI4Do
         ZgNyvSIu458U6bor1X6lkJJpIfsboycNM8PX82nXxwKGJwOTbu4yhjyDTTu/AcUPkGG1
         eMODo48AwZp7ZGHPCisxKLkDRJDgLr6xC1vVGT6ZsonW3LA5RO4PsgFa+vqPYUKzHWKm
         sN1VN/NMtLKyzBxgFiN5iQ1P4G8v3LrjArpfWLC+ROn5Fw1W1+cwuqS6tRb85F/oOw3I
         doFw5QAQqgHT2fSqX5R6Vlf01k8jDnsf+EGP23VtgXJqrnmNWGm4FWDjiBvfH2k2pac3
         FXdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713361368; x=1713966168;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mKUxn1aArk3LQL9fXJQSAOcunhIx4UjEZdsUQAPhyi8=;
        b=NFyBcZG7WeeJqPp+zpMoiSXwJNZNooxQ3bFOGGTq/G33LEY1EsMOLcGC+k9KBjDStf
         NZB2CAAR9i+MDnnNxJxSjjMNXIWdmSP9Fih8MGLvKSorI78bH9nY5INS+Mw2nnYg7rM5
         zZiV/ekXnJBkmQm9iiR2rYFmTAmYf5h0Jvd7XI27ud6nK+kzCTL04dzDx1Oj5vXN35Lp
         xMfRt7zhs6W7O4MOLr4WNJBZlJI59s601ySTCIS2qbSpBOuIQ2aMacROknFSeo9mBMH9
         NtcsBW9uwe225Ogu+Lh814XWrLgGeiFsUPBPWHak7hBQP/z6OdifdT17MaOtHWkFsg1i
         xMOw==
X-Forwarded-Encrypted: i=1; AJvYcCVZFM7e/mFmwEmF+OaqKkLfu1Gt1OQ3wpC2iy2YQ3gqhM1ZWXlAq4T7WrxC4qpAvnbGCpMpvQhLZ69skksUnXR38HegoL6KorBTZzTkWGfbeMK8RdpRTjcGWu8epY5FRXxF1RoB3+cr9ZEZtjCQXZnGBdCQ6mcSBUydYR7kCiB8UvL9AeAD
X-Gm-Message-State: AOJu0Yx0SJIqkaVnASJeIOKH7jQFE7t1x2eDiAUg7W15XaLUOLW5v/dr
	wZn9ckybCE+DijbA7il8+T37jl2o3sHf6yARoo7i6L7HttqQUkEJ
X-Google-Smtp-Source: AGHT+IG+ez/RdMy97j0G4ssolQFiRmkaiiYuB7OGoN8y0FJ9CT1Q0Hxno7vIq42pMfMIBESJm8bVEQ==
X-Received: by 2002:a17:902:f68c:b0:1e0:e8b5:3225 with SMTP id l12-20020a170902f68c00b001e0e8b53225mr6857432plg.12.1713361367456;
        Wed, 17 Apr 2024 06:42:47 -0700 (PDT)
Received: from localhost.localdomain ([103.14.183.131])
        by smtp.gmail.com with ESMTPSA id q14-20020a170902a3ce00b001e3f54f90ecsm6234834plb.300.2024.04.17.06.42.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 06:42:46 -0700 (PDT)
From: Mighty <bavishimithil@gmail.com>
To: 
Cc: Mithil Bavishi <bavishimithil@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4] ASoC: dt-bindings: omap-mcpdm: Convert to DT schema
Date: Wed, 17 Apr 2024 19:12:36 +0530
Message-Id: <20240417134237.23888-1-bavishimithil@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mithil Bavishi <bavishimithil@gmail.com>

Convert the OMAP4+ McPDM bindings to DT schema.

Signed-off-by: Mithil Bavishi <bavishimithil@gmail.com>
---
 .../devicetree/bindings/sound/omap-mcpdm.txt  | 30 ----------
 .../bindings/sound/ti,omap4-mcpdm.yaml        | 58 +++++++++++++++++++
 2 files changed, 58 insertions(+), 30 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/omap-mcpdm.txt
 create mode 100644 Documentation/devicetree/bindings/sound/ti,omap4-mcpdm.yaml

diff --git a/Documentation/devicetree/bindings/sound/omap-mcpdm.txt b/Documentation/devicetree/bindings/sound/omap-mcpdm.txt
deleted file mode 100644
index ff98a0cb5..000000000
--- a/Documentation/devicetree/bindings/sound/omap-mcpdm.txt
+++ /dev/null
@@ -1,30 +0,0 @@
-* Texas Instruments OMAP4+ McPDM
-
-Required properties:
-- compatible: "ti,omap4-mcpdm"
-- reg: Register location and size as an array:
-       <MPU access base address, size>,
-       <L3 interconnect address, size>;
-- interrupts: Interrupt number for McPDM
-- ti,hwmods: Name of the hwmod associated to the McPDM
-- clocks:  phandle for the pdmclk provider, likely <&twl6040>
-- clock-names: Must be "pdmclk"
-
-Example:
-
-mcpdm: mcpdm@40132000 {
-	compatible = "ti,omap4-mcpdm";
-	reg = <0x40132000 0x7f>, /* MPU private access */
-	      <0x49032000 0x7f>; /* L3 Interconnect */
-	interrupts = <0 112 0x4>;
-	interrupt-parent = <&gic>;
-	ti,hwmods = "mcpdm";
-};
-
-In board DTS file the pdmclk needs to be added:
-
-&mcpdm {
-	clocks = <&twl6040>;
-	clock-names = "pdmclk";
-	status = "okay";
-};
diff --git a/Documentation/devicetree/bindings/sound/ti,omap4-mcpdm.yaml b/Documentation/devicetree/bindings/sound/ti,omap4-mcpdm.yaml
new file mode 100644
index 000000000..73fcfaf6e
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/ti,omap4-mcpdm.yaml
@@ -0,0 +1,58 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/ti,omap4-mcpdm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: OMAP McPDM
+
+maintainers:
+  - Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
+
+description:
+  OMAP ALSA SoC DAI driver using McPDM port used by TWL6040
+
+properties:
+  compatible:
+    const: ti,omap4-mcpdm
+
+  reg:
+    items:
+      - description: MPU access base address
+      - description: L3 interconnect address
+
+  interrupts:
+    maxItems: 1
+
+  ti,hwmods:
+    description: Name of the hwmod associated to the McPDM, likely "mcpdm"
+
+  clocks:
+    description: phandle for the pdmclk provider, likely <&twl6040>
+
+  clock-names:
+    description: Must be "pdmclk"
+
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - ti,hwmods
+  - clocks
+  - clock-names
+
+additionalProperties: false
+
+examples:
+  - |
+    pdm@0 {
+      compatible = "ti,omap4-mcpdm";
+      reg = <0x40132000 0x7f>, /* MPU private access */
+            <0x49032000 0x7f>; /* L3 Interconnect */
+      interrupts = <0 112 0x4>;
+      interrupt-parent = <&gic>;
+      ti,hwmods = "mcpdm";
+      clocks = <&twl6040>;
+      clock-names = "pdmclk";
+    };
-- 
2.34.1


