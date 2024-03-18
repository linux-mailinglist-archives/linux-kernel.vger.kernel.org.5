Return-Path: <linux-kernel+bounces-105781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66C8B87E445
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 08:47:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2A461F216C1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 07:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DC272557A;
	Mon, 18 Mar 2024 07:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D0RObpfF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FCC8249ED;
	Mon, 18 Mar 2024 07:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710748029; cv=none; b=lWKBMvL5/4lazEF/ArZniiSWmQyH9c45vcjr02Z4srVITbsymTWfhUUbzcdDD1g0EvNePe+6eTRKLv6zx9ymOxgNZ8JIB9rI2y1FQZwYB6KiWj7N38vz2SdNgYx40A3b1eq7OqZeUnaGfXjmxaxeyoG1fBP4yeDFYCVI00t3pTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710748029; c=relaxed/simple;
	bh=0IileY4KTERKAEQx1LyPEiRlXaWXwOgaikBtQNDncX8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=nWMGKMu7GVVYrsE7hhw7XtfU6PRZMVIVOz5LbJx/MCxw9LwMr8n2MbqtJPFCL+MYiiam45lsPG+8UeFToo+8ZX0h0oDhGWSDwc1E84UhEsLcH2yUUVhtEOxy54pfstGxoTPRgOlFKPfPOp1vMzWCNbdiETO3u3IyqFtewowGoe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D0RObpfF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C7FF0C433F1;
	Mon, 18 Mar 2024 07:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710748028;
	bh=0IileY4KTERKAEQx1LyPEiRlXaWXwOgaikBtQNDncX8=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=D0RObpfF7D0s2IGO8bd9Cf3HmHJPOBYplNJgK0W4Jt4SUk951XgCcGTkDezqRAI2X
	 eYqH27vPts4qF4ZxANtnU2TAZXaqvFnzXVXkY5BS2eHIpNp2Fa7460/Uc8oNPqUWGt
	 U0/leJ9meebE4DLYCU+mdi8QjxtuphSPryzBgh1ceF0kbv/msElYYDyT2kMXvnh9Iz
	 kZgWk0tBPiB90URtD7dOqnUGM0/TLhbbX3uFoHp/vv56LpUq1PN0jymzLwQpybiG6K
	 vlseMFNv0daQMoSNXLJgE9LuYMxDtVLBS1KeVjNe7/bmIt5K9YRzyXOpVutGcRVkbx
	 98/MMd2QDtzag==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3983C54E5D;
	Mon, 18 Mar 2024 07:47:08 +0000 (UTC)
From: =?utf-8?b?QXLEsW7DpyDDnE5BTA==?= via B4 Relay
 <devnull+arinc.unal.arinc9.com@kernel.org>
Subject: [PATCH 0/3] Fix EEE support for MT7531 and MT7988 SoC switch
Date: Mon, 18 Mar 2024 10:46:22 +0300
Message-Id: =?utf-8?q?=3C20240318-for-net-mt7530-fix-eee-for-mt7531-mt7988-v?=
 =?utf-8?q?1-0-3f17226344e8=40arinc9=2Ecom=3E?=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAE7x92UC/x2NQQqDMBREryJ/7YfEGJL2KtKFxIn+RWNJpBTEu
 zdmNbzHMHNSQRYUenYnZXylyJ4q6L6jsM1pBctSmQY1jMpox3HPnHDw+3DWKI7yYwBNN6XveHj
 Psw12tCYEBU917pNRy+1qel3XH2pcu9x6AAAA
To: Daniel Golle <daniel@makrotopia.org>, DENG Qingfang <dqfext@gmail.com>, 
 Sean Wang <sean.wang@mediatek.com>, Andrew Lunn <andrew@lunn.ch>, 
 Florian Fainelli <f.fainelli@gmail.com>, 
 Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 =?utf-8?q?Ren=C3=A9_van_Dorst?= <opensource@vdorst.com>, 
 Russell King <linux@armlinux.org.uk>, 
 SkyLake Huang <SkyLake.Huang@mediatek.com>, 
 Heiner Kallweit <hkallweit1@gmail.com>
Cc: Bartel Eerdekens <bartel.eerdekens@constell8.be>, 
 mithat.guner@xeront.com, erkin.bozoglu@xeront.com, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, 
 =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL?= <arinc.unal@arinc9.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1710748010; l=899;
 i=arinc.unal@arinc9.com; s=arinc9-patatt; h=from:subject:message-id;
 bh=0IileY4KTERKAEQx1LyPEiRlXaWXwOgaikBtQNDncX8=;
 b=MvoN53hH2wrfbvyDLe2J5XZFtp6mqVf4l86LIsFblVBKfoyUfPbX/amdemD8asCtN6EGZKuEz
 u42E5pne4MiDXlAfYr/fO4zn5HkWlZDvIGDC85H9eXfauPMi8AW1P5J
X-Developer-Key: i=arinc.unal@arinc9.com; a=ed25519;
 pk=VmvgMWwm73yVIrlyJYvGtnXkQJy9CvbaeEqPQO9Z4kA=
X-Endpoint-Received:
 by B4 Relay for arinc.unal@arinc9.com/arinc9-patatt with auth_id=115
X-Original-From: =?utf-8?b?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Reply-To: <arinc.unal@arinc9.com>

Hi.

This patch series fixes EEE support for MT7531 and the switch on the MT7988
SoC. EEE did not work on MT7531 on most boards before this, it is unclear
what's the status on MT7988 SoC switch as I don't have the hardware.

Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
---
Arınç ÜNAL (3):
      net: dsa: mt7530: fix enabling EEE on MT7531 switch on all boards
      net: dsa: mt7530: fix disabling EEE on failure on MT7531 and MT7988
      net: phy: mediatek-ge: do not disable EEE advertisement

 drivers/net/dsa/mt7530.c      | 7 +++++++
 drivers/net/dsa/mt7530.h      | 7 ++++++-
 drivers/net/phy/mediatek-ge.c | 3 ---
 3 files changed, 13 insertions(+), 4 deletions(-)
---
base-commit: ea80e3ed09ab2c2b75724faf5484721753e92c31
change-id: 20240317-for-net-mt7530-fix-eee-for-mt7531-mt7988-a5c5453cc0e8

Best regards,
-- 
Arınç ÜNAL <arinc.unal@arinc9.com>


