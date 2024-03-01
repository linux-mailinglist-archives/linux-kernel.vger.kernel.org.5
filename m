Return-Path: <linux-kernel+bounces-87867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD01B86DA2A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 04:36:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88D7B281BED
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 03:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C826450276;
	Fri,  1 Mar 2024 03:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O0Uo5Ec7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4D145BEC;
	Fri,  1 Mar 2024 03:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709264160; cv=none; b=LryJsWFmNowjD4CoIhR+awLhRL81RhZ6eHeQ9VwbFgFnLNlt/qqDRiTV+ACFBD9ecIQvcO7888iXuxY62Mu1uU8Tx9wXER3nul1ygML11eJ3YqgapNVgEc/gj+wrSxRRhJMYMmQnb7xKEh5egChdcR071ui63DZeekSQCV0ZxEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709264160; c=relaxed/simple;
	bh=hVJk0iSdbJpuspEMDLOCQ/5TuUNcecz1X0UPINQcwWI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=k1W31YhcD1vdxJFd4bwxdpMl9CmT+pZZf39P9A97OXVxvsne1UxfjWlr8oU+snQnYVtVcQZ8VUr0SuAQ/Vs5ZTLkYvMyV0eB+ziKjDzJXCGODuBPjNpCJ/KdRwQt8y2k9yBVK/0J2jMShdpzl+fk00zAbBjuJoE7FNAlR9j4+Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O0Uo5Ec7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6440DC433C7;
	Fri,  1 Mar 2024 03:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709264160;
	bh=hVJk0iSdbJpuspEMDLOCQ/5TuUNcecz1X0UPINQcwWI=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=O0Uo5Ec7BmKZTZhxcv1QeGGqSIS6Tlh982YyAFxDwWxqBhX2+CZBCKFABWjYCwHAU
	 qD6Wo9nYlvu6WrKEYbeZi1up30/91Ndf1ec9bm5pezIcISVRd/freFGGa5hVPftmZb
	 6dlQmYGaJYyJyBOv1GMoVEdR277TIFbGLzR0HvdxQpFr46RZWVTBnu+G7sl94JheVM
	 eXorYbP3M5NAI3VrglJ91FoT8+PKI6uZ04Zfvp1LsZW86n+jlfoKiz8PwDdh2rQ7gT
	 H7XK51+8RwuWpyUkyegAl7OP23QgZkpDrSc61MFflgJhha1JhjGOkiVhQmz7oWJ4Nw
	 esgaSQ6q/4Qeg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B660C54798;
	Fri,  1 Mar 2024 03:36:00 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Subject: [PATCH net-next v7 0/9] net: hisi-femac: add support for
 Hi3798MV200, remove unmaintained compatibles
Date: Fri, 01 Mar 2024 11:35:53 +0800
Message-Id: <20240301-net-v7-0-45823597d4d4@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABlN4WUC/23Oy07DMBAF0F+pvMZoPH53xX8gFn5MqAXEKAlRU
 ZV/x002qcLy6s65mhsbaSg0svPpxgaay1hq34J9OrF0Cf078ZJbZgioAIXhPU3cBwRHwiYFHWu
 X3wN15bquvLL7QU/Xib215lLGqQ6/6/ws1v5haRYcOEHI3mLKwfuX+jN91vrxnOrXujDjPwqbc
 j5mFS0YnfCo5E4hbEo2FY0jHa0ma/RRqb3CTan7hxSM67zswMNR6b2Sm9JNKRkRs/QJhDwqs1d
 uU6Ypk63LMmvvknhUy7L8AdXvGmawAQAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709264157; l=3136;
 i=forbidden405@outlook.com; s=20240228; h=from:subject:message-id;
 bh=hVJk0iSdbJpuspEMDLOCQ/5TuUNcecz1X0UPINQcwWI=;
 b=nNAll33rt6S5TMw/zEC90qOiLZG0HvnvrJdFkVc/EYlcsKRFSuEilEGXTw403ck3f9TIUkjEf
 fhVqnopv45rDpmugJ19yn/H303t22kR1HGmjAFDGPUs1M5Hz/OIeZK7
X-Developer-Key: i=forbidden405@outlook.com; a=ed25519;
 pk=KAWv6ZzFsT54MGllOczJgFiWB+DuayEmyn24iiVVThU=
X-Endpoint-Received:
 by B4 Relay for forbidden405@outlook.com/20240228 with auth_id=136
X-Original-From: Yang Xiwen <forbidden405@outlook.com>
Reply-To: <forbidden405@outlook.com>

Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
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
      net: hisi_femac: remove unused MODULE_ALIAS()

 .../bindings/net/hisilicon,hisi-femac-mdio.yaml    |  39 +++++++
 .../bindings/net/hisilicon,hisi-femac.yaml         | 120 +++++++++++++++++++++
 .../bindings/net/hisilicon-femac-mdio.txt          |  22 ----
 .../devicetree/bindings/net/hisilicon-femac.txt    |  41 -------
 drivers/net/ethernet/hisilicon/hisi_femac.c        |  78 ++++++++++----
 drivers/net/mdio/mdio-hisi-femac.c                 |  18 +---
 6 files changed, 220 insertions(+), 98 deletions(-)
---
base-commit: d206a76d7d2726f3b096037f2079ce0bd3ba329b
change-id: 20240216-net-9a208e17c40f

Best regards,
-- 
Yang Xiwen <forbidden405@outlook.com>


