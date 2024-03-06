Return-Path: <linux-kernel+bounces-93369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D910872E9B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 07:12:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F3FE1F25E47
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 06:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11F071BDD8;
	Wed,  6 Mar 2024 06:12:50 +0000 (UTC)
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0CBC14F68;
	Wed,  6 Mar 2024 06:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.169.211.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709705569; cv=none; b=mM/9QKsKw3GXx8Iw7wDgp5j2g/7PI9lTTrR3Ox42mQj1AFl6gmWB1uzd1kRWMlluKW3UBYYIxxzSQqzSkO4a8Mrs8K6uqPNKnqx9WRnJTg+TXsXRx06kalgBE9Y4JQDJRGhLNUMCbptLd/B464cDW6QCrbfW2f98gA/2vZtyGhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709705569; c=relaxed/simple;
	bh=VTXFrHXqmkOyo2MWZsQ+0ObQpBHSFj83KWXg9ku3l90=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bliq//2l1SEoQu7O+0tIxwCK95E836LFmd1GYuDOJ81wNxc4JIQs8T++Q6eeLyrGGRorewMgGAT9gUCpfO7GpQ4u2YhOG1ajbfXXGdUlXHc04Toi7h9So4E1DH4hoS5gKg1SmMaIdiHibTSf01Q1iHkzdFlDFjowZVIXNkyLfQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=18.169.211.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtp79t1709705535t3g5c5m7
X-QQ-Originating-IP: pILm192FyR81AYB9KGQnP3T5yfbnc3HdKc3z+35qQyc=
Received: from HX01040022.powercore.com.cn ( [223.112.234.130])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 06 Mar 2024 14:12:13 +0800 (CST)
X-QQ-SSF: 01400000000000B0B000000A0000000
X-QQ-FEAT: HXiF522FjMi93sTH/OHoeIDVj5X9MbFg3an5BRaoXaBW5rSiIQZ4mrQPgqLb/
	r6+Y4DP9L4C0ZKrX+qbHSFsCKBuB+8f7sSF+WqaAv7esWQexWB8q5nO/66v01KwO8AzRuB0
	4PEw3qLwr01WkMzm/PgRk6U6JW59xYO/GDaKZ9NkUsQVWheLHfWQ4BmlXBWPPibUodTrE2J
	ZcGJSDrBBamYlKaUSnBXAtZCEuX45A2cfdUrJpcAG8m3GnDVRX7fzzxUEA+x+8r8uvFK5E6
	0FFJB9dWCsqXXvbuv9OoyMBWAN3EOvxZy1o1MpUNT9OOKjHMNiloET90XMDhT/OPyp7nPAE
	Yx+ZoYLKXmKWCtP51UeP2WP4L0ClJg/vhjJBQQQqHn2yK5+8maV8hRIFJRQdxO3rwbvZL7C
	9oDSa/AYvh4=
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 1942117647981403500
From: "JiaLong.Yang" <jialong.yang@shingroup.cn>
To: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: shenghui.qu@shingroup.cn,
	Rob Herring <robh@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] dt-bindings: Add HEXIN Technologies Co., Ltd. vendor prefix
Date: Wed,  6 Mar 2024 14:16:01 +0800
Message-Id: <f674ec19ce824dfc13258396931256c3d33cd207.1709694173.git.jialong.yang@shingroup.cn>
In-Reply-To: <cover.1709694173.git.jialong.yang@shingroup.cn>
References: <cover.1709694173.git.jialong.yang@shingroup.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:shingroup.cn:qybglogicsvrgz:qybglogicsvrgz6a-1

Update file vendor-prefixes.yaml to include hexin as a vendor prefix
for "HEXIN Technologies Co., Ltd.".

Signed-off-by: JiaLong.Yang <jialong.yang@shingroup.cn>
---
v1 --> v2: Not changes this file and give warning.
v2 --> v3: Add this patch to fix the warning.

 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 1a0dc04f1db4..3a82104ac8a7 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -619,6 +619,8 @@ patternProperties:
     description: HwaCom Systems Inc.
   "^hxt,.*":
     description: HXT Semiconductor
+  "^hexin,.*":
+    description: HEXIN Technologies Co., Ltd.
   "^hycon,.*":
     description: Hycon Technology Corp.
   "^hydis,.*":
-- 
2.25.1


