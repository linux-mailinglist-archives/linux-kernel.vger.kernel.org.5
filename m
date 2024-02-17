Return-Path: <linux-kernel+bounces-70103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4E3085931A
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 23:04:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55A021F21C9B
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 22:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AB0B8060D;
	Sat, 17 Feb 2024 22:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I9twV0LV"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E708A8005B;
	Sat, 17 Feb 2024 22:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708207427; cv=none; b=JhihOtlD2ZKNlp+DeLCJx3AcwNH2gbZayBdSbF/S3dLJb5Z+3smugv9EuoC4yDfDQxwE9zUblF8DdqWrkYg1mN6iSZUsadETcWxK86dqrdPvT5z8eLl8C85lWygLmpvqqr2P/e7Q7vPH/L8Pqi1CZJmwscPVYiA3XuWpLj/I/z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708207427; c=relaxed/simple;
	bh=tuNHywPBJTYXwQUVEt7KzPYJvhBz5lRqgPaGOkUzsEA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IKdnHX0xeF0C4OKk7t/yPpT1PIx+2PQO2aEUTonBq+DDDnLsTszTMAsPuP6bkRZYGEHMnvSdpYsXTCnmP/deH+Lo/lch9B4ju4pWGH8kpbMvZK8DOWylG9OeNzEU9UkiHACdoPiPSC8M05eBW9xlq5P4nniES2oECL70hfRYU3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I9twV0LV; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-51197ca63f5so2642328e87.1;
        Sat, 17 Feb 2024 14:03:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708207424; x=1708812224; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5M1YSE81QKZG/kSHWWVAPeSPQl4ZwhZA94VajK9D/Zg=;
        b=I9twV0LVppLuO/a70Q0UdoHLE7cmqGjG2ZjIAycWSalyiIfmV67DrqeWqTn4rT+gym
         p5dJYWecHDxPzycV66P7KEbg8d16D+z+ol6sO/p89eqzkq8Mg5eBAjj1d34OmABIz70U
         CjZBUrOlKVZx1gwcB5u16gDyUXmOY0+dWlvrhX7mut1MCRzArqHUkVq7ahAf/P9qTmot
         01WTnF8Hjn8YH9aQuAUPcMlQpkEt5reHO5u+cWcc2nwAGZN5ECtDeUl4SSutT7pjg9Cc
         uc99yDldcCAYLvNPng2aDA7D7EpSHn2zQZwss1QTd1uC5WBok/8Djs5sqMNfOjObR8l9
         fsMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708207424; x=1708812224;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5M1YSE81QKZG/kSHWWVAPeSPQl4ZwhZA94VajK9D/Zg=;
        b=j/fnBLoDm9vDDdrqFJN8t7UQH1j5j2TK7YWb+VxZWl717Bal/rGhFc2uVYAJcX3RpE
         aNdVhr8J0ehSUtqKLUt2YsKwTMIzGy5J2/W1k1THyE3hGXxKglDknyfHYH4YTgLew5wR
         BhCQqwqN/ZUv6fSAUmrpJPI8aCnqVmDUzWHFi+gpwmeg2Ar/Bg5Pk2cXyJSMMIhQ1WPf
         s+GquaEM3zfc9Gds4Jdo/wF3XF73fpxh/Dn/4JpKif8Te2kU8DCCzxxTs0ysUNnJ/Mvb
         cpj2tiaSKjFKmVXk09vDaG2H7wn8SoDVCpL5QzXU2mS78e6tL7fGYEF+FYbG2Ycg6va4
         hwgA==
X-Forwarded-Encrypted: i=1; AJvYcCUARu30ATJDnmX72eEKvbo2Wd9knWJyWruwvaQr+tldhoNnNmTgDwmF3pWuah0j4Wi9xtAup3pMy1d84Zs7NFzKbJhK2q3gUnj4pph6ebZr2jqMZ5YYieyqF5dD9SAvdqXFcM2sYyXUl/gqdZDqmtlzOEi9Lq93Ndwy+kPy2OrvonoaMvr0
X-Gm-Message-State: AOJu0YxVjn59yh47cf1r3/krcq1zu/fGxza8BuAKeVILW2mSURnw24Mz
	XHMIePArPqc28av70pLEGN4WyXiem4kdKPM5tn7fi6UxmO8aqwoJ
