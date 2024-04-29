Return-Path: <linux-kernel+bounces-161995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B66E88B5452
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 11:34:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E765A1C21337
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 09:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 040C628DB7;
	Mon, 29 Apr 2024 09:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b="Efl6Y62k"
Received: from smtpcmd13146.aruba.it (smtpcmd13146.aruba.it [62.149.156.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC2B22EF8
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 09:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.156.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714383270; cv=none; b=bN7T3PikcbeG6YgUCIrsKPVknq6T3VpC9W314oNMMK59o2O0LABUU2pg38Tm4pgcx694V26Tj4aNX3IPfAV55qmqPHz4GoH5mG/+8XJpBCNljn0pjsU9PZixGli/rLIYTsdSi2feb5ZtHlmgLhAWsGbW4lobYTYJ/caYWrfbFBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714383270; c=relaxed/simple;
	bh=yJ5DK+frYviDBgPRfGTLYiMKxN5TUIopuDDTaKC/Srs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ekPttuLNb0fF352/eXOvXpTgRwbJI5t/dQy+XyiN8zm4aAPPdNY4RFzRkG+5qOUKguVxbP4ctYedsdA2mzMBvpzuMdUSx7n+2C8czt1Hrofmi18sCNaBGMKkH2LaNaKYpMJSKhgDDKYNvlb7w/DB8NarqltFxFHtIolkTlkz8FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engicam.com; spf=pass smtp.mailfrom=engicam.com; dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b=Efl6Y62k; arc=none smtp.client-ip=62.149.156.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engicam.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engicam.com
Received: from engicam.com ([146.241.8.107])
	by Aruba Outgoing Smtp  with ESMTPSA
	id 1NLxsVDmQ8U421NLysOAhR; Mon, 29 Apr 2024 11:31:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
	t=1714383078; bh=yJ5DK+frYviDBgPRfGTLYiMKxN5TUIopuDDTaKC/Srs=;
	h=From:To:Subject:Date:MIME-Version;
	b=Efl6Y62k/mhVHHzL3cXuAwVI65xaLEQL5TDjW2bOvZlqZHA3p+qDkMJ2PUA3paMRc
	 PVecczy84rqe+PRHe28KN5G6p34wPNcRon5M7s9oLRFH2xU7OVshD7LuT7zRn6kfQU
	 RCb4O5t3YUjBDE8SN9PtgYn0XJ66MFNus6phIr8MPxP2vz/dgPfNRaizDjDku4m/0k
	 HHBLnEIEVtxLQs2UjFnHG8aP2vpYiK5Yxhk1GNOzpIY4VLyo3a9wizXGZXZqhNrLof
	 +ocdGFtSHM1ZoynfOqJ2NHgy1pqiQxLswll/T/rI6vsS9ZPkBfN14BMETiv4MI5jA8
	 dOyulDcCHOuow==
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
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v8 1/3] dt-bindings: arm: fsl: add Engicam i.Core MX93 EDIMM 2.0 Starter Kit
Date: Mon, 29 Apr 2024 11:31:14 +0200
Message-Id: <20240429093116.9346-2-fabio.aiuto@engicam.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240429093116.9346-1-fabio.aiuto@engicam.com>
References: <20240429093116.9346-1-fabio.aiuto@engicam.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfMjEokuSxgu8rdo8B5Qc0dov8DNzpZcvyqv6+gfR2HKlxrQ68OwtsPw4qkPkQEvVb9ieCpuD6onS8zCEfZUo2DzrqdIh/8fRMov3EVHb70alJErf1fym
 eecV1keRTq/Fsfu130ig9E6NvABopSZNjf8xDVVQWymHFC8HLKMBBAxJUTuSdVvaQtQwprW5Hwr/0C5TYg42+mvKsnPTYqI2bNQoxFGwVv6RJCil9Dwpjwsx
 9UcpSIiQ4S9/ZmyUP+r1AHEKlKW3mP7v6l7U9lZYlLEWI8njdYZwvbRAbckA/I6dp1/qs2GQIWX7f90wL7gP0cxNlNk75Aey2JLs/5Ly5vhH4KPHeMxbsuNq
 gwYZgL7/o0UNTVJE3fu4sU14mI2RyWNe/5/UAy2XRQJBbblX2TZhwcPcQl95l4dSYd5l08sswSvbOLgXtVrixSCkEM9hN0XVgflXrbgH74KYwqneFaH0dtgQ
 urlmRVXdr3mTOb5lSqReZE72ih3JUfjP3a1343+Q0BGb+Lyy9t2VGjaND6zvEr5DfuHdHnwPoZ2RsdZBldnW5k0RckGkADSxkUnJ0pbyzHnr2t+/pAfe3xkE
 /ndiPNkx8GR9yvh3C1H5jOrPKUvoyOxy/mzDVPyo+haVYwI33l+UVhFpCc323E8J0JCl2Xn/jMEDyJrRc9jAdRso

i.Core MX93 is a NXP i.MX93 based EDIMM SoM by Engicam.

EDIMM 2.0 Starter Kit is an EDIMM 2.0 Form Factor Capacitive
Evaluation Board by Engicam.

i.Core MX93 needs to be mounted on top of EDIMM 2.0 Starter Kit
to get the full i.Core MX93 EDIMM 2.0 Starter Kit board.

Add bindings for this board.

Cc: Matteo Lisi <matteo.lisi@engicam.com>
Cc: Mirko Ardinghi <mirko.ardinghi@engicam.com>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Fabio Aiuto <fabio.aiuto@engicam.com>
---
v7 ---> v8:
	- fixed tag in commit message
v3 ---> v7:
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


