Return-Path: <linux-kernel+bounces-98122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB497877566
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 06:19:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04E2DB20155
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 05:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 210E6111A8;
	Sun, 10 Mar 2024 05:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YZsQJNyO"
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECBAE257D;
	Sun, 10 Mar 2024 05:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710047979; cv=none; b=Jv3r+pCkX1hfZX8l4HaHx9WCdI91dxwDwefxBiZ4KT7YH3c+L2nJyB6/oc7tNLlxagpk+vODF7ZMV/56naR6q8iRFCC3ATxP78uhL3q1HWobtuU36K6K1dc/c6ngKf9mnFRCsCohJUmRYfDbF7vMptnGKIbrD84h118bwwb+HIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710047979; c=relaxed/simple;
	bh=FEwqsZ/L47wp0oexwqcD/oAHTnhQ1S/70n21XEPQ7JM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=srgFft8/LqZfOGC0wBommHBTvWaAaG0NYkjI/I0Zp+OSSnrAAlvknwtYQ97gUl09Fyzxn5fn0iLZ8dp/Gwsp9scLgQyhnjX1AtAi2FTDFYvTaid2L6BAVVcyhuNPwrpZbVA04icG8Uo+erpK520+bF3MhjrtZPZGpk+2J36ZZKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YZsQJNyO; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-221a37a29f5so1177869fac.3;
        Sat, 09 Mar 2024 21:19:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710047977; x=1710652777; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uVVGE8GaEDHHmhOEunvfSVf3mdMruJPA7Ps3WM6YTI0=;
        b=YZsQJNyO0DHprjquQSjX/UKVjkQqV1NqU6TLP60JluykMtEM+W+vQrtA2TWyCUUrIr
         YSGMGqwBZSrF7GChOaTLd20dGbc23EbIXh37oMrny305TetKSZhUykca2a6WzenxJ+OE
         oXZAuV579AkAqO94DlVRvCRQDCFf/u4aSEmIjJR7fiWKSchuwZkjquS/yVqsjbth38/g
         6fhwrk54AYlpRaBhVHJXR9pH9fDqXlIZz5AR4o9lb35si+tQfzzcNCdfVeszJQSX6Diq
         kMMxlMTTzb7AFxG8ReQQl0ihK8BqpNrPZfEU5FbwJ9QWuCxP/eaBAh89McDKsbmF1SdO
         BQPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710047977; x=1710652777;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uVVGE8GaEDHHmhOEunvfSVf3mdMruJPA7Ps3WM6YTI0=;
        b=lFwZI9WSvH+bQarzryn32MnF5K2OiuAC7unud6V4QYN4cLXnraeGEJ8QFPlDoLhXK/
         aLOan5fMTo29tdqHGpmS3s1PtM17sImR6fQ1zGnAb6cS2466JucBsEySLx7RAKn8A7Ri
         WRgQW5/ANG/dkluunzYznze59dsJyyKOTDEqWQqEDrVMm5pJ3839e29OB7zOkTQo8qLI
         T0AFdh7Mx7ceGjvUnrbafoIH40yDUb5jxP3qOTerIdM3GGvxVHvA5Pnb+0K4IDAMqA9T
         gpma7Hz3sqjcb/Q9Aki1wpq+tMCfdDgOO2ZMqahdg8qkPjuGkU8JTTJdNBDhjASSxN+1
         CxJw==
X-Forwarded-Encrypted: i=1; AJvYcCW9+ZWSe3z0f8xB3irJO2RcAneqqy0aXeRYPKtdKuyn1jwRFFPIidtYwWju6lodoX0AdpKeVjODza82tjFd1VeNJGBH1KTnJErx8ad/7Qqth9AzSKfJyBi4IqxFLQeej+JqbRMsRu17qgU/kaogPilrg+FoLMaAbVbmjDznyQ834YspGQ==
X-Gm-Message-State: AOJu0YwV4hKYrwgZBvcEuSvVYUxdiDJZc2/vJvE6MpdP2eZtAOl6Jm2Q
	zLG99rjn3uZKsST6OqI1O5Py7vuqRYtmOlQXR3bAF9gu2Mcu8Qzw
