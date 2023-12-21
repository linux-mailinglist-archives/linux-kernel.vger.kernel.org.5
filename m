Return-Path: <linux-kernel+bounces-7903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E81381AEEF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 07:51:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 408891C22F7A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 06:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3800D29F;
	Thu, 21 Dec 2023 06:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RQYJgA30"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B69814262;
	Thu, 21 Dec 2023 06:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-54cb4fa667bso537290a12.3;
        Wed, 20 Dec 2023 22:51:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703141466; x=1703746266; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x3bh5VcvCxx4fWLkzgiM2GduP9Lsn4VDLUW6TgSpZaY=;
        b=RQYJgA30+MDVVGJ9+kMY82wZ9OSyKve9VfBwxLYEhnZQ9FqGTBQmSoQv5o3NyR4iGJ
         KxSb/EHnz6CHxb9UsC+8HcNNpD3gmMQ6mZ3txhhRmQwlAqtA08Yf4Z1EtZ263pXVOqJU
         q7IErGkND1Rq3JaGzP9BUJWeKjy+v08tHIFw2Nf+ccAsVNi4TPXbS46JCijd9wY13tAm
         9/ZG5s59mTnclYChKO2jA5aJ0lfNE+ySvQFcqGQcRIa6smGM2y6UGNmlaP0CuKRzqNIZ
         f/ZPeT6fp0SGWaEad5lE/ykQP273GfYKGhRN3koIeiA7yokVRMnnA5NnNoW8EZ4lbkAn
         szvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703141466; x=1703746266;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x3bh5VcvCxx4fWLkzgiM2GduP9Lsn4VDLUW6TgSpZaY=;
        b=Ys9ambgCbI5Ki88l1vHVu0Z5HHn1Bhtx5AQ2hNui+syqXox60szzoSn+BPFFgLIG++
         30L1FRuhiFyS6Shm2GMaw/+g1CnBZF4z+NuY4sgelZdZ6tu0iYJn24oOt9Z7eixUZWs2
         /FTPCP/T57ADGpjVwfUbfNIx0sI4uisViaB4j+OUH4da5nz9IuA1kyOTwy4Cf62O4rIX
         XHAeH1PRiG67W9P4T6TgmCXBs0w6ZEJaCBFZsZOJb8B2UmmcaxCxkP8FRxufUPTXqJjE
         ckNcHnkIfTRSC5rsKR4W/M0GAk3H/IKHe5ylHryfgYYGrkpHoMAVziGlnUWkgwYHL5kb
         dweQ==
X-Gm-Message-State: AOJu0YzkLcXm5V08/wC3nFT2Reaw/7ZR9hJ8D6IS9ZqpWq4erzgOl2yN
	a4nQFTc/OCFX3pvOlXjDkco=
X-Google-Smtp-Source: AGHT+IGbRNxggiHyG0+uor7Nsd1Hpq3Ub3q+hqUqZqEbb1bxnG+TXQZ5tB2RgDpEbLyAtoBuDZb+kg==
X-Received: by 2002:a17:906:78f:b0:a26:6e93:491b with SMTP id l15-20020a170906078f00b00a266e93491bmr1852160ejc.35.1703141465684;
        Wed, 20 Dec 2023 22:51:05 -0800 (PST)
Received: from localhost.localdomain (2a02-8388-0502-f480-6c32-186a-368b-d6a9.cable.dynamic.v6.surfer.at. [2a02:8388:502:f480:6c32:186a:368b:d6a9])
        by smtp.gmail.com with ESMTPSA id jo23-20020a170906f6d700b00a268e4757b2sm617082ejb.143.2023.12.20.22.51.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 22:51:05 -0800 (PST)
From: Christoph Winklhofer <cj.winklhofer@gmail.com>
To: krzysztof.kozlowski@linaro.org,
	robh+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Christoph Winklhofer <cj.winklhofer@gmail.com>
Subject: [PATCH v1 1/2] dt-bindings: w1: UART 1-wire bus
Date: Thu, 21 Dec 2023 07:50:47 +0100
Message-ID: <20231221065049.30703-2-cj.winklhofer@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231221065049.30703-1-cj.winklhofer@gmail.com>
References: <20231221065049.30703-1-cj.winklhofer@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add device tree binding for UART 1-wire bus.

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


