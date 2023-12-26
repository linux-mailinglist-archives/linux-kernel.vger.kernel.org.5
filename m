Return-Path: <linux-kernel+bounces-11469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3838981E6CF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 11:05:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AA0D1C21E00
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 10:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E483F4D58F;
	Tue, 26 Dec 2023 10:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VFQfcP95"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37E94D58A;
	Tue, 26 Dec 2023 10:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6d9b2c8e2a4so776845b3a.0;
        Tue, 26 Dec 2023 02:04:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703585087; x=1704189887; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zALJ01CFGwfZRr0IjmG/gadIQQhjHBrCuCAP27TqDmc=;
        b=VFQfcP950cT+7StpaYEIhE+QRGLSDoLFxl0CwQnwu94WroBG/Ne/gluka79zGeuB3s
         A2cVllIrfMEkpF4WamY+ZrOArjsxcQheNt5jGoe+/n2D+px1XdjCDrODEvDq6EAQyhcx
         Djz6gBzMa4zSkivNi63UPWR2Z4cK/7Z5Bb+b/VDhRWDK0MP7sEnqnStL8wlk9FEVGxtu
         fX5vg8M5sAWG7CQR/luAWIgkPRJcjImRouHSepG/jKfCM3G6rU5sDTJEs47WmaW6UjhS
         ZGLfyj5GSAviZn3tGAOeiBJm/V5fO6KleOOF3dqa8F/fRDlWCGxpIrM+WJjKpkU+YPlu
         HvCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703585087; x=1704189887;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zALJ01CFGwfZRr0IjmG/gadIQQhjHBrCuCAP27TqDmc=;
        b=h5948MsHnw0fLjkeXCgyc8nO+hsTUVfmnhDsSsSeD+gG66NnqjQgMqgDmYP2tG7yry
         zPItrBICYPTBuqWVkJQZ2pTeSLBy9205LEjjHeRd9HmFE5Yft85+JYvsaozlyVSQrB8y
         BQaHI+6Pb0v4wId/AOh8vUyAGLb8v+wA9SseVONkvEcfFepYwpLw42cPKKcNbkZoq4rx
         P2xSwKV4soe23xvKXAklaoTfGlxiZplzfmjsZsG661bhyEiVsRIR8DHSeR39gIst3YZ8
         ES7ok7ndhV9r5NuRJIPZnVCAXdb+ScPzMVP50S1X3MZX5+KdCYUY/HiAe3lwvJhEV9KI
         4Olg==
X-Gm-Message-State: AOJu0Yz2stuQH6ZNID9G3ioCq6+TaANFHL9Iwaqs26RvpZao6AJA+MZb
	GJmDfLYEPNzrTD54FMMmqd0=
X-Google-Smtp-Source: AGHT+IGIfN4WXH7B0ejS2o+fvDRD2frnQxH0SsDJV2HItWqpYfNOMSMI3FvrSYkM9uIVolCFHORpbA==
X-Received: by 2002:a05:6a20:40a7:b0:195:2018:596e with SMTP id a39-20020a056a2040a700b001952018596emr6150642pzf.26.1703585086951;
        Tue, 26 Dec 2023 02:04:46 -0800 (PST)
Received: from localhost ([46.3.240.106])
        by smtp.gmail.com with ESMTPSA id b10-20020a056a0002ca00b006d99ef226c0sm5644007pft.136.2023.12.26.02.04.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Dec 2023 02:04:46 -0800 (PST)
From: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
To: a.zummo@towertech.it,
	alexandre.belloni@bootlin.com,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor@kernel.org,
	conor+dt@kernel.org,
	chao.wei@sophgo.com,
	unicorn_wang@outlook.com,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu
Cc: linux-rtc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dlan@gentoo.org,
	inochiama@outlook.com,
	Jingbao Qiu <qiujingbao.dlmu@gmail.com>
Subject: [PATCH v3 2/4] dt-bindings: rtc: sophgo: add RTC support for Sophgo CV1800 series SoC
Date: Tue, 26 Dec 2023 18:04:29 +0800
Message-Id: <20231226100431.331616-3-qiujingbao.dlmu@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231226100431.331616-1-qiujingbao.dlmu@gmail.com>
References: <20231226100431.331616-1-qiujingbao.dlmu@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add devicetree binding for Sophgo CV1800 SoC.

Signed-off-by: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
---
 .../bindings/rtc/sophgo,cv1800-rtc.yaml       | 45 +++++++++++++++++++
 1 file changed, 45 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/sophgo,cv1800-rtc.yaml

diff --git a/Documentation/devicetree/bindings/rtc/sophgo,cv1800-rtc.yaml b/Documentation/devicetree/bindings/rtc/sophgo,cv1800-rtc.yaml
new file mode 100644
index 000000000000..eb86fd432053
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/sophgo,cv1800-rtc.yaml
@@ -0,0 +1,45 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/rtc/sophgo,cv1800-rtc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Real Time Clock of the Sophgo CV1800 SoC
+
+maintainers:
+  - Jingbao Qiu <qiujingbao.dlmu@gmail.com>
+
+description:
+  This is the RTC device for the CV1800 SoC. This device
+  is placed under MFD and shares an address with other devices.
+
+allOf:
+  - $ref: rtc.yaml#
+
+properties:
+  compatible:
+    const: sophgo,cv1800b-rtc
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+required:
+  - compatible
+  - interrupts
+  - clocks
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/clock/sophgo,cv1800.h>
+
+    rtc {
+      compatible = "sophgo,cv1800b-rtc";
+      interrupts = <17 IRQ_TYPE_LEVEL_HIGH>;
+      clocks = <&clk CLK_RTC_25M>;
+    };
-- 
2.25.1


