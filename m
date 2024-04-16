Return-Path: <linux-kernel+bounces-146570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBBB58A676E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 11:50:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE8441C21573
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 09:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29A9586264;
	Tue, 16 Apr 2024 09:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="evP/gDb2"
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E6D85955;
	Tue, 16 Apr 2024 09:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713261050; cv=none; b=CxL+tkXUeLzhBL1jNCwnlxjaTh1UIcr1L6UNSFVEmPassN0hhDDaxnPR/AQrWJUOZy3oq3oagyt+YgW6OqnQXRcW+q+Pw6cg8AYpqCHK6/kpKppIMcFarrK6Ib7pmVfGcezC8hOkDtsP1hhJj0cN3kXP2oteQdc19dswnPnak8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713261050; c=relaxed/simple;
	bh=rJxuOVYfhO9valRP+XblmWf6WsATk4XWKvDb25yDuq4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IqvTYghbv5oyrtHMEpLk/wFYYQXF7WYf/5SxjDLFHdOIzzAOsJm2J9hsO9QyZFdGcTmocFZFbKdbF2AlV0UG0jRZMklZg59haFfrUNtu6aMwcky4KZAKBO3mK74z5tbbBWgCDmRXV4ogw26LD/6YSofjKsAyaN3/0MOYzdDbeoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=evP/gDb2; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5ac61cf3fffso2645248eaf.3;
        Tue, 16 Apr 2024 02:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713261048; x=1713865848; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2p5OSXn24EKOZqy7EDcmeeMFADHFv6owcaxiqAYNSKE=;
        b=evP/gDb2dPp8mxu8Jr87ApP5rOtxK1zk21mCHV/MDGrY+e02hH7N9Ohgy5hZT39b13
         KunENNtB1wdCi3az91hnaCnn/6rh0SRr3N//mgleasgARkg3Qtj/Irf1GAeMOephMBH5
         8bmaAkGsHvCpAnEEHofAoS+n9Rt7Ik+HMagG24nQzWNuZudR4Q7y0nnPkQYB3TS/FCz6
         mqdLlsD43qfizGlNZG4outBZsPqMsqIuOloIshyp+I5Xhd3dAWTsL9YNugk4JUcpUkrB
         7mk6g3BnOhKahru7i6rNX2RZVVWDo18OjtUy/JH5319f1q5wSsEEE44seLus3xGQgi94
         A5EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713261048; x=1713865848;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2p5OSXn24EKOZqy7EDcmeeMFADHFv6owcaxiqAYNSKE=;
        b=DPrxpWCs79JuS92UFLD98h3a87cVaC0Lc4eyJ7UdpepmsUfqJu1zQMMl8RzCkJypCT
         C/oTj7IPl4Qp1o8ILwu0dn5EQBP4WsVy6n4I9eZPZ0FbI1MqU0MMi6en3pf0FkP/F6UW
         8+DFHB3TA29PRMC2VhmjcHRfhd8GejqN5w3kW3E1COkkqTDggg5FnM85pTw6yiJjT0Kx
         Tsrv5gLfyLN5PohdWXzIkADZMoz8ePM96sQs0FlBxQ4MERiKolPda2H5p/x/ZVTSNQCx
         4pIPDq1wZQWfKxDkJr+9g4A0gWEY8hxv9RjC2f9LOflGtPwMSJGZdkKMxGds9ss15Nny
         SqKQ==
X-Forwarded-Encrypted: i=1; AJvYcCVOG17db3zld3Abglr6B2/mmfT6qI2E3PSKSqUBR+JcXo2bG1p23CIi3AhL84jT3BtTIQkHNPOAS8mxUL0WGtat+bz/ZWhx0p44EQCxjg7d+fk1JD98p9AnZzawWdAZq+Qx2S/aC4kxEU6ulrFppV7t/3VSLkNmoS+1h/5xuCv874rRQw==
X-Gm-Message-State: AOJu0YxkkGjL90pZDZ4haxtQXzi/TdiWHYCk+bHTab1mcGUL6jmSufY1
	xgFLrkDGu6qiW2OprFfPoIh5BYTZlz2QSrSt9LyXNIElP96N+wJ2
X-Google-Smtp-Source: AGHT+IGUJuaKo6/23XXIC/onjoXbCFQXGz0jHnqblFr3WK+l8O/XfNWE2Bm+VrI66kMAcwyD+8R2Ew==
X-Received: by 2002:a05:6820:217:b0:5aa:6a1f:f673 with SMTP id bw23-20020a056820021700b005aa6a1ff673mr13329923oob.1.1713261047983;
        Tue, 16 Apr 2024 02:50:47 -0700 (PDT)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id dc6-20020a056820278600b005a796851f5bsm2458798oob.35.2024.04.16.02.50.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 02:50:47 -0700 (PDT)
