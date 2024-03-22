Return-Path: <linux-kernel+bounces-111019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C3A886700
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 07:46:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B4AB1C23735
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 06:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D58D13AD9;
	Fri, 22 Mar 2024 06:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LtNFgVT+"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C932010A35;
	Fri, 22 Mar 2024 06:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711089943; cv=none; b=BUmH3Q2lHS6GEcbRhwAkYvPosQapeBeE4jUBW3QV+vAIr35DaZU6/X6uZ4ZLZJTaE8Gd3bmUamFNuDELEuk93yIrXyiDzDNa5mPK6zCF2Y9Nq38JChmMXnDj03Se2tGGkBbyLzbwHinxnVEt2sMXBPhLKBdJA6l4TwbKYAZL1EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711089943; c=relaxed/simple;
	bh=l9AcFCPvmbDmRPKHHUdkbOmNj27sBNChGiCLDfCdWFw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dVuvlOyHwBwFBfG7WSwCsqCXTzCGZiDimuKhWrI9+Q9CEw9oTgjLaV0uA52LLUmtygE1LCk0YUr1+j1ZMMQBTJAW3fZmZ2S6CXsr50fXfVKalQLzFpgpaxzxYJc8kvZcwJzhJlw2sI2/PuOVTiKiSextvdHymYIipdi9uOKsCkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LtNFgVT+; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a467d8efe78so204674866b.3;
        Thu, 21 Mar 2024 23:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711089940; x=1711694740; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7MsEAz+9LEdA+n5F4viKLmE3lAJcvkoHSIBKA1QCQsw=;
        b=LtNFgVT+BWR4qpe40q9FCmNzvg8yptp2WbbqCLWV7doITfDT0dXtiPos1iS5+AGIpf
         EWMCZHWzRv9EmfP2P4woUc4Az5Z3pSYMvX1AxL2rm8Z1tcDTwHE8LszKsvlcDbUEQWqj
         ir06vuwK27/XecitWERQNx+2PHRJ2jYzVI+ktmf5T2fH4cbTa3YjuHt9F4LTEPkAN7ap
         XR2gKlKcyhdG1FEYhTbxOq8zppbNoUkIgZeuegWSvi+qeKUEH6q4JM4HNpwKgnmf6NQ6
         +ZJTA0mzc+O6wyub0UXRkRd4XsE6eFqzi6CyMOPEWg6qqNZGA51+5V13t31oyewF8bnM
         BZXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711089940; x=1711694740;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7MsEAz+9LEdA+n5F4viKLmE3lAJcvkoHSIBKA1QCQsw=;
        b=tdJOindDbco+50gm78DVZmG8Hw90LQ4APfT7qQC5/cyuP/VBcSMoeS/FFVkwHhf/8E
         8ss1rqzdgS1HH4D0FHF/MShtAt28QC44ow4JIqkY+DEidHWZxEUQg2a+X06t9T86wvpG
         sCoVaF7hzzLqGYiWtNbW5SkJIYchFms1R0VH3WXfZeF02ApSLOjumJlaQfNqB86QsNFO
         d6cMxpw1C/pZgFjUq3RiF+qcJIuly9cn0pmhD6Hje85QbofFIcKDL0cqDKkt4hSN4YyS
         aRggGId+IwLAVOk/J7I2II22NWJZ4FOip80GfpkSCKxNCC5WJkVLDpzlB/heAGhReLZU
         UeuQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKWFpbZ38nGjvgp/muZ2g/H0eHXmuLN4Kc3mmg3XHYj9S89HcmWhuAnhZYZ/DHFjolsOWcsosKWxtF/RISBwPKYMU+FTJr7cV2BwuTvJ+FIXqThhgwYaVdEaEYyewiaGzipvn8f2ceCQ==
X-Gm-Message-State: AOJu0Yx0akslTJMWlXsZ1RCV+SrP+8UCQPaQWDQenfAdH3p+W8CLV93g
	jDbP0h1XNF3M68RqYOWYA3DfYo7BO9n/ojF8DyV3h4RB4NSXz3Up
