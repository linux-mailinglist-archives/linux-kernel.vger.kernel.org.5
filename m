Return-Path: <linux-kernel+bounces-91835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BA11871756
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 08:51:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32DB4B21855
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 07:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7500F7F7FA;
	Tue,  5 Mar 2024 07:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GJY4LqPQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10E318E1D;
	Tue,  5 Mar 2024 07:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709625072; cv=none; b=JE8VVDnW57inrFrITNfImjlLUOAzCOEcnw1K2+OH0ByBY6x7y8Ts0lg7w+1+90rWoqznuuIAN78hZTLuYSf+Tm3aTs8lIu1aOWUwBj3KbDF5Gkj8VYQF2TtA2XsWqVkKbhBPQnN+Bp0GCshqlbu26D3xnuLnYQh/vxgxtET2jhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709625072; c=relaxed/simple;
	bh=7PtIg95ncCvxMHh4b5Xw5GAtbDAZ3d89g3e/YJ0Tj88=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lrIGMPokDor86HGDAJ8Da2qpAyuwSke0ET1FqIDuyk3xtjyq8xzvhiWeqE5lnHNmrbcMaqavx0C+1vHoTdduio+fQNJDsUDrWmdREFzsZo4ABWjzyxaVpdHR/j5Pxt/VqlLTBf6Z4PbeU9T8W7jxtVk5hxqmvkTvUjflYphFyhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GJY4LqPQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4D811C433C7;
	Tue,  5 Mar 2024 07:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709625072;
	bh=7PtIg95ncCvxMHh4b5Xw5GAtbDAZ3d89g3e/YJ0Tj88=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=GJY4LqPQNmaI3mCPhhtrJx/x8oL9I54ycWY1vTD1Ye04ugdovyeO5FHAXWF+66yYm
	 TSjV1jkmr+4jD/2UarluMNxXAezXS5pib+3Ws96BmbvABYXwwh7qDpaI4jtAriss7X
	 dXL4+qAqUjS2KxHtj2+MyLI1Qbt40xfneaeH7bRHkJoKWCnNdtc3qhaQsAcBKIn6T6
	 NR2dB0Va/Ha+UaegGgsO+PfF24uxNxoL8+8DmxFU8MPuWEMOQtkHaDUZQzFoo9DM5q
	 F1X4jga7YoChIRiArgmVVuf/t2qJCNNXKOGJJM+MrkqzywEIlCVO5eaNKriX9G4rCv
	 2lJvRWiQXB7BA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36F7CC54E55;
	Tue,  5 Mar 2024 07:51:12 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Tue, 05 Mar 2024 15:51:11 +0800
Subject: [PATCH net-next v8 2/9] dt-bindings: net:
 hisilicon,hisi-femac-mdio: remove clocks
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240305-net-v8-2-166aaeea2107@outlook.com>
References: <20240305-net-v8-0-166aaeea2107@outlook.com>
In-Reply-To: <20240305-net-v8-0-166aaeea2107@outlook.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709625070; l=1118;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=zFRj07D287wM/dCKue4SsEqnuuC7qPQ9ydZbNJ2lxsQ=;
 b=7ZM4LlkywvpT9Sg2uxbbVgwRYe4NPQiS1o5MQjDpWXhrIUZxZGr4XbmI8qnJxc9sNvNQakdDF
 Nx5LVi1axk8D/vNnIk4rx6nGwBtNvo0krW4GnkCj7E+1tOoTRdSCKzr
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


