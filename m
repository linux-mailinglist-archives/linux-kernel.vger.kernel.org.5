Return-Path: <linux-kernel+bounces-10374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1718781D37D
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 11:04:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C736E281986
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 10:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B8F3CA6A;
	Sat, 23 Dec 2023 10:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FeqA0guO"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E3A9445;
	Sat, 23 Dec 2023 10:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2cca5d81826so24400301fa.2;
        Sat, 23 Dec 2023 02:04:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703325855; x=1703930655; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mWZ1NcegCJYasprW6dwjMa12PRbPbr9Rylbancz0WLc=;
        b=FeqA0guOe3E6zCwA5glANRvOyv7OYzKfRtQ+9KOCY6iLv93hOnBfOKmOx7Dlx5/tHL
         Bl3a2+ME23DFXo5J2hzC95irZ52zOwbjhtM1vC1Up40y5g2OQ895DSKD5MEwFScuc7iV
         z+2fM4kVaOAqcayjs++SJQn62BqOwPkDZ2Y9IKNyP7LN6HRY4FEl72PFHr1wheElAJvc
         M/XauW6/X35bds2eHN0yNyUkwnBHNqkrd/3aeI2MUDqezpuTayVIR5XuTe3L9v4l7HuQ
         Gl/w2I0ECw3ZXfuaLIneG5Bf1ifRYiAH5SF/uiVhH3/e7NvfsmXftYmH89mK+qjjsxR1
         q4fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703325855; x=1703930655;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mWZ1NcegCJYasprW6dwjMa12PRbPbr9Rylbancz0WLc=;
        b=np3MakvOasJhyinUScZA2ITu46VqBm89H8O5yv6iZEVgkMwVzdeo65thL7poA+NwBz
         l9rFxBMtvJfG3yXCrvzs9C0hJhBMvFe9axcgcA+9wMKxJwfn3yuHN52h1IEG69XnZh8i
         3NOnVzMiTV98T92Vm9qc5JDcQjPhZQd9norLb8NmHGz4MP7EnoRyrQnlXk8wZJG5oEEc
         AL2EfSy7JdUW7i5OQibudKDBkkqxozMekSF9wgoco7XboJO2wiyflyfIbumkcEGZ/7Ae
         7WZ+SftvEb55aIZwMK9HpFGdx5PzXpmHArqm/xtUfz++6CM85Edws6uv0Sc49c5rzfGB
         4TNg==
X-Gm-Message-State: AOJu0YyEIS41OjCUjG7n3S1IE32Rj4uM6WrGu7JMFZJ2v1xP/5hLfSMX
	YWXkFz7LDChNITvpASF58QI=
X-Google-Smtp-Source: AGHT+IF8CKEt+ISf1f09eGurF/6tHPQXUskuFnT8fNn0nm9Cownp590BWsfQ342qEzwea96vByleSQ==
X-Received: by 2002:a2e:a0ca:0:b0:2cc:7d76:faa3 with SMTP id f10-20020a2ea0ca000000b002cc7d76faa3mr1309899ljm.88.1703325854684;
        Sat, 23 Dec 2023 02:04:14 -0800 (PST)
Received: from cjw-notebook.. (188-23-116-43.adsl.highway.telekom.at. [188.23.116.43])
        by smtp.gmail.com with ESMTPSA id su24-20020a17090703d800b00a26ab41d0f7sm2357765ejb.26.2023.12.23.02.04.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Dec 2023 02:04:14 -0800 (PST)
From: Christoph Winklhofer <cj.winklhofer@gmail.com>
To: krzysztof.kozlowski@linaro.org,
	robh+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Christoph Winklhofer <cj.winklhofer@gmail.com>
Subject: [PATCH v2 1/3] dt-bindings: w1: UART 1-Wire bus
Date: Sat, 23 Dec 2023 11:04:06 +0100
Message-ID: <20231223100408.44056-2-cj.winklhofer@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231223100408.44056-1-cj.winklhofer@gmail.com>
References: <20231223100408.44056-1-cj.winklhofer@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add device tree binding for UART 1-Wire bus.

Signed-off-by: Christoph Winklhofer <cj.winklhofer@gmail.com>
---
 .../devicetree/bindings/w1/w1-uart.yaml       | 44 +++++++++++++++++++
 1 file changed, 44 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/w1/w1-uart.yaml

diff --git a/Documentation/devicetree/bindings/w1/w1-uart.yaml b/Documentation/devicetree/bindings/w1/w1-uart.yaml
new file mode 100644
index 000000000000..93d83c42c407
--- /dev/null
+++ b/Documentation/devicetree/bindings/w1/w1-uart.yaml
@@ -0,0 +1,44 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/w1/w1-uart.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: UART 1-Wire Bus
+
+maintainers:
+  - Christoph Winklhofer <cj.winklhofer@gmail.com>
+
+description: |
+  UART 1-wire bus. Utilizes the UART interface via the Serial Device Bus
+  to create the 1-Wire timing patterns.
+
+  The UART peripheral must support full-duplex and operate in open-drain
+  mode. The timing patterns are generated by a specific combination of
+  baud-rate and transmitted byte, which corresponds to a 1-Wire read bit,
+  write bit or reset pulse.
+
+  The default baud-rate for reset and presence detection is 9600 and for
+  a 1-Wire read or write operation 115200. In case the actual baud-rate
+  is different from the requested one, the transmitted byte is adapted
+  to generate the 1-Wire timing patterns.
+
+  https://www.analog.com/en/technical-articles/using-a-uart-to-implement-a-1wire-bus-master.html
+
+
+properties:
+  compatible:
+    const: w1-uart
+
+required:
+  - compatible
+
+additionalProperties: false
+
+examples:
+  - |
+    serial {
+      onewire {
+        compatible = "w1-uart";
+      };
+    };
-- 
2.43.0


