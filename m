Return-Path: <linux-kernel+bounces-88269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E605786DF78
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 11:43:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B1BB1C2279E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 10:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02F056CC14;
	Fri,  1 Mar 2024 10:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZG7xcID6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2894067E74;
	Fri,  1 Mar 2024 10:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709289779; cv=none; b=IQSvi8iIrmO0GHCIcSYFjEDFE/vAE5NlFg1xaVapPWspkVh1G0gY7pAVizdphpUJzyxOQXVNQ6OxRCB7+YE9lyImgR4q+F9oc53JcoI+8OASbnSgns1A4TJlgNNtKDT9o/l9UO/6ZCoAG1b4oywbe39nVONzYxKpOQwU8/T/pdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709289779; c=relaxed/simple;
	bh=ZJKLgZ4Q+W8RC6y4mRrQuRCA9QBqTIit+Yam4i3YxuY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=OaKa8g8bIQnrdycbEKcA9Zcrhnwbrd71TxuQcxERqWRkcXVA90Pjo4kEQ7LXsBHWzSW7PR0dlt7ao51gMJE8GgHUJrNMWGb2oHemPQTUm/i5cC+fCjQK6aHmOntgFgAMamA50RWEaq6i0bQ0YhkhxESlzqsIY+8+NKeRbYjxzE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZG7xcID6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id AFAD5C433F1;
	Fri,  1 Mar 2024 10:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709289778;
	bh=ZJKLgZ4Q+W8RC6y4mRrQuRCA9QBqTIit+Yam4i3YxuY=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=ZG7xcID6XznKMNSRiAc8WHXKKIM2FJGHSIaYWolY7h4F3uncVrz0hkW5WAd4TTlwk
	 4Ih4uYsr9+oCVRf8pdBjwcQ94kCXHJqAe0IzCb1aL5iuyIOOdgNlJkfiq/g5ETXBmR
	 +I3HW0JGTLIuJYVyOKmAGYgoguejSkTC44IvDo+uvmGjKsg2sw5ZI2m7DWHLreTEn+
	 HKccR6EaiJ3xDcKMsUJECIxin30Fh15ncfkHWE54lOijh0NAOVeOkzumjsw720jhUn
	 hMFsJQBuE7SUbjXTOZl5D2aCidgbJ1JuG3gGSYs+8CDEUZEx/ngRFWhTCnfdfbrKSj
	 ODfrrcpi5Oupw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92B5EC5478C;
	Fri,  1 Mar 2024 10:42:58 +0000 (UTC)
From: =?utf-8?b?QXLEsW7DpyDDnE5BTA==?= via B4 Relay
 <devnull+arinc.unal.arinc9.com@kernel.org>
Subject: [PATCH net-next v3 0/9] MT7530 DSA Subdriver Improvements Act III
Date: Fri, 01 Mar 2024 12:42:56 +0200
Message-Id:
 <20240301-for-netnext-mt7530-improvements-3-v3-0-449f4f166454@arinc9.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIADCx4WUC/42NvQ7CIBRGX8Uwew1/tdbJ9zAOeHtRhkIDhNQ0f
 XeRSTfHLyffOStLFB0ldt6tLFJxyQVfh9rvGD6NfxC4sW4mudRcKAE2RPCUPS0Zptx3ioOb5hg
 KTeRzAgXmZFAPo7Y9SlY9cyTrlta4snqFz5fdKnm6lEN8tXgRjbeO5Kc/OkUAh7FHgXbsuERzM
 dF5HA4YpqYv8kspjv8oZVXyQaMhZa1U9x/ltm1vtty9ajABAAA=
To: Daniel Golle <daniel@makrotopia.org>, DENG Qingfang <dqfext@gmail.com>, 
 Sean Wang <sean.wang@mediatek.com>, Andrew Lunn <andrew@lunn.ch>, 
 Florian Fainelli <f.fainelli@gmail.com>, 
 Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: mithat.guner@xeront.com, erkin.bozoglu@xeront.com, 
 Bartel Eerdekens <bartel.eerdekens@constell8.be>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, 
 =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL?= <arinc.unal@arinc9.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709289776; l=2904;
 i=arinc.unal@arinc9.com; s=arinc9-Xeront; h=from:subject:message-id;
 bh=ZJKLgZ4Q+W8RC6y4mRrQuRCA9QBqTIit+Yam4i3YxuY=;
 b=ZjlR+JK6Wc12fpxCA0Z/UmD0nT/C3mkcQQ+Tv284Gx7ntuu0OjsWGUmA+Sd7h72x3BjBCTzXz
 buk1reF6htoDmrx3gmAhh3y41FPGdaDJeoGS1YvwrKMBxHsB4L+60zu
