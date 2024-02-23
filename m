Return-Path: <linux-kernel+bounces-78378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E42D8612B5
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 14:29:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A241285B39
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 13:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFA848004C;
	Fri, 23 Feb 2024 13:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u4rQ22jH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0BBD7EEF9;
	Fri, 23 Feb 2024 13:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708694909; cv=none; b=G5m3xwlSuozfmiWyEhPUzHZeYysfYOd7gs3eaEI73Wk79lV0kHGcCOOKLZbIcQJELMr01FxGTGNbOHBAfOFvAN+4E3jiYhha9e5LYX0yuWPPr48v3xkIWNu90tA5AZ43gKNImiX8hM45phGMXwWMuIotOfPnTwS2sCyPVeMU1wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708694909; c=relaxed/simple;
	bh=pKcNTK6Z5tI0bFy5+Tq7Gks61H4UMrpzQSq2t9t4RXM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MaSN0BMvJbFPUIuoTfcxLfxlUFou6MZIpk5Zft3vXwykNT9LI5b1zoU6HkiD47D4fBxPtic9A0QgnBAt7bVimze0qr0Q57wo6ocdtY5pRfiKCTZ31IHltMA1QCQ6DSeZ5UPXL70hpE9Wmx0YSYzwdl/yvTsAX9I6TYXgnO4XRTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u4rQ22jH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9598FC43399;
	Fri, 23 Feb 2024 13:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708694908;
	bh=pKcNTK6Z5tI0bFy5+Tq7Gks61H4UMrpzQSq2t9t4RXM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=u4rQ22jH7vAS1bu9N0AEiUri752pKDqizrCuzOrI9l/w/dRmMAwbI54YV/LBYP/Pi
	 gGQLDBRpTWFKJTmXaBmImn0i2l4GSWHBCGDn3YovyUohCb+G+IRbAULfx9SpBJNDw+
	 xYG0wpCA7zF/pSZC8EFZmafcE8mLzxyY54GOfQ6R16AxrLZ1rodC6FuyYQ0mvvycGo
	 qZl1BPkHwjYNgvpGUBNPJzYEYgowYZi3ta2U9rgrlPWJCrTBZl05VCiEqxEMKMzxZp
	 aPVL8ivAyGvP37eChdFsZbXjE7xGfEioRYeHwCzDQTO6jfnX/IIySQJXF1SGec2qXG
	 AIU75G3YZsJ7w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DF40C54E4C;
	Fri, 23 Feb 2024 13:28:28 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Fri, 23 Feb 2024 21:28:17 +0800
Subject: [PATCH net-next v5 2/7] dt-bindings: net:
 hisilicon,hisi-femac-mdio: remove clocks
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240223-net-v5-2-43b22d39c013@outlook.com>
References: <20240223-net-v5-0-43b22d39c013@outlook.com>
In-Reply-To: <20240223-net-v5-0-43b22d39c013@outlook.com>
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
 devicetree@vger.kernel.org, Yang Xiwen <forbidden405@outlook.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708694896; l=1050;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=WNDjoyByLxxs8bx1Sb+vpJXUIZZVY7VH/gcmrFa/1O0=;
 b=T+lHIqiFV8xSDm+DEj4YrnNc7Fw0mujhLx7dvbgq4044z4hs+wh3c2n96QQ33hqr7MfKPP+FZ
 LeOYo3y+456CW94jNl6PmGsPSs5FARGaJW7jCNJB/OtlCnp/BZmqgko
X-Developer-Key: i=forbidden405@outlook.com; a=ed25519;
 pk=qOD5jhp891/Xzc+H/PZ8LWVSWE3O/XCQnAg+5vdU2IU=
X-Endpoint-Received:
 by B4 Relay for forbidden405@outlook.com/20230724 with auth_id=67
X-Original-From: Yang Xiwen <forbidden405@outlook.com>
Reply-To: <forbidden405@outlook.com>

From: Yang Xiwen <forbidden405@outlook.com>

This integrated MDIO bus does have a dedicated clock. Remove it. The old
binding is wrong.

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


