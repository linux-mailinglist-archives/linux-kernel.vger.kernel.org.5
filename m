Return-Path: <linux-kernel+bounces-68489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F6FD857B15
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 12:06:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD5B8284C86
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 11:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C8E559B62;
	Fri, 16 Feb 2024 11:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sy3FVV9F"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742C25813A;
	Fri, 16 Feb 2024 11:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708081544; cv=none; b=Qeeop5umRiQ4ALPgSnXKVKOsWln++C4ixO5mPLZxgP5vdbTsa1mVYxYIQcIttgQU/mX9L4+p2CjAqhJABzMgkm1fr2KPM5aYFSgR/CdeepcsmsV2Htp8V4AD4n5sAog5+eAMJu9HfhzQ+1FO2Ua/GTrDLYPyUVCBmM1z3eL1DyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708081544; c=relaxed/simple;
	bh=1FS8ZPPLPybCi3YVj/4MOwJosG7TrEfNHZ4uB1ISjOk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=AglFJy0uFkW5KZQQvyDyqCSemoOOOh0HWl4ZrN8ciVPzWTwfiOJWoRzHbubK+TPV65ZJvr/u44G//KVGJycGib/llTvw9BRQFVR12lvi+0O+lDXaT+ZzURq8UJtV5KJRrrCO03YK82NZ9IsICLCDOhwV7AqhiCH8y2muNUffVt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sy3FVV9F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 04F5FC433F1;
	Fri, 16 Feb 2024 11:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708081544;
	bh=1FS8ZPPLPybCi3YVj/4MOwJosG7TrEfNHZ4uB1ISjOk=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=Sy3FVV9FYcbOcXef0kjnLwBdIcSiYvFwqAdFaWTYl95fM+cMeXLb7C6z+UA3dxSlf
	 gxn+Y3wQkt681mBqoAuiziaeDLPZWbQ5FYDXlkHQXAEXkfITD+AwpSLdK5ugt1wzZx
	 o0FdOGlN13Y6ov18nWokMnzkPFsG/tZKbbKxX4qBKCpZj4JCcvzYZRKZRDDOcTqdR2
	 DRui6kFvqCNzFOdH7HswRL6ReWLTEp4Fss3Cttdq6ep5Zd3k3APTsVaFSZYcnIm5DB
	 fWSgsJuS092yBJOEsWbOm2+pHnPpTPaDYWgLdzugnwuZP2O0iHZgge6Xj7ZmZVTZwo
	 YAG1hlap6YAxA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D267FC48260;
	Fri, 16 Feb 2024 11:05:43 +0000 (UTC)
From: =?utf-8?b?QXLEsW7DpyDDnE5BTA==?= via B4 Relay
 <devnull+arinc.unal.arinc9.com@kernel.org>
Subject: [PATCH net-next v2 0/8] MT7530 DSA Subdriver Improvements Act III
Date: Fri, 16 Feb 2024 14:05:28 +0300
Message-Id:
 <20240216-for-netnext-mt7530-improvements-3-v2-0-094cae3ff23b@arinc9.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAHhBz2UC/42NQQ6DIBBFr2Jm3WkANWpXvUfjgsBQWQAGCLEx3
 r2UE3T58vL/OyFRtJTg0Z0Qqdhkg68gbh2oTfo3odWVQTAxMN5zNCGip+zpyOjyNPYMrdtjKOT
 I54Q9ylmqYdGDmZSA+rNHMvZojRfUKf62sFaz2ZRD/LR44c23jmDzH53CkaGeFFdGj0wo+ZTRe
 rXcVXCwXtf1BUYpan/dAAAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708081540; l=2534;
 i=arinc.unal@arinc9.com; s=arinc9-patatt; h=from:subject:message-id;
 bh=1FS8ZPPLPybCi3YVj/4MOwJosG7TrEfNHZ4uB1ISjOk=;
 b=4YDBIR62fslTZb8yk0gux/BhP0YkemDBzqxqJr4mpU0FNWNGZw9VDzR7jHpWd4cmtwufLDsHb
 QLrKPdaGchfAzq7A0QN6KKwoE16uM87Qn8Xnzy1OW4EH4H2up+5HIvx
X-Developer-Key: i=arinc.unal@arinc9.com; a=ed25519;
 pk=VmvgMWwm73yVIrlyJYvGtnXkQJy9CvbaeEqPQO9Z4kA=
X-Endpoint-Received:
 by B4 Relay for arinc.unal@arinc9.com/arinc9-patatt with auth_id=115
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
Changes in v2:
- Patch 8
  - Use a single mt7530_rmw() instead of two mt7530_clear() and
    mt7530_set() commands.
- Link to v1: https://lore.kernel.org/r/20240208-for-netnext-mt7530-improvements-3-v1-0-d7c1cfd502ca@arinc9.com

---
Arınç ÜNAL (8):
      net: dsa: mt7530: remove .mac_port_config for MT7988 and make it optional
      net: dsa: mt7530: set interrupt register only for MT7530
      net: dsa: mt7530: do not use SW_PHY_RST to reset MT7531 switch
      net: dsa: mt7530: get rid of useless error returns on phylink code path
      net: dsa: mt7530: get rid of priv->info->cpu_port_config()
      net: dsa: mt7530: get rid of mt753x_mac_config()
      net: dsa: mt7530: put initialising PCS devices code back to original order
      net: dsa: mt7530: simplify link operations and force link down on all ports

 drivers/net/dsa/mt7530.c | 259 ++++++++---------------------------------------
 drivers/net/dsa/mt7530.h |  19 +---
 2 files changed, 47 insertions(+), 231 deletions(-)
---
base-commit: b6b614558ed5b2ca50edacc0f2fbf5f52158c86c
change-id: 20240131-for-netnext-mt7530-improvements-3-a8ac49d4f7c2

Best regards,
-- 
Arınç ÜNAL <arinc.unal@arinc9.com>


