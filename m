Return-Path: <linux-kernel+bounces-2571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 73910815EEF
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 13:21:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DA22B21CF2
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 12:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EE833308A;
	Sun, 17 Dec 2023 12:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gU29NcpZ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B05432C63;
	Sun, 17 Dec 2023 12:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2cc5d9cf766so13552211fa.2;
        Sun, 17 Dec 2023 04:20:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702815643; x=1703420443; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ASUrErE9IB4rBsV06LSlQI5+Mv2WPJpJ2KbkeexjDLU=;
        b=gU29NcpZF16mxO3rhk+Vpw/IQjjl3LlDIgKLDODM66RmYBDd46BTaWsCCjgqxbkVD4
         MWKo4VdJFnNJskKO3OhI/EdBaihK8R59fn+q72bXEgs7PMm1DuYSTTgrGIh7X+22bYrc
         fMibr4USVqz3mOOy1u5NNu7p+T6mlg0cQdIlqfIm/WMckAFoddtRvcTwMdK9xzKFJgf4
         l4sLvEfR7FKnJ2+O0TvMGQdLf9U4naOXr0gaIu3kvSGnwU7Nt1H6viBNSmBaXVHmg64C
         TghNjzvHWPPGErgBxV/MYQs8wTa116fOORXBeML46EYXLx9YomXro3S/QMkbMqazhLEC
         MztA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702815643; x=1703420443;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ASUrErE9IB4rBsV06LSlQI5+Mv2WPJpJ2KbkeexjDLU=;
        b=FdN1Rf42iqi6YiJlO1sagajx0O5cHT6R52/LPno6wvB/uSiHOSG9vcKxA6HtfwO2zK
         P68wyR8rpWj7N57htOTkqe/oTUXyBiXvJos4E6lpR7uqlsv7y2ee1t6XCQ6mNEIcDjav
         nD2MpPppa1cD825FQ5Yg4aLTZD5cxMo/WkeARUMSvD5xrB8wDdsHT5VH5oj4gEM25/PK
         86oMHo3akISjKPmJEPbtCH8OTW9FU8pleoQfhfsWmGDJox52nVL8BijbC0f3IaDzj86V
         Hwmh3B+xYkNsOZVmVq2+qiBCPhHc24Y9xzG2YsRTHTfOlhCcQ8fjNkj4dbhVW07Mg9e9
         I0jw==
X-Gm-Message-State: AOJu0Ywe/UYomVRdE+SO9x4RREd3pkl2l2vg3qYUMBgyZwDlpBMob/SX
	us6WYOqvPwFHtY4VKUF56ACppufz1Bqc1w==
X-Google-Smtp-Source: AGHT+IE/3BfixLlYi4nD9GaDxGqah+0NJJz63WD9a0Pum2lAWDEMyyUh+edLRX1EYqfxN1Wb6kK+2Q==
X-Received: by 2002:a2e:9c94:0:b0:2cc:5368:6c52 with SMTP id x20-20020a2e9c94000000b002cc53686c52mr1367636lji.93.1702815643222;
        Sun, 17 Dec 2023 04:20:43 -0800 (PST)
Received: from localhost.localdomain (2a02-8388-0502-f480-6c32-186a-368b-d6a9.cable.dynamic.v6.surfer.at. [2a02:8388:502:f480:6c32:186a:368b:d6a9])
        by smtp.gmail.com with ESMTPSA id es21-20020a056402381500b0055267663784sm3495621edb.11.2023.12.17.04.20.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Dec 2023 04:20:42 -0800 (PST)
From: Christoph Winklhofer <cj.winklhofer@gmail.com>
To: krzysztof.kozlowski@linaro.org,
	robh+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Christoph Winklhofer <cj.winklhofer@gmail.com>
Subject: [PATCH 1/2] dt-bindings: w1: UART 1-wire bus
Date: Sun, 17 Dec 2023 13:20:03 +0100
Message-ID: <20231217122004.42795-2-cj.winklhofer@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231217122004.42795-1-cj.winklhofer@gmail.com>
References: <20231217122004.42795-1-cj.winklhofer@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add device tree binding for UART 1-wire bus driver.

Signed-off-by: Christoph Winklhofer <cj.winklhofer@gmail.com>
---
 .../devicetree/bindings/w1/w1-uart.yaml       | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/w1/w1-uart.yaml

diff --git a/Documentation/devicetree/bindings/w1/w1-uart.yaml b/Documentation/devicetree/bindings/w1/w1-uart.yaml
new file mode 100644
index 000000000000..1a4fbe1d7c60
--- /dev/null
+++ b/Documentation/devicetree/bindings/w1/w1-uart.yaml
@@ -0,0 +1,27 @@
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


