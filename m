Return-Path: <linux-kernel+bounces-60964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F79A850BB3
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 22:40:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29F101F22115
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 21:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F11E95FEF1;
	Sun, 11 Feb 2024 21:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YU/akLXo"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689675FB8D;
	Sun, 11 Feb 2024 21:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707687584; cv=none; b=tByR0tFSLDPWjKde3jN5+hH0UevtVch2Ye06nzxpmUTLFFqahT7HDMaJ8OsEGqd8Iq+PaimjxlAe/WbxolgY165yuW0movSR+BCcdZRHMH8oDzOTO/MemGwfq3pGnL2a3y/6m2ZPKYqx16y1sVrXd7xFhzH+arHGJm5lJx042kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707687584; c=relaxed/simple;
	bh=LgpLA72Yy2DgXq7fM3U+hFO1U9oOC9qFq5Ar4+afhHM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hWVwGanfiI4RgqZp3JH/mAnLIOReJBPnJv051CYFYlN0ZmShJ/Jt6SeksdY5Xw5elqnWPm7W/DmT+NDOC3Jaj7sym6O+iYZFyxc5ggDFqH8/63ymAL07i+cXfSXlirEkQgaYreiZ9Jz8zJxvOpEYQd82N1qnTUIxC5oRFWxFy+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YU/akLXo; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-55a5e7fa471so3311493a12.1;
        Sun, 11 Feb 2024 13:39:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707687580; x=1708292380; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0EDbWqws9cGFaTSgQ7d/JTeQtcU5zOGhJZiE31yQ40s=;
        b=YU/akLXoQp8ObAuG6Yw+HnS2S7QqnrOvtU9BUql27XTu1e72Xa9NTQQy/QkqAg6STB
         fYXaJ9W8GR5X8jLtJnkoy0LnGzMYQA1dNfLcFFvKYxONNoJ9YWJ/5PHXgEjkt2B5ssm1
         j5e48i+AyDlt6W8XqF6ud6Ir/Nki2MhCNA8t5FUmCnevjjQplmZhCo1MuYISlqmW5D7c
         inYPiHVNtF6VkGQ8GLyxY9gCgHSAibybC+LFPimjXwDOZ++o0aMWBLb9tzz3PCft0jZc
         PeMVmdes3T8vQ7ZMXgYkI5Mycr/4+iiBp2cTuturvQ/ScQ9zIvLj0PaK6C35hxuhHSHZ
         rVEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707687580; x=1708292380;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0EDbWqws9cGFaTSgQ7d/JTeQtcU5zOGhJZiE31yQ40s=;
        b=waedMgh7KtzK4b9jOeqjEWsQF+CZP+eSPPzSbQQIthkaMw8QLuCA0X5nPwvGffFCvD
         4skfgZtiAA2p7vLzDZDvI6cLXnYJbhW4nFlEg5VZSchYP/tv3M95rp39G6k/1dPNp2Sy
         bJn/qTvnET+PDmun7Y7lE/mWqlqyIcip1F+RLUR1eILEJO7N3NOczuHWGp4iAnzVI/Ns
         FhPwLq4OoM6ga1e2heMPAaLdZ3tQvPyEXwiFkersFflUI78OmnBO75He95iiraGpjPXY
         GoF0HwdMEMl9TOHxuptmFKeyaEOFUoa0TyGM3tvKdSuSpr7LggfWiTSHv37LVAdfs2ZJ
         V7MQ==
X-Forwarded-Encrypted: i=1; AJvYcCWgsI+BO7eDKyo3pQ3ItS9XarGHrJQ33F1uWIy0uWyQWqPBNy5uJCPVJNxQ4pDEMSSlYMLkA2vd6hxpuf5Vj9aSdK+osIYRMCwovrNZwDMaJn3eo21wytIrCyD+qAdBdjskEWZn6uj6e5W7YyNaczF5mi7jplJJMDpbHdhyUnighq+WiA==
X-Gm-Message-State: AOJu0Yzv9J+ahZ10js1u2CXe085gNqLXrF589fHmOBzkiiWIk1RjiuiW
	i2X6+GFHO2lvFY7XwrYOmMRtn/DccPc5YEBkok7V51Atwl8A9FRr
