Return-Path: <linux-kernel+bounces-58749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E523E84EB05
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 23:00:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D0F428E269
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 22:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCEAE50244;
	Thu,  8 Feb 2024 21:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jrm0VFg7"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F334F61E;
	Thu,  8 Feb 2024 21:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707429581; cv=none; b=Ycp23UwUqfLysDAwdZsNHW1oAiolGL20UiO8dIDPIZnDPs+X7A6A2T7GF+eFrLQqRaM1Rbni7GYhN2bzKsExtNP9VDn1U0IIe6RArKoYhtaZGhxUe2rx+ON1+Ww6IHhWQiS0+ypyRQdiXszw5nEDJ2H7kW6ppSDkkcFlMsuqxZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707429581; c=relaxed/simple;
	bh=GCre1XQTsyAwp1dzEfFqTBUkUfOE6AvAGr3w8n4g3tU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aSVgwpliN2NVWg5tb2Sfb69KHKN7EcmhlGsO85cdABghdoXQC4n7fvrJd+6lpE2njZx0kGFO+H0HlXsu4Wt4xCj4k6nd8eXwnQ2qB1lQLFwQwIR3Q9ixkgT1CVhEdc0afxNWTtQES4y5PIShIG/lVdvN6qPVfgiUcC6/a914TIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jrm0VFg7; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-560e9c7a094so517849a12.0;
        Thu, 08 Feb 2024 13:59:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707429578; x=1708034378; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eeAmHmtuylGJLNzh3ueLyRJFJ1gmDfZc8JyHSqj91w8=;
        b=Jrm0VFg7xGEX5HaxTGpblvhVDE7ivcA8vQtxYu5AU3LgU16jSORSXe2tjnaLz1OoJB
         VRdYa9WJ6gbDpcQo1/ezJaLWVrK6khZ7pIcKDmB6VOXTjJWv3+bqmMEPqN3fLw/OLlEG
         tMBFdU59RMgmDoII444/tx1iKp0xra4LKuq64Y/57OCjhQVx0uGKNxVIHCINLGwneVkQ
         knhEyMTRgpWSIgG8md7ol+CER4mq5TCg5/YEneDy4u/OXle7h4D9wNuLAVCz4aABtPFN
         cfW3bAhAzL3yZwUoj/L8j7j8ZKbJCO8Rl2Y09XBYE16mNM6UHqam5khrfXnNFebPLirK
         SLGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707429578; x=1708034378;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eeAmHmtuylGJLNzh3ueLyRJFJ1gmDfZc8JyHSqj91w8=;
        b=mUhzPWF4jkl5mFXJm1sbvZcGfezDHKx22/oE8ppalOLF+bmIwubGfI2veQ4CJvtLCU
         gZYdeWLI6n9jeFpdNrFCdHhONRQRTnEndrM+tAOB1YNp5zhFIT4L61R0393jZ9pnjE2I
         DY1g/clZxzh9eaWfDNqsNP4WHtqKdAx0DougBJWy4nU38T1A1PYsb9ngh165vQqVEH1x
         Ry78JWCLxvXmH6XNxPXd4J0sQ796DzPLhHnuXf6wHGTrFs8RqCUgoo3B2oGTv+c7TdG9
         kAcMEffMuqiqpn5gcFH2LBn7iJULp0W8+JucZmyfe9Q+8zlaaIHxCcVANW7lsMi31sqD
         NnHw==
X-Gm-Message-State: AOJu0YyCuOsdPkZi34vXerYmLjmEPsQfwU7VEwTDfnBfw5Vp5VN/SGTG
	cCnPfA3/LbJqGwc7jnTcAV8BaM9z90lCv9p8kPRidqKWfVzhV+KlMMbBAleq
X-Google-Smtp-Source: AGHT+IHmPgWSOLtLs+Nyfep3ErUyyxdizCanfCowfDUpJU2c+fXTJ3GLxnI7xq55RoFsVMrADvcnyA==
X-Received: by 2002:a17:906:aed7:b0:a38:9fc3:3d8d with SMTP id me23-20020a170906aed700b00a389fc33d8dmr390460ejb.46.1707429577716;
        Thu, 08 Feb 2024 13:59:37 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXhCgss0C0rgZFIaPdY59ajK1Bar3J5lmPTYtD0zsdtpziXQgWSvHS5QdaNLyzf8CNUKFtfF/hiu0t1mnTFwSi1AONqWfSWOCu0ZXMuWJUZDtH7848iAkj7/e+Sd4KMg3N05EA8gmc1p3eGAk9MpJRE7oOYI4oCIziNM/ria9zUh8JQHe7ZUNHpBtJ6pnWONzoacijysVTANphk2KRK/uxwVPQk1AB4X50jR2QENYL5cBDyaIEyqEdN55BR3Pd6fNw7s0P9E5uPE/hlfFXJ8BTacPUJDlUWvMW49NxtDqTUWWeewrg0/CagaqSQIT5dWwSf8txE/upsIt70Hp5W6sNRVqK3OE4xglY8ofJHyvSRke1vJctCu9si8SDTrATRoM0caRm7GrJiMRcBCZtbouqX5RkOu+jtHtkGgnBnQiiAUMy+VhyPJub3H7ANpm03X/gqO4y9Ps+dXar70BhEn0M/pd0ibOXevGoTZ7yq2dxUI62p9tNvmAjefEtlP3boFv7w96w=
Received: from localhost.lan (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.gmail.com with ESMTPSA id rf19-20020a1709076a1300b00a3743142429sm108255ejc.39.2024.02.08.13.59.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 13:59:37 -0800 (PST)
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
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH V2 2/3] dt-bindings: arm: mediatek: convert PCIESYS to the json-schema clock
Date: Thu,  8 Feb 2024 22:59:25 +0100
Message-Id: <20240208215926.10085-3-zajec5@gmail.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240208215926.10085-1-zajec5@gmail.com>
References: <20240208215926.10085-1-zajec5@gmail.com>
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
index 000000000000..27b19d5e3a85
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/mediatek,mt7622-pciesys.yaml
@@ -0,0 +1,45 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/mediatek,mt7622-pciesys.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek PCIESYS controller
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


