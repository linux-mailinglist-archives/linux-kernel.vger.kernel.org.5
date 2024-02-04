Return-Path: <linux-kernel+bounces-51695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B884848E58
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 15:19:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF4EA1C20E5D
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 14:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C53F2260B;
	Sun,  4 Feb 2024 14:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="czEZ28UZ"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA92225AE;
	Sun,  4 Feb 2024 14:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707056336; cv=none; b=HE2TiRuPwhhSC/ISrEBbpSpWDxwwQGZk/ATeeLOaadAICLDoFRuAzq8+KdsN4eQPzC45oB4m8aK7eQh2XymQKMzQyGuJGx9fyMjL1QcrwSpCuxau6TB696y4emWQnV4lirtXfqbIrSTEeZXOy5uboCcKOq48YAq5h00gMXkc6oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707056336; c=relaxed/simple;
	bh=quF0sI4yyVsv4XVcnTDTvpd+pofVhyqDVTIKsul4VjU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I/YJbu716kUNG/yDVensxfjSIucXJnQXmVR4IGue/TmzcwecXwwBFLn9Qf29yAku1i31kI6nroQuOAyK5zfnvy+/hVKQqIt7Ckc8pVBrtnhcnTs7jSSApz3YBPF2xwlAH+RhxQIK0M68IjelVNrUDpZRluQk3r+LFQ3TJw9vpCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=czEZ28UZ; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=h/meM589cBbKRoq1Yh/j2VWjBxZZoI+3UVuISqojP0I=; b=czEZ28UZCVcwyVfK6IYz46L35k
	oS8E6Vz8Ji1Vpyh5NGltpe245f77llZAn+oQy9b/Jizwz/ipsrnMhl/7sNilHLxnPSWMwmsytR4MO
	MxUfbMhGTcqkh9D05VB0YsWC5lBprBPZEi4rkcqesMHn0VzvAtzc64Nhad2bK0jP8NqSN3D8gf0Zp
	BdCu3xE676JJgPE7B0DwmqNJZFtOtREgTtm7YGkBLRLON+1xnuzQQ5DjuTGu4uxfvO6QBAeNJw8qh
	Hcvc3QeGOUuQ2CekJmxPnY/IHRdOF6/RNPAMPNpBX0xMIDE/vke9ENAPrljLKA2KAtkgqwNnbe+HD
	Jda3b1yg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:54308)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rWdKM-00082q-1a;
	Sun, 04 Feb 2024 14:18:34 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rWdKG-0001qF-5w; Sun, 04 Feb 2024 14:18:28 +0000
Date: Sun, 4 Feb 2024 14:18:28 +0000
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
Message-ID: <Zb+ctEe9TVA3zhv8@shell.armlinux.org.uk>
References: <20240202-for-netnext-mt7530-improvements-2-v3-0-63d5adae99ca@arinc9.com>
 <20240202-for-netnext-mt7530-improvements-2-v3-4-63d5adae99ca@arinc9.com>
 <ZbzWpmZrukknMsYf@shell.armlinux.org.uk>
 <5b744f7f-2f63-4219-a0e9-8f08267b1fdd@arinc9.com>
 <Zb021ozEQSbU-gPd@makrotopia.org>
 <f6234b46-ce30-4b2a-9681-15633a06feff@arinc9.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f6234b46-ce30-4b2a-9681-15633a06feff@arinc9.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Sun, Feb 04, 2024 at 04:55:40PM +0300, Arınç ÜNAL wrote:
