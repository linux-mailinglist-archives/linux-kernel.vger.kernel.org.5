Return-Path: <linux-kernel+bounces-13013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A47A981FE70
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 10:07:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37AF2B220F6
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 09:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 397E010A3E;
	Fri, 29 Dec 2023 09:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HBVz/1lK"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5816910A18;
	Fri, 29 Dec 2023 09:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1d3eb299e2eso31698685ad.2;
        Fri, 29 Dec 2023 01:06:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703840811; x=1704445611; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wqLn3CmpBkHp0Ow/2hdH0XpO/heL7ml3rbUZvxmCYqU=;
        b=HBVz/1lKpnS43vs1TgtZ2jE/HzvHla/+FlOXD2KoBqB7t8rEiUhA9P8kj1BXR+mP3n
         Ebb2eEDWAYlz7xo7UGjOe1HAs6LSPJfzP5yo7NGofQDQKdax3MxCkvJIyg8x0fAu0hWW
         EOycgJripHKX86FFxOluzkRNCCOEdl3hkHbKdGOFLTSkeYeNfGnDhTXuBzvHbtuECRd3
         wXi4QhHww20fTi+wrHZZXd+3VLgJV5b2cWrbsEnB94ZrLg+Hh2RgkmrvKeMdnxD6rkHK
         bpKWb0JHw47+/TUHhQAyNkXD4n5g+1PsAgqc7q+0vx7jwS4GMs2cKEJkouMjNiBvnTqe
         p+/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703840811; x=1704445611;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wqLn3CmpBkHp0Ow/2hdH0XpO/heL7ml3rbUZvxmCYqU=;
        b=C02SoMCF0ajIbO5H7PqfWI4Cg98fsp81ekq/MNNxmfQ6z02Vp0mw0iBxcixgCmW/eO
         zs38WTyAwtbHCiOA+TD7+220+wWwiI3FY0sYS1qqcdmf7EnJwjH+KJQihQTkU3V71GMy
         p+WrT5VY5tVy6dnOA9J9CqlnLZzUyJLGwh7K06wNAOjCjOLeuKWhbRX+1SC5y0veLdyX
         f9GvuVRexZCoip2xcRzvdXBz9BSTcaLNldGjrk2OUKF0sEkPYS7w/YFV5/BHiyJ5roiW
         7O5AaBX62rz8er/JR7Y4XUI9+yzhayn7m9JtHJgfA4EelmIwjfB7V7no2i+SULW9ZXq0
         ijmw==
X-Gm-Message-State: AOJu0Yxp1K7IbXOPYLrF31ZhvSCQZmvHDIX+mDOvD36/E/FUYq0BWEs8
	1AluZbcHYlTVHOysnOC9m/A=
X-Google-Smtp-Source: AGHT+IGok63pjigKRiqqzSkGkPj6/SH1ymCAw68D/rFbpRQspGbAIriMSwmmOxJZdwU0voHulh1cww==
X-Received: by 2002:a17:902:e888:b0:1d4:2c93:39cf with SMTP id w8-20020a170902e88800b001d42c9339cfmr5738858plg.100.1703840810500;
        Fri, 29 Dec 2023 01:06:50 -0800 (PST)
Received: from localhost ([46.3.240.107])
        by smtp.gmail.com with ESMTPSA id z3-20020a170902ee0300b001d3e3a86dccsm15147424plb.84.2023.12.29.01.06.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Dec 2023 01:06:50 -0800 (PST)
From: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
To: a.zummo@towertech.it,
	alexandre.belloni@bootlin.com,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu
Cc: linux-rtc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dlan@gentoo.org,
	inochiama@outlook.com,
	Jingbao Qiu <qiujingbao.dlmu@gmail.com>
Subject: [PATCH v1 1/3] dt-bindings: rtc: sophgo: add RTC for Sophgo CV1800 series SoC.
Date: Fri, 29 Dec 2023 17:06:41 +0800
Message-Id: <20231229090643.116575-2-qiujingbao.dlmu@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231229090643.116575-1-qiujingbao.dlmu@gmail.com>
References: <20231229090643.116575-1-qiujingbao.dlmu@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add devicetree binding to describe the RTC for Sophgo CV1800 SoC.

Signed-off-by: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
---
This patch depends on the clk driver
Clk driver link:
https://lore.kernel.org/all/IA1PR20MB49539CDAD9A268CBF6CA184BBB9FA@IA1PR20MB4953.namprd20.prod.outlook.com/

 .../bindings/rtc/sophgo,cv1800-rtc.yaml       | 40 +++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/sophgo,cv1800-rtc.yaml

diff --git a/Documentation/devicetree/bindings/rtc/sophgo,cv1800-rtc.yaml b/Documentation/devicetree/bindings/rtc/sophgo,cv1800-rtc.yaml
new file mode 100644
index 000000000000..595d3289b183
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/sophgo,cv1800-rtc.yaml
@@ -0,0 +1,40 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/rtc/sophgo,cv1800-rtc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Real Time Clock of the Sophgo CV1800 SoC
+
+maintainers:
+  - Jingbao Qiu <qiujingbao.dlmu@gmail.com>
+
+allOf:
+  - $ref: rtc.yaml#
+
+properties:
+  compatible:
+    const: sophgo,cv1800-rtc
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+required:
+  - compatible
+  - interrupts
+  - clocks
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    rtc {
+      compatible = "sophgo,cv1800-rtc";
+      interrupts = <17 IRQ_TYPE_LEVEL_HIGH>;
+      clocks = <&clk 15>;
+    };
-- 
2.25.1


