Return-Path: <linux-kernel+bounces-150498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 891398AA02B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 18:35:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28D221F23104
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 16:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D751175548;
	Thu, 18 Apr 2024 16:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NEU7qUKc"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122A0174ECA;
	Thu, 18 Apr 2024 16:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713458056; cv=none; b=LhTLabAAX8Dmtutrg2crHYejp9cYvUolHBAVARmdW8ffG/ooZHfJwfOgoLlzI3kZzSw1SylIk/NnhM+rXBJ2aN0par88ZUC789HLZmWCDcYBVL1JJHFowR56FSKjcXIYEcfT47N4P2uYDrJThrGKsho+3ljtv7q0VZ5zkv/1fcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713458056; c=relaxed/simple;
	bh=u/EmtiRaLybzXhqOhz8n8iP61f2w08tm7qMXyf9XZxA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aGtOcqgB1dsJJ+Jer1lTSu4z5u7K9eMgZ60arC3VjNzXFCQARgJx70c1o1GFfLFKefY2yMyhT2efjsDT7i94AZlWDFWeQ94GONCXC+3rG23yZq0WiUGfty01MxHzC5zdTjAhmzg8wHVi5E8l7AnZUOyJYcqmlj9lZ+bXt5EJB8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NEU7qUKc; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1e40042c13eso8827315ad.2;
        Thu, 18 Apr 2024 09:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713458054; x=1714062854; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6g4LCoPE+ljeoLvZRIiB0MJO/6AQkzVDaqR+XYwNS0Y=;
        b=NEU7qUKc12nty1GIEHRyy8d8d9akSOmFcXQ62bQ9IA2PpQpzkAq5FAWIcx4rhZRb2G
         BzKfBie8fXdsqS+fsrOX1xxwUCXgUNbMAKN6+uE/cHS2xHFYHShN4TaQCn47MpXzzxB3
         fqd2wUT5mcnUxxy/MQb/ZmxyjMV1MDAIMn6hWR6t5qdUl+N4gvrAj4Qc5+37uoIh95kK
         xKn0k3bBmPy2nFXabw2msW/u0ZPw6+cOuSdBFf/PdSRRI3IjdpzdQnqTyRfr1Ps2kMlE
         6In8UIbfQCS8oOgSlXKsVtlEueK2MvvUxWd3ANZHrffHw7aMr+R5y5uFIODHrMw9t9Py
         qkag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713458054; x=1714062854;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6g4LCoPE+ljeoLvZRIiB0MJO/6AQkzVDaqR+XYwNS0Y=;
        b=BTky0pzDcwZH/mrvAkqYgwkeul8y0QXyzDf90/TJfnN0vRtXImgYLS+HnXczUyHDO0
         x475fxjKxsYbpiNytf31s/xIMFPteuLNFJ50NDtbh+4CYeYAWDoeQT4we3cUTSnYtUP9
         ut33szC0sYl3DvG82Eiou3FZSDj+4uR4cyoFGvLrxcPzR1vFM0Y+8aN81vN96t9Z8pz8
         9d3AlUkunBSDpcGS1MYR+cYrkqQ6DecLfvmHcVoKIjsPjJFGX2Oh4to3zrE5jx+w6iyR
         3m0nFEA5GNABdk2UcKRPNI649i9mbGuX7c00CPx9vX5PZP4s1r2Yve93lOz3o2+KDSha
         R9Jw==
X-Forwarded-Encrypted: i=1; AJvYcCX6tVco+Cw2RzbODK3vM/lOvoaSZHOgbLhZRIkMSO77krmrR7gpQ+46N9sJ62K5Cp1+SJ7rIDL/Cgy59G+bf9H8IWmNVN16uebiM678bXj2Ns3g98u+HEIlnAScHh7jDEq0DIa5lBL58OB1DdQc4P7+mE8NdLCVZPbFvSwkiqlviy6eRKlOw4ngvuauZ9DY+BXYrpzsTnwooC4CP94njIAMVlw=
X-Gm-Message-State: AOJu0YyMQLwav1HgJp7bT7arE4mE6mND1BK17QgRhsEs6OAuo5Jakmlb
	YnAK32nx7IIzqG9we2S9s5axPg0H8HcMCcvsSlL8OPappCXDYcH6
