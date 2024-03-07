Return-Path: <linux-kernel+bounces-95425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B60A3874D8C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 12:35:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4411B1F2358C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 11:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93BE412AAD5;
	Thu,  7 Mar 2024 11:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TROdJQPQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23EA12880A;
	Thu,  7 Mar 2024 11:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709811289; cv=none; b=Oc2xvgLoXlr1RsNyDMeQTpNdqu13x6N5RYynE9FaREXQ+29gf0+dn4NI7tqSRJR1aNVKEogWtHc8r6yhGHhAjbII2vPHdJRuHU2e6GpxOg9v0Q0zhA4diLkvWnhhuYuaP88eXD2VQmC238bj2vorADe/wYsMPDy2WVik4BsLHzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709811289; c=relaxed/simple;
	bh=srvNJpqSk/taaFXpsEyk9citjjpIL0QxkmUKGM2SEtY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=n4OfzCtNOMaS5WFs4dmkSiUsG6Ov/S8+FLLExf87vbxX1OAVyQAx/7rSqcz8j7LaICATQaFj5jH+s6HMhGmp9pB1Ykik2kK3RPplM42SXQsIW5pDAMkwRNkvSgSx0uUzKHcK9R+kIburMUvxt/gb43SPELAeD7hNapUqUer54o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TROdJQPQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3F90CC433C7;
	Thu,  7 Mar 2024 11:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709811289;
	bh=srvNJpqSk/taaFXpsEyk9citjjpIL0QxkmUKGM2SEtY=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=TROdJQPQnjG0IZnIsIsxPjW69WIhftjVKfL4Zg+QCJrHlJRo/mExskCnV2t1zsFao
	 JH2j/rLd3NL0ueib6nZOjxalslk1ztrvPj7LQABjINB9ohCbbsMDQeipALaqCo6qN6
	 E9Tz//nUokWdmZDgx/cXN436qo6VU4Ggj3DnQ0frobNbSL4geD6IpO7EiDjbFDqsF5
	 4+yJu8nrY3CdKkr6acbmNHxaZW25Jp63U14DMu1gC2gqIbP1hSk3rdtCYR+bljavSi
	 XaRW84X3tZ47132AkqSYYc9cL9J5htEO7fJWrorum15YE5fnGs1DHIMaHIB76VnXpp
	 N2ZNPIEjs6KkA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2817BC54E49;
	Thu,  7 Mar 2024 11:34:49 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Subject: [PATCH net-next v9 0/9] net: hisi-femac: add support for
 Hi3798MV200, remove unmaintained compatibles
Date: Thu, 07 Mar 2024 19:34:46 +0800
Message-Id: <20240307-net-v9-0-6e0cf3e6584d@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFam6WUC/23PS07EMAwG4KuMsqbIcd6suAdikSYuEwENaks1a
 NS7k2kWdBSWlv39tq9spinRzJ5OVzbRmuaUx1K4hxMLZz++UZdiqRkCSkCuu5GWznkES9wECQM
 rk18TDemyp7yw28BIl4W9ls45zUuefvb4le/9u6SVd9AR+OgMhuide87fy0fO748hf+4JK/6js
 Cjr+ih7A1oFbJU4KISqRFG9tqR6o8ho1Sp5VFiVvF1IXtvBiQEctEodlahKFSVFjxiFC8BFq/R
 R2ap0UToaG0VUzgbeKvOnBPCqzG2XsiiUM1FG2Sp7VKoqWxTX2vvyHHIw92rbtl8M/5kTHAIAA
 A==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709811287; l=3539;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=srvNJpqSk/taaFXpsEyk9citjjpIL0QxkmUKGM2SEtY=;
 b=c5qZyE/AL5bUtZKngDHzVgMHS5Wk5EzX5+U45i8CKwUAu5gbRIA5/DgKhh5NdFA9Z+nT1mf+s
 54hmkjr0Z7AAkUaCepZhU/5nDIeCLw7luLAmX1YH63JnL4nO+XxBi+j
X-Developer-Key: i=forbidden405@outlook.com; a=ed25519;
 pk=qOD5jhp891/Xzc+H/PZ8LWVSWE3O/XCQnAg+5vdU2IU=
X-Endpoint-Received:
 by B4 Relay for forbidden405@outlook.com/20230724 with auth_id=67
X-Original-From: Yang Xiwen <forbidden405@outlook.com>
Reply-To: <forbidden405@outlook.com>

Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
Changes in v9:
- binding: remove generic fallback compatible as it's not used in driver
- Link to v8: https://lore.kernel.org/r/20240305-net-v8-0-166aaeea2107@outlook.com

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
 .../bindings/net/hisilicon,hisi-femac.yaml         | 118 +++++++++++++++++++++
 .../bindings/net/hisilicon-femac-mdio.txt          |  22 ----
 .../devicetree/bindings/net/hisilicon-femac.txt    |  41 -------
 drivers/net/ethernet/hisilicon/hisi_femac.c        |  77 +++++++++++---
 drivers/net/mdio/mdio-hisi-femac.c                 |  18 +---
 6 files changed, 218 insertions(+), 97 deletions(-)
---
base-commit: 90d35da658da8cff0d4ecbb5113f5fac9d00eb72
change-id: 20240216-net-9a208e17c40f

Best regards,
-- 
Yang Xiwen <forbidden405@outlook.com>


