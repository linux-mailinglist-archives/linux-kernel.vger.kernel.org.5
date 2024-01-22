Return-Path: <linux-kernel+bounces-32330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53465835A50
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 06:36:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB0DC1F235BD
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 05:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69BA26AA7;
	Mon, 22 Jan 2024 05:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HH1z9tR0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934B14C87;
	Mon, 22 Jan 2024 05:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705901758; cv=none; b=WMPXBhL6zspOSFOhQdZn3gDIBrehRN5WdaYYUQv86VNKuDRSMlXDGONyCVUTJCUPQsxWPQuI/TcEP9Ae/ci4F5BRVxYZ+XvHYidpAZ80Jhpsi4iFrQ3WUzpiAOjJudEGFOqIWmTk6hVdiXcxWG/l9cbKBh/zlTmpZQwciG4LxAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705901758; c=relaxed/simple;
	bh=eTYY+evS04ACta4sLOnbAMToYxY7CybRXgNbJ7leYNw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=S4jm9vRdCiB0wYTwjbcn/0PUNROWSjkQdmXKrFN0Is9JPTYn29beZxlIhKg61BQ9FObZH5ux2Jji/fLUfoPRVHK3IMmsPuUQqEw27/vl0rfSck+6CoQ32cxC3Az73PvxT4MKHyCjtlMJAnkiCG0koJl/v7GKwZA5dL1NKS4zOOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HH1z9tR0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2BFAFC433C7;
	Mon, 22 Jan 2024 05:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705901758;
	bh=eTYY+evS04ACta4sLOnbAMToYxY7CybRXgNbJ7leYNw=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=HH1z9tR0lCmBiqTf07IYzAJQaRQ2FfT2cKclURFfnTWkLZ48Necmv0EqMoayXsOSs
	 //JFund+TwDlk27lLa+M2vvpkqhHFH2MXtwF3o7kY3iNJVtWdRHdWA5gKba3WfD2RX
	 +zCivtZ/RgPt/W/FXBHenNaM1FTBDDMOuDVodVaBGw9J87QxQz4sYnluasGheZn4uU
	 Dva/RahkmWBi9oX/ioW6J4xXsvrkbDcOvwEbZUA2o2VvicbBZ7HhNJ7tPj6nMhROri
	 0BPbEzW5wHed9qr8yesghs/M/IJFiVDHIP0g1wjRJ+nr9fahXNlmTJPnd5fsQNokl5
	 UfSZtZsbeWJFQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10834C4725D;
	Mon, 22 Jan 2024 05:35:58 +0000 (UTC)
From: =?utf-8?b?QXLEsW7DpyDDnE5BTA==?= via B4 Relay
 <devnull+arinc.unal.arinc9.com@kernel.org>
Subject: [PATCH net-next v3 0/7] MT7530 DSA Subdriver Improvements Act I
Date: Mon, 22 Jan 2024 08:35:51 +0300
Message-Id:
 <20240122-for-netnext-mt7530-improvements-1-v3-0-042401f2b279@arinc9.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIALf+rWUC/3WNQQ7CIBREr2JYS8P/0NK68h7GRa2/lsRCA0hqm
 t5dZOPK3Uwmb97GAnlDgZ0OG/OUTDDO5iKPBzZMvX0QN/fcGQpUAhD46Dy3FC2tkc9R11JwMy/
 eJZrJxsCBN0rJWnXjTeua5Z/F02jW4riwjPIvy655mUyIzr+LPEHZs0cCQAsoUdQVNk0LXT7tv
 bFD9bL981xiVw1uLicJfyCiFtmudAVCYwf/wX3fP64TAoj8AAAA
To: Daniel Golle <daniel@makrotopia.org>, 
 Landen Chao <Landen.Chao@mediatek.com>, DENG Qingfang <dqfext@gmail.com>, 
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1705901755; l=3455;
 i=arinc.unal@arinc9.com; s=arinc9-patatt; h=from:subject:message-id;
 bh=eTYY+evS04ACta4sLOnbAMToYxY7CybRXgNbJ7leYNw=;
 b=17GHcU05i+tBO3+FtLXH7FLTko8AoULh6yvzNTCWphY/pvp9Fd6q9hsjeqHR1Xz5bHD0JlxG4
 uXo5JR8k6j/ACr1ZhmojnGwA0y3n98w8mFm4JqMkj0vIDy3/Oyl1KbC
X-Developer-Key: i=arinc.unal@arinc9.com; a=ed25519;
 pk=VmvgMWwm73yVIrlyJYvGtnXkQJy9CvbaeEqPQO9Z4kA=
X-Endpoint-Received:
 by B4 Relay for arinc.unal@arinc9.com/arinc9-patatt with auth_id=115
X-Original-From: =?utf-8?b?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Reply-To: <arinc.unal@arinc9.com>

Hello!

This patch series simplifies the MT7530 DSA subdriver and improves the
logic of the support for MT7530, MT7531, and the switch on the MT7988 SoC.

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
- Update the patches with the latest received trailers.
- Patch 1
  - Declare the longest variable assignment first.
  - Improve the patch log and the comment on the code.
  - Don't do type cast for __ffs. Implicit type promotion takes place.
- Patch 4
  - Put more relevant information on the comments on the code.
  - Follow the 'commit <12+ chars of sha1> ("<title line>")' style on the
    patch log to satisfy checkpatch errors.
- Patch 6
  - Change the patch log to explain the change better.
- Link to v2: https://lore.kernel.org/r/20231227044347.107291-1-arinc.unal@arinc9.com

Changes in v2:
- Shorten the patch series, include only 7 patches.
- Add the reviewed-by tags given.
- Patch 1
  - Change variable ordering of mt753x_conduit_state_change().
  - Define the mask variable and store BIT(cpu_dp->index) on it.
  - Disable CPU_EN if priv->active_cpu_ports is 0.
- Patch 5
  - On the patch log, take the irrelevant information about the
    mt7530_setup_port5() call from mt7530_setup() out.
- Patch 6
  - Change the patch log to reflect correct information.
- Link to v1: https://lore.kernel.org/r/20231118123205.266819-1-arinc.unal@arinc9.com

---
Arınç ÜNAL (7):
      net: dsa: mt7530: always trap frames to active CPU port on MT7530
      net: dsa: mt7530: use p5_interface_select as data type for p5_intf_sel
      net: dsa: mt7530: store port 5 SGMII capability of MT7531
      net: dsa: mt7530: improve comments regarding switch ports
      net: dsa: mt7530: improve code path for setting up port 5
      net: dsa: mt7530: do not set priv->p5_interface on mt7530_setup_port5()
      net: dsa: mt7530: do not run mt7530_setup_port5() if port 5 is disabled

 drivers/net/dsa/mt7530-mdio.c |   7 +--
 drivers/net/dsa/mt7530.c      | 135 +++++++++++++++++++++++-------------------
 drivers/net/dsa/mt7530.h      |  16 +++--
 3 files changed, 87 insertions(+), 71 deletions(-)
---
base-commit: 736b5545d39ca59d4332a60e56cc8a1a5e264a8e
change-id: 20240121-for-netnext-mt7530-improvements-1-6443549fb775

Best regards,
-- 
Arınç ÜNAL <arinc.unal@arinc9.com>