X-Google-Smtp-Source: AGHT+IGoT67/Zk5VRMY5JxMDwjrPQIy//74w/ZJz4vIhvTmeGkhbIjvy7LLSQ1GOOo0IdshD/4Hr8A==
X-Received: by 2002:a17:906:3e50:b0:a3b:eaa3:ecc4 with SMTP id t16-20020a1709063e5000b00a3beaa3ecc4mr3428920eji.60.1707687580350;
        Sun, 11 Feb 2024 13:39:40 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVnOiPrRQU6g/KcAGXBm4PkuAYH/5MKHSz+jA/zC0Z9hHXwj+OZBs8CukESzauvKFAXsSX6P+Cd6H+vWhMIL1j9W4uIirC0JLn6+paa25HOTDHOqsnEJjHUdByz3gV/cdIupMpq+DxudSKt5/dtT2bpiQkJ67PjCTZa7zZLVgshE7W59gF5fH+YzngaWD9xYmKxXXrXIvtZ/kPv68x+uI4ml/Rk4Ms3gCJndjdglUelwC7pr8Fx9DfCgwOwnhouqRpoNypUt+SaCLAhWCZW1Fce7uG3arn1tG2NrafmqJUAzn4HHpa4Rqa34PwerXhlmRyAWWwWGCSBHrTud/zTWEQyP2NkzhogfFPoUZs/xSt6YTVsyU4FyVArrjZF6lR5XsLrYaxHIL5NWSA9vfuMzq0Ic7YsXmgSqigPIk55NVvPuO/YIiRNw3bmX06GR7FCc0kJ/7pa87DxEXhHGP5UwO6abD9LMHkQ1LL5zV9nMUMDe2ASkM0CkH4sRTo0IjeOOer3oGoUvUcj7aK92RfPYx6Fjn2W+SVRbxlG9EnMYXJNsAFGWQ==
Received: from localhost.lan (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.gmail.com with ESMTPSA id ps6-20020a170906bf4600b00a3c66ac512asm1206344ejb.214.2024.02.11.13.39.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Feb 2024 13:39:40 -0800 (PST)
From: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To: Russell King <linux@armlinux.org.uk>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	devicetree@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH V3 3/3] dt-bindings: arm: mediatek: convert SSUSBSYS to the json-schema clock
Date: Sun, 11 Feb 2024 22:39:25 +0100
Message-Id: <20240211213925.18348-4-zajec5@gmail.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240211213925.18348-1-zajec5@gmail.com>
References: <20240211213925.18348-1-zajec5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Rafał Miłecki <rafal@milecki.pl>

This helps validating DTS files. Introduced changes:
1. Documented "reg" property
2. Dropped "syscon" as it was incorrectly used
3. Adjusted nodename, "compatible" and "reg" in example

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../arm/mediatek/mediatek,ssusbsys.txt        | 25 -----------
 .../clock/mediatek,mt7622-ssusbsys.yaml       | 45 +++++++++++++++++++
 2 files changed, 45 insertions(+), 25 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,ssusbsys.txt
 create mode 100644 Documentation/devicetree/bindings/clock/mediatek,mt7622-ssusbsys.yaml

diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,ssusbsys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,ssusbsys.txt
deleted file mode 100644
index 7cb02c930613..000000000000
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,ssusbsys.txt
+++ /dev/null
@@ -1,25 +0,0 @@
-MediaTek SSUSBSYS controller
-============================
-
-The MediaTek SSUSBSYS controller provides various clocks to the system.
-
-Required Properties:
-
-- compatible: Should be:
-	- "mediatek,mt7622-ssusbsys", "syscon"
-	- "mediatek,mt7629-ssusbsys", "syscon"
-- #clock-cells: Must be 1
-- #reset-cells: Must be 1
-
-The SSUSBSYS controller uses the common clk binding from
-Documentation/devicetree/bindings/clock/clock-bindings.txt
-The available clocks are defined in dt-bindings/clock/mt*-clk.h.
-
-Example:
-
-ssusbsys: ssusbsys@1a000000 {
-	compatible = "mediatek,mt7622-ssusbsys", "syscon";
-	reg = <0 0x1a000000 0 0x1000>;
-	#clock-cells = <1>;
-	#reset-cells = <1>;
-};
diff --git a/Documentation/devicetree/bindings/clock/mediatek,mt7622-ssusbsys.yaml b/Documentation/devicetree/bindings/clock/mediatek,mt7622-ssusbsys.yaml
new file mode 100644
index 000000000000..da93eccdcfc1
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/mediatek,mt7622-ssusbsys.yaml
@@ -0,0 +1,45 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/mediatek,mt7622-ssusbsys.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek SSUSBSYS clock and reset controller
+
+description:
+  The MediaTek SSUSBSYS controller provides various clocks to the system.
+
+maintainers:
+  - Matthias Brugger <matthias.bgg@gmail.com>
+
+properties:
+  compatible:
+    enum:
+      - mediatek,mt7622-ssusbsys
+      - mediatek,mt7629-ssusbsys
+
+  reg:
+    maxItems: 1
+
+  "#clock-cells":
+    const: 1
+    description: The available clocks are defined in dt-bindings/clock/mt*-clk.h
+
+  "#reset-cells":
+    const: 1
+
+required:
+  - reg
+  - "#clock-cells"
+  - "#reset-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    clock-controller@1a000000 {
+        compatible = "mediatek,mt7622-ssusbsys";
+        reg = <0x1a000000 0x1000>;
+        #clock-cells = <1>;
+        #reset-cells = <1>;
+    };
-- 
2.35.3


