Return-Path: <linux-kernel+bounces-87865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D9B0586DA28
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 04:36:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4291B23671
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 03:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89E494F5EA;
	Fri,  1 Mar 2024 03:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RPAnhxU6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A254596C;
	Fri,  1 Mar 2024 03:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709264160; cv=none; b=gAc6RGhwXRXmLjB/hh9FdTBWKdsDfuC1t2TFfO7eRnMNMpxg9cKFliJ4xaUTlBK47/LaJ67oyK+e/gQPFAK9rL820LEZ3M8/z5vNqY/2e1zyi9yD0JaIy4ZgDPgX2KhQY5sNs527WiugX028qQzvNBJNQTonklimluTJh0U9CXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709264160; c=relaxed/simple;
	bh=7PtIg95ncCvxMHh4b5Xw5GAtbDAZ3d89g3e/YJ0Tj88=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LIAq/89dKHEvb9yjFNUOfOlYQ7tDoL4QQ7Nj2hW0nMumP2wCvj6ysiFgNLEzvdAbfN+WBgXlYoq6L3Z+YM8xP8ZrHrXOehoG7vB7GSRK9mTOPF1jYTfLEiSVqF7kSW+KdY8KvL9sWP6zkOnDRDdywJgQ4KOIL3v+0bx733uRoow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RPAnhxU6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 86580C43390;
	Fri,  1 Mar 2024 03:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709264160;
	bh=7PtIg95ncCvxMHh4b5Xw5GAtbDAZ3d89g3e/YJ0Tj88=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=RPAnhxU6yR03wfaviKp8EQdwG/NOhrTu1a9mxGtCb/wxNGRmn3OiZn3fGDDDt6n11
	 63BFzgNIn1joFTgy2s+b3iExiBu2HBwyKCtsTOA3Ct0h8DENGkwINM/wxyJhNwRBgb
	 feucdy3LizQFmbyi0KqPMXJmvSN/+3YrtnRefJ0IbI/jeo2T+c/TgqEWh7stedwqRd
	 C3Oq7GU47WYWAtzmmtenAxZJYJOe9wjZG6vDQ8pRi2NDCB537d3zQRfl+gCcPtnZSm
	 XGhWYeJnM+XavxWb9FPr77Otso2m/eU2O9NxCi2je2ZEFbHKI+tQXyPPnUx017/VHk
	 VUR7Va1bqgvJA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6382EC54E55;
	Fri,  1 Mar 2024 03:36:00 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Fri, 01 Mar 2024 11:35:55 +0800
Subject: [PATCH net-next v7 2/9] dt-bindings: net:
 hisilicon,hisi-femac-mdio: remove clocks
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240301-net-v7-2-45823597d4d4@outlook.com>
References: <20240301-net-v7-0-45823597d4d4@outlook.com>
In-Reply-To: <20240301-net-v7-0-45823597d4d4@outlook.com>
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
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709264157; l=1118;
 i=forbidden405@outlook.com; s=20240228; h=from:subject:message-id;
 bh=zFRj07D287wM/dCKue4SsEqnuuC7qPQ9ydZbNJ2lxsQ=;
 b=OK4PrSktWk34tayOmh4vUrfwolvI7Ts8AYHGoH4VDtzyzhZWw4IIHtDdka2r0vPXCQyWy5K6q
 qfOu7YmPwwdAUlCYpi6yp52xMRStatRk056d6SAvft7zvN2t8qAT6l7
X-Developer-Key: i=forbidden405@outlook.com; a=ed25519;
 pk=KAWv6ZzFsT54MGllOczJgFiWB+DuayEmyn24iiVVThU=
X-Endpoint-Received:
 by B4 Relay for forbidden405@outlook.com/20240228 with auth_id=136
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


