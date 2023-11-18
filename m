Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C05897F02B0
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 20:36:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231215AbjKRTgc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 14:36:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231640AbjKRTgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 14:36:13 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECBB126A1;
        Sat, 18 Nov 2023 11:33:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=k1aqD8s308HU/CtiyzCh6FFV6oCvcUqmf4QRDj/tSmU=; b=FfGMdm7P9JHeq7crmQS6ocDyYq
        rR10RxYawbG2+cH5LYzCM47xsVZ6YLwEr5PZtrC22xvfLB/KVjUW6mOSDqINsbHd2JVfgCGP9er6o
        V/GpwNX6GnlnX1kUTjAeZvw/crRzQtD0tPZd7cbLp2YtuSuGMkEbHCugn2Wh6rGN4V2H4iZaicUhW
        b8zxwi3lEvgen7q6kaB2Y4qGMrGQVAPOFaGjIb4S/4jFt4aDiMcxdZF08zshRWFheZ3lir9oJzTnK
        hIkx4wX4LmrIzTeAdzJCqgCo0GJw4fItZrHAnMjG+pbkVqmMxmPjxh2l6D47pSZU3sgCyoIVjEJHy
        p6b3zy9Q==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:46872)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1r4R4W-0003vd-0d;
        Sat, 18 Nov 2023 19:33:40 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1r4R4U-0001OK-SV; Sat, 18 Nov 2023 19:33:38 +0000
Date:   Sat, 18 Nov 2023 19:33:38 +0000
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Luo Jie <quic_luoj@quicinc.com>, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, hkallweit1@gmail.com, corbet@lwn.net,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v5 3/6] net: phy: at803x: add QCA8084 ethernet phy support
Message-ID: <ZVkRkhMHWcAR37fW@shell.armlinux.org.uk>
References: <20231118062754.2453-1-quic_luoj@quicinc.com>
 <20231118062754.2453-4-quic_luoj@quicinc.com>
 <1eb60a08-f095-421a-bec6-96f39db31c09@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1eb60a08-f095-421a-bec6-96f39db31c09@lunn.ch>
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

On Sat, Nov 18, 2023 at 04:51:42PM +0100, Andrew Lunn wrote:
> On Sat, Nov 18, 2023 at 02:27:51PM +0800, Luo Jie wrote:
> > Add qca8084 PHY support, which is four-port PHY with maximum
> > link capability 2.5G, the features of each port is almost same
> > as QCA8081 and slave seed config is not needed.
> > 
> > Three kind of interface modes supported by qca8084.
> > PHY_INTERFACE_MODE_10G_QXGMII, PHY_INTERFACE_MODE_2500BASEX and
> > PHY_INTERFACE_MODE_SGMII.
> 
> Sorry for joining the conversation late.
> 
> I'm trying to get my head around QXGMII. Let me describe what i think
> is happening, and then you can correct me....
> 
> You have 4 MACs, probably in a switch. The MII interfaces from these
> MACs go into a multiplexer, and out comes QXGMII? You then have a
> SERDES interface out of the switch and into the PHY package. Inside
> the PHY package there is a demultiplexor, giving you four MII
> interfaces, one to each PHY in the package.
> 
> If you have the PHY SERDES running in 2500BaseX, you have a single
> MAC, no mux/demux, and only one PHY is used? The other three are idle.
> Same from SGMII?
> 
> So the interface mode QXGMII is a property of the package. It is not
> really a property of one PHY. Having one PHY using QXGMII and another
> SGMII does not work?

10G_QXGMII is defined in the Cisco USXGMII multi-port document as one
of several possibilities for a USXGMII-M link. The Cisco document can
be a little confusing beause it states that 10G_QXGMII supports 10M,
100M, 1G and 2.5G, and then only talks about a 10G and 100M/1G MAC.

For 10G_QXGMII, there are 4 MAC interfaces. These are connected to a
rate "adaption" through symbol replication block, and then on to a
clause 49 PCS block.

There is then a port MUX and framing block, followed by the PMA
serdes which communicates with the remote end over a single pair of
transmit/receive serdes lines.

Each interface also has its own clause 37 autoneg block.

So, for an interface to operate in SGMII mode, it would have to be
muxed to a different path before being presented to the USXGMII-M
block since each interface does not have its own external data lane
- thus that's out of scope of USXGMII-M as documented by Cisco.

Hope this helps.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
