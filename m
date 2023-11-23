Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A0577F5E9E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 13:01:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345202AbjKWMBO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 07:01:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345193AbjKWMBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 07:01:10 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 090D698;
        Thu, 23 Nov 2023 04:01:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=tjOG3IUarrrhmsM7mzYA0wffrVbKcTF1Zf9Q1kyefhs=; b=oGdIzS/Z0rkfKOlbhFssglTAY0
        4ou1QIfNoAf4/5fOpEgd5DUsTMsIKMU4CXckJxO4ugwlRPwE7Dg36GL7wtt08TVHvG0T8xkwFqNwb
        tYiujWn9KvPlntJUfbdchZ1XcA0zCCo2BHeWqfrn6TsD5qXjvwk5+Vt9wd5oRm3ZZaAGyvbcZLw+S
        KAHuiUlrhy8qTQMlnsfe022i9Ry80s/svb5Qydx/s1AIhYafT25deoQQA0ELp33noffjgkvRum65i
        CW5/37GVoVRNkX7DqOaqztvIuMKNiPfQIexipHxc4ZSBhLYXby7JKq3vjgazdiTVkDv0aKfs5IGhz
        cFmBzjHQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:56140)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1r68OF-0001WC-1c;
        Thu, 23 Nov 2023 12:01:03 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1r68OF-0006By-7q; Thu, 23 Nov 2023 12:01:03 +0000
Date:   Thu, 23 Nov 2023 12:01:03 +0000
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Jie Luo <quic_luoj@quicinc.com>
Cc:     Andrew Lunn <andrew@lunn.ch>, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, hkallweit1@gmail.com, corbet@lwn.net,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v5 3/6] net: phy: at803x: add QCA8084 ethernet phy support
Message-ID: <ZV8+/4eNzLpLzSDG@shell.armlinux.org.uk>
References: <20231118062754.2453-1-quic_luoj@quicinc.com>
 <20231118062754.2453-4-quic_luoj@quicinc.com>
 <1eb60a08-f095-421a-bec6-96f39db31c09@lunn.ch>
 <ZVkRkhMHWcAR37fW@shell.armlinux.org.uk>
 <eee39816-b0b8-475c-aa4a-8500ba488a29@lunn.ch>
 <fef2ab86-ccd7-4693-8a7e-2dac2c80fd53@quicinc.com>
 <1d4d7761-6b42-48ec-af40-747cb4b84ca5@lunn.ch>
 <316fb626-4dc3-4540-9cc4-e45840e36f77@quicinc.com>
 <ZVyZ+8Q2eNfAKjO/@shell.armlinux.org.uk>
 <d2ac542c-aae3-49ae-ae2b-9defc4ca98eb@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d2ac542c-aae3-49ae-ae2b-9defc4ca98eb@quicinc.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 23, 2023 at 06:57:59PM +0800, Jie Luo wrote:
> On 11/21/2023 7:52 PM, Russell King (Oracle) wrote:
> > Ultimately, you will need a way to use inband signalling with Cisco
> > SGMII for 10M/100M/1G speeds, and then switch to 2500base-X when
> > operating at 2.5G speeds, and that is done via the PHY driver
> > updating phydev->interface.
> > 
> > What we do need is some way for the PHY to also tell the PCS/MAC
> > whether inband should be used. This is something I keep bringing up
> > and now that we have PCS drivers revised to use the value from
> > phylink_pcs_neg_mode() _and_ a consistent implementation amongst them
> > we can now think about signalling to PCS drivers whether inband mode
> > needs to be turned off when switching between modes.
> 
> Yes, we can switch the interface mode according to the current link
> speed in the pcs driver.
> but the issue is that the phy-mode i specified for the PHYLINK,
> if phy-mode is sgmii, the support capability is limited to maximum
> capability 1G during the PHYLINK setup and i can't configure it to 2.5G
> dynamically, if the phy-mode is 2500base-x, then PHY capability will
> be modified to only support 2.5G, other speeds can't be linked up.

So you need my patches that add "possible_interfaces" to phylib so you
can tell phylink that you will be switching between SGMII and
2500base-X. Please see the RFC posting of those patches I sent
yesterday and try them out - you will need to modify your phylib
driver to fill in phydev->possible_interfaces.

> > There have been patches in the past that allow inband mode to be
> > queried from phylib, and this is another important component in
> > properly dealing with PHYs that need to use inband signalling with
> > Cisco SGMII, but do not support inband signalling when operating at
> > 2.5G speeds. The problem when operating at 2.5G speed is that the
> > base-X protocols are normally for use over fibre, which is the media,
> > and therefore the ethtool Autoneg bit should define whether inband
> > gets used or not. However, in the case of a PHY using 2500base-X,
> > the Autoneg bit continues to define whether autonegotiation should
> > be used on the media, and in this case it's the media side of the
> > PHY rather than the 2500base-X link.
> > 
> > So, when using a 2500base-X link to a PHY, we need to disregard the
> > Autoneg bit, but that then raises the question about how we should
> > configure it - and one solution to that would be to entire of phylib
> > what the PHY wants to do. Another is to somehow ask the PCS driver
> > whether it supports inband signalling at 2500base-X, and resolve
> > those capabilities.
> 
> For the qca808x PHY, when it is linked in 2.5G, the autoneg is also
> disabled in PCS hardware, so the sgmii+ of qca808x PHY is almost
> same as 2500base-X.

Not "almost". It _is_ the same. This is the point I've been trying
to get across to you. Without inband signalling, 1000base-X and SGMII
(when operating at 1G) are _identical_ and entirely compatible.

You've said that your 2.5G "SGMII" mode has inband signalling disabled,
and thus it without inband signalling, 2500base-X and this 2.5G mode
are again identical and entirely compatible. There's no "almost" about
it.


-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
