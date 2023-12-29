Return-Path: <linux-kernel+bounces-13015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1207F81FE76
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 10:07:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36B761C22D78
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 09:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5264711712;
	Fri, 29 Dec 2023 09:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tc5b01/e"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ABAC111BE;
	Fri, 29 Dec 2023 09:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1d480c6342dso14645555ad.2;
        Fri, 29 Dec 2023 01:06:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703840818; x=1704445618; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xDe8yeQVtuhtzkjLkzQYVPss6LOeEHpd4RwzdwynHSY=;
        b=Tc5b01/elN5J7JhMxEuT0dJiJQ/KGSW3CRue+Mke/S5jk9GlY9q3/Qm24NjZjBRPzd
         oWxWMMZ6L/BgRP+jvhIIkRRLPHUU69V4HSNf0X5Cx8Bvnk4/qPLFt1NI2bD6Yk455zUD
         KBeKwocZ7bGgQd6sW5/MY9qtepIFcZvcCn7zXt2NUho0pgBs1mqpROdM9tjjZpAnHT5B
         nyLamwEwYc9WHYJiMeUA5ZElPDs7lm5g4RRi24Y4mSpC9YINFxy4UTF7cnZre6EirV9k
         t7ap8V7K6rIOcLI+5Q6yGcq+rh5atn86mNhE1zt3HJDD8clMBEHM/5QioiEfzoGxtFB8
         TNAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703840818; x=1704445618;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xDe8yeQVtuhtzkjLkzQYVPss6LOeEHpd4RwzdwynHSY=;
        b=mg/IefLdK+nbFv+qOiSDOELgeAI+2X4/5jUBGLYLKLl1jIJ7dQLxS50BK3ijFEmeNi
         xpDkGaUWK7MSTdCglE+PzRbfXn8yDZyD83MmPiarJ9nHGp/AyRBR7psVUuWetaMW9XjJ
         Gf2oVBW1xao9Q4GZ+DFsL1RLh13tEP/Tq+TlQEWb+MuI5jxSI+NTlW+PU8dR6wHW6Aj6
         EztiOB+Ns9AuYqMMYyAmAyDnK3y1zMtUP0WTBeGq190QuISyYhrTdFEhj3/20bedJz/W
         oLiKHbaKiE0cFV9nJzlfA4Qw99YVBbSBK3bIwbbPok+8ZfVBM+dVpGWhxwLYek9f+jKt
         KMGA==
X-Gm-Message-State: AOJu0Yyr88fA3YXaQg0ptADckG0mxnPRcBuXd5pgFTbPSteYuEWIlBoJ
	XO1hbJMEMD6QxMq9bMH7ZNw=
X-Google-Smtp-Source: AGHT+IEm5MTj9FXn/m4WyhB5JXA+sasDDun8W0QQ1lMaRWb71zQvmN4nR8Pv3hB5dlU6DslqjkAy6w==
X-Received: by 2002:a17:903:2349:b0:1cf:f7c3:1e32 with SMTP id c9-20020a170903234900b001cff7c31e32mr13434472plh.27.1703840817279;
        Fri, 29 Dec 2023 01:06:57 -0800 (PST)
Received: from localhost ([46.3.240.107])
        by smtp.gmail.com with ESMTPSA id n10-20020a1709026a8a00b001ab39cd875csm15205002plk.133.2023.12.29.01.06.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Dec 2023 01:06:57 -0800 (PST)
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
	linux-kernel@vger.kernel.org,
	dlan@gentoo.org,
	inochiama@outlook.com,
	Jingbao Qiu <qiujingbao.dlmu@gmail.com>
Subject: [PATCH v1 3/3] dt-bindings: mfd: sophgo: add misc MFD for Sophgo CV1800 series SoC.
Date: Fri, 29 Dec 2023 17:06:43 +0800
Message-Id: <20231229090643.116575-4-qiujingbao.dlmu@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231229090643.116575-1-qiujingbao.dlmu@gmail.com>
References: <20231229090643.116575-1-qiujingbao.dlmu@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add devicetree binding to describe the MFD for Sophgo CV1800 SoC.

Signed-off-by: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
---
This patch depends on the clk driver
Clk driver link:
https://lore.kernel.org/all/IA1PR20MB49539CDAD9A268CBF6CA184BBB9FA@IA1PR20MB4953.namprd20.prod.outlook.com/

 .../bindings/mfd/sophgo,cv1800-misc.yaml      | 69 +++++++++++++++++++
 1 file changed, 69 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/sophgo,cv1800-misc.yaml

diff --git a/Documentation/devicetree/bindings/mfd/sophgo,cv1800-misc.yaml b/Documentation/devicetree/bindings/mfd/sophgo,cv1800-misc.yaml
new file mode 100644
index 000000000000..6fd574a2a945
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/sophgo,cv1800-misc.yaml
@@ -0,0 +1,69 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/sophgo,cv1800-misc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Sophgo CV1800 SoC MISC hardware block
+
+maintainers:
+  - Jingbao Qiu <qiujingbao.dlmu@gmail.com>
+
+description:
+  This hardware block is an independently powered module within
+  the CV1800 SoC. This hardware block contains RTC, Power-On-Reset/POR.
+
+properties:
+  compatible:
+    items:
+      - const: sophgo,cv1800-misc
+      - const: syscon
+      - const: simple-mfd
+
+  reg:
+    maxItems: 1
+
+  rtc:
+    # Child node
+    $ref: /schemas/rtc/sophgo,cv1800-rtc.yaml
+    type: object
+    description:
+      RTC for the SoC. This child node definition
+      should follow the bindings specified in
+      Documentation/devicetree/bindings/rtc/sophgo,cv1800-rtc.yaml.
+
+  por:
+    # Child node
+    $ref: /schemas/power/sophgo,cv1800-por.yaml
+    type: object
+    description:
+      Power-On-Reset/POR for the SoC. This child node definition
+      should follow the bindings specified in
+      Documentation/devicetree/bindings/power/sophgo,cv1800-por.yaml.
+
+required:
+  - compatible
+  - reg
+  - rtc
+  - por
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    misc@5025000 {
+      compatible = "sophgo,cv1800-misc", "syscon", "simple-mfd";
+      reg = <0x05025000 0x2000>;
+
+      rtc  {
+        compatible = "sophgo,cv1800-rtc";
+        interrupts = <17 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&clk 15>;
+      };
+
+      por  {
+        compatible = "sophgo,cv1800-por";
+      };
+    };
-- 
2.25.1


