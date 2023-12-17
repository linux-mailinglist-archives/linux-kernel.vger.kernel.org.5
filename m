Return-Path: <linux-kernel+bounces-2538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7639D815EA0
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 12:10:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 310BD2831F4
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 11:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 893EE1401E;
	Sun, 17 Dec 2023 11:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cV3SI/lL"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1FD134D3;
	Sun, 17 Dec 2023 11:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1d04c097e34so14630855ad.0;
        Sun, 17 Dec 2023 03:10:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702811400; x=1703416200; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jj9r1jU92ga6wROpemMXonWR/8N0PXMeAQwWf03uXmk=;
        b=cV3SI/lLXt/zfh25QCiA+c13HuQYhOh4eZEq4wWGSVuN6VY6WL7WTjULK0es13Rorg
         2HMokzlX4j9KmZ5HL6kbwmIxUtHVB5pdw6NRztCUob7rFBy4430C9H+NESA3U7osK8Tp
         J786eOWPqStTcFJji2S3aUTaelGTmA9JWz9rUr8RXcpBabEOgfGMPI3+Yf22K1GyVCTK
         8BibzAxnkUsUdcsLtkJXwn9WBkcfKjuYYHxrab2Dy4YBgFErrAZgD1LEoiNodxbFYGiU
         hD0aKIAp+/8W8t+Am3Ito8DF5Hsi8kD5LNxhDvqzdYTl6xk334fw0ZaE/GpkkO2JnzQR
         rZlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702811400; x=1703416200;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jj9r1jU92ga6wROpemMXonWR/8N0PXMeAQwWf03uXmk=;
        b=GRFIiLhE0RmvsmyZ6PRcRE2r93W7BNDBpn4ZJ+t0mOG81T8q/diQUZ+eH0lC5xO8HJ
         ljXt+2u0GcX0SEsgyEi7Z7h47Sgd0N9flfj1d1c1Eq4dwpNw3qIBlbk1PbBr4E5ptGgf
         mmjr2L+AouE59H4LVNz4l3RfqhokRF8VVKGWSLNGRvMWGgBr6JMVLz0HXcQkwCTpnchU
         Lux0G6YKBbWisRO5fodu2juI1qDNF6b9v7x3BHpkigYxzc+wu8g+5tqMlQO2cqy2T3l7
         EVc61QiJmDbw8oXgIDDUPSZhqzzPtZTmt7hBJ8yVB6o4siydLruzhNwxsBVn/CJJdXOa
         9sKg==
X-Gm-Message-State: AOJu0YxlS6KZyt2NRwAKWOEFZeX/uPZ4/mBLSqDg2YA7XZZnHmF5J8EW
	I8Vzn6Pgbkkf6sD+szezQaQ=
X-Google-Smtp-Source: AGHT+IEi4pCY/wsaINfrL92eMehYjuLLRbYHtXmxxWR7eINfCe3acG7jajMv5kjOe6v39NL9yq6jSw==
X-Received: by 2002:a17:902:6e02:b0:1d0:6ffd:610a with SMTP id u2-20020a1709026e0200b001d06ffd610amr14342657plk.44.1702811399715;
        Sun, 17 Dec 2023 03:09:59 -0800 (PST)
Received: from localhost ([2404:7ac0:4520:e744:f37a:6f5:5189:13da])
        by smtp.gmail.com with ESMTPSA id m9-20020a170902db0900b001d06b93c66dsm17015084plx.233.2023.12.17.03.09.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Dec 2023 03:09:59 -0800 (PST)
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
	Jingbao Qiu <qiujingbao.dlmu@gmail.com>
Subject: [PATCH v2 1/3] dt-bindings: rtc: sophgo: add RTC support for Sophgo CV1800 series SoC
Date: Sun, 17 Dec 2023 19:09:50 +0800
Message-Id: <20231217110952.78784-2-qiujingbao.dlmu@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231217110952.78784-1-qiujingbao.dlmu@gmail.com>
References: <20231217110952.78784-1-qiujingbao.dlmu@gmail.com>
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
 .../bindings/rtc/sophgo,cv1800-rtc.yaml       | 47 +++++++++++++++++++
 1 file changed, 47 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/sophgo,cv1800-rtc.yaml

diff --git a/Documentation/devicetree/bindings/rtc/sophgo,cv1800-rtc.yaml b/Documentation/devicetree/bindings/rtc/sophgo,cv1800-rtc.yaml
new file mode 100644
index 000000000000..a9e1dcc2a5be
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/sophgo,cv1800-rtc.yaml
@@ -0,0 +1,47 @@
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
+allOf:
+  - $ref: rtc.yaml#
+
+properties:
+  compatible:
+    const: sophgo,cv1800-rtc
+
+  reg:
+    items:
+      - description: data register
+      - description: control register
+
+  clocks:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - interrupts
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    rtc@5025000{
+      compatible = "sophgo,cv1800-rtc";
+      reg = <0x5025000 0x1000>, <0x5026000 0x1000>;
+      clocks = <&osc>;
+      interrupts = <17 IRQ_TYPE_LEVEL_HIGH>;
+    };
-- 
2.25.1


