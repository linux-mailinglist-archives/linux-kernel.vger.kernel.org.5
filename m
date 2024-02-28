Return-Path: <linux-kernel+bounces-85005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C147B86AF0A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 13:24:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78D37281642
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 12:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CD3E6CDA2;
	Wed, 28 Feb 2024 12:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tweaklogic.com header.i=@tweaklogic.com header.b="QkEaFVC8"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0593BBFD
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 12:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709123069; cv=none; b=ATEULb4Yz7j0ttOvPef02xgi9RCGpt/ebY4wiop5ol6bS0nPfm7AlCR3b89zADS+oVFz+dFG+YIn8d689XJS4uzFAxNrWiaFH/vcPi6i+rw+2fKvxIrlKzS2q7cy629/DRrldYg2Iv+zPjK5H52q3kbtgtcNfAt2xSVVxh3xcHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709123069; c=relaxed/simple;
	bh=HOUoZIa3MkZ+KSHWn/PWd1QcEHzU3kYqBJSIQy5PVHk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NiD/voCKS3nSb1i8MqcvS4PkTg/zTfXpIEhA9K86QaAQW05f9UU5WWWfZnsqTCitRRSJ+Zr3VRw5fpmXzagFapFPWxv/fIeSx0YSWPtXd8nmagaZuj0W21pSwayB06q97ERf3B+CMC4Gd71ambXbd0v7hjCI0+8yX1sy8lxit7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tweaklogic.com; spf=pass smtp.mailfrom=tweaklogic.com; dkim=pass (2048-bit key) header.d=tweaklogic.com header.i=@tweaklogic.com header.b=QkEaFVC8; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tweaklogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tweaklogic.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6e55101cc56so1162696b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 04:24:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tweaklogic.com; s=google; t=1709123067; x=1709727867; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cUpx31yvSWfMaXn3gef1SDwAb7zb/rd060Do4+3pH9c=;
        b=QkEaFVC8wAhVjWJ04LL+2Sz2yHlt4Kxn7dAgZ4EZSqznBJWRiCgd5+3KUmFyGd/n+w
         GOZWauNssUQLQn2kSKCtw7D56O1iSxbPRzcenVadCS68DIdGTorm+GAaiU2FxG94c00x
         obu+1PA58WPolh5jOfe8d0pRozJcshuQt1jomFp9S1K5r9wF5zHr2b+1R7Ew5JnKndFp
         oroT3PnwDgvMIGNu87PxIlJC2B0TBj1QKId45LUJIXo9Rf+3wVgSYQdEVOVHD1rYB3lg
         9cYmFNT0641c/M6WM7UF1XAn62xUtQ2Ap2x7N2TvBsc71ExOGHPylztm3Mq0il4tUZCY
         Zb1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709123067; x=1709727867;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cUpx31yvSWfMaXn3gef1SDwAb7zb/rd060Do4+3pH9c=;
        b=j5zZadAZgvvJzfCznNoXawilq1JdZgxTp89CEkOYhJx0hAeziccG2SYbewwH40+awJ
         lZPxacV/B/x1nXcXR+jZxrwUXAW3IwHwB8fDHqPB+e2lM79NnJd987WAfjLnZrD2YtiB
         J2hkqWjtD8gsYebg3HmgNxvAqTHKh6uHAw+rz4PADj0qsX5sXrjgKLiM7uhiZV5Lkf1N
         mrt1tqNzcaQdwBpGVT+/hHFk4gVnAN3jHIijByOs6WNDnIOn+XC9MXJEu6makK3M1poP
         uh27M3hiM8WBAz64/iIfpYkrP18fXODRaJtwAGWY+gCj6mrpUVKhxzCuqsS7DVtGQioZ
         N3Pg==
X-Forwarded-Encrypted: i=1; AJvYcCXwQezHfpPZ/ya0Vdu2qN3k4MkILCBqLZyqli/kHFYP3gS+n7v//ETw3arHSDml1LyA5cEwB4UtGeC26WLx8iE5jFECm5kjdyzL+0VW
X-Gm-Message-State: AOJu0YwlNLep98Y3yC8s56Do7G7xmfCJVBHCbpB/d5dmFm9NltBHsHwN
	z+YjbYmHVFRzA8+WxwUn+b1u+IYOGyRH9A6lSrT9FYq86gGJ5ZEiLcntvWYyhNQSVDGBC1IYsWc
	I
X-Google-Smtp-Source: AGHT+IEYYJ2V8VKY/vW/qjuf7LtVF78EApZt7fG3uojTxTrno1hrxqJLlBXc4Qr7/bhbLX5er6aj7g==
X-Received: by 2002:a05:6a00:1889:b0:6e5:4451:eb90 with SMTP id x9-20020a056a00188900b006e54451eb90mr7509191pfh.6.1709123066844;
        Wed, 28 Feb 2024 04:24:26 -0800 (PST)
