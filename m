Return-Path: <linux-kernel+bounces-5619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CEB24818D39
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 18:01:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76751283A94
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 17:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21FA9225A5;
	Tue, 19 Dec 2023 17:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aCKPCWwF"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D908F35295;
	Tue, 19 Dec 2023 17:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40b5155e154so60381055e9.3;
        Tue, 19 Dec 2023 09:01:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703005268; x=1703610068; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LuKwY9nW5+R7DeHCNpC77KMqCvSYagjOBXGDTeiO2JI=;
        b=aCKPCWwFAIn0DirJIaeFdefNIuMSwxFOFd0C3HuKU7TB57A6dN3TlntUSuZQ0d9KSY
         vJzX6VeBEk4NA8WH9ngm1xxJx7CePA5OIq5MMnefF3gcKA9TqgbRN5rU2ZDjWTaLFXdH
         K2vJUABGtraa2cv+4/zLqGv5boBiYyl+C/oBlET7z8vg7Th7sHwgWgKZDNESg4fcSg9X
         XzI5aoXBwnE+8vRtIunIe/363C7ZGI3nrlVIQ1Sq2ZKYtmTsjc3bO55UIdUYqxGBFF3A
         Ag+1jJ6XuVaOxTvyywD0sUewh07DVWVwfRn81PQiJM7WIiSCj3R9kpqec5M2oaXjDTtR
         Gugg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703005268; x=1703610068;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LuKwY9nW5+R7DeHCNpC77KMqCvSYagjOBXGDTeiO2JI=;
        b=vRqctI+jvMeD5EVcdkJkBDuIBme9FNoAwtg97Xd6p43DTvTjC1+3Tj1HmBFReOBn97
         Ju1zhc/8Pun5gwVM1gQJKDMyGThckyqlKY8Q5hWFUf9lxufzghzWxEiDLYceFTacUuBm
         RLsm4h3It7Ck1a6Y9zqZbyhvgoGoFvVSaj98N5L1q4i4J0G8q6aYNy1HWxpWLhhdZBZB
         zws2C732J5wU5YVyym6+BrY3F1BqQYNwsmf++cHC4THJ+bCvzs2k5Uw7UedbvYF4hHKr
         2zqRIOVOMZy1JFm0WyKAF8T8Tj/8hVjd1oGMyx2RVWgbWCz/dnyHf9HE0wwzc2gDyGM7
         XFZw==
X-Gm-Message-State: AOJu0YwsRVTJhDFn6otHsbRFhVCS2hEFaQZpPAgMvki53+qmXygS0H8u
	VvOSxZJysqDj8nR7ZvuR9Q==
X-Google-Smtp-Source: AGHT+IHjyJcBo9pFgVWTlwbgCdScLicwo5eWIY6pSPcbe8l2hqtFhG18/pJv3xIxu5MSaFiQGfmU6A==
X-Received: by 2002:a05:600c:5408:b0:40d:3084:e66b with SMTP id he8-20020a05600c540800b0040d3084e66bmr127509wmb.163.1703005267997;
        Tue, 19 Dec 2023 09:01:07 -0800 (PST)
Received: from U4.lan ([2a02:810b:f40:4300:7ae5:3e:d1c6:a138])
        by smtp.gmail.com with ESMTPSA id i7-20020a05600c354700b0040d2805d158sm3225878wmq.48.2023.12.19.09.01.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 09:01:07 -0800 (PST)
From: Alex Bee <knaerzche@gmail.com>
To: Sandy Huang <hjc@rock-chips.com>,
	=?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Alex Bee <knaerzche@gmail.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v3 01/29] dt-bindings: display: rockchip,inno-hdmi: Document RK3128 compatible
Date: Tue, 19 Dec 2023 18:00:31 +0100
Message-ID: <20231219170100.188800-2-knaerzche@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231219170100.188800-1-knaerzche@gmail.com>
References: <20231219170100.188800-1-knaerzche@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The integration for this SoC is different from the currently existing: It
needs it's PHY's reference clock rate to calculate the DDC bus frequency
correctly. The controller is also part of a powerdomain, so this gets added
as an mandatory property for this variant.

Signed-off-by: Alex Bee <knaerzche@gmail.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---
changes in v2:
 - clarify that the controller itself is part of the powerdomain
 - simplify clock-names
 - made power-domains property only allowed (and required) for new variant

changes in v3:
 - collect RB

 .../display/rockchip/rockchip,inno-hdmi.yaml  | 40 ++++++++++++++++++-
 1 file changed, 38 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/rockchip/rockchip,inno-hdmi.yaml b/Documentation/devicetree/bindings/display/rockchip/rockchip,inno-hdmi.yaml
index 96889c86849a..be78dcfa1c76 100644
--- a/Documentation/devicetree/bindings/display/rockchip/rockchip,inno-hdmi.yaml
+++ b/Documentation/devicetree/bindings/display/rockchip/rockchip,inno-hdmi.yaml
@@ -14,6 +14,7 @@ properties:
   compatible:
     enum:
       - rockchip,rk3036-inno-hdmi
+      - rockchip,rk3128-inno-hdmi
 
   reg:
     maxItems: 1
@@ -22,10 +23,19 @@ properties:
     maxItems: 1
 
   clocks:
-    maxItems: 1
+    minItems: 1
+    items:
+      - description: The HDMI controller main clock
+      - description: The HDMI PHY reference clock
 
   clock-names:
-    const: pclk
+    minItems: 1
+    items:
+      - const: pclk
+      - const: ref
+
+  power-domains:
+    maxItems: 1
 
   ports:
     $ref: /schemas/graph.yaml#/properties/ports
@@ -55,6 +65,32 @@ required:
   - pinctrl-names
   - ports
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: rockchip,rk3036-inno-hdmi
+
+    then:
+      properties:
+        power-domains: false
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: rockchip,rk3128-inno-hdmi
+
+    then:
+      properties:
+        clocks:
+          minItems: 2
+        clock-names:
+          minItems: 2
+      required:
+        - power-domains
+
 additionalProperties: false
 
 examples:
-- 
2.43.0


