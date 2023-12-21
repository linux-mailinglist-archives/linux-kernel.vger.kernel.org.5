Return-Path: <linux-kernel+bounces-8292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CA7C81B509
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 12:39:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EFA62869C8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 11:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BC0D6EB44;
	Thu, 21 Dec 2023 11:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nmjIcpmY"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B196DCF5;
	Thu, 21 Dec 2023 11:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-33664b4e038so585241f8f.3;
        Thu, 21 Dec 2023 03:38:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703158738; x=1703763538; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RMm8zv9Z35kfc5G03goO2WZtkIVh50f0pyRY4VXxFeA=;
        b=nmjIcpmY4vP3OaJqBqelA1npWI3OBtwTdaOEJxXZW41XxFPAVE0lx9x5kEz0kULPqw
         QcDlHZHylDnHrPxL2+h8+gp0/hMJhvR0WPBhskFx6gKBcC7UrdfSryRfIxJZzzPOa+RN
         hSiJH6nHsHRsC/AWxGSdJ3f4mr/L4ZYAFFxfULtuUvk362MflygkCBY/K4TWkpEXkVxj
         99M0zlnyVxGQAXagTCi5q/+VTAmO1q4xgWMX7Wp66sE9S9Xs0KF0gzkoVmDUCIRYDfZB
         mqAmQwkJ4Mfxy/Umm2q0C1rj5IqekpkGqXy6WEBUJiRtVffr/1008k2iGKcfBTruOJT8
         D1aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703158738; x=1703763538;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RMm8zv9Z35kfc5G03goO2WZtkIVh50f0pyRY4VXxFeA=;
        b=EwYpiTApwS7QM6uXPBe7i0e1Q4an/1dtK//xaRVbUlAKRXGxMCUYD3/+zHFq263Sm9
         GkVSwXGg1kG75CUICpYod52AeI67ts+7QD4l6spY5E9nOkgiQc6O66joH40fp8kKO8f2
         D6mH3EJKxCUQFe9GgUlE7tZRW2Ip2kaauuDApJwLGcnTVGc74SxPJrmdOVOjzEjl3SdW
         WpsuIcfqnSAN/STdY72AxFkTNY4T1+BcZsuvOkO8/OEf93toQFBYaJcjuPPq4e6R+5LZ
         gh3AngAmkt3WiuRKK9L4GRMkJXrtkV1jyeKvQIl8DGc7m969AKCQEqkEofxMtXF4Ibua
         iIfA==
X-Gm-Message-State: AOJu0Yw5PP2xeDYHIAByVKHS5Qe1FFfTH0uSAiYnIC2ZUMtERUduB3nd
	YsTTAdCfLdt7t2dig5fk1k48+JmL9Qx8bw==
X-Google-Smtp-Source: AGHT+IFy0iFzXTrN/MFkPuGfj8NQK+drRNF0WfZNeM/uI4dYSLRZnJ1ONSZgUXaEJzGtQpkG4QfWSw==
X-Received: by 2002:a05:600c:a297:b0:40c:6138:981a with SMTP id hu23-20020a05600ca29700b0040c6138981amr592707wmb.38.1703158737974;
        Thu, 21 Dec 2023 03:38:57 -0800 (PST)
Received: from HYB-hhAwRlzzMZb.ad.analog.com ([213.157.161.11])
        by smtp.gmail.com with ESMTPSA id fl25-20020a05600c0b9900b0040b3e26872dsm10940404wmb.8.2023.12.21.03.38.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 03:38:57 -0800 (PST)
From: Dumitru Ceclan <mitrutzceclan@gmail.com>
To: 
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ceclan Dumitru <dumitru.ceclan@analog.com>,
	Dumitru Ceclan <mitrutzceclan@gmail.com>
Subject: [PATCH 1/3] dt-bindings: iio: hmc425a: add entry for LTC6373
Date: Thu, 21 Dec 2023 13:38:38 +0200
Message-ID: <20231221113842.25957-2-mitrutzceclan@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231221113842.25957-1-mitrutzceclan@gmail.com>
References: <20231221113842.25957-1-mitrutzceclan@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The LTC6373 is a silicon, 3-bit Fully-Differential digital instrumentation
amplifier that supports the following programmable gains (Vout/Vin):
 G = 0.25, 0.5, 1, 2, 4, 8, 16 + Shutdown.

Signed-off-by: Dumitru Ceclan <mitrutzceclan@gmail.com>
---
 .../bindings/iio/amplifiers/adi,hmc425a.yaml     | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/amplifiers/adi,hmc425a.yaml b/Documentation/devicetree/bindings/iio/amplifiers/adi,hmc425a.yaml
index 67de9d4e3a1d..8e7d99823059 100644
--- a/Documentation/devicetree/bindings/iio/amplifiers/adi,hmc425a.yaml
+++ b/Documentation/devicetree/bindings/iio/amplifiers/adi,hmc425a.yaml
@@ -21,6 +21,8 @@ description: |
   HMC540S 1 dB LSB Silicon MMIC 4-Bit Digital Positive Control Attenuator, 0.1 - 8 GHz
     https://www.analog.com/media/en/technical-documentation/data-sheets/hmc540s.pdf
 
+  LTC6373 is a 3-Bit precision instrumentation amplifier with fully differential outputs
+    https://www.analog.com/media/en/technical-documentation/data-sheets/ltc6373.pdf
 
 properties:
   compatible:
@@ -28,6 +30,7 @@ properties:
       - adi,adrf5740
       - adi,hmc425a
       - adi,hmc540s
+      - adi,ltc6373
 
   vcc-supply: true
 
@@ -38,6 +41,19 @@ properties:
     minItems: 6
     maxItems: 6
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: adi,ltc6373
+
+    then:
+      properties:
+        ctrl-gpios:
+          minItems: 3
+          maxItems: 3
+
 required:
   - compatible
   - ctrl-gpios
-- 
2.42.0


