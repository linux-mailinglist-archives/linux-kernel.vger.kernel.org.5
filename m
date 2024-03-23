Return-Path: <linux-kernel+bounces-112507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9DC0887AAB
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 23:47:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14BFE1C20B60
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 22:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9DA3523C;
	Sat, 23 Mar 2024 22:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ajnILBfH"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC615B69E;
	Sat, 23 Mar 2024 22:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711233995; cv=none; b=bgDFKf7v2p2SU4mQvcsB/B87urzlbfV7hc6PqKT9zsIhOGRwDUQIxwWLZFRQUpZiKlSGt0oX8fk3Xe6vtEv+fNiIxxDbDLtFpxU/abrPyH9gL6QQNOQbjILhZFRw5aatJ+tG/jGQb3FY7bbNT4Uxcb+ocqP4xM7KIyG9pcabNCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711233995; c=relaxed/simple;
	bh=Bd6au8ufU5mdThI9uvAPKXC/6x6DrvohxJj2kkL5HjQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TdG0kRDG/02CjgCvaIinptf8SWRBad5KG/fvPaXTpZdXflrwU3ewyoNbiDHc4Q8DomZdUTK+tggmN/Z4SH0ntNWcRJAlVhFp/m91lyhBzc9gvryqY9uN/GiLwRm1rUzvFO0o80SJuyzMaYtmcWt/PuS97B92125bSrP4pnhx6Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ajnILBfH; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-513edc88d3cso3511508e87.0;
        Sat, 23 Mar 2024 15:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711233991; x=1711838791; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V+2AzQj3mBosP08WhAfzvg7bEORkrGW2OOHVuztE61g=;
        b=ajnILBfHJA/qltRwcWaBdLQj3WGfFpuBKfLRGCVKv7WrKotVTcxwg2eVIuvkw+lt9O
         tAaKEcLjM65tecbA9P+39AuZtFvwZ/SHRZfFc4xD4KO+mQV/5zYqFnF0JVmrR4kNJVDC
         Fwrk/el2B1CmKRFVoQBoVTnDfxdvm48299Rfqc2yPtPDEc3kK2LYFBW5IUwn4aMyyuWv
         VFAATmpWLQ8WFv2YlfICbdcn9p7w+q09YHdYq2bvu75CYvqf8V50LA+7qFR3j5GR5H4z
         ld4a++ldLcH2HKFSRKQmZn87ne7aHXlcSPeJp/nx93lCk1r3jEPx6pg1RnfDjbaLV0uT
         lT6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711233991; x=1711838791;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V+2AzQj3mBosP08WhAfzvg7bEORkrGW2OOHVuztE61g=;
        b=psgcRMQEj/Ly4+RnbnuevxhmMEclsjtl6k0glux8g5oh1iH7imEtLezq7e8iyacYzB
         6AP+Y5QT44bE1qg4naFdKOwEiHwYrm5Shx0GQhUduJ8Cb2BlSpCfFTbQGZ7lcvS8JpBj
         img3prOQIp17iEbH8WHP/Cm8MfUh/3QufiZtv+XYkBcVuUSD74SxP3yUg4O7i0dvg54K
         e79QLijO02b9u2DUK9lbEVyLhHpX7h2vuVbkLvbDN4eukSeXl4xuldwP425v3wFp9NaE
         DAmL45NVWjlzQakgRZp7dSdWzvMuZe7JpU+TbZAQ3aORxYAc0Z84ShqXo71hxM9QwMTw
         LfqQ==
X-Forwarded-Encrypted: i=1; AJvYcCWX9nD1ionKcolHGTzc9hnV/OoKIzhAXSV4Cr0Il8rb7QPIKqIxMgUbcq/z4Mie64xbse5ogGtdCRJRoyd12ot4hMxUsHjDoVH4OHFOoGap1kN+VO6q8WaaW+b8B3Kx/uyyfFrclA61vQ==
X-Gm-Message-State: AOJu0YyA0lYZdLn9u4tnTveqdRg5m7rT9+U5VCIO8Er06BKBwcpknQ+l
	zYsvbybq0cvmX1aYBN+8CXibMjyp9ce6PPpKgld+IwosXlgCQ9mU
