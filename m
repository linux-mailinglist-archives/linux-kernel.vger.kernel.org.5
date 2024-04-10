Return-Path: <linux-kernel+bounces-138266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C221589EEFB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 11:34:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3A2E1C215C8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 09:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3904B1598F8;
	Wed, 10 Apr 2024 09:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="dbCqCr3W"
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8311598F7;
	Wed, 10 Apr 2024 09:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712741588; cv=none; b=uPN1RkG1sQ4j2DF2zccooxSNp/txbc65cERLDriD7xVtuQeVdhnuQg/bpo9Ozz/MVfgXBZ4tD3gFxIbWfmOo3rJhRrq8eOluutdZuPKLLr/0zktQwfufS5ky2WkQ5eF3DjojDiwd3xzrEh17gFBdcUJyP2VqiWv+NOSacnLi9DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712741588; c=relaxed/simple;
	bh=T1YIXNKOKmk0HCpf7gFyTxJ5Gf3Ca8L3mGSoUrehSd8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rKkIKv0LCGBGWuDwYULWJa/39/YOj5UDqfvMmv6Q/g48K+l16a3xlKNgWwWWmPXFaenACfkW/EtEmn4jSoeECmMMHT+19kcJFjpcHcfKvT9FNudM5qy0SqMepYqpDxbKo+BcAjDDp/851bxCIxPskzAM4LAxT6sact7LiN+qqwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=dbCqCr3W; arc=none smtp.client-ip=217.70.178.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from relay6-d.mail.gandi.net (unknown [IPv6:2001:4b98:dc4:8::226])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id 5C71CC5F28;
	Wed, 10 Apr 2024 09:29:13 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 58193C0004;
	Wed, 10 Apr 2024 09:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712741350;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rTF3tEOlEX8botUulcBFWhU0qypXrMI0sFEbs2/cCHs=;
	b=dbCqCr3WYuLwsnm50stbIfoYR6zbNOFVAl+n2GIVomYHvx2KnijqOd8s0YU62k4lMeDWop
	TisRWqFvUfD6JeYDubLZCpkXCkCziISk1rOuX4NW13D6VzQ/GGnvYcxIUh4nrLzktxFoiE
	Rcj7NPdlQui2t175YlHmtq9DBIwDoVUI3Vomvt/I4H6PxCzTSKF2AKpNMRH9ljcfhFsvey
	GdiXdRvXVh0N7d8I58bXQ8SbO4ShYPpPGRzcny5bRqvFmxPOLjLk/HIzILc5pvIXV4N575
	R81vWnjT1GSI4lejITkWIAroxFQl6rwhAc6xsMHlqd7L4gZ8WUAdBsVlGBEI6w==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Wed, 10 Apr 2024 11:29:04 +0200
Subject: [PATCH v3 1/9] spi: dt-bindings: cdns,qspi-nor: sort compatibles
 alphabetically
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240410-cdns-qspi-mbly-v3-1-7b7053449cf7@bootlin.com>
References: <20240410-cdns-qspi-mbly-v3-0-7b7053449cf7@bootlin.com>
In-Reply-To: <20240410-cdns-qspi-mbly-v3-0-7b7053449cf7@bootlin.com>
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Vaishnav Achath <vaishnav.a@ti.com>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 Rob Herring <robh@kernel.org>
Cc: linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-GND-Sasl: theo.lebrun@bootlin.com

Compatibles are ordered by date of addition.
Switch to (deterministic) alphabetical ordering.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml b/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
index cca81f89e252..b865d4cc25cc 100644
--- a/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
+++ b/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
@@ -68,12 +68,12 @@ properties:
       - items:
           - enum:
               - amd,pensando-elba-qspi
-              - ti,k2g-qspi
-              - ti,am654-ospi
               - intel,lgm-qspi
-              - xlnx,versal-ospi-1.0
               - intel,socfpga-qspi
               - starfive,jh7110-qspi
+              - ti,am654-ospi
+              - ti,k2g-qspi
+              - xlnx,versal-ospi-1.0
           - const: cdns,qspi-nor
       - const: cdns,qspi-nor
 

-- 
2.44.0


