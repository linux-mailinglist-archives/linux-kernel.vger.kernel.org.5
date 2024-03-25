Return-Path: <linux-kernel+bounces-118016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB15288B263
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 22:11:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90BC32E6767
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 21:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83E4A7173A;
	Mon, 25 Mar 2024 21:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wk0pUGBB"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0A45BACF;
	Mon, 25 Mar 2024 21:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711401020; cv=none; b=bGmQDlxAkvagSaWmTz+WtpN3wODMUzz7hQfjKh9Thz0ym70L9ymXFozvlIaKkykZfqJZAxuBJiCFMdiOyXfeLYR5zcD26qp925ytaDxtU5maEUcq4mNBu9Px3MtuJEiOCf9pKAmNMQQxnEhOU+q3/xhsIbrk8Z7uPthqRoDARZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711401020; c=relaxed/simple;
	bh=sCh/0SN7MH569zUkTqSnKfaRS1rQLp/YzuaMSAPp7s8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pszpKTXwMiBmv3oBHrRewIW1jzbD161bMzOLd+rk5PyJZ1K5iEIRzTT0bIuL0+iIM976AJ8yA3o2k19UfTAZ5uibPGxbkMgWZZz025Vx2ElnK/YlpywrhMqL38wuF8T+7U9krOkXrjNtcyurS/n3aieYGkHxGq3ALLxx0lBGyNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wk0pUGBB; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4148c73255eso3506155e9.0;
        Mon, 25 Mar 2024 14:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711401017; x=1712005817; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VGEtC9VmIyJE7VU6ssd2fF9DrY93wiaDpfh+Fxx4nJA=;
        b=Wk0pUGBBiki73om8ZqbRuAkq80hK5jNBSUN6AyaNAutU6KxHoaLj5bUai2HXXJjMld
         2oyei/Bv9hcZL8FaJ1mcrwo78ACgTi0uV5c7cbiiXo514PmeFM/QKKAngKYiBNIX7JAt
         /7ciSFWPcBdUy06MOgsAJ904YBLtHzG3HVEI0fH80jm8/aSh0u861QQMPxWuUrNsHpHw
         DA/KeYdA4+cxNVPm+zHBwxCwU3PvwCCKVX0u4z7pR0s335VmoU9Hj+GX7NP63XwPIsew
         OqQxVdlvZf++Od8W2NyvDDO+TI073Y+ZuFeL15Mpt66EnVNZ+kMTDA3fMXh6lb7I1qCe
         8ZiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711401017; x=1712005817;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VGEtC9VmIyJE7VU6ssd2fF9DrY93wiaDpfh+Fxx4nJA=;
        b=PVwJQEDyTGNbAUkAjJ5Y+HSta5r/ve/SSy3xFlLnf3MTNljKZ6uum3v25NL+x5/jry
         SiHxt7tAvQz3qoR+mGL98FlqJyI42hu9PSkSTvQYvs71YogfAMKxuBwJHz5TqAoJJnbJ
         EcsKq6xVwRu/vAEpXOyjY5tVcMkzdeF1fVNbOr8Pv/4jSOoIaqE57n1ELhCD7vfikdFV
         3opa8O0MX2fNKn8g7d6NCKUceFnYu4HuFM8AEsEXu+2rDFG+OcTcLk5g3gkS+57qPD3S
         gynUnTbYzKCVw9XSQUa6UZw2hjvjW+GAfX6KX9OFw+zJJU6An6kY9ifAkSttTBD1Sshi
         bIaA==
X-Forwarded-Encrypted: i=1; AJvYcCUeWa9IzzVyaLMuo92IAFz/JA9tdHIga8RgaDIGChxngsG+YRJsoOeOzyEMjAVXqHcg88tEbMHN/S3BypoQiBnfi6N5M6gC6DD7/igoQpID4upyxSXIyrzhf434JOv/BwRCRVuJRWXeXA==
X-Gm-Message-State: AOJu0YxPQmQb0Oy4XiqY1qcjurH/jHDluEPIrzmQjFVZxHSoBLUSbZLd
	HR216m089L1Ue3jI8VDjEEnK56VqMTaPoxzALSXmveGPiTd36CsH
