Return-Path: <linux-kernel+bounces-67852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E97A8571DF
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 00:49:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60DE91C2257B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 23:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 141F6146900;
	Thu, 15 Feb 2024 23:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jog+Hq6V"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36001139589;
	Thu, 15 Feb 2024 23:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708040933; cv=none; b=BbJ13OxmP5JBFiqETuKJfhdRQwduztkwIvC041IoAORuDfPRU3mbrj4meH42LgE/fRztwtOhbnJrG1OuwkR183M3WEdT6qgmDR6o5iJ77y3JUYIlgLkdMmiYSQzdq8DorQpGG52JiFynTpya+K0SkdXeHwwynk2+pw/LB3FlCC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708040933; c=relaxed/simple;
	bh=m941Sbuue6lax4UKMmxtO0nmkIxGUQrjsrLye+L4Em0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=N0sPUils8A5bTmnYDxjobVyb1dpPISk0MSHwphdpTZPGzsi6gx7xtWrlVFpMTwvxZc0tBAlGj+iUE80/8ydkcBXQld6F174flJFUWd6VE9Y9ew3NavzcnWjCUiAFhW9KgIekHQK4xIyFUKMc9WDfLBYLol6GpHhV+lW77grGwpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jog+Hq6V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id AA036C433C7;
	Thu, 15 Feb 2024 23:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708040932;
	bh=m941Sbuue6lax4UKMmxtO0nmkIxGUQrjsrLye+L4Em0=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=jog+Hq6VtmXR0FiKmWuLmOt0iPYrrIm4g7WtJXmrayWxyT2IYNZ4DnulCmA+pMiYT
	 1AAk9Yd0qgA0cHNxMcB5Sr4VhVseXu1aDG9s3NkXwhNgE1znqYgMxMwR3qbf7bb1l+
	 aCiqHo/nkxiCt6dh9CLOt71AIVIkLwb2uN8ImHXcFQLsoLptNBDgPp1YM2dRlgx0cW
	 PXPUwBneIIN884CIg5Z1xrIfL3m8pUqAczCVK1A80l1yWmFfq+On333AW5NjMfjnBZ
	 XJQ8A6ebOqo95LoKQyuOeNaYwStNQo8/QpKSwLvf778ocXRyHtX7N544ghJMh+rR9P
	 vgivA8uZq+ODw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 935EAC48BC4;
	Thu, 15 Feb 2024 23:48:52 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Subject: [PATCH 0/6] net: hisi-femac: add support for Hi3798MV200, remove
 unmaintained compatibles
Date: Fri, 16 Feb 2024 07:48:52 +0800
Message-Id: <20240216-net-v1-0-e0ad972cda99@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOSizmUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDI0Mz3bzUEl3LRCMDi1RD82QTgzQloMqCotS0zAqwKdGxtbUABWErjFU
 AAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708040932; l=983;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=m941Sbuue6lax4UKMmxtO0nmkIxGUQrjsrLye+L4Em0=;
 b=2sOk2vozN8hrgMsvgYl+50Do8EfwMKSRFvFVYxJoAbmYU/vB+BB/DHCRm3UcUly3sw4UNcaqt
 GOLJuJl4xeRDInpTJ7t91J0veyiVl568HonhzYAWms3HjhQcfFCslBW
X-Developer-Key: i=forbidden405@outlook.com; a=ed25519;
 pk=qOD5jhp891/Xzc+H/PZ8LWVSWE3O/XCQnAg+5vdU2IU=
X-Endpoint-Received:
 by B4 Relay for forbidden405@outlook.com/20230724 with auth_id=67
X-Original-From: Yang Xiwen <forbidden405@outlook.com>
Reply-To: <forbidden405@outlook.com>

Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
Yang Xiwen (6):
      net: hisilicon: add support for hisi_femac core on Hi3798MV200
      net: hisi_femac: remove unused compatible strings
      dt-bindings: net: remove outdated hisilicon-femac
      dt-bindings: net: add hisilicon-femac
      net: mdio: hisi-femac: make clock optional
      dt-bindings: net: hisilicon-femac-mdio: make clock optional

 .../bindings/net/hisilicon-femac-mdio.txt          |   2 +
 .../devicetree/bindings/net/hisilicon-femac.txt    |  41 -------
 .../devicetree/bindings/net/hisilicon-femac.yaml   | 125 +++++++++++++++++++++
 drivers/net/ethernet/hisilicon/hisi_femac.c        |  93 ++++++++++-----
 drivers/net/mdio/mdio-hisi-femac.c                 |   2 +-
 5 files changed, 196 insertions(+), 67 deletions(-)
---
base-commit: 8d3dea210042f54b952b481838c1e7dfc4ec751d
change-id: 20240216-net-9a208e17c40f

Best regards,
-- 
Yang Xiwen <forbidden405@outlook.com>


