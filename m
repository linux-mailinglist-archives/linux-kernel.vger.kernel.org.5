Return-Path: <linux-kernel+bounces-120397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 310E888D6CD
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 07:44:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A28DE1F2BCC2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 06:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CB0B22089;
	Wed, 27 Mar 2024 06:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V/syqnZj"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5B92577A;
	Wed, 27 Mar 2024 06:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711521869; cv=none; b=Z5W1s7LiLl2wTzMBMUmiIlqvHh8xTqYqJk0Y/lqMHIrTRvoco4rqU8cAmlDuuxJ7jzeDLhbBgEy021ZkEdQOgQy+C94L9f0FqbZxIBbgt2P6F3JeBD+98wXzdF3mURntgPXgqa07GIoHMG6lKoVUZdFH5MN11bXghsEWFhY5SI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711521869; c=relaxed/simple;
	bh=gaY4uxUtw/VyYyckWAO5Sda2ZlYWBVwNlEmKIyc4jbA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BeVpFl/YG9YoSEflDgQ8xH+QpVv/JWQLefrfcVnR/ev64rmIUakEvj3F31bQfOAQv0gVW2d/68I/9xEnXnIPUn8SsIGW5vcZxJcCi2YHVn5N6dkp3x9bfowPJaqnQ4VKMlHu9y/60u52J3HzbqyxGHY57NQVmDTnZ8ryfsNboxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V/syqnZj; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6e6b3dc3564so4516719b3a.2;
        Tue, 26 Mar 2024 23:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711521867; x=1712126667; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=r6dZugYqHLKD48hNBCyfJRW1Kclovt4nu1MkauiHbJ8=;
        b=V/syqnZjk4fQBpWZCfFHCRgSxANpkxm0BlsAS4pATVJx75bGehFCjbJw5cTIPWkEgC
         KENk3OA/afUtJyq19te5I4RGBVEZYRORs9ce1mcLOsiewUVi7UtMS+xBMzH3K1E47FAB
         URpjdrwGDKU3W0T/pGAKIwUEvux3PF/3vbd5qKY7yVTt0rLI2AzvmoSc9xUHTuQBdT6C
         iNDYQNUicO5HuC/FswLkFdUzJVaIFUVLGb6RUJcGvDM/ci/WxEzAtm48gGFveigdNK5Z
         fr8gkgrFwc/Y0qwSHnx2wXMA/jEEmZWk+2YbaWokMu3eUIMRQtb3AS+CnQCwIvC7vj9E
         D0GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711521867; x=1712126667;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r6dZugYqHLKD48hNBCyfJRW1Kclovt4nu1MkauiHbJ8=;
        b=CIg7OD/vPCh+Y448XWG8Loz+4NSug/VBUpcQ+yKMYyZhLYnDps/RgPXcEBVyDNfbml
         qkS1uD5yM4TmTNFgxYeijV+64lkD+vF1s2t3YS9Vk5ROxLTDmxPi8e/8Jk3Q3FWQHKQ8
         3HG4ijaCKcpW5ZZf0h8CPZeTSWBJ3ursKfEP2eeamZiX02frmcR3gcf8rMdcUqWdIWP1
         hVtI7gtM7yLvWXEV8A3EcSvs6J8VFfUTrujWKh/gYIMEMDS9gqO/bw0NHFktuxJkeR8e
         dhMYKAoK0L5JT5rrGU/tPBkTQQuQDMxoOe5WCQcVhl/uTeSlUWi8qPymabuutXFAfOFc
         dxBA==
X-Forwarded-Encrypted: i=1; AJvYcCXHwlBkEcaKvhCfShIOAN7ZXDVta3l0+ZFfusMQpPwtn6koCem4XSZXeC4C+PZdnk55A/hg8f+YlIz0lj48//GcaBhFT40jay7KB9O8pBbQ1VSD7jBAupxl2uY+d76CZO72su0wDJa86uCJdisJzglkJR60MgA5qG9cu4DAIITZ+z3hRA==
X-Gm-Message-State: AOJu0YwFlXUWgs8vafsWMDUgsfBPg9iC8oJASI7HqgVWCPEBBvHtyzN1
	6BWRblArROV6MvYJmDYcbJBVWlKn7FPUMMt4wt+fMBmayTUnR7JR
