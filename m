Return-Path: <linux-kernel+bounces-91834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F28871757
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 08:51:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3966C1C21C8E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 07:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88EC27FBA8;
	Tue,  5 Mar 2024 07:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eVBhFvbM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11257E775;
	Tue,  5 Mar 2024 07:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709625072; cv=none; b=ow5Jtxo0QJjhT7R6U88oCtn4gqINKlf61dcaXz9ai000yI/4TIjfGkR/U523K/qAs1ABI14KoK27mL1tnMQ2vfw1r1NYBGez8hycJOZ46o4wDki2zWMCTl750OlaRJ08Yd/D0CNpcY7Xy6V1412Uijj4rPB5Yz30j3txce56q2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709625072; c=relaxed/simple;
	bh=LFNIOfkegJnCP0scLIaYXcJC1OdZyxYPTASiv2DQEnU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=cOH8OevM+NJN28zsx8gBOWrbueISnitYSkIz1dye5xWv9GavYvkeyWbXhA0JdXMZlnGjqleKC6t94xmB/2yeCKjprJ+GXSiJu8psxvPIqy2Y2mC+uRUrEjKiLxtnotCr3YV2QFh8oBQpfh9lXOjmkqrNByhcKUKVdRX9A01tUnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eVBhFvbM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 39699C433F1;
	Tue,  5 Mar 2024 07:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709625072;
	bh=LFNIOfkegJnCP0scLIaYXcJC1OdZyxYPTASiv2DQEnU=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=eVBhFvbMJv9VOf2n0gJG4agrIdZBbyucn1XVlCR/k8Q/6AYiPuxf90jAegUC21OHI
	 lLk0R5U/axdRL57d/VkwzTmffTCx+AoAiaVuMbJteIqbWidC6CankNDG7dDVI78H3U
	 r4by6xIpOP3ca0eiP3MX+MsngjYUaxkRB01VrXNSpF1Fq8ZxAXcklpe53FLM4U2N80
	 6yVpDrYuFsKGlzqSQJnSOtaL2zgRwS4GqZJyl98TOs9Car/5RaGFxeL6CrnKupxp0F
	 RkxpBiCjJdpck6EXmlgKo7CsOqkVR+YWNAW2/aemdBHMtJslsI2JQ418NMojSjc3wX
	 wH/Z3l8/Zll/g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D37CC5478C;
	Tue,  5 Mar 2024 07:51:12 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Subject: [PATCH net-next v8 0/9] net: hisi-femac: add support for
 Hi3798MV200, remove unmaintained compatibles
Date: Tue, 05 Mar 2024 15:51:09 +0800
Message-Id: <20240305-net-v8-0-166aaeea2107@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAO3O5mUC/23OTU7EMAwF4KuMsqbIcf5ZcQ80izZxmQhoUNupB
 o16d9JmQUdhaT1/z76zicZIE3s53dlIS5xiGvJgn07MX9rhnZoY8swQUAJy3Qw0N65FsMSNl9C
 zvPk9Uh9ve8sb2xYGus3snJNLnOY0/uz1C9/zh6aFN9AQtMEZ9KF17jVd58+UPp59+tobFvxHY
 VbWdUF2BrTyWCtxUAhFiaw6bUl1RpHRqlbyqLAouX1Irba9Ez04qJU6KlGUykqKDjEI54GLWum
 jskXprHQwNoignPW8VuZPCeBFme2WsiiUM0EG+ajWdf0F8mrwd+YBAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709625070; l=3362;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=LFNIOfkegJnCP0scLIaYXcJC1OdZyxYPTASiv2DQEnU=;
 b=OIoCiihOooTHqeLzR80GsvBLxaIHvbwecEUurwhEPN6INbXAd4Z+XfSTl3VYtdkD2r/6cCDHX
 kSTupnXZTvlA1GeZMWr3Rj5y64pgAls5FjHbHd9edhPDmBFiFyqzs37
X-Developer-Key: i=forbidden405@outlook.com; a=ed25519;
 pk=qOD5jhp891/Xzc+H/PZ8LWVSWE3O/XCQnAg+5vdU2IU=
X-Endpoint-Received:
 by B4 Relay for forbidden405@outlook.com/20230724 with auth_id=67
