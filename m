Return-Path: <linux-kernel+bounces-80031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E405E8629EB
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 11:03:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9391C1F2174B
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 10:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B468F4E2;
	Sun, 25 Feb 2024 10:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G/hocDDZ"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F54DD528;
	Sun, 25 Feb 2024 10:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708855430; cv=none; b=m8cjKJ0DnzrcwNozNt0kIizCm9wXmU8n2BhzmZv+elC2CxB7vHRF7uXVtv1w+XQdl7uoRDpKRq6MbL2TgdFd6HQ8lF/eMDDosHC76oqRL2FqeQ6EyC8nTIHv+8Pg3uDlKSF3D8E/NGVZluJJ2up2i+0KfJ2ceanLHWzEcrr/l6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708855430; c=relaxed/simple;
	bh=FwyYlcicA94hCgi0KTUdT4QunAnlUBM+uSL7POHZY/g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kSKrZ/ypC8wnd6tpmbyYHtXt8tV7gZp+DunoDYSFAE2rX9jE4SgnIlfxw+7DwCsEnoPQ2hyJKIQMuwD0bmWh7r8lQ7abZxEvrgGaM6wYU56275eLgg2SlYOeBkn54BQfH/TOyxhEsHxWiD+kXczvg9lvHHiSno8jgsF2KZYbQH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G/hocDDZ; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2d21a68dd3bso29350551fa.1;
        Sun, 25 Feb 2024 02:03:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708855427; x=1709460227; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Wyw3xA0HGd/6i6d7WHoA8ZSWdz/coub8I+ng5GM1Nc0=;
        b=G/hocDDZEK6FqVGz8QjNwwQeT7di3QuuWq04ofgZ+dpErvHCoG/XWeoQH5OZ1kY6dy
         G9Ei31s0zWUXeO56bgP4DIjF7+jZvzz4bBiYRzpM5/h9x9buI8oFy2pzFImFF5e6Ua1G
         VpyQpLTe27GQ2Ijl9eL+/8i5iDkWkbsCQiWh1Ux92F8S6OPIN6RRkEb6PxD9fApRWo6e
         MMzWsHZxNznJl6RsXm+jUJWbrnm+tWlc5E+Twpepi3LtKr0FE+xrQE6c5+WJ/FLw+qrQ
         cl+I2MGi7xS/tPCH5FkP8fxVn3qVL7xWwZHVRJWprkSa9qb1hwpCneqPXexj5RLdVBDu
         htJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708855427; x=1709460227;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wyw3xA0HGd/6i6d7WHoA8ZSWdz/coub8I+ng5GM1Nc0=;
        b=CySXu3PIcCp86eIw7lhQ13ZirNPqYzqgAPYcrZxWdMCT98IkfSG7HmrhWEif4cRTyI
         Tu+AEwl59UoNAwdwY3xdVHa7kvlJ3ro7/4VYAD5BR6GC7yGV1pUH3L9twWuQWHMUy3T4
         y7uIPuhGVT1YAzXkhB5C7ExbSpfuc5VCESePcjQpJRT0HdXB9t04r3fZlc5/PAKo15X7
         b7JEu49gXwyoCvr6UbtMXxibCNL6teMuycP5aMyNz9pUdhONOvXFroF17sPPbQpIOrgh
         PeZbcS5ZyuCIMMtH2Bp6pSi6EwCVr2g+68wDgOSQnIhPlTBtBbCy3RLwyX9pm5jeEiK5
         IQvA==
X-Forwarded-Encrypted: i=1; AJvYcCXaaq1oQTu/KIh7xFlstUZghJe3rSekdsAwQKiKB5Dgq/Z6rTBKJtqlsQXwa5Ov8WXzrxv8/FBkuRbH464jPnsXo3SwY9MFFczs0f8RAGBZp+pHGOOTwzySJ8rkJLyC/c4ueICAqsxxTQ==
X-Gm-Message-State: AOJu0Yys4pvVA3lwJAjScmsxeLNsexnY9kU10/2DMPl9vMHASZ2/8eLK
	wh6sL6XH5ePjTVzPuwSJTL9BRlgRHTc4kps0+mbEvP6JjmfqIwVZQ6k+66Ng
