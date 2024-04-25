Return-Path: <linux-kernel+bounces-158551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D8228B21EF
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 14:50:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFB96284A75
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 12:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41773149C49;
	Thu, 25 Apr 2024 12:49:50 +0000 (UTC)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC531149C41;
	Thu, 25 Apr 2024 12:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714049389; cv=none; b=DEieyZ/wRgCYR1A2wiCTyQmNlRDp0YnsxB0ZE7RsNFJPxF132mlyJ7pj7uojX5S7P/dgTWOxZ3va538578ykgIQS6SonSQuHh0uSgFnIK/UlaaA4CtmQErD+/Zp9/EAui3S9IYqi/rVGc2TvfjbWt+T5ac8pQgPSWnxVAQG7AHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714049389; c=relaxed/simple;
	bh=TRTPpsVvtSlamQNa6WIDCztS4UVt83J5kzZZOXt95FA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V6Zfi9nRpHrUm5/lF9s3QTIiGGFEDVgsY3GRWUAOGAztv89ZPZEkPd+Km0X+D+dtoUfxQ84o0qzGxKvQDiHZ02Jmo0GCT29A/ncRkApkK0KE+eQuyMVHA2dbp+4AhqpdT7QC1jXnSguKroueEtct3TTiOup9Y0M1wGzurasKPPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.97.1)
	(envelope-from <daniel@makrotopia.org>)
	id 1rzyXc-0000000033E-3DOF;
	Thu, 25 Apr 2024 12:49:32 +0000
Date: Thu, 25 Apr 2024 13:49:28 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: arinc.unal@arinc9.com
Cc: DENG Qingfang <dqfext@gmail.com>, Sean Wang <sean.wang@mediatek.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Russell King <linux@armlinux.org.uk>,
	Bartel Eerdekens <bartel.eerdekens@constell8.be>,
	mithat.guner@xeront.com, erkin.bozoglu@xeront.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net-next v2 00/15] MT7530 DSA Subdriver Improvements Act
 IV
Message-ID: <ZipRWJZ9c7ZzQd4N@makrotopia.org>
References: <20240422-for-netnext-mt7530-improvements-4-v2-0-a75157ba76ad@arinc9.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240422-for-netnext-mt7530-improvements-4-v2-0-a75157ba76ad@arinc9.com>

On Mon, Apr 22, 2024 at 10:15:07AM +0300, Arınç ÜNAL via B4 Relay wrote:
> Hello!
> 
> This is the forth patch series with the goal of simplifying the MT7530 DSA
> subdriver and improving support for MT7530, MT7531, and the switch on the
> MT7988 SoC.
> 
> I have done a simple ping test to confirm basic communication on all switch
> ports on MCM and standalone MT7530, and MT7531 switch with this patch
> series applied.
> 
> MT7621 Unielec, MCM MT7530:
> 
> rgmii-only-gmac0-mt7621-unielec-u7621-06-16m.dtb
> gmac0-and-gmac1-mt7621-unielec-u7621-06-16m.dtb
> 
> tftpboot 0x80008000 mips-uzImage.bin; tftpboot 0x83000000 mips-rootfs.cpio.uboot; tftpboot 0x83f00000 $dtb; bootm 0x80008000 0x83000000 0x83f00000
> 
> MT7622 Bananapi, MT7531:
> 
> gmac0-and-gmac1-mt7622-bananapi-bpi-r64.dtb
> 
> tftpboot 0x40000000 arm64-Image; tftpboot 0x45000000 arm64-rootfs.cpio.uboot; tftpboot 0x4a000000 $dtb; booti 0x40000000 0x45000000 0x4a000000
> 
> MT7623 Bananapi, standalone MT7530:
> 
> rgmii-only-gmac0-mt7623n-bananapi-bpi-r2.dtb
> gmac0-and-gmac1-mt7623n-bananapi-bpi-r2.dtb
> 
> tftpboot 0x80008000 arm-zImage; tftpboot 0x83000000 arm-rootfs.cpio.uboot; tftpboot 0x83f00000 $dtb; bootz 0x80008000 0x83000000 0x83f00000
> 
> This patch series finalises the patch series linked below.
> 
> https://lore.kernel.org/r/20230522121532.86610-1-arinc.unal@arinc9.com
> 
> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>

I've imported the series to OpenWrt as pending patch and (briefly)
tested it myself on MT7988 and MT7986+MT7531 hardware, with very little
changes so it would apply on Linux 6.1 and Linux 6.6.

https://git.openwrt.org/?p=openwrt/openwrt.git;a=commit;h=d40691a5fb9415976bc917d1d96a0a6da99f2dc1

So for the whole series:

Tested-by: Daniel Golle <daniel@makrotopia.org>

I will review the patches individually in the next days.


> ---
> Changes in v2:
> - Add two new patches to the end.
> - Patch 13
>   - Add the missing patch log.
> - Link to v1: https://lore.kernel.org/r/20240419-for-netnext-mt7530-improvements-4-v1-0-6d852ca79b1d@arinc9.com
> 
> ---
> Arınç ÜNAL (15):
>       net: dsa: mt7530: disable EEE abilities on failure on MT7531 and MT7988
>       net: dsa: mt7530: refactor MT7530_PMCR_P()
>       net: dsa: mt7530: rename p5_intf_sel and use only for MT7530 switch
>       net: dsa: mt7530: rename mt753x_bpdu_port_fw enum to mt753x_to_cpu_fw
>       net: dsa: mt7530: refactor MT7530_MFC and MT7531_CFC, add MT7531_QRY_FFP
>       net: dsa: mt7530: refactor MT7530_HWTRAP and MT7530_MHWTRAP
>       net: dsa: mt7530: move MT753X_MTRAP operations for MT7530
>       net: dsa: mt7530: return mt7530_setup_mdio & mt7531_setup_common on error
>       net: dsa: mt7530: define MAC speed capabilities per switch model
>       net: dsa: mt7530: get rid of function sanity check
>       net: dsa: mt7530: refactor MT7530_PMEEECR_P()
>       net: dsa: mt7530: get rid of mac_port_validate member of mt753x_info
>       net: dsa: mt7530: use priv->ds->num_ports instead of MT7530_NUM_PORTS
>       net: dsa: mt7530: do not pass port variable to mt7531_rgmii_setup()
>       net: dsa: mt7530: explain exposing MDIO bus of MT7531AE better
> 
>  drivers/net/dsa/mt7530.c | 294 +++++++++++++++++++++++------------------------
>  drivers/net/dsa/mt7530.h | 289 ++++++++++++++++++++++++----------------------
>  2 files changed, 297 insertions(+), 286 deletions(-)
> ---
> base-commit: e1bc03d8372ac081810c2956cd244ed9899f9a02
> change-id: 20240320-for-netnext-mt7530-improvements-4-95430d150c05
> 
> Best regards,
> -- 
> Arınç ÜNAL <arinc.unal@arinc9.com>
> 
> 