X-Google-Smtp-Source: AGHT+IESntEqwQzHWhQocQpY9SyZGd4m4ChjOhsqpXKrxhu1lQP7c035x40l2KEcp0OBYa/Bq+H4ig==
X-Received: by 2002:a05:6808:1509:b0:3c2:2639:9792 with SMTP id u9-20020a056808150900b003c226399792mr4828392oiw.48.1710047976958;
        Sat, 09 Mar 2024 21:19:36 -0800 (PST)
Received: from fedora.. ([2409:40f4:3a:d8ab:6980:be5b:99c3:fb12])
        by smtp.gmail.com with ESMTPSA id s9-20020a639e09000000b005e17cad83absm2034243pgd.74.2024.03.09.21.19.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Mar 2024 21:19:36 -0800 (PST)
From: Animesh Agarwal <animeshagarwal28@gmail.com>
To: 
Cc: animeshagarwal28@gmail.com,
	Damien Le Moal <dlemoal@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	linux-ide@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4] dt-bindings: imx-pata: Convert to dtschema
Date: Sun, 10 Mar 2024 10:49:09 +0530
Message-ID: <20240310051914.153193-1-animeshagarwal28@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the imx-pata bindings to DT schema.

Signed-off-by: Animesh Agarwal <animeshagarwal28@gmail.com>

---
Changes in v4:
- added fsl,imx31-pata in compatible property
- imx51-pata was not defined as	compatible in txt bindings, adding imx51-pata ensures this node	compiles to imx31.dtsi
Changes in v3:
- added fsl,imx51-pata in compatible property
- imx51-pata was not defined as compatible in txt bindings, adding imx51-pata ensures this node compiles to imx51.dtsi
Changes in v2:
- fixed style issues
- compatible property now matches the examples
- fixed yamllint warnings/errors
---
---
 .../devicetree/bindings/ata/fsl,imx-pata.yaml | 41 +++++++++++++++++++
 .../devicetree/bindings/ata/imx-pata.txt      | 16 --------
 2 files changed, 41 insertions(+), 16 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/ata/fsl,imx-pata.yaml
 delete mode 100644 Documentation/devicetree/bindings/ata/imx-pata.txt

diff --git a/Documentation/devicetree/bindings/ata/fsl,imx-pata.yaml b/Documentation/devicetree/bindings/ata/fsl,imx-pata.yaml
new file mode 100644
index 000000000000..aa0174844eb1
--- /dev/null
+++ b/Documentation/devicetree/bindings/ata/fsl,imx-pata.yaml
@@ -0,0 +1,41 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/ata/fsl,imx-pata.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Freescale i.MX PATA Controller
+
+maintainers:
+  - Animesh Agarwal <animeshagarwal28@gmail.com>
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - fsl,imx31-pata
+          - fsl,imx51-pata
+      - const: fsl,imx27-pata
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    items:
+      - description: PATA Controller interrupts
+
+  clocks:
+    items:
+      - description: PATA Controller clocks
+
+additionalProperties: false
+
+examples:
+  - |
+    pata: pata@83fe0000 {
+        compatible = "fsl,imx51-pata", "fsl,imx27-pata";
+        reg = <0x83fe0000 0x4000>;
+        interrupts = <70>;
+        clocks = <&clks 161>;
+    };
+
diff --git a/Documentation/devicetree/bindings/ata/imx-pata.txt b/Documentation/devicetree/bindings/ata/imx-pata.txt
deleted file mode 100644
index f1172f00188a..000000000000
--- a/Documentation/devicetree/bindings/ata/imx-pata.txt
+++ /dev/null
@@ -1,16 +0,0 @@
-* Freescale i.MX PATA Controller
-
-Required properties:
-- compatible: "fsl,imx27-pata"
-- reg: Address range of the PATA Controller
-- interrupts: The interrupt of the PATA Controller
-- clocks: the clocks for the PATA Controller
-
-Example:
-
-	pata: pata@83fe0000 {
-		compatible = "fsl,imx51-pata", "fsl,imx27-pata";
-		reg = <0x83fe0000 0x4000>;
-		interrupts = <70>;
-		clocks = <&clks 161>;
-	};
-- 
2.44.0


