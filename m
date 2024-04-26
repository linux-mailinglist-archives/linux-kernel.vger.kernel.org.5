Return-Path: <linux-kernel+bounces-160294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B4078B3B87
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 17:31:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCB8F1C22470
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 15:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9729824B3;
	Fri, 26 Apr 2024 15:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b="kOuOHeAT"
Received: from smtpcmd0757.aruba.it (smtpcmd0757.aruba.it [62.149.156.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6ED414901A
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 15:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.156.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714145446; cv=none; b=aW/CflI4OF7G3OzhPGz5XHOOwPYtDcxYpuFtddDNPgoYlU9tJvt2Zpgo86FpG14P5m8uNOZIp1Gd2FaTRwx6NsnRRWx448C2HZntgmnBfAkHqc+XGADta8cvCEhKa98skOWmToYm7GagLOoDhDMmXeQ4Hv1TJJiQ6lPKb0XLm0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714145446; c=relaxed/simple;
	bh=AL/RIHlDSD7TG5DlDkAMmKi18A+T8P4sO4zdcXPXefU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aXDLzmma739xdLqOQK7OJAgrZxqosWAN+kkPubdv40pzECEnbMtiI6Cz9bt6XUYxSynL2w26D+RjhNz477O5zUTXNhMozM39faThxvg+PCv061zXguBMcUeLauYI56tvjWdvCBX4MDpsfxRSAehdJ4gcK0ARdOpw9zr5NTzo5bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engicam.com; spf=pass smtp.mailfrom=engicam.com; dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b=kOuOHeAT; arc=none smtp.client-ip=62.149.156.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engicam.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engicam.com
Received: from engicam.com ([146.241.23.148])
	by Aruba Outgoing Smtp  with ESMTPSA
	id 0NU4sgEVa6epj0NU5seY30; Fri, 26 Apr 2024 17:27:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
	t=1714145254; bh=AL/RIHlDSD7TG5DlDkAMmKi18A+T8P4sO4zdcXPXefU=;
	h=From:To:Subject:Date:MIME-Version;
	b=kOuOHeAThuJp/LE1dluXA9fhCl3DfboaH+ZZKpug382AHP6KsB3Iy9GB03WAG9QLn
	 geeHZ86ot/vMjxPrnr36ogu5xaVS4zLoUnuJ4OJ65IDXKf5GcdtJ6Vd77Uz0cIicz8
	 y81dTqCEW4n75MbnF5m0zhRr1syxOOoCuvmIRbjpWCQiiJwnxDVNZQJa04L63rdT0U
	 IAlPWTzpcVw9OQ3WMdhrtYSpDVIlKcdqGl5IFzsj4eLVsAg4dr/oF57mtaJ2Htds9r
	 Siaf9g09YilJQ7wsV62OGD4fN9IXj9YeBKW+zs6cqEkn4Z1wB5ndkFTT792SvMKH6k
	 7HKIo8yXLoRZA==
From: Fabio Aiuto <fabio.aiuto@engicam.com>
To: Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Fabio Aiuto <fabio.aiuto@engicam.com>,
	Matteo Lisi <matteo.lisi@engicam.com>,
	Mirko Ardinghi <mirko.ardinghi@engicam.com>,
	Krzysztof Kozlowsky <krzk@kernel.org>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v6 1/3] dt-bindings: arm: fsl: add Engicam i.Core MX93 EDIMM 2.0 Starter Kit
Date: Fri, 26 Apr 2024 17:27:28 +0200
Message-Id: <20240426152730.9806-2-fabio.aiuto@engicam.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240426152730.9806-1-fabio.aiuto@engicam.com>
References: <20240426152730.9806-1-fabio.aiuto@engicam.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfBpXg0R56R6cOqqviDj0eVmGiholy62key5QTgyVk64OidOQYPGH8pVLedjYxirnNH6w/6GZ4Q20PGL/9G4lcxVEb1HqAuHoaiBg3k+uHfCvX0yYs7at
 emkjG2GRa/L83oeTGTAoiARWlNfviUBynjZIIyeHylgRXT80iuGPhtZ7ZpUjseLwoPebJiFJ/95Xip/FdggUI9xdAiT86HmyAPR34qj1+bc0sTgzQbqOJIBS
 REUxZiP187uYRJJ2SQ/bBSf9kvSxO59aqga5U6Or49v6BFH0/+ClIds0hxPaSwgmPXB3weXmUOhuwiSkSf/zA6LGEw5INyOXF27jaYq68xK9yB1/WXAKd4Qc
 qp6ghCVk/x/iWk7GPSWyMTgGT6TCYDt9DvrieVkZc7OtPhtfFuJwaEIr9DOOtu71bSZaKWpa56YqsuBJ4SJXWOYt0tmZf2Q0ijbnmGfJQ9vdwVbThbzpKqdj
 VduN/792uCWTYFA5WlhsRZqgRWVVxBoMzT1BR/NwHjg6pC7xO4UjPixm7y0ttyU41gyuh1sd4ibRQ5mLdGE95LOUkVqNos0tfj8sKtvbYK6/NajfCE86w8QH
 X0LAg0aXWZGMpDpwJZqvhpoy7jcJg98mO1UhVrRKRBfUUxDcPvT+thL1bUtn6Znz9JUbUyU0vqhPiujQBliDldpZ

i.Core MX93 is a NXP i.MX93 based EDIMM SoM by Engicam.

EDIMM 2.0 Starter Kit is an EDIMM 2.0 Form Factor Capacitive
Evaluation Board by Engicam.

i.Core MX93 needs to be mounted on top of EDIMM 2.0 Starter Kit
to get the full i.Core MX93 EDIMM 2.0 Starter Kit board.

Add bindings for this board.

Cc: Matteo Lisi <matteo.lisi@engicam.com>
Cc: Mirko Ardinghi <mirko.ardinghi@engicam.com>
Reviewed-by: Krzysztof Kozlowsky <krzk@kernel.org>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Fabio Aiuto <fabio.aiuto@engicam.com>
---
v3 ---> v6:
	- no changes
v2 ---> v3:
	- added {Reviewed,Acked}-by tags
v1 ---> v2:
	- no changes

 Documentation/devicetree/bindings/arm/fsl.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 0027201e19f8..b497a01c7418 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -1265,6 +1265,13 @@ properties:
               - fsl,imx93-11x11-evk       # i.MX93 11x11 EVK Board
           - const: fsl,imx93
 
+      - description: Engicam i.Core MX93 based Boards
+        items:
+          - enum:
+              - engicam,icore-mx93-edimm2         # i.MX93 Engicam i.Core MX93 EDIMM 2.0 Starter Kit
+          - const: engicam,icore-mx93             # i.MX93 Engicam i.Core MX93 Som
+          - const: fsl,imx93
+
       - description: i.MXRT1050 based Boards
         items:
           - enum:
-- 
2.34.1


