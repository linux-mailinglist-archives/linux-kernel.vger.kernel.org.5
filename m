Return-Path: <linux-kernel+bounces-30315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B1C6831CFE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 16:56:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C0E6B22910
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 15:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87DDA2D7B7;
	Thu, 18 Jan 2024 15:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="m03HPZLJ"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C482D021;
	Thu, 18 Jan 2024 15:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705593200; cv=none; b=ToRgF6u5ZXVo0GQ5csI9W3k5wp24GPX6ZdzUDNPlmXL0Ps+H5mMMf+HltvIZTI2OntO2JEs6myudA7m/0S1YCtkglxhEvVHcILVYsWAl03Fr7H0fyY3HYEopk8KIZzvNPynrxQT22Xy0HraoaQZDdwpZgfuf/4P+6QTg5BMvgGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705593200; c=relaxed/simple;
	bh=zkHzvVhKkqmhHXMYvIXk97BK8Hudfzm2zXC5uewsDi0=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-GND-Sasl; b=KPjbILItP2CpqrJqOvmS/e+MEO0qf7yNcCPZFi4RzGl/y6EMVUb5D2BfhoN0+4T/PFECBKzHMncHfCkfVQjEfrpcp8yegemc/RjfWLeUPDGZ7hhHR4fN6B6+pfUJsX2TfC7YwT3lJxLd+vJN+LFX8m6ZOQKxxBUTGHHUWMzmyco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=m03HPZLJ; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id CBB0AE0008;
	Thu, 18 Jan 2024 15:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1705593191;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lbVsbmHE4CGNjOWLyfslnCmWW1EMalEIZK9eUB8mHKE=;
	b=m03HPZLJGGZzR0nGC6CmmyVbkycBEN896zgtCF/JeExvmK9+IvWaNPFjqHXLToMqYoAe3r
	YuBDwidAECZxSchieL2eyhTkcF30v8pksFvRT+TigBQ7iM68hA58qPc3fCrxtLCYGJo6i9
	+AfClGfXd1AYm1fekdAVXF3xd8CxzvuCH7QpEf8mDDUYq5UhebhJtQ1Xh1w3vtUsyRoUM7
	cNZ73+4YK2G16Wxn2+dMjhMBSImOkUNXhRsA+VTSR7Vh+ad+/KzeyAv8d0JV/1BZdjAzLr
	Fm2be0L0vqixc86+Kp0bIW7FPHtDJNw8raRH6md6q+G+VaZX/8dTF6m2S5yUaw==
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
Subject: [PATCH v6 07/15] dt-bindings: mips: cpus: Sort the entries
Date: Thu, 18 Jan 2024 16:52:36 +0100
Message-ID: <20240118155252.397947-8-gregory.clement@bootlin.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240118155252.397947-1-gregory.clement@bootlin.com>
References: <20240118155252.397947-1-gregory.clement@bootlin.com>
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


