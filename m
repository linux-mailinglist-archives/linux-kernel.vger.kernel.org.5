Return-Path: <linux-kernel+bounces-82492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD45D86854D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 01:57:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FC102860E6
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 00:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7EED525D;
	Tue, 27 Feb 2024 00:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kgc535m5"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7695F4A29;
	Tue, 27 Feb 2024 00:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708995425; cv=none; b=H0i4sjiHu91Rf2dlsRiJwapFG6FINzUsLyxC54N/vGhgHX+PT8yFKSXKWwnpBwblTdpCmHr8shbVSgaiYn67UjeyGwQNErLfmiKg+LlRt7bIcUig1dSbdpdOtLwsKwwXTHl/ZP+2CVo9mAKW8IsR4ULipqUO6+e5Mo3j7nsdaQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708995425; c=relaxed/simple;
	bh=xt+P52CkE2QqdybtNxMmcXYypfUOZZ7DvOIFDhA5jR0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FbR/6B3KpqCotlpfagPu1PK7WP/W7fYpYZ/qlYRa1Gb+VbzF8W49zP7IAZHpmPF1TsRGjwo9UX5Reo/eoshiuda55CddFf6ex5OcnPvn4xoXsdCnWut59+cNnz/z9I7K2XTWNsvTuS30MsakgaLDgVIhQinAUbQG7n+4YxWUuFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kgc535m5; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1dcafff3c50so8916835ad.0;
        Mon, 26 Feb 2024 16:57:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708995423; x=1709600223; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tla499i31FteRARO4yRBYIXYdMACpp2W1rRXAXvCyxw=;
        b=kgc535m5t/1QB6ntVhEjGrz40jGndEmcSqVgGKs6S42P4nDJfjWJgA+SNGaWwOo5+O
         8Dcy8BLBCnloVVys9bZMJ5H0qIBOjYu351xFJv4wpQlyOUfIRu+oUqQqq6dPXNdL6J97
         XICzyxpTIMxReZHYb3J/0wqmKSmdh3t9MlS82WvQGDhr2DdRtI1pxVi0arF8A4c972gh
         jmUe2SqPM5YNSWia0dDL6SHDzlE2efPjIRsWP8T2vrZk6QrU/2+/Hn7x+blOwj+lgoWI
         UqrP8QqP1/x4hrdKvGtd6UZwdR/8NZcKZoFMKpIbYLnsrZ19WUIPSKZPLrPZPZk5KqrJ
         vxlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708995423; x=1709600223;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tla499i31FteRARO4yRBYIXYdMACpp2W1rRXAXvCyxw=;
        b=Mq1jptoPpjq2U019fJdyju8aROaFOclW/jQB/rPdvxx+yhNdovr2exACiPF6RqfDBy
         Vd7vVIBgumGuEDiiOeY7Xvr/m387bTfRuHV+e8I6ZEW40P08wIalFE09tG+DToUJaWll
         WlNXMFJQWWNsDNGV7BdGn0otRCyojWCOHUUYsmxjwM/Oq3nFglOOvdOseftD1Rx/zXFc
         p75d2vBzEI0R2DRYPeOFrGTko3MUBf2F/3t2JO51cAYxSLRefJnjFpozn5Nbb994DdeV
         hRjzjka+qijKka+xnuZ/wIdQSOHdiEPL1lmNhYTj/I7ttfixL/f9nwU0DqqZceRvwwyI
         s9Iw==
X-Forwarded-Encrypted: i=1; AJvYcCUTSNPNw/S5eklcMGvpQRyjcUdNivkBneEIcfHihog7xBtSKZKhrkfUngSt8bgtFo4LPc3DkTC3k+C4swo2S+0qWYy+1CVf2hGxGOEWHMfackBTqtD6gqXt8Di1psxl4Zrg0iCKmOXPkLpd8Ol8Q+JAqAnHvbrIOEUvWA03e+/ZmyeC+g==
X-Gm-Message-State: AOJu0Yzv4fXurRP2a+LOo6L3/YIYJOeHszmdHoimLIgXpfopyiDprDk+
	i6C6iYWWjtfybzhBPKzJGx0xWTx70q9BZhWcsAOv0iICWmV6iXoM
X-Google-Smtp-Source: AGHT+IGCy+oh/bhTmP6gkGaiFn4PrQOA8ZorBecG2+JPULAK9/O1vc3Sngfq2A/mk+7XsqD5Pb9Yyg==
X-Received: by 2002:a17:902:bf49:b0:1db:f371:dc90 with SMTP id u9-20020a170902bf4900b001dbf371dc90mr8777057pls.20.1708995422708;
        Mon, 26 Feb 2024 16:57:02 -0800 (PST)
Received: from hcdev-d520mt2.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id t12-20020a170902e84c00b001db3361bc1dsm289253plg.102.2024.02.26.16.56.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 16:57:02 -0800 (PST)
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
	billy_tsai@aspeedtech.com,
	Rob Herring <robh@kernel.org>
Subject: [PATCH v4 1/3] dt-bindings: hwmon: fan: Add fan binding to schema
Date: Tue, 27 Feb 2024 08:56:04 +0800
Message-Id: <20240227005606.1107203-2-kcfeng0@nuvoton.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240227005606.1107203-1-kcfeng0@nuvoton.com>
References: <20240227005606.1107203-1-kcfeng0@nuvoton.com>
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

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>
Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
Signed-off-by: Ban Feng <kcfeng0@nuvoton.com>
---
 .../devicetree/bindings/hwmon/fan-common.yaml | 78 +++++++++++++++++++
 1 file changed, 78 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/fan-common.yaml

diff --git a/Documentation/devicetree/bindings/hwmon/fan-common.yaml b/Documentation/devicetree/bindings/hwmon/fan-common.yaml
new file mode 100644
index 000000000000..15c591c74545
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/fan-common.yaml
@@ -0,0 +1,78 @@
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
+    enum: [ dc, pwm ]
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
+
-- 
2.34.1


