Return-Path: <linux-kernel+bounces-119454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 010B488C92A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 17:28:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24B3A1C3F497
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 16:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B58C913CC45;
	Tue, 26 Mar 2024 16:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="C7r5zL3w"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2B613C9D6;
	Tue, 26 Mar 2024 16:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711470518; cv=none; b=C7vNPWsAddcPraWf3Ci2lOj2vi6hduKAGm2BazEBG5D54NwS/jNVT8G9c7q8O0RuysXkaHQHCezmGtvo+qFUvJfir4Olrv8APZi8ovlftyhYhTwWpLDOiEDik10tNZl+qbcVpX+xhNUWmsrojzexG3Bxe4o4JTyb2tSdWUtlog4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711470518; c=relaxed/simple;
	bh=cnfca3Jmjldq/unKmKoyHtdHACTokkYBtkSCRfoj6RI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cYpc895YZqMD0jdJRii3q38XJTK+c72gH4UifX5DlviVYT8VxwVcs/d3jrNlGZjKTGdBoXMio7rlmb8rvYqJuQwoh4FpaNf69cWp9drw7NjTP9e3LvPlgYlIdEaXV6fP18cz94sw51fUETCBWpAN5KyoKoZd1h53r73sr8Tia+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=C7r5zL3w; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E42512000C;
	Tue, 26 Mar 2024 16:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1711470514;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RmYml7XwTSu6fSdoWdCFzUtOiKillgd8hTYBjXtprsw=;
	b=C7r5zL3wlRU0TVIuEGVlJO4Pv0QsFT5fakKDCEjP6XGPbIwjk6RYd6fbmAClmIOKNTZ1QO
	cYvYe0+AcvGmTER3z5TCBwwQXV0i/UnTeK/JFr1Pe4ax56GV08FdtfBvQaS9K8+u9Q9Y+B
	Qy/YiaRYIRiih9ZlhTp47GDNykIiw1bhCHwMBJVjww0+KJ6Q5nfDBMbJcFYbRnccUYY6wR
	hmp2k+JdE4czP514d91u1bn5IP6i1agR4qZ0yNOPp4Wg0p2CIw6DF5hho12/0ivIr/A+HB
	VEARt9ItnNWt3W7UjrjNZA7DjaucaKzPmLAmkcNf5ubMfvAThQsAVsdwE8XKpg==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Tue, 26 Mar 2024 17:28:11 +0100
Subject: [PATCH 1/4] dt-bindings: display: bridge: add the Hot-plug MIPI
 DSI connector
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240326-hotplug-drm-bridge-v1-1-4b51b5eb75d5@bootlin.com>
References: <20240326-hotplug-drm-bridge-v1-0-4b51b5eb75d5@bootlin.com>
In-Reply-To: <20240326-hotplug-drm-bridge-v1-0-4b51b5eb75d5@bootlin.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Paul Kocialkowski <contact@paulk.fr>, 
 =?utf-8?q?Herv=C3=A9_Codina?= <herve.codina@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Paul Kocialkowski <paul.kocialkowski@bootlin.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
X-Mailer: b4 0.13.0
X-GND-Sasl: luca.ceresoli@bootlin.com

Add bindings for a physical, hot-pluggable connector allowing the far end
of a MIPI DSI bus to be connected and disconnected at runtime.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 .../bridge/hotplug-video-connector-dsi.yaml        | 87 ++++++++++++++++++++++
 MAINTAINERS                                        |  5 ++
 2 files changed, 92 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/bridge/hotplug-video-connector-dsi.yaml b/Documentation/devicetree/bindings/display/bridge/hotplug-video-connector-dsi.yaml
new file mode 100644
index 000000000000..05beb8aa9ab4
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/bridge/hotplug-video-connector-dsi.yaml
@@ -0,0 +1,87 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/bridge/hotplug-video-connector-dsi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Hot-pluggable connector on a MIPI DSI bus
+
+maintainers:
+  - Luca Ceresoli <luca.ceresoli@bootlin.com>
+
+description:
+  A bridge representing a physical, hot-pluggable connector on a MIPI DSI
+  video bus. The connector splits the video pipeline in a fixed part and a
+  removable part.
+
+  The fixed part of the video pipeline includes all components up to the
+  display controller and 0 or more bridges. The removable part includes one
+  or more bridges and any other components up to the panel.
+
+  The removable part of the pipeline can be physically disconnected at any
+  moment, making all of its components not usable anymore. The same or a
+  different removable part of the pipeline can be reconnected later on.
+
+  Note that the hotplug-video-connector does not describe video busses
+  having native hotplug capabilities in the hardware, such as HDMI.
+
+properties:
+  compatible:
+    const: hotplug-video-connector-dsi
+
+  ports:
+    $ref: /schemas/graph.yaml#/properties/ports
+
+    properties:
+      port@0:
+        $ref: /schemas/graph.yaml#/properties/port
+        description:
+          The end of the fixed part of the MIPI DSI bus (terminating at the
+          hotplug connector). The remote-endpoint sub-node must point to
+          the previous component of the video pipeline.
+
+      port@1:
+        $ref: /schemas/graph.yaml#/properties/port
+        description:
+          The start of the removable part of the MIPI DSI bus (starting
+          from the hotplug connector). The remote-endpoint sub-node must
+          point to the next component of the video pipeline.
+
+    required:
+      - port@0
+      - port@1
+
+required:
+  - compatible
+  - ports
+
+additionalProperties: false
+
+examples:
+  - |
+    hotplug-video-connector {
+        compatible = "hotplug-video-connector-dsi";
+
+        ports {
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            port@0 {
+                reg = <0>;
+
+                hotplug_connector_in: endpoint {
+                    remote-endpoint = <&previous_bridge_out>;
+                };
+            };
+
+            port@1 {
+                reg = <1>;
+
+                hotplug_connector_out: endpoint {
+                    remote-endpoint = <&next_bridge_in>;
+                };
+            };
+        };
+    };
+
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index aa3b947fb080..e1affd13e30b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6716,6 +6716,11 @@ T:	git git://anongit.freedesktop.org/drm/drm-misc
 F:	Documentation/devicetree/bindings/display/panel/himax,hx8394.yaml
 F:	drivers/gpu/drm/panel/panel-himax-hx8394.c
 
+DRM DRIVER FOR HOTPLUG VIDEO CONNECTOR BRIDGE
+M:	Luca Ceresoli <luca.ceresoli@bootlin.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/display/bridge/hotplug-video-connector-dsi.yaml
+
 DRM DRIVER FOR HX8357D PANELS
 S:	Orphan
 T:	git git://anongit.freedesktop.org/drm/drm-misc

-- 
2.34.1


