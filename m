Return-Path: <linux-kernel+bounces-11468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1141F81E6CC
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 11:05:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08D8CB21EBE
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 10:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 939564E1BF;
	Tue, 26 Dec 2023 10:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HFLx8dbh"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E1E4E1A1;
	Tue, 26 Dec 2023 10:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-58e256505f7so2736368eaf.3;
        Tue, 26 Dec 2023 02:04:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703585084; x=1704189884; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=op5IgUGrd2vVqxhaWBzjX7j/f0ku0uRgr3gHZWom0+A=;
        b=HFLx8dbhdC1Biks6GhZ6ka+m8j8hrGwDx93L8fE7kRqa1dAdC+fcQM2D8SYHTW3tRX
         gV51yOru52tPj8cYHy9FwURictT3puQRTEyFUe7CGdI7YlImlTTIWeJKwwAnz3Y/TE10
         vib3bIVgZIEn2n6aULJ9wwS+gkZqUBv8VwQsBNlkpvmHpOVWeJATABxogX+f/oPpSK9o
         bcGCsTSG/ICbi5ad7peXPPXRYHjEtJVt8F1Ad01LF6XQKBUeeVOj30MDWrIEygwL1u1Y
         5EXHE/Ol6ncuBJuYnedp2TVRR+hYZX3bC0446vI33Ci2M7m0mMYU1ro1VpYxF0l7JMmk
         Owzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703585084; x=1704189884;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=op5IgUGrd2vVqxhaWBzjX7j/f0ku0uRgr3gHZWom0+A=;
        b=WhQpJPUP/3wjaAtvdtOSqxgSvxz+858UliTpeP/pI57q0ka/LpSMYjliTLJRtm/+Kw
         Qp8P389L1e1/81/Cogm4dsgUflYUk80hX7uAH0Zf65jLNZDmHvsgMD5Lfvz//HPMOtJl
         4QSaLj+baQGeJaMU49V8nLYsHRozLknZ3Poqatf6MeTTNg0QYjNPLKGJvYrcoKMTq0Jz
         EY0vX36j6rj2lJo8cK0UtdD1LD5NQmrU+Jl6JJPhR/xKb0oGZGqK4QPOJ4SazHhMCLzH
         26hAzk/R7oWewtZNl4bGxLKvhrzCc9nwXkn293Mk2Gw2wSmX+Fh5Lai/luJGCmNNaUsg
         CSRA==
X-Gm-Message-State: AOJu0YwwWuMr+abSNF8MDxhNZ2vc1+5al7Df5jl3KxJpQI7TseNAlWKv
	9ZFLD+5vrwLHB5kHjrbhn9E=
X-Google-Smtp-Source: AGHT+IEEsQpyTUR9riqSqdyJ7qGIEwix9mV9LnU0n3afd75l/mOQv9tAn/v1YfXMjgZ/cur9xmFcww==
X-Received: by 2002:a05:6358:9392:b0:172:dbff:766e with SMTP id h18-20020a056358939200b00172dbff766emr4484345rwb.53.1703585083350;
        Tue, 26 Dec 2023 02:04:43 -0800 (PST)
Received: from localhost ([46.3.240.106])
        by smtp.gmail.com with ESMTPSA id o21-20020a056a001b5500b006d99056c4edsm6888782pfv.187.2023.12.26.02.04.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Dec 2023 02:04:43 -0800 (PST)
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
Subject: [PATCH v3 1/4] dt-bindings: mfd: sophgo: add MFD subsys support for Sophgo CV1800 series SoC
Date: Tue, 26 Dec 2023 18:04:28 +0800
Message-Id: <20231226100431.331616-2-qiujingbao.dlmu@gmail.com>
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

Add devicetree binding for Sophgo CV1800 SoC MFD subsys.

Signed-off-by: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
---
 .../bindings/mfd/sophgo,cv1800-subsys.yaml    | 51 +++++++++++++++++++
 1 file changed, 51 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/sophgo,cv1800-subsys.yaml

diff --git a/Documentation/devicetree/bindings/mfd/sophgo,cv1800-subsys.yaml b/Documentation/devicetree/bindings/mfd/sophgo,cv1800-subsys.yaml
new file mode 100644
index 000000000000..c2a071c8a2de
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/sophgo,cv1800-subsys.yaml
@@ -0,0 +1,51 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/sophgo,cv1800-subsys.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Sophgo CV1800 SoC subsys controller
+
+maintainers:
+  - Jingbao Qiu <qiujingbao.dlmu@gmail.com>
+
+description:
+  The Sophgo CV1800 SoC subsys controller contains many functions
+  for example, RTC and restart. In addition, CV1800 has an 8051
+  subsystem, which is configured through registers at this controller.
+
+properties:
+  compatible:
+    items:
+      - const: sophgo,cv1800b-subsys
+      - const: syscon
+      - const: simple-mfd
+
+  reg:
+    maxItems: 1
+
+  rtc:
+    $ref: /schemas/rtc/sophgo,cv1800-rtc.yaml#
+    type: object
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/clock/sophgo,cv1800.h>
+
+    syscon@5025000 {
+      compatible = "sophgo,cv1800b-subsys", "syscon", "simple-mfd";
+      reg = <0x05025000 0x2000>;
+
+      rtc {
+        compatible = "sophgo,cv1800b-rtc";
+        interrupts = <17 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&clk CLK_RTC_25M>;
+      };
+    };
-- 
2.25.1


