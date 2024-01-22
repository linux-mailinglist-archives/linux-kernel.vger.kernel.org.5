Return-Path: <linux-kernel+bounces-32505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C757A835C6C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 09:20:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5875CB27708
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 08:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A04839851;
	Mon, 22 Jan 2024 08:18:44 +0000 (UTC)
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7440939846
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 08:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705911523; cv=none; b=J9cxPuJNTbDNDKsQdr3nziqBdzRobF/HEfbuq1kEXeE7y+9gBAXLQ+5rQhyxSk/Tr5QkOYWKMXe9beuEz0uA/6gnuCLRn1g120kUQBy/4+nrHj1XI7VJs6Hcuq4ABK27h+/sZou4iq1EaD85At5SBG9eq9syuMCPcifDW4COoPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705911523; c=relaxed/simple;
	bh=BWzqwv+5BLR9iJ/cwRZDzelnwRi5bJX8TzYd0bzhZqw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=niSuZNpvSoUEMJ+sXxrDYD7EM3jbzA2xPKNJ7V+3ApzxXNT7E4yXmXkltQFXnqqX3ilahmSsOPjgHG1SOaOfd6UndOt7sG3h2YzBRnj11/8p0EyX44Xfe7pT70RKa2CxaQxsSspkbx2bC6Tzbm6PSA8yYVj956AllvKygTyYiOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 40M8I8DK055611;
	Mon, 22 Jan 2024 16:18:08 +0800 (+08)
	(envelope-from Wenhua.Lin@unisoc.com)
Received: from SHDLP.spreadtrum.com (shmbx06.spreadtrum.com [10.0.1.11])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4TJNFj2Zzxz2Rb03v;
	Mon, 22 Jan 2024 16:10:49 +0800 (CST)
Received: from xm9614pcu.spreadtrum.com (10.13.2.29) by shmbx06.spreadtrum.com
 (10.0.1.11) with Microsoft SMTP Server (TLS) id 15.0.1497.23; Mon, 22 Jan
 2024 16:18:06 +0800
From: Wenhua Lin <Wenhua.Lin@unisoc.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
CC: Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang
	<baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>, <linux-pwm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, wenhua lin
	<wenhua.lin1994@gmail.com>,
        Wenhua Lin <Wenhua.Lin@unisoc.com>,
        Xiongpeng Wu
	<xiongpeng.wu@unisoc.com>,
        zhaochen su <zhaochen.su29@gmail.com>,
        Zhaochen Su
	<Zhaochen.Su@unisoc.com>,
        Xiaolong Wang <Xiaolong.Wang@unisoc.com>
Subject: [PATCH 6/6] dt-bindings: pwm: sprd: Add sprd,mod attribute
Date: Mon, 22 Jan 2024 16:17:54 +0800
Message-ID: <20240122081754.17058-7-Wenhua.Lin@unisoc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240122081754.17058-1-Wenhua.Lin@unisoc.com>
References: <20240122081754.17058-1-Wenhua.Lin@unisoc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 shmbx06.spreadtrum.com (10.0.1.11)
X-MAIL:SHSQR01.spreadtrum.com 40M8I8DK055611

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


