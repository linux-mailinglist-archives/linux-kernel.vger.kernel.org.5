Return-Path: <linux-kernel+bounces-112509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 421DC887AB1
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 23:47:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 655FA1C20BAC
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 22:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8922B612EC;
	Sat, 23 Mar 2024 22:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CdRKT+V7"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD995CDEE;
	Sat, 23 Mar 2024 22:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711233997; cv=none; b=AUQr8NVOqtod9i5QQHCEhO/IRpVMWGa7BZ0Y0FVaIjN8PkXaF/Hp4oJRYnOCz4wzCFAdfr+Bka54y/29BTgjbY9jMCkms+n/Owk2kAaxlZighTtejglJYu4iiUp4RbKHnewtyD9jfvjRWYC7CEadxLiYqxWXBJZLF10veIfkZTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711233997; c=relaxed/simple;
	bh=tDhol2FcUGB60ncWKxOskxvWSaZiOqEgh32oNnukAEE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tes8J65s7sVv73RYdO7J4GWqWUDauNuT2EqcAMcRM5eRsrG5tg3W1GyE9HY00m9lL+ErFjuPBQ6kGgm3ZtzXp7Lhd1eNkw5RbqH0u9FfngIUQodRfTxIe+sctc3b41nOF8FZtYqjqYsLa4+1mgut4I8GtGYqQi0RskdMslRsvIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CdRKT+V7; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a474d2d8ce6so32243566b.1;
        Sat, 23 Mar 2024 15:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711233994; x=1711838794; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2/SYA3orZiCrt6UMAkkZctPdfoSwlJljhgv136QIUdg=;
        b=CdRKT+V74H7Sos4xgq88G76RhS50v7Cb6J/KBdzHs7bPypjZ2/W4sye2ArMyT40r/j
         3uboFDlD/+ccsqMAob4qPRwhR2z4AunWQUIR2P2QZPS54VI8FI+UrK+G+AM1rwP+ZgIh
         HWXuUWhMXJ4B2MDNIGmCA2m7JKtoQbG0R0qcsuaJ3Gg+7HQabQfira23CNi7I12y/VAW
         mao+Y8pBD7nleEWF8TQKmzzUPO+qDYIFYoQvTmNxhwCofz1JRHqrRmtj6yxTQcMjXynf
         3XXUGq6rH2WiWbiLefz1KkmvlMABv96OIQ/1vS/7huEaymC3Sb9qXY+/WtflV0DOKkzH
         8BdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711233994; x=1711838794;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2/SYA3orZiCrt6UMAkkZctPdfoSwlJljhgv136QIUdg=;
        b=IdXXXxH9oIhuxSKBPVf9aXxVhR8GjIqVjJrOdmY9KhEQHyi2bHa0qrCfosdxLAurZZ
         2OTiF51ItAuPvEc2MBqzfAV8ACxl3sCot/hueFXtrr4MjVQJvs3NN6LbgtBJhnrftc6a
         SfYdCepkDOJCe38oePTnKEdzlYR29P+vQe9Ablxsa0HhBanwJXTyL2CIs5mAnYyXfss7
         eT9RDLS0ZNgbUG/KHXEE+2+QAyWEy90JoczRPRU6NeeazV9IISQ4ap/RygPNFxMscd54
         eIkygyTP7gnvMgjdWkQziFQxqF5gHbhLHfLNt4HEhaMUkBGsb9XqLiCr4dI7BdqvvKb9
         MMng==
X-Forwarded-Encrypted: i=1; AJvYcCW+w43Xc0yvdAFOZtlblRXOetdtHMWO21+6OAAqu/hGcnOq+OofBJjxoHMaa37jrtM7aFbRWO0gYVLJUtGEIiS3zYdBQm9iPKJw3VUKNczUIvQ4QNYGaQbwSUTzZdfh+CqppeRDk4ETYw==
X-Gm-Message-State: AOJu0YzK7DKxheRhTaYo44M2SCZrFyjfFRlDLN5rdadPjkVdx9hvWbDg
	iA/W8+OSDHetMK6HC11v0Pmkr7wuVvo7bbsN65n93eXjjgdFgenF
X-Google-Smtp-Source: AGHT+IE4E5V6xQKFVc06Bc6OUnNbkY8byp2AQg2ojfzBoU85i+rvR6iVYMsMxQrMQ1tLDA7V7mTsJw==
X-Received: by 2002:a17:906:bb10:b0:a47:876:28b9 with SMTP id jz16-20020a170906bb1000b00a47087628b9mr2121553ejb.42.1711233994149;
        Sat, 23 Mar 2024 15:46:34 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-195f-8ce5-d7d9-2242.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:195f:8ce5:d7d9:2242])
        by smtp.gmail.com with ESMTPSA id bu22-20020a170906a15600b00a461d2a3374sm1350424ejb.47.2024.03.23.15.46.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Mar 2024 15:46:33 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Sat, 23 Mar 2024 23:46:16 +0100
Subject: [PATCH 4/4] dt-bindings: rtc: nxp,lpc1788-rtc: convert to dtschema
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240323-rtc-yaml-v1-4-0c5d12b1b89d@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711233987; l=2951;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=tDhol2FcUGB60ncWKxOskxvWSaZiOqEgh32oNnukAEE=;
 b=oJPdbot4N6v1SuCC2+5aXuS9QMZuvlR1aLfydfYT4s4EH8ge91JzhuwBTePdDJL7ScWZq9HPy
 ql1HOUODczMC/yoeSF18b+lfuWyis3BYGBWC4f4caFcPwXaJiOf8ehp
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

Convert existing binding to dtschema to support validation.

This is a direct conversion with no additions.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 .../devicetree/bindings/rtc/nxp,lpc1788-rtc.txt    | 21 --------
 .../devicetree/bindings/rtc/nxp,lpc1788-rtc.yaml   | 57 ++++++++++++++++++++++
 2 files changed, 57 insertions(+), 21 deletions(-)

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
index 000000000000..af157ff24835
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/nxp,lpc1788-rtc.yaml
@@ -0,0 +1,57 @@
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
+additionalProperties: false
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


