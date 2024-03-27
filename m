Return-Path: <linux-kernel+bounces-121574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABA0B88EB65
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 17:35:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48DF1B36ECE
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E46B12CD98;
	Wed, 27 Mar 2024 15:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="pIenkUfc"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A2559B71;
	Wed, 27 Mar 2024 15:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711554664; cv=none; b=durauT5tyERe5J+NU5Su1tSKzz/a+qyAApWng1yXu/SsKhWTf9nWNemZeLkrk9m9MEYLU4rq6kt6KcPbHloFwb1ehB34Ovuvr01LKg5PBDkaw3bkSr7Av0ZSWTlZShRnMosrTdoVZKpSk7Om034smgZK+7IBH5+mgHXeP2mVCP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711554664; c=relaxed/simple;
	bh=AW16EC2aEa0IebRO+qULBwtga1dRcMAePpBtTF1Cz4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ofn93WgKCICcPBa7LVFN2B1oUXz6SgVZe0rcUX8WaekLKXvjJ9urP+bnBd+iV6+b5nhCehXT1HPGGW/hkRgTTSHxpToJZAZviKz6Fhygs5E0EJi2icNKwUxCCeSjU6tjRXRKvj4gBW74MBY/sJzUCS3EKsuw6SQrqY0mi9oBRxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=pIenkUfc; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=v8Zo+lpGmEYMzAiuqKIM8OssQvdryZbCI6NC3RlvDLc=; b=pIenkUfc6gIEUz1zTSvCVoy95W
	tG+Pc5hVuecUgQGIPOcmluq+nOW/noQ3qiVIO3xP+tcxUES0f47sFzfHK5vlPsJP3B2vcHG+tzUYH
	/4Hc33aOH8Ff+mRWIm1nyCysVWjLjEDBVTgtFdVB/qPPBLugAVfKXTtp0xI7VH581NXCqHnP7Wtlo
	MV9S2txg5yF539UdMvjJRv0Jbj5x3RJxLtE/xB0ohtFR+Z4tqQaARb2gnyCAl2YPgi1qKRF/tYR1i
	09DfcdIzM2VaySFd+Z6bSiU9lwqZlOWswkcn39wQC5MrM9BzTfHUMbQywbIsCNrhZEgGQOeQ4PLtl
	LSJUDBpA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:53940)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rpVXq-0007DS-20;
	Wed, 27 Mar 2024 15:50:30 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rpVXk-000100-VR; Wed, 27 Mar 2024 15:50:25 +0000
Date: Wed, 27 Mar 2024 15:50:24 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Cc: Paolo Abeni <pabeni@redhat.com>, Daniel Golle <daniel@makrotopia.org>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>, Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	=?iso-8859-1?Q?Ren=E9?= van Dorst <opensource@vdorst.com>,
	SkyLake Huang <SkyLake.Huang@mediatek.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Bartel Eerdekens <bartel.eerdekens@constell8.be>,
	mithat.guner@xeront.com, erkin.bozoglu@xeront.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net v2 2/2] net: dsa: mt7530: fix disabling EEE on
 failure on MT7531 and MT7988
Message-ID: <ZgRAQFfKWR1skCMo@shell.armlinux.org.uk>
References: <20240321-for-net-mt7530-fix-eee-for-mt7531-mt7988-v2-0-9af9d5041bfe@arinc9.com>
 <20240321-for-net-mt7530-fix-eee-for-mt7531-mt7988-v2-2-9af9d5041bfe@arinc9.com>
 <799572b672ea8b4756236b14068aef7c8fa726a6.camel@redhat.com>
 <d65f4c45-e616-4157-a769-c285cbad575c@arinc9.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d65f4c45-e616-4157-a769-c285cbad575c@arinc9.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Mar 26, 2024 at 12:19:40PM +0300, Arınç ÜNAL wrote:
> On 26.03.2024 12:02, Paolo Abeni wrote:
> > On Thu, 2024-03-21 at 19:29 +0300, Arınç ÜNAL via B4 Relay wrote:
> > > From: Arınç ÜNAL <arinc.unal@arinc9.com>
> > > 
> > > The MT7531_FORCE_EEE1G and MT7531_FORCE_EEE100 bits let the
> > > PMCR_FORCE_EEE1G and PMCR_FORCE_EEE100 bits determine the 1G/100 EEE
> > > abilities of the MAC. If MT7531_FORCE_EEE1G and MT7531_FORCE_EEE100 are
> > > unset, the abilities are left to be determined by PHY auto polling.
> > > 
> > > The commit 40b5d2f15c09 ("net: dsa: mt7530: Add support for EEE features")
> > > made it so that the PMCR_FORCE_EEE1G and PMCR_FORCE_EEE100 bits are set on
> > > mt753x_phylink_mac_link_up(). But it did not set the MT7531_FORCE_EEE1G and
> > > MT7531_FORCE_EEE100 bits. Because of this, EEE will be enabled on the
> > > switch MACs by polling the PHY, regardless of the result of phy_init_eee().
> > > 
> > > Define these bits and add them to MT7531_FORCE_MODE which is being used by
> > > the subdriver. With this, EEE will be prevented from being enabled on the
> > > switch MACs when phy_init_eee() fails.
> > > 
> > > Fixes: 40b5d2f15c09 ("net: dsa: mt7530: Add support for EEE features")
> > > Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
> > 
> > If I read the past discussion correctly, this is a potential issue
> > found by code inspection and never producing problem in practice, am I
> > correct?
> > 
> > If so I think it will deserve a 3rd party tested-by tag or similar to
> > go in.
> > 
> > If nobody could provide such feedback in a little time, I suggest to
> > drop this patch and apply only 1/2.
> 
> Whether a problem would happen in practice depends on when phy_init_eee()
> fails, meaning it returns a negative non-zero code. I requested Russell to
> review this patch to shed light on when phy_init_eee() would return a
> negative non-zero code so we have an idea whether this patch actually fixes
> a problem.

Urgh, so I need to read the code and report back?

Well, looking at phy_init_eee(), it could return a negative vallue when:

1. phydev->drv is NULL
2. if genphy_c45_eee_is_active() returns negative
3. if genphy_c45_eee_is_active() returns zero, it returns
   -EPROTONOSUPPORT
4. if phy_set_bits_mmd() fails (e.g. communication error with the PHY)

If we then look at genphy_c45_eee_is_active(), then:

genphy_c45_read_eee_adv() and genphy_c45_read_eee_lpa() propagate their
non-zero return values, otherwise this function returns zero or positive
integer.

If we then look at genphy_c45_read_eee_adv(), then a failure of
phy_read_mmd() would cause a negative value to be returned.

Looking at genphy_c45_read_eee_lpa(), the same is true.

So, it can be summarised as:

- phydev->drv is NULL
- there is a communication error accessing the PHY
- EEE is not active

otherwise, it returns zero on success.

If one wishes to determine whether an error occurred vs EEE not being
supported through negotiation for the negotiated speed, if it returns
-EPROTONOSUPPORT in the latter case. Other error codes mean either the
driver has been unloaded or communication error.

This has been expertly determined by reading the code, which only a
phylib maintainer has the capability of doing. Thank you for using this
service.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

