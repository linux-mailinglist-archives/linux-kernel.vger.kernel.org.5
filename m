Return-Path: <linux-kernel+bounces-88862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 865DC86E7AD
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 18:48:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07919283AB1
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 17:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AF3E1CA98;
	Fri,  1 Mar 2024 17:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XBGd3eSe"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A32538DE7;
	Fri,  1 Mar 2024 17:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709315275; cv=none; b=m33KxoYlKc6QNDVeA4+I+WMFKJYgMQoQn97U49fiXW1cgBJ8zgY2mD6Ji1I5jXTJU9UuLjaNr0D6KdYC3oJy1/qH1CNz1UZcF6PJT8Ot2JkuIjAJdLgl6Ay2o6KiJ0vf4PDMwtqcO9mDO1XS4HDloBZXzZaVZEpGrVAVCRVTZhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709315275; c=relaxed/simple;
	bh=K8c2wBorxqggjEKYwjSzH32E/7kyU6uSehkmDr1/e8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z4OUYUk06sb6b4/iTNaMnDGEItxVX0CHaQHKfjePQ7JPAUxMtecpNarpmpHGUhPsV6YC/iwMOKC8b5O7khHtvS6VBCPpqKCQwDEzn0D2zv7Iu+Pf6dBt7OsGzXv0pBQd+4GyY5VhBkmdSZdV2M2+NIe4r9XmSmV6iHZF0Kc/RSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XBGd3eSe; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1dca3951ad9so22259285ad.3;
        Fri, 01 Mar 2024 09:47:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709315273; x=1709920073; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=t5K43xaydVTO1PuV43+YCPcsWOpQXQNoMQ4Cz9/+c2w=;
        b=XBGd3eSeEQfecxYV0Bw+Qk64LZTb2jVzv2sKQF5ZukUuNzmxlhZKZ0md4p8jIg/01v
         bb0nPSoCg6kLh8+fUUkNbnyA+ABtCEiDJNc0RHuMmm3JfCwzSmR7eCP+YFgUMBzdJVos
         V9WWQVdTAFTsYUu3eeHmdeRC/UhdV9vFfWEltYk9vonExN7FqTySyM5xRzoWwCH5HiLu
         vQEO1AiVxG5Kwk3CAd4voOVnkcczaRc2BPXNoxUXaJRry54P0JYfgAdfclFIhBS1VC6W
         rlz/jzFZmeEjry0aWSy6uX8TE2rBT1DHr5V0ZkTB1YNEU3nownUrdyg5qRSJPcybBPxG
         VbHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709315273; x=1709920073;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t5K43xaydVTO1PuV43+YCPcsWOpQXQNoMQ4Cz9/+c2w=;
        b=rwyNR9C24XIRaVor5sdMKHe8/Fr7iqa0RvuoIle3u7vSkeOBD/6Z0Rp4eczt48TxlV
         Fnvjit9QNaGVk6+rxOB3o9GL5zD9ZZlaPyTZvu8psi3Fr1O9HYb51H7ck0ppdEYDeeeH
         bUigfQOmkbDt5KLBdME0LmLrk4ea32KiGq2OlxZiEuZGy2G9FZ3zGnrwRVSSTKzIB8lR
         nqQbAZ9e9A0+Oc6d90r/NSmQsci8cq5or8LZDyTtBJzbUutsBW1pipynn0QrnWDWhR40
         Hn7vWbgN6PxKo3toXRAStdtTGfhmaoawV1JfztPxLPYcuJF/oyAL/u6dEXbqgYfvWqYT
         ko/g==
X-Forwarded-Encrypted: i=1; AJvYcCXnD79C0gpuSat/o5iZtHNrAoZpsXvkKskwgpkeKLqAAfWGsTx2o/0u19v6X76bP3sXyUmYl+PKvtbh5pD0+oG6WyvUnGjqN6dSdTxsO3pHNmAZOGLa21YowjL7XbP9UuOBi+2+e9ViQ61LNfw4oHLKUWqG344NEch81Cq+5dAJWHFI7g==
X-Gm-Message-State: AOJu0YzFMeST/hPK3quGIlDI0D9/LOCVvNEMycKUch5PZnPCKwl3ovvq
	khOZO9ROb7p4yr81CDY+NFhXNGoqDaX/qJQwETLVUVXklbWVuZxm
X-Google-Smtp-Source: AGHT+IF1CHMaxJVofw46VYsGcVxC3/eoKJaOwO77Vy/Fjpjn1DtXabpklwX0BKS+jltF5s4dQFC7fQ==
X-Received: by 2002:a17:903:2445:b0:1dc:afff:9f96 with SMTP id l5-20020a170903244500b001dcafff9f96mr2762237pls.44.1709315273558;
        Fri, 01 Mar 2024 09:47:53 -0800 (PST)
Received: from localhost.localdomain ([2409:40f4:24:c27e:10bb:63fc:b695:4c40])
        by smtp.googlemail.com with ESMTPSA id x6-20020a170902a38600b001db86c48221sm3796974pla.22.2024.03.01.09.47.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 09:47:53 -0800 (PST)
From: Animesh Agarwal <animeshagarwal28@gmail.com>
To: 
Cc: dlemoal@kernel.org,
	Animesh Agarwal <animeshagarwal28@gmail.com>,
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
Subject: [PATCH] dt-bindings: imx-pata: Convert to dtschema
Date: Fri,  1 Mar 2024 23:17:21 +0530
Message-ID: <20240301174729.238869-1-animeshagarwal28@gmail.com>
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
 .../devicetree/bindings/ata/imx-pata.txt      | 16 ---------
 .../devicetree/bindings/ata/imx-pata.yaml     | 34 +++++++++++++++++++
 2 files changed, 34 insertions(+), 16 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/ata/imx-pata.txt
 create mode 100644 Documentation/devicetree/bindings/ata/imx-pata.yaml

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
diff --git a/Documentation/devicetree/bindings/ata/imx-pata.yaml b/Documentation/devicetree/bindings/ata/imx-pata.yaml
new file mode 100644
index 000000000000..78a562587fb5
--- /dev/null
+++ b/Documentation/devicetree/bindings/ata/imx-pata.yaml
@@ -0,0 +1,34 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/ata/imx-pata.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Freescale i.MX PATA Controller
+
+maintainers:
+  - Animesh Agarwal <animeshagarwal28@gmail.com>
+
+properties:
+  compatible: 
+    enum:
+      - fsl,imx27
+  reg:
+    maxItems: 1
+  interrupts:
+    items:
+      - description: PATA Controller interrupts
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
-- 
2.44.0


