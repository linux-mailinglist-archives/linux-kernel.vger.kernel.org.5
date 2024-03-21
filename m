Return-Path: <linux-kernel+bounces-110567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21EAF8860B2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 19:44:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A26611F22DE3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 18:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9785313443D;
	Thu, 21 Mar 2024 18:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F1HFsahg"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00339133991;
	Thu, 21 Mar 2024 18:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711046640; cv=none; b=FUTLA2zvQrK48qyXB+fwCFHd22FIPVqPHa8wQSJIVhMj8LEeRAjD0rJp9rKQwQ1YUDWORh8rSY51u4+CF+NYYGuPo+O/VE3vSjSk372C9d8gws0AtiUwaPju4EVH65bmW7h8KqyOCZSQfAkv16Vf2waPG/1b0hLZVb7TIVuUpO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711046640; c=relaxed/simple;
	bh=B4z+N7ahUY9ApzqDTqzWOq9rCMknJMon3IQBcjSmS+0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U799YZonlocLK4/63J5KfCJBpOWSrNAIMEWeUA+nJbiRYfUkXU7WoXMV2IfUdARdHBRrUkFBOmqVW6z6Inppj+oNy92mCcTK+Qis703YodA85GDrb8JdQaDQyvBn1iP4p74++ZYSBUdT/4F84Ic6cS20O4oKCDZ2xcX3hsUXvQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F1HFsahg; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a471f77bf8eso58138966b.2;
        Thu, 21 Mar 2024 11:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711046637; x=1711651437; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZxQdV0gSwFea/wvwZN65K3fXrbPQE6rK+EuyPQNgzgU=;
        b=F1HFsahgpMrkDJ+e/sXO30+2fuaRodAkJLfK7rpmM5jD62odGzDsoAW9hriEtWppv/
         bsACXLw+DS86xTw4en4JKn3PYpIsZXMrr0kIwhHGET45/vIekLuaHIfcNIUv0H+i7Dnf
         eB/qUK7YkL6QcGTMORQwYiHSIU0Op43AiHDrmzgQYrtHmTYKeJNvuOSOgM+6V8DY62Em
         kbUwhUM/ttEpbQfsAVfK2RJC/vvFFcaUanwN3ysLZDWwK8YdwXpoK4ED/VY0RRaXXnh4
         RSZI1z6xIiO7Phyg2j/Nd0z1WnpYd7DndM9fn9dpGwPHDPAxaGWHfJ6wpSeH0S0WFzsN
         m0GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711046637; x=1711651437;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZxQdV0gSwFea/wvwZN65K3fXrbPQE6rK+EuyPQNgzgU=;
        b=H7KIjuCOYQMKuDK6UE4kUaQSJTh0BfDYngYq/Icj9N8AGfloKMvoTM1ljbDrqDHYEk
         jkzYaapQ84j/3TIPUXDJMeoG/443zbQTJdQFzGGzC+kt+X5fvnkSIaYVt4ZP/idCy9zk
         4rI0Or0V+hr2m5tUOVES8c5k1Kc1Y7wETCScLITqZ7dBeqmINWy+FmBcoc9cC/M3B4gf
         iCTgjHlXUVJaoeo11RiYKfXz6+UtMA0/QPmWynULE8iDO7fwkikYCyorHB0apvfE9Qkm
         8RBQUl0eJo/79gXt/LX5/oVvoKT5/ZwCvR1hucYSMqpuVN6a4xPj1WAFowvoFvnXGuox
         8NaA==
X-Forwarded-Encrypted: i=1; AJvYcCVmXvKfOzMJvmueezvbyvqD7DMmgQMzf7kzvfvALRLLY5rW5AyEjQK2kFlLe0aEHHcRk5iEVe/Z4ivXJycIRNaGT2nmX7OomhyhFQNmvGECMpbqCX2t4bLQxjQxFLzo3EiPUmLqJEwWaQ==
X-Gm-Message-State: AOJu0YzbmHyPUmZ9DbjVllPHJmUnJiSJW8WnkOupH40SzKOG6GSfZqzR
	9PtWCYbRnTyra08idSR0wvqyVPX0fvCFWFlVKHhKmQMEDEL7scRX
X-Google-Smtp-Source: AGHT+IEG3AMGQ1osr9ItXCZUq1B19nD5/fEmokg4CRjx7D3N3zMzsZXK4cQeC/aBxwlB5SfDdpP8lg==
X-Received: by 2002:a17:906:fb06:b0:a46:b4c7:341c with SMTP id lz6-20020a170906fb0600b00a46b4c7341cmr203638ejb.58.1711046637340;
        Thu, 21 Mar 2024 11:43:57 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-7db2-5855-2c59-b89b.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:7db2:5855:2c59:b89b])
        by smtp.gmail.com with ESMTPSA id t6-20020a17090616c600b00a4576dd5a8csm188627ejd.201.2024.03.21.11.43.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 11:43:57 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Thu, 21 Mar 2024 19:43:43 +0100
Subject: [PATCH 2/5] dt-bindings: hwmon: ibmpowernv: convert to dtschema
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240321-hwmon_dtschema-v1-2-96c3810c3930@gmail.com>
References: <20240321-hwmon_dtschema-v1-0-96c3810c3930@gmail.com>
In-Reply-To: <20240321-hwmon_dtschema-v1-0-96c3810c3930@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711046632; l=2489;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=B4z+N7ahUY9ApzqDTqzWOq9rCMknJMon3IQBcjSmS+0=;
 b=oqyia0IGym0y9rYVCkRgAlrQNxtFb7uL+qIR3kHFpYZ4LBCMWtK9h2dIytpqyKwpEpo0Nu34S
 7L5GmIk/5n3DJ6sb2wPxsv1/D2ozM6IoFmN6E47+RW9/n2CiOoHptmi
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
index 000000000000..27c949b94c7b
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
+        compatible = "st,stts751";
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


