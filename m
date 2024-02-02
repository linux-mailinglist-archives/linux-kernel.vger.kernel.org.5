Return-Path: <linux-kernel+bounces-49792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E651C846F71
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 12:51:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36044B23ED1
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 11:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94FAE13E216;
	Fri,  2 Feb 2024 11:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="OqmD8m/c"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0107613E211;
	Fri,  2 Feb 2024 11:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706874687; cv=none; b=BGw0e54IV+4NxA45xHNtLJIIYj/9yESUC9EHW1wNzJjoyHaWFoEYqHYE46iPjvF0jmdOQi+OFqSWtNClympZV9We0gnQS3WV54cf5BjhnTYQDvOkLQbIsCMU4GAenvXMRHSpUtxZnyd75LcNTY9bvU+t663MVCqv3K6vues7x8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706874687; c=relaxed/simple;
	bh=tmseyaSoz8Telz9bqfnPz+Tc5gw75RGbX7OtTxriO0k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HThbLcAksj/mDxDOQLEYI5uTmnZkSA3rmyJoiLEGRBJzd2b3DgqxrtTcN7BGDBTDiHdTDI6IhZ4Cbx7mYFxauMr6TvDpGDbOAGx03wfyIn76j07zQG3eu2WZdgpVsA+QDMWpERI2bHjiRx6fARiwr/Vqbzbu8NGO4CdgYgt5dD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=OqmD8m/c; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=cIlxsvGg83BWYVggTT3nBjbFOe8N4Nii5E4TFnZPDZU=; b=OqmD8m/c5B7vFICq5Ev33gkvCd
	zn9HpBZjkLeFSbjTmF0+KV3kDCfrtUU8q2XpEmCsVIdKN1fLofI4H7osUKPxlvhaGw/YYoOO/yavh
	0RxLKv9NKCsePeKLqJfl/stdpXKdZL8yV0CsvpCq/mESPDQRb8djrtVtflee4WUJPzsAnsO5KPQ0n
	9HgJKZefg40oAb2w5pp7GSbtniF/orPv5hKa3eyVd+ENdChW1vvuw308QnoJOEgX+IsSReMZzV4Dv
	zEmQUn3RTgdm8vOvqYSuZyZ6yQP17vWW25KqcDIKHOVwh8JlFkcWO43yEhsyqLjD1Tii8peERhv7C
	l8MCJAQg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:56268)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rVs4f-0005vW-10;
	Fri, 02 Feb 2024 11:51:13 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rVs4b-0008IK-DO; Fri, 02 Feb 2024 11:51:09 +0000
Date: Fri, 2 Feb 2024 11:51:09 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: arinc.unal@arinc9.com
Cc: Daniel Golle <daniel@makrotopia.org>, DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>, Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	mithat.guner@xeront.com, erkin.bozoglu@xeront.com,
	Bartel Eerdekens <bartel.eerdekens@constell8.be>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net-next v3 5/7] net: dsa: mt7530: simplify
 mt7530_setup_port6() and change to void
Message-ID: <ZbzXLZ4ZyPSbqkdg@shell.armlinux.org.uk>
References: <20240202-for-netnext-mt7530-improvements-2-v3-0-63d5adae99ca@arinc9.com>
 <20240202-for-netnext-mt7530-improvements-2-v3-5-63d5adae99ca@arinc9.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240202-for-netnext-mt7530-improvements-2-v3-5-63d5adae99ca@arinc9.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Feb 02, 2024 at 12:19:11PM +0300, Arınç ÜNAL via B4 Relay wrote:
> From: Arınç ÜNAL <arinc.unal@arinc9.com>
> 
> This code is from before this driver was converted to phylink API. Phylink
> deals with the unsupported interface cases before mt7530_setup_port6() is
> run. Therefore, the default case would never run. However, it must be
> defined nonetheless to handle all the remaining enumeration values, the
> phy-modes.
> 
> Switch to if statement for RGMII and return which simplifies the code and
> saves an indent.
> 
> Set P6_INTF_MODE, which is the the three least significant bits of the
> MT7530_P6ECR register, to 0 for RGMII even though it will already be 0
> after reset. This is to keep supporting dynamic reconfiguration of the port
> in the case the interface changes from TRGMII to RGMII.
> 
> Disable the TRGMII clocks for all cases. They will be enabled if TRGMII is
> being used.
> 
> Read XTAL after checking for RGMII as it's only needed for the TRGMII
> interface mode.
> 
> Change mt7530_setup_port6() to void now that there're no error cases left.
> 
> Reviewed-by: Daniel Golle <daniel@makrotopia.org>
> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>

Yay. Less possible errors in mac_config()!

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