X-Google-Smtp-Source: AGHT+IELbG/lC0SlpK0hEcU3eD3jc67RaNLZQPnP6YvgN6qsnMrfI47ZjrXTHm4QnvLMRVLz1nnsJQ==
X-Received: by 2002:a05:6a20:8409:b0:1a3:c3e1:6a23 with SMTP id c9-20020a056a20840900b001a3c3e16a23mr3536644pzd.43.1711521867452;
        Tue, 26 Mar 2024 23:44:27 -0700 (PDT)
Received: from localhost.localdomain ([122.187.117.179])
        by smtp.gmail.com with ESMTPSA id v13-20020a170902f0cd00b001e09c35e058sm8074962pla.195.2024.03.26.23.44.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 23:44:27 -0700 (PDT)
From: Animesh Agarwal <animeshagarwal28@gmail.com>
To: 
Cc: animeshagarwal28@gmail.com,
	Damien Le Moal <dlemoal@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-ide@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] dt-bindings: ata: ahci-da850: Convert to dtschema
Date: Wed, 27 Mar 2024 12:13:51 +0530
Message-ID: <20240327064354.17384-1-animeshagarwal28@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the ahci-da850 bindings to DT schema.

Signed-off-by: Animesh Agarwal <animeshagarwal28@gmail.com>

---
Changes in v3:
- Fixed line length issue on line 20
- Removed unneccessary '|' character
Changes in v2:
- Added description for reg property items.
---
 .../devicetree/bindings/ata/ahci-da850.txt    | 18 ---------
 .../bindings/ata/ti,da850-ahci.yaml           | 39 +++++++++++++++++++
 2 files changed, 39 insertions(+), 18 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/ata/ahci-da850.txt
 create mode 100644 Documentation/devicetree/bindings/ata/ti,da850-ahci.yaml

diff --git a/Documentation/devicetree/bindings/ata/ahci-da850.txt b/Documentation/devicetree/bindings/ata/ahci-da850.txt
deleted file mode 100644
index 5f8193417725..000000000000
--- a/Documentation/devicetree/bindings/ata/ahci-da850.txt
+++ /dev/null
@@ -1,18 +0,0 @@
-Device tree binding for the TI DA850 AHCI SATA Controller
----------------------------------------------------------
-
-Required properties:
-  - compatible: must be "ti,da850-ahci"
-  - reg: physical base addresses and sizes of the two register regions
-         used by the controller: the register map as defined by the
-         AHCI 1.1 standard and the Power Down Control Register (PWRDN)
-         for enabling/disabling the SATA clock receiver
-  - interrupts: interrupt specifier (refer to the interrupt binding)
-
-Example:
-
-	sata: sata@218000 {
-		compatible = "ti,da850-ahci";
-		reg = <0x218000 0x2000>, <0x22c018 0x4>;
-		interrupts = <67>;
-	};
diff --git a/Documentation/devicetree/bindings/ata/ti,da850-ahci.yaml b/Documentation/devicetree/bindings/ata/ti,da850-ahci.yaml
new file mode 100644
index 000000000000..ce13c76bdffb
--- /dev/null
+++ b/Documentation/devicetree/bindings/ata/ti,da850-ahci.yaml
@@ -0,0 +1,39 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/ata/ti,da850-ahci.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: TI DA850 AHCI SATA Controller
+
+maintainers:
+  - Animesh Agarwal <animeshagarwal28@gmail.com>
+
+properties:
+  compatible:
+    const: ti,da850-ahci
+
+  reg:
+    items:
+      - description: Address and size of the register map as defined by the AHCI 1.1 standard.
+      - description:
+          Address and size of Power Down Control Register (PWRDN) for enabling/disabling the SATA clock
+          receiver.
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    sata@218000 {
+        compatible = "ti,da850-ahci";
+        reg = <0x218000 0x2000>, <0x22c018 0x4>;
+        interrupts = <67>;
+    };
-- 
2.44.0


