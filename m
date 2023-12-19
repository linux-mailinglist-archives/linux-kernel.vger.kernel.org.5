Return-Path: <linux-kernel+bounces-5927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 554CF8191A0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 21:35:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D916E1F27A04
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 20:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FDE73B78B;
	Tue, 19 Dec 2023 20:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UWIKJsHv"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C8693BB2D
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 20:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703018095;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uBP5+4pQK3uFRN8UqYAB+LK0Vg09XZtHg8dKysI62eg=;
	b=UWIKJsHveG5VIOoOcbVyD+ISqNIZ9Gm1airsZ8rQH2FzuNwXKDR3dHogwxycAMV5Qgq+5r
	oJF4HwICa1/P8G79zbbJ9DG/MkVZqMAUlwuDSOyoow6tRK0WeULX42qTqbxxumuiKMYgi+
	rKDFTvF+GkdNK0lGkxa6slApPXbQu98=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-345-g5HbBmySNSqXXQ8dH77tTA-1; Tue, 19 Dec 2023 15:34:53 -0500
X-MC-Unique: g5HbBmySNSqXXQ8dH77tTA-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-40c514f9243so33023975e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 12:34:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703018091; x=1703622891;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uBP5+4pQK3uFRN8UqYAB+LK0Vg09XZtHg8dKysI62eg=;
        b=EzXZuKsDpcicydHB+2fTRQinvFJ0fONtDGGnVLj3s2VumDHFAOWsBxtE/Y0tudTcQL
         0JKrsYP8PMVxG01zPmq9P7jQUb+rfm1Q/B4rAbYwUPESdcl4nhVWdDiUeOWRCm841Rmc
         eXlYd8BJFN0MVee1e7lRPMn6JqnxAcs3lVVZMjCysT/20hBrdqrAY5CyxfHDNgepXBTE
         wuQSi17p6QXnbsR6XttEFefPPJhbEdt94Mi9A9v5/9T+V1YG4iYBO0ZlFrInO8AkrJ71
         fktcem69X5rFt6owKaYIvRT0HUzE1DQ7jaQbJ5Vhkdaqr5Ovop7rNKbynKD4p2Cco8Bf
         QMnA==
X-Gm-Message-State: AOJu0YxoycQ4bGRacd7Z6b2Bs6OFo7CzNbc3K/htYPNE/zfdbRIvsCJS
	5/brl5UcrUg1dwGbHQOShBFpZWS9yfmPjY7b+ZB3R+HjaPc/Diq5DSslKP6BuUPK40wR4ZgTenM
	Fhlz+aHh5tx6hGlkLbkPo73cCA8D5CuBMTfNAlHtleUhP5dLIMpZ22Ll9xbQFzLajxVK6pWblhQ
	IchOtPkM8=
X-Received: by 2002:a05:600c:458d:b0:40b:33c0:a22 with SMTP id r13-20020a05600c458d00b0040b33c00a22mr11268590wmo.28.1703018091029;
        Tue, 19 Dec 2023 12:34:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFsXT5JFxqoigwef/u1QlfVGRPMXewmQtLqix/INqsVLkJ2tdFjoRjRtz0EBStx4PVCPvpwYg==
X-Received: by 2002:a05:600c:458d:b0:40b:33c0:a22 with SMTP id r13-20020a05600c458d00b0040b33c00a22mr11268569wmo.28.1703018090722;
        Tue, 19 Dec 2023 12:34:50 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id c5-20020a05600c0a4500b0040c411da99csm4464496wmq.48.2023.12.19.12.34.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 12:34:50 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	Maxime Ripard <mripard@kernel.org>,
	Peter Robinson <pbrobinson@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor@kernel.org>,
	Jocelyn Falempe <jfalempe@redhat.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Daniel Vetter <daniel@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Rob Herring <robh+dt@kernel.org>,
	devicetree@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH v3 3/4] dt-bindings: display: Add SSD133x OLED controllers
Date: Tue, 19 Dec 2023 21:34:08 +0100
Message-ID: <20231219203416.2299702-4-javierm@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231219203416.2299702-1-javierm@redhat.com>
References: <20231219203416.2299702-1-javierm@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a Device Tree binding schema for the OLED panels based on the
Solomon SSD133x family of controllers.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

Changes in v3:
- Move solomon,ssd-common.yaml ref before the properties section and
  width/height constraints after the other properties (Conor Dooley).

Changes in v2:
- Unconditionally set the width and height constraints (Conor Dooley).
- Fix indentation in the DTS examples (Krzysztof Kozlowski).

 .../bindings/display/solomon,ssd133x.yaml     | 57 +++++++++++++++++++
 1 file changed, 57 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/solomon,ssd133x.yaml

diff --git a/Documentation/devicetree/bindings/display/solomon,ssd133x.yaml b/Documentation/devicetree/bindings/display/solomon,ssd133x.yaml
new file mode 100644
index 000000000000..e93879b3da5d
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/solomon,ssd133x.yaml
@@ -0,0 +1,57 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/solomon,ssd133x.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Solomon SSD133x OLED Display Controllers
+
+maintainers:
+  - Javier Martinez Canillas <javierm@redhat.com>
+
+allOf:
+  - $ref: solomon,ssd-common.yaml#
+
+properties:
+  compatible:
+    enum:
+      - solomon,ssd1331
+
+  solomon,width:
+    default: 96
+
+  solomon,height:
+    default: 64
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
+        oled@3c {
+            compatible = "solomon,ssd1331";
+            reg = <0x3c>;
+            reset-gpios = <&gpio2 7>;
+        };
+
+    };
+  - |
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        oled@0 {
+            compatible = "solomon,ssd1331";
+            reg = <0x0>;
+            reset-gpios = <&gpio2 7>;
+            dc-gpios = <&gpio2 8>;
+            spi-max-frequency = <10000000>;
+        };
+    };
-- 
2.43.0


