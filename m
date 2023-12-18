Return-Path: <linux-kernel+bounces-4280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9970E817AB9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 20:11:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C9E5285F3D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 19:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61E36740A3;
	Mon, 18 Dec 2023 19:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m2TJO3k+"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182DC7347C;
	Mon, 18 Dec 2023 19:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-553046ea641so2886960a12.3;
        Mon, 18 Dec 2023 11:10:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702926642; x=1703531442; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tA4z8mkcehpNXuo3DXINrbq3mX2Koy2s0Ow4jzwEMZA=;
        b=m2TJO3k+IBHoBFXqPVZjfgTWj7nAKrqTQ8PdaZUaXAHu5t1G6LjB9e5zwDY0R3n1JU
         SjxGrSarFBBIDTscon+ohAMhZKnq4MdIgjmO71YOxYQwRmlQHvcEDzBUDsFdEG64BlWf
         Dfg0z8QlxXIb7Wy7YsSjWNqkH5NtqsSD1YWOMPoSQuiuxapYOPY+rrKhcSCnM4UNhuxB
         PEhNOUR1Aub6NxasmAo4q7Jb5eLIPx0cjWyL2heZlrQhUaHuJszKpcZBxHN/ftRVbJnV
         ahsUz/zkePiWa94LjxZ0N+BV0TPYUls+LcXmnYyGNytIhIuMQPXMDnAdmhIByq/7XgGJ
         yE5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702926642; x=1703531442;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tA4z8mkcehpNXuo3DXINrbq3mX2Koy2s0Ow4jzwEMZA=;
        b=LZxah7UxH341DmpxILhlfMSGEbL4b1WIZAw8duYHctcfobHpC6hJUOVBsTgG5TsR6U
         i8j1Aeq7pLGJ+OTlCDs+70NMMTxGDItOZ0yb8yJuHqtxEk1IvTl83ETsj/l2N6rmyQYV
         346W3rVijyjCJAk+yPVQZO5Eump1AdiTyVR08ED/mUfLL0y/ojTa84cM+vILo3y8p+hN
         ne+giWvGDTkKz+bBqbTNkxSlpcd62Wow4qYRBM4cjmSjQG6SjV6hc5RZRew5zZmmmeZ5
         XK+3POobIWBMCxThhxYood8XUYVtm5kTv9iWZ+9sEoeayKzT8wgW5IvyawR+ARgge+TC
         z0vA==
X-Gm-Message-State: AOJu0YypOC56zleGryrLlJmvdDJ1qtlvV65QAe3AzkSLS1ZRq2gKyf6m
	g0AlB4XtZe6sPF9W7b2tw3U=
X-Google-Smtp-Source: AGHT+IGZEFU9B0trDW/0jJy/LKTa+tUdaFzx3DU6zmxp2e/6Nojvl1dKDiEbdu4/h+v9H6KygNV13A==
X-Received: by 2002:a17:906:1db:b0:a1e:9cc0:ea83 with SMTP id 27-20020a17090601db00b00a1e9cc0ea83mr3810103ejj.269.1702926642404;
        Mon, 18 Dec 2023 11:10:42 -0800 (PST)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-339c-9917-d041-4030.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:339c:9917:d041:4030])
        by smtp.gmail.com with ESMTPSA id vw6-20020a170907a70600b00a1d80b665dfsm14398956ejc.26.2023.12.18.11.10.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 11:10:41 -0800 (PST)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Mon, 18 Dec 2023 20:10:32 +0100
Subject: [PATCH v4 4/5] dt-bindings: hwmon: Add Amphenol ChipCap 2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231020-topic-chipcap2-v4-4-7940cfa7613a@gmail.com>
References: <20231020-topic-chipcap2-v4-0-7940cfa7613a@gmail.com>
In-Reply-To: <20231020-topic-chipcap2-v4-0-7940cfa7613a@gmail.com>
To: Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jean Delvare <jdelvare@suse.com>, 
 Guenter Roeck <linux@roeck-us.net>, Jonathan Corbet <corbet@lwn.net>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org, 
 linux-doc@vger.kernel.org, Javier Carrasco <javier.carrasco.cruz@gmail.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1702926633; l=2681;
 i=javier.carrasco.cruz@gmail.com; s=20230509; h=from:subject:message-id;
 bh=Lr5muLwArpjju4xp2y4YqKDNsdVFstyldtex35HluNY=;
 b=uWCXEkwrPxphENnsKVWtcUGjuUfGPH7EW3vxcpEDGCDsfg9JXlSWTjFtaS+MsGU9M4cNRZIsn
 ENXdLzN7/yUDQiAWLCx9biWbmq8q/fJV7HAmFT0QFWltkIRzdxdJ0zK
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=tIGJV7M+tCizagNijF0eGMBGcOsPD+0cWGfKjl4h6K8=

Add device tree bindings and an example for the ChipCap 2 humidity
and temperature sensor.

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 .../bindings/hwmon/amphenol,chipcap2.yaml          | 77 ++++++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/Documentation/devicetree/bindings/hwmon/amphenol,chipcap2.yaml b/Documentation/devicetree/bindings/hwmon/amphenol,chipcap2.yaml
new file mode 100644
index 000000000000..738c278d6403
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/amphenol,chipcap2.yaml
@@ -0,0 +1,77 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/hwmon/amphenol,chipcap2.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ChipCap 2 humidity and temperature iio sensor
+
+maintainers:
+  - Javier Carrasco <javier.carrasco.cruz@gmail.com>
+
+description: |
+  Relative humidity and temperature sensor on I2C bus.
+
+  Datasheets:
+    https://www.amphenol-sensors.com/en/telaire/humidity/527-humidity-sensors/3095-chipcap-2
+
+properties:
+  compatible:
+    oneOf:
+      - const: amphenol,cc2d23
+      - items:
+          - enum:
+              - amphenol,cc2d23s
+              - amphenol,cc2d25
+              - amphenol,cc2d25s
+              - amphenol,cc2d33
+              - amphenol,cc2d33s
+              - amphenol,cc2d35
+              - amphenol,cc2d35s
+          - const: amphenol,cc2d23
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    items:
+      - description: measurement ready indicator
+      - description: low humidity alarm
+      - description: high humidity alarm
+
+  interrupt-names:
+    items:
+      - const: ready
+      - const: low
+      - const: high
+
+  vdd-supply:
+    description:
+      Dedicated, controllable supply-regulator to reset the device and
+      enter in command mode.
+
+required:
+  - compatible
+  - reg
+  - vdd-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        humidity@28 {
+            compatible = "amphenol,cc2d23s";
+            reg = <0x28>;
+            interrupt-parent = <&gpio>;
+            interrupts = <4 IRQ_TYPE_EDGE_RISING>,
+                         <5 IRQ_TYPE_EDGE_RISING>,
+                         <6 IRQ_TYPE_EDGE_RISING>;
+            interrupt-names = "ready", "low", "high";
+            vdd-supply = <&reg_vdd>;
+        };
+    };

-- 
2.39.2


