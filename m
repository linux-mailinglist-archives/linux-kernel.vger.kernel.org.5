Return-Path: <linux-kernel+bounces-2249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A222815A31
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 17:27:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F071B237F5
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 16:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EAFE30D05;
	Sat, 16 Dec 2023 16:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="InjvMp1u"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425C930657;
	Sat, 16 Dec 2023 16:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40c6ea99429so12370485e9.3;
        Sat, 16 Dec 2023 08:27:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702744026; x=1703348826; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=obq8YELyZEbke3rZFXNs+HxX85EVdqoEFqpud8UWY9A=;
        b=InjvMp1uUR0NHOkuQAzAuWczkMefFNzt7gVR/8QLDdUggYFRsjrNxbhgeU8UQetO0x
         elrMGzoiOalbdSoqUqGlVrRrcJ/962Ky6GZl67a3CkQVSuHXQr5re/W1R1xt6eftm79N
         lstG6KDYfVhf7X/nSx1s4sqJzCPDq7A4ArtP7mnHLQbvmdB3ez9GLdeRrK9KaHEhZZUa
         KR45MptEyYnQrgC4cGxDD/kUfvwoHQEN8nltq1hdRou4/iScYh2Hpf2zHgLlhPNCUSRv
         BbFXhFObbPhl3Bl9TpUbdJJ8774Xg86k3oOb41kjx4OVFgsRTIEcfeAu7KhQ1G0kYrst
         JX7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702744026; x=1703348826;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=obq8YELyZEbke3rZFXNs+HxX85EVdqoEFqpud8UWY9A=;
        b=QrSqJe6fE0MWYLr08Tog8SK21BApy9G7Qqi3Sg0eFIOGeORuPWzihWu6I9uK+gEmo/
         u4xxYU7JNNKRd39nU2Jd3YG1KZgPbcQPGM4SNQxtc2J1bICA7exuNAKRbBGx2ozHZEbC
         +GBEQd03KtIm1yG5+HWUrOjTmq3OpWW/BNGQ8wqmuV2z8ZXTJW1RTVFxi/eXOCvrp6Q4
         lTNC1baXT5Jo4b+Oonu6ZKZ9zZfxWEmd/tg7YOOccJveTBwOpidltG66sWYFF985CAg2
         BQmqeWTe6cxvbA9KCHVm6FcYibDeCPRH4vIbWZRKM3hjL+p5cjATphFo82iiDOzjhABN
         OrQA==
X-Gm-Message-State: AOJu0YyCQz6tmPhfVnBX+ybEHQBxDHB+zu5hFzjNHe7cgBDlWbgsVixk
	gzl74yMeR9gztinGNtum8A==
X-Google-Smtp-Source: AGHT+IGnNQencjmVxcsF2n4BTXIbiDj3zIdsmRa4iZ0r/ILDY0raJeyfz2VYhdxmAd1idrgHfog51w==
X-Received: by 2002:a7b:c4c7:0:b0:40c:6567:1d85 with SMTP id g7-20020a7bc4c7000000b0040c65671d85mr1569882wmk.232.1702744026333;
        Sat, 16 Dec 2023 08:27:06 -0800 (PST)
Received: from U4.lan ([2a02:810b:f40:4300:e807:d345:6f47:1db9])
        by smtp.gmail.com with ESMTPSA id st10-20020a170907c08a00b00a1cd0794696sm11990362ejc.53.2023.12.16.08.27.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Dec 2023 08:27:06 -0800 (PST)
From: Alex Bee <knaerzche@gmail.com>
To: Sandy Huang <hjc@rock-chips.com>,
	=?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
	Andy Yan <andyshrk@163.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>
Cc: David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Alex Bee <knaerzche@gmail.com>
Subject: [PATCH v2 01/27] dt-bindings: display: rockchip,inno-hdmi: Document RK3128 compatible
Date: Sat, 16 Dec 2023 17:26:12 +0100
Message-ID: <20231216162639.125215-2-knaerzche@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231216162639.125215-1-knaerzche@gmail.com>
References: <20231216162639.125215-1-knaerzche@gmail.com>
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
---
changes in v2:
 - clarify that the controller itself is part of the powerdomain
 - simplify clock-names
 - made power-domains property only allowed (and required) for new variant
 
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


