Return-Path: <linux-kernel+bounces-96670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD7B3875FCB
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 09:40:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F18341C2191A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 08:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD952535DA;
	Fri,  8 Mar 2024 08:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jvC/eoaj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983DD2D634;
	Fri,  8 Mar 2024 08:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709887185; cv=none; b=euiScvI3u7DRzLvFfWwKXbaqygE1Q8TxaktMqOEM/5Yc0h3ouAjhVKR2SvCjs32BN8Yi2PlZNWtcoPtkwi1b4+0G4w9fHrIOUQ+328MpZianZW4F+3jXDEBJWaD7FkEX/FduQllf8hviCP7muT55ymO1dEx/lteAa//nwVsRXSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709887185; c=relaxed/simple;
	bh=fpjJ+KIH4JMq/xdgl2NY6xMV1rC3blGItlCeexND23s=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=DC7oiCeoeCRq6EAGvIcx/ryRNr6dqAkE20rCLE4D7qLjHVljt+8UT4Ul+BKIWyTnsgbJZ+Sbamrjp1coq2KPv2X7XwwokTIDBLXWFPq5n/MBnWkEbNlgJlQJkzTPTuq1m/eJjaJfXMV4g0KzO3/BjGieLYg+PeoN3nnolfSt4bA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jvC/eoaj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 17A74C433F1;
	Fri,  8 Mar 2024 08:39:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709887185;
	bh=fpjJ+KIH4JMq/xdgl2NY6xMV1rC3blGItlCeexND23s=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=jvC/eoaj9YJGXUKKZh6vButsRAd1fo/S5vkAPNXUC7vBA7dT0Wt/Qc3TGTOJVy+7j
	 41F3iOyET8Sbvyy4hyI14n8kqjnTRZAfsnm63HOKeajBzKdOQ7UfoaW7PGi++RSEiX
	 UHOA5nR3tsO5nxVsKWmv6kxHGrUeSk516qtd3zO04LZWatO+1bi1ATF60O5LQujTKr
	 GJLRciTjzHFHgnnxwitD6J1e+iXqDAExUSscPR7O2X3zkoWwIW+Io/32aHBVAwwiIc
	 04cRXx5/CvQWTCuC+Tjk+M5VDfECVSpDuCBCRTob09xWc49otOhJG/12twnoePsYua
	 OkLLYyEFDKumA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01339C5475B;
	Fri,  8 Mar 2024 08:39:45 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Subject: [PATCH net-next v10 0/8] net: hisi-femac: add support for
 Hi3798MV200, remove unmaintained compatibles
Date: Fri, 08 Mar 2024 16:39:42 +0800
Message-Id: <20240308-net-v10-0-3684df40897e@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAM7O6mUC/23PS07EMAwG4KuMsqbIcd6suAdikSYuEwENaks1a
 DR3J20WdBSWjv39dq5spinRzJ5OVzbRmuaUx1JweDixcPbjG3UplgeGgBKQ626kpXMewRI3QcL
 AyuTXREO67DEvbBsY6bKw19I5p3nJ08+ev/K9f5e08g46Ah+dwRC9c8/5e/nI+f0x5M89YcV/F
 BZlXR9lb0CrgK0SB4VQlSiq15ZUbxQZrVoljwqrktuF5LUdnBjAQavUUYmqVFFS9IhRuABctEo
 fla1KF6WjsVFE5WzgrTJ/SgCvymy7lEWhnIkyylbZo1JV2aK41t6XzyEH0yp3VKYqt11IEAZBW
 lkZ79XtdvsFVKaEx1MCAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709887184; l=3722;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=fpjJ+KIH4JMq/xdgl2NY6xMV1rC3blGItlCeexND23s=;
 b=STFT050VODmeZweSzsU25Hi2/wEkyc9rSfX99pEKiqW5NXaT/wvH2trbDVdYsKgzbZxU9wL0G
 SNPKfsDi2ZICDs5Yy09AIk3g47IaBxm3OqFEPcSVTesgOj+9U39urxO
X-Developer-Key: i=forbidden405@outlook.com; a=ed25519;
 pk=qOD5jhp891/Xzc+H/PZ8LWVSWE3O/XCQnAg+5vdU2IU=
X-Endpoint-Received:
 by B4 Relay for forbidden405@outlook.com/20230724 with auth_id=67
X-Original-From: Yang Xiwen <forbidden405@outlook.com>
Reply-To: <forbidden405@outlook.com>

Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
Changes in v10:
- binding: make hi3516cv300 the fallback compatible (Krzysztof Kozlowski)
- driver: drop mv200 match string (Krzysztof Kozlowski)
- commit msg: remove #conflicts
- Link to v9: https://lore.kernel.org/r/20240307-net-v9-0-6e0cf3e6584d@outlook.com

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
Yang Xiwen (8):
      dt-bindings: net: hisilicon-femac-mdio: convert to YAML
      dt-bindings: net: hisilicon,hisi-femac-mdio: remove clocks
      net: mdio: hisi-femac: remove clock
      dt-bindings: net: convert hisi-femac.txt to YAML
      dt-bindings: net: hisi-femac: add mandatory MDIO bus subnode
      dt-bindings: net: hisi-femac: add binding for Hi3798MV200 FEMAC core
      net: hisi_femac: remove unused compatible strings
      net: hisi_femac: remove unneeded MODULE_ALIAS()

 .../bindings/net/hisilicon,hisi-femac-mdio.yaml    |  39 +++++++
 .../bindings/net/hisilicon,hisi-femac.yaml         | 121 +++++++++++++++++++++
 .../bindings/net/hisilicon-femac-mdio.txt          |  22 ----
 .../devicetree/bindings/net/hisilicon-femac.txt    |  41 -------
 drivers/net/ethernet/hisilicon/hisi_femac.c        |   3 -
 drivers/net/mdio/mdio-hisi-femac.c                 |  18 +--
 6 files changed, 161 insertions(+), 83 deletions(-)
---
base-commit: 90d35da658da8cff0d4ecbb5113f5fac9d00eb72
change-id: 20240216-net-9a208e17c40f

Best regards,
-- 
Yang Xiwen <forbidden405@outlook.com>


