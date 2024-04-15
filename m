Return-Path: <linux-kernel+bounces-144920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17A408A4C9C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 12:35:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 810151F22C82
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 10:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 408195C903;
	Mon, 15 Apr 2024 10:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HL76c/o6"
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F72C5B692;
	Mon, 15 Apr 2024 10:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713177338; cv=none; b=PqHIGRDDt/fMcqzie4Fisi7GFdHA6EtBeKm/0f3KaDUE/w8uKNSI+fS4WosfeBzlN/mA83Offc1GDGSFKCXqWFr9prxBnhmeICcCOCkJFKMupudKYGGcL2Uxr/h7RaKHoLNx3YGRJRn+6HrHUGU0MDdomRejZEQ1+ulXb2WC/AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713177338; c=relaxed/simple;
	bh=+sZ4VpMaNAH3Kyh1mrOtLGIavWRSCUxu2kcXWNcK9Ag=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=I8+lxO/dGmxnNcD5VBguZcg/euap9sdaQlzoEJk+XlR3ofevEyZHcTX/0xMkO35nKReuiRqKUUvSWoflB6rKq4/kJkFQiOo6JhM/nlAQ4w2seOXzRQ5RBClrqZlcK6LQCtL9vkJZGfqoeEDJqfMYr4ZO1RHBp1aWdQVq0y/XFC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HL76c/o6; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-36b191a746cso7424615ab.1;
        Mon, 15 Apr 2024 03:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713177335; x=1713782135; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+XyhthZLoESO9WHc+S1+kDbhL7mPzfup8TR5Ezu6fL8=;
        b=HL76c/o6RvkTUhUZiZnCWy50DOK2rNWUIgMT7yd61XJwFEisG4p86QBuWiBOpBJvCj
         cXpVSuOUSd0Hf7OhbUOuzE75wvCvBaq49jqSlIfGAWgSsCcPlL2aZPmKjHthg2vBzeAh
         SOnvlqMmRGM8jlO1xbWP+rLzoVsg7r6m4LYvZIfczEwe81DsVSTltp35CWKdTd5MmcsN
         9zkDtT+vGx9qme6cnmFL/cgfWTxRVErPbWk6gEp1KtVU5iKIYIEAT8yhlc0/oawdTkB9
         NXaH+tzO1omKyeuyGLzVcj8tqcCTpQrCitSh8BM/v4BjfyQA8zpvZkTyG7OILkLAPkfy
         IPGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713177335; x=1713782135;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+XyhthZLoESO9WHc+S1+kDbhL7mPzfup8TR5Ezu6fL8=;
        b=P10JJPAF4u1pCWAY/dD4wlX8KMIdHrmeWGDJBlNg2y9l3MUPvNe74ZPByQQGxmZQ4G
         gxJJ0Fm1mxlNsh+AASOoAWuHE4RkYmlpm6qAkgq+8d7p17sjFZ7qklTsNyBuERlOCcXb
         KGOAZNPVBtUNI8BgnElYWaLc+FqPwQB01qw5r6HWZbqrNVyR/I3+AwAAlt/5ih+tGHbX
         /eGJrbQsM9Hxu16N9dCTIharFDYLNbRZz1yXJemiWLR1/AAVztOvCNTC1M+ra8UMvdS4
         aO9YMmot6lZW7xFA0k11flGbxJAW+s/qWC2aV+ulBaL8OJh25zxODXDyaNyFOtmk91fv
         mp9Q==
X-Forwarded-Encrypted: i=1; AJvYcCURs9Hpz+d5qc81V/+5sbs5pLNvXwLcm3e+t/hdfhjwoluYLq7Kln220dyKL6jMB59OkW8SaNwhg1/vHEyKxceeupI2OnW9nJxROhs2leB8xY0j+ukfMs1zrlwJAXqsU5yduNW/DaJtVg==
X-Gm-Message-State: AOJu0YwPrDV8+T5XhTdC3LU3Y+rndS/jjFIVWmyFya5O4PcUYqLepxvm
	RzNTg+ZzT4hOZOzYzTUj3Ptb8cyKnjKSJOOIMu0TfGOAXvd6nbwx
X-Google-Smtp-Source: AGHT+IGJY0q9uBdwrLu0JkPMZbqGy95JD3Xs0cjTSo3ts38OfBJnJAWmE+u6dEhicMygwm+jq5e5qw==
X-Received: by 2002:a05:6e02:19cd:b0:36a:a6c4:b6da with SMTP id r13-20020a056e0219cd00b0036aa6c4b6damr12178592ill.4.1713177334703;
        Mon, 15 Apr 2024 03:35:34 -0700 (PDT)
