Return-Path: <linux-kernel+bounces-14327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28B63821B6D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 13:10:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBE43282F2F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 12:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C361EEDB;
	Tue,  2 Jan 2024 12:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="A+4Q2ju+"
X-Original-To: linux-kernel@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6EF8EAE5;
	Tue,  2 Jan 2024 12:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=su1M2ye5o0dILxMk9cyElIFBQ93oGry7ZL5GdcqEe5c=; b=A+4Q2ju+LRwnACQadXkh3mRDOd
	F4GjSEr48wc7/6dH+TGpdTTVy+yOEJMzKGAvhnKZ2WqDHdz9Yfil/pofBF9pG85v5bIxSor/ksZsw
	ddZ//ZQ5wpf3NIRoFjM40NZhQtTpM4xOu79dYkqpqxLp8Pr2+0QtDdOsOtXgPizonvaqIz69URts9
	xqAbqIzfjmCZM5bz2WMNDgi2ID8bVdj9kANgTkCzUzAcRqED1QIkl/AlAbg3erSCwYGSGfsh2HVEv
	T/QMUxFge9AJYEWnWJpHHRqApfDINJyCSZ0H2yU3nJjZLoaMSQyaaddYENww1KgSnn4H3pkebA0yO
	A7nW7RyQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:46174)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rKdas-0006Wk-01;
	Tue, 02 Jan 2024 12:10:02 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rKdar-0005Hg-2n; Tue, 02 Jan 2024 12:10:01 +0000
Date: Tue, 2 Jan 2024 12:10:01 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Eric Woudstra <ericwouds@gmail.com>
Cc: Alexander Couzens <lynxis@fe80.eu>,
	Daniel Golle <daniel@makrotopia.org>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Frank Wunderlich <frank-w@public-files.de>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH RFC net-next] net: pcs: pcs-mtk-lynxi fix
 mtk_pcs_lynxi_get_state() for 2500base-x
Message-ID: <ZZP9GR15ufDbjGAJ@shell.armlinux.org.uk>
References: <20240102074408.1049203-1-ericwouds@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240102074408.1049203-1-ericwouds@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Jan 02, 2024 at 08:44:08AM +0100, Eric Woudstra wrote:
> From: Daniel Golle <daniel@makrotopia.org>
> 
> Need to fix mtk_pcs_lynxi_get_state() in order for the pcs to function
> correctly when the interface is set to 2500base-x, even when
> PHYLINK_PCS_NEG_INBAND_DISABLED is set.

Please describe your setup more fully. What is the link partner on this
2500base-X link?

In PHYLINK_PCS_NEG_INBAND_DISABLED mode, this means that phylink is
operating in inband mode, but Autoneg is clear in the advertisement
mask, meaning Autoneg is disabled and we are using a "fixed" setting.
state->speed and state->duplex should already be initialised.

> When the pcs is set to 2500base-x, the register values are not compatible
> with phylink_mii_c22_pcs_decode_state(). It results in parameters such as
> speed unknown and such. Then the mac/pcs are setup incorrectly and do not
> function.

Since Autoneg is clear, phylink_mii_c22_pcs_decode_state() won't
change state->speed and state->duplex, which should already be
correctly set.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

