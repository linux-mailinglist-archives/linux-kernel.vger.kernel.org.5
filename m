Return-Path: <linux-kernel+bounces-97911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4D8F877184
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 14:48:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E673281C9C
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 13:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D09140867;
	Sat,  9 Mar 2024 13:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hTYbaf1W"
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8AEB3BBD4;
	Sat,  9 Mar 2024 13:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709992132; cv=none; b=gmEVjSytVzqJtigfOQvs/GRHP9YDsWamgS7U2ccMdNv4EJVcTnsds1I2FO4u28NV5xQtuPTO5+c9kZo0SF85wroWrRktboDfFb58aXvsuZMQeOKeTDa+xGjzUXAPN886R3H5Nh5gPC0XxKmVRp3tALb5snERs263cScE1gwf59w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709992132; c=relaxed/simple;
	bh=sp1H9xABh0PhXI5TeP2TNI+A7aphIh7I3mX3AuKQrww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=piEOyi+2I4VzVdMBVPnS91CZYSfuK1WiP8u9a/J7yQ7XMyiTtCv4SRjpY5MCZb3YNqX+/DK92nWtGOeZFMpSEcXOBKIEJDBN6NFcixWePS/02yVr2i0FV4tfTL4mhheu3QlyGn29uRzT6FzfNFuxwD62YrGre9BeB5FrmsGft0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hTYbaf1W; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-36576b35951so15710125ab.3;
        Sat, 09 Mar 2024 05:48:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709992130; x=1710596930; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ReBWmNQbcmPGLbzSYkOMNsFbfoSFa/F5yoxWz0JB9mA=;
        b=hTYbaf1WgYzxtCnHkXQ3ajcAxz1G9dC6mlv/c9E/+kqq7YM2rJ5Hjc0lJ2i7cp5xCQ
         +fT48ik6Q0dqpldEPeHqRg4VCHvTKP5pRkrQBhPg/kgdiG+sT7pkMGqexml+lC9/OhJ2
         dYuh+Ka7fQUosyfwRpXb5k90dOMKBKEub7M+XJFToRvbAhUCatnhBOctkYo5QpNm1MaV
         frId9//0kxbv5m0DJxSUeywiK4iM/jBtJOFg2JlpvPK/PDxz4wQb/66i5bpeh9v4YwVO
         j8JChARU4J/rTpJ4t4r8pNBq7OQ5BJ5V1QCgczT/iISrZJthj057ct100jCaUI8Y55Jm
         iqRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709992130; x=1710596930;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ReBWmNQbcmPGLbzSYkOMNsFbfoSFa/F5yoxWz0JB9mA=;
        b=IY29EpeFxdEDP7qvsxqZa/QE8x7+BQ/D6WjJ6sAqucGb8mDWrwtW4haXDH6y9lQeqk
         a9QG8IdPLv5t2SYm+5K8o5XcDKO+a5Kb/gILwOzMNMd3BTShF4gX05ubPCG/uDey/y3T
         3ONoUML3+Qt91+RmjeD1IfwxRKNhVdJFqdJKHhjSzCR+hhKnia6WjNPrTCaU7UUvGiYB
         c6Qnx4DNoWKJuVQfhSEa/aKstKm5RwYLKT/fP7/OoegDnDtL8lBssBrruwNnr9P3CDMl
         K1YtPJX9ju7kX5iEtOwf/PJ4vvbC1AyMaPfU5XZ1Z0Owlv+ai9EadPc2tKRJey9InSro
         ewgg==
X-Forwarded-Encrypted: i=1; AJvYcCWkIhi96oTb9j7BUwbMC26prED43Sncqmu2AwFTC0MitcNMAj7lO96DUAa6ZtSmm1O2gvX2Psx72r4uB5O9G9FFrWIZueTjjfHnbFlefu6kG/yIevnNgWiULloRW/Owr5w91swUWkP37Y41WDmhOTFF2GJYfxbyGlFOBWrFjAuSfvThbg==
X-Gm-Message-State: AOJu0YySLGyTwA2rmGwhtCjgEePZBcfN4mbm0RA4J36v3gYEZrhKSMCR
	G9efXeXNTfh6tUYEz3kubyOWvHjwT21orGCCu63vSd6uLNFTfF1N
X-Google-Smtp-Source: AGHT+IHUKDB4JmITt5SpvbuRsEk8boctsCoSc0OnmQYn0lJa2GvGUhf+K1ng2a5tsJyfL4N1BqLFZg==
X-Received: by 2002:a05:6e02:214d:b0:365:69a:86b2 with SMTP id d13-20020a056e02214d00b00365069a86b2mr2636951ilv.17.1709992129946;
        Sat, 09 Mar 2024 05:48:49 -0800 (PST)
Received: from fedora.. ([2409:40f4:3a:d8ab:6980:be5b:99c3:fb12])
        by smtp.gmail.com with ESMTPSA id r7-20020aa79887000000b006e5e93e7854sm1251485pfl.151.2024.03.09.05.48.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Mar 2024 05:48:49 -0800 (PST)
From: Animesh <animeshagarwal28@gmail.com>
To: 
Cc: dlemoal@kernel.org,
	Animesh <animeshagarwal28@gmail.com>,
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
Subject: [PATCH v2] dt-bindings: imx-pata: Convert to dtschema
Date: Sat,  9 Mar 2024 19:18:07 +0530
Message-ID: <20240309134810.352428-1-animeshagarwal28@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <81e42a64-03c5-4372-914d-9f2df517dcf7@linaro.org>
References: <81e42a64-03c5-4372-914d-9f2df517dcf7@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the imx-pata bindings to DT schema.

Signed-off-by: Animesh <animeshagarwal28@gmail.com>
---
 .../devicetree/bindings/ata/fsl,imx-pata.yaml | 38 +++++++++++++++++++
 .../devicetree/bindings/ata/imx-pata.txt      | 16 --------
 2 files changed, 38 insertions(+), 16 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/ata/fsl,imx-pata.yaml
 delete mode 100644 Documentation/devicetree/bindings/ata/imx-pata.txt

diff --git a/Documentation/devicetree/bindings/ata/fsl,imx-pata.yaml b/Documentation/devicetree/bindings/ata/fsl,imx-pata.yaml
new file mode 100644
index 000000000000..ee7892bf963b
--- /dev/null
+++ b/Documentation/devicetree/bindings/ata/fsl,imx-pata.yaml
@@ -0,0 +1,38 @@
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
+    contains:
+      const: fsl,imx27-pata
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


