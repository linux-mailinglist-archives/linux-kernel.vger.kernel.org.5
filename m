Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D0AA7F7094
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 10:54:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345336AbjKXJxx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 04:53:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345283AbjKXJxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 04:53:51 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8D2492;
        Fri, 24 Nov 2023 01:53:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=hkZni39lbThoT9dZBCT30ULv0iuj2C5j0MgE1MKeF0E=; b=u89kb9KNOXkwb+aJrX/Vnv9C1R
        DD98mqnrqIV4CabFKki8ZszmNGdHErw74EtPGWOV0q5hSFvJJhywAUzq2cCKwaHBuGDrbqu3ug/Sh
        /PmwolaGt17qexnLdVsIBx2jetgQa7yN8ejqUcg2vc5qAvVV72wJYEi5PcaxMHtP/NS60rZSawMMS
        pQLx78j3VHSbpKOIqtJT4BGhCnN67R6b2bzj9Dlv00byPC1DlK6EyLjT+lep8P8CubwMegnX6Qafr
        jLiYrPwDUyvgxi+c/XZWErC4f7q+6KmFKJHV6cpJpIYNH8a2W5mNk6R8emkcuHMASu4Dc4/JtFSV1
        aVSl7GpQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:35134)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1r6SsS-0002de-1D;
        Fri, 24 Nov 2023 09:53:36 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1r6SsR-00078v-Ge; Fri, 24 Nov 2023 09:53:35 +0000
Date:   Fri, 24 Nov 2023 09:53:35 +0000
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Jie Luo <quic_luoj@quicinc.com>
Cc:     Andrew Lunn <andrew@lunn.ch>, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, hkallweit1@gmail.com, corbet@lwn.net,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v5 3/6] net: phy: at803x: add QCA8084 ethernet phy support
Message-ID: <ZWByn7HpAmPTP3GJ@shell.armlinux.org.uk>
References: <1eb60a08-f095-421a-bec6-96f39db31c09@lunn.ch>
 <ZVkRkhMHWcAR37fW@shell.armlinux.org.uk>
 <eee39816-b0b8-475c-aa4a-8500ba488a29@lunn.ch>
 <fef2ab86-ccd7-4693-8a7e-2dac2c80fd53@quicinc.com>
 <1d4d7761-6b42-48ec-af40-747cb4b84ca5@lunn.ch>
 <316fb626-4dc3-4540-9cc4-e45840e36f77@quicinc.com>
 <ZVyZ+8Q2eNfAKjO/@shell.armlinux.org.uk>
 <d2ac542c-aae3-49ae-ae2b-9defc4ca98eb@quicinc.com>
 <ZV8+/4eNzLpLzSDG@shell.armlinux.org.uk>
 <1bd2f3a9-3dd1-4c95-b4e5-c9bf2274f271@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1bd2f3a9-3dd1-4c95-b4e5-c9bf2274f271@quicinc.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 24, 2023 at 05:47:04PM +0800, Jie Luo wrote:
> 
> 
> On 11/23/2023 8:01 PM, Russell King (Oracle) wrote:
> > On Thu, Nov 23, 2023 at 06:57:59PM +0800, Jie Luo wrote:
> > > On 11/21/2023 7:52 PM, Russell King (Oracle) wrote:
> > > > Ultimately, you will need a way to use inband signalling with Cisco
> > > > SGMII for 10M/100M/1G speeds, and then switch to 2500base-X when
> > > > operating at 2.5G speeds, and that is done via the PHY driver
> > > > updating phydev->interface.
> > > > 
> > > > What we do need is some way for the PHY to also tell the PCS/MAC
> > > > whether inband should be used. This is something I keep bringing up
> > > > and now that we have PCS drivers revised to use the value from
> > > > phylink_pcs_neg_mode() _and_ a consistent implementation amongst them
> > > > we can now think about signalling to PCS drivers whether inband mode
> > > > needs to be turned off when switching between modes.
> > > 
> > > Yes, we can switch the interface mode according to the current link
> > > speed in the pcs driver.
> > > but the issue is that the phy-mode i specified for the PHYLINK,
> > > if phy-mode is sgmii, the support capability is limited to maximum
> > > capability 1G during the PHYLINK setup and i can't configure it to 2.5G
> > > dynamically, if the phy-mode is 2500base-x, then PHY capability will
> > > be modified to only support 2.5G, other speeds can't be linked up.
> > 
> > So you need my patches that add "possible_interfaces" to phylib so you
> > can tell phylink that you will be switching between SGMII and
> > 2500base-X. Please see the RFC posting of those patches I sent
> > yesterday and try them out - you will need to modify your phylib
> > driver to fill in phydev->possible_interfaces.
> 
> Your patches work on my board, thanks Russell.

Please can you reply to the covering email for that series giving your
tested-by? Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