X-Google-Smtp-Source: AGHT+IHREvj01EsbKiiQva4CdE4k+soXe/2fsiihxknRWMchMegvdTdXqeew6z0bVCcGYfQRsQaNjw==
X-Received: by 2002:a17:906:abc7:b0:a46:b764:fc81 with SMTP id kq7-20020a170906abc700b00a46b764fc81mr985691ejb.44.1711089940144;
        Thu, 21 Mar 2024 23:45:40 -0700 (PDT)
Received: from [127.0.1.1] ([213.208.157.67])
        by smtp.gmail.com with ESMTPSA id e19-20020a170906375300b00a46bb8a44cdsm679694ejc.198.2024.03.21.23.45.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 23:45:39 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Fri, 22 Mar 2024 07:45:27 +0100
Subject: [PATCH v2 2/5] dt-bindings: hwmon: ibmpowernv: convert to dtschema
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240322-hwmon_dtschema-v2-2-570bee1acecb@gmail.com>
References: <20240322-hwmon_dtschema-v2-0-570bee1acecb@gmail.com>
In-Reply-To: <20240322-hwmon_dtschema-v2-0-570bee1acecb@gmail.com>
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
 "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>
Cc: linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711089934; l=2506;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=l9AcFCPvmbDmRPKHHUdkbOmNj27sBNChGiCLDfCdWFw=;
 b=NPbeHwM3uK9PZwZ1Xwi81PirJ+/H+Jea1v14E2joc98FCbHX9o0tgHW5medAhEkV3anuA2ljt
 XCnfNryadrWC0xgqMRvI7U0URTENNIqDAVxW4SqXceX6KCRmje6FUc2
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

Convert existing binding to support validation.

This is a straightforward conversion with now new properties.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 .../devicetree/bindings/hwmon/ibm,powernv.yaml     | 37 ++++++++++++++++++++++
 .../devicetree/bindings/hwmon/ibmpowernv.txt       | 23 --------------
 2 files changed, 37 insertions(+), 23 deletions(-)

diff --git a/Documentation/devicetree/bindings/hwmon/ibm,powernv.yaml b/Documentation/devicetree/bindings/hwmon/ibm,powernv.yaml
new file mode 100644
index 000000000000..b26d42bce938
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/ibm,powernv.yaml
@@ -0,0 +1,37 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/hwmon/ibm,powernv.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: IBM POWERNV platform sensors
+
+maintainers:
+  - Javier Carrasco <javier.carrasco.cruz@gmail.com>
+
+properties:
+  compatible:
+    enum:
+      - ibm,opal-sensor-cooling-fan
+      - ibm,opal-sensor-amb-temp
+      - ibm,opal-sensor-power-supply
+      - ibm,opal-sensor-power
+
+  sensor-id:
+    description:
+      An opaque id provided by the firmware to the kernel, identifies a
+      given sensor and its attribute data.
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+required:
+  - compatible
+  - sensor-id
+
+additionalProperties: false
+
+examples:
+  - |
+    sensor {
+        compatible = "ibm,opal-sensor-cooling-fan";
+        sensor-id = <0x7052107>;
+    };
diff --git a/Documentation/devicetree/bindings/hwmon/ibmpowernv.txt b/Documentation/devicetree/bindings/hwmon/ibmpowernv.txt
deleted file mode 100644
index f93242be60a1..000000000000
--- a/Documentation/devicetree/bindings/hwmon/ibmpowernv.txt
+++ /dev/null
@@ -1,23 +0,0 @@
-IBM POWERNV platform sensors
-----------------------------
-
-Required node properties:
-- compatible: must be one of
-		"ibm,opal-sensor-cooling-fan"
-		"ibm,opal-sensor-amb-temp"
-		"ibm,opal-sensor-power-supply"
-		"ibm,opal-sensor-power"
-- sensor-id: an opaque id provided by the firmware to the kernel, identifies a
-	     given sensor and its attribute data
-
-Example sensors node:
-
-cooling-fan#8-data {
-	sensor-id = <0x7052107>;
-	compatible = "ibm,opal-sensor-cooling-fan";
-};
-
-amb-temp#1-thrs {
-	sensor-id = <0x5096000>;
-	compatible = "ibm,opal-sensor-amb-temp";
-};

-- 
2.40.1