> On 2.02.2024 21:39, Daniel Golle wrote:
> > On Fri, Feb 02, 2024 at 09:16:02PM +0300, Arınç ÜNAL wrote:
> > > On 2.02.2024 14:48, Russell King (Oracle) wrote:
> > > > On Fri, Feb 02, 2024 at 12:19:10PM +0300, Arınç ÜNAL via B4 Relay wrote:
> > > > > From: Arınç ÜNAL <arinc.unal@arinc9.com>
> > > > > 
> > > > > The crystal frequency concerns the switch core. The frequency should be
> > > > > checked when the switch is being set up so the driver can reject the
> > > > > unsupported hardware earlier and without requiring port 6 to be used.
> > > > > 
> > > > > Move it to mt7530_setup(). Drop the unnecessary function printing.
> > > > > 
> > > > > Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
> > > > > Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> > > > > Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
> > > > 
> > > > I would prefer this to be earlier in the series, before patch 2 which
> > > > moves mt7530_setup_port6() to be called from mac_config(). mac_config()
> > > > is supposed to be configuration error-free - in other words, all state
> > > > should have been checked before hand.
> > > 
> > > I agree but mt7530_mac_config() is not a void function yet. The
> > > mac_port_config member of the mt753x_info structure points to this
> > > function. My next patch series gets rid of all useless error returns on the
> > > phylink path and change mac_port_config to void. So I don't think working
> > > on this patch series further will worth the effort. I'd rather have this
> > > version applied as is.
> > 
> > I agree regarding not changing the patch itself, but I also agree
> > with Russell regarding the patch ordering. I know it's a 10-minute
> > git headache to rebase the patches on top of each other in a different
> > order, but you can easily compare the end result being identical to
> > what you had before and hence don't need to retest.
> 
> This is not about laziness. This is before patch 2:
> 
> phylink_mac_ops :: mac_config() -> dsa_port_phylink_mac_config()
> -> dsa_switch_ops :: phylink_mac_config() -> mt753x_phylink_mac_config()
>    -> mt753x_mac_config()
>       -> mt753x_info :: mac_port_config() -> mt7530_mac_config()
>          -> mt7530_setup_port5()
>    -> mt753x_pad_setup()
>       -> mt753x_info :: pad_setup() -> mt7530_pad_clk_setup()
> 
> This is after:
> 
> phylink_mac_ops :: mac_config() -> dsa_port_phylink_mac_config()
> -> dsa_switch_ops :: phylink_mac_config() -> mt753x_phylink_mac_config()
>    -> mt753x_mac_config()
>       -> mt753x_info :: mac_port_config() -> mt7530_mac_config()
>          -> mt7530_setup_port5()
>          -> mt7530_setup_port6()
> 
> Patch 2 does not move mt7530_setup_port6() to be called from
> phylink_mac_ops :: mac_config(), it already is. There is no valid reason to
> reorder the patches.
> 
> My response to Russell should've stated this instead of focusing on his
> second sentence.

This patch moves the test for a 20MHz crystal to mt7530_setup(),
which is something that is entirely orthogonal to patch 2, which
can be done cleanly (I've just applied the patches in the original
order and then reordered them:

98c481f5d706 net: dsa: mt7530: do not clear config->supported_interfaces
93c6b53b17f4 net: dsa: mt7530: correct port capabilities of MT7988
c9c6d4c51a1d net: dsa: mt7530: simplify mt7530_setup_port6() and change to void
adfa948253e0 net: dsa: mt7530: remove pad_setup function pointer
57e21e6c2fc0 net: dsa: mt7530: call port 6 setup from mt7530_mac_config()
959a0f9323c8 net: dsa: mt7530: move XTAL check to mt7530_setup()
856ab64a22ef net: dsa: mt7530: empty default case on mt7530_setup_port5()

No problems. The end result is identical comparing the git tree at the
original "move XTAL" patch with adfa948253e0.

Now, if we look at "net: dsa: mt7530: remove pad_setup function pointer"
we can see that yes, the pad_setup() method was called from mac_confing,
but this is the exact contents of that patch removing the callsite:

-               mt753x_pad_setup(ds, state);

This returns an integer, which may be an error code, which is ignored.
Therefore, if the XTAL frequency check fires, and mt753x_pad_setup()
returns an error, it is ignored today.

After "net: dsa: mt7530: call port 6 setup from mt7530_mac_config()"
the renamed pad_setup() method is now called from mac_config() thusly:

+               ret = mt7530_setup_port6(priv->ds, interface);
+               if (ret)
+                       return ret;

So now the error checks cause mt7530_mac_config() to return an error
which in turn causes mt753x_mac_config() to fail, and therefore
mt753x_phylink_mac_config() has different behaviour.

So, patch 2 changes the driver behaviour in the case of a 20MHz XTAL,
which is then changed again by patch 4.

It would be better to have only one change of behaviour by moving
patch 4 before patch 2.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

