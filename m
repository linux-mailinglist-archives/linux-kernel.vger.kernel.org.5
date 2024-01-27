Return-Path: <linux-kernel+bounces-41140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7DCE83EC6D
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 10:49:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 080D5283FF0
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 09:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCC2C200AB;
	Sat, 27 Jan 2024 09:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mecka.net header.i=@mecka.net header.b="Lpv60KY9"
Received: from mecka.net (mecka.net [159.69.159.214])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E6691F952;
	Sat, 27 Jan 2024 09:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.159.214
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706348927; cv=none; b=MZkHfW84FRSmj7sw4/evFW+8NZO2n/weF+wwrcbimfkqkuNSYDBzCRzkqH1ZsMsgw8RDcynBBMwE+Jc10bKjc+oZDvnuZMWPWeqsqzAE7hmYLn93/CwA9+9uGpSmqk+4w+zNsSuQ1hEzsQJuEVybCkL1ItM5ClMPRGAE9fd1iG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706348927; c=relaxed/simple;
	bh=d/mPhCDD2i3XgKxf8jrSdZHr8qoOj21nqnUYrLCOwkM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JXrbWrjVWx9uApYirFQifQO2fLxKoGit+7IDg6sXU7LEQMHqx2lNT0/L0GWz49eJyd6+RUHQ/DwcR7QhikkOIrhocUnSDSIcZoUTFa7j6h2/+hDpWjB15tcMML3Hsw2LbqIL1PqbiMsERkKsObIcGHoucX/5S4fmQs2gQazgrtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mecka.net; spf=pass smtp.mailfrom=mecka.net; dkim=fail (0-bit key) header.d=mecka.net header.i=@mecka.net header.b=Lpv60KY9 reason="key not found in DNS"; arc=none smtp.client-ip=159.69.159.214
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mecka.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mecka.net
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mecka.net; s=2016.11;
	t=1706348924; bh=d/mPhCDD2i3XgKxf8jrSdZHr8qoOj21nqnUYrLCOwkM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Lpv60KY9OiB7fdvFNMxUFh78OaTgbSlN+lX+mWpSZ/xotVLlAlyzt0XW12DQNmOhu
	 gREj1sYbd2MdWp4stsPhepsVCeGkXzQUkCxcAUoJ1PTsox4P9ThcLs1sb9lqzwj0gi
	 /Ptq1lD559s402ZWmJ+dEsU4osZS2kiKPy0mtqATvjbx+9B4Ra5U2HPMCpIABXJOgM
	 327XGDEHXlyOTUGQ+8LoM8tk9xGl1P/c6FSe+khJ9tGt1P0/jDn4fA/jbxuPKwJWIg
	 bIPbLasIu6WrG7KbyZGmLX0Jvt5hj3YArk9sK8eEVKbJ6WxERISnH+pOEbLxauFoX9
	 LY/3d5t+mUIdw==
Received: from arthur.fritz.box (unknown [185.147.11.134])
	by mecka.net (Postfix) with ESMTPSA id 98F983BF7A5;
	Sat, 27 Jan 2024 10:48:43 +0100 (CET)
From: Manuel Traut <manut@mecka.net>
Date: Sat, 27 Jan 2024 10:48:42 +0100
Subject: [PATCH v4 1/4] dt-bindings: display: panel: Add BOE
 TH101MB31IG002-28A panel
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240127-pinetab2-v4-1-37aab1c39194@mecka.net>
References: <20240127-pinetab2-v4-0-37aab1c39194@mecka.net>
In-Reply-To: <20240127-pinetab2-v4-0-37aab1c39194@mecka.net>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Sandy Huang <hjc@rock-chips.com>, Mark Yao <markyao0591@gmail.com>, 
 Diederik de Haas <didi.debian@cknow.org>, 
 Segfault <awarnecke002@hotmail.com>, Arnaud Ferraris <aferraris@debian.org>, 
 Danct12 <danct12@riseup.net>, Ondrej Jirman <megi@xff.cz>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, Manuel Traut <manut@mecka.net>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.4

Add bindings for the BOE TH101MB31IG002-28A LCD panel. It is
used e.g. in the Pine64 PineTab2 and PineTab-V.

Signed-off-by: Manuel Traut <manut@mecka.net>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Link: https://lore.kernel.org/r/20240102-pinetab2-v3-1-cb1aa69f8c30@mecka.net
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20240102-pinetab2-v3-1-cb1aa69f8c30@mecka.net
(cherry picked from commit baae3a0b10c499d4228514a701602f6fd2a8d6b4)
---
 .../display/panel/boe,th101mb31ig002-28a.yaml      | 58 ++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/boe,th101mb31ig002-28a.yaml b/Documentation/devicetree/bindings/display/panel/boe,th101mb31ig002-28a.yaml
new file mode 100644
index 000000000000..32df26cbfeed
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/boe,th101mb31ig002-28a.yaml
@@ -0,0 +1,58 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/boe,th101mb31ig002-28a.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: BOE TH101MB31IG002-28A WXGA DSI Display Panel
+
+maintainers:
+  - Manuel Traut <manut@mecka.net>
+
+allOf:
+  - $ref: panel-common.yaml#
+
+properties:
+  compatible:
+    enum:
+        # BOE TH101MB31IG002-28A 10.1" WXGA TFT LCD panel
+      - boe,th101mb31ig002-28a
+
+  reg: true
+  backlight: true
+  enable-gpios: true
+  power-supply: true
+  port: true
+  rotation: true
+
+required:
+  - compatible
+  - reg
+  - enable-gpios
+  - power-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    dsi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        panel@0 {
+            compatible = "boe,th101mb31ig002-28a";
+            reg = <0>;
+            backlight = <&backlight_lcd0>;
+            enable-gpios = <&gpio 45 GPIO_ACTIVE_HIGH>;
+            rotation = <90>;
+            power-supply = <&vcc_3v3>;
+            port {
+                panel_in_dsi: endpoint {
+                    remote-endpoint = <&dsi_out_con>;
+                };
+            };
+        };
+    };
+
+...

-- 
2.43.0


