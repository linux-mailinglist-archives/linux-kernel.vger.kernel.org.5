Return-Path: <linux-kernel+bounces-93836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 63436873563
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 12:10:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 866591C22670
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 11:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D2A377F12;
	Wed,  6 Mar 2024 11:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aXs3uIeF"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB535FB91;
	Wed,  6 Mar 2024 11:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709723410; cv=none; b=RxsJCbMGoLUC56Yop3iURDlv7osPzHBozw6QIXs40J6MgsXZe6YsIe7n/P6vSdfciFnW3BN2GYQV8jhEVDJeZumBv/tx/h5xalm9Ozj+CPGvPTu95ZjbThOGwh7qEBBOIyaOdUYJLxwkWsGtEnU4G4Ck8JPgkNn8/ydn8J2Inzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709723410; c=relaxed/simple;
	bh=xM/qLoPo9oJykJCfWxb6HZg/Jzg24FTEt0CjZITzZT0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gWiAeQuM6wwqPJh+/GvAa8VM+k0Did/0zX0AVeiIih4wyThp1lc3QUNOAw5ACuAVjdw0OewPSJgv7nprvXPwgyxZz90uDHJzFuTflGrviIeRrNPzXeHb82KAf0ookMOC0UOaj59WZdj8M2+wNNYkdnb0vo9Q0Ndob4tjn5gx/UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aXs3uIeF; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2d3fd0e6832so8936951fa.2;
        Wed, 06 Mar 2024 03:10:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709723407; x=1710328207; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a/n875ZVkVVNvvL6uVSJ+VnT1mBwNw8mXu8sRTs/2+Q=;
        b=aXs3uIeFQhS9/TVbra1AGchOmgPAPGyDxIcRGgbPQ+cRzxMsSwYeZF+T4HtRRKPrtB
         tAq4s1BmSFipKxi4Fbea6qRtOXDRCYlkBgPlXt4RWhoqALoFRVOUkP+rnND7rCJeOJJP
         SJQV7nWFPUh1tvYQG4ve4ah514a1fPpjG71QR6cADFXo0mqKgE0Kmz5+TaqJDubKzB/P
         inY0yjItWoeDLbtInzD5vPXyQ+BXxraXYOk3zjk+lNAlWBG+z7l814qJnmhQO+P+5rUi
         ucctRJodPT08b/lzUFvQquBwJjcYEJK1OUcgCtG8o9829tIeohwkqXSsgX+/AE2NjCkb
         L4Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709723407; x=1710328207;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a/n875ZVkVVNvvL6uVSJ+VnT1mBwNw8mXu8sRTs/2+Q=;
        b=YiQhGhfkoMh4vJhgYg5Tm7uM0+uXdlPvPVwtGj/H+tsvc042S2x1It6m33hK40o9Gv
         EChz+7pV51xUtdSUQvi6QN/cX4tJY7P1PaJ29wR/dbpFfLwQhR9sYiwcaMA6fJIF+t6o
         KCUbd7zeGbvTziSZfCaKTrPtJNBMrovt1OlZvWMdosl0SzXOZGKQ/7JIwmHXYfPiEEf4
         DVaHKQX3KU4ewLlcFslFcLRVaAB7gVlm2w7VEx5gzJVp+q3OLGv0AJxYrRDk+4X6uZK2
         VmZn+CJZNd3d+lArdy3LXDDn0dD1S4yje3g3jANHcOlapgOOAogRTra0tYvNCocvL+w5
         D0Rg==
X-Forwarded-Encrypted: i=1; AJvYcCUSFiqyp7UxkWGcagaYWtxmLh5EV0fHVME5D7xg1C3BDs4IKFF7DEova5xFbIuW08eMqkho5pNpFsvlLkil58wvlWa2xgLEQholWtFaG2z2rP+XzsvoDY8ub+TJU+Ptwy32X8Hi5Cz1fA==
X-Gm-Message-State: AOJu0YyVHD3mjXQCW+jS12qRhMWUOevWiGohNLH+lNA3Bn/F8L7PaDLK
	dvgpRuhAsk7wmLR8+iJYRUYdaWWiy0jHILFeGu2ioQogV9xo2ScUBaJa/rumT1YMbQ==
X-Google-Smtp-Source: AGHT+IGaO5dUmMQNROYg5Hsthg07LVP56kZIeFs0pHT82csPMOsKQ+tUFQIWBI6hAGOFX2SqYxEAsw==
X-Received: by 2002:a05:6512:559:b0:513:5af1:c70b with SMTP id h25-20020a056512055900b005135af1c70bmr1313263lfl.46.1709723406346;
        Wed, 06 Mar 2024 03:10:06 -0800 (PST)
Received: from HYB-hhAwRlzzMZb.ad.analog.com ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id w26-20020a170906385a00b00a4394f052cesm7002479ejc.150.2024.03.06.03.10.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 03:10:05 -0800 (PST)
From: Dumitru Ceclan <mitrutzceclan@gmail.com>
To: dumitru.ceclan@analog.com
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lars@metafoo.de,
	jic23@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	dlechner@baylibre.com,
	Dumitru Ceclan <mitrutzceclan@gmail.com>
Subject: [PATCH v3 1/3] dt-bindings: adc: ad7173: add support for additional models
Date: Wed,  6 Mar 2024 13:09:54 +0200
Message-ID: <20240306110956.13167-2-mitrutzceclan@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240306110956.13167-1-mitrutzceclan@gmail.com>
References: <20240306110956.13167-1-mitrutzceclan@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for: AD7172-2, AD7175-8, AD7177-2.
AD7172-4 does not feature an internal reference, check for external
 reference presence.

Signed-off-by: Dumitru Ceclan <mitrutzceclan@gmail.com>
---
 .../bindings/iio/adc/adi,ad7173.yaml          | 39 +++++++++++++++++--
 1 file changed, 36 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml
index 36f16a325bc5..ea6cfcd0aff4 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml
@@ -21,17 +21,23 @@ description: |
 
   Datasheets for supported chips:
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
@@ -136,8 +142,10 @@ patternProperties:
           refout-avss: REFOUT/AVSS (Internal reference)
           avdd       : AVDD  /AVSS
 
-          External reference ref2 only available on ad7173-8.
-          If not specified, internal reference used.
+          External reference ref2 only available on ad7173-8 and ad7172-4.
+          Internal reference refout-avss not available on ad7172-4.
+
+          If not specified, internal reference used (if available).
         $ref: /schemas/types.yaml#/definitions/string
         enum:
           - vref
@@ -157,12 +165,17 @@ required:
 allOf:
   - $ref: /schemas/spi/spi-peripheral-props.yaml#
 
+  # Only ad7172-4, ad7173-8 and ad7175-8 support vref2
+  # Other models have [0-3] channel registers
   - if:
       properties:
         compatible:
           not:
             contains:
-              const: adi,ad7173-8
+              enum:
+                - adi,ad7172-4
+                - adi,ad7173-8
+                - adi,ad7175-8
     then:
       properties:
         vref2-supply: false
@@ -177,6 +190,26 @@ allOf:
             reg:
               maximum: 3
 
+  # Model ad7172-4 does not support internal reference
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: adi,ad7172-4
+    then:
+      patternProperties:
+        "^channel@[0-9a-f]$":
+          properties:
+            reg:
+              maximum: 7
+            adi,reference-select:
+              enum:
+                - vref
+                - vref2
+                - avdd
+          required:
+            - adi,reference-select
+
   - if:
       anyOf:
         - required: [clock-names]
-- 
2.43.0


