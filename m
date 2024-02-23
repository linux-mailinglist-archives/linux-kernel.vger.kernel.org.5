Return-Path: <linux-kernel+bounces-78375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90CF88612B1
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 14:28:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDC461F22DAB
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 13:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A8817F7CA;
	Fri, 23 Feb 2024 13:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QMKlpope"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC427A73A;
	Fri, 23 Feb 2024 13:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708694908; cv=none; b=G3p9yH2A6/x1KIhFxF5WjGQtSW5J7M+EviBA858Ec4ujErvL5vTWMZ8vX/mIx4FF3fImIsk64V/8Jp0EMqJWSkLHhIdFoyZaWUDVZP/AUolySeB/cDkbVMMuMLSIxkywZuSFe4negNld+2JouqYCv/cq5wLbHN3/Uf5/dXXtZjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708694908; c=relaxed/simple;
	bh=8DzLgimkymdwxe/dgxIFcpGgsnFMVLS8xgcZ/cKHlA0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=AFrxcVRKKgejlg1d4LRjEecsWQ0Swwo0xeHGT0Yw3rlxBe8xiNIYDzt5F8++Htv5LyzksehlVAMfQhzXWENQ10fAN361z7dYdcC/hoVf+CWo3gJnk96yrGU8bDkOKGLhz79qEyeaYbC4uJRKf2+Zv2vydrvvL+44sz9n41d3b4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QMKlpope; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 77180C433C7;
	Fri, 23 Feb 2024 13:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708694908;
	bh=8DzLgimkymdwxe/dgxIFcpGgsnFMVLS8xgcZ/cKHlA0=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=QMKlpopeiC4P7KqbFG2J/pnhV+q8ybPdy1eTWQMGC8qMYxATNb1j2UVyHWsDRbxz2
	 tJFTcWW7/UpLLpzPzxycF2H9UslrDRE4/hxd5j8yL7pMfgm1KhLbC7owcl6gTbAqaF
	 UNSsZoMtdaQWoxCbiHuQWh+giLkSUISSVS2Vv3gWCl5u2Nz5oKkpDxb0bwnpyheGGE
	 LBNboSOQvItKUTqGp09jqDWRV57uFCjb/DYe3G2mURKBhxJxgyNvgJURwTActh+Q2r
	 wdzWitT+5aHrJlrRJmgsE0J699i4LbANrkqDj0o4ZlWVfZ1169fUK4zDIjX5cLYiZW
	 zNAFcC/V15XPA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D918C5478C;
	Fri, 23 Feb 2024 13:28:28 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Subject: [PATCH net-next v5 0/7] net: hisi-femac: add support for
 Hi3798MV200, remove unmaintained compatibles
Date: Fri, 23 Feb 2024 21:28:15 +0800
Message-Id: <20240223-net-v5-0-43b22d39c013@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAG+d2GUC/23OTQ6CMBAF4KuYrq0Zhv5QV97DuChl0EalBpBgC
 He3wAaiy5c338sMrKHaU8OOu4HV1PnGhyoGud8xd7PVlbgvYmYIKAATxStqubEIGSXaCShZvHz
 VVPp+Xjmz6aCivmWX2Nx804b6M893ydxvlrqEAyewhdHoCmvMKbzbRwj3gwvPeaHDPwqjykxei
 FyDkg5/VbpSCItKo8pVRjLXkrSSv0qsFS5KTB+SVVlp0hIMbNU4jl9E8i9QRAEAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708694896; l=2386;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=8DzLgimkymdwxe/dgxIFcpGgsnFMVLS8xgcZ/cKHlA0=;
 b=FY1uLXGvPGQH6mhEYG7UftN41nXckDIFRjZaWfO2cVFD45mih3KdAAhxbqNJaCm5hhnov0qCN
 iokPH60OCTFANhtIoY/prVwwMtMyfiFHSW228W4qgeU5i94yCNpQGD1
X-Developer-Key: i=forbidden405@outlook.com; a=ed25519;
 pk=qOD5jhp891/Xzc+H/PZ8LWVSWE3O/XCQnAg+5vdU2IU=
X-Endpoint-Received:
 by B4 Relay for forbidden405@outlook.com/20230724 with auth_id=67
X-Original-From: Yang Xiwen <forbidden405@outlook.com>
Reply-To: <forbidden405@outlook.com>

Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
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
Yang Xiwen (7):
      dt-bindings: net: hisilicon-femac-mdio: convert to YAML
      dt-bindings: net: hisilicon,hisi-femac-mdio: remove clocks
      net: mdio: hisi-femac: remove clock
      dt-bindings: net: remove outdated hisilicon-femac
      dt-bindings: net: add hisilicon,hisi-femac
      net: hisilicon: add support for hisi_femac core on Hi3798MV200
      net: hisi_femac: remove unused compatible strings

 .../bindings/net/hisilicon,hisi-femac-mdio.yaml    |  39 +++++++
 .../bindings/net/hisilicon,hisi-femac.yaml         | 116 +++++++++++++++++++++
 .../bindings/net/hisilicon-femac-mdio.txt          |  22 ----
 .../devicetree/bindings/net/hisilicon-femac.txt    |  41 --------
 drivers/net/ethernet/hisilicon/hisi_femac.c        |  78 +++++++++++---
 drivers/net/mdio/mdio-hisi-femac.c                 |  18 +---
 6 files changed, 217 insertions(+), 97 deletions(-)
---
base-commit: 8d3dea210042f54b952b481838c1e7dfc4ec751d
change-id: 20240216-net-9a208e17c40f

Best regards,
-- 
Yang Xiwen <forbidden405@outlook.com>


