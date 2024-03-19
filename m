Return-Path: <linux-kernel+bounces-108008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D56AA8804C3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 19:26:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20B1AB225E2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 18:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2966838384;
	Tue, 19 Mar 2024 18:26:02 +0000 (UTC)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C280D33CD0;
	Tue, 19 Mar 2024 18:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710872761; cv=none; b=cjhsWe/pJgmszeUFlvuB7KuKNsVR56jPtVtHIuPGSRjaeIHtQFX9tKq9r7qy0xQAx2dAGveWmiliF03SWpV9c7bq7Ibqj7ziIn7DUzCfFKNRUuVogmtwlUFAWs+O7mDeSDtA4pMUKOKN3+l9JI06HBpAuHifvOv+o0FzhHtTctg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710872761; c=relaxed/simple;
	bh=+B2/YuQBg7yNiILnBdMyRTQ5naKzC7rhn0eUUKSPVr0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KpDU+oIP80SOuD2ltCK1SQoLWohYQESmGe7437oOewSl/9aPwy1093c8uKQKwwu/fAYt52z45g5IOAbNxpGjvDYknuGsvLtu9NR384A1liIo4NZ8qeoIY/QcCSnnXzyOfKqm573tgXdjApub1K9D9WngRANXbtACB1YAJ92ocwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.96.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1rme9R-0005tO-32;
	Tue, 19 Mar 2024 18:25:30 +0000
Date: Tue, 19 Mar 2024 18:25:22 +0000
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
	=?iso-8859-1?Q?Ren=E9?= van Dorst <opensource@vdorst.com>,
	Russell King <linux@armlinux.org.uk>,
	SkyLake Huang <SkyLake.Huang@mediatek.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Bartel Eerdekens <bartel.eerdekens@constell8.be>,
	mithat.guner@xeront.com, erkin.bozoglu@xeront.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 0/3] Fix EEE support for MT7531 and MT7988 SoC switch
Message-ID: <ZfnYkuzuvwLepIfC@makrotopia.org>
References: <=?utf-8?q?=3C20240318-for-net-mt7530-fix-eee-for-mt7531-mt7988-v?=>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <=?utf-8?q?=3C20240318-for-net-mt7530-fix-eee-for-mt7531-mt7988-v?=>

On Mon, Mar 18, 2024 at 10:46:22AM +0300, Arınç ÜNAL via B4 Relay wrote:
> Hi.
> 
> This patch series fixes EEE support for MT7531 and the switch on the MT7988
> SoC. EEE did not work on MT7531 on most boards before this, it is unclear
> what's the status on MT7988 SoC switch as I don't have the hardware.

EEE seems to already work just fine on the MT7988 built-in switch, at least
on the BPI-R4. I don't think the SoC has bootstrap pins related to EEE like
stand-alone MT753x may have.

root@bpi-r4:~# ethtool --show-eee lan1
EEE settings for lan1:
    EEE status: disabled
    Tx LPI: 30 (us)
    Supported EEE link modes:  100baseT/Full
                               1000baseT/Full
    Advertised EEE link modes:  Not reported
    Link partner advertised EEE link modes:  100baseT/Full
                                             1000baseT/Full

root@bpi-r4:~# ethtool --set-eee lan1 eee on
root@bpi-r4:~# ethtool --show-eee lan1
EEE settings for lan1:
    EEE status: enabled - inactive
    Tx LPI: 30 (us)
    Supported EEE link modes:  100baseT/Full
                               1000baseT/Full
    Advertised EEE link modes:  100baseT/Full
                                1000baseT/Full
    Link partner advertised EEE link modes:  Not reported
root@bpi-r4:~# ethtool --show-eee lan1
EEE settings for lan1:
    EEE status: enabled - active
    Tx LPI: 30 (us)
    Supported EEE link modes:  100baseT/Full
                               1000baseT/Full
    Advertised EEE link modes:  100baseT/Full
                                1000baseT/Full
    Link partner advertised EEE link modes:  100baseT/Full
                                             1000baseT/Full

So don't fix if it ain't broken maybe...?

> 
> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
> ---
> Arınç ÜNAL (3):
>       net: dsa: mt7530: fix enabling EEE on MT7531 switch on all boards
>       net: dsa: mt7530: fix disabling EEE on failure on MT7531 and MT7988
>       net: phy: mediatek-ge: do not disable EEE advertisement
> 
>  drivers/net/dsa/mt7530.c      | 7 +++++++
>  drivers/net/dsa/mt7530.h      | 7 ++++++-
>  drivers/net/phy/mediatek-ge.c | 3 ---
>  3 files changed, 13 insertions(+), 4 deletions(-)
> ---
> base-commit: ea80e3ed09ab2c2b75724faf5484721753e92c31
> change-id: 20240317-for-net-mt7530-fix-eee-for-mt7531-mt7988-a5c5453cc0e8
> 
> Best regards,
> -- 
> Arınç ÜNAL <arinc.unal@arinc9.com>
> 
> 

