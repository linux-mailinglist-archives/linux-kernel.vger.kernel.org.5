Return-Path: <linux-kernel+bounces-88676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCEF486E521
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 17:18:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49AEB1F25B73
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 16:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2439C70CB8;
	Fri,  1 Mar 2024 16:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iXsCr0Y5"
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00CD03AC01;
	Fri,  1 Mar 2024 16:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709309872; cv=none; b=B8IpaL+xCwWuQ/3RvV6vUsDRn6wSdwVj7kpH4+q33TA7kMoLMwQgauvpShKSFbRipI5SNB7aKEwMwHmdJgVs3LLXHASPWU7PnZomRGcC9R5gyfI7ps5liGeik3bHGuIcUdbhE+bM/1KPKHxlKYiCO9uJXFu5F6q10ZDeoNwYAnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709309872; c=relaxed/simple;
	bh=esq0zwaMOu8VQuNzVlU5wPmONfZBe34k1nLi8jMWftY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ALVzOZu3TK+Cm/pWADuPDMUWjNU/cVm2zO0BB7ZYYUIJv/aNL5oNMSPqt7dw3hWhm47nTQIXzI7URdvNNYil5BI7E6Gv5j0sTVyFycKKrT3I74FS41f0iaMtAElNClENNg8zLDtXEN1Oa1e6j+ifxNuXBe4bgNAH8NLugkgQcwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iXsCr0Y5; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3bd72353d9fso1307366b6e.3;
        Fri, 01 Mar 2024 08:17:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709309870; x=1709914670; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jnn8uRYmSKDUccKSblaeho39pxNSJMdFMW/v0CPtmDM=;
        b=iXsCr0Y5OyR7z5YkEXgnTgikB7s6LR+NcfyZqbsDtIHETPRUq/vMdguEn0EVAep/zk
         bxV/YvK7DRdEBiG3h7lH0eKvHzFOHiCJI+gB8ai+0wrfk4JsNhMUTitOvBPNCO7TbTXy
         lc+WPvrHC034CiMQDhMk40yt2DTJnEK176MAariN7tMIcVf/1SK8c0vv0KSjYHn409RD
         Kd2rLDXj8q7WFFrGwlELvXI2GffaJoNksRRwq+LpXFxB4kuXxkdWR2Tux3PBPTZWoShM
         qon/V43brjD8Tt01/MgR20ZFt71L4ACIMo9j/l/maZZ+O0VZOyhdA6Zio3ok4Zta+GlU
         tdgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709309870; x=1709914670;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jnn8uRYmSKDUccKSblaeho39pxNSJMdFMW/v0CPtmDM=;
        b=MSw+gWE4zxMOfryeJCUJ5jPZ9T26b6I6WVyWYDJ8SrQB4mzXW2wBbrNaSm9YEvuMkL
         9DXNQV764PKTqnx7QyU1xKcVm06eCcmsc/lMldmM80OBLcnjtducnqtVYBu+zidkLrgr
         p1AolhCa9bJULn/lQf4jg50b1Z5ge8qqshQ7EdOo+ooxlhKz1Ys5ScHvVxih1JD9YS6v
         WHj9tWqlF6CWBjzfzh6keqZsogR7v/odQ3XweTFVrXfEPZK1wc4qqdirnl6ns9mJT5yx
         YkV7gMkKgeXOx5o01X+tjMHGYB9RnIcaiFbWmfOKQluIgAvdWfjh1rnvRJEHA5s8B/hB
         mekg==
X-Forwarded-Encrypted: i=1; AJvYcCVTFKIr+IPhtrhXRmwouCBp1MB+ePY96vLWot3c+TN0FALYfLpwb1JPfrOUwWdazyygOTjjIscbWcCa6P1mMiyBUXVyybtP2i8c2FW0IMXyLjyMPni3gJ7xpV8GGGRRIB38hriq/tdNPzpBBWjSrrOf/JXmbfa1nShT3XGrbPSGpPdoUuM=
X-Gm-Message-State: AOJu0YxzxhXzE55V9O9kSAwpDv7k1Pe00h6WSmu4TSpYYzOg3z6VSxzt
	anGm6eiF1K2/xuwvqZuHNbZNcNgmoOtZvEwmIMyjm+N3NkQvznE1
