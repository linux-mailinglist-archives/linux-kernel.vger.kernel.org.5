Return-Path: <linux-kernel+bounces-64777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F38208542B2
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 07:14:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 691CA1F24846
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 06:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E285125BC;
	Wed, 14 Feb 2024 06:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DqBXR9n0"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730F01170F;
	Wed, 14 Feb 2024 06:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707891203; cv=none; b=L3lgx8dR02QkFKKxkujZgLT+Yw0k5dvq+fE9r/6oNxg6oRQfvsrhcB8SKGbDg4UR17Z6CnPcQ7W38rcjwF0TURK0IqHCY/tjEDfEiMdLZnL2+ZrvlvDfwrbcaA9H1EJM6gS8lpobodBRl11c8ZeLpkMSluwm8PAIEb6CHlMaN+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707891203; c=relaxed/simple;
	bh=LgpLA72Yy2DgXq7fM3U+hFO1U9oOC9qFq5Ar4+afhHM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CtADk41/jbdbby1oCAkuTFDXqkme58D+BB+Dx0BoqEvGp9gwSySQSHFt0Ncn0j8bR6g68tjJQkJ6Q3IhZPKu3sRvRrWP3+4LAXpEfXXSfeftR08J+4h6Ymn1Uf6XsOJ/ET48AJnMVdNhoAysdivBv/F6eYm/QNHpAoIqZMSEU1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DqBXR9n0; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a3cf64f33b3so183967166b.3;
        Tue, 13 Feb 2024 22:13:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707891199; x=1708495999; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0EDbWqws9cGFaTSgQ7d/JTeQtcU5zOGhJZiE31yQ40s=;
        b=DqBXR9n0CAqjQowmqGaMPYUUWDChm7x04czGafI75QcwuOVxVid8cx4KnRoHfor+zy
         PQix2J1Dlb1a7o4qwJlgJjE6qPXqBCJDybD8CwMp8ru/T+HBvTiMbZDpSvuhyq+t4tkD
         /RQ+Ht/O/v6z3fNwxviLv4osIq+I8X3ui4/UikdFFOuts6pPyRaFzW0db6sbEMoVAVQX
         piy3vhpT2wBi4wsgY7gZSK1ZQiprCz1oM/4OLTSSl9GIDNoF9gxN80IA+tpNBE+zPzyO
         fGR51GGVHvNQp9kRc9LssGUO4bCK2IbDKZwjeoENDQHoo1uxY4dqQrwi61cMBf5wwRv/
         rlFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707891199; x=1708495999;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0EDbWqws9cGFaTSgQ7d/JTeQtcU5zOGhJZiE31yQ40s=;
        b=fZqTWlagEEATziC/OcwHd1rxQ+VO9EDpFOpuETYwy+nLRWIOsBWjE6DwDY8KkkI6Y0
         NkmBOBfQd3BLRefKaIzN8AfNxV3P50nJtfiltXr+TmW+hHYCbP0NHXXokTvW3IEYg+0y
         dWb3tf3sYtgfYv4+F+Ekzq0wmYXCbhMfs/Xottx0hf/7G966Tn86aL7Ydo8wNuYAKiUQ
         52BaTDj8GC+JVmrEaf4tG4x2eIZz3mH8T7cTndCTXWhwjxNvX4Ja34EQAcH9sD66BOAb
         mkOeQq43C3+S56tdjI0ylQ9Np7ThOWn5vTHW0Yb2/QN+aYcHA/iSmPxfs+17rlpj4r1F
         CzdQ==
X-Forwarded-Encrypted: i=1; AJvYcCUoO1NtVEhLxSYK/OGKonqN6Fc0nRNh/enGbCewMilFQBsVumuye2Wsqvv1Qz+yBFdUfNScwaaTDbzD9+HeIuTt2IQ6FFoPfM2z4ZocJRd6mTvR5L53mfMB5ETeEX+S2mAB2O0Xc8UXvE4WG1nTfxUqSJfiJurubT22hjwFLQwHHmIhVw==
X-Gm-Message-State: AOJu0YwfN/jkyA2kituIqHulfBUqVyd6BeL0eLiXsylvoEb7mkLf4xyU
	NELvOZFCR5o9pppiFGVMppi2e7zr6Ru8pXj0WF3StXmBi7uTw0e1
X-Google-Smtp-Source: AGHT+IGcdc9MhMF2QCYXKDqgHAb2iQpgiSM62KSdnvoJCUvMTwnehra+UAazTEfsrpPrGHVZ7N5lZg==
X-Received: by 2002:a17:906:4a8e:b0:a3d:4dec:26f7 with SMTP id x14-20020a1709064a8e00b00a3d4dec26f7mr338386eju.6.1707891199525;
        Tue, 13 Feb 2024 22:13:19 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWyN8G4qtIV202cD4o9ZwYJxigXomwvuwD44sYYENvf/P+NZwmHwC+mlVJd32ng0LnLOo9xX0nuFr/NU8vNqFrz1ovgcR8wX1qhe7TG0oBhaDIMxI72PveuU+FovLjBEjxV3p7D6LjZUGfZAOIJIQIPEu8V/Wnz6UiXHisSL5JdnwfTAWPeVR5p2K9YINIb6WWGS5OzzSRTBVmp6ss8jeiU17vEeY/gOX3eDR7DitLuGjk6NTbvX0dp8Mfz81Yy3mPEnBvnboRjx64eSXmpoB+euFmIldHnVa/qec9QCz6iZFrKRjAEWaOTMdRzTqDazEH5WhWuNxCUq9sFDPr6JWBdYcjY9dwaGRMViSQ9zfWsIo6BFWJY9iTUk9asxQuaKIvajlRHSiGuMbit17oxV64VTTIIQA64qPVNvfJzERtbiVXb/lg/rELNSmEr6XH6z7I0Fc3ceJOGl2CnlbCg4jGyjQhXih9QZn+YCd89S3vkyDOicm/XoFyHiPWvYhm/x3ARWvFaGc/0c5cJGlzD3xiGTlV3MhM6SgOkrGTB63eTTeZ2byCN5NMiG5/XH/28JI891Gy4FBixopGm17QS0EgZ1mMH/wFkjY/h
Received: from localhost.lan (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.gmail.com with ESMTPSA id ca23-20020a170906a3d700b00a3caccb8f66sm1980163ejb.44.2024.02.13.22.13.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 22:13:19 -0800 (PST)
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
Subject: [PATCH V4 3/3] dt-bindings: clock: mediatek: convert SSUSBSYS to the json-schema clock
Date: Wed, 14 Feb 2024 07:12:33 +0100
Message-Id: <20240214061233.24645-4-zajec5@gmail.com>
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


