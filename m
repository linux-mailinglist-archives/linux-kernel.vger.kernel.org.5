Return-Path: <linux-kernel+bounces-51812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C0729848F99
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 18:08:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38D32B22155
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 17:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C776249EF;
	Sun,  4 Feb 2024 17:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="O23N4o9h"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F8122EED;
	Sun,  4 Feb 2024 17:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707066488; cv=none; b=N0Q+RLANuzfo6hzA1PLcOOgQn2d2uapHHXNQ6DuVxL7gDU5VjWY9rg2Wsx4KDajiHg115HLIWpW4lwzf1AJ+hEk21PklasqwDMb/apqs5XZvUjfKGmDyRAB6Zn5eP3BclaR/a4Ez3GjizLEaErqKZ9k9W6verYQL4EruH2J/k54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707066488; c=relaxed/simple;
	bh=LFr7UxbEFGGYI7ZMatHVs/wputz0SkdQ/xfia29nFWs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BimIDuuGisLoxU0UPFc0FYIoZoWt2Sbg50v/vthLnCLmM6sJASgyCUorB4mjJFG5iWpv59kXtrEL7LTk/+q39ANQc0BXTjyS1m6mprACpi+0sXnitM0bhMF7NsPIXgKoDGCehCGKn4AZXFiPl+B2Vl5Xc83NgMeU+exnK58FBXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=O23N4o9h; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=U4d3lRQ+ywMUSxhsEgLIy35J6MHjR5owkJFbKhUA3UE=; b=O23N4o9hua1bAJ5AUx0rkQ/4NH
	nHRZyTmutWAbbf9FljfiUtU6WWkEryEp5R+bpzo9Pk/QP6PY/T/9p0VIbkUJjdSUSO6bnnjNJ9RGj
	RXeexlnfDUlbauEzkG/glRz5aql0Wemp7ZnWq08Rx58XDPhNDCDOW1MuK7H8mgzGM6jVAo+0Eruiy
	Vh7Qm8Np+KNUsW0wFF7K5tPMkbrOYRG5EsjvImM5Mz+GoyngUkfvXGPK6ZdxDMMrNMaEBMwjUKWOp
	AohLh166OCDr3k8zCWRCLn9At8Mh2FdDpbikUa97+oAGUJjGNdWaxUcj8EJmfxMxZ42G+QDqHodNz
	TWq5y0SA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:35158)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rWfyD-0008Ai-2R;
	Sun, 04 Feb 2024 17:07:53 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rWfy9-0001vQ-VX; Sun, 04 Feb 2024 17:07:50 +0000
Date: Sun, 4 Feb 2024 17:07:49 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
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
Subject: Re: [PATCH net-next v3 4/7] net: dsa: mt7530: move XTAL check to
 mt7530_setup()
Message-ID: <Zb/EZSqwChexAuso@shell.armlinux.org.uk>
References: <20240202-for-netnext-mt7530-improvements-2-v3-0-63d5adae99ca@arinc9.com>
 <20240202-for-netnext-mt7530-improvements-2-v3-4-63d5adae99ca@arinc9.com>
 <ZbzWpmZrukknMsYf@shell.armlinux.org.uk>
 <5b744f7f-2f63-4219-a0e9-8f08267b1fdd@arinc9.com>
 <Zb021ozEQSbU-gPd@makrotopia.org>
 <f6234b46-ce30-4b2a-9681-15633a06feff@arinc9.com>
 <Zb+ctEe9TVA3zhv8@shell.armlinux.org.uk>
 <4fa2ff0d-2804-4a58-980f-162e62b3dc9c@arinc9.com>
 <Zb+9jQUqaha3Idsi@shell.armlinux.org.uk>
 <850064fb-59c6-4e07-962a-6a213e9e7f90@arinc9.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <850064fb-59c6-4e07-962a-6a213e9e7f90@arinc9.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Sun, Feb 04, 2024 at 07:51:49PM +0300, Arınç ÜNAL wrote:
