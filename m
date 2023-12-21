Return-Path: <linux-kernel+bounces-8638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22F8281BA81
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 16:22:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4719E1C2457E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 15:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17CF053A08;
	Thu, 21 Dec 2023 15:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OpGE6vs+"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142E453A0A
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 15:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1d409bcb0e7so3240475ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 07:21:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703172101; x=1703776901; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=31dDSPmTEwAk2xBEYscYsgGP3NvqtS1pbeFP7C1NdB4=;
        b=OpGE6vs+quIgVsp4/GgP9Apc+jKC+o/AbYAQ3pXejY9ws6nUY+LOdEaCPSh9ZSoyXg
         fYtb6Ybd1aZ3DFRWgE5uNVJDzZOb8JbstOktKOBxs1UwSpJhFLbt0t7hl73S0wSJJExr
         0opA0eOPf8u8hQl0wrr4aOWBuBeK+XKOe+1v5HT8/o+JRP82xUReKWTttfW/VftbDYd/
         8yFWtZlgyp19bPy1J04Pdosis/lXKhae1ozMw0mdCm2xl7g9o8UQwKSzMyHdCHXtPAjB
         YLiekWzEuQ/cg2ZG/HlMTpJYnmigbPkCvGFcLKL0NNRjsJkivCz4Txxjyit+ICOJZAAi
         xp+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703172101; x=1703776901;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=31dDSPmTEwAk2xBEYscYsgGP3NvqtS1pbeFP7C1NdB4=;
        b=o+pclO3JUUyW2gF+6bOyheURE4cGszv8vYVzSFyX0+mb4i4eSGuwy2vQoEd1vETUaY
         8MDxmHr3pOC8hZbVdGLd/gJrUQDWsjZ1czBt+nxkm+YWgrUM7JoCVy0fWu9xCR6y3IAq
         0FYuNBErdex11psYEZhyGOsNkWhsg88SlfVL9iCEgpbpgnW3XGG0eavtguVEdZyx+nLw
         73F8mYzElDbVjXh/NCIA5oAbtN+vjtIEJGoZpTXx6ewP+M/BzJJQIRMeKINc3poHWRkV
         +CCw71HqP5p22PAAnPiIbFPkhKN4tXJSgj70JtuRJnChevUUFKZxDd/ecaxsO0Y+ISkR
         pRzw==
X-Gm-Message-State: AOJu0YzGHAKFNHNyNkeXf94blXYi8SkAePlisqrjlfDRfF6tOe+iMBQF
	MZ0MhNIG+hfkxDM+KvTuiJaXxg==
X-Google-Smtp-Source: AGHT+IHrRgf8u5JWR6MRL05N4gqIKbRAqYeSguKzPzSmCgMx2GuFELBFABue7yUP2MLLlcI5F75h7w==
X-Received: by 2002:a17:902:d58d:b0:1d4:458:7aa6 with SMTP id k13-20020a170902d58d00b001d404587aa6mr1106171plh.23.1703172101368;
        Thu, 21 Dec 2023 07:21:41 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id z3-20020a170902ee0300b001d3561680aasm1756217plb.82.2023.12.21.07.21.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 07:21:40 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Thu, 21 Dec 2023 16:21:19 +0100
Subject: [PATCH v14 1/4] dt-bindings: input: document Goodix Berlin
 Touchscreen IC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231221-topic-goodix-berlin-upstream-initial-v14-1-04459853b640@linaro.org>
