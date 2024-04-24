Return-Path: <linux-kernel+bounces-156558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CC7D8B0483
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 10:39:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E24E72898AC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 08:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BD42158A15;
	Wed, 24 Apr 2024 08:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b="MDcnI1Gv"
Received: from smtpcmd01-g.aruba.it (smtpcmd01-g.aruba.it [62.149.158.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6730156C72
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 08:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.158.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713947976; cv=none; b=tJgoOJihO5Ww/RGGepnMyTW1E4RSHdBuE6sh+yA2Y6t5nMVkeehmYCvqBIVwEWoYPhUtyrbA2RM9zg7Imv0GlQ4oh0YojX0xzAOpr6xEeaK+ufkQ4bxcayHOJ4R3vnjf8mpTmp6Iv1KAIHT3egCdLr58MDLheK1Glteo3OCb8+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713947976; c=relaxed/simple;
	bh=zYKq99FX6bSTj9flwcYNc4uocVSd8mkKIJiOpYzrO5s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rlhAnS4G4zLhjOtIzzqwjvVanEMqdznThpkzCk1aevobmZKZvya+Ge3h4rmwOJLAQWCQeO9EUMmys3HAyjND1544RCYXnmpem4b6jU2AhXTUOIS+gXxdCMl4y82/B7B+3tNgWsxeCC/6p1MoRzJkrlNT8A0/pP4O9DCJ6Kyn++0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engicam.com; spf=pass smtp.mailfrom=engicam.com; dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b=MDcnI1Gv; arc=none smtp.client-ip=62.149.158.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engicam.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engicam.com
Received: from engicam.com ([146.241.29.4])
	by Aruba Outgoing Smtp  with ESMTPSA
	id zY75r7sLxwy3rzY77rdApr; Wed, 24 Apr 2024 10:36:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
	t=1713947786; bh=zYKq99FX6bSTj9flwcYNc4uocVSd8mkKIJiOpYzrO5s=;
	h=From:To:Subject:Date:MIME-Version;
	b=MDcnI1Gv46ZhVtGeckp8i9Bsux/NfNUGKtmZxZVZ3CD7aPKTqWClt6z4I7hPB/bEk
	 ikmFN9JUwQN0VojU5i31IXhOqOifWiDXtDCd/yNIOkE4udhbRUJS4ap6y2erW7PPTH
	 9peVI90dpD9O7xGOiERh/zzp1pJQ++NRH+0bxs6/tSrouuue52WYZTBUUkUzPxj/of
	 QMC5ps38I4AeNcrQgYxltsaO3AHLIzAkbiWgHnLvWlHNme7DHRcUU1uO2Aq1XywHFY
	 tqP4GIzxkOL4Wv3+F2vavT02sTR+4hSiehvLRRh0qiBK9V/FyYlUiHW3z9tQ++2L0T
	 aLaLiz4fVTozA==
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
Subject: [PATCH v4 1/3] dt-bindings: arm: fsl: add Engicam i.Core MX93 EDIMM 2.0 Starter Kit
Date: Wed, 24 Apr 2024 10:36:05 +0200
Message-Id: <20240424083607.11162-2-fabio.aiuto@engicam.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240424083607.11162-1-fabio.aiuto@engicam.com>
References: <20240424083607.11162-1-fabio.aiuto@engicam.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfNWrA2QwJIllrVeX8O9QWMHqSyyKKNYoWuYnQHHskYIutnelpB3bQjgKvAZtSX53lyIaXJgLRRCxTKwePb5xXY/nDDw3JApYFvx/I8bOGyqgSXzRrr8E
 DZgWrRnabjxhihVVYoDh6juEKyZWm7VotK2qJ4j25Bf4TsJ68e0piHPQMYuqjckvq/ZMHebCieKstBxGKYTBhGNX1uYAubj5ce6o6DQ7ldMdlMsrQwx+GDQ7
 /d1q+viSC41QTNfAcni/FN83+j1kQZaQ5dV2MVhocPg/4dCUpubRDy7cCSeTDRJ1GCwvic3OdcvX9oEJbfd8l9Imum2ywbebEzTaocDwXKFTU99pZlzJ/btO
 3LaskwBj2pUdw4765W3yUH6hFpX3bM/manaigK2Smbf4o8HfD5ggB4e6YpjQHh1+awh+YoG4neIUzXYoRNSX1ZWZDUPQNqvNKW2S6P1/fFwgiKa+V+B1qm/q
 e0a71ble6u/fHEGYRP9gjgY+iOEQPv4Mr+uV0fNTjbwj+lze85JcC7iauUQdMkMDxGuihkCz4G0UMIXi7Eg+WCH+/FBxttWiPxEGx3iyL0uQ9+v7wHBpBpdi
 3fBAi4B+Q1I+vjaHzI4hLXh2Kh1H+/1J3BqNSQuk7EujkWlF4kiY6r7eaPzGlLlEg8kx1Er52NGt+1yfv37UzTA9

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