X-Original-From: Yang Xiwen <forbidden405@outlook.com>
Reply-To: <forbidden405@outlook.com>

Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
Changes in v8:
- remove MODULE_ALIAS: rewrite commit msg (Krzysztof Kozlowski)
- driver: use only SoC compatibles (Krzysztof Kozlowski)
- Link to v7: https://lore.kernel.org/r/20240301-net-v7-0-45823597d4d4@outlook.com

Changes in v7:
- dt-bindings: squash a bunch of patches to YAML conversion (Krzysztof Kozlowski)
- dt-bindings: drop phy-mode->phy-connection-type conversion (Andrew Lunnm, Krzysztof Kozlowski)
- driver: drop SoC compatibles
- misc: some minor clean ups
- driver: remove MODULE_ALIAS()
- Link to v6: https://lore.kernel.org/r/20240228-net-v6-0-6d78d3d598c1@outlook.com

Changes in v6:
- add missing "not" in commit logs (Andrew)
- rework binding changes, split it into several commits (Krzysztof Kozlowski)
- Link to v5: https://lore.kernel.org/r/20240223-net-v5-0-43b22d39c013@outlook.com

Changes in v5:
- hisi-femac-mdio: remove clock completely (Krzysztof Kozlowski)
- dt-bindings: mdio: apply comments from Krzysztof Kozlowski

Changes in v4:
- edit commit log to show why mdio bus clk is optional (Krzysztof Kozlowski)
- add clk_bulk_disable_unprepare() during error path (Maxime Chevallier)
- remove of_node_put() (Simon Horman)
- remove histb-clock.h header in binding example as it's goign to be deprecated.
- rearrange patches so binding comes before driver
- Link to v3: https://lore.kernel.org/r/20240220-net-v3-0-b68e5b75e765@outlook.com

Changes in v3:
- rearrange patches to fix bot error. (Rob Herring)
- rewrite commit logs (Andrew Lunn)
- use clk_bulk_ APIs (Andrew Lunn)
- fix uninitialization use of ret (assign to -ENODEV before goto) (Simon Horman)
- Link to v2: https://lore.kernel.org/r/20240216-net-v2-0-89bd4b7065c2@outlook.com

Changes in v2:
- replace email.
- hisi-femac: s/BUS/MACIF (Andrew Lunn)
- hisi-femac: add "hisilicon,hisi-femac" compatible since the driver
  seems generic enough for various SoCs
- hisi-femac-mdio: convert binding to YAML (Krzysztof Kozlowski)
- rewrite commit logs (Krzysztof Kozlowski)
- Link to v1: https://lore.kernel.org/r/20240216-net-v1-0-e0ad972cda99@outlook.com

---
Yang Xiwen (9):
      dt-bindings: net: hisilicon-femac-mdio: convert to YAML
      dt-bindings: net: hisilicon,hisi-femac-mdio: remove clocks
      net: mdio: hisi-femac: remove clock
      dt-bindings: net: convert hisi-femac.txt to YAML
      dt-bindings: net: hisi-femac: add mandatory MDIO bus subnode
      dt-bindings: net: hisi-femac: add binding for Hi3798MV200 FEMAC core
      net: hisi_femac: remove unused compatible strings
      net: hisi_femac: add support for hisi_femac core on Hi3798MV200
      net: hisi_femac: remove unneeded MODULE_ALIAS()

 .../bindings/net/hisilicon,hisi-femac-mdio.yaml    |  39 +++++++
 .../bindings/net/hisilicon,hisi-femac.yaml         | 120 +++++++++++++++++++++
 .../bindings/net/hisilicon-femac-mdio.txt          |  22 ----
 .../devicetree/bindings/net/hisilicon-femac.txt    |  41 -------
 drivers/net/ethernet/hisilicon/hisi_femac.c        |  77 ++++++++++---
 drivers/net/mdio/mdio-hisi-femac.c                 |  18 +---
 6 files changed, 220 insertions(+), 97 deletions(-)
---
base-commit: 90d35da658da8cff0d4ecbb5113f5fac9d00eb72
change-id: 20240216-net-9a208e17c40f

Best regards,
-- 
Yang Xiwen <forbidden405@outlook.com>


