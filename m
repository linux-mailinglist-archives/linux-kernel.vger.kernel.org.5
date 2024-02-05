Return-Path: <linux-kernel+bounces-52929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C159849E79
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 16:36:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8B95B295A0
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 15:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AE0B44C7D;
	Mon,  5 Feb 2024 15:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="YVRGhqy8"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C7C37156;
	Mon,  5 Feb 2024 15:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707147317; cv=none; b=u/EYuiXxtUiQuLZFToWyQ8X2BmJvZ4LU+z2eL20csyiK++Pz2RUjHMXw5gR/xl9ueyXz63SBzHQyCi6WBJhqf0JT+DJ8D/1MEEgTJXXyztDcAy7MC0j3gEeQqOGw1IcQTAwjbyLkydgEBOllN9wGY+7jjF9lhTzLNfvp3BdI0gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707147317; c=relaxed/simple;
	bh=zkHzvVhKkqmhHXMYvIXk97BK8Hudfzm2zXC5uewsDi0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lmF1NT6XL/+DZT/u8FHwYqQ6KmZ/73Lo1J34EMCBkLLqkRO5doZC0Lc3FCcptix3dtDd/EUkyakJlyy4hM+V6pkgIvsRkvi0VLnuqB29FLw1ugjQKXY3xpCIsFCdoNXkhGIPm2oGHI8hOqyYHiSyFw13fia/Yj00GFaoabk5+/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=YVRGhqy8; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6937E60009;
	Mon,  5 Feb 2024 15:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1707147313;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lbVsbmHE4CGNjOWLyfslnCmWW1EMalEIZK9eUB8mHKE=;
	b=YVRGhqy89BG4su5TlFeQwXbZsSLfAYPqAqELLgpVmob1+hvaSav1gq9VKrENhmlWuPjF3J
	yzGEkK3O7p4N9mVfxdbyvEhaReDrpHeSqbwqKGl9ddRvFbZaSvFKB/EIaWIn27M7N0bks7
	Drqo2CbHo/V1DdCHSYE5F/s6dEmPEiEngFtLR2XgFha3IYeu5F+C0ln2cL/n35swGLTUnR
	RrkBcQoSxXJET/w/cgSO5ehhoW02ZnqN3V0tl0y7DH1lCSt6Q3iSA0wSC79C6XQ08z5bD5
	IKDolxe+5Hbz9WjdiMb9t9dGwM+tmZw9CE13xYmZvWIXLUCsh1Vq6/eKyQ87NQ==
From: Gregory CLEMENT <gregory.clement@bootlin.com>
To: Paul Burton <paulburton@kernel.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-mips@vger.kernel.org,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Vladimir  Kondratiev <vladimir.kondratiev@mobileye.com>,
	Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	=?UTF-8?q?Th=C3=A9o=20Lebrun?= <theo.lebrun@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Gregory CLEMENT <gregory.clement@bootlin.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v7 07/14] dt-bindings: mips: cpus: Sort the entries
Date: Mon,  5 Feb 2024 16:34:53 +0100
Message-ID: <20240205153503.574468-8-gregory.clement@bootlin.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240205153503.574468-1-gregory.clement@bootlin.com>
References: <20240205153503.574468-1-gregory.clement@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: gregory.clement@bootlin.com

The entries were nearly sorted but there were still some entries at
the wrong places. Let's fix it.

Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
---
 Documentation/devicetree/bindings/mips/cpus.yaml | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/mips/cpus.yaml b/Documentation/devicetree/bindings/mips/cpus.yaml
index cf382dea3922c..9bc47868d28b6 100644
--- a/Documentation/devicetree/bindings/mips/cpus.yaml
+++ b/Documentation/devicetree/bindings/mips/cpus.yaml
@@ -23,22 +23,22 @@ properties:
       - brcm,bmips4380
       - brcm,bmips5000
       - brcm,bmips5200
-      - ingenic,xburst-mxu1.0
       - ingenic,xburst-fpu1.0-mxu1.1
       - ingenic,xburst-fpu2.0-mxu2.0
+      - ingenic,xburst-mxu1.0
       - ingenic,xburst2-fpu2.1-mxu2.1-smt
       - loongson,gs264
       - mips,m14Kc
-      - mips,mips4Kc
-      - mips,mips4KEc
-      - mips,mips24Kc
+      - mips,mips1004Kc
       - mips,mips24KEc
+      - mips,mips24Kc
+      - mips,mips4KEc
+      - mips,mips4Kc
       - mips,mips74Kc
-      - mips,mips1004Kc
       - mti,interaptiv
-      - mti,mips24KEc
       - mti,mips14KEc
       - mti,mips14Kc
+      - mti,mips24KEc
 
   reg:
     maxItems: 1
-- 
2.43.0


