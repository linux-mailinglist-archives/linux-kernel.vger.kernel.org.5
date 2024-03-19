Return-Path: <linux-kernel+bounces-107369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F1C387FB8E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 11:12:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 586342819D5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 10:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E0497F480;
	Tue, 19 Mar 2024 10:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="C9FijljL"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654587E0F2
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 10:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710843099; cv=none; b=qkLnVpyNCF+PbJA/41T4kGG+j2GaqlaEorezpDQ0ddwNxaB/5FdkQQA2I/BC7IKcjpwvePxkvSoEQBXnJ1AlFjPHdJew13AUp5Hy1NcCT3wmpkdDr6LbFjLz4nFa3W6zlbpwJTaywwXLbFeI40Rccc1m00JJgC/XlKACKr1TuRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710843099; c=relaxed/simple;
	bh=6FdJ2CW7ns0N7pSBnl0b4vKzClFKqoDHDGQiNlpE6O4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YTtE4cm84bXaJh9jkLKDqYfHOm2wVFWlEZ2Tsu8tUWj0dWTDBr+wn+LkagUh0uqrmhzkStVlXpxGMBgYViGY2nPOvp+Y055FZQ0tcJ6dBDwzI/JCMml0UV1duHagXfyNx0oUmdVVvAdr66i1Ko06cZFuK/TcnP3MfhXDMtrzQlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=C9FijljL; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-41465082887so3190415e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 03:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1710843096; x=1711447896; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/ELHgbJRI0hpdwNdKuAigvNZ6wv0yemP6+rn+V2FMf0=;
        b=C9FijljLBk3NyfIWc29K3674oNYU23qx42iDCoxJqHjVGqWjevtmW8M1pHk266vwDK
         OYfGFCeSxbpSuK6dFT9ArdKSmmt7uvAoZDUPHKsoo1/Q3QQnTBkQMe9WFEzLaho0kBO3
         snPwz/hoUzPrA7Ro+HD/54FnLqCMPTchMy+V3h69hAU5p8w+w2x2FKjmWluOsSJhnvBO
         fLIco+plPNUeKkZUVA/YExvp8HlmcV1hY1g4r47Jngp2qMtr7RaFKe/VJ6hmfoyGH5P8
         7z4Xtk3HKYHRpftgVh6XJKNIdBSQEVOdv/OzP+w4OCLrNJw0fRh6N1ZYWPpOvk4/X5qx
         G90g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710843096; x=1711447896;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/ELHgbJRI0hpdwNdKuAigvNZ6wv0yemP6+rn+V2FMf0=;
        b=U+yhCZCz88jdq3f1rKNNfcSfDuZjkuw8kI8HnKBw+Q5YIrPlPXheHRp8PCqDQIZt8K
         wt/Evwy4It1U4tVMs4iyE4wp5kh0Z0B4AK2kLAafUicgL00v0YhGDgJn+wtxOBctF17F
         NYWX3JVfn+JQ5UK2A+pZ6fNrGExiYtZB6ElFmXxjvJwVmBgU4vNRXPMi7sapkHF1zPgo
         uzKNsGUBt+F2JEEo/ZAPpYVUGCQGG4b0s/jUEd3BNu2AlM6OPDk6v2YMll4rG5jlid/Z
         s/whC7v7QrQ1alJnliuKN0wdboYFc9WEfIYzjPIPbIrncisKfXqHwnX+bGfy48n+I4eU
         SnKg==
X-Forwarded-Encrypted: i=1; AJvYcCXL7HihQPRe5yH1i9vifB31sXbj/QjGIrg4/4WZOrxpJ7GKQRg8UbuCWl199uSFctkSiX9nEuV7ezSwt/Y9r9yudsgyLJ2e5LhnXkt7
X-Gm-Message-State: AOJu0YxH4+YrWvPF5cwXFS/ZAZj3mgqpcMm8LkmxPJCMUuj+ata6DhVy
	Z1rqR8ehF2mqgPJwHG11dEjLdyi4VtS1xbo5dJwlOH/8/pI3b3QjFx1eR/7fbWI=
X-Google-Smtp-Source: AGHT+IGJgOYpFA3y0+DgHBY0+6EXot3CDMWex47C8FEAedK2gdO8eY315+AfFKmhuCZeExNAx0Op2Q==
X-Received: by 2002:a05:600c:3503:b0:414:4d82:e610 with SMTP id h3-20020a05600c350300b004144d82e610mr2127430wmq.7.1710843095915;
        Tue, 19 Mar 2024 03:11:35 -0700 (PDT)
Received: from [192.168.1.63] ([2a02:842a:d52e:6101:6fd0:6c4:5d68:f0a5])
        by smtp.gmail.com with ESMTPSA id je2-20020a05600c1f8200b004133072017csm21096384wmb.42.2024.03.19.03.11.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 03:11:35 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Tue, 19 Mar 2024 11:11:27 +0100
Subject: [PATCH v5 6/7] dt-bindings: iio: adc: ad7380: add support for
 ad738x-4 4 channels variants
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240319-adding-new-ad738x-driver-v5-6-ce7df004ceb3@baylibre.com>
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

Add compatible support for ad7380/1/3/4-4 parts which are 4 channels
variants from ad7380/1/3/4

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 .../devicetree/bindings/iio/adc/adi,ad7380.yaml    | 34 ++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml
index de3d28a021ae..899b777017ce 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml
@@ -15,6 +15,10 @@ description: |
   * https://www.analog.com/en/products/ad7381.html
   * https://www.analog.com/en/products/ad7383.html
   * https://www.analog.com/en/products/ad7384.html
+  * https://www.analog.com/en/products/ad7380-4.html
+  * https://www.analog.com/en/products/ad7381-4.html
+  * https://www.analog.com/en/products/ad7383-4.html
+  * https://www.analog.com/en/products/ad7384-4.html
 
 $ref: /schemas/spi/spi-peripheral-props.yaml#
 
@@ -25,6 +29,10 @@ properties:
       - adi,ad7381
       - adi,ad7383
       - adi,ad7384
+      - adi,ad7380-4
+      - adi,ad7381-4
+      - adi,ad7383-4
+      - adi,ad7384-4
 
   reg:
     maxItems: 1
@@ -56,6 +64,16 @@ properties:
       The common mode voltage supply for the AINB- pin on pseudo-differential
       chips.
 
+  ainc-supply:
+    description:
+      The common mode voltage supply for the AINC- pin on pseudo-differential
+      chips.
+
+  aind-supply:
+    description:
+      The common mode voltage supply for the AIND- pin on pseudo-differential
+      chips.
+
   interrupts:
     description:
       When the device is using 1-wire mode, this property is used to optionally
@@ -79,6 +97,8 @@ allOf:
           enum:
             - adi,ad7383
             - adi,ad7384
+            - adi,ad7383-4
+            - adi,ad7384-4
     then:
       required:
         - aina-supply
@@ -87,6 +107,20 @@ allOf:
       properties:
         aina-supply: false
         ainb-supply: false
+  - if:
+      properties:
+        compatible:
+          enum:
+            - adi,ad7383-4
+            - adi,ad7384-4
+    then:
+      required:
+        - ainc-supply
+        - aind-supply
+    else:
+      properties:
+        ainc-supply: false
+        aind-supply: false
 
 examples:
   - |

-- 
2.44.0