> On 4.02.2024 19:38, Russell King (Oracle) wrote:
> > On Sun, Feb 04, 2024 at 06:55:14PM +0300, Arınç ÜNAL wrote:
> > > On 4.02.2024 17:18, Russell King (Oracle) wrote:
> > > > On Sun, Feb 04, 2024 at 04:55:40PM +0300, Arınç ÜNAL wrote:
> > > > > This is not about laziness. This is before patch 2:
> > > > > 
> > > > > phylink_mac_ops :: mac_config() -> dsa_port_phylink_mac_config()
> > > > > -> dsa_switch_ops :: phylink_mac_config() -> mt753x_phylink_mac_config()
> > > > >      -> mt753x_mac_config()
> > > > >         -> mt753x_info :: mac_port_config() -> mt7530_mac_config()
> > > > >            -> mt7530_setup_port5()
> > > > >      -> mt753x_pad_setup()
> > > > >         -> mt753x_info :: pad_setup() -> mt7530_pad_clk_setup()
> > > > > 
> > > > > This is after:
> > > > > 
> > > > > phylink_mac_ops :: mac_config() -> dsa_port_phylink_mac_config()
> > > > > -> dsa_switch_ops :: phylink_mac_config() -> mt753x_phylink_mac_config()
> > > > >      -> mt753x_mac_config()
> > > > >         -> mt753x_info :: mac_port_config() -> mt7530_mac_config()
> > > > >            -> mt7530_setup_port5()
> > > > >            -> mt7530_setup_port6()
> > > > > 
> > > > > Patch 2 does not move mt7530_setup_port6() to be called from
> > > > > phylink_mac_ops :: mac_config(), it already is. There is no valid reason to
> > > > > reorder the patches.
> > > > > 
> > > > > My response to Russell should've stated this instead of focusing on his
> > > > > second sentence.
> > > > 
> > > > This patch moves the test for a 20MHz crystal to mt7530_setup(),
> > > > which is something that is entirely orthogonal to patch 2, which
> > > > can be done cleanly (I've just applied the patches in the original
> > > > order and then reordered them:
> > > > 
> > > > 98c481f5d706 net: dsa: mt7530: do not clear config->supported_interfaces
> > > > 93c6b53b17f4 net: dsa: mt7530: correct port capabilities of MT7988
> > > > c9c6d4c51a1d net: dsa: mt7530: simplify mt7530_setup_port6() and change to void
> > > > adfa948253e0 net: dsa: mt7530: remove pad_setup function pointer
> > > > 57e21e6c2fc0 net: dsa: mt7530: call port 6 setup from mt7530_mac_config()
> > > > 959a0f9323c8 net: dsa: mt7530: move XTAL check to mt7530_setup()
> > > > 856ab64a22ef net: dsa: mt7530: empty default case on mt7530_setup_port5()
> > > > 
> > > > No problems. The end result is identical comparing the git tree at the
> > > > original "move XTAL" patch with adfa948253e0.
> > > > 
> > > > Now, if we look at "net: dsa: mt7530: remove pad_setup function pointer"
> > > > we can see that yes, the pad_setup() method was called from mac_confing,
> > > > but this is the exact contents of that patch removing the callsite:
> > > > 
> > > > -               mt753x_pad_setup(ds, state);
> > > > 
> > > > This returns an integer, which may be an error code, which is ignored.
> > > > Therefore, if the XTAL frequency check fires, and mt753x_pad_setup()
> > > > returns an error, it is ignored today.
> > > > 
> > > > After "net: dsa: mt7530: call port 6 setup from mt7530_mac_config()"
> > > > the renamed pad_setup() method is now called from mac_config() thusly:
> > > > 
> > > > +               ret = mt7530_setup_port6(priv->ds, interface);
> > > > +               if (ret)
> > > > +                       return ret;
> > > > 
> > > > So now the error checks cause mt7530_mac_config() to return an error
> > > > which in turn causes mt753x_mac_config() to fail, and therefore
> > > > mt753x_phylink_mac_config() has different behaviour.
> > > > 
> > > > So, patch 2 changes the driver behaviour in the case of a 20MHz XTAL,
> > > > which is then changed again by patch 4.
> > > > 
> > > > It would be better to have only one change of behaviour by moving
> > > > patch 4 before patch 2.
> > > 
> > > If the idea is to not bring any more error returns to mt753x_mac_config()
> > > because the return code is actually checked for that, I should do a bit
> > > more effort and put patch 5 before patch 2 as well, to live up to what you
> > > originally requested.
> > 
> > I assume you are referring to getting rid of the default case in
> > mt7530_pad_clk_setup().
> > 
> > In patch "net: dsa: mt7530: call port 6 setup from mt7530_mac_config()"
> > where you move this to be called from mt7530_mac_config(), you add it
> > as:
> > 
> > +       } else if (port == 6) {
> > +               ret = mt7530_setup_port6(priv->ds, interface);
> > +               if (ret)
> > +                       return ret;
> > +       }
> > 
> > So it is only called for port 6. The switch within the called function
> > deals with PHY_INTERFACE_MODE_RGMII and PHY_INTERFACE_MODE_TRGMII.
> > Anything else results in the use of the default case, and thus
> > returning an error.
> > 
> > Since mt7530_mac_port_get_caps() does this for port 6:
> > 
> >                  __set_bit(PHY_INTERFACE_MODE_RGMII,
> >                            config->supported_interfaces);
> >                  __set_bit(PHY_INTERFACE_MODE_TRGMII,
> >                            config->supported_interfaces);
> > 
> > mt7530_setup_port6() will only ever be called for these two modes,
> > which means that the default case is unreachable, thus we will never
> > execute that path, thus whether that path returns an error or not is
> > completely irrelevant.
> > 
> > The only case in mt7530_setup_port6() / mt7530_pad_clk_setup() which
> > can today return an error is the XTAL check.
> > 
> > Therefore, my suggestion makes complete sense, and there is no need
> > to also move patch 5.
> 
> Understood. I've already submitted v4 which moves patch 5. The remaining
> benefit is that there're fewer code changes as I don't need to add an error
> return for mt7530_setup_port6() and then remove it.

I'm pretty sure netdev has a rule _not_ to submit the next version of
a patch series if discussion about the previous is still ongoing...
but I can't find any of the netdev rules in Documentation/networking
anymore, and nothing stands out in Documentation/process... ah,
Documentation/process/maintainer-netdev.rst, and here we are:

"Make sure you address all the feedback in your new posting. Do not post
a new
version of the code if the discussion about the previous version is
still
ongoing, unless directly instructed by a reviewer."

Discussion was still ongoing over this point, so ideally you should
have waited instead of presenting a fait-accompli _during_ the
ongoing discussion.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

