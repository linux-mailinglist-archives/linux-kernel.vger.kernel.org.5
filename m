Return-Path: <linux-kernel+bounces-111993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A3ED8873DF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 20:25:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 100D91F236C3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 19:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD9AF79B97;
	Fri, 22 Mar 2024 19:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aaIAB7MV"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CECF79DDF;
	Fri, 22 Mar 2024 19:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711135494; cv=none; b=iDmqCYkkCZh/0lAzFuvW7sbv8J+U58FcbU7WClz8JWbYO9QY9K7IO0dpy90nNoY9JgmLD2zopX6wlfJC9b4PxvqCsZgPzsA4sAvIwZl9wbaEEN03xCX4pdxE6rn7R3W3kf+WuJABfreqPlSlQ6f/G7IVChWBDeICrWDshdnQK2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711135494; c=relaxed/simple;
	bh=wUpWMU2bOBD6Qwu6TCUYfBngziKtHdkpYGHrXVf6ZaI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nPCuvCtF7v41/tE76sI654HH3es5m5hltV4Fc9hBhZUu6/QoiqVSWKf6nMExJmeYJlIZxmjvq7xOeBcEJIBgTk5iYasu5yQR1xXBag7BomyrM5wC+mH1yr0+5xmWzQcsFKNjLiLOrIMN0juPeQSHdglFWaTlgEYwrgVS1PheoXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aaIAB7MV; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-56be0860060so1380061a12.1;
        Fri, 22 Mar 2024 12:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711135490; x=1711740290; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z0qn6EG3GrsHqpOB936k/w8hIJUCfUQFAV2vkGQLEp0=;
        b=aaIAB7MV7uonDpadAFlgO7qthEP713+zuMOSVumceKHbP815/54jxf2FUNXejHXTuS
         IfOkzaCW+YkKWubnboQmAlKeOgE+G1suj7CQU8RHwdOowKd8acHi9j7TebHMPaOjDK//
         qpTcS7WTKJVnbwp/7A1Xhi5t4buycQdZPEKsbEli1oP+YFg84zXLLUL6SLpy2+hXQNbB
         JbGh4Er/9E2Um/sDm2lUsNHm2Nni9Mks7LarXq5M54zxSjS9gTnqb+1OIs9mSuDapuyk
         iQyom8LC+vEq9paeT5k/FH2FsDZOEyvGBxVS+YRGpty5tdCrWMw33QHSi3Xwbq6Fl6yv
         ewxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711135490; x=1711740290;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z0qn6EG3GrsHqpOB936k/w8hIJUCfUQFAV2vkGQLEp0=;
        b=fTwOpTNDGZiBZeMH5il6NYPVLFhCXKNoeb6ifbUl5r6pLG1imT+ybHuh7c1HtuoFke
         GKDxOMRVdhTxexsPeoLIEgO/ASED+3GNwRZ/KMWt8kAf5duPAlAPDwWY29tJSBOeWxTD
         n6iv1n9EpT2bx6DN5l0NxKiOiDCk9GuNyYGinn49gD5PZsF8E6I0mouEC1JsCzdU/tk2
         65no0xdJrCF5vDvwHdFWbYrxJkf3Q+NHlF53uwll3ZMHa3jckm1jxe4vGHlbqdYRPQvF
         6L84lWYNAF3ubZAckzoo2s8FTEaPBtL9GfVL1cT/kekvj3FXAyZLv+JjjOcDZtqkhjGb
         qNog==
X-Forwarded-Encrypted: i=1; AJvYcCXb5FXwu0euNU598LEedHIGp2hGIOiWThNvUDy0VU3xAdrzKOR+MpUsRHcOzwoNXwO/BvlipkEYCto+h1boc8EYzGjzH1pNvoLr6WxY0DHOrIJicKSOHj0274sbjH/ZRxcLl+0mmsDvow==
X-Gm-Message-State: AOJu0YynqhlRdeayterNqsC9LbkF7XCsA+Pyc2DKItMPq6IXyEhdm/Ym
	xYI3U8N5B2neu2yqpsg6tkhiK+Ck9nHnKUsp54n0nx2+Eb41nhsy
X-Google-Smtp-Source: AGHT+IEjIVI8QESvEO3Htw539vsXNX9NF9f9TsDBWTJfZ9q1LVdbqw2eP58R/0i0gyBR9SJ655scjw==
X-Received: by 2002:a17:906:4ece:b0:a47:345f:de7b with SMTP id i14-20020a1709064ece00b00a47345fde7bmr451135ejv.59.1711135490502;
        Fri, 22 Mar 2024 12:24:50 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-b7fa-7d92-6b28-0504.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:b7fa:7d92:6b28:504])
        by smtp.gmail.com with ESMTPSA id ku12-20020a170907788c00b00a46b87c32besm138572ejc.39.2024.03.22.12.24.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 12:24:50 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Fri, 22 Mar 2024 20:24:38 +0100
Subject: [PATCH v3 4/5] dt-bindings: hwmon: stts751: convert to dtschema
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240322-hwmon_dtschema-v3-4-6697de2a8228@gmail.com>
References: <20240322-hwmon_dtschema-v3-0-6697de2a8228@gmail.com>
In-Reply-To: <20240322-hwmon_dtschema-v3-0-6697de2a8228@gmail.com>
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
 Javier Carrasco <javier.carrasco.cruz@gmail.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711135482; l=2209;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=wUpWMU2bOBD6Qwu6TCUYfBngziKtHdkpYGHrXVf6ZaI=;
 b=NDqKnaT/P4mE/GWz2eFqSnF/44C8crtro+gdf4XptGUjavRzlNzPjgh5R2GTrCig2NzJwwhYo
 3im3lgjC6v7DXBDTYrIV58QXRPfgrhNMZzY21LtvQ9erQSMTYj7P1RE
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

Convert existing binding to support validation.

This is a straightforward conversion with no new properties.

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 .../devicetree/bindings/hwmon/st,stts751.yaml      | 41 ++++++++++++++++++++++
 .../devicetree/bindings/hwmon/stts751.txt          | 15 --------
 2 files changed, 41 insertions(+), 15 deletions(-)

diff --git a/Documentation/devicetree/bindings/hwmon/st,stts751.yaml b/Documentation/devicetree/bindings/hwmon/st,stts751.yaml
new file mode 100644
index 000000000000..9c825adbed58
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/st,stts751.yaml
@@ -0,0 +1,41 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/hwmon/st,stts751.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: STTS751 Thermometer
+
+maintainers:
+  - Javier Carrasco <javier.carrasco.cruz@gmail.com>
+
+properties:
+  compatible:
+    const: st,stts751
+
+  reg:
+    maxItems: 1
+
+  smbus-timeout-disable:
+    description:
+      When set, the smbus timeout function will be disabled.
+    $ref: /schemas/types.yaml#/definitions/flag
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        thermometer@48 {
+            compatible = "st,stts751";
+            reg = <0x48>;
+            smbus-timeout-disable;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/hwmon/stts751.txt b/Documentation/devicetree/bindings/hwmon/stts751.txt
deleted file mode 100644
index 3ee1dc30e72f..000000000000
--- a/Documentation/devicetree/bindings/hwmon/stts751.txt
+++ /dev/null
@@ -1,15 +0,0 @@
-* STTS751 thermometer.
-
-Required node properties:
-- compatible: "stts751"
-- reg: I2C bus address of the device
-
-Optional properties:
-- smbus-timeout-disable: when set, the smbus timeout function will be disabled
-
-Example stts751 node:
-
-temp-sensor {
-	compatible = "stts751";
-	reg = <0x48>;
-}

-- 
2.40.1


