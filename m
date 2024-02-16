Return-Path: <linux-kernel+bounces-69095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC54A858468
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 18:44:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 924611F2276F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 17:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE65813664A;
	Fri, 16 Feb 2024 17:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="U5AM+IIy"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE42454BD3;
	Fri, 16 Feb 2024 17:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708105366; cv=none; b=ms/5KwQM5CqOrHOK+cXYIwD0H+FAtRDcL0NXFXgDejpnxbX+MLaf///ZYouKumlV2t6w3YAt16MoX8uuuoEwBEphOChvo7VEqPbhLhAFY+q4k02vN63eL7FI1Esi19LWzO7ZcxAfg4mw/zBMk6jP4T5pfe/tLXSkxoV0GGlX+4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708105366; c=relaxed/simple;
	bh=ixMcKFY+IUbSdpEbmhiHUnPBLE8f92Qaft2wepBV4zg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cz5eqmWhqzMp9TEfFFj9/XRWaPUBsl3Rmmq82qp8CaTFmffxQWwShpVez/+vstXzwoF8SAsU9utisWE7rkQtqphqK6TdSIWlOJVhALg+cquNBJGdXFMewATB1L6MIIVff4b+a5ieHd3Kp2ogxnE0yPGz1VKjXnrUVzTmKs1t2ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=U5AM+IIy; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9749360006;
	Fri, 16 Feb 2024 17:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708105356;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GD5dmA3icQ0aFc9IWzxUyFJ8W/NRInrfQ2B2LPqfRyo=;
	b=U5AM+IIy6md4avJJAAMXfYrFomYfUJ2NYz0D2DlzvrKlAEhC1mtZzsWbfK7eTTe5xqo1e5
	I9NqxdAk5lA0mwfZhopG+b310YVrQX690Zt43Kq28oYAjEVRu7lo6zMS6/+BmDeRYeTSsK
	gPFkyl1+sbyFCAxZzMHRwvXB/LAQj6dJkhHSkV7EQGVgvxnN5GBUgrqG/sTt08uefgJ0ge
	+gkHCMzF3ua+yjZmcIHsChfLoTvP+KELgBl/7XmhMxCdJJ5sfyV47r1eduQmajjohAhhqJ
	JofoBINFJBMrA8/FWUBGCWaTZqRrdbOG1eTvHTiymN2SZojFtWGAhWhR1g5Vig==
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
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
	Rob Herring <robh@kernel.org>
Subject: [PATCH v8 06/14] dt-bindings: Add vendor prefix for Mobileye Vision Technologies Ltd.
Date: Fri, 16 Feb 2024 18:42:15 +0100
Message-ID: <20240216174227.409400-7-gregory.clement@bootlin.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240216174227.409400-1-gregory.clement@bootlin.com>
References: <20240216174227.409400-1-gregory.clement@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: gregory.clement@bootlin.com

Mobileye Vision Technologies Ltd. is a company developing autonomous
driving technologies and advanced driver-assistance systems (ADAS)
including cameras, computer chips and software.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 1a0dc04f1db47..fb088d9c6f5b2 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -911,6 +911,8 @@ patternProperties:
     description: Miyoo
   "^mntre,.*":
     description: MNT Research GmbH
+  "^mobileye,.*":
+    description: Mobileye Vision Technologies Ltd.
   "^modtronix,.*":
     description: Modtronix Engineering
   "^moortec,.*":
-- 
2.43.0


