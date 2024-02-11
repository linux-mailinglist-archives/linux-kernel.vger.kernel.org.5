Return-Path: <linux-kernel+bounces-60963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E3E850BB0
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 22:40:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69134B2242A
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 21:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14B765FDA3;
	Sun, 11 Feb 2024 21:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f2ZPsswE"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815A15F577;
	Sun, 11 Feb 2024 21:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707687582; cv=none; b=Rv8FqtXcRAalcUG80ArVThzMb0CeE6pTgppvPLXsInWwrQEdz6mIRSuP3A6gvlEkhSpMQnTMr/JdW5X7fD2ocu/SPrmiudgHURki2kYcZHfkLllmU2iDq4R6Yyy/BzD6RBhjWg/WVgTAjS5U2KObq+K5y9wSBQYJh6Yp/IjMTFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707687582; c=relaxed/simple;
	bh=7aIBd9Ub4VgUkMILxliwT1q+jMq3XfF8c+XqzX9wUrc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KOKK1d+gb12P0HyqqQuMGBTcCrDWGzoz63SGwm3ZCVcUEkFTTff+0j2LuA0PPLUSVtxsPwUYAqvp16d2R+kSSteGfM8DVo0Pqg4vmB5tflHh23/Ui/8bv/Ymik3E9Ecf7HV6hMyhholMxGe9bcvnlkkSIdDu/5s4xL+uHINpMI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f2ZPsswE; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a3c00c98d32so272682466b.3;
        Sun, 11 Feb 2024 13:39:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707687579; x=1708292379; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fm7RlLurDkB9nfwalxlLQ2JW0yHxYihI8gdZfuipTWc=;
        b=f2ZPsswELlHHoOKKDYmJUJXJg6ev/zD2yYFf/Tq4SIklm2k5LVA8SEQ6l5AK1yJIKf
         InYZBqXHVsIEyqi8pWfSr4ppyuyHJHGt+RJycNUP6Ahseuvf6tXjTB1/Lp9I8uqRBaAA
         ng/32i7vkk0+0RvhlhRQg+lN8p5jZO4rcu3YwiKhnjE++cbrp/ip4qrzUitGdDtZF3cz
         Yaa2q4igAiYuG5+94+bMBKLIXE9UlkXVEIDmqXU/yCeD8xva7rBEWD/d31/U+tqGIwzR
         l92itqt49MnP6vlltaH32jjje85ZRY+uKbjn0Ff/dbCYlIZfNGK6w/uKoDQXP2vg4382
         vRtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707687579; x=1708292379;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fm7RlLurDkB9nfwalxlLQ2JW0yHxYihI8gdZfuipTWc=;
        b=ECR+Awcs7FCABYvzChm5RkusyLtzE88vWldXFVh8sa6onicw7wT6ngU3o5jIiP5UG3
         8Q5g2FNilhZrd8nMNNG7JRu5bJAQsyMISDRH0fU4No/nP9Sg0KD/NB3IFfyDpfE84Ike
         oijGkUURZy5oPG2Ln25oHbQbasjPYUkj8INkMpgRCd7wYAY+kRjdVgr0Ef0bS8gVupDu
         wHDeT691cABIOIgTV9PO9H4+0g32bDQqwiPZdZVLyvKdMG3YtrHX+vePv/MBElZX2wv1
         N5s+fw5nZytdSmz7sy2hE07xWaaRHrSCQXnZtw+5cK/JtaPf0xiRr/xk72CDhMLV0iFN
         yENg==
X-Gm-Message-State: AOJu0YwG2CyttGh1nPmr0edyohAmNPV3zWxFDDtb1AeVnbXIrpftPMkl
	hpmSRDfUAHbRTH20Jf+cutOBaDEeD5Y36gzSKsUmWtHGQ1ENXhES
