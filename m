Return-Path: <linux-kernel+bounces-118013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C67ED88B25B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 22:10:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B13B1F65D20
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 21:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 421386DCE8;
	Mon, 25 Mar 2024 21:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iav0x3TI"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED2D60EEB;
	Mon, 25 Mar 2024 21:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711401016; cv=none; b=h41RzreLmiBGC0N3OBg0FhqHhnBJKrXWRyUwzcI8CnkJsLvGqjEwh60F2F8Imq2YZ237vRVLfSoOPDCSxrdbRKkLbiJhUJYkQ1TLSFiM3jcHqJWrX0IITFNiVcnG41a+tezCducVt/2sW0BfUKFuhD29ONezTx7BCwu26MQIT6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711401016; c=relaxed/simple;
	bh=rEBCNP/6NmVLxWp51iovuTYMtLHoXyc5d80U+1whzuE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ojhRdqttWvB8yosOudQjkrDWtMKmycUfJwDlsX43ntdb6nxK8rK8CXQt5hU4yVc+uYZLFanElZhtIBmyB8RI/jvD0xFLc5TpljwDD3DWi6FfZTK+rUPFTxIF27bp+8cx/zkd1I270H+h8yv9chK81Y7L9HwRfF1TfJ4IuZ7PZ6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iav0x3TI; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4148ca200a7so2537585e9.0;
        Mon, 25 Mar 2024 14:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711401013; x=1712005813; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=01KctL/of7sv3NxZB3/YVlhWZ/130viwtg3hXxU0jGk=;
        b=iav0x3TIt0xQNu30jZDbfv6n7nMSUECMeGeTwetY1WToWwGD41NUo/2n8fo3obVuNy
         ca9tPCytatKQ5N3h6RywdRgPBTFWntfMnmRH51iQuzSfpPsIF2R/2oa7nSyPD6IKp3zZ
         zIPkOkkdbYwF/+dEplsXSHOdBuolUEnSYlO+GyfXjDfzCPZd71oiY/GfUzs+Tj/mvVOg
         Vy5W5gkNWo/8Ez84QaNduPfCZw887sIdFcgKIohukz87yHzsgwIuo4z/4wMGsPwwLP8C
         Nns8zhHT3iaCBcdLBYScROkKdltN5bufzx+nJX4mpYRnS8fyz8HIRzwsSA5pG1NL/itm
         5Peg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711401013; x=1712005813;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=01KctL/of7sv3NxZB3/YVlhWZ/130viwtg3hXxU0jGk=;
        b=rpze6tGNMdmgnvmwGFZrocKCwaodzN+b5a0A4+J205lBUa4W0RaYh9C+ItSJLsOniA
         ELLuv1oO1AKDLiav2jfg5o5du8WJCKGnnPz4SIHSEzGpuy7rwuILRcW+4UAI+q27WzsF
         tcJPJVwbSC5ZD/5Jt9EnTkle1unG8X8w/2xr3C+GjfwMVU5VJKLqnOXg2V4bFE879LR0
         /HS8dJ1An6VDQwEeO6CywVrWIVqodYl2flLn+IrXMx/wi3rRSfnereQqka4C3/29csjm
         VUhcH1o+pmIuiD9tWg2EQ3tDVoT7qeFgWknErn0Nhg3jtuXQLMHfaVSVAiAqDFbjeswV
         BksA==
X-Forwarded-Encrypted: i=1; AJvYcCXDRSVaniIZQnZydpg6zUJvq15qI0Qw/F1WIsSFsRX7Kt2+gHq4m9dFM0ZJUZB9smgeEHpHSf54RfjsbPTU14jWFjWgOYl1/oOm34ffKK4CdqHm91xhFuh+SBPvbn3GfFMcqSQwJLT8Jg==
X-Gm-Message-State: AOJu0YwY6qhWvS7ShXimsNSnPiIwNAQAHRzcfhd86fkECueF2rr6x8RA
	hxe/CHNDwVH3M1QS2mM70dyNiKR0ehnW4qg0hm/hBTRbVbCFadu6