X-Google-Smtp-Source: AGHT+IF6JgLiBVRoAo6Ks5BP7fc5Q8N4eFD3gwmmYE1x7etuOZvNvi1HvTi0pmIe7bj5tYn9AbSBzg==
X-Received: by 2002:a19:7505:0:b0:513:a920:aa77 with SMTP id y5-20020a197505000000b00513a920aa77mr1831613lfe.16.1711233991186;
        Sat, 23 Mar 2024 15:46:31 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-195f-8ce5-d7d9-2242.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:195f:8ce5:d7d9:2242])
        by smtp.gmail.com with ESMTPSA id bu22-20020a170906a15600b00a461d2a3374sm1350424ejb.47.2024.03.23.15.46.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Mar 2024 15:46:30 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Sat, 23 Mar 2024 23:46:14 +0100
Subject: [PATCH 2/4] dt-bindings: rtc: alphascale,asm9260: convert to
 dtschema
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240323-rtc-yaml-v1-2-0c5d12b1b89d@gmail.com>
References: <20240323-rtc-yaml-v1-0-0c5d12b1b89d@gmail.com>
In-Reply-To: <20240323-rtc-yaml-v1-0-0c5d12b1b89d@gmail.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Baruch Siach <baruch@tkos.co.il>
Cc: linux-rtc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711233987; l=2601;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=Bd6au8ufU5mdThI9uvAPKXC/6x6DrvohxJj2kkL5HjQ=;
 b=ypThBmwghWRnK+btDCsBIiJklPkOBik0W0VxH6ODXTu7vWT54T+T4wMISHRDNmvVcOfq3xPXX
 dtdr/YESErWB3219jzm0Y0+scooMqBVRLN573IJSh19fos8W6oITMq5
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

Convert existing binding to dtschema to support validation.

This is a direct conversion with no additions.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 .../bindings/rtc/alphascale,asm9260-rtc.txt        | 19 ---------
 .../bindings/rtc/alphascale,asm9260-rtc.yaml       | 49 ++++++++++++++++++++++
 2 files changed, 49 insertions(+), 19 deletions(-)

diff --git a/Documentation/devicetree/bindings/rtc/alphascale,asm9260-rtc.txt b/Documentation/devicetree/bindings/rtc/alphascale,asm9260-rtc.txt
deleted file mode 100644
index 76ebca568db9..000000000000
--- a/Documentation/devicetree/bindings/rtc/alphascale,asm9260-rtc.txt
+++ /dev/null
@@ -1,19 +0,0 @@
-* Alphascale asm9260 SoC Real Time Clock
-
-Required properties:
-- compatible: Should be "alphascale,asm9260-rtc"
-- reg: Physical base address of the controller and length
-       of memory mapped region.
-- interrupts: IRQ line for the RTC.
-- clocks: Reference to the clock entry.
-- clock-names: should contain:
-  * "ahb" for the SoC RTC clock
-
-Example:
-rtc0: rtc@800a0000 {
-	compatible = "alphascale,asm9260-rtc";
-	reg = <0x800a0000 0x100>;
-	clocks = <&acc CLKID_AHB_RTC>;
-	clock-names = "ahb";
-	interrupts = <2>;
-};
diff --git a/Documentation/devicetree/bindings/rtc/alphascale,asm9260-rtc.yaml b/Documentation/devicetree/bindings/rtc/alphascale,asm9260-rtc.yaml
new file mode 100644
index 000000000000..f949634ef56b
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/alphascale,asm9260-rtc.yaml
@@ -0,0 +1,49 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/rtc/alphascale,asm9260-rtc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Alphascale asm9260 SoC Real Time Clock
+
+maintainers:
+  - Javier Carrasco <javier.carrasco.cruz@gmail.com>
+
+properties:
+  compatible:
+    const: alphascale,asm9260-rtc
+
+  reg:
+    description:
+      Base address and length of the register region.
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    const: ahb
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/alphascale,asm9260.h>
+
+    rtc@800a0000 {
+        compatible = "alphascale,asm9260-rtc";
+        reg = <0x800a0000 0x100>;
+        clocks = <&acc CLKID_AHB_RTC>;
+        clock-names = "ahb";
+        interrupts = <2>;
+    };

-- 
2.40.1


