Return-Path: <linux-kernel+bounces-9949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EADFA81CDBD
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 18:42:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84ED11F23541
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 17:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC33928E3C;
	Fri, 22 Dec 2023 17:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YZvAyPix"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89D32C188;
	Fri, 22 Dec 2023 17:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-336746c7b6dso1673114f8f.0;
        Fri, 22 Dec 2023 09:42:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703266943; x=1703871743; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xcMMn1wo5ecoqzzFfZ/NThvc+Exg7NREzlaFXx0npiA=;
        b=YZvAyPixlMQtq36mNN6T+kSNM7T7SmI6b26dVE07xaIQZYnOd0+dLrGLEUN+7BlGYt
         UlK1tUjkk9yJWWJ6H3+h9wFKkiCwQSksJItdCErFEdh1/1kFus7BS4byporKRp/zWeGL
         08VYTlh86qyMw2nKfF995t8FaiHRg2B7Rb6Gz8Q9wN+PMxsHm9P+3fMySvfRrdpm+ETD
         +yo3HUERartESOzrJVKPa9Bp8JQCEk1I7p59/A8ZZff46b7Gfbvs+cDJgEMsY/iZhXtg
         iTpvRdYNibIdzCQQD7BJAvE+fcmIY3pe1k2UdkMCZvg6YJskkjV+wnTH3fpaTCR30Ylm
         Slvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703266943; x=1703871743;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xcMMn1wo5ecoqzzFfZ/NThvc+Exg7NREzlaFXx0npiA=;
        b=WGi32pBxN1XKu/sp6uJgFiXg2Tz5WvvvfTKFKQzCbW4T/WEfA8RnMohEoDsCirk/jr
         RIlxx2S+BelInDkCIAH7r9IspKTUO3OXl5i1GToO7p9BFfoQANlTqYyOmHdsoYFFLWSV
         Gf0lIHezvSBWpkUrdgjZNY7SxV8QGjcmLZyQfsWPQy1Ax4Zncfisxsk0YZF00GpYs26L
         RNkNLgmd7ol5NUHajUKLjR+OCsIsab/LBQFU7WIPSsUNKoWV3OrrP/74yhVbQsSbWU6U
         k1KvpNIQA7gg/AQUa9VFibttTBZfaAmokg5GtUtup2CajYR8HMeGgQuo8I/vJ2DGPjAS
         Lmeg==
X-Gm-Message-State: AOJu0YxWDUW3IKsv24k6dOImoDZj1MxNtmL7MguV1FHlImZQeD+uiRlA
	i7u3UdMELgKkHV1oV0gYDA==
X-Google-Smtp-Source: AGHT+IH55tOdjFEvsimvQ0AWwkhlparYzELlSEvcxba6ID4XqVa/0ncC9dCVT9baJ10rAbzbikAuQg==
X-Received: by 2002:a5d:6546:0:b0:336:7794:4475 with SMTP id z6-20020a5d6546000000b0033677944475mr992813wrv.109.1703266943072;
        Fri, 22 Dec 2023 09:42:23 -0800 (PST)
Received: from U4.lan ([2a02:810b:f40:4300:f3ae:2788:7e03:f44])
        by smtp.gmail.com with ESMTPSA id w10-20020adfec4a000000b00336670abdcasm4777116wrn.40.2023.12.22.09.42.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 09:42:22 -0800 (PST)
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
Subject: [PATCH v4 01/29] dt-bindings: display: rockchip,inno-hdmi: Document RK3128 compatible
Date: Fri, 22 Dec 2023 18:41:52 +0100
Message-ID: <20231222174220.55249-2-knaerzche@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231222174220.55249-1-knaerzche@gmail.com>
References: <20231222174220.55249-1-knaerzche@gmail.com>
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

changes in v4:
 - none

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


