Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F1A77F2C11
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 12:52:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233827AbjKULwu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 06:52:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbjKULwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 06:52:47 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF7B7100;
        Tue, 21 Nov 2023 03:52:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=kwc1QROQrLJK6qUZ4szek7aN5NLGZbYDFO7vd+LJx7k=; b=p1GSOW5Q5ngq2gB9UFFHXhhNx2
        IEEp17E+pQPpltJwXRdYJ4xt88epaNYQHSVeJlwBx3pY1GvtqF3yPohDeG2ViPVgZQYD63lrd5nlb
        ftQxctWDXh5TNkaajh1PiVXXADlE/+hNNH3JqQfOtoG+gU1tOI4AOZmC1pgajtlRMcbYuTIHoGvOz
        6X9j4Hci8nDHUrV90T+eCYyxrQS8fdiCt62QlH8h9QROrz7VE1QEV91c0mePwvziTs5TkmP5RxIkP
        iVLFidZjxjJQ91CA91OOAo59wa8mcZ0A3UpUmNDpH7TbKNB6iNI10CQwqOnn9gl6L9pzHvGurlc0a
        kAnwc31g==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:41702)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1r5PIq-0006ve-2k;
        Tue, 21 Nov 2023 11:52:28 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1r5PIp-00049X-Hc; Tue, 21 Nov 2023 11:52:27 +0000
Date:   Tue, 21 Nov 2023 11:52:27 +0000
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Jie Luo <quic_luoj@quicinc.com>
Cc:     Andrew Lunn <andrew@lunn.ch>, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, hkallweit1@gmail.com, corbet@lwn.net,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v5 3/6] net: phy: at803x: add QCA8084 ethernet phy support
Message-ID: <ZVyZ+8Q2eNfAKjO/@shell.armlinux.org.uk>
References: <20231118062754.2453-1-quic_luoj@quicinc.com>
 <20231118062754.2453-4-quic_luoj@quicinc.com>
 <1eb60a08-f095-421a-bec6-96f39db31c09@lunn.ch>
 <ZVkRkhMHWcAR37fW@shell.armlinux.org.uk>
 <eee39816-b0b8-475c-aa4a-8500ba488a29@lunn.ch>
 <fef2ab86-ccd7-4693-8a7e-2dac2c80fd53@quicinc.com>
 <1d4d7761-6b42-48ec-af40-747cb4b84ca5@lunn.ch>
 <316fb626-4dc3-4540-9cc4-e45840e36f77@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <316fb626-4dc3-4540-9cc4-e45840e36f77@quicinc.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2023 at 07:10:08PM +0800, Jie Luo wrote:
> when pcs is configured to SGMII mode, the fourth PHY can reach to
> maximum speed 2.5G(2500BaseT) that is reached by increasing the clock
> rate to 312.5MHZ from 125MHZ of 1G speed, but there is no corresponding
> interface mode can be used to reflect this 2.5G speed mode(sgmii+)

So this comes up again. 2.5G SGMII? What is that?

Let's start off with the basics. SGMII is Cisco's modification of
1000base-X. The two are broadly compatible in that they can communicate
with each other provided that the inband control word is disregarded.

2500base-X is generally implemented as 1000base-X over-clocked by 2.5x.
Some manufacturers state that the inband control word is not supported.
Others say it can be used. This disparity comes from the lack of early
IEEE standardisation of this protocol.

Cisco SGMII as defined is a 10M/100M/1G protocol operating at 125MHz
with a fixed underlying baud rate of 1250Mbaud. Slower speeds are
achieved via symbol replication by 10x or 100x. The inband control
word is modified in order to convey this speed information, as well
as duplex and sometimes also other vendor extensions.

Switching SGMII to be clocked 2.5x faster means that a partner that
expects SGMII at normal speed sees garbage - it can't recognise the
waveform. Therefore, it is not possible for inband to convey any
information. Many vendors explicitly state that symbol replication
is not supported when "SGMII" is clocked at 2.5x.

All variants of whatever the vendor calls the 2.5G mode tend to use
the SGMII term because... it's Serial Gigabit... and SGMII even gets
used by vendors to describe the interface used for 1000base-X.
Vendors use terms like "HS-SGMII" and other stuff to describe their
2.5x mode. Some use "2500base-X". Yours seems to use "SGMII+".

SGMII without inband signalling is basically the same as 1000base-X.
Therefore, SGMII clocked at 2.5x the speed is basically the same as
2500base-X without inband signalling.

So, the whole area is totally confused, and one should not get too
hung up on the terminology that vendors are using, but go back to
precisely what's going on at the hardware level.

We have raised this point almost every time someone talks about an
up-clocked "SGMII".


> Actually we should add a new interface mode such as sgmii+
> to reflect this 2.5G speed of sgmii

Only if there really is something different about it. For example,
if it were Cisco SGMII modified to operate always at 312.5MHz with
inband signalling updated to signal the four speeds. That would
definitely be a different protocol.

However, it's not that. What it actually is is Cisco SGMII when
operating at 10M/100M/1G speeds, and 2500base-X without inband
signalling when operating at 2.5G speed.

We have PHYs that support this (and more) which we support. PHYs
that switch between 10GBASE-R, 5GBASE-R, 2500BASE-X and Cisco SGMII
depending on the speed that was negotiated on the media. There is
no definition of a single interface mode that covers all those,
because it isn't a single interface mode. It's four separate modes
that the PHY switches between - and this is no different from what
is happening with your PHY.

Ultimately, you will need a way to use inband signalling with Cisco
SGMII for 10M/100M/1G speeds, and then switch to 2500base-X when
operating at 2.5G speeds, and that is done via the PHY driver
updating phydev->interface.

What we do need is some way for the PHY to also tell the PCS/MAC
whether inband should be used. This is something I keep bringing up
and now that we have PCS drivers revised to use the value from
phylink_pcs_neg_mode() _and_ a consistent implementation amongst them
we can now think about signalling to PCS drivers whether inband mode
needs to be turned off when switching between modes.

There have been patches in the past that allow inband mode to be
queried from phylib, and this is another important component in
properly dealing with PHYs that need to use inband signalling with
Cisco SGMII, but do not support inband signalling when operating at
2.5G speeds. The problem when operating at 2.5G speed is that the
base-X protocols are normally for use over fibre, which is the media,
and therefore the ethtool Autoneg bit should define whether inband
gets used or not. However, in the case of a PHY using 2500base-X,
the Autoneg bit continues to define whether autonegotiation should
be used on the media, and in this case it's the media side of the
PHY rather than the 2500base-X link.

So, when using a 2500base-X link to a PHY, we need to disregard the
Autoneg bit, but that then raises the question about how we should
configure it - and one solution to that would be to entire of phylib
what the PHY wants to do. Another is to somehow ask the PCS driver
whether it supports inband signalling at 2500base-X, and resolve
those capabilities.

That is my view where we need to get to in order to properly resolve
the ongoing issues about 2500base-X and PHYs that make use of that.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
