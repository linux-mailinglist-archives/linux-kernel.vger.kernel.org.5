Return-Path: <linux-kernel+bounces-64776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0E6D8542AE
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 07:13:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11B691C269E6
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 06:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EE4311CA9;
	Wed, 14 Feb 2024 06:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NaEAMEE/"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B200A111AB;
	Wed, 14 Feb 2024 06:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707891201; cv=none; b=Kj+ar1phLXfjLQEh5ksB98NbpXZ6cuJrjvhsEJtZ9WhvGBeJPkuq+qmOtgkyFcvkP1FliXlFr3X2Rg/Nh+kftaIbqSk9FznWN+y608up22EbM08YxSyP8R7Dc35c856UqaYcav2zTHu/GUqTvNMUa4c0VaVuZfDJ0w0jm51gtwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707891201; c=relaxed/simple;
	bh=7aIBd9Ub4VgUkMILxliwT1q+jMq3XfF8c+XqzX9wUrc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FERfe1DPJVDka5W1VfTJr9Tnxt0rB6ijFnRu/ru6t7/5OvcHaZ0qcdjW1/MvSEXobZhWw2obARtGK7iBl+6ph/nrbRiCBSeccA+yMtDWLnF2OsPqW+7Nbjr8lntWoVpIFtvpDtTlCt2rjXjcn2KHKGQNCgX24Vhy2tTex+ddlVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NaEAMEE/; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-55a8fd60af0so6798263a12.1;
        Tue, 13 Feb 2024 22:13:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707891198; x=1708495998; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fm7RlLurDkB9nfwalxlLQ2JW0yHxYihI8gdZfuipTWc=;
        b=NaEAMEE/bQQ811G+Ma5rE5urGRD/srak9kqITksnQ7lvnvOOgE7zlZmc3eYODJDUnT
         mdwfKFXr7973HBD9enye6JPx9wiSZHCYUtfxEQ5WrH5qfVKlG09lOaBrx09dBJTb6Vpw
         2moxaq7N4337NWPXJcw1Yx9eT4IRD7OJYxXtS06eQ5YwiRU3+6FElG+UfNxizochiyF8
         2MPzw3zEOuPY+6uZW9LGmx5ifkDvh095k9g8gPYs4nOCLvFXCAqn0EoHP2jU8GxKnn7x
         m8ivUeZI/eRll0Qgu6cb6K/gPEeOxpICU8aQsZuTv9NdcAzPKOSLb+ayeMhm6rGRjY6v
         1HiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707891198; x=1708495998;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fm7RlLurDkB9nfwalxlLQ2JW0yHxYihI8gdZfuipTWc=;
        b=jB20HcAf+m2KiEIr0xYK7NlU3O2YzKIWxczNPtjeBQVK92CfSREntthTrzZfOjWW0P
         fr5pesZ8vSMuyZng/wrsmirhmQlrGnntJIbiOj5sYz6jDKlhMRFhHDpRFUtWL7B+16Ka
         rP+3QP2TBQN4vrg79eKacSFHPfeoV8P4sQXO+snxe8SBbdlU4EchL7X4ujB8LhjSHQ5R
         ikPPiO7uUjUP5GsXEuBjQDAVl4dXaHqsNwNN37TeIOYwW2YPdMAltVKswvGp+p6jayGv
         uVUku0AR+deqsN+myRLcSTzff919QadZbbhpRjHmDpPQoaZgzz7hP5GMppXFxT4Nr4El
         4rWA==
X-Forwarded-Encrypted: i=1; AJvYcCWi/zQFXBWkG2DsUjvXDZqG7tKQ9Jo+eR4qZoNWxD1smuStVoIv0rU9NH2p72QzBZiWGKmI0EcbaVBAmfxwkz2pfnjRoqsj21vwWBvIn3pTYsSXzGt55XkCDDUWtuAxuBb/dTYksr/TMbUnM5EyxcOaEY0MdNXHGdfjtsRPTL0UWKCYRg==
X-Gm-Message-State: AOJu0Yyfdoah0PLX54yXD1u/6v4Cd27NKbXL9oB2B/uhbxeIW8DDB+3J
	fXl5WXX/Gwo/WntkLf3auk1ntTtX9DmRouAyt7OTjQv1w7bsJafu
X-Google-Smtp-Source: AGHT+IE6vAggKpthxxjybdmDgBEebRvguPc9ZiRq1zVHc9Ghzh2ZwyyLhUgUWwF+aT64O1YJHrAJgg==
X-Received: by 2002:a17:906:e086:b0:a3b:ff1d:43a1 with SMTP id gh6-20020a170906e08600b00a3bff1d43a1mr1118210ejb.53.1707891197676;
        Tue, 13 Feb 2024 22:13:17 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWHguzWqGVn3ASuDOAp0rM46lm7SYe7FHG+PybMh2tpknnmhFcGzex29Mbwnueqj87nMN6va+oMQLeM4fi1wv7FI5tDe/6uOGjwn8p/wOUa1V0KMlm7MnOXnlwCeLKQwwoer3opr9Po2HPEpPtC+PZiYrWgMmk1LnyPJ6/zJ+5eg5+DyqBToRMPJYZnA41PbqOmDWpMJp3W174xSgzKbrVToOhWUS7AfroOacBZzARd4mVqtGHHnZBALrcdP6ruEoBmrYzje9uoT8Av2mO17LJ/agGuL82ybmLfNJ9yf5RqfAZcldNVmz1SaWWskV4euwbBaNl6Zyid42YUyswBdLWiLFt+zmaNxovv9HcFsC/aJ/DTkwRFLwniScEp27qVJf8TZJf4TzOhRc8rQ2Xv/NWhPk5khH/phtjQcPVFgZ4vP/nknheQnyfc/U0JbJo5Fc9T+3OQ50rNlqkpe2Y8MHdS2WtExiCs76zCCOYOR/Zwwq9Ba6j7pjbvBKS0WWpWvDj0J38uYBCjEi8seTvuFMUJw52ZYutZ9vQVfQ7lYNx71AEFbBgDwiPn8KnZJfAAMcsqxeW8T1MrVGm2QPDlIQz0kC/BiByo9C2T
Received: from localhost.lan (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.gmail.com with ESMTPSA id ca23-20020a170906a3d700b00a3caccb8f66sm1980163ejb.44.2024.02.13.22.13.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 22:13:17 -0800 (PST)
From: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Russell King <linux@armlinux.org.uk>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	devicetree@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH V4 2/3] dt-bindings: clock: mediatek: convert PCIESYS to the json-schema clock
Date: Wed, 14 Feb 2024 07:12:32 +0100
Message-Id: <20240214061233.24645-3-zajec5@gmail.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240214061233.24645-1-zajec5@gmail.com>
References: <20240214061233.24645-1-zajec5@gmail.com>
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


