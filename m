Return-Path: <linux-kernel+bounces-8494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24D4781B8A7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 14:49:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A02B1B216CE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 13:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6593379472;
	Thu, 21 Dec 2023 13:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gal0+Fue"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849B278E8D;
	Thu, 21 Dec 2023 13:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1d3ea5cc137so6652525ad.0;
        Thu, 21 Dec 2023 05:32:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703165525; x=1703770325; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0cUg/+vllJugO46aB+P68E/fubJZERqebixXBfi33xg=;
        b=Gal0+FueLsZuUqsXNVXFg44cz7w2Nzk8PZsaJeCJtNUHe2n85X6JScpYWDuSevLiQJ
         O1XqNgAtPS5tIuG8q+wvOGRZX/ymRVVNFu/p2ePr+5MxK5OiuOjnWk57bhgWDlRAo+Hj
         te+mgr7C88z0rx+rSkCg6juuk8vPBlKxfp8CAln1UVj2oWNUinRJ7ZG9E5QdliItodUE
         nMud9TisiKT+2fzZWb7DSLPItCXoG5Nt6bCncBdcXMiTKsLw58WU7ZlyPdayMcZPvjpT
         5lEnUaae07LdH7m1lBbaeQRh2m9Om6V1VGGPLQWoXt2pVh6gG1Vxi9xE6i/OmCEzTZii
         w1XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703165525; x=1703770325;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0cUg/+vllJugO46aB+P68E/fubJZERqebixXBfi33xg=;
        b=uLqGnfR5LYZsHOjHfvbY5mpqbO9Mh8pxDXZY56KX2V9LG1iSSTq68SL3mQmTFVL+aT
         zsRT8nwOatzVPd/UsqLgTGCDltDK0vJTZUPEjoBEoXcbsKA6pyJSUkCVuPJ4J0vgz+ZL
         0vtNLztXUNZdLjXZ2msUAvw42VHhSvnjIC4MAQFVH37fk9CxcZf/L2O7ziK+XuUsRqDe
         osJ14XVR+gdAjVhomwHIO1JwBCeUerV3BeMb70mBGOofXYfjqQEp0nBqAAn6f8Sgyvzr
         dq21LUedn8MEeKJm1FK2tWzorOQwHTkH6sUmTBsZol8PXeUzTokW28aBeZH5HZ4OxnZP
         QfDQ==
X-Gm-Message-State: AOJu0YwsqVbktWxvwZ4QvOGoNXz6RuX1IBO41tueDkP5GGHiPgvBPBR2
	bF1wyRFMhgL4xFd8IKO18kI=
X-Google-Smtp-Source: AGHT+IFhtu5fXogwjXDEVQEkWCRtPR28aCpniwfyI/gGUy8Zhl+6rVd9AegUxMf+5qrVTjHA8TkXuw==
X-Received: by 2002:a17:903:246:b0:1d3:bc96:6c13 with SMTP id j6-20020a170903024600b001d3bc966c13mr8617784plh.35.1703165524863;
        Thu, 21 Dec 2023 05:32:04 -0800 (PST)
Received: from ruipeng-ThinkCentre-M730e-N010.company.local (014136220210.static.ctinets.com. [14.136.220.210])
        by smtp.gmail.com with ESMTPSA id k1-20020a170902ba8100b001d2ed17751asm1601624pls.261.2023.12.21.05.32.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 05:32:04 -0800 (PST)
From: Ruipeng Qi <ruipengqi7@gmail.com>
To: robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org
Cc: qiruipeng@lixiang.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 4/7] dt-bindings: reserved-memory: Support osdump module
Date: Thu, 21 Dec 2023 21:31:58 +0800
Message-Id: <20231221133158.729-1-ruipengqi7@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

From: qiruipeng <qiruipeng@lixiang.com>

Add bindings to allow osdump module to store dump in reserved-memory
region named "osdump".

Signed-off-by: qiruipeng <qiruipeng@lixiang.com>
---
 .../bindings/reserved-memory/osdump.yaml      | 45 +++++++++++++++++++
 1 file changed, 45 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reserved-memory/osdump.yaml

diff --git a/Documentation/devicetree/bindings/reserved-memory/osdump.yaml b/Documentation/devicetree/bindings/reserved-memory/osdump.yaml
new file mode 100644
index 000000000000..149bf0204e68
--- /dev/null
+++ b/Documentation/devicetree/bindings/reserved-memory/osdump.yaml
@@ -0,0 +1,45 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/reserved-memory/osdump.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: OS minidump module
+
+description: |
+  Specifies that the reserved memory region can be used for OS minidump
+  module.
+
+  The "osdump" node is named after the "OS minidump" module which
+  provides an implementation of a new crash dumping solutionin in Linux.
+
+maintainers:
+  - Ruipeng Qi <ruipengqi7@gmail.com>
+
+allOf:
+  - $ref: reserved-memory.yaml
+
+properties:
+  compatible:
+    const: osdump
+
+  reg:
+    description: region of memory that can be used for OS minidump module
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    reserved-memory {
+        #address-cells = <1>;
+        #size-cells = <1>;
+
+        osdump: osdump@64000000 {
+            compatible = "osdump";
+            reg = <0x64000000 0x01000000>;
+        };
+    };
-- 
2.17.1


