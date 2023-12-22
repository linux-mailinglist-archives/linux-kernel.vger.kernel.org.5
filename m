Return-Path: <linux-kernel+bounces-9572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A565281C7BF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 11:03:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AE501F2539F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 10:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE4DC17984;
	Fri, 22 Dec 2023 10:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HOYxbXpd"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3028171D9
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 10:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703239322;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L4FSS8B/TyNttrAPDKVxxrfugLFfEOoGgW3LT/2ICJc=;
	b=HOYxbXpdyDSF3zfClSnRrBQ1j3JPXQL+7BQisjQyKSjAdwFj3XqnEl4+Q00jiZwZiqGNel
	qz/+rH7Oe8nBiBlANfnXXpnYYDxMPE3EKd2eQcZuVE+4zR7at/B5SkfW94ILt+Ld3dINUF
	blpx594T2hY706Gme4xEMaidiPik/aU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-372-Bsa_6LomPOyPJgQ41GUfCw-1; Fri, 22 Dec 2023 05:02:00 -0500
X-MC-Unique: Bsa_6LomPOyPJgQ41GUfCw-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3367e2bd8b0so1096623f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 02:02:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703239318; x=1703844118;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L4FSS8B/TyNttrAPDKVxxrfugLFfEOoGgW3LT/2ICJc=;
        b=Lc2gH3T7PdtZRSJu3RHCGIeg6sDmlrOpwELS7O5lIeu3+KEVZ1vSS3w80wx6Zv+2hk
         YEvprGdy1FQPJzbH4lIcWJDZwZXmgv2flbn+Ha3UXaqpUetovQmrTPGiBjmh7mHpS+hB
         sVLn/TjACtbVrJuosyA0fBfG2jDmfGYVqGr5NRc71WgohTYJby8rh+8c7bd4Py69kdt3
         1uI4CPFPfgc1PiDmkQIYDfMWDAlRYyUR7oYWhTPi6LhsdhSYyymSLZGM4oOo8ooBkuv9
         pkYjmCJgbUDRE4re6QbsLwZlImjOncX7kJ5wY5Sk6LbwoDJEPq734a8bts4CYyVu0AuL
         ZSKg==
X-Gm-Message-State: AOJu0YzTv0sPSunwYRNNzO3M39AAA022OHug7u0vLZ7YtkvLxkUvJDhH
	pONNchkzJA6U3yAl4zQV75n6qmf5xMVJfApki6YjloF3J2DfdcCnPJKRFzjgo5TxYkef2jR8f68
	GTqIDJO1O56T8SXE112VX+rF4KIRbBl17F8c/PLYAXWJspbuow8RwMOh4CQUi0UiVqKS4/+uRTO
	E7LmRrRsX1VmkPpJI=
X-Received: by 2002:a5d:4351:0:b0:336:7357:a9f9 with SMTP id u17-20020a5d4351000000b003367357a9f9mr609057wrr.83.1703239318723;
        Fri, 22 Dec 2023 02:01:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGsZNdU6Ak/y/62OAv0NofaXq3Tb9KBXRWL0RjpFZICnql7RgbmU8gyoAOcGlYZ24PvkGjvFQ==
X-Received: by 2002:a5d:4351:0:b0:336:7357:a9f9 with SMTP id u17-20020a5d4351000000b003367357a9f9mr609036wrr.83.1703239318274;
        Fri, 22 Dec 2023 02:01:58 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id t16-20020adfe450000000b0033666ec47b7sm3883026wrm.99.2023.12.22.02.01.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 02:01:57 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Maxime Ripard <mripard@kernel.org>,
	Jocelyn Falempe <jfalempe@redhat.com>,
	Peter Robinson <pbrobinson@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Conor Dooley <conor@kernel.org>,
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
Subject: [PATCH v4 3/4] dt-bindings: display: Add SSD133x OLED controllers
Date: Fri, 22 Dec 2023 11:01:40 +0100
Message-ID: <20231222100149.2641687-4-javierm@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231222100149.2641687-1-javierm@redhat.com>
References: <20231222100149.2641687-1-javierm@redhat.com>
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
Reviewed-by: Rob Herring <robh@kernel.org>
---

(no changes since v3)

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


