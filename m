Return-Path: <linux-kernel+bounces-69097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D68E885846F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 18:45:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7656F1F2282A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 17:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8E0E137C5A;
	Fri, 16 Feb 2024 17:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="fHUoiYCQ"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD443135401;
	Fri, 16 Feb 2024 17:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708105367; cv=none; b=rajEsHaUrCUNbv9s/quzbF3ZNjnNQY3gkT2wkEk4yfHPWhBAQJuFvRCLBAIEu1c5+jaIOUFSRnsPGl7as7h0JbyJgC3NNoLutCxFXvWg2Iz067oOHETvVxqq7Iy6HlLjOmp8TW7ZFuNmdMQmaUVmOkAJjquFsU/Dp7rnT1/4ScU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708105367; c=relaxed/simple;
	bh=zkHzvVhKkqmhHXMYvIXk97BK8Hudfzm2zXC5uewsDi0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bjp8MLKBTXtRscwP1Q9XWnosAWGDNEkEafd/4x1lW54MXN5Z6D+cJUeXOCGf0y9nt+z2ToCtAZ0I2pjn7E0qxU8AqSza/9k+CvQ/14ZZYgykptE6ydCeRd4QRWRVwtPa+1+HAKAfanTop4DCO2n4HGYzbqt5biWe0Ea6xjECpNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=fHUoiYCQ; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A59B2FF804;
	Fri, 16 Feb 2024 17:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708105357;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lbVsbmHE4CGNjOWLyfslnCmWW1EMalEIZK9eUB8mHKE=;
	b=fHUoiYCQBX+G8LDk0+TzfxJnaKfFyPj/Oh5JGJSJukX3scl7nF4nswEQbA0F4Hj2EFx6RA
	MmQT0sW21UFPuArIKFFjjWG+/+U7iLQ+qj7Z9fcOht2Uv8cepjTaV+xy9UYWOlDMy5Ple9
	4UzRRDexQmOuJHTVv68qpthL8YgCvlY3GKJaklrfPeYDG5wrLH3augQxL1m+C1fXJ1oT/+
	ZsDYNyb0CJbjZcGnnZkpE9auhJW6cwmR47TJFts1+2MRroKwiWQ9XUSwpK6a1v0bd1Xymo
	6Uwf1jhLF5W66ah+P85PXrUwa0yFfHCEpgPT7t+T61HY2n7ekfazNHW+RnZAeA==
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
Subject: [PATCH v8 07/14] dt-bindings: mips: cpus: Sort the entries
Date: Fri, 16 Feb 2024 18:42:16 +0100
Message-ID: <20240216174227.409400-8-gregory.clement@bootlin.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240216174227.409400-1-gregory.clement@bootlin.com>
References: <20240216174227.409400-1-gregory.clement@bootlin.com>
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


