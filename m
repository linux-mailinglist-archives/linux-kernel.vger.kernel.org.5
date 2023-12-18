Return-Path: <linux-kernel+bounces-3754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 719CD817098
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 14:37:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED9E4B2310C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 13:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C56414F63;
	Mon, 18 Dec 2023 13:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ug2kJ+gY"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A2C129EC2;
	Mon, 18 Dec 2023 13:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-40c256ffdbcso35954365e9.2;
        Mon, 18 Dec 2023 05:37:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702906661; x=1703511461; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=74hbRXhVdXgSDAgGqkd3Z2N/WmcE11nXVnluNKZBVyg=;
        b=Ug2kJ+gY8YN/dSPfBe42ePougX0mn67gIm3aNT1JPsrQIZresGUzecJJZfDTB4oPSa
         xZaUWGMiup3ZCMdbHGaYWol1gl0Pu3Q19RUaSCg27ARTtqy8n9xFhlhAjjxpNP7LOotf
         VyRIHbU3EnySe0pd3xqyEWhKdpE5CuKTdg4LlebckZlwozrjeAUN1Kir5rIQqxMwOlEi
         7Zc67ajGROhLcwdbGTvH35/XZ9KaTvb9SP9VjjK3iCG3Cr5kv9J3fZC+JUNcbiXvfKgI
         rBwjFihqjTV1Ee4dZsGIoRiKko9KLvZ3hcW2Iw/xvz98Ccbarf/ETOZJDT32jEGGvVnQ
         W3pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702906661; x=1703511461;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=74hbRXhVdXgSDAgGqkd3Z2N/WmcE11nXVnluNKZBVyg=;
        b=joB+VuZUh5utHdA+jRTrzh1NkNYLqde753qgjriSBKz+Vu4FzCxMQZqU0/nEbU7j58
         yUhs7gVrgpnQdET97dnskVJtcDzD+PYmzho7XhCRuoaDIF9csJi86zpveojFAUOpVxPS
         q7ecfGz+TB0rWASnJUHY/JaEeu0MXBYNvgKR8LFgyGWyTM+EcqT0oL6vR8NZGT81CwMK
         B9CEIWiy7JTr8JlJMEwtVjmRc6ldTvCXnA45/i5blxtRcg8KltXUtgj3MHqehLsZH/FX
         QBgyjlr6Ki2rBIhiQ+joaSbWICbXUxN0Au2Nw94V2byuFlvR94l81l5UFgGQtuGQX12K
         3cnQ==
X-Gm-Message-State: AOJu0YxC+ZMak8kNjPh2L50oyYwL1FbsnS//ct1y73vOZSS5Lc4Hz1ha
	Te2gYOtiwGqVENMofJGiQ50=
X-Google-Smtp-Source: AGHT+IHT+hNGJimAnfQ6BtcEMsMSLNWd6wLudFTGCwXIlKzIipmCiwiwJao7CLfyL16Ml1MTDiLl1w==
X-Received: by 2002:a05:600c:3556:b0:40b:5e1e:cf9 with SMTP id i22-20020a05600c355600b0040b5e1e0cf9mr7839833wmq.52.1702906659774;
        Mon, 18 Dec 2023 05:37:39 -0800 (PST)
Received: from localhost.lan (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.gmail.com with ESMTPSA id f20-20020a1709067f9400b00a234907311asm1891537ejr.55.2023.12.18.05.37.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 05:37:39 -0800 (PST)
From: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Michael Walle <michael@walle.cc>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	linux-mtd@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	u-boot@lists.denx.de,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH 1/4] dt-bindings: nvmem: layouts: add U-Boot environment variables layout
Date: Mon, 18 Dec 2023 14:37:19 +0100
Message-Id: <20231218133722.16150-1-zajec5@gmail.com>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Rafał Miłecki <rafal@milecki.pl>

U-Boot env data is a way of storing firmware variables. It's a format
that can be used of top of various storage devices. Its binding should
be an NVMEM layout instead of a standalone device.

This patch adds layout binding which allows using it on top of MTD NVMEM
device as well as any other. At the same time it deprecates the old
combined binding.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 .../bindings/nvmem/layouts/u-boot,env.yaml    | 55 +++++++++++++++++++
 .../devicetree/bindings/nvmem/u-boot,env.yaml |  6 ++
 2 files changed, 61 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nvmem/layouts/u-boot,env.yaml

diff --git a/Documentation/devicetree/bindings/nvmem/layouts/u-boot,env.yaml b/Documentation/devicetree/bindings/nvmem/layouts/u-boot,env.yaml
new file mode 100644
index 000000000000..3a7ec02b3535
--- /dev/null
+++ b/Documentation/devicetree/bindings/nvmem/layouts/u-boot,env.yaml
@@ -0,0 +1,55 @@
+# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/nvmem/layouts/u-boot,env.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NVMEM layout of U-Boot environment variables
+
+maintainers:
+  - Rafał Miłecki <rafal@milecki.pl>
+
+description:
+  U-Boot uses environment variables to store device parameters and
+  configuration. They may be used for booting process, setup or keeping end user
+  info.
+
+  Data is stored using U-Boot specific formats (variant specific header and NUL
+  separated key-value pairs).
+
+properties:
+  compatible:
+    oneOf:
+      - description: A standalone env data block
+        const: u-boot,env
+      - description: Two redundant blocks with active one flagged
+        const: u-boot,env-redundant-bool
+      - description: Two redundant blocks with active having higher counter
+        const: u-boot,env-redundant-count
+      - description: Broadcom's variant with custom header
+        const: brcm,env
+
+additionalProperties: false
+
+examples:
+  - |
+    partitions {
+        compatible = "fixed-partitions";
+        #address-cells = <1>;
+        #size-cells = <1>;
+
+        partition@0 {
+            reg = <0x0 0x40000>;
+            label = "u-boot";
+            read-only;
+        };
+
+        partition@40000 {
+            reg = <0x40000 0x10000>;
+            label = "u-boot-env";
+
+            nvmem-layout {
+                compatible = "u-boot,env";
+            };
+        };
+    };
diff --git a/Documentation/devicetree/bindings/nvmem/u-boot,env.yaml b/Documentation/devicetree/bindings/nvmem/u-boot,env.yaml
index 68214b96f5c9..fd95e611322d 100644
--- a/Documentation/devicetree/bindings/nvmem/u-boot,env.yaml
+++ b/Documentation/devicetree/bindings/nvmem/u-boot,env.yaml
@@ -26,9 +26,15 @@ description: |
 
   Variables can be defined as NVMEM device subnodes.
 
+  Introduction of NVMEM layouts exposed a limitation of this binding design.
+  Description of NVMEM data content should be separated from NVMEM devices.
+  Since the introduction of U-Boot env data layout this binding is deprecated.
+
 maintainers:
   - Rafał Miłecki <rafal@milecki.pl>
 
+deprecated: true
+
 properties:
   compatible:
     oneOf:
-- 
2.35.3


