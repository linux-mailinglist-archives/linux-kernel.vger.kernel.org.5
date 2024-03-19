Return-Path: <linux-kernel+bounces-107365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4915F87FB85
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 11:12:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 966F6B211AD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 10:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C65457E788;
	Tue, 19 Mar 2024 10:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="o3GqbBOg"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2D27D419
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 10:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710843096; cv=none; b=S8oRjZP/l+HJMu1QR1nOvQnMr5FHZ5Y7kdvLD4sb3HsIW4Ihpt1SOSHzSbSZ2azpOfyaT/uDtwDgQr2gGgUR7PkaukqrgVRRfERuf/NuiMylCsHTNKHe04AJfJUPP1oLckab+fPqyE5ScwVmXl4nz3YkFwwzCbJxxp2oat5Hehs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710843096; c=relaxed/simple;
	bh=czaIaHpWacbHvrT3dLJ9BZDtzI53upuZ3C+6jO7LbVE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S0g64XyMgGQ/8xbGMzwdNU2wsMDFUwe10+7RnYL/QbN4+giKWu1970FfHVpFPgi2fNo29DkYQrAAi7uRAkuqge1IDs88x9sZEM+ytDuDU8C5KKUkP7pMDqPRW+5oIcyUca8/yMLC59ambumnqycmmbeEVotsfpAtVvtuy/Jt26g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=o3GqbBOg; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4140aadfe2eso18414205e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 03:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1710843093; x=1711447893; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=20G10aq4n95bwpqPngcQLkJebAykRiVc3dZZR4VCUNM=;
        b=o3GqbBOg35TaabT1yCI2IkRBcWV9cgLS/BW37C0Qs4krfiUfCkQi5uNtZoiAAu5CuA
         OyWSDVBwE+6xFKhU0FKlOXon7JVCN+9oeydcK9crRn28P81FJhROeh+o2Mt/1SiKpQNF
         g0zY9j9yEj6ia6TTkfXcNVLvKMsaPT90SDOJ4Kv3v4qqp+CZ7mvV7dsCbQR3Tf6f+XBY
         sRqsbYB190x1I1JXZ64M5swt35y7a7JVhzXr/OfQvCPHS/921z9PJ77H+OLaw35U4mnH
         7Dn8Ot+OFG4EYvW88u+LGCKMtLf5trBYUofohqnqi226zkcuoDcq04CE1Yv/+a6MY0TB
         wTmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710843093; x=1711447893;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=20G10aq4n95bwpqPngcQLkJebAykRiVc3dZZR4VCUNM=;
        b=jdJXBuC5Byrjh8ceJ02Dm8KnJ6OvkO7gucJjujhXqUz/wKDlRoLMfKtAmPUF596S97
         pLpSEZ6fj2uODSNL11YPztn5iqQ31ummYyJ+xms/BWRaHeJ1LMm96hEx/v6rcQ/NQRzH
         RDHRpHbcDELBfDTe0SyBwsandxiHPHtryhjMogZ1amYO1gphsc/dFCgC7ea2spZxKB+m
         0wYBchhhx/1pxWPoBQIqk3RpkWEY3I7pPDh37bhP3uJumoIcUL422uqweKJwt0sfm9ee
         GLXqRIfW94llABAQdMQBQVRwY50l3AXlUjnpVy5rySQWzzb1HUDmSDSBGNrg9eXKD/Nu
         qaBQ==
X-Forwarded-Encrypted: i=1; AJvYcCVmuRoReJMkpWIRdZqG74MmkUjYOBYmniRx5TLt4IXTOFLiHap3ho56cxMfISlSMTLJMXO3a2T373ZZ0AoGrS3iFd7JctLkiJONkzOQ
X-Gm-Message-State: AOJu0Yy4I4tPUmSgYGJI2MLONQ6bmt1uBTePaelzGziF7HZvsWuTue+l
	xaWD58fuziKCADcn/K7VhvAbNXPXXjhmzIkLyCpHzVqi8N1kRjcgqZ5iOOVC6v8=
X-Google-Smtp-Source: AGHT+IG/ML9RNGlAS9T+wEv3lV+veoRshM4ygPD77/GG6j5CVj46wmGmDSpEJ+nBbNi86BSaZdtXxg==
X-Received: by 2002:a05:600c:1c08:b0:413:fe9d:eaa5 with SMTP id j8-20020a05600c1c0800b00413fe9deaa5mr8977533wms.26.1710843093269;
        Tue, 19 Mar 2024 03:11:33 -0700 (PDT)
Received: from [192.168.1.63] ([2a02:842a:d52e:6101:6fd0:6c4:5d68:f0a5])
        by smtp.gmail.com with ESMTPSA id je2-20020a05600c1f8200b004133072017csm21096384wmb.42.2024.03.19.03.11.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 03:11:32 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Tue, 19 Mar 2024 11:11:24 +0100
Subject: [PATCH v5 3/7] dt-bindings: iio: adc: ad7380: add
 pseudo-differential parts
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240319-adding-new-ad738x-driver-v5-3-ce7df004ceb3@baylibre.com>
References: <20240319-adding-new-ad738x-driver-v5-0-ce7df004ceb3@baylibre.com>
In-Reply-To: <20240319-adding-new-ad738x-driver-v5-0-ce7df004ceb3@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 David Lechner <dlechner@baylibre.com>, Jonathan Cameron <jic23@kernel.org>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>, 
 Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.13.0

From: David Lechner <dlechner@baylibre.com>

Adding AD7383 and AD7384 compatible parts that are pseudo-differential.

Pseudo-differential require common mode voltage supplies, so add them
conditionally

Signed-off-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 .../devicetree/bindings/iio/adc/adi,ad7380.yaml    | 32 ++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml
index 5e1ee0ebe0a2..de3d28a021ae 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml
@@ -13,6 +13,8 @@ maintainers:
 description: |
   * https://www.analog.com/en/products/ad7380.html
   * https://www.analog.com/en/products/ad7381.html
+  * https://www.analog.com/en/products/ad7383.html
+  * https://www.analog.com/en/products/ad7384.html
 
 $ref: /schemas/spi/spi-peripheral-props.yaml#
 
@@ -21,6 +23,8 @@ properties:
     enum:
       - adi,ad7380
       - adi,ad7381
+      - adi,ad7383
+      - adi,ad7384
 
   reg:
     maxItems: 1
@@ -42,6 +46,16 @@ properties:
       A 2.5V to 3.3V supply for the external reference voltage. When omitted,
       the internal 2.5V reference is used.
 
+  aina-supply:
+    description:
+      The common mode voltage supply for the AINA- pin on pseudo-differential
+      chips.
+
+  ainb-supply:
+    description:
+      The common mode voltage supply for the AINB- pin on pseudo-differential
+      chips.
+
   interrupts:
     description:
       When the device is using 1-wire mode, this property is used to optionally
@@ -56,6 +70,24 @@ required:
 
 unevaluatedProperties: false
 
+allOf:
+  # pseudo-differential chips require common mode voltage supplies,
+  # true differential chips don't use them
+  - if:
+      properties:
+        compatible:
+          enum:
+            - adi,ad7383
+            - adi,ad7384
+    then:
+      required:
+        - aina-supply
+        - ainb-supply
+    else:
+      properties:
+        aina-supply: false
+        ainb-supply: false
+
 examples:
   - |
     #include <dt-bindings/interrupt-controller/irq.h>

-- 
2.44.0


