Return-Path: <linux-kernel+bounces-151609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A74E88AB117
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 16:53:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA12C1C211BB
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 14:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A781812F385;
	Fri, 19 Apr 2024 14:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b="nlNPd1JA"
Received: from smtpcmd0872.aruba.it (smtpcmd0872.aruba.it [62.149.156.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3DA412F380
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 14:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.156.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713538390; cv=none; b=aU1ju4fFsl06o6xj6uogFXWLwjKYqBs3qn6ii0N+T+KhMQUnaWivethjVwfepNL54yA0v0DVFV4hXqJ82xn3L3+eJhcyhls+bKdwX/Q8QZQEUeTzCc9V77CbXkLvNxhS73kiOG9x3sEsbKLoafJh6jwoDZtSys0WIeZ1es8TXuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713538390; c=relaxed/simple;
	bh=zYKq99FX6bSTj9flwcYNc4uocVSd8mkKIJiOpYzrO5s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DW1dqp01GGEVII5AyLXdsi1uVcbj6OISmN283I0qC9WH0WoEiwicpl9ZmVDMCF0vSoChNJfmoDiyF2RkgjtETjMZiKf9LzNpSMy5jB41QqAPaS1jm2m8xpNDtmkmQwz/a2p5dydYjlZQi7X7oFYI8Dl4SChmN1/+5lY/G1tlS08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engicam.com; spf=pass smtp.mailfrom=engicam.com; dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b=nlNPd1JA; arc=none smtp.client-ip=62.149.156.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engicam.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engicam.com
Received: from engicam.com ([146.241.23.200])
	by Aruba Outgoing Smtp  with ESMTPSA
	id xpYprTscuBZCLxpYsrR4th; Fri, 19 Apr 2024 16:49:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
	t=1713538198; bh=zYKq99FX6bSTj9flwcYNc4uocVSd8mkKIJiOpYzrO5s=;
	h=From:To:Subject:Date:MIME-Version;
	b=nlNPd1JAXesqRglLTXuwVX0O0OsC8SH/KqKMD4azvbpOL7sh6d/Z3apTkXYPBs58d
	 9XqaG9A73RnmDt/w3XquP6NYA8n3T6iVB6rETt2LRgs7mLmXDnDzDY+uHMpuDwk7dV
	 hEIK8GQ82AOnfiJx5IEQ2RwNjJkv1gynG7B3whS1RDxsHqiVsGWYt3Sv6SSeQrJXqc
	 uge5Cgyf/E6JhfijtZGTnZXPAqKf9wJzctYQ9PlnWpyrdgpTX0qINEfrtmvwaHn7Ri
	 pP2aDzlQzO9jpxEiOVoFrIeXxT+R+bDGguxLonuyugKgUw0hyPilhghHwV/J7dJk+M
	 L+6gEswYelJLA==
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
Subject: [PATCH v3 1/3] dt-bindings: arm: fsl: add Engicam i.Core MX93 EDIMM 2.0 Starter Kit
Date: Fri, 19 Apr 2024 16:49:51 +0200
Message-Id: <20240419144953.8700-2-fabio.aiuto@engicam.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240419144953.8700-1-fabio.aiuto@engicam.com>
References: <20240419144953.8700-1-fabio.aiuto@engicam.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfFo4JUBZwzm009nJ7bZbsQToPtL1WuiHrMH5BlyIi9hFk9/DXdbwK2z7r/FGpI/rRoSTXCINQoxNtXxbK1L8fSaRJZJYcs2yoXfyUsWN9jDHMPbJ5JvW
 bEXA/DmyTJyZvejX5jIZ39DEiHvQ0fIGK47VF/D93ZZ/ZVLbspyHOl3AFUR24Dmmn+7a+8MJaCxsHefR1/yAkMe4ghmrwkL+hKsxcKfdbY/Xy+g7FtEFWkKL
 k7PJoLzqkMHuUQWQEq9r9DBDSEEO05nwLoqfAtf5Xcss77l3q56wIiWkZfmKyVYXnEXd+kmbUzCQHF5AF++cFEGIAi2AqpSpa8EfMefSMyXjS0HnmToYbHV2
 yyeOdX0z6+JolCCeacJZl04UF4p9LP5rev61sNvTGEGsvj8T0Sv4pyV4Gu0yJbAcb+5Cmyl2ZV5SprKmr4XrrflfTA6LLBa0lvOTMa9GFGzH5zjczegQ3vMC
 uiHbMBed8HvEM9p7YJeZPgHNFkG6S2aHw8hnUfGQb9HNSiPT3ILDE+auxP4banXX1mBdohhGzxCsZd3DHnlckJog3ufSCDNad/o1bdiMSzbDLMBS1vIU/rLk
 t4/44mI0HYMoBk8DPsOBzUtIzTsLbFT+UU9TfsJkI6Y2stPd+vLi+jftDRBUMp2SZ14cQz7/69augVqtZ+AoxwqQ

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