X-Google-Smtp-Source: AGHT+IHFeK4t03vFhKIvhm5HUOHakft7kj/pH/9dnbnx+xfFomiLu7vdjYQeqLJ4s+1AA79tsrHhuw==
X-Received: by 2002:a05:600c:3555:b0:414:8e02:e435 with SMTP id i21-20020a05600c355500b004148e02e435mr86052wmq.3.1711401013021;
        Mon, 25 Mar 2024 14:10:13 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-36af-6d49-8348-9a76.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:36af:6d49:8348:9a76])
        by smtp.gmail.com with ESMTPSA id n39-20020a05600c502700b004148c3685ffsm1520768wmr.3.2024.03.25.14.10.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 14:10:12 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Mon, 25 Mar 2024 22:10:08 +0100
Subject: [PATCH v2 1/4] dt-bindings: rtc: armada-380-rtc: convert to
 dtschema
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240325-rtc-yaml-v2-1-ff9f68f43dbc@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711401010; l=2914;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=rEBCNP/6NmVLxWp51iovuTYMtLHoXyc5d80U+1whzuE=;
 b=z46YIanLXwYCjMvPC7lBpXiXgiyAGRtxpCygfcL2gJclcVgq3mDbybEJyp9Oqfp5erlLcu3Yg
 DD8ubRCcHqEDXe/veHhrR37Jqg7LbSffjqyp5hiKSNRsFulKXwnSYE7
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

Convert existing binding to dtschema to support validation.

This is a direct conversion with no additions.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 .../devicetree/bindings/rtc/armada-380-rtc.txt     | 24 ----------
 .../bindings/rtc/marvell,armada-380-rtc.yaml       | 51 ++++++++++++++++++++++
 2 files changed, 51 insertions(+), 24 deletions(-)

diff --git a/Documentation/devicetree/bindings/rtc/armada-380-rtc.txt b/Documentation/devicetree/bindings/rtc/armada-380-rtc.txt
deleted file mode 100644
index c3c9a1226f9a..000000000000
--- a/Documentation/devicetree/bindings/rtc/armada-380-rtc.txt
+++ /dev/null
@@ -1,24 +0,0 @@
-* Real Time Clock of the Armada 38x/7K/8K SoCs
-
-RTC controller for the Armada 38x, 7K and 8K SoCs
-
-Required properties:
-- compatible : Should be one of the following:
-	"marvell,armada-380-rtc" for Armada 38x SoC
-	"marvell,armada-8k-rtc" for Aramda 7K/8K SoCs
-- reg: a list of base address and size pairs, one for each entry in
-  reg-names
-- reg names: should contain:
-  * "rtc" for the RTC registers
-  * "rtc-soc" for the SoC related registers and among them the one
-    related to the interrupt.
-- interrupts: IRQ line for the RTC.
-
-Example:
-
-rtc@a3800 {
-	compatible = "marvell,armada-380-rtc";
-	reg = <0xa3800 0x20>, <0x184a0 0x0c>;
-	reg-names = "rtc", "rtc-soc";
-	interrupts = <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
-};
diff --git a/Documentation/devicetree/bindings/rtc/marvell,armada-380-rtc.yaml b/Documentation/devicetree/bindings/rtc/marvell,armada-380-rtc.yaml
new file mode 100644
index 000000000000..adf3ba0cd09f
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/marvell,armada-380-rtc.yaml
@@ -0,0 +1,51 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/rtc/marvell,armada-380-rtc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: RTC controller for the Armada 38x, 7K and 8K SoCs
+
+maintainers:
+  - Javier Carrasco <javier.carrasco.cruz@gmail.com>
+
+allOf:
+  - $ref: rtc.yaml#
+
+properties:
+  compatible:
+    enum:
+      - marvell,armada-380-rtc
+      - marvell,armada-8k-rtc
+
+  reg:
+    items:
+      - description: RTC base address size
+      - description: Base address and size of SoC related registers
+
+  reg-names:
+    items:
+      - const: rtc
+      - const: rtc-soc
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - interrupts
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    rtc@a3800 {
+        compatible = "marvell,armada-380-rtc";
+        reg = <0xa3800 0x20>, <0x184a0 0x0c>;
+        reg-names = "rtc", "rtc-soc";
+        interrupts = <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
+    };

-- 
2.40.1


