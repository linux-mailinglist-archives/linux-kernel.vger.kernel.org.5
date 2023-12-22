Return-Path: <linux-kernel+bounces-9242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C2A681C2C7
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 02:34:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60CC41C25073
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 01:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57C492115;
	Fri, 22 Dec 2023 01:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vkr42U33"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48113A31;
	Fri, 22 Dec 2023 01:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1d3ef33e68dso10140335ad.1;
        Thu, 21 Dec 2023 17:34:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703208870; x=1703813670; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ETRSFur40AfpBaI78BUa335OqHgbVSXvF5B1Xe3sqDk=;
        b=Vkr42U33LRdR/DLssS5iSvsHLQLqqQMRfLt5cOGzGd9Q0LGOjcCd7zGTUSN5KxBcdv
         N+sR0lf8Ok3iP+xT4ays97tE+WhxR53AuNK5ST8sBIk2K/xYotW7ULDpQYF/1sgQhgpy
         B4xg1/6FhtHupl6vj3G25Hn8xFZHvkdNeWeCIpzC6DKVMxby97PlOYrvelYhfY5LTi0e
         HYJXMno+GibnYDMgCl6ABtg47xIGbbT46MnfNQYBDB67oCUVvRvIS/4nqVqKHiF8H17i
         OJmLwmo2k8XzTm5hNEhYv/fffiEi244DLcOnC/Tf9xEmuzbjMqzgBZgeSsaAPy9YBtdq
         MY7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703208870; x=1703813670;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ETRSFur40AfpBaI78BUa335OqHgbVSXvF5B1Xe3sqDk=;
        b=EVXPH5EZhHSOfvSYbyrvH5nsSnTxNh+eJWHGQsamWf7InKPOmk6mE6fQYKbyq60Ern
         gxIr6G8oiyq8e7HVqiKu1x9UzJSaR4PslYAQ5SUEhp7bPFC7XIGukJtudDWOIX7e59hd
         C98u32t5jkf8tEJdE0iJQrxpzVpZEMhMlrby98JE+FGlDtcGMfwGSRYVrz7pDCdkmiFC
         Hu0hu3IfpkWttOf+NOVVZYsKqd5sX34djDtMyKmk31SDPA9sRx+VMkIPTTEQjaNJt2Js
         tZ4ChXHuY8bN2w8s9gcCy0c0EX5VH8ciNQlZv53zynnCOsvMHedpdLqN9+U1H0vWotzt
         PVUw==
X-Gm-Message-State: AOJu0Ywf9QtC0GYfIhmE+l4tnXu5eB9nByuMkg7YzNnHnIOrrwEQjjpr
	V4/+o1fJwWdgQ8CQyBPM8c4=
X-Google-Smtp-Source: AGHT+IHA5GhnBx6vZ62Xk1DYmpIi3B6wwdjPCvbgiKHKyfskJ0cBoGCKQVf5H9xa6q5hyNGxkGvfig==
X-Received: by 2002:a17:902:7245:b0:1d4:8d6:13b with SMTP id c5-20020a170902724500b001d408d6013bmr1532940pll.39.1703208870104;
        Thu, 21 Dec 2023 17:34:30 -0800 (PST)
Received: from hcdev-d520mt2.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id 5-20020a170902c24500b001d3d8e718c6sm2258634plg.282.2023.12.21.17.34.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 17:34:29 -0800 (PST)
From: baneric926@gmail.com
X-Google-Original-From: kcfeng0@nuvoton.com
To: jdelvare@suse.com,
	linux@roeck-us.net,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	corbet@lwn.net
Cc: linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	openbmc@lists.ozlabs.org,
	kwliu@nuvoton.com,
	kcfeng0@nuvoton.com,
	DELPHINE_CHIU@wiwynn.com,
	Bonnie_Lo@wiwynn.com,
	naresh.solanki@9elements.com,
	billy_tsai@aspeedtech.com
Subject: [PATCH v3 1/3] dt-bindings: hwmon: fan: Add fan binding to schema
Date: Fri, 22 Dec 2023 09:33:50 +0800
Message-Id: <20231222013352.3873689-2-kcfeng0@nuvoton.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231222013352.3873689-1-kcfeng0@nuvoton.com>
References: <20231222013352.3873689-1-kcfeng0@nuvoton.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Naresh Solanki <naresh.solanki@9elements.com>

Add common fan properties bindings to a schema.

Bindings for fan controllers can reference the common schema for the
fan

child nodes:

  patternProperties:
    "^fan@[0-2]":
      type: object
      $ref: fan-common.yaml#
      unevaluatedProperties: false

Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>
Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
Signed-off-by: Ban Feng <kcfeng0@nuvoton.com>
---
 .../devicetree/bindings/hwmon/fan-common.yaml | 76 +++++++++++++++++++
 1 file changed, 76 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/fan-common.yaml

diff --git a/Documentation/devicetree/bindings/hwmon/fan-common.yaml b/Documentation/devicetree/bindings/hwmon/fan-common.yaml
new file mode 100644
index 000000000000..ba7d6531f01d
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/fan-common.yaml
@@ -0,0 +1,76 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/hwmon/fan-common.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Common Fan Properties
+
+maintainers:
+  - Naresh Solanki <naresh.solanki@9elements.com>
+  - Billy Tsai <billy_tsai@aspeedtech.com>
+
+properties:
+  max-rpm:
+    description:
+      Max RPM supported by fan.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    maximum: 100000
+
+  min-rpm:
+    description:
+      Min RPM supported by fan.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    maximum: 1000
+
+  pulses-per-revolution:
+    description:
+      The number of pulse from fan sensor per revolution.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    maximum: 4
+
+  tach-div:
+    description:
+      Divisor for the tach sampling clock, which determines the sensitivity of the tach pin.
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  target-rpm:
+    description:
+      The default desired fan speed in RPM.
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  fan-driving-mode:
+    description:
+      Select the driving mode of the fan.(DC, PWM and so on)
+    $ref: /schemas/types.yaml#/definitions/string
+
+  pwms:
+    description:
+      PWM provider.
+    maxItems: 1
+
+  "#cooling-cells":
+    const: 2
+
+  cooling-levels:
+    description:
+      The control value which correspond to thermal cooling states.
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+
+  tach-ch:
+    description:
+      The tach channel used for the fan.
+    $ref: /schemas/types.yaml#/definitions/uint8-array
+
+  label:
+    description:
+      Optional fan label
+
+  fan-supply:
+    description:
+      Power supply for fan.
+
+  reg:
+    maxItems: 1
+
+additionalProperties: true
-- 
2.34.1


