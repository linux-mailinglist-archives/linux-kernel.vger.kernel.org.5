Return-Path: <linux-kernel+bounces-19135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0C67826887
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 08:23:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18357281877
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 07:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D2908BE7;
	Mon,  8 Jan 2024 07:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OHoA19XS"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E7249467;
	Mon,  8 Jan 2024 07:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1d3e84fded7so3184985ad.1;
        Sun, 07 Jan 2024 23:23:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704698583; x=1705303383; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oU/7KnaY3R8It+5bk/kDDayYUebGyI/ajRMVKGdFzEk=;
        b=OHoA19XSQ/PYue/gsqkSftz1+lf2i86fGNAWvV8EcH08k2hb8inHEin9pF7IplMDX0
         mIMmCI11uCIJYJl9cZGCp451FtEve/Z8ewJPzPG/ovuI0DmKl4bIzSTyo2thn0X/E2zt
         aM+I60XvcBgOVxGbMHzlohnBFWvjBSg1oS67cxdtmTQQR3OFTL1Ys1vQ+CBjgi5BPXry
         6U+UxdB3jzWMiCUt3OoWsr4dNihzsFM0MZ4TXFdba9w33xVMjrZG4lhq1+JdN1ZRAqKd
         DLDF0poXUwcE8/V1PCr2ivdXgO1iI5U+Ugl0DPM+Qly9kXPvzutdI0kUgy5l0dGJxLgE
         9DOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704698583; x=1705303383;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oU/7KnaY3R8It+5bk/kDDayYUebGyI/ajRMVKGdFzEk=;
        b=aInOGEGpNC4zZQx/ow803CCC0XP3ame5DbyXJxegl6u69Vcrof6dJpYb6ywSSqHwtO
         MUcponQbr15PLyEnxF9TXntG/u0HyAxM88z4TvkfyeloU3Hk9N0o4eppaE8SpYLclTaB
         v3L2p3m8Dne1WARHnfZvB4Zlgt31w0Gk4WrC6LbPWzVJPWsRNQZppNMmjoUYucsUeATs
         G3KJ+BLN3bBkWAn9t2mtEqKPo65LBoN/476P/gLkt8vnCichlWfjfvWeimEye5x5LA3y
         e0xlwFD/HwMS+fjWY+v2jo789L0BSx/MGL22DPza5ffK6YfeuNpR7pKPttdsY5yeEDdS
         3JNg==
X-Gm-Message-State: AOJu0Yy9N2A50Z3Flj6cHwJoHReQ8CGUjuEbRWnP6nAyXL9+gEyfiqaA
	rkYhKUIUbpgFB7s/v6MOkfU=
X-Google-Smtp-Source: AGHT+IHUDVPdaUPp0h0sCuXboGsVAFDunsaKZrszdvzDULnHJ66AGtQ/oqTJi/InXNCVOliGq+zfRA==
X-Received: by 2002:a17:902:ecc4:b0:1d4:f319:85ea with SMTP id a4-20020a170902ecc400b001d4f31985eamr1043649plh.117.1704698583380;
        Sun, 07 Jan 2024 23:23:03 -0800 (PST)
Received: from localhost ([39.70.12.102])
        by smtp.gmail.com with ESMTPSA id c5-20020a170902d90500b001d33e6521b9sm5545937plz.14.2024.01.07.23.23.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jan 2024 23:23:03 -0800 (PST)
From: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
To: a.zummo@towertech.it,
	alexandre.belloni@bootlin.com,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu
Cc: linux-rtc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/1] dt-bindings: rtc: sophgo: add RTC support for Sophgo CV1800 series SoC
Date: Mon,  8 Jan 2024 15:22:53 +0800
Message-ID: <20240108072253.30183-2-qiujingbao.dlmu@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240108072253.30183-1-qiujingbao.dlmu@gmail.com>
References: <20240108072253.30183-1-qiujingbao.dlmu@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add RTC devicetree binding for Sophgo CV1800 SoC.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
---
 .../bindings/rtc/sophgo,cv1800-rtc.yaml       | 56 +++++++++++++++++++
 1 file changed, 56 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/sophgo,cv1800-rtc.yaml

diff --git a/Documentation/devicetree/bindings/rtc/sophgo,cv1800-rtc.yaml b/Documentation/devicetree/bindings/rtc/sophgo,cv1800-rtc.yaml
new file mode 100644
index 000000000000..01a926cb5c81
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/sophgo,cv1800-rtc.yaml
@@ -0,0 +1,56 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/rtc/sophgo,cv1800-rtc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Real Time Clock of the Sophgo CV1800 SoC
+
+allOf:
+  - $ref: rtc.yaml#
+
+maintainers:
+  - Jingbao Qiu <qiujingbao.dlmu@gmail.com>
+
+description:
+  Real Time Clock (RTC) is an independently powered module
+  within the chip, which includes a 32KHz oscillator and a
+  Power On Reset/POR submodule. It can be used for time display
+  and timed alarm generation. In addition, the hardware state
+  machine provides triggering and timing control for chip
+  power on, off, and reset.
+
+properties:
+  compatible:
+    items:
+      - const: sophgo,cv1800-rtc
+      - const: syscon
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    rtc@5025000 {
+        compatible = "sophgo,cv1800-rtc", "syscon";
+        reg = <0x5025000 0x2000>;
+        interrupts = <17 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&clk 15>;
+    };
+...
-- 
2.43.0


