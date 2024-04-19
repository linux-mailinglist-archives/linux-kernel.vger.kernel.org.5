Return-Path: <linux-kernel+bounces-151421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBA7A8AAEA7
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 14:38:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2DB6CB21E4F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 12:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 339268565D;
	Fri, 19 Apr 2024 12:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="VbitxgIq"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F56678286;
	Fri, 19 Apr 2024 12:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713530318; cv=none; b=Zq6TN98nqN3duq1hUMuWDlPcY0v4gAj/b31Hzj7apkfDSJJwzNP/SlEtoxj1PsU8NmCl30z2rVs67z0rD3CcXcgITSiYHvobvVbuMMHPBPPTKjny6dCIv5KQglWGQxKyP32OEQqSq6SrSbEsyH+9M1EeL1EOm9WqCnMocN4qoBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713530318; c=relaxed/simple;
	bh=xvhakI/gJi6QeG2YGEaTZ/99O68GdGOJPHyw5PUhbO8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hAO3r0N4tAJRoyJ74LE15FTho2w8dhscuyEUl/yn3wjKeComLbP66F0mf33Td9TFVXz7J4la06tNIdY9Ya6vUw8AXtlvEK9MO+Dcze/E896Rcf0EtWQSdL6OeXgiX5cCxLFz6TfPEglR+FXkznlDcYidSOVe4n+ZSbWvs73Frpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=VbitxgIq; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id CEA5C6000B;
	Fri, 19 Apr 2024 12:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1713530314;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KpuZnh+0Pw/1mj7y4M1pa+0BGDPeeXQB2THZ9rva5uI=;
	b=VbitxgIqd+FVWp+E1birDLvtJP0A1RalUscF/4wAGQkBk1uUMknF2F8PudxLacPliMt+KH
	Ut6rJ066pv9H790Z3EcoPKjY653qraP/D+XJOsW4BNosay1+RfKOEZjMSKOnBzPb7lr18E
	EUVhl/Z4T7cBJVaTj1T+JSnvu8jfpdjsw0wM/RHZPBZOJsZKUx//y5P1Qn6QVR5wTiFf1b
	xfQiwGnDOA/vE9Meb0/kSOHvsx5JCZD0Cb90DrFnoWEf1oXebDTaQUNuGvqq5DcBaUBo4o
	Hihkzi64+aN/oFnLRV/xVB0F4P5YXBZ/Ei91ZJ/2tCVWhVZIZS/CdmpoaOD1+w==
From: Kamel Bouhara <kamel.bouhara@bootlin.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Henrik Rydberg <rydberg@bitmath.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Marco Felsch <m.felsch@pengutronix.de>,
	Jeff LaBundy <jeff@labundy.com>
Cc: catalin.popescu@leica-geosystems.com,
	mark.satterthwaite@touchnetix.com,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Gregory Clement <gregory.clement@bootlin.com>,
	bsp-development.geo@leica-geosystems.com,
	Kamel Bouhara <kamel.bouhara@bootlin.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v11 1/3] dt-bindings: vendor-prefixes: Add TouchNetix AS
Date: Fri, 19 Apr 2024 14:38:25 +0200
Message-ID: <20240419123829.120396-2-kamel.bouhara@bootlin.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240419123829.120396-1-kamel.bouhara@bootlin.com>
References: <20240419123829.120396-1-kamel.bouhara@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: kamel.bouhara@bootlin.com

Add vendor prefix for TouchNetix AS (https://www.touchnetix.com/products/).

Signed-off-by: Kamel Bouhara <kamel.bouhara@bootlin.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index b97d298b3eb6..33205dea558b 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1481,6 +1481,8 @@ patternProperties:
     description: Toradex AG
   "^toshiba,.*":
     description: Toshiba Corporation
+  "^touchnetix,.*":
+    description: TouchNetix AS
   "^toumaz,.*":
     description: Toumaz
   "^tpk,.*":
-- 
2.25.1


