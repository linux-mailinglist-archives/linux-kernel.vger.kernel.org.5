Return-Path: <linux-kernel+bounces-3779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 280EC817107
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 14:53:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97A76B20ACE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 13:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC3561D134;
	Mon, 18 Dec 2023 13:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J3daaCiL"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF9415AC0
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 13:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702907620;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xcLxXFd71FqRSBT1EG5Vxt0tr8/Qm7u7kD7fkPmPXog=;
	b=J3daaCiLLpHCeA5flahgWqM+5cHBiGs4uumjcr17ZWgsnEXWtpboUrYRKQLvbmgEBR17Il
	1JwnvEnJGzUPh5kTo1pgx1UGa8CEDltB5hMNtejwgua+EeLOUoAqdKhqL6qTurHiMcXCzI
	DwOXeabAArh//qiSx8ZUo3PV9KzH/fo=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-yHjWfYp-MZu9huJpMVe_rg-1; Mon, 18 Dec 2023 08:53:39 -0500
X-MC-Unique: yHjWfYp-MZu9huJpMVe_rg-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-50e30e33677so1034592e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 05:53:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702907617; x=1703512417;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xcLxXFd71FqRSBT1EG5Vxt0tr8/Qm7u7kD7fkPmPXog=;
        b=eKK/BKXe5STJtp8fI1KGeobsiDoi8JFa8LzIviPsFokTNYNIlBflvZPE+IuO2wcjTq
         XJQROlDzGBDmBZavVxAKF/jy8CRznwBeIdl5aDckMiDsDUQFQsHnZ28Vn2oh5Nfb51vB
         ozeZGOk2c5qlkQLPoxmx00nZRF2I1O6qK3KhWE4jHJ0txyM1B6Bbr/fabrJPOYG/NQea
         fhZCmjfIPlhUhcVkXuY1zETPn/Up3eAnjjaouoIEvhJKMsnpy4J/d8WZ2KST2aC6/yVW
         RZgR8jDBnBOD7YrkY8xHfSS8YLgibAfNQAiymgcLTzut/5M38FoK6cyC3agI04tzBXkb
         HUTg==
X-Gm-Message-State: AOJu0YzLVi8ZfuuawYAajQPjDvccTchJ5seYkyOFFigmG3DCxaUHIIJN
	SK9S+CwxVpRN76NxmandzHyInWN6THvtxvUk8A6T+kQl9fGvWsAehrX//L2q+NIrpUgZBGFK+Qo
	45dek806HL6A9AwwpXF4wCEcLCbuyHR1B6+rVIitppy8t9yeD6ULrAzdvhRCCDIMloVYrXG4WMb
	oTisCum4E=
X-Received: by 2002:a19:2d02:0:b0:50e:3121:1a12 with SMTP id k2-20020a192d02000000b0050e31211a12mr1252032lfj.110.1702907617013;
        Mon, 18 Dec 2023 05:53:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEJY8+4hU5oDu6qSl59TsTm745DG8WzEVry6hZALawkyULyAWdi5nKE6mTJ+I9u3OMhtVhj6w==
X-Received: by 2002:adf:cf0e:0:b0:336:445a:ec51 with SMTP id o14-20020adfcf0e000000b00336445aec51mr4106218wrj.143.1702905686791;
        Mon, 18 Dec 2023 05:21:26 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id g17-20020a5d5551000000b003333521a1cesm2115952wrw.57.2023.12.18.05.21.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 05:21:25 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Maxime Ripard <mripard@kernel.org>,
	Jocelyn Falempe <jfalempe@redhat.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Conor Dooley <conor@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Peter Robinson <pbrobinson@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Daniel Vetter <daniel@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Rob Herring <robh+dt@kernel.org>,
	devicetree@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH v2 1/2] dt-bindings: display: Add SSD133x OLED controllers
Date: Mon, 18 Dec 2023 14:20:35 +0100
Message-ID: <20231218132045.2066576-2-javierm@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231218132045.2066576-1-javierm@redhat.com>
References: <20231218132045.2066576-1-javierm@redhat.com>
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

Changes in v2:
- Unconditionally set the width and height constraints (Conor Dooley).
- Fix indentation in the DTS examples (Krzysztof Kozlowski).

 .../bindings/display/solomon,ssd133x.yaml     | 57 +++++++++++++++++++
 1 file changed, 57 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/solomon,ssd133x.yaml

diff --git a/Documentation/devicetree/bindings/display/solomon,ssd133x.yaml b/Documentation/devicetree/bindings/display/solomon,ssd133x.yaml
new file mode 100644
index 000000000000..8feee9eef0fd
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
+properties:
+  compatible:
+    enum:
+      - solomon,ssd1331
+
+required:
+  - compatible
+  - reg
+
+allOf:
+  - $ref: solomon,ssd-common.yaml#
+
+  - properties:
+      width:
+        default: 96
+      height:
+        default: 64
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


