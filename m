Return-Path: <linux-kernel+bounces-51790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7549848F53
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 17:35:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DB6B283A26
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 16:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D0AD24A19;
	Sun,  4 Feb 2024 16:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cfH2Txno"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306E222F0A;
	Sun,  4 Feb 2024 16:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707064492; cv=none; b=X5cuiXa+4kS95MHRIQk91ElZ0ZSWGxJenHfIagrXdY1+pDDS2bv2yzw/VGpZyKtPRq6xPaH/MB0MBU5cBDSkTUGyUzz8HxRCbsAetuOGenCbdE6pH/xr1TKb6iUqFRIpVJpIKaP0s1ZxNByXMZ27qGSiT9NWeRTD5Pdg3jgIHyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707064492; c=relaxed/simple;
	bh=GPRwEqhKu9uor7uol+Wpdzz8RAN3PePg13sdJEo9IOw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=XckTGNKNUfyQBl5Sm3qyQXA2BUheQswhqFwLP00Et6yCRNhjiqlhIyAZE6mzkuvewj6iLQuTyfZ7JMV2eqENzhhMqzpzHz77ZF6UoJmRjo+iCu/Wkg9X6oUmFuQ8hsW5irm/ppB+FeinBIxiSSUQI3AhgAmmN/ayCAY3/ahM1XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cfH2Txno; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A1941C433C7;
	Sun,  4 Feb 2024 16:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707064491;
	bh=GPRwEqhKu9uor7uol+Wpdzz8RAN3PePg13sdJEo9IOw=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=cfH2Txnovg7AkARKRp1B3aExKtamooGMH/SIWByU7IuQq8kf2kKUCpkR1SgApOM/I
	 79b0ElzUa8YlXQFsO2szLIeroTaIis3DYT8WotDQRo9jP4g4wDa86O5oygyYfRHN37
	 bmMYNTfvl9GPHK+tTDcbJw3dW8yVDCzXe2hC+NsA322SJNIGEqEMqBBWeqlnDm00Em
	 DW0rBRWDEJVN3gzmFJEbmv1iCOjmibbUD9duXnX8i3F9naJXEFk1I+vyRCSY7NwSYg
	 r/G9i05tVzEoZA2vP8IUImyIVcDmM/o7ZcDsPrgoyQsi75gkq58Wz2bDVB9kTo4ehG
	 is4L0eaU82TXQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85618C4828F;
	Sun,  4 Feb 2024 16:34:51 +0000 (UTC)
From: =?utf-8?b?QXLEsW7DpyDDnE5BTA==?= via B4 Relay
 <devnull+arinc.unal.arinc9.com@kernel.org>
Subject: [PATCH net-next v4 0/7] MT7530 DSA Subdriver Improvements Act II
Date: Sun, 04 Feb 2024 19:34:18 +0300
Message-Id:
 <20240204-for-netnext-mt7530-improvements-2-v4-0-02bf0abaadb8@arinc9.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAIq8v2UC/42OzW7CMBCEXwX5zEb+DZgT74F6cOJNsUTsyDYWF
 cq71zUHQD20l9WORvPN3EnC6DCRw+ZOIhaXXPBVyO2GjGfjPxGcrZpwyiVlnMEUInjMHm8Z5rx
 TgoKblxgKzuhzAg6DnKToezbIvSKVs0Sc3K11nEiNwk+WfFTn7FIO8auVF9b8Rw8TjHLFdbenY
 seAgYnOj93Vm8uxvbobw9wYhb/k6pi/9xUOFAZD+0lZq3Ggv5DiiaznP0hRkb2wyliDWo/mDbm
 u6zf+VdzmaAEAAA==
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
 =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL?= <arinc.unal@arinc9.com>, 
 "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707064489; l=3249;
 i=arinc.unal@arinc9.com; s=arinc9-patatt; h=from:subject:message-id;
 bh=GPRwEqhKu9uor7uol+Wpdzz8RAN3PePg13sdJEo9IOw=;
 b=/up5bQUp91SPSdEI9oKko43R4KVNkg2s+V0zqwkjVMK9n89RQ9RdgL0n/k+dpRsudgRs14CS0
 /GDT3TJ7WBKDtqb1dKKxa1DxiKAq16lvhiBmZVU95d2yN1uG7FAt0LP
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
Changes in v4:
- Update the patches with the latest received trailers.
- Leave no error returns on mt7530_pad_clk_setup() before renaming it to
  mt7530_setup_port6() and moving it to under mt7530_mac_config().
- Link to v3: https://lore.kernel.org/r/20240202-for-netnext-mt7530-improvements-2-v3-0-63d5adae99ca@arinc9.com

Changes in v3:
- Update the patches with the latest received trailers.
- Patch 5
  - Disable TRGMII clocks for all cases.
- Link to v2: https://lore.kernel.org/r/20240130-for-netnext-mt7530-improvements-2-v2-0-ba06f5dd9eb0@arinc9.com

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
      net: dsa: mt7530: move XTAL check to mt7530_setup()
      net: dsa: mt7530: simplify mt7530_pad_clk_setup()
      net: dsa: mt7530: call port 6 setup from mt7530_mac_config()
      net: dsa: mt7530: remove pad_setup function pointer
      net: dsa: mt7530: correct port capabilities of MT7988
      net: dsa: mt7530: do not clear config->supported_interfaces

 drivers/net/dsa/mt7530.c | 152 +++++++++++++++++------------------------------
 drivers/net/dsa/mt7530.h |   3 -
 2 files changed, 53 insertions(+), 102 deletions(-)
---
base-commit: 4acf4e62cd572b0c806035046b3698f5585ab821
change-id: 20240121-for-netnext-mt7530-improvements-2-b4f43661b485

Best regards,
-- 
Arınç ÜNAL <arinc.unal@arinc9.com>


