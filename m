Return-Path: <linux-kernel+bounces-97879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48BE087711B
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 13:27:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79D911C20AAE
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 12:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A5DE3F9FA;
	Sat,  9 Mar 2024 12:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Buc5nCdH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D9E2D05C;
	Sat,  9 Mar 2024 12:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709987184; cv=none; b=Oyk/A8BWD+zEol1I5GJgVM26sr5ql5wPZrJE93RwG0bQP8/CpB8epzRdDtxh+fqxjDQ8UAMleffZo4YGmWG+hbCPri8ZjHiUjyu9ftHHPVaNRETFmm1g9eRYyXhJJyjuWJPkB77W5s3q2UXEH8Zxp2zo3S3GDe0LCasUy4AaVO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709987184; c=relaxed/simple;
	bh=7PtIg95ncCvxMHh4b5Xw5GAtbDAZ3d89g3e/YJ0Tj88=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aUiYJDXeKu4iVoHnNOoXdAkMiwsV9e5xKnvEdJKV7R9T4RXodj68ZN9H2COwEERdfuFcRQA/BILSX4AAjmPaK+fx/jjsdxempVYtN77Tn70oge91NgZL9IiSDdNmrYr6o7KTvryxpHc+xNWsCJRUdE/ApunuchuvU6JWRvVnodM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Buc5nCdH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 56A97C43390;
	Sat,  9 Mar 2024 12:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709987184;
	bh=7PtIg95ncCvxMHh4b5Xw5GAtbDAZ3d89g3e/YJ0Tj88=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Buc5nCdHqRJJnnQTDybTOkvl6KvTbX1JuPfeREiCCYihniikrIfBOJG0R8FyuX/e/
	 N8JHNNCENENOVTTo/Rou/WfxH7L03GzcZi60eXu88rQRXlIAcED/lpPBCVLldoeNCp
	 SWsJ/YGwiOAr1y0vQn6fX4VrlE0nqtkJrJyzbg+B+5cuHoFaMCSQOd/WLRlIOirWdW
	 CfucG1Eu4m2+YHihmoz6IknBZpN96bt4vvadJUfc0eSdfP/p3l6xY5NtrFsZ5Qprq9
	 EovnF0Q7rcFxejJeaQCam+tRH33vmI1NYwaL9/AsiPZVsFCy9ftzjgdjy0aSEpL5OR
	 B3dBWxHe1tAcA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37B38C54E4A;
	Sat,  9 Mar 2024 12:26:24 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Sat, 09 Mar 2024 20:26:24 +0800
Subject: [PATCH net-next v11 2/9] dt-bindings: net:
 hisilicon,hisi-femac-mdio: remove clocks
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240309-net-v11-2-eb99b76e4a21@outlook.com>
References: <20240309-net-v11-0-eb99b76e4a21@outlook.com>
In-Reply-To: <20240309-net-v11-0-eb99b76e4a21@outlook.com>
To: Yisen Zhuang <yisen.zhuang@huawei.com>, 
 Salil Mehta <salil.mehta@huawei.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Yang Xiwen <forbidden405@outlook.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709987182; l=1118;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=zFRj07D287wM/dCKue4SsEqnuuC7qPQ9ydZbNJ2lxsQ=;
 b=/Wr0Wapem+14yZEJl1OghbGR2tE6gSM+BhDcrr6KVIqfeDNmXIw/RtVleGMIOHW3Fx9e2Gdk/
 zmCVOjOnlilCSIhsjDIlEA7TPJBEGaeSiJp3D+oedfsBBSGT4u7iHKI
X-Developer-Key: i=forbidden405@outlook.com; a=ed25519;
 pk=qOD5jhp891/Xzc+H/PZ8LWVSWE3O/XCQnAg+5vdU2IU=
X-Endpoint-Received:
 by B4 Relay for forbidden405@outlook.com/20230724 with auth_id=67
X-Original-From: Yang Xiwen <forbidden405@outlook.com>
Reply-To: <forbidden405@outlook.com>

From: Yang Xiwen <forbidden405@outlook.com>

This integrated MDIO bus does not have a dedicated clock. Remove it. The
old binding is wrong.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
 Documentation/devicetree/bindings/net/hisilicon,hisi-femac-mdio.yaml | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/hisilicon,hisi-femac-mdio.yaml b/Documentation/devicetree/bindings/net/hisilicon,hisi-femac-mdio.yaml
index 36def9d5eecd..dea1bcc27381 100644
--- a/Documentation/devicetree/bindings/net/hisilicon,hisi-femac-mdio.yaml
+++ b/Documentation/devicetree/bindings/net/hisilicon,hisi-femac-mdio.yaml
@@ -19,13 +19,9 @@ properties:
   reg:
     maxItems: 1
 
-  clocks:
-    maxItems: 1
-
 required:
   - compatible
   - reg
-  - clocks
 
 unevaluatedProperties: false
 
@@ -34,7 +30,6 @@ examples:
     mdio@10091100 {
         compatible = "hisilicon,hisi-femac-mdio";
         reg = <0x10091100 0x20>;
-        clocks = <&clk_mdio>;
         #address-cells = <1>;
         #size-cells = <0>;
 

-- 
2.43.0