X-Developer-Key: i=arinc.unal@arinc9.com; a=ed25519;
 pk=z49tLn29CyiL4uwBTrqH9HO1Wu3sZIuRp4DaLZvtP9M=
X-Endpoint-Received:
 by B4 Relay for arinc.unal@arinc9.com/arinc9-Xeront with auth_id=137
X-Original-From: =?utf-8?b?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Reply-To: <arinc.unal@arinc9.com>

Hello!

This is the third patch series with the goal of simplifying the MT7530 DSA
subdriver and improving support for MT7530, MT7531, and the switch on the
MT7988 SoC.

I have done a simple ping test to confirm basic communication on all switch
ports on MCM and standalone MT7530, and MT7531 switch with this patch
series applied.

MT7621 Unielec, MCM MT7530:

rgmii-only-gmac0-mt7621-unielec-u7621-06-16m.dtb
gmac0-and-gmac1-mt7621-unielec-u7621-06-16m.dtb

tftpboot 0x80008000 mips-uzImage.bin; tftpboot 0x83000000 mips-rootfs.cpio.uboot; tftpboot 0x83f00000 $dtb; bootm 0x80008000 0x83000000 0x83f00000

MT7622 Bananapi, MT7531:

gmac0-and-gmac1-mt7622-bananapi-bpi-r64.dtb

tftpboot 0x40000000 arm64-Image; tftpboot 0x45000000 arm64-rootfs.cpio.uboot; tftpboot 0x4a000000 $dtb; booti 0x40000000 0x45000000 0x4a000000

MT7623 Bananapi, standalone MT7530:

rgmii-only-gmac0-mt7623n-bananapi-bpi-r2.dtb
gmac0-and-gmac1-mt7623n-bananapi-bpi-r2.dtb

tftpboot 0x80008000 arm-zImage; tftpboot 0x83000000 arm-rootfs.cpio.uboot; tftpboot 0x83f00000 $dtb; bootz 0x80008000 0x83000000 0x83f00000

This patch series is the continuation of the patch series linked below.

https://lore.kernel.org/r/20230522121532.86610-1-arinc.unal@arinc9.com

Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
---
Changes in v3:
- Patch 8
  - Explain properly the behaviour of setting link down on all ports at
    setup.
  - Split the changes for simplifying the link settings operations out to
    another patch.
- Link to v2: https://lore.kernel.org/r/20240216-for-netnext-mt7530-improvements-3-v2-0-094cae3ff23b@arinc9.com

Changes in v2:
- Patch 8
  - Use a single mt7530_rmw() instead of two mt7530_clear() and
    mt7530_set() commands.
- Link to v1: https://lore.kernel.org/r/20240208-for-netnext-mt7530-improvements-3-v1-0-d7c1cfd502ca@arinc9.com

---
Arınç ÜNAL (9):
      net: dsa: mt7530: remove .mac_port_config for MT7988 and make it optional
      net: dsa: mt7530: set interrupt register only for MT7530
      net: dsa: mt7530: do not use SW_PHY_RST to reset MT7531 switch
      net: dsa: mt7530: get rid of useless error returns on phylink code path
      net: dsa: mt7530: get rid of priv->info->cpu_port_config()
      net: dsa: mt7530: get rid of mt753x_mac_config()
      net: dsa: mt7530: put initialising PCS devices code back to original order
      net: dsa: mt7530: sort link settings ops and force link down on all ports
      net: dsa: mt7530: simplify link operations

 drivers/net/dsa/mt7530.c | 259 ++++++++---------------------------------------
 drivers/net/dsa/mt7530.h |  19 +---
 2 files changed, 47 insertions(+), 231 deletions(-)
---
base-commit: b6b614558ed5b2ca50edacc0f2fbf5f52158c86c
change-id: 20240131-for-netnext-mt7530-improvements-3-a8ac49d4f7c2

Best regards,
-- 
Arınç ÜNAL <arinc.unal@arinc9.com>


