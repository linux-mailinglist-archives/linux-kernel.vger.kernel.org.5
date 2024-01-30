Return-Path: <linux-kernel+bounces-44824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A33328427E6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 16:21:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D68831C24014
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 15:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2FDD86AC8;
	Tue, 30 Jan 2024 15:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tysz8r3Y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A2E67E75;
	Tue, 30 Jan 2024 15:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706628057; cv=none; b=dr01/T3p6Gtyox1km06UOGii1fQQQLTKKLDSRBkC8RhJzCLqHFl2eUlaqfCH7m5aOA0PGqyfeJXkS+92ZrMELxOBC4ZY3OAdk2NdB4W8L5C37oWQb94xW1Gr2epJGbtffL/h0gqnv2E4DrobDBmALdoWHJYloV3nNikF2lk+nrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706628057; c=relaxed/simple;
	bh=LGaZ3YTJBfQ0lG0YcC/NrSyyzu8IUICWtPtIKqoiP3Q=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=hhzK6EGo5/sx6tQujTWPfR1TDGlirwa67Jl8LScs7zI1gEbEBT57tQtHgc8vzoKenhyS9X2dCYd3oDL4thwHutuj6PIq3KliG6YwHz75C6C0LjguaEVZrxjcDZp8m5kKg5u/8VXnkJp1bh+pK3ka5+2VQKFmdiyHyOxHYWBeTuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tysz8r3Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 84975C433B2;
	Tue, 30 Jan 2024 15:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706628056;
	bh=LGaZ3YTJBfQ0lG0YcC/NrSyyzu8IUICWtPtIKqoiP3Q=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=tysz8r3YwVsemLIq+hMfVkBJfC/H0mgK7ddeEQchHcTp2nc8sk0YTF1yxWcwl0SkX
	 mJB7Kmvq6aI8j6yMG+F9EW6tNTQC5HkoQsIL6CiFQZTBNqg4EkTRrP0ulKmjrEbVSE
	 JC4/QfYaMvj8aq74szTuLVwVaO2BakfeGUrIJqHpYmh9tyPg5rje0d4YoZCuuiMxuP
	 xM/Bx/0tPObZEiiYQTTd/kEEzOxYqi+zzseoUIxijPgFcxrGzVBl1lojhBq0deQfJE
	 njEe0e4W6wpnCTZRFOZi3LDvxxtqITUIC/K+a4IAVJyLxR2Q19Q4cztDMkaQhr+h2U
	 Z5HY1W+jwbP3A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E082C47DDB;
	Tue, 30 Jan 2024 15:20:56 +0000 (UTC)
From: =?utf-8?b?QXLEsW7DpyDDnE5BTA==?= via B4 Relay
 <devnull+arinc.unal.arinc9.com@kernel.org>
Subject: [PATCH net-next v2 0/7] MT7530 DSA Subdriver Improvements Act II
Date: Tue, 30 Jan 2024 18:20:46 +0300
Message-Id:
 <20240130-for-netnext-mt7530-improvements-2-v2-0-ba06f5dd9eb0@arinc9.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAM4TuWUC/yWNyw6CMBREf4XctZf0xcuV/2FYAF6kiW1JWwmG8
 O/WupvJ5Mw5IJDXFOBaHOBp00E7m4q4FDAtg30S6kfqIJhQjAuOs/NoKVraI5rYVJKhNqt3Gxm
 yMaDAUc1K1jUfVVtB+lk9zXrPjjskFH8s9GlZdIjOf7J843n/e7jkTFSiK1smG44cB6/tVL7t8
 Lrl2JWTM9Cf5/kFtSUfRcIAAAA=
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
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706628054; l=2695;
 i=arinc.unal@arinc9.com; s=arinc9-patatt; h=from:subject:message-id;
 bh=LGaZ3YTJBfQ0lG0YcC/NrSyyzu8IUICWtPtIKqoiP3Q=;
 b=soUoCM9RUYqLpUSzNO6lqpgNpfqmqya/NbkPWl1MK6QH7ak+HzZWqpZSeJgHq3RlCvMIo7lr1
 j3B7IBb1T0ZC2LfVcKaKKaijupISylgykgjzqG1/m9ccuzWbVT1QuBx
X-Developer-Key: i=arinc.unal@arinc9.com; a=ed25519;
 pk=VmvgMWwm73yVIrlyJYvGtnXkQJy9CvbaeEqPQO9Z4kA=
X-Endpoint-Received:
 by B4 Relay for arinc.unal@arinc9.com/arinc9-patatt with auth_id=115
X-Original-From: =?utf-8?b?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Reply-To: <arinc.unal@arinc9.com>

Hello!

This is the second patch series with the goal of simplifying the MT7530 DSA
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
Changes in v2:
- Update the patches with the latest received trailers.
- Remove 'net: dsa: mt7530: move enabling port 6 to mt7530_setup_port6()'
  which was patch 5. I will bring a more appropriate change with a later
  patch series.
- Patch 5
  - Set P6_INTF_MODE(0) and explain why on the patch log.
- Patch 6
  - Mention the MT7988 document and explain more on the patch log.
- Patch 7
  - Explain more on the patch log.
- Link to v1: https://lore.kernel.org/r/20240113102529.80371-1-arinc.unal@arinc9.com

---
Arınç ÜNAL (7):
      net: dsa: mt7530: empty default case on mt7530_setup_port5()
      net: dsa: mt7530: call port 6 setup from mt7530_mac_config()
      net: dsa: mt7530: remove pad_setup function pointer
      net: dsa: mt7530: move XTAL check to mt7530_setup()
      net: dsa: mt7530: simplify mt7530_setup_port6() and change to void
      net: dsa: mt7530: correct port capabilities of MT7988
      net: dsa: mt7530: do not clear config->supported_interfaces

 drivers/net/dsa/mt7530.c | 154 +++++++++++++++++------------------------------
 drivers/net/dsa/mt7530.h |   3 -
 2 files changed, 54 insertions(+), 103 deletions(-)
---
base-commit: 4acf4e62cd572b0c806035046b3698f5585ab821
change-id: 20240121-for-netnext-mt7530-improvements-2-b4f43661b485

Best regards,
-- 
Arınç ÜNAL <arinc.unal@arinc9.com>