X-Google-Smtp-Source: AGHT+IHGroIo6ERn3UACocSiJ9WfFMGughDyjwCI0sGpKzQMBRpQryv/QV+raqs/d3JR/ZOmehBCyw==
X-Received: by 2002:a05:600c:216:b0:413:eb74:fe46 with SMTP id 22-20020a05600c021600b00413eb74fe46mr6071381wmi.34.1711401016909;
        Mon, 25 Mar 2024 14:10:16 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-36af-6d49-8348-9a76.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:36af:6d49:8348:9a76])
        by smtp.gmail.com with ESMTPSA id n39-20020a05600c502700b004148c3685ffsm1520768wmr.3.2024.03.25.14.10.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 14:10:16 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Mon, 25 Mar 2024 22:10:11 +0100
Subject: [PATCH v2 4/4] dt-bindings: rtc: nxp,lpc1788-rtc: convert to
 dtschema
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240325-rtc-yaml-v2-4-ff9f68f43dbc@gmail.com>
References: <20240325-rtc-yaml-v2-0-ff9f68f43dbc@gmail.com>
In-Reply-To: <20240325-rtc-yaml-v2-0-ff9f68f43dbc@gmail.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Baruch Siach <baruch@tkos.co.il>
Cc: linux-rtc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711401010; l=2986;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=sCh/0SN7MH569zUkTqSnKfaRS1rQLp/YzuaMSAPp7s8=;
 b=6R9l6ygvPscEyjE4CGScDoU+15JmPTtf8S09nBgY79mYNNOW8MuR1i7FbWVW6UogNFnlzdrHB
 u3FW9fWKirvCjn3A7AywBDl3Iw0u11JeqYAspyEXKUMCgx05zKSpzc0
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

Convert existing binding to dtschema to support validation.

This is a direct conversion with no additions.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 .../devicetree/bindings/rtc/nxp,lpc1788-rtc.txt    | 21 --------
 .../devicetree/bindings/rtc/nxp,lpc1788-rtc.yaml   | 60 ++++++++++++++++++++++
 2 files changed, 60 insertions(+), 21 deletions(-)

diff --git a/Documentation/devicetree/bindings/rtc/nxp,lpc1788-rtc.txt b/Documentation/devicetree/bindings/rtc/nxp,lpc1788-rtc.txt
deleted file mode 100644
index 3c97bd180592..000000000000
--- a/Documentation/devicetree/bindings/rtc/nxp,lpc1788-rtc.txt
+++ /dev/null
@@ -1,21 +0,0 @@
-NXP LPC1788 real-time clock
-
-The LPC1788 RTC provides calendar and clock functionality
-together with periodic tick and alarm interrupt support.
-
-Required properties:
-- compatible	: must contain "nxp,lpc1788-rtc"
-- reg		: Specifies base physical address and size of the registers.
-- interrupts	: A single interrupt specifier.
-- clocks	: Must contain clock specifiers for rtc and register clock
-- clock-names	: Must contain "rtc" and "reg"
-  See ../clocks/clock-bindings.txt for details.
-
-Example:
-rtc: rtc@40046000 {
-	compatible = "nxp,lpc1788-rtc";
-	reg = <0x40046000 0x1000>;
-	interrupts = <47>;
-	clocks = <&creg_clk 0>, <&ccu1 CLK_CPU_BUS>;
-	clock-names = "rtc", "reg";
-};
diff --git a/Documentation/devicetree/bindings/rtc/nxp,lpc1788-rtc.yaml b/Documentation/devicetree/bindings/rtc/nxp,lpc1788-rtc.yaml
new file mode 100644
index 000000000000..db900617f1e3
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/nxp,lpc1788-rtc.yaml
@@ -0,0 +1,60 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/rtc/nxp,lpc1788-rtc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP LPC1788 real-time clock
+
+description:
+  The LPC1788 RTC provides calendar and clock functionality
+  together with periodic tick and alarm interrupt support.
+
+maintainers:
+  - Javier Carrasco <javier.carrasco.cruz@gmail.com>
+
+allOf:
+  - $ref: rtc.yaml#
+
+properties:
+  compatible:
+    const: nxp,lpc1788-rtc
+
+  reg:
+    description:
+      Base address and length of the register region.
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: RTC clock
+      - description: Register clock
+
+  clock-names:
+    items:
+      - const: rtc
+      - const: reg
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
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/lpc18xx-ccu.h>
+
+    rtc@40046000 {
+        compatible = "nxp,lpc1788-rtc";
+        reg = <0x40046000 0x1000>;
+        clocks = <&creg_clk 0>, <&ccu1 CLK_CPU_BUS>;
+        clock-names = "rtc", "reg";
+        interrupts = <47>;
+    };

-- 
2.40.1