X-Google-Smtp-Source: AGHT+IGFzBxhuTnyefK/t9xRQxJ56QQoT+sGJAbGtIJMIUSdRGvwgWiUdfR5iKFRcAYMA0DTKFcknQ==
X-Received: by 2002:a19:7407:0:b0:512:9e9f:2f1d with SMTP id v7-20020a197407000000b005129e9f2f1dmr2099232lfe.58.1708207423888;
        Sat, 17 Feb 2024 14:03:43 -0800 (PST)
Received: from localhost.localdomain ([2a05:3580:f312:6c01:1b8f:2a1b:d18:1951])
        by smtp.gmail.com with ESMTPSA id p19-20020a056512313300b00511936e2d61sm363836lfd.56.2024.02.17.14.03.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Feb 2024 14:03:43 -0800 (PST)
From: Andrey Skvortsov <andrej.skvortzov@gmail.com>
To: Sakari Ailus <sakari.ailus@linux.intel.com>,
	Alain Volmat <alain.volmat@foss.st.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-media@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ond=C5=99ej=20Jirman?= <megi@xff.cz>,
	Pavel Machek <pavel@ucw.cz>,
	Arnaud Ferraris <arnaud.ferraris@collabora.com>,
	Andrey Skvortsov <andrej.skvortzov@gmail.com>
Subject: [PATCH 1/2] dt-bindings: media: i2c: add galaxycore,gc2145 DVP bus support
Date: Sun, 18 Feb 2024 01:03:07 +0300
Message-ID: <20240217220308.594883-2-andrej.skvortzov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240217220308.594883-1-andrej.skvortzov@gmail.com>
References: <20240217220308.594883-1-andrej.skvortzov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Don't require link-frequencies like it's done for ov5640, that
supports both CSI-2 and DVP. And v4l2_fwnode_endpoint_alloc_parse
ignores link-frequencies property for DVP endpoint. It's used only for
CSI-2 endpoints

Signed-off-by: Andrey Skvortsov <andrej.skvortzov@gmail.com>
---
 .../bindings/media/i2c/galaxycore,gc2145.yaml | 33 +++++++++++++++++--
 1 file changed, 30 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/media/i2c/galaxycore,gc2145.yaml b/Documentation/devicetree/bindings/media/i2c/galaxycore,gc2145.yaml
index 1726ecca4c77..fb376b9d0f2a 100644
--- a/Documentation/devicetree/bindings/media/i2c/galaxycore,gc2145.yaml
+++ b/Documentation/devicetree/bindings/media/i2c/galaxycore,gc2145.yaml
@@ -61,9 +61,6 @@ properties:
         properties:
           link-frequencies: true
 
-        required:
-          - link-frequencies
-
     required:
       - endpoint
 
@@ -110,4 +107,34 @@ examples:
         };
     };
 
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        camera@3c {
+            compatible = "galaxycore,gc2145";
+            reg = <0x3c>;
+            clocks = <&clk_ext_camera>;
+            iovdd-supply = <&scmi_v3v3_sw>;
+            avdd-supply = <&scmi_v3v3_sw>;
+            dvdd-supply = <&scmi_v3v3_sw>;
+            powerdown-gpios = <&mcp23017 3 (GPIO_ACTIVE_LOW | GPIO_PUSH_PULL)>;
+            reset-gpios = <&mcp23017 4 (GPIO_ACTIVE_LOW | GPIO_PUSH_PULL)>;
+
+            port {
+                endpoint {
+                    remote-endpoint = <&parallel_from_gc2145>;
+                    bus-width = <8>;
+                    hsync-active = <1>;
+                    vsync-active = <1>;
+                    data-active = <1>;
+                    pclk-sample = <1>;
+                };
+            };
+        };
+    };
+
 ...
-- 
2.43.0


