Return-Path: <linux-kernel+bounces-132815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE406899AA0
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 12:21:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4183282E0C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 10:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ADB916ABC0;
	Fri,  5 Apr 2024 10:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="XxhDIG9x"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18F0160798;
	Fri,  5 Apr 2024 10:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712312473; cv=none; b=Yv3hYd9Expuo95jSPfV5yGpg+5ffTzUfNBPdKojHpiBSNuQ4o6eLeuyD61IcpdE7u1lCYC/ouVbWSdXSaVaXef5PMnGxMlvKVPx5f5/sM7e0VCC7ojcDjEaSq7dkORC2RRRukhVAVPBiMq1W3uGvMJKigtI/yaQhkl3wtTSyNuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712312473; c=relaxed/simple;
	bh=8OTcYbM5BXtHpjptecVPfKlc9zekT5TkSATwQT2nhFg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=foCApdi0hU3JecENYDeQ4+vC0RIeK0KLhPyhqzQ35SxLBRykJXQ2xIhlBtH2O3sHG85aN6MP3kJmZ2NcW7c1bk2GbiwVQyrfaB37tj6W1ANxDjS8II9T4WaHsD5ta5RFX17ixbY4C3QI+h9639MRQJizv0KkGOAVcTI+iq+0vcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=XxhDIG9x; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=h6ooeeo3yUb6+TuxcE/grwqLZtdIxPaR752SVlSVmKQ=; b=XxhDIG9xuOitAMHCbDFb0BlB6B
	DiryAlmDMJmtwZ815XVyY3qDkdkswFq9dqYmkmXWhgDCmegsEGEdYMyBVsHM7khh2WLVp9LoJ8jjP
	NE9D52HkUhK2rYVojzqgnHMNzNg0Gj/hegRy7OrJ2+04Tg0M6eah+L9bZBNXqjNTKYlh+XUxTC5tl
	nGyxozXpq0JW9Y7Un7dWNZy/1jryTfstjW4/EJAW9T6k5HHWt4IJIfsAmWmDDcfdF/Pz52Zldcryh
	kcaOb7C+cjctXDi4/isMSf+shwF5twQzHYBItIZcIOh7bFSfxIc5pgsi0TLwgNQLlw5EyUPDaFjJR
	fjLiabFw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:47700)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rsggk-0002HW-22;
	Fri, 05 Apr 2024 11:20:50 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rsggh-0001Jq-Nk; Fri, 05 Apr 2024 11:20:47 +0100
Date: Fri, 5 Apr 2024 11:20:47 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Daniel Machon <daniel.machon@microchip.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Lars Povlsen <lars.povlsen@microchip.com>,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Bjarni Jonasson <bjarni.jonasson@microchip.com>,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: sparx5: fix reconfiguration of PCS on link mode
 change
Message-ID: <Zg/Qf4P5gAzRUYuK@shell.armlinux.org.uk>
References: <20240405-link-mode-reconfiguration-fix-v1-1-c1480bc2346a@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240405-link-mode-reconfiguration-fix-v1-1-c1480bc2346a@microchip.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Apr 05, 2024 at 11:53:15AM +0200, Daniel Machon wrote:
> It was observed that the PCS would be misconfigured on link mode change,
> if the negotiated link mode went from no-inband capabilities to in-band
> capabilities. This bug appeared after the neg_mode change of phylink [1],
> but is really due to the wrong config being used when reconfiguring the PCS.

I don't see how the change you point to could have changed the
behaviour. Old code:

	conf.inband = phylink_autoneg_inband(mode);
	conf.autoneg = phylink_test(advertising, Autoneg);

New code:

	conf.inband = neg_mode == PHYLINK_PCS_NEG_INBAND_DISABLED ||
		      neg_mode == PHYLINK_PCS_NEG_INBAND_ENABLED;
	conf.autoneg = neg_mode == PHYLINK_PCS_NEG_INBAND_ENABLED;

where, for SGMII or 802.3z modes, neg_mode will be one of
PHYLINK_PCS_NEG_INBAND_DISABLED or PHYLINK_PCS_NEG_INBAND_ENABLED if
phylink_autoneg_inband(mode) is true, or PHYLINK_PCS_NEG_OUTBAND if
not.

It does change conf.autoneg slightly in that this will always be true
for SGMII, but will only be true for Autoneg + 802.3z modes.

As far as your code change goes, it looks correct to me, but I think
it's fixing a bug that goes back long before the commit you have
identified.

However, I think there's another issue here which is more relevant to
the problem you describe in your commit message. If you look at
port_conf_has_changed(), you will notice that it fails to compare
conf.inband, and thus fails to notice any change in the setting of
that configuration item. This will result in sparx5_port_pcs_set()
not even being called if only conf.inband changes state.

Thus, changing from in-band to out-of-band or vice versa won't have
any effect if this is the only change that occurs, and this also
exists prior to my change.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

