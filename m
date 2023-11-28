Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB9D57FB80E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 11:38:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344452AbjK1KiB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 05:38:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234937AbjK1Kha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 05:37:30 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 435E32720;
        Tue, 28 Nov 2023 02:35:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ywzJ900a2ajqKWMAZ1RXwUxbjIFP4a4N/LNkum40b84=; b=OEaE8iBJFMLypOJEI7eDK6VbXl
        HevRBMVCn3wtHBWmLzYecdk3q/VcAcQRFH5dalBCaCrFwhMTVdzQ5BcvQa3xsF1YE9L/a+XQeXoSc
        TY8c4FO3eAFzAWZPD8Vhtw27uNh6sfjxbz2n2alhRf+7HJGugNwAb+C6oElow7RyJdOj5ffDFR/Gi
        T9FPW7U5z6JxJohiIus6zRYQ2nDfqAJ9ATa9fy4lpnWIVy9YwkEZ3tOGCP3Ftqpygho2vCDB4T3Jl
        CLMAiQRkfPG1y7Ua+Iuxi+SYzV4ZHF/SJ0Gf8UcmZ361n4uTeb+DWMAenQ56Z1ndb0dCuHRRFjk5I
        +1KL3LTQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:37610)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1r7vQi-00079K-05;
        Tue, 28 Nov 2023 10:35:00 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1r7vQi-0002sT-7G; Tue, 28 Nov 2023 10:35:00 +0000
Date:   Tue, 28 Nov 2023 10:35:00 +0000
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Jie Luo <quic_luoj@quicinc.com>
Cc:     Andrew Lunn <andrew@lunn.ch>, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, hkallweit1@gmail.com, corbet@lwn.net,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v6 3/6] net: phy: at803x: add QCA8084 ethernet phy support
Message-ID: <ZWXCVPq2aE59uJs+@shell.armlinux.org.uk>
References: <20231126060732.31764-1-quic_luoj@quicinc.com>
 <20231126060732.31764-4-quic_luoj@quicinc.com>
 <0b22dd51-417c-436d-87ce-7ebc41185860@lunn.ch>
 <f0604c25-87a7-497a-8884-7a779ee7a2f5@quicinc.com>
 <8e4046dd-813c-4766-83fb-c54a700caf31@lunn.ch>
 <9c4c1fe7-5d71-4bb2-8b92-f4e9a136e93d@quicinc.com>
 <ZWWsLf/w82N0vwBq@shell.armlinux.org.uk>
 <a324b7d4-5265-4766-814a-36c53a84f732@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a324b7d4-5265-4766-814a-36c53a84f732@quicinc.com>
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

On Tue, Nov 28, 2023 at 05:50:41PM +0800, Jie Luo wrote:
> 
> 
> On 11/28/2023 5:00 PM, Russell King (Oracle) wrote:
> > On Tue, Nov 28, 2023 at 03:16:45PM +0800, Jie Luo wrote:
> > > > > The interface mode is passed in the .config_init, which is configured
> > > > > by the PCS driver, the hardware register is located in the PCS, this
> > > > > driver will be pushed later.
> > > > 
> > > > Is this the same as how the syqca807x works? Can the PCS driver be
> > > > shared by these two drivers?
> > > 
> > > I am not sure syqca807x, would you point me the code path of this driver?
> > > 
> > > > 
> > > > What i don't like at the moment is that we have two driver
> > > > developments going on at once for hardware which seems very similar,
> > > > but no apparent cooperation?
> > > > 
> > > > 	Andrew
> > > 
> > > The PCS of qca8084 is the PHY PCS, which should be new PCS driver,
> > > in the previous chips, we don't have this kind of PHY PCS.
> > 
> > No. PCS drivers are for MAC-side PCS drivers, not PHY-side PCS drivers.
> > 
> >                       +-------------
> > 		     |     PHY
> > MAC---PCS --- link --- PCS --- ...
> >         ^             |  ^
> >         |	     +--|----------
> >    For this PCS          |
> >                    Not for this PCS
> > 
> 
> The PCS drivers in drivers/net/pcs/ should be in PHY side, such as
> pcs-lynx.c and pcs-xpcs.c, they are configuring the MDIO device
> registers.

Wrong. No they are not. Just because they are accessed via MDIO does
not mean they are in the PHY. MDIO can be used for more than just the
PHY, and is on a lot of platforms.

LX2160A for example has many MDIO buses, and the PCSes (of which there
are multiple inside the chip, and use pcs-lynx) are accessed through
the MDIO bus specific to each port. They are not MMIO mapped.

The same is true on stmmac platforms, where xpcs is used - xpcs is the
_MAC_ side PCS.

Sorry but you are wrong.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
