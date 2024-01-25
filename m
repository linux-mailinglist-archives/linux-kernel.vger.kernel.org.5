Return-Path: <linux-kernel+bounces-37916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1DAE83B791
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 04:10:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 806362887D9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 03:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7059411181;
	Thu, 25 Jan 2024 03:09:20 +0000 (UTC)
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D13EC10A0A
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 03:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706152160; cv=none; b=Z/3+yBMGAkr/HFHIZB036MNnmpbNJjOJHW2bTnZ9J+kHr3FpnwpFh4PceiCJ/BPLMAA33Odark8ySjTzNZjL2vQnmw6G45IuZaxzNZrnoCt5E+a37di7L5W6/rlgX80XgDOXYIlGdCia/Y1kTdGu8gpipJURalag+ZjF89Vu7cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706152160; c=relaxed/simple;
	bh=BWzqwv+5BLR9iJ/cwRZDzelnwRi5bJX8TzYd0bzhZqw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fMY8oSkaogsy6AJMiOpp/vKrtbvBS2Bg7tGAczoItNr5kOKdRKgsrJVnN5BFbkh00AQJJRddzzJvhcyvnLQK8TuFhpFbnWLPeXYw0UZopnDw0NriMHIpbzgbiE6vE2HPq8b4Z3nzBSQW38R2AoIMQ0MGXFXGBH6/N7igd8LBw/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 40P38fm3061776;
	Thu, 25 Jan 2024 11:08:41 +0800 (+08)
	(envelope-from Wenhua.Lin@unisoc.com)
Received: from SHDLP.spreadtrum.com (shmbx06.spreadtrum.com [10.0.1.11])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4TL5F86NPcz2Rq2lq;
	Thu, 25 Jan 2024 11:01:16 +0800 (CST)
Received: from xm9614pcu.spreadtrum.com (10.13.2.29) by shmbx06.spreadtrum.com
 (10.0.1.11) with Microsoft SMTP Server (TLS) id 15.0.1497.23; Thu, 25 Jan
 2024 11:08:40 +0800
From: Wenhua Lin <Wenhua.Lin@unisoc.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        Rob
 Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang
	<baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>, <linux-pwm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        wenhua lin <wenhua.lin1994@gmail.com>,
        Wenhua
 Lin <Wenhua.Lin@unisoc.com>,
        Xiongpeng Wu <xiongpeng.wu@unisoc.com>,
        zhaochen
 su <zhaochen.su29@gmail.com>,
        Zhaochen Su <Zhaochen.Su@unisoc.com>,
        Xiaolong
 Wang <Xiaolong.Wang@unisoc.com>
Subject: [PATCH V2 6/6] dt-bindings: pwm: sprd: Add sprd,mod attribute
Date: Thu, 25 Jan 2024 10:55:33 +0800
Message-ID: <20240125025533.10315-7-Wenhua.Lin@unisoc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240125025533.10315-1-Wenhua.Lin@unisoc.com>
References: <20240125025533.10315-1-Wenhua.Lin@unisoc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 shmbx06.spreadtrum.com (10.0.1.11)
X-MAIL:SHSQR01.spreadtrum.com 40P38fm3061776

Add sprd,mod attribute, which set the number of different
duty cycles that PWM's waveform could output, to dts.

Signed-off-by: Wenhua Lin <Wenhua.Lin@unisoc.com>
---
 Documentation/devicetree/bindings/pwm/pwm-sprd.yaml | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/pwm/pwm-sprd.yaml b/Documentation/devicetree/bindings/pwm/pwm-sprd.yaml
index 02e039fee3b4..7c956b840fa1 100644
--- a/Documentation/devicetree/bindings/pwm/pwm-sprd.yaml
+++ b/Documentation/devicetree/bindings/pwm/pwm-sprd.yaml
@@ -55,6 +55,16 @@ properties:
     minItems: 4
     maxItems: 4
 
+  sprd,mod:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    minItems: 4
+    maxItems: 4
+    items:
+      minimum: 0xFF
+      maximum: 0xFFF
+    description: |
+      The number of different duty cycles that could be set for PWM's waveform output.
+
   "#pwm-cells":
     const: 2
 
@@ -63,6 +73,7 @@ required:
   - reg
   - clocks
   - clock-names
+  - sprd,mod
 
 additionalProperties: false
 
@@ -88,6 +99,7 @@ examples:
                                  <&ext_26m>,
                                  <&ext_26m>,
                                  <&ext_26m>;
+        sprd,mod = <0xFF 0x1FF 0x3FF 0xFFF>;
         #pwm-cells = <2>;
     };
 
-- 
2.17.1