X-Google-Smtp-Source: AGHT+IFrUFDb5dvOB/I1quK+RLrQ4EPU8c08ERozsrK7LGc2bxmLQn5mBDolgwAa+FN932VjdBuFZQ==
X-Received: by 2002:a05:6808:130d:b0:3c1:d169:b405 with SMTP id y13-20020a056808130d00b003c1d169b405mr2503573oiv.29.1709309869840;
        Fri, 01 Mar 2024 08:17:49 -0800 (PST)
Received: from localhost.localdomain ([2409:40f4:14:45f5:a762:7947:f54a:ac40])
        by smtp.googlemail.com with ESMTPSA id c2-20020a637242000000b005dc36279d6dsm3211067pgn.73.2024.03.01.08.17.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 08:17:49 -0800 (PST)
From: Animesh Agarwal <animeshagarwal28@gmail.com>
To: 
Cc: mdf@kernel.org,
	Animesh Agarwal <animeshagarwal28@gmail.com>,
	Wu Hao <hao.wu@intel.com>,
	Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-fpga@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: altera-fpga2sdram-bridge: Convert to dtschema
Date: Fri,  1 Mar 2024 21:46:43 +0530
Message-ID: <20240301161648.124859-1-animeshagarwal28@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the altera-fpga2sdram-bridge bindings to DT schema.

Signed-off-by: Animesh Agarwal <animeshagarwal28@gmail.com>
---
 .../fpga/altera-fpga2sdram-bridge.txt         | 13 -----------
 .../fpga/altera-fpga2sdram-bridge.yaml        | 23 +++++++++++++++++++
 2 files changed, 23 insertions(+), 13 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/fpga/altera-fpga2sdram-bridge.txt
 create mode 100644 Documentation/devicetree/bindings/fpga/altera-fpga2sdram-bridge.yaml

diff --git a/Documentation/devicetree/bindings/fpga/altera-fpga2sdram-bridge.txt b/Documentation/devicetree/bindings/fpga/altera-fpga2sdram-bridge.txt
deleted file mode 100644
index 5dd0ff0f7b4e..000000000000
--- a/Documentation/devicetree/bindings/fpga/altera-fpga2sdram-bridge.txt
+++ /dev/null
@@ -1,13 +0,0 @@
-Altera FPGA To SDRAM Bridge Driver
-
-Required properties:
-- compatible		: Should contain "altr,socfpga-fpga2sdram-bridge"
-
-See Documentation/devicetree/bindings/fpga/fpga-bridge.txt for generic bindings.
-
-Example:
-	fpga_bridge3: fpga-bridge@ffc25080 {
-		compatible = "altr,socfpga-fpga2sdram-bridge";
-		reg = <0xffc25080 0x4>;
-		bridge-enable = <0>;
-	};
diff --git a/Documentation/devicetree/bindings/fpga/altera-fpga2sdram-bridge.yaml b/Documentation/devicetree/bindings/fpga/altera-fpga2sdram-bridge.yaml
new file mode 100644
index 000000000000..88bf9e3151b6
--- /dev/null
+++ b/Documentation/devicetree/bindings/fpga/altera-fpga2sdram-bridge.yaml
@@ -0,0 +1,23 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/fpga/altr-fpga2sdram-bridge.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Altera FPGA To SDRAM Bridge Driver
+
+properties:
+  compatible:
+    enum:
+      - altr,socfpga-fpga2sdram-bridge
+
+required:
+  - compatible
+
+examples:
+  - |
+    fpga_bridge3: fpga-bridge@ffc25080 {
+        compatible = "altr,socfpga-fpga2sdram-bridge";
+        reg = <0xffc25080 0x4>;
+        bridge-enable = <0>;
+    };
-- 
2.44.0


