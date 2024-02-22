Return-Path: <linux-kernel+bounces-76528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 65BD085F880
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 13:44:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06FB0B22BA6
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 12:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25A41133296;
	Thu, 22 Feb 2024 12:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RpPnITRj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3227312DD8F;
	Thu, 22 Feb 2024 12:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708605822; cv=none; b=p7yRrEG0XJgzSRahCEfQICO1lM1ME+u+tnHJ/U1Bo/YqcsY+H3avl5FI/u2aqckpzC+YjQZTNwyEzRp4taeBektijE19H1Eziy8jaZCC7Mm+o5xBw3xYUmgqSF9joJPXbOoPbBxwL/CbV9YUwVbzl4VgKwZ8ULV943hl/j3HNrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708605822; c=relaxed/simple;
	bh=fxXyTnfaIEMd/Q22ZZODuf6RK5WPhFO+nFybeSW6WRM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=i3zd80/b0pOkhalFbXFzIsdEVkFe+VoiHFBtlrn+cG77It6cetyP4EGX+NHOAYGTMnuJ1hLERvT96loGFbyD/7KSL+kcsKW5mxrKlTj9LuDlkyG3/zd5EGLt9Ea7LMOCkZxThsH+9GhEnzOH65JdIWiq7CQuAiL1Uk3xwZgOxac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RpPnITRj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B4D9CC433F1;
	Thu, 22 Feb 2024 12:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708605821;
	bh=fxXyTnfaIEMd/Q22ZZODuf6RK5WPhFO+nFybeSW6WRM=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=RpPnITRj9dSrbD/t1sjshLiCi+BTf2/+GLZKXBfbvIrcS9Dr+zgjeEG+Cxk3gckMj
	 ywTBYOowk3LFLqYciEEVkEabePeA7LPzG0sdosaIFsrJmomlgIF0DVSnWpd/KS7gF9
	 iLle01qR2CL/hJfutEOcIZC6iVaXm3l08f6EWUB5gvkX7peKxal/tMR6vCvmzJJ2G4
	 Jtk0rV5EKkQY72Um+LhKXxA+UlbcWIATMEak7dDOpYhDFcD3bmQclAzOM/pSV/8lLZ
	 QkWYiR6Cul67kLGmDJIHeVXJnszYP5wzwqY4//2O82yGy3f5OrGXWRYSwg4T3MfUb5
	 san7A+127UYfw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96A72C48BEB;
	Thu, 22 Feb 2024 12:43:41 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Subject: [PATCH net-next v4 0/6] net: hisi-femac: add support for
 Hi3798MV200, remove unmaintained compatibles
Date: Thu, 22 Feb 2024 20:43:20 +0800
Message-Id: <20240222-net-v4-0-eea68f93f090@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGhB12UC/23MTQ6CMBQE4KuYrq1pH/2hrryHcdGWhzRqawAJh
 nB3K24kupzMfDORDtuAHdlvJtLiELqQYg5iuyG+sfGMNFQ5E2AgGHBFI/bUWGAlcu0Fq0le3lu
 sw7i8HMl7EHHsySk3Tej61D6X+4Ev/epp4JRRZLYyGnxljTmkR39N6bLz6bY8DPBHQValcZVwm
 inp4VcVXwrYRxVZOVWidFqiVnKt5nl+AcVufu0OAQAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708605802; l=2180;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=fxXyTnfaIEMd/Q22ZZODuf6RK5WPhFO+nFybeSW6WRM=;
 b=RrqJTz2jLMJ7U3KfrwKu0Jq2o8HGaCGAG8EpKR8IWL0Pa49wginkGhGWVa/kmqdHo7rVh6UL+
 Vmh4RpB5yMYAYn2A2ihTYNchYzzuB7IkeaLm9W79IPzAVSTi/vrjnhx
X-Developer-Key: i=forbidden405@outlook.com; a=ed25519;
 pk=qOD5jhp891/Xzc+H/PZ8LWVSWE3O/XCQnAg+5vdU2IU=
X-Endpoint-Received:
 by B4 Relay for forbidden405@outlook.com/20230724 with auth_id=67
X-Original-From: Yang Xiwen <forbidden405@outlook.com>
Reply-To: <forbidden405@outlook.com>

Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
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
Yang Xiwen (6):
      dt-bindings: net: hisilicon-femac-mdio: convert to YAML
      net: mdio: hisi-femac: make clock optional
      dt-bindings: net: remove outdated hisilicon-femac
      dt-bindings: net: add hisilicon,hisi-femac
      net: hisilicon: add support for hisi_femac core on Hi3798MV200
      net: hisi_femac: remove unused compatible strings

 .../bindings/net/hisilicon,hisi-femac-mdio.yaml    |  43 ++++++++
 .../bindings/net/hisilicon,hisi-femac.yaml         | 116 +++++++++++++++++++++
 .../bindings/net/hisilicon-femac-mdio.txt          |  22 ----
 .../devicetree/bindings/net/hisilicon-femac.txt    |  41 --------
 drivers/net/ethernet/hisilicon/hisi_femac.c        |  78 +++++++++++---
 drivers/net/mdio/mdio-hisi-femac.c                 |   2 +-
 6 files changed, 221 insertions(+), 81 deletions(-)
---
base-commit: 8d3dea210042f54b952b481838c1e7dfc4ec751d
change-id: 20240216-net-9a208e17c40f

Best regards,
-- 
Yang Xiwen <forbidden405@outlook.com>