Received: from localhost.localdomain ([180.150.112.31])
        by smtp.gmail.com with ESMTPSA id m3-20020a62f203000000b006dde0724247sm7857587pfh.149.2024.02.28.04.24.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 04:24:26 -0800 (PST)
From: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Marek Vasut <marex@denx.de>,
	Anshul Dalal <anshulusr@gmail.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>,
	Matt Ranostay <matt@ranostay.sg>,
	Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v8 1/5] dt-bindings: iio: light: Merge APDS9300 and APDS9960 schemas
Date: Wed, 28 Feb 2024 22:54:04 +1030
Message-Id: <20240228122408.18619-2-subhajit.ghosh@tweaklogic.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240228122408.18619-1-subhajit.ghosh@tweaklogic.com>
References: <20240228122408.18619-1-subhajit.ghosh@tweaklogic.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Merge very similar schemas for APDS9300 and APDS9960.

Suggested-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Link: https://lore.kernel.org/all/4e785d2e-d310-4592-a75a-13549938dcef@linaro.org/
Signed-off-by: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
---
v7 -> v8:
 - No change

v6 -> v7:
 - No change

v5 -> v6:
 - Write proper commit messages
   Link: https://lore.kernel.org/all/1d0a80a6-dba5-4db8-a7a8-73d4ffe7a37e@linaro.org/

v2 -> v5:
 - Removed 'required' for Interrupts and 'oneOf' for compatibility strings
   as per below reviews:
   Link: https://lore.kernel.org/lkml/20231028142944.7e210eb6@jic23-huawei/
   Link: https://lore.kernel.org/lkml/22e9e5e9-d26a-46e9-8986-5062bbfd72ec@linaro.org/
---
 .../bindings/iio/light/avago,apds9300.yaml    | 11 +++--
 .../bindings/iio/light/avago,apds9960.yaml    | 44 -------------------
 2 files changed, 7 insertions(+), 48 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/iio/light/avago,apds9960.yaml

diff --git a/Documentation/devicetree/bindings/iio/light/avago,apds9300.yaml b/Documentation/devicetree/bindings/iio/light/avago,apds9300.yaml
index 206af44f2c43..c610780346e8 100644
--- a/Documentation/devicetree/bindings/iio/light/avago,apds9300.yaml
+++ b/Documentation/devicetree/bindings/iio/light/avago,apds9300.yaml
@@ -4,17 +4,20 @@
 $id: http://devicetree.org/schemas/iio/light/avago,apds9300.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Avago APDS9300 ambient light sensor
+title: Avago Gesture/RGB/ALS/Proximity sensors
 
 maintainers:
-  - Jonathan Cameron <jic23@kernel.org>
+  - Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
 
 description: |
-  Datasheet at https://www.avagotech.com/docs/AV02-1077EN
+  Datasheet: https://www.avagotech.com/docs/AV02-1077EN
+  Datasheet: https://www.avagotech.com/docs/AV02-4191EN
 
 properties:
   compatible:
-    const: avago,apds9300
+    enum:
+      - avago,apds9300
+      - avago,apds9960
 
   reg:
     maxItems: 1
diff --git a/Documentation/devicetree/bindings/iio/light/avago,apds9960.yaml b/Documentation/devicetree/bindings/iio/light/avago,apds9960.yaml
deleted file mode 100644
index f06e0fda5629..000000000000
--- a/Documentation/devicetree/bindings/iio/light/avago,apds9960.yaml
+++ /dev/null
@@ -1,44 +0,0 @@
-# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
-%YAML 1.2
----
-$id: http://devicetree.org/schemas/iio/light/avago,apds9960.yaml#
-$schema: http://devicetree.org/meta-schemas/core.yaml#
-
-title: Avago APDS9960 gesture/RGB/ALS/proximity sensor
-
-maintainers:
-  - Matt Ranostay <matt.ranostay@konsulko.com>
-
-description: |
-  Datasheet at https://www.avagotech.com/docs/AV02-4191EN
-
-properties:
-  compatible:
-    const: avago,apds9960
-
-  reg:
-    maxItems: 1
-
-  interrupts:
-    maxItems: 1
-
-additionalProperties: false
-
-required:
-  - compatible
-  - reg
-
-examples:
-  - |
-    i2c {
-        #address-cells = <1>;
-        #size-cells = <0>;
-
-        light-sensor@39 {
-            compatible = "avago,apds9960";
-            reg = <0x39>;
-            interrupt-parent = <&gpio1>;
-            interrupts = <16 1>;
-        };
-    };
-...
-- 
2.34.1