Received: from localhost.localdomain ([103.242.120.171])
        by smtp.gmail.com with ESMTPSA id u10-20020a63b54a000000b005dca5caed40sm6799430pgo.81.2024.04.15.03.35.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 03:35:34 -0700 (PDT)
From: Mighty <bavishimithil@gmail.com>
To: 
Cc: Mithil Bavishi <bavishimithil@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	alsa-devel@alsa-project.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] ASoC: dt-bindings: omap-mcpdm: Convert to DT schema
Date: Mon, 15 Apr 2024 16:05:23 +0530
Message-Id: <20240415103523.139-1-bavishimithil@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mithil Bavishi <bavishimithil@gmail.com>

Convert the OMAP4+ McPDM bindings to DT schema.

Signed-off-by: Mithil Bavishi <bavishimithil@gmail.com>
---
 .../devicetree/bindings/sound/omap-mcpdm.txt  | 30 ----------
 .../bindings/sound/ti,omap4-mcpdm.yaml        | 58 +++++++++++++++++++
 2 files changed, 58 insertions(+), 30 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/omap-mcpdm.txt
 create mode 100644 Documentation/devicetree/bindings/sound/ti,omap4-mcpdm.yaml

diff --git a/Documentation/devicetree/bindings/sound/omap-mcpdm.txt b/Documentation/devicetree/bindings/sound/omap-mcpdm.txt
deleted file mode 100644
index ff98a0cb5..000000000
--- a/Documentation/devicetree/bindings/sound/omap-mcpdm.txt
+++ /dev/null
@@ -1,30 +0,0 @@
-* Texas Instruments OMAP4+ McPDM
-
-Required properties:
-- compatible: "ti,omap4-mcpdm"
-- reg: Register location and size as an array:
-       <MPU access base address, size>,
-       <L3 interconnect address, size>;
-- interrupts: Interrupt number for McPDM
-- ti,hwmods: Name of the hwmod associated to the McPDM
-- clocks:  phandle for the pdmclk provider, likely <&twl6040>
-- clock-names: Must be "pdmclk"
-
-Example:
-
-mcpdm: mcpdm@40132000 {
-	compatible = "ti,omap4-mcpdm";
-	reg = <0x40132000 0x7f>, /* MPU private access */
-	      <0x49032000 0x7f>; /* L3 Interconnect */
-	interrupts = <0 112 0x4>;
-	interrupt-parent = <&gic>;
-	ti,hwmods = "mcpdm";
-};
-
-In board DTS file the pdmclk needs to be added:
-
-&mcpdm {
-	clocks = <&twl6040>;
-	clock-names = "pdmclk";
-	status = "okay";
-};
diff --git a/Documentation/devicetree/bindings/sound/ti,omap4-mcpdm.yaml b/Documentation/devicetree/bindings/sound/ti,omap4-mcpdm.yaml
new file mode 100644
index 000000000..73fcfaf6e
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/ti,omap4-mcpdm.yaml
@@ -0,0 +1,58 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/ti,omap-mcpdm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: OMAP McPDM
+
+maintainers:
+  - Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
+
+description:
+  OMAP ALSA SoC DAI driver using McPDM port used by TWL6040
+
+properties:
+  compatible:
+    const: ti,omap4-mcpdm
+
+  reg:
+    items:
+      - description: MPU access base address
+      - description: L3 interconnect address
+
+  interrupts:
+    maxItems: 1
+
+  ti,hwmods:
+    description: Name of the hwmod associated to the McPDM, likely "mcpdm"
+
+  clocks:
+    description: phandle for the pdmclk provider, likely <&twl6040>
+
+  clock-names:
+    description: Must be "pdmclk"
+
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - ti,hwmods
+  - clocks
+  - clock-names
+
+additionalProperties: false
+
+examples:
+  - |
+    pdm@0 {
+      compatible = "ti,omap4-mcpdm";
+      reg = <0x40132000 0x7f>, /* MPU private access */
+            <0x49032000 0x7f>; /* L3 Interconnect */
+      interrupts = <0 112 0x4>;
+      interrupt-parent = <&gic>;
+      ti,hwmods = "mcpdm";
+      clocks = <&twl6040>;
+      clock-names = "pdmclk";
+    };
-- 
2.34.1


