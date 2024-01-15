Return-Path: <linux-kernel+bounces-26061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2CB782DAAF
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 14:55:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01BE31C2117F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 13:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4C6F17BD4;
	Mon, 15 Jan 2024 13:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S0Zq/aVH"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1A7179AA;
	Mon, 15 Jan 2024 13:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40e67e90d5aso28191325e9.1;
        Mon, 15 Jan 2024 05:54:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705326863; x=1705931663; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K85zJT+qT++kzzI1xx0+ItX9vmO1s0PJ1u1koFzADEI=;
        b=S0Zq/aVHNBBNXpmJZqxWNAGtmyUAtZiSrDI5MYkWonN4wvTzfbfZmMJaf78Pfz23ai
         3RMo5j6wedcxm5izvxnXUdjXJGzaiP4F6yd7y//EO+iotbplORq2Czn/TYg2J52YONeD
         9ONwogTkvFgOw0ma1USL2MgMD+XGFBssC7HipMHWvVcgi9RT7t60oOLsut64fq1iOA5d
         W6JQ9AVLrOg4/nljJPXR0QUmzew0w+SDUHnpKQinpQpZEkhtohREKY4J01FTen0LLHQj
         NPTz+ierlZfg8ySU7MuMBTy1t24hUANJrQmjY+oLe3DqA/8+9IFPS2T4rjPqzo0ir0XB
         KMdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705326863; x=1705931663;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K85zJT+qT++kzzI1xx0+ItX9vmO1s0PJ1u1koFzADEI=;
        b=u6bSSzxDkFONx/K/T23FeTK81wDUXjSXj7SNUNyIIYPWc+ZuIJQGN8UmZAJByDYVja
         Dt+l6Lw/2cPWEQe1wJq2gYjedafzbxGr/sSB+Xa8i1xvOWVwyA5tbyd7M4RjLwOPEMFh
         K2vYKRqNv5LTgU8iYHuWEr5HhjC6+YnEe2KGprytXmpTUegd7h+WlsttmOoPisODwKrv
         SoaRFNi6kZeeIXsEh/JlUlZVpFH1V+iQ9iRlJz82MRRUB9GYcsEllGWblvHkniaLODU3
         rLwwu1rVcXTxQ8Arfm4wnltw8iCvELKS2KBBNYkfoQRJdf+aisDHvwzoHf7YP0UfwFv+
         07+Q==
X-Gm-Message-State: AOJu0YxeTIb/ca2WaMMztUY+FzxkZV/E0T1M5DXSIObxWfLvux4v8Y2B
	feDmU7ZKoO5FWtWOFx5OJas=
X-Google-Smtp-Source: AGHT+IFwESFgNF+3ChGf8GmousVzzkoYtmmmkjmn5rdFsDbpXL4ZYC28MyO2oCxsphK56KbL4DcLFg==
X-Received: by 2002:a05:600c:218:b0:40d:8199:c3f with SMTP id 24-20020a05600c021800b0040d81990c3fmr2695257wmi.153.1705326863136;
        Mon, 15 Jan 2024 05:54:23 -0800 (PST)
Received: from HYB-hhAwRlzzMZb.ad.analog.com ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id r10-20020a05600c458a00b0040e6efeac9esm7979651wmo.48.2024.01.15.05.54.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 05:54:22 -0800 (PST)
From: Dumitru Ceclan <mitrutzceclan@gmail.com>
To: 
Cc: linus.walleij@linaro.org,
	brgl@bgdev.pl,
	andy@kernel.org,
	linux-gpio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	ChiaEn Wu <chiaen_wu@richtek.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	=?UTF-8?q?Leonard=20G=C3=B6hrs?= <l.goehrs@pengutronix.de>,
	Mike Looijmans <mike.looijmans@topic.nl>,
	Haibo Chen <haibo.chen@nxp.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Ceclan Dumitru <dumitru.ceclan@analog.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dumitru Ceclan <mitrutzceclan@gmail.com>