X-Google-Smtp-Source: AGHT+IEWEGxiqa0nVStbul3b5PFLnalXG65PJVNIAUyBMQG81zfzM8hx+xJmLTO2HQSakmnaydRC5A==
X-Received: by 2002:a17:906:230e:b0:a3c:a655:3a3c with SMTP id l14-20020a170906230e00b00a3ca6553a3cmr412496eja.16.1707687578712;
        Sun, 11 Feb 2024 13:39:38 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXG0zji+/RT4h8jx2M6HlPz8tko0mW5GDcJr4n0rfjWvJlJE09IZcQmaTxmr/wKnu5NQV4S1dFz5Fc2pdhn9vFQ5rymN4bSyZeVpF/vr7svVGRrbOOyCPqAAf2M4RzqpJeV8sQjIyiw96XXVi5axlqxOIswoti1Ss6ZIAWdy5v1q4c6R16uy2YkOm+p0c7hEZpjjvBzMQcfWTFTLUa7W2d7XyC0MteXTica8HOk8yDueWGxhlWD6+Wx/b4BdWJottk7DDlR9rCivSlbVuxgRNFyHFIDvLu4410sunh8VoYifm7XgglF/Qjn6YA8qYzJLS+I8ZtwVVZPPC8f+Vpiftqbs1JeAIkW6jZYSgAntktsllWDMfCSn4xBG9ZlIAhQny4WnekE/1MWlAfOeAsoJVcD1/64hPzgDDvLN80F6O8w8/oxQR9I5BwT+Qs9qIPbD7t+phL++ZJeH9DGCohTscDu+mJdS2+dG0PNt1hH0GE0R5w7hSxDmzKImjEIw16riFekyaEyKDQERRbJpJu/f8rEfIv5YlmGaPnGZQvizx2orwLODw==
Received: from localhost.lan (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.gmail.com with ESMTPSA id ps6-20020a170906bf4600b00a3c66ac512asm1206344ejb.214.2024.02.11.13.39.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Feb 2024 13:39:38 -0800 (PST)
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
Subject: [PATCH V3 2/3] dt-bindings: arm: mediatek: convert PCIESYS to the json-schema clock
Date: Sun, 11 Feb 2024 22:39:24 +0100
Message-Id: <20240211213925.18348-3-zajec5@gmail.com>
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
 .../arm/mediatek/mediatek,pciesys.txt         | 25 -----------
 .../clock/mediatek,mt7622-pciesys.yaml        | 45 +++++++++++++++++++
 2 files changed, 45 insertions(+), 25 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,pciesys.txt
 create mode 100644 Documentation/devicetree/bindings/clock/mediatek,mt7622-pciesys.yaml

diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,pciesys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,pciesys.txt
deleted file mode 100644
index d179a61536f4..000000000000
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,pciesys.txt
+++ /dev/null
@@ -1,25 +0,0 @@
-MediaTek PCIESYS controller
-============================
-
-The MediaTek PCIESYS controller provides various clocks to the system.
-
-Required Properties:
-
-- compatible: Should be:
-	- "mediatek,mt7622-pciesys", "syscon"
-	- "mediatek,mt7629-pciesys", "syscon"
-- #clock-cells: Must be 1
-- #reset-cells: Must be 1
-
-The PCIESYS controller uses the common clk binding from
-Documentation/devicetree/bindings/clock/clock-bindings.txt
-The available clocks are defined in dt-bindings/clock/mt*-clk.h.
-
-Example:
-
-pciesys: pciesys@1a100800 {
-	compatible = "mediatek,mt7622-pciesys", "syscon";
-	reg = <0 0x1a100800 0 0x1000>;
-	#clock-cells = <1>;
-	#reset-cells = <1>;
-};
diff --git a/Documentation/devicetree/bindings/clock/mediatek,mt7622-pciesys.yaml b/Documentation/devicetree/bindings/clock/mediatek,mt7622-pciesys.yaml
new file mode 100644
index 000000000000..c77111d10f90
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/mediatek,mt7622-pciesys.yaml
@@ -0,0 +1,45 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/mediatek,mt7622-pciesys.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek PCIESYS clock and reset controller
+
+description:
+  The MediaTek PCIESYS controller provides various clocks to the system.
+
+maintainers:
+  - Matthias Brugger <matthias.bgg@gmail.com>
+
+properties:
+  compatible:
+    enum:
+      - mediatek,mt7622-pciesys
+      - mediatek,mt7629-pciesys
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
+    clock-controller@1a100800 {
+        compatible = "mediatek,mt7622-pciesys";
+        reg = <0x1a100800 0x1000>;
+        #clock-cells = <1>;
+        #reset-cells = <1>;
+    };
-- 
2.35.3