X-Google-Smtp-Source: AGHT+IFChv3YgQYETC4JqyameENL27arMYPIiHxYKM/mHw2RlWtdkWXAExJxuP/XnmMazmxvZhG8hQ==
X-Received: by 2002:a17:903:24c:b0:1e3:e1c4:eaf3 with SMTP id j12-20020a170903024c00b001e3e1c4eaf3mr3765416plh.43.1713458054185;
        Thu, 18 Apr 2024 09:34:14 -0700 (PDT)
Received: from localhost (ec2-3-111-32-5.ap-south-1.compute.amazonaws.com. [3.111.32.5])
        by smtp.gmail.com with UTF8SMTPSA id kh3-20020a170903064300b001e48565b40csm1721343plb.210.2024.04.18.09.34.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Apr 2024 09:34:13 -0700 (PDT)
From: Mohammad Shehar Yaar Tausif <sheharyaar48@gmail.com>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>
Cc: Mohammad Shehar Yaar Tausif <sheharyaar48@gmail.com>,
	Thierry Reding <treding@nvidia.com>,
	linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: dt-bindings: tegra20-das: Convert to schema
Date: Thu, 18 Apr 2024 22:03:24 +0530
Message-ID: <20240418163326.58365-1-sheharyaar48@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert NVIDIA Tegra20 DAS (Digital Audio Switch) binding to schema.

Signed-off-by: Mohammad Shehar Yaar Tausif <sheharyaar48@gmail.com>
---
 .../bindings/sound/nvidia,tegra20-das.txt     | 12 -------
 .../bindings/sound/nvidia,tegra20-das.yaml    | 36 +++++++++++++++++++
 2 files changed, 36 insertions(+), 12 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/nvidia,tegra20-das.txt
 create mode 100644 Documentation/devicetree/bindings/sound/nvidia,tegra20-das.yaml

diff --git a/Documentation/devicetree/bindings/sound/nvidia,tegra20-das.txt b/Documentation/devicetree/bindings/sound/nvidia,tegra20-das.txt
deleted file mode 100644
index 6de3a7ee4efb..000000000000
--- a/Documentation/devicetree/bindings/sound/nvidia,tegra20-das.txt
+++ /dev/null
@@ -1,12 +0,0 @@
-NVIDIA Tegra 20 DAS (Digital Audio Switch) controller
-
-Required properties:
-- compatible : "nvidia,tegra20-das"
-- reg : Should contain DAS registers location and length
-
-Example:
-
-das@70000c00 {
-	compatible = "nvidia,tegra20-das";
-	reg = <0x70000c00 0x80>;
-};
diff --git a/Documentation/devicetree/bindings/sound/nvidia,tegra20-das.yaml b/Documentation/devicetree/bindings/sound/nvidia,tegra20-das.yaml
new file mode 100644
index 000000000000..44c5ce8ee6be
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/nvidia,tegra20-das.yaml
@@ -0,0 +1,36 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/nvidia,tegra20-das.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NVIDIA Tegra 20 DAS (Digital Audio Switch) controller
+
+maintainers:
+  - Thierry Reding <treding@nvidia.com>
+  - Jon Hunter <jonathanh@nvidia.com>
+
+properties:
+  compatible:
+    const: nvidia,tegra20-das
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    bus {
+        #address-cells = <1>;
+        #size-cells = <1>;
+        das@70000c00 {
+            compatible = "nvidia,tegra20-das";
+            reg = <0x70000c00 0x80>;
+        };
+    };
+...
-- 
2.44.0


