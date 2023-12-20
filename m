Return-Path: <linux-kernel+bounces-6141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A9FB819512
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 01:20:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D61DB246E7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 00:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 746F120FC;
	Wed, 20 Dec 2023 00:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OQmCpYNm"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64DADB660;
	Wed, 20 Dec 2023 00:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-77fa980b50aso328010385a.3;
        Tue, 19 Dec 2023 16:19:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703031553; x=1703636353; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=meLKqm86U76iMcMmqxuxzpMVgH/WS4qTltle+XEqnQE=;
        b=OQmCpYNmz0FfkOKwZcsZn5JXmQg3xso5xaV8JDgXGPPM2iOLTsHf0FcDRjH2I7Rzy2
         lzhzE3/24Hb/QhJn6aiWIXUd98DHLRSQMZ4HY0fYGLphyGH9LA2V70vXZT2i+MGZyEkL
         oL8ELXgvksLl38AOBfEfuoVtF34krhL6FJ9ujH8j/sjGsKXGUGPwDkTsBcZ+XIqO5nqa
         8e3d6Ngijk9S4CqIE2OwymLpwDMPEwzK1J6CiytdUyZ77zS2N/lXvo/Oq2VPozt9QN5g
         X/zfxBB/BQ75lXq0S0Hy6uEf7jhNmNXg2iDVHv0UkOl9/oNvyJVCWSs8vKAFGl+73m+W
         4qJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703031553; x=1703636353;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=meLKqm86U76iMcMmqxuxzpMVgH/WS4qTltle+XEqnQE=;
        b=J5IIebDkjMOc9rW9/C1swaH640XTA084xWXZvo2wsA0ouMstA2dzZcHF1GMACPVVgv
         y30Qz32jIAl2niPN4kdB3r1FfFmxTh+A2ggX1Jq+Z6HBQeD0uE/PJdpJZVCw0tm+IlHc
         UqUV7K3FOF7K+mV+2hpY5b5E+8KbuXvrQvtSTEJ3LCp6v6ChHxqCcPrALTRRLpivkBAb
         WLbfiwoQ7CDM7G7tP8/pboi4rMv7epTLRTNi5Qlnc7QY+wPjaC88WzUsGQHdPwgk/Mvm
         slQ6qsr2P81KkP3QpNA9f2tOTvI5M50INieZhqn2Gg5z3GKzeeUBdUdrphj3E2JBnYfu
         bK4A==
X-Gm-Message-State: AOJu0YyTjc5PUzK0yIxlhp1ZicD4kpbgNCOQMlvWY3mzNnq5LhmzsA0D
	2BuO5sHuVT/QmpySfdwbNsA=
X-Google-Smtp-Source: AGHT+IF03ORjQpot6OdjDBHZZ9wMEUcfKs6SFiHIM+pbsb3kmTs+e9FbE3Jj5SmCOl8ealfugR6mPw==
X-Received: by 2002:ad4:594d:0:b0:67f:494b:c1f8 with SMTP id eo13-20020ad4594d000000b0067f494bc1f8mr4440459qvb.32.1703031553244;
        Tue, 19 Dec 2023 16:19:13 -0800 (PST)
Received: from localhost.localdomain ([174.95.13.129])
        by smtp.gmail.com with ESMTPSA id da14-20020a05621408ce00b0067a276fd8d5sm3814094qvb.54.2023.12.19.16.19.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 16:19:12 -0800 (PST)
From: Abdel Alkuor <alkuor@gmail.com>
To: Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Abdel Alkuor <alkuor@gmail.com>,
	linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH v3 1/2] dt-bindings: hwmon: (lm75) Add AMS AS6200 temperature sensor
Date: Tue, 19 Dec 2023 19:17:47 -0500
Message-Id: <af834e980f57dc11d3e821c074c433cdbc6accc3.1703030297.git.alkuor@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

as6200 is a temperature sensor with a range between -40°C to
125°C degrees and an accuracy of ±0.4°C degree between 0
and 65°C and ±1°C for the other ranges.

Signed-off-by: Abdel Alkuor <alkuor@gmail.com>
---
Changes in v3:
  - Enable interrupt property conditionally based on the chips that
    support it.
  - Fix alignment for the added example
Changes in v2:
  - Incorporate as6200 into lm75 bindings

 .../devicetree/bindings/hwmon/lm75.yaml       | 29 +++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/Documentation/devicetree/bindings/hwmon/lm75.yaml b/Documentation/devicetree/bindings/hwmon/lm75.yaml
index 0b69897f0c63..c5b2ec0b2c84 100644
--- a/Documentation/devicetree/bindings/hwmon/lm75.yaml
+++ b/Documentation/devicetree/bindings/hwmon/lm75.yaml
@@ -14,6 +14,7 @@ properties:
   compatible:
     enum:
       - adi,adt75
+      - ams,as6200
       - atmel,at30ts74
       - dallas,ds1775
       - dallas,ds75
@@ -48,10 +49,24 @@ properties:
   vs-supply:
     description: phandle to the regulator that provides the +VS supply
 
+  interrupts:
+    maxItems: 1
+
 required:
   - compatible
   - reg
 
+allOf:
+  - if:
+      not:
+        properties:
+          compatible:
+            contains:
+              const: ams,as6200
+    then:
+      properties:
+        interrupts: false
+
 additionalProperties: false
 
 examples:
@@ -66,3 +81,17 @@ examples:
         vs-supply = <&vs>;
       };
     };
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      temperature-sensor@48 {
+        compatible = "ams,as6200";
+        reg = <0x48>;
+        vs-supply = <&vs>;
+        interrupt-parent = <&gpio1>;
+        interrupts = <17 IRQ_TYPE_EDGE_BOTH>;
+      };
+    };
-- 
2.34.1