X-Google-Smtp-Source: AGHT+IEb1awhqOX9jx96QWtjLdmcla70/r/iR4O58vc7lQP9nu1y4FGSySxuh4pudnWUVWSKJYhlig==
X-Received: by 2002:a2e:92c9:0:b0:2d2:6568:eb6c with SMTP id k9-20020a2e92c9000000b002d26568eb6cmr2179436ljh.30.1708855426478;
        Sun, 25 Feb 2024 02:03:46 -0800 (PST)
Received: from localhost ([2001:861:3385:e20:6384:4cf:52c5:3194])
        by smtp.gmail.com with ESMTPSA id k2-20020a5d6d42000000b0033b79d385f6sm4604075wri.47.2024.02.25.02.03.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Feb 2024 02:03:46 -0800 (PST)
From: Raphael Gallais-Pou <rgallaispou@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Patrice Chotard <patrice.chotard@foss.st.com>
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH] dt-bindings: serial: convert st,asc to DT schema
Date: Sun, 25 Feb 2024 11:03:36 +0100
Message-ID: <20240225100336.34122-1-rgallaispou@gmail.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Converts st,asc binding to DT schema format and update example.

Signed-off-by: Raphael Gallais-Pou <rgallaispou@gmail.com>
---
 .../devicetree/bindings/serial/st,asc.yaml    | 57 +++++++++++++++++++
 .../devicetree/bindings/serial/st-asc.txt     | 18 ------
 2 files changed, 57 insertions(+), 18 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/serial/st,asc.yaml
 delete mode 100644 Documentation/devicetree/bindings/serial/st-asc.txt

diff --git a/Documentation/devicetree/bindings/serial/st,asc.yaml b/Documentation/devicetree/bindings/serial/st,asc.yaml
new file mode 100644
index 000000000000..b26e1d247346
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/st,asc.yaml
@@ -0,0 +1,57 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/serial/st,asc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: STMicroelectronics STi SoCs Serial Port
+
+maintainers:
+  - Patrice Chotard <patrice.chotard@foss.st.com>
+
+allOf:
+  - $ref: serial.yaml#
+
+properties:
+  compatible:
+    const: st,asc
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  uart-has-rtscts: true
+
+  st,hw-flow-ctrl:
+    description: When set, enable hardware flow control.
+    type: boolean
+
+  st,force-m1:
+    description: When set, force asc to be in Mode-1. This is recommended for
+      high bit rates above 19.2K.
+    type: boolean
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/stih407-clks.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    serial@9830000 {
+        compatible = "st,asc";
+        reg = <0x9830000 0x2c>;
+        interrupts = <GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&clk_s_c0_flexgen CLK_EXT2F_A9>;
+    };
+...
diff --git a/Documentation/devicetree/bindings/serial/st-asc.txt b/Documentation/devicetree/bindings/serial/st-asc.txt
deleted file mode 100644
index a1b9b6f3490a..000000000000
--- a/Documentation/devicetree/bindings/serial/st-asc.txt
+++ /dev/null
@@ -1,18 +0,0 @@
-*st-asc(Serial Port)
-
-Required properties:
-- compatible : Should be "st,asc".
-- reg, reg-names, interrupts, interrupt-names	: Standard way to define device
-			resources with names. look in
-			Documentation/devicetree/bindings/resource-names.txt
-
-Optional properties:
-- st,hw-flow-ctrl	bool flag to enable hardware flow control.
-- st,force-m1		bool flat to force asc to be in Mode-1 recommended
-			for high bit rates (above 19.2K)
-Example:
-serial@fe440000{
-    compatible    = "st,asc";
-    reg         = <0xfe440000 0x2c>;
-    interrupts     =  <0 209 0>;
-};
-- 
2.43.2