From: Chen Wang <unicornxw@gmail.com>
To: adrian.hunter@intel.com,
	aou@eecs.berkeley.edu,
	conor+dt@kernel.org,
	guoren@kernel.org,
	inochiama@outlook.com,
	jszhang@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	palmer@dabbelt.com,
	paul.walmsley@sifive.com,
	robh@kernel.org,
	ulf.hansson@linaro.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	chao.wei@sophgo.com,
	haijiao.liu@sophgo.com,
	xiaoguang.xing@sophgo.com,
	tingzhu.wang@sophgo.com
Cc: Chen Wang <unicorn_wang@outlook.com>
Subject: [PATCH 1/3] dt-bindings: mmc: sdhci-of-dwcmhsc: Add Sophgo SG2042 support
Date: Tue, 16 Apr 2024 17:50:37 +0800
Message-Id: <032c06642b01f06c86ba8bcd2108d18c005b57eb.1713258948.git.unicorn_wang@outlook.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1713258948.git.unicorn_wang@outlook.com>
References: <cover.1713258948.git.unicorn_wang@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen Wang <unicorn_wang@outlook.com>

SG2042 use Synopsys dwcnshc IP for SD/eMMC controllers.

SG2042 defines 3 clocks for SD/eMMC controllers.
- AXI_EMMC/AXI_SD for aclk/hclk(Bus interface clocks in DWC_mshc)
  and blck(Core Base Clock in DWC_mshc), these 3 clocks share one
  source, so reuse existing "core".
- 100K_EMMC/100K_SD for cqetmclk(Timer clocks in DWC_mshc), so reuse
  existing "timer" which was added for rockchip specified.
- EMMC_100M/SD_100M for cclk(Card clocks in DWC_mshc), add new "card".

Adding some examples.

Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
---
 .../bindings/mmc/snps,dwcmshc-sdhci.yaml      | 67 ++++++++++++++-----
 1 file changed, 51 insertions(+), 16 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml b/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
index 4d3031d9965f..a04ccae216cf 100644
--- a/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
+++ b/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
@@ -21,6 +21,7 @@ properties:
       - snps,dwcmshc-sdhci
       - sophgo,cv1800b-dwcmshc
       - sophgo,sg2002-dwcmshc
+      - sophgo,sg2042-dwcmshc
       - thead,th1520-dwcmshc
 
   reg:
@@ -30,23 +31,36 @@ properties:
     maxItems: 1
 
   clocks:
-    minItems: 1
-    items:
-      - description: core clock
-      - description: bus clock for optional
-      - description: axi clock for rockchip specified
-      - description: block clock for rockchip specified
-      - description: timer clock for rockchip specified
-
+    anyOf:
+      - minItems: 1
+        items:
+          - description: core clock
+          - description: bus clock for optional
+          - description: axi clock for rockchip specified
+          - description: block clock for rockchip specified
+          - description: timer clock for rockchip specified
+
+      - minItems: 1
+        items:
+          - description: core clock
+          - description: timer clock
+          - description: card clock
 
   clock-names:
-    minItems: 1
-    items:
-      - const: core
-      - const: bus
-      - const: axi
-      - const: block
-      - const: timer
+    anyOf:
+      - minItems: 1
+        items:
+          - const: core
+          - const: bus
+          - const: axi
+          - const: block
+          - const: timer
+
+      - minItems: 1
+        items:
+          - const: core
+          - const: timer
+          - const: card
 
   resets:
     maxItems: 5
@@ -96,5 +110,26 @@ examples:
       #address-cells = <1>;
       #size-cells = <0>;
     };
-
+  - |
+    mmc@bb0000 {
+      compatible = "snps,dwcmshc-sdhci";
+      reg = <0xbb000 0x1000>;
+      interrupts = <0 25 0x4>;
+      clocks = <&cru 17>;
+      clock-names = "core";
+      bus-width = <8>;
+      #address-cells = <1>;
+      #size-cells = <0>;
+    };
+  - |
+    mmc@cc0000 {
+      compatible = "snps,dwcmshc-sdhci";
+      reg = <0xcc000 0x1000>;
+      interrupts = <0 25 0x4>;
+      clocks = <&cru 17>, <&cru 18>, <&cru 19>;
+      clock-names = "core", "timer", "card";
+      bus-width = <8>;
+      #address-cells = <1>;
+      #size-cells = <0>;
+    };
 ...
-- 
2.25.1


