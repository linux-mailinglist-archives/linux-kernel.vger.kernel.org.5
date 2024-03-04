Return-Path: <linux-kernel+bounces-90723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CAA48703F5
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 15:24:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E4CD1C21D7B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 14:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7024645BE7;
	Mon,  4 Mar 2024 14:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eH4AwPmQ"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2B0405F8;
	Mon,  4 Mar 2024 14:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709562239; cv=none; b=V6B5grBMlkOnGL+sGT5IFmyxCi12IZiE0cRv1T2RgINV9FHzylUaHiNrNKKSSLkYJhnI6fiKXCVYEgdTZ00IjnzS9c9enQ+0di7rode0QhXidJDXXcmOA+bxRKBlgifXF6m1DO4XZLD1IvmbXdEFz9TgTSEQg2bjj7NwRBtw6Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709562239; c=relaxed/simple;
	bh=/Af1OqvaKj+Y/we0Ts7Sbh6sS0efeCNow+1SafjuFO4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=B60+an3X6k8uA83v8vLjSTWYUqiMQUEAWExTPmHdDcIAfi+XMli0yDOAF1C9XWslqVKp/c5iqtW/ei85n8yzcel7XVd62jfedQOQO2rLSB6hXnwh2TLCAAF+QO9/c+AMrp6VQzz5BcoYe9Fl/Q6xk9tVKeItdLbAY5YCR2BE3nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eH4AwPmQ; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-33d568fbf62so2364227f8f.3;
        Mon, 04 Mar 2024 06:23:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709562236; x=1710167036; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=apaBpVQtA1STXfsjN2l+EhbnfJdRR6DZH9EsOTj0lX4=;
        b=eH4AwPmQ3u+g/XndhdwZI8V7XWRMXhZNEHCh0ApkgeEaJ4e1xSq1a6Z2AeUSYmHKb8
         KF28hAfNlg4tF2BkFg2od08mnYYW3Y4J5XqXxe3Dw/ytVBNraXNHyMNilmbO72TkoZGS
         vBn6Xe4+ehDXM1jWfZaaEq8PqpCOIqkljpHlmWbZACWzUJYjMGd5NF03g75ECbHmlzu5
         EwPKTo/n02iA87AyWQTbgVfuE1QbKilm43XWAA+WtYSvk1tYFhuieLXK6XQg8/ZuZkX2
         FY/zJkWTbGDLIPpK2IsrzAA1b0JMfd5nvHqM7kUswN8NDyGSPKJdcetnuWWMoR4RxfzV
         6Srw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709562236; x=1710167036;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=apaBpVQtA1STXfsjN2l+EhbnfJdRR6DZH9EsOTj0lX4=;
        b=HhDZfIJWjXMRsywSDLwzZzIUyVp+C3irZcwgy2agzXMkrh0iV/5M3f25+Y2mhuoqEP
         EHZfpVS78dq6GwXmFjoQZpt2Vs/Am3VxKvtisVyD6H2/hzWxFHJboOcUNtWCVg9+bf9i
         qKrRGL0j/fww1ZtP3PjqRSAFLH63YDK3oSg95R7GQtFyRYb87vceXNQwZ6nsMDO7Ze7w
         irXqWj7+p3R/rb7W2vKqecFocZmaTgeKNAs+6IDUOiqQjbUlNRu0k0Wkm2c1rR6+xL8C
         jKrZokXLM6zJjS2IfqP4127RhXZuiKIuynrZ/jrND3i0kqDXUUmk4X0yJILbClpf1Zb/
         P78w==
X-Forwarded-Encrypted: i=1; AJvYcCXGbMFDW2mgGN8/LyGeTz2hOnG0DcAWXzIQOufMcxeUCDv2o5KM/cbx4oGHqUHegZwUiDfJNVv5Ym7FcjuL0uv6UarJC4SiQGMpWi3/bMSN1p8THNG/HWKDEb01xLkuzdkyFQOOWRETDA==
X-Gm-Message-State: AOJu0YzFmdYjgINUmS1Hv2HTyVXcyRCk4tq00yAulR+JByugmp1z2gky
	usU7VUzs0evlP4njtwWSxaYD7KOs1xa9VLXr3o1b220ujS7aKtS7
X-Google-Smtp-Source: AGHT+IGg2MH7GT1C+UoWFBUBjsuKghbrFQ0VkykOdak4bcjOJxYr/eYANQGF+LIh5pxi2hOHce8Bmw==
X-Received: by 2002:a05:6000:1249:b0:33d:2226:a28b with SMTP id j9-20020a056000124900b0033d2226a28bmr6152789wrx.37.1709562236222;
        Mon, 04 Mar 2024 06:23:56 -0800 (PST)
Received: from tuxserver.lan ([79.116.0.170])
        by smtp.googlemail.com with ESMTPSA id bs19-20020a056000071300b0033daaef7afcsm12636594wrb.83.2024.03.04.06.23.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 06:23:55 -0800 (PST)
From: =?UTF-8?q?Javier=20Garc=C3=ADa?= <javier.gar.tab@gmail.com>
To: 
Cc: javier.gar.tab@gmail.com,
	daniel.baluta@nxp.com,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jack Yu <jack.yu@realtek.com>,
	alsa-devel@alsa-project.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: dt-bindings: rt1015: Convert to dtschema
Date: Mon,  4 Mar 2024 15:23:07 +0100
Message-ID: <20240304142315.14522-1-javier.gar.tab@gmail.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Convert the RT1015 Mono Class D Audio Amplifier to DT schema.

Signed-off-by: Javier García <javier.gar.tab@gmail.com>
---
 .../bindings/sound/realtek,rt1015.yaml        | 41 +++++++++++++++++++
 .../devicetree/bindings/sound/rt1015.txt      | 23 -----------
 2 files changed, 41 insertions(+), 23 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/realtek,rt1015.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/rt1015.txt

diff --git a/Documentation/devicetree/bindings/sound/realtek,rt1015.yaml b/Documentation/devicetree/bindings/sound/realtek,rt1015.yaml
new file mode 100644
index 000000000000..880196081a60
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/realtek,rt1015.yaml
@@ -0,0 +1,41 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/realtek,rt1015.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: RT1015 Mono Class D Audio Amplifier
+
+maintainers:
+  - Jack Yu <jack.yu@realtek.com>
+
+properties:
+  compatible:
+    enum:
+      - realtek,rt1015
+
+  reg:
+    maxItems: 1
+
+  realtek,power-up-delay-ms:
+    description: Set a delay time for flush work to be completed,
+      this vlaue is adjustable depending on platform.
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        codec@28 {
+            compatible = "realtek,rt1015";
+            reg = <0x28>;
+            realtek,power-up-delay-ms = <50>;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/sound/rt1015.txt b/Documentation/devicetree/bindings/sound/rt1015.txt
deleted file mode 100644
index e498966d436f..000000000000
--- a/Documentation/devicetree/bindings/sound/rt1015.txt
+++ /dev/null
@@ -1,23 +0,0 @@
-RT1015 Mono Class D Audio Amplifier
-
-This device supports I2C only.
-
-Required properties:
-
-- compatible : "realtek,rt1015".
-
-- reg : The I2C address of the device.
-
-Optional properties:
-
-- realtek,power-up-delay-ms
-  Set a delay time for flush work to be completed,
-  this value is adjustable depending on platform.
-
-Example:
-
-rt1015: codec@28 {
-	compatible = "realtek,rt1015";
-	reg = <0x28>;
-	realtek,power-up-delay-ms = <50>;
-};
-- 
2.41.0


