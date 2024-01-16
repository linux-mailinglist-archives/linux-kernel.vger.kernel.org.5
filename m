Return-Path: <linux-kernel+bounces-27514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B73E982F16D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 16:24:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CAF31F24794
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 15:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB6CA1C290;
	Tue, 16 Jan 2024 15:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ELpBQhVl"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E551BF52;
	Tue, 16 Jan 2024 15:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2ccec119587so123326971fa.0;
        Tue, 16 Jan 2024 07:24:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705418673; x=1706023473; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tjjU8IDrB3XaEWVqZQ0UDUmOq+AsoSGQAKLBwBxw4Rg=;
        b=ELpBQhVlYXsc7j4Cxn0vDrqSYWT+k481jQYT9YEvfrT7eO0iiRaQEOQDq2vEUlIhIz
         yqS0r5oEVfL16B1aiwUP7+djtbWdp5yPjP8wwI8XGIOEnWQ55nrEWdE0ZYlrAo3bydut
         L2Xp9qKFfJshIj8cd7pXm6JUJ1fyuXSigQ8ve/qol7p3BO12oHaEKtC2YRPObpcfAls7
         ZFAnBnVedt/TbeXCWLvNQ1dBQ1DWCkH14yp2yebEYmP6p/Z6YedAG/T7B3azFHyZS5Sg
         R4VETZNdO7eBb1roFINISfEtpbGUde6wWbAue0JkSZ2wFm3ajubc87fTrKsrcOm5EigK
         x4NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705418673; x=1706023473;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tjjU8IDrB3XaEWVqZQ0UDUmOq+AsoSGQAKLBwBxw4Rg=;
        b=itAVD8T7yszuVZOWYvtV1U16gMxibfsX5QOvHthjMBOhUjN5CZh8EBZD+IdAYSoiOM
         mXtjkra2eDeh38uClBC+ty5RZvnj6Mpvi9j9ilO/yrTKDFqI5eqSkxL0HKxYaA1pOn30
         OgofG5QtWCF5HBu6TOJV+BquXAx9qNOYM1pjpnuzWBxjemlefGRbigCs5ZAdsFdAX2Oj
         fOEcm4DmAXT216grkocgbyfdC/wQQFpwENdfRpUEG2JWw6fOVFpthZpQuWtct5FIun2S
         gh/k4tV65NLw5UN4N9YODvzlh55P/RmY9vaAapkRpHreTDl4oDn/sKPVShpLG/JYx0NH
         9yHA==
X-Gm-Message-State: AOJu0YxIKxeK6ogczMuMgfS7Q258zJjQrCe3E69z4m19gj2vAREzDvPa
	/J+JGXq136a5bolgkZQaYECd4tgQtlt2CZXbz4wJxG+a46s=
X-Google-Smtp-Source: AGHT+IECsde9ElTDr34bDUzhaluzdwpiZtfcwuDLDW2A8Mj5/e7up+bds0CVsnkRVLGxVaIFt1fubTderGMqJ4jJPsA=
X-Received: by 2002:a2e:a105:0:b0:2cd:9f51:ac23 with SMTP id
 s5-20020a2ea105000000b002cd9f51ac23mr3952853ljl.4.1705418672705; Tue, 16 Jan
 2024 07:24:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Petar Stoykov <pd.pstoykov@gmail.com>
Date: Tue, 16 Jan 2024 16:24:21 +0100
Message-ID: <CADFWO8EomrhEgtC+i9ikkcDU1c05kx-8kjrS4usAv-TRKxif+w@mail.gmail.com>
Subject: [PATCH 1/3] dt-bindings: iio: pressure: Add Sensirion SDP500
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh+dt@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Angel Iglesias <ang.iglesiasg@gmail.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Sensirion SDP500 is a digital differential pressure sensor. It provides
a digital I2C output. Add devicetree bindings requiring the compatible
string and I2C slave address (reg).

Signed-off-by: Petar Stoykov <pd.pstoykov@gmail.com>
---
 .../bindings/iio/pressure/sdp500.yaml         | 38 +++++++++++++++++++
 1 file changed, 38 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/pressure/sdp500.yaml

diff --git a/Documentation/devicetree/bindings/iio/pressure/sdp500.yaml
b/Documentation/devicetree/bindings/iio/pressure/sdp500.yaml
new file mode 100644
index 000000000000..af01ec7e3802
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/pressure/sdp500.yaml
@@ -0,0 +1,38 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/pressure/sdp500.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: sdp500/sdp510 pressure sensor with I2C bus interface
+
+maintainers:
+  - Petar Stoykov <pd.pstoykov@gmail.com>
+
+description: |
+  Pressure sensor from Sensirion with I2C bus interface.
+  There is no software difference between sdp500 and sdp510.
+
+properties:
+  compatible:
+    const: sensirion,sdp500
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c3 {
+      #address-cells = <1>;
+      #size-cells = <0>;
+      sdp500@40 {
+        compatible = "sensirion,sdp500";
+        reg = <0x40>;
+      };
+    };
-- 
2.30.2