Subject: [PATCH 1/2] dt-bindings: adc: ad7173: add support for additional models
Date: Mon, 15 Jan 2024 15:53:04 +0200
Message-ID: <20240115135416.10595-2-mitrutzceclan@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240115135416.10595-1-mitrutzceclan@gmail.com>
References: <20240115135416.10595-1-mitrutzceclan@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for: AD7172-2, AD7175-8, AD7177-2
Add hardware description of the AD771X family instead of "Bindings for"
AD7172-4 does not feature an internal reference, check for ext-ref

Signed-off-by: Dumitru Ceclan <mitrutzceclan@gmail.com>
---
 .../bindings/iio/adc/adi,ad7173.yaml          | 50 +++++++++++++++++--
 1 file changed, 46 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml
index 7c8caef76528..6d4b26e43144 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml
@@ -11,19 +11,33 @@ maintainers:
   - Ceclan Dumitru <dumitru.ceclan@analog.com>
 
 description: |
-  Bindings for the Analog Devices AD717X ADC's. Datasheets for supported chips:
+  Analog Devices AD717X ADC's:
+  The AD717x family offer a complete integrated Sigma-Delta ADC solution which
+  can be used in high precision, low noise single channel applications
+  (Life Science measurements) or higher speed multiplexed applications
+  (Factory Automation PLC Input modules). The Sigma-Delta ADC is intended
+  primarily for measurement of signals close to DC but also delivers outstanding
+  performance with input bandwidths out to ~10kHz.
+
+  Datasheets for supported chips:
     https://www.analog.com/media/en/technical-documentation/data-sheets/AD7172-2.pdf
+    https://www.analog.com/media/en/technical-documentation/data-sheets/AD7172-4.pdf
     https://www.analog.com/media/en/technical-documentation/data-sheets/AD7173-8.pdf
     https://www.analog.com/media/en/technical-documentation/data-sheets/AD7175-2.pdf
+    https://www.analog.com/media/en/technical-documentation/data-sheets/AD7175-8.pdf
     https://www.analog.com/media/en/technical-documentation/data-sheets/AD7176-2.pdf
+    https://www.analog.com/media/en/technical-documentation/data-sheets/AD7177-2.pdf
 
 properties:
   compatible:
     enum:
       - adi,ad7172-2
+      - adi,ad7172-4
       - adi,ad7173-8
       - adi,ad7175-2
+      - adi,ad7175-8
       - adi,ad7176-2
+      - adi,ad7177-2
 
   reg:
     maxItems: 1
@@ -89,8 +103,10 @@ patternProperties:
           refout-avss: REFOUT/AVSS (Internal reference)
           avdd       : AVDD
 
-          External reference refin2 only available on ad7173-8.
-          If not specified, internal reference used.
+          External reference refin2 only available on ad7173-8 and ad7172-4.
+          Internal reference refout-avss not available on ad7172-4.
+
+          If not specified, internal reference used (if available).
         $ref: /schemas/types.yaml#/definitions/string
         enum:
           - refin
@@ -111,12 +127,15 @@ required:
 allOf:
   - $ref: /schemas/spi/spi-peripheral-props.yaml#
 
+  # Only ad7172-4 and ad7173-8 support refin2
   - if:
       properties:
         compatible:
           not:
             contains:
-              const: adi,ad7173-8
+              anyOf:
+                - const: adi,ad7172-4
+                - const: adi,ad7173-8
     then:
       properties:
         refin2-supply: false
@@ -129,6 +148,29 @@ allOf:
                 - refout-avss
                 - avdd
 
+  # Model ad7172-4 does not support internal reference
+  #  mandatory to have an external reference
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: adi,ad7172-4
+    then:
+      patternProperties:
+        "^channel@[0-9a-f]$":
+          properties:
+            adi,reference-select:
+              enum:
+                - refin
+                - refin2
+                - avdd
+              default: false
+          required:
+            - adi,reference-select
+      oneOf:
+        - required: [refin2-supply]
+        - required: [refin-supply]
+
 unevaluatedProperties: false
 
 examples:
-- 
2.42.0


