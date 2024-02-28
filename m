Return-Path: <linux-kernel+bounces-84721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93EFA86AAC2
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 10:03:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A2FB1F26064
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 09:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34A1037169;
	Wed, 28 Feb 2024 09:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lv2dK1kf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD702D60F;
	Wed, 28 Feb 2024 09:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709110947; cv=none; b=O7vLeHBuNHaLS4qsNpnHZ3ZizG4uk7TEMLKsGVVFLe9EqaJs6E556QbWVZdZOfJsvbghjPcy0k9vkZQHbJ/80ghHuvnj6YgIYAKdY5D/t/gUWQMtMeEO462axPTub3WzxZqQwq5vw6qd4bR1z4U0LoZg15X6c/hxakVkSBpZ3wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709110947; c=relaxed/simple;
	bh=HZVyfHOTe+v57yTden9brq8Q3xcBbqcgWJYLrxaXoYU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=lUtYiRh/FroGvzcSj+6EH7ZGJHySyXe2o/lsCgKJvqkWgji2/T9DDNWm2lDb4dWvLBsTMxFpseI/paBqgqULB1pvWEkzH8Zyz577qp1Pr8/ZFC6df+uaJ+sws1bBd696ZDt2Ns9bM5hENboCnon69JOMHun/QWeAfD74ZsWLRU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lv2dK1kf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8DE31C43390;
	Wed, 28 Feb 2024 09:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709110946;
	bh=HZVyfHOTe+v57yTden9brq8Q3xcBbqcgWJYLrxaXoYU=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=lv2dK1kfRrkTgyl/U/LWjN+ngjYOvbErxUPNFYH7VPPYwjpyCTf34wQBC/sZF3I1l
	 AdFlC9szG1NL1oCD/jdcO1drHIw5wpb+K6vJJFfpHBOPd9JsDM4RqFdhjkjlRMxGVU
	 sIWcwWdUq5+DpjLzYR36CvANdlbqOU/JIwBiDHTvuDAFj8+e8qbOTcV6rC7+CZwApb
	 kAZu8ErV06w/lBY9FehLYcetzqbgGq26NZgnzsgjdzjuq4vnammAtRCxU/TftzLZSP
	 70PIcwwnODPMs4EIpn023Swhp/pO8JpIO0El7OI0ypJIx9f4CkekB4qm1o0m6Y+4eu
	 QA7SVvNY+rYIw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A8F9C47DD9;
	Wed, 28 Feb 2024 09:02:26 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Subject: [PATCH net-next v6 00/11] net: hisi-femac: add support for
 Hi3798MV200, remove unmaintained compatibles
Date: Wed, 28 Feb 2024 17:02:24 +0800
Message-Id: <20240228-net-v6-0-6d78d3d598c1@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKD23mUC/23Oy26DMBAF0F+JvK6r8fiFs+p/VF34MSRWUlwBR
 aki/r0ObIjI8urOuZo7G6jPNLDj4c56mvKQS1eDeTuwePbdiXhONTMEVIDC8I5G7jxCQ8JGBS2
 rlz89tfm2rHyyx0FHt5F91each7H0f8v8JJb+aWkSHDiBT85iTN65j/I7Xku5vMfyvSxM+EJhV
 Y0LSQULRkfcK7lRCKuSVQXTkA5WkzV6r9RW4arU40PypmmdbMHBXumtkqvSVSkZEJN0EYR8VvM
 8/wPVJtGZegEAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709110945; l=2932;
 i=forbidden405@outlook.com; s=20240228; h=from:subject:message-id;
 bh=HZVyfHOTe+v57yTden9brq8Q3xcBbqcgWJYLrxaXoYU=;
 b=hzmdokhJv/A5BfSeWoxhpBE9FymGgCKXGBpVTg1FjKcc3SA+a74WLyw70OGVfb+h6XRCwQSfF
 lOh37SX5sV7Bv2M7dRw1JZKfi5A7sLQn6LpVJIA7GltFllw5Ewph+/+
X-Developer-Key: i=forbidden405@outlook.com; a=ed25519;
 pk=KAWv6ZzFsT54MGllOczJgFiWB+DuayEmyn24iiVVThU=
X-Endpoint-Received:
 by B4 Relay for forbidden405@outlook.com/20240228 with auth_id=136
X-Original-From: Yang Xiwen <forbidden405@outlook.com>
Reply-To: <forbidden405@outlook.com>

Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
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
Yang Xiwen (11):
      dt-bindings: net: hisilicon-femac-mdio: convert to YAML
      dt-bindings: net: hisilicon,hisi-femac-mdio: remove clocks
      net: mdio: hisi-femac: remove clock
      dt-bindings: net: convert hisi-femac.txt to YAML
      dt-bindings: net: hisi-femac: remove core specific versioning
      dt-bindings: net: hisi-femac: add missing clocks
      dt-bindings: net: hisi-femac: replace deprecated phy-mode with recommended phy-connection-type
      dt-bindings: net: hisi-femac: add mandatory MDIO bus subnode
      dt-bindings: net: hisi-femac: add binding for Hi3798MV200 FEMAC core
      net: hisi_femac: remove unused compatible strings
      net: hisi_femac: add support for hisi_femac core on Hi3798MV200

 .../bindings/net/hisilicon,hisi-femac-mdio.yaml    |  39 +++++++
 .../bindings/net/hisilicon,hisi-femac.yaml         | 120 +++++++++++++++++++++
 .../bindings/net/hisilicon-femac-mdio.txt          |  22 ----
 .../devicetree/bindings/net/hisilicon-femac.txt    |  41 -------
 drivers/net/ethernet/hisilicon/hisi_femac.c        |  77 ++++++++++---
 drivers/net/mdio/mdio-hisi-femac.c                 |  18 +---
 6 files changed, 221 insertions(+), 96 deletions(-)
---
base-commit: d206a76d7d2726f3b096037f2079ce0bd3ba329b
change-id: 20240216-net-9a208e17c40f

Best regards,
-- 
Yang Xiwen <forbidden405@outlook.com>


