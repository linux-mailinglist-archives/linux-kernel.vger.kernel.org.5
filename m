Return-Path: <linux-kernel+bounces-71924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C1EC85ACA2
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 20:57:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCB62281ABF
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 19:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88557535B6;
	Mon, 19 Feb 2024 19:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="odVmSVOQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8EE41A81;
	Mon, 19 Feb 2024 19:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708372656; cv=none; b=YzvSvf8XoF4osvxTyQ4x4EWLHqv2MZfMdUW1Y/ni+yQocpOGP5D4aJ+RmGnGT0O1is3klh3VEsqEZ/6ceJq+yl6J2DhNEwz4OmSKv485aYuElJi23E+c38v580Ac25cXVt1UzbApnOlroaP6WzvpeDcv11ahPOmLvvyXkuowJ9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708372656; c=relaxed/simple;
	bh=l6lMfvTk7CFPjhzUlulstlIJN8SObLPyb4ZjLiD1XlI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=QJh0evQmQmnCR6WrKWbw1ZQ99p2LfXguUQ+ipkLJjRTq5lqD6V3hAghrePjCf5f0xqSuRIRwxNnNjQhNV3FQH71m5x2mNRsNJZN4V9jjiyfpo6QsbIHKPIszcMYtA1RYlRZIB1793AefD2OsaTj+H0vNei6iUmwQhmGJTAV6J/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=odVmSVOQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 95041C43394;
	Mon, 19 Feb 2024 19:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708372656;
	bh=l6lMfvTk7CFPjhzUlulstlIJN8SObLPyb4ZjLiD1XlI=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=odVmSVOQ9xVOvSw1kFwVc7nk/nwzBIHD0zf9sC5jwgljwZwW4wWwDxXfgSTmEpBv/
	 i9E6Xlb2FrS2UsY8DF06/6tQFRFzefv/UucG7drHXo1Tj/tFLZzOvHytKab+Mp2lqc
	 4srNL+7Hd5qxrdsV5SNp6zoAjK0rzF/i90xksKGDJI8uCJZYKN/o/sQ+nIP+riANM4
	 45Bl041Eqit9SSySYdkBWP9FpaO39KJ3acu7T681PxCSe9rgwq7zW8FCusdz4xnKVe
	 JwL4zkKdFYwC+iiUMZRVsmmAPatLlQ8Va2ZL0NhLtEWhnmGF4BTYvR/gom1IH6oGVo
	 W4SaXQPQXGR1Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77BB1C48BC3;
	Mon, 19 Feb 2024 19:57:36 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Subject: [PATCH net-next v3 0/6] net: hisi-femac: add support for
 Hi3798MV200, remove unmaintained compatibles
Date: Tue, 20 Feb 2024 03:57:35 +0800
Message-Id: <20240220-net-v3-0-b68e5b75e765@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAK+y02UC/22MwQ7CIBAFf6XZsxhYa1s8+R/GA4WtJSoYiqSm6
 b+L3Jp4fJk3s8BEwdIEp2qBQMlO1rs8DrsK9KjcjZg1eQNyrDmKhjmKTCrkHYlW13yA/HwFGux
 cKhf4HRzNEa6ZjHaKPnxKPonCN6UkGGfElZEtaqOkPPt3fHh/32v/LIWEfyzMVid7U/ctb44at
 9a6rl+JlDGj2AAAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708372656; l=1754;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=l6lMfvTk7CFPjhzUlulstlIJN8SObLPyb4ZjLiD1XlI=;
 b=fqSRDr03JWvB1/KlVujOqSKV65CXq15sxpgv7TgX9NJQp+SpzImaPyPjgTs1Pb8Z3cgMMWNch
 p0NhfQxp3xmDfcr0OscchnD7tzCnpufT3HK+dKfqEURI1yrVaTypG/2
X-Developer-Key: i=forbidden405@outlook.com; a=ed25519;
 pk=qOD5jhp891/Xzc+H/PZ8LWVSWE3O/XCQnAg+5vdU2IU=
X-Endpoint-Received:
 by B4 Relay for forbidden405@outlook.com/20230724 with auth_id=67
X-Original-From: Yang Xiwen <forbidden405@outlook.com>
Reply-To: <forbidden405@outlook.com>

Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
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
      net: mdio: hisi-femac: make clock optional
      dt-bindings: net: hisilicon-femac-mdio: convert to YAML
      net: hisilicon: add support for hisi_femac core on Hi3798MV200
      net: hisi_femac: remove unused compatible strings
      dt-bindings: net: remove outdated hisilicon-femac
      dt-bindings: net: add hisilicon,hisi-femac

 .../bindings/net/hisilicon,hisi-femac-mdio.yaml    |  48 +++++++++
 .../bindings/net/hisilicon,hisi-femac.yaml         | 117 +++++++++++++++++++++
 .../bindings/net/hisilicon-femac-mdio.txt          |  22 ----
 .../devicetree/bindings/net/hisilicon-femac.txt    |  41 --------
 drivers/net/ethernet/hisilicon/hisi_femac.c        |  81 ++++++++++----
 drivers/net/mdio/mdio-hisi-femac.c                 |   2 +-
 6 files changed, 228 insertions(+), 83 deletions(-)
---
base-commit: 8d3dea210042f54b952b481838c1e7dfc4ec751d
change-id: 20240216-net-9a208e17c40f

Best regards,
-- 
Yang Xiwen <forbidden405@outlook.com>


