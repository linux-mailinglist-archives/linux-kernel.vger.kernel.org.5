Return-Path: <linux-kernel+bounces-14347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C47E1821BB3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 13:37:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 607AE1F229BE
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 12:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC69DF505;
	Tue,  2 Jan 2024 12:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="S0UnOMij"
X-Original-To: linux-kernel@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6DFF4F4;
	Tue,  2 Jan 2024 12:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=EKt6waYkREQSl8TOEPwS+m4Ybyc4+NtjQUDV5bNbQWs=; b=S0UnOMijCUX3JsRUr+wAE4YgUf
	eE9RQMlrBh1t9kmigzTWvhMhi71gOETUnZhO+58XxWphtoXyw3uthVlbhWzEuqXTEH/jKgMnD9XJl
	lmE+XNhJUHF4E+87DAc3z6ASZSw1QTFP9k1pURiHfE7GXVyX6QCvE5yYzFQFA03Pl1dvr00fH2EKx
	nBHnIgIodzNv0e3nV/Ki3wMSXzEzYEgkbAW2gSB0cLcZblTqgz3Tv1j2/V/gJBR6BYrQEw/n9ow2V
	vaC8ZxRUMlczXMv27GBH+Q9orgljB4nUEdNR/Og6ySj5CmdbIGo1dWgr4RNBOe0t3c2yxxdiiNp1p
	eywa18Ig==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:34188)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rKe0f-0006Xv-27;
	Tue, 02 Jan 2024 12:36:41 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rKe0h-0005IC-OE; Tue, 02 Jan 2024 12:36:43 +0000
Date: Tue, 2 Jan 2024 12:36:43 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Eric Woudstra <ericwouds@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Frank Wunderlich <frank-w@public-files.de>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH RFC net-next] net: phylink: add quirk for disabling
 in-band-status for mediatek pcs at 2500base-x
Message-ID: <ZZQDWzYlxAKl0JxI@shell.armlinux.org.uk>
References: <20240102074326.1049179-1-ericwouds@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240102074326.1049179-1-ericwouds@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Jan 02, 2024 at 08:43:26AM +0100, Eric Woudstra wrote:
> In follow up to: net: pcs: pcs-mtk-lynxi: use 2500Base-X without AN
> 
> MediaTek LynxI PCS, 2500Base-X will only work without inband status due to
> hardware limitation.

Yes, we need better support for 2500base-X connected to a PHY.
Currently, we treat both base-X interface modes as _media_ side modes
by looking at the Autoneg bit. However, given that 2500base-X has been
around for ages in vendor-specific forms, we need to do better. The
introduction of the PHYLINK_PCS_NEG_* enum and phylink_pcs_neg_mode()
is a step towards resolving this (as well as ensuring consistency of
implementation so we _can_ start to address it in phylink rather than
having different PCS drivers doing weird stuff.)

I am _not_ of the opinion that we should be dealing with this based on
compatibles or anything like that.

As 6.6 was declared LTS, I think we can now move phylink_pcs_neg_mode()
into phylink.c, and thus think about what we should do with:

+               /* 1000base-X is designed for use media-side for Fibre
+                * connections, and thus the Autoneg bit needs to be
+                * taken into account. We also do this for 2500base-X
+                * as well, but drivers may not support this, so may
+                * need to override this.
+                */
+               if (!phylink_autoneg_inband(mode))
+                       neg_mode = PHYLINK_PCS_NEG_OUTBAND;
+               else if (linkmode_test_bit(ETHTOOL_LINK_MODE_Autoneg_BIT,
+                                          advertising))
+                       neg_mode = PHYLINK_PCS_NEG_INBAND_ENABLED;
+               else
+                       neg_mode = PHYLINK_PCS_NEG_INBAND_DISABLED;
+               break;

Specifically, the linkmode_test_bit() bit. When there is a PHY present,
the link between the PCS and PHY should _not_ depend on Autoneg as that
is indicates what we want for the _media_ side, and in the case of a
PCS-to-PHY link, that is not the media.

The next issue is the one that you refer to, and there's several issues:

1. some implementations of 2500base-X do not support inband
2. some implementations of 2500base-X appear to require inband
   (e.g. mvneta, mvpp2)

I have some thoughts on this, but I don't have the time to express them
in email at the moment (too much to get through post-Christmas post-
Covid.)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