References: <20231221-topic-goodix-berlin-upstream-initial-v14-0-04459853b640@linaro.org>
In-Reply-To: <20231221-topic-goodix-berlin-upstream-initial-v14-0-04459853b640@linaro.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 linux-input@vger.kernel.org
Cc: Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bastien Nocera <hadess@hadess.net>, 
 Hans de Goede <hdegoede@redhat.com>, Henrik Rydberg <rydberg@bitmath.org>, 
 Jeff LaBundy <jeff@labundy.com>, linux-arm-msm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=3093;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=sfk9uxvNPIwk9f8d5iBn9m2N4nTZgMQFpRmAil1gnVU=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlhFf1K4Uq99CRfhYiO1LRhHgHjTpHt8bAa06Eik0z
 zi4M0CGJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZYRX9QAKCRB33NvayMhJ0cwSEA
 CxM4ma0ZnmTUJsT/zl2VMHuMqFEQvua/DjBwCEre79tUK6UjX8SZ5cczUqUd4Z4Nf2+GdXY89LAtHi
 qEZqlei0ZbdFElIz3kglELp15Z3Md+jOm3VtQ38PUxLgrrGkF75QIYQuxRpzJjTkk44D10UeKX4Rmh
 yH2De9Ga8EZDvxd7Rkr5QPjxIrp6NGvu1F9v8k8jgskLoInWcEj4PpeENLlgS139f3jdFrDWRJSiwp
 5wZrMvwwAM5AclFXzITBPUfyGwyHi0FOcV2C9q4DJvYrV1fVDd4bnA8nMwRTm+WL5OMLYMqfd/F9VD
 moGPYRt2gZqf0GYM7NoJZceZeFjrdszjvvzEhu/qyXZlVTDjE+0DZmc22aUIqei+xEESm7LY7Gmgxq
 HPLDBbbwkFAIEHNKlVnMHSTn6WOO+Ui33m/fP+2TM9dXU2IslL4h5ZX704SQ6LtqxajKJrskX36auz
 nlIqVr/o2IKsF+TdXNw2Rjron8X8miLi2T9urHdSCELa0nwfhR6APp3mTN594+NrQEuyw61UJoYrBM
 +XtRF2S9qfo+MUcfg547MNfezlApaJ1Uuk/zxxX8KJBBGK57o1CNP3rSDXB582UY5NWXFvxiGizjEl
 SGuo7abGcfZvh/5JZnhp5PgKd1XSYES2n9tsnbC09LhpVTyjlDCMMkzmTBYg==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Document the Goodix GT9916 wich is part of the "Berlin" serie
of Touchscreen controllers IC from Goodix.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 .../bindings/input/touchscreen/goodix,gt9916.yaml  | 95 ++++++++++++++++++++++
 1 file changed, 95 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/goodix,gt9916.yaml b/Documentation/devicetree/bindings/input/touchscreen/goodix,gt9916.yaml
new file mode 100644
index 000000000000..d90f045ac06c
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/touchscreen/goodix,gt9916.yaml
@@ -0,0 +1,95 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/input/touchscreen/goodix,gt9916.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Goodix Berlin series touchscreen controller
+
+description: The Goodix Berlin series of touchscreen controllers
+  be connected to either I2C or SPI buses.
+
+maintainers:
+  - Neil Armstrong <neil.armstrong@linaro.org>
+
+allOf:
+  - $ref: touchscreen.yaml#
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+properties:
+  compatible:
+    enum:
+      - goodix,gt9916
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  reset-gpios:
+    maxItems: 1
+
+  avdd-supply:
+    description: Analog power supply regulator on AVDD pin
+
+  vddio-supply:
+    description: power supply regulator on VDDIO pin
+
+  spi-max-frequency: true
+  touchscreen-inverted-x: true
+  touchscreen-inverted-y: true
+  touchscreen-size-x: true
+  touchscreen-size-y: true
+  touchscreen-swapped-x-y: true
+
+additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - avdd-supply
+  - touchscreen-size-x
+  - touchscreen-size-y
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/gpio/gpio.h>
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+      touchscreen@5d {
+        compatible = "goodix,gt9916";
+        reg = <0x5d>;
+        interrupt-parent = <&gpio>;
+        interrupts = <25 IRQ_TYPE_LEVEL_LOW>;
+        reset-gpios = <&gpio1 1 GPIO_ACTIVE_LOW>;
+        avdd-supply = <&ts_avdd>;
+        touchscreen-size-x = <1024>;
+        touchscreen-size-y = <768>;
+      };
+    };
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/gpio/gpio.h>
+    spi {
+      #address-cells = <1>;
+      #size-cells = <0>;
+      num-cs = <1>;
+      cs-gpios = <&gpio 2 GPIO_ACTIVE_HIGH>;
+      touchscreen@0 {
+        compatible = "goodix,gt9916";
+        reg = <0>;
+        interrupt-parent = <&gpio>;
+        interrupts = <25 IRQ_TYPE_LEVEL_LOW>;
+        reset-gpios = <&gpio1 1 GPIO_ACTIVE_LOW>;
+        avdd-supply = <&ts_avdd>;
+        spi-max-frequency = <1000000>;
+        touchscreen-size-x = <1024>;
+        touchscreen-size-y = <768>;
+      };
+    };
+
+...

-- 
2.34.1


