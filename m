Return-Path: <linux-kernel+bounces-97876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B5F187711D
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 13:27:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30777281A86
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 12:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A16FD3FB90;
	Sat,  9 Mar 2024 12:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DvROqRgk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E27383B5;
	Sat,  9 Mar 2024 12:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709987184; cv=none; b=qzt6ZH1vA/D62vPhnpcOljb0PsvL15sNVB9E6oruA0HofqkdZum7nIC3un4TCMaXgv9cGhqdgliDLTN+QmUVCaPhtqZb9z6KCHCtnGFzkXMaydbsmu7xv/vrUHRAWzLwiLME5Kens81xfdRxf8Hn55TMgrJ0whTy+HWOxvO7GJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709987184; c=relaxed/simple;
	bh=Ug/jD5YobYvsdYpf7Z3VXJhD6BXa6oRpdNYEA22u7fE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=W+L47j/TXuT8ic4yKn3QxJg6KJJYRDlJfZdJ5JbUwl6m2wq+AmUTv56rAORCGD7fMLGpCXb/LaxoCZAqvySFjacN1eTD/WG0hHivoa8AaMvGE1zAxiRTRDm7+do3EAjFx+BUc+gnR9nN2Ayki/4yh3mbWS+Gv+SyiVA1i5/+9Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DvROqRgk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3BB34C433C7;
	Sat,  9 Mar 2024 12:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709987184;
	bh=Ug/jD5YobYvsdYpf7Z3VXJhD6BXa6oRpdNYEA22u7fE=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=DvROqRgkMg4lNxS17/uNzbNKwCugN0IR+kAKBmN2mY3UZDSyFHOy9+xDW5dKrhpPs
	 Pg0hPD15fSQV+AysSBq2agQtP7e+x5+NSlRp7AVyA4EU2WgpgzsKSFckLYwNYJLTZI
	 0o7fUehSEYsf3EfUpE9f+O6qzjCFRsx4qCjxUEQ3wXp25HWvI/4+xTSS7nvclGczGG
	 w2h6RrcmM0qe/Dx2z1tfikmgxZwvO/fGrI/S+64l5vyk5NfG/MR8b9IoUhZYwk9rPG
	 r0ViBoeXSyY4hAPer6iIbND9aoMqnYHePkAqSKCzMWzWebTbe3A0KassgRPvwkKy09
	 8H9hcJzLXXqCQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FBEBC54798;
	Sat,  9 Mar 2024 12:26:24 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Subject: [PATCH net-next v11 0/9] net: hisi-femac: add support for
 Hi3798MV200, remove unmaintained compatibles
Date: Sat, 09 Mar 2024 20:26:22 +0800
Message-Id: <20240309-net-v11-0-eb99b76e4a21@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAG5V7GUC/23PS07EMAwG4KuMsqbIcd6z4h6IRZq4TAW0qC3Vo
 FHvTtogkVFYxvb3x76xmaaeZnY+3dhEaz/345AenD+cWLj44ZWaPqYCQ0AJyHUz0NI4j2CJmyC
 hY2nyc6Kuvx4xz2wfGOi6sJfUufTzMk7fR/7Kj/5d0sobaAh8dAZD9M49jV/L+zi+PYbx40hY8
 R+FSVnXRtka0CpgrUShELISSbXakmqNIqNVrWSpMCu5b0he286JDhzUSpVKZKWSkqJFjMIF4KJ
 WulQ2K52UjsZGEZWzgdfK/CkBPCuz/6UsCuVMlFHWypZKZWWT4lp7n45DDqZWrlQmK7dvSBA6Q
 VpZGWvFoWS/h3FITugEOgnWGbp327b9AMfI/Y6LAgAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709987182; l=4008;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=Ug/jD5YobYvsdYpf7Z3VXJhD6BXa6oRpdNYEA22u7fE=;
 b=4O+hFbv68XAQY3zAKuyEW55H7UZ45cVYF+2xJvX9I7YTw41d/4a/mDbdEvCIgdt1XXrmm2/ti
 JCLTtwL6hZUDocRnZSX4QiHDPvGvmByiURxAd+1Y0yzJRSEFEDDMF9E
X-Developer-Key: i=forbidden405@outlook.com; a=ed25519;
 pk=qOD5jhp891/Xzc+H/PZ8LWVSWE3O/XCQnAg+5vdU2IU=
X-Endpoint-Received:
 by B4 Relay for forbidden405@outlook.com/20230724 with auth_id=67
X-Original-From: Yang Xiwen <forbidden405@outlook.com>
Reply-To: <forbidden405@outlook.com>

Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
Changes in v11:
- driver: repick the patch adding mv200 support, which is a stupid mistake (Krzysztof Kozlowski)
- Link to v10: https://lore.kernel.org/r/20240308-net-v10-0-3684df40897e@outlook.com

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
 .../bindings/net/hisilicon,hisi-femac.yaml         | 121 +++++++++++++++++++++
 .../bindings/net/hisilicon-femac-mdio.txt          |  22 ----
 .../devicetree/bindings/net/hisilicon-femac.txt    |  41 -------
 drivers/net/ethernet/hisilicon/hisi_femac.c        |  76 ++++++++++---
 drivers/net/mdio/mdio-hisi-femac.c                 |  18 +--
 6 files changed, 220 insertions(+), 97 deletions(-)
---
base-commit: 90d35da658da8cff0d4ecbb5113f5fac9d00eb72
change-id: 20240216-net-9a208e17c40f

Best regards,
-- 
Yang Xiwen <forbidden405@outlook.com>


