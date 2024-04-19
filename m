Return-Path: <linux-kernel+bounces-151291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E88458AAC81
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 12:10:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9ED128409C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 10:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A94717FBC7;
	Fri, 19 Apr 2024 10:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HIOa2uVW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E977D3E3;
	Fri, 19 Apr 2024 10:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713521377; cv=none; b=VUdROG70mxMRjVICHdUYqukz852NqdFqpSZ3ZrkyZCNamWxHfxoo4cl64vpMrt9Pp4CvH3LUGS0NTCP7NPT0qK7IL0efpDiU7BOAPP145PDYQxIO5ZcmAjZnsF8C5pWTwulMwmQb1RIwZpZswdgvzh2rvjJVXi1U7yzuiY1RcMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713521377; c=relaxed/simple;
	bh=hIqlbjO65jZjxYKpeWau84wCqd4vKuYsewjegaEPtAw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=rPqLweVAkXBxEb4W53kpJvKtX8qsFWd5OfKTok7KsEeixJb/CATBv7ckkcUvsntq68nGfdS0mtV3TZGBsRPy43uU2vDXHvb5hrq2uc/WRzdesv2T29qFBLtYwM94GBCt7TnhCruzZk1wlJnVQAVJnaHhpsm1UHKJC2CK/w22DaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HIOa2uVW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 56899C072AA;
	Fri, 19 Apr 2024 10:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713521377;
	bh=hIqlbjO65jZjxYKpeWau84wCqd4vKuYsewjegaEPtAw=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=HIOa2uVW3uIspoEQuRXVy2cZHWLeq1qvOOOQ2kfIa0fnUnSrkOe1tgVZDNGpFRfgy
	 5eO1xkGuG1eGzAVeXizFsVCDv3Ti3ASsNNlniq/GfsyRluxJQJNm5S0C4X6M7jSyYg
	 zXuOxUwt7V7IDgsFQcj4p0KCHPheacQTGFVgBA6zOWPI8EXIdR4aS79G8uqVIEh81A
	 iAwxtJRnd383YK68tfm1s/pI9dhyoZSXJZR54vDkEXlXQC9g1MOyHdXWSqoAfE+j+P
	 1svKDTfn/LPa6hDZYNnlSfEL+gjHGEaBH7hQ9QthB5+wIxCfY5lJxrRXTQmpnm4KBn
	 7tQ1jOyY5gWDA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B112C04FF6;
	Fri, 19 Apr 2024 10:09:37 +0000 (UTC)
From: =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL_via_B4_Relay?= <devnull+arinc.unal.arinc9.com@kernel.org>
Subject: [PATCH net-next 00/13] MT7530 DSA Subdriver Improvements Act IV
Date: Fri, 19 Apr 2024 13:09:23 +0300
Message-Id: <20240419-for-netnext-mt7530-improvements-4-v1-0-6d852ca79b1d@arinc9.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIANNCImYC/x2NywqDQAwAf0VyNhD3QWl/pXgoGjWHzUp2EUH89
 257nMPMXFDYhAu8uguMDymStcHQdzBtH10ZZW4Mjlwg7wiXbKhclc+KqT6iJ5S0Wz44sdaCAZ8
 xeJqHSBNFaJ3deJHz/3hDU/HnwnjfX14TZvh9AAAA
To: Daniel Golle <daniel@makrotopia.org>, DENG Qingfang <dqfext@gmail.com>, 
 Sean Wang <sean.wang@mediatek.com>, Andrew Lunn <andrew@lunn.ch>, 
 Florian Fainelli <f.fainelli@gmail.com>, 
 Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: Bartel Eerdekens <bartel.eerdekens@constell8.be>, 
 mithat.guner@xeront.com, erkin.bozoglu@xeront.com, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, 
 =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL?= <arinc.unal@arinc9.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713521374; l=2654;
 i=arinc.unal@arinc9.com; s=arinc9-Xeront; h=from:subject:message-id;
 bh=hIqlbjO65jZjxYKpeWau84wCqd4vKuYsewjegaEPtAw=;
 b=iGbg2Xv6D/RpNIc/k3j1XoPdRClUOkq02kgugFhytAdQDrC0bmxdXD7gR+Ink69lISXC1XYSC
 O1swa4N6PULD3Y43CMD7t5opgf7OEhELDS4iH9UGGRxzf/SVMm+9UKF
X-Developer-Key: i=arinc.unal@arinc9.com; a=ed25519;
 pk=z49tLn29CyiL4uwBTrqH9HO1Wu3sZIuRp4DaLZvtP9M=
X-Endpoint-Received: by B4 Relay for arinc.unal@arinc9.com/arinc9-Xeront
 with auth_id=137
X-Original-From: =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL?= <arinc.unal@arinc9.com>
Reply-To: arinc.unal@arinc9.com

Hello!

This is the forth patch series with the goal of simplifying the MT7530 DSA
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

This patch series finalises the patch series linked below.

https://lore.kernel.org/r/20230522121532.86610-1-arinc.unal@arinc9.com

Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
---
Arınç ÜNAL (13):
      net: dsa: mt7530: disable EEE abilities on failure on MT7531 and MT7988
      net: dsa: mt7530: refactor MT7530_PMCR_P()
      net: dsa: mt7530: rename p5_intf_sel and use only for MT7530 switch
      net: dsa: mt7530: rename mt753x_bpdu_port_fw enum to mt753x_to_cpu_fw
      net: dsa: mt7530: refactor MT7530_MFC and MT7531_CFC, add MT7531_QRY_FFP
      net: dsa: mt7530: refactor MT7530_HWTRAP and MT7530_MHWTRAP
      net: dsa: mt7530: move MT753X_MTRAP operations for MT7530
      net: dsa: mt7530: return mt7530_setup_mdio & mt7531_setup_common on error
      net: dsa: mt7530: define MAC speed capabilities per switch model
      net: dsa: mt7530: get rid of function sanity check
      net: dsa: mt7530: refactor MT7530_PMEEECR_P()
      net: dsa: mt7530: get rid of mac_port_validate member of mt753x_info
      net: dsa: mt7530: use priv->ds->num_ports instead of MT7530_NUM_PORTS

 drivers/net/dsa/mt7530.c | 285 ++++++++++++++++++++++------------------------
 drivers/net/dsa/mt7530.h | 289 +++++++++++++++++++++++++----------------------
 2 files changed, 291 insertions(+), 283 deletions(-)
---
base-commit: e1bc03d8372ac081810c2956cd244ed9899f9a02
change-id: 20240320-for-netnext-mt7530-improvements-4-95430d150c05

Best regards,
-- 
Arınç ÜNAL <arinc.unal@arinc9.com>



