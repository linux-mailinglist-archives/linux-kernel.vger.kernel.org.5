Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E9FD801BA7
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 10:36:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231998AbjLBJai (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 04:30:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbjLBJag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 04:30:36 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 434ED129;
        Sat,  2 Dec 2023 01:30:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=cJLjF77y4SxHEjhOXmOD85mb2tXiT1lNxpnlYkZDglQ=; b=PV3qkCYHbGLiIITrG9RmdVBpGt
        dZM+/IuzIBJsIhispOgoPrWvFxw0DTPbZGEm5CtaF0Qs2Ep3N+gsw0lOiKrWZH0CC6cHPENHUcycP
        LYjXjV8dJHRM6XIxLqVrf0aunHcAC/o4Lz7CGJrMtTTRABiQwnN35QNhl6dWTt2nl5OwohIh+/GB7
        5MotVL2W4IVGe+suBjtekgHICGTClzxiF2pQJeLSVBybGgTLt/2enbborcxowEaaKq1NYVLomTMeX
        ftnt37kMGJlxW5Zmn7K7bnzLPdvcZc6QTEbYMoWyKUuts2+L8sNMF0fjJzvi07+2tQ0+ta/EhMcnc
        W5a8JLhQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:53892)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1r9MKT-0003yv-03;
        Sat, 02 Dec 2023 09:30:29 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1r9MKQ-0006xW-U6; Sat, 02 Dec 2023 09:30:26 +0000
Date:   Sat, 2 Dec 2023 09:30:26 +0000
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Cc:     Simon Horman <horms@kernel.org>,
        Daniel Golle <daniel@makrotopia.org>,
        Landen Chao <Landen.Chao@mediatek.com>,
        DENG Qingfang <dqfext@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Frank Wunderlich <frank-w@public-files.de>,
        Bartel Eerdekens <bartel.eerdekens@constell8.be>,
        mithat.guner@xeront.com, erkin.bozoglu@xeront.com
Subject: Re: [PATCH net-next 07/15] net: dsa: mt7530: do not run
 mt7530_setup_port5() if port 5 is disabled
Message-ID: <ZWr5MiiR1OQujoGG@shell.armlinux.org.uk>
References: <20231118123205.266819-1-arinc.unal@arinc9.com>
 <20231118123205.266819-8-arinc.unal@arinc9.com>
 <20231121185358.GA16629@kernel.org>
 <a2826485-70a6-4ba7-89e1-59e68e622901@arinc9.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a2826485-70a6-4ba7-89e1-59e68e622901@arinc9.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 02, 2023 at 11:45:42AM +0300, Arınç ÜNAL wrote:
> Hi Simon.
> 
> On 21.11.2023 21:53, Simon Horman wrote:
> > On Sat, Nov 18, 2023 at 03:31:57PM +0300, Arınç ÜNAL wrote:
> > > There's no need to run all the code on mt7530_setup_port5() if port 5 is
> > > disabled. The only case for calling mt7530_setup_port5() from
> > > mt7530_setup() is when PHY muxing is enabled. That is because port 5 is not
> > > defined as a port on the devicetree, therefore, it cannot be controlled by
> > > phylink.
> > > 
> > > Because of this, run mt7530_setup_port5() if priv->p5_intf_sel is
> > > P5_INTF_SEL_PHY_P0 or P5_INTF_SEL_PHY_P4. Remove the P5_DISABLED case from
> > > mt7530_setup_port5().
> > > 
> > > Stop initialising the interface variable as the remaining cases will always
> > > call mt7530_setup_port5() with it initialised.
> > > 
> > > Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
> > > Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
> > > ---
> > >   drivers/net/dsa/mt7530.c | 9 +++------
> > >   1 file changed, 3 insertions(+), 6 deletions(-)
> > > 
> > > diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
> > > index fc87ec817672..1aab4c3f28b0 100644
> > > --- a/drivers/net/dsa/mt7530.c
> > > +++ b/drivers/net/dsa/mt7530.c
> > > @@ -942,9 +942,6 @@ static void mt7530_setup_port5(struct dsa_switch *ds, phy_interface_t interface)
> > >   		/* MT7530_P5_MODE_GMAC: P5 -> External phy or 2nd GMAC */
> > >   		val &= ~MHWTRAP_P5_DIS;
> > >   		break;
> > > -	case P5_DISABLED:
> > > -		interface = PHY_INTERFACE_MODE_NA;
> > > -		break;
> > >   	default:
> > >   		dev_err(ds->dev, "Unsupported p5_intf_sel %d\n",
> > >   			priv->p5_intf_sel);
> > > @@ -2313,8 +2310,6 @@ mt7530_setup(struct dsa_switch *ds)
> > >   		 * Set priv->p5_intf_sel to the appropriate value if PHY muxing
> > >   		 * is detected.
> > >   		 */
> > > -		interface = PHY_INTERFACE_MODE_NA;
> > > -
> > >   		for_each_child_of_node(dn, mac_np) {
> > >   			if (!of_device_is_compatible(mac_np,
> > >   						     "mediatek,eth-mac"))
> > > @@ -2346,7 +2341,9 @@ mt7530_setup(struct dsa_switch *ds)
> > >   			break;
> > >   		}
> > > -		mt7530_setup_port5(ds, interface);
> > > +		if (priv->p5_intf_sel == P5_INTF_SEL_PHY_P0 ||
> > > +		    priv->p5_intf_sel == P5_INTF_SEL_PHY_P4)
> > > +			mt7530_setup_port5(ds, interface);
> > 
> > Hi Arınç,
> > 
> > It appears that interface is now uninitialised here.
> > 
> > Flagged by Smatch.
> 
> I'm not sure why it doesn't catch that for mt7530_setup_port5() to run
> here, priv->p5_intf_sel must be either P5_INTF_SEL_PHY_P0 or
> P5_INTF_SEL_PHY_P4. And for that to happen, the interface variable will be
> initialised.

It's probably due to the complexities involved in analysing the values
of variables, especially when they're in structures that are passed in.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
