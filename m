Return-Path: <linux-kernel+bounces-68405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED9E98579C8
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 11:02:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C9B61C20FA7
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 10:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B8741CF94;
	Fri, 16 Feb 2024 10:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JBBpgknJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4911C6A0;
	Fri, 16 Feb 2024 10:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708077722; cv=none; b=HYVTXQOnh3aR5eCvuJAeYEXTStUEkPV3KsYYlrt4vO3WxcknQH+HFTGCT5a6Dp7rB2ki3A5d0Xfp7Psj/4wHPCixLh9LOhXDAKMOeyRP4AQ8Ip4eIIcUGlHIyAaxLlSkm9v6t067Kv0rOMLWyU6+PaF7CXxodYMwXLzp/irm5kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708077722; c=relaxed/simple;
	bh=4csa7aTSDQipjQQRAGTCioYnRiR1XMs3x6cVhQ5/Ans=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=EeR5EQxAhm7LUllV9yt14DcseGtkqiO+I6jlkiRzfJ3/jp9VbyHN5CKyGyQD9J/eMmOy/cXG56an8t1+yboMNtid/kcYU6XXiJO0NPyEmQOhF8QuoQpndaIDmBj4RczyoZjwWMR2ipKjV6bj4d54NZAnKKfFyeBeVUsXMG1pr9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JBBpgknJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0446FC43390;
	Fri, 16 Feb 2024 10:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708077722;
	bh=4csa7aTSDQipjQQRAGTCioYnRiR1XMs3x6cVhQ5/Ans=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=JBBpgknJw95tDd0K3chvvJNRQp49SVje18gE1bXXaDG4EtO983UiFgVouf8Chxaxy
	 MpELaiRyITJw2zXlV+My/jrl4kD5aJqvY5pxkhiUzjUtjNWblqUTI5XoVVC+FPzMkQ
	 7y1/NnK4ZisnocDRFuFqhnAjGFRsZcwewXMduQQAAZpYwD4fPx2zjvMP33vghk4bWf
	 8KDoNQOrXCRy7kFzCUX/4erA+oFayUMGcgYP4IjKCXGGCbkoMmlGQzxt26/0SBqI2O
	 Jy2SlNanNmyCnNGESnKoMk/znyOFIbg1R8rQov4eNNKGNRkgourfeS+t0SwSAW/Yy0
	 VcWA7HXVz8Cgg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3837C48260;
	Fri, 16 Feb 2024 10:02:01 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Subject: [PATCH v2 0/6] net: hisi-femac: add support for Hi3798MV200,
 remove unmaintained compatibles
Date: Fri, 16 Feb 2024 18:01:59 +0800
Message-Id: <20240216-net-v2-0-89bd4b7065c2@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJcyz2UC/1WMQQ7CIBBFr9LMWsxAGiuuvIfpgsDUTtSOASSah
 ruL3bl8P/+9FRJFpgSnboVIhRPL0sDsOvCzW66kODQGg6ZHow9qoaysM3gkPfgeJ2jPZ6SJ31v
 lMjaeOWWJny1a9G/994tWqAhdsIPxwVl7lle+i9z2Xh4w1lq/1dQLkpgAAAA=
To: Yisen Zhuang <yisen.zhuang@huawei.com>, 
 Salil Mehta <salil.mehta@huawei.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Yang Xiwen <forbidden405@foxmail.com>, 
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Yang Xiwen <forbidden405@outlook.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708077720; l=1447;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=4csa7aTSDQipjQQRAGTCioYnRiR1XMs3x6cVhQ5/Ans=;
 b=b2egZ3PgqKEpipPpPARcNfiNidRYvOIV4ankzyZlv7kGLkClHpB2yRACkfh8rt1OUht43KKF6
 dnmswJm420OCX0eWmdU3AZ4JtbaZ4T/m34LcE1h7nMisoWFlN29ErWU
X-Developer-Key: i=forbidden405@outlook.com; a=ed25519;
 pk=qOD5jhp891/Xzc+H/PZ8LWVSWE3O/XCQnAg+5vdU2IU=
X-Endpoint-Received:
 by B4 Relay for forbidden405@outlook.com/20230724 with auth_id=67
X-Original-From: Yang Xiwen <forbidden405@outlook.com>
Reply-To: <forbidden405@outlook.com>

Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
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
      net: hisilicon: add support for hisi_femac core on Hi3798MV200
      net: hisi_femac: remove unused compatible strings
      dt-bindings: net: remove outdated hisilicon-femac
      dt-bindings: net: add hisilicon,hisi-femac
      net: mdio: hisi-femac: make clock optional
      dt-bindings: net: hisilicon-femac-mdio: convert to YAML

 .../bindings/net/hisilicon,hisi-femac-mdio.yaml    |  48 +++++++++
 .../bindings/net/hisilicon,hisi-femac.yaml         | 117 +++++++++++++++++++++
 .../bindings/net/hisilicon-femac-mdio.txt          |  22 ----
 .../devicetree/bindings/net/hisilicon-femac.txt    |  41 --------
 drivers/net/ethernet/hisilicon/hisi_femac.c        |  94 ++++++++++++-----
 drivers/net/mdio/mdio-hisi-femac.c                 |   2 +-
 6 files changed, 235 insertions(+), 89 deletions(-)
---
base-commit: 8d3dea210042f54b952b481838c1e7dfc4ec751d
change-id: 20240216-net-9a208e17c40f

Best regards,
-- 
Yang Xiwen <forbidden405@outlook.com>


