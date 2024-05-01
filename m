Return-Path: <linux-kernel+bounces-165398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B15C8B8C42
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 16:56:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A71F1F2198D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 14:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37F0112FB20;
	Wed,  1 May 2024 14:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Ihh5VOAF"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D4512F588
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 14:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714575355; cv=none; b=jdFf+yHm6eO6dpi4ikv/O4/T9aUOnNbqRU1y1OXSl2G7fY8VryyKdoGqSWXChmyVdTbcN8885MelhEE5eRyW65602PZ6wMJGMrZmMi+0RjN7lUuL99agWDAIDT1lWKgvnL1HeWXaexZyYtdNoU2jTdgGSq2XVLbv8SzAv7wqVqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714575355; c=relaxed/simple;
	bh=OB8tgBWPkNRhkYwIg+R2Ji0Wb3SGKEyVa27sOqMTYcs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Yb2RFVmtHk+oR+z454CMXgtkQ14Bg320gQI/FJKVz5z/oNBSCGKxuUvbvmEjnHN3P5VmRYacd7kvL/j29Nncvm1WyXmd/9ka4HtP7xa0PZemSEKRWbLoK2Jp9zHj/tylzCgQ7xV2VkizAu0aE3EruSjmwtLP8LTYjuVdL8oC8f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Ihh5VOAF; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-34dc9065606so384991f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2024 07:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1714575352; x=1715180152; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kJ8CU1KsZdsOI/zOnwTeILM7ZuUE9hyEpMnwtAluPZE=;
        b=Ihh5VOAF5kqM+khFfNVYVVEgLvdamwx3Rx+OxH6lfnPkr7UyIN8KTqfLhn2LDuHj+X
         H3NK7Xd1xKAC8uei6tASU3u40u/FOqIVRSm9AFAbhu0Iuqcd8dNeyJXVnuIIYv4IMzgI
         T6ZXiHbvlAkwr6+f84ODRkH9F30WAucHK09QlEv5E2EqUs+fpSll9/N99RK5gt+8hc+i
         mQJas8mxfCfCzKzviAbThhJA63v4GbT1vsu1SCae7fc/QpN4FgYe2eq1e9Rqk6GJAt2P
         gcs7E6PEeXljlbkmrAaLQXzcH4oCnTHQV0h7rKYs1sEDM/S8x8rc+GLvwzfnyY9t1D6z
         BJeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714575352; x=1715180152;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kJ8CU1KsZdsOI/zOnwTeILM7ZuUE9hyEpMnwtAluPZE=;
        b=gn5nAfDYvmwGkE6nBFpzVtLKtfsMpxY4HDDZSeAHp7rA01ka3MFKyOiaPeFqfd4mFL
         AGnjZgVPUuRMAAryq5AJBV6AhBMUhX/sWjSKSyddXbp2QKDLaeD4ozX3r1LB1SfFZKv8
         DjUCZsMtaAFOioWfG2M8qds0dbisX0UwjXH53p29ghhmcKvarZKnqhro4qsC2kLAwEOc
         04mzcNgT2jYwub+d3HrTSI0GUGWiu33jpeY1Q4ypmRKvxz2Mkn7lpkgBMDm9BfQU8lvI
         LVzcfCR8nLXPwYOptZXIUtm0kf6irAk+tgfjdxhnlJemmaiY+kIMWfhMkTX1WAv0tBNN
         o5FQ==
X-Forwarded-Encrypted: i=1; AJvYcCXwUiDPzhuiVbBGaCACiGZTCNUL61GunI+J9Z5cuJfGWCXCLqAeROnG05McPlEyp9EvYhaa6FEUJUbOSfTBm6WcPlXJ6Rr2sPX/ZGGe
X-Gm-Message-State: AOJu0YwLzAiwpIS8DRpBEBXcqKcrf0GMYk8M5xpo0F/PX0YzMw5eIAzK
	GemRFEgRppL07jOgYxnLLbm5nhzBn+GP112dYlU1cFKglaZzGh9rTAsC9XqRUY8=
X-Google-Smtp-Source: AGHT+IEbjszfmVkTzjjE49mNkp1RDoY6WJdm5Dh/H6CEyFull2eOfXFaa255+mdEhVRdivb1lKxn4A==
X-Received: by 2002:adf:e708:0:b0:34d:a37d:d383 with SMTP id c8-20020adfe708000000b0034da37dd383mr3329382wrm.22.1714575352183;
        Wed, 01 May 2024 07:55:52 -0700 (PDT)
Received: from [192.168.1.61] ([2a02:842a:d52e:6101:6fd0:6c4:5d68:f0a5])
        by smtp.gmail.com with ESMTPSA id o27-20020a05600c511b00b00418a386c17bsm2422999wms.12.2024.05.01.07.55.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 07:55:52 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Wed, 01 May 2024 16:55:36 +0200
Subject: [PATCH RFC v6 03/10] dt-bindings: iio: adc: ad7380: add
 pseudo-differential parts
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240501-adding-new-ad738x-driver-v6-3-3c0741154728@baylibre.com>
References: <20240501-adding-new-ad738x-driver-v6-0-3c0741154728@baylibre.com>
In-Reply-To: <20240501-adding-new-ad738x-driver-v6-0-3c0741154728@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 David Lechner <dlechner@baylibre.com>, Jonathan Cameron <jic23@kernel.org>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>
Cc: kernel test robot <lkp@intel.com>, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Julien Stephan <jstephan@baylibre.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.13.0

From: David Lechner <dlechner@baylibre.com>

Adding AD7383 and AD7384 compatible parts that are pseudo-differential.

Pseudo-differential require common mode voltage supplies, so add them
conditionally

Signed-off-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Julien Stephan <jstephan@baylibre.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
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


