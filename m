Return-Path: <linux-kernel+bounces-133205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 716E089A07B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 17:02:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08E6BB21277
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 15:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24D9D16F900;
	Fri,  5 Apr 2024 15:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="mW0I9HEw"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55DB616F0FB;
	Fri,  5 Apr 2024 15:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712329340; cv=none; b=vE43xMU0ikewtHYn/0lNbi7zhuIw1X6naw6FsLsD1w8mnPHQK6h5h03M17SG6jsq2Rl6tm3Ta+rTT9Ncfg4dggvQqhqbFRtpwDRiwlwjetvrQwLcyNw9pdQKrquEpZ5AKoRi9Yp0cLrnpD2fmbi9Le5PbDA2WoUiPaWSiT4kXFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712329340; c=relaxed/simple;
	bh=kWHhdR9UQSbOBCijUt28orjnewhf0V+/gLGehzP8igM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GLZoN5/3Unnx1wUeM9x0vGnEuwgOBbQIqKn88sSmlKSRtKKbznEkFNE0IsfjGNFEYgnMaioGKM2jz0jybRMeoko76RMCKPf7UMsGc64jodqh4lBVR/MsY9IToUTxhUjVGCvZWvX1d+2Fn5u2S0W5zduGxi3qt2tpMeF17wyTgTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=mW0I9HEw; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 30F3E1BF217;
	Fri,  5 Apr 2024 15:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712329336;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RRgBiKVeJ2Jy7Ape+Lobb5Tr82aRXUnmBplRp1OZZNA=;
	b=mW0I9HEwwZDMIO+C+TQ5ZjVohADU0OBQmmyF2LkCE46oCbPNhM4s1/Yu6LaZn5jy5Cc1Ni
	adDm15EpMl2e3+o6BEHKfi9NdGKbc9ekwkKOP54rzXj9W69eOHCx9M7uvq5e8flaJ77vgG
	JXsLgd9zv2JVt3SAg+IoSPTsjYL5dg3EO0o49h6n8/aRTXHAnCNznE5xYlpk1It/oCI5Lo
	XfRmrLXDyP1esHtWQJ0JEI5tKPusZ0/bxUfZEFBbnk2KwzPgwXDni4ec5G/C9beHvskZ0O
	m3nEvDlowyScKSiDi1D2hVQhIDg/39PfVKPHJT+xVcQyj1Ipj4rxuJW2VRUQmw==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Fri, 05 Apr 2024 17:02:12 +0200
Subject: [PATCH v2 02/11] spi: dt-bindings: cdns,qspi-nor: sort compatibles
 alphabetically
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240405-cdns-qspi-mbly-v2-2-956679866d6d@bootlin.com>
References: <20240405-cdns-qspi-mbly-v2-0-956679866d6d@bootlin.com>
In-Reply-To: <20240405-cdns-qspi-mbly-v2-0-956679866d6d@bootlin.com>
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
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: b4 0.13.0
X-GND-Sasl: theo.lebrun@bootlin.com

Compatibles are ordered by date of addition.
Switch to (deterministic) alphabetical ordering.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml b/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
index 5509c126b1cf..e53d443c6f93 100644
--- a/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
+++ b/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
@@ -79,13 +79,13 @@ properties:
       - items:
           - enum:
               - amd,pensando-elba-qspi
-              - mobileye,eyeq5-ospi
-              - ti,k2g-qspi
-              - ti,am654-ospi
               - intel,lgm-qspi
-              - xlnx,versal-ospi-1.0
               - intel,socfpga-qspi
+              - mobileye,eyeq5-ospi
               - starfive,jh7110-qspi
+              - ti,am654-ospi
+              - ti,k2g-qspi
+              - xlnx,versal-ospi-1.0
           - const: cdns,qspi-nor
       - const: cdns,qspi-nor
 

-- 
2.44.0


