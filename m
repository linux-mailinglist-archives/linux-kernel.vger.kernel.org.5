Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08BF17FA418
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 16:09:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233809AbjK0PJD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 10:09:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233614AbjK0PJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 10:09:01 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86345AA;
        Mon, 27 Nov 2023 07:09:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=S6gRHL7aWODpPuBJIryHbptG3WPOk3fgIh9keMDXZtI=; b=jD2Kx1Gp3h8I3UmaPgzNR3FeCq
        PGU0PNt2nM9tBN6xrKdSNIwCQMtzvwRjIklErBISu69Y5Jw5Djbm9To5QEcNUxVt+thMjOs66RHCm
        4pk0+UbjMQ6K/yYV7t+Gh/P2oLIUx7WQv6LKwfAnLlIh7jKke9QEicYfuNt4xWdrBdKd5m9unwb+G
        7WuDuU7GJ02MiBdGwr2Zjp+bZpWsh3Q/51i5vuPIHkzeN8hRjzwjaOofO6UeoNxtP77R+ZrJndf3X
        fku8pQV5bc4GbS00BlhX81uu+KQ1jVC4WHnZz+Jutfy9sn0/dqxhdn3MmqmIKHedM/L/ccIfl1DRZ
        YxSsuZ8g==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:58562)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1r7dE3-00061S-2V;
        Mon, 27 Nov 2023 15:08:43 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1r7dE1-0001zq-BK; Mon, 27 Nov 2023 15:08:41 +0000
Date:   Mon, 27 Nov 2023 15:08:41 +0000
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Daniel Golle <daniel@makrotopia.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Felix Fietkau <nbd@nbd.name>, John Crispin <john@phrozen.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Mark Lee <Mark-MC.Lee@mediatek.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Alexander Couzens <lynxis@fe80.eu>,
        Philipp Zabel <p.zabel@pengutronix.de>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-phy@lists.infradead.org
Subject: Re: [RFC PATCH 6/8] net: pcs: add driver for MediaTek USXGMII PCS
Message-ID: <ZWSw+cecLhjbpX4o@shell.armlinux.org.uk>
References: <cover.1699565880.git.daniel@makrotopia.org>
 <b9f787f3e4aa36e148d7595495af60db53f74417.1699565880.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b9f787f3e4aa36e148d7595495af60db53f74417.1699565880.git.daniel@makrotopia.org>
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

On Thu, Nov 09, 2023 at 09:51:57PM +0000, Daniel Golle wrote:
> Add driver for USXGMII PCS found in the MediaTek MT7988 SoC and supporting
> USXGMII, 10GBase-R and 5GBase-R interface modes. In order to support
> Cisco SGMII, 1000Base-X and 2500Base-X via the also present LynxI PCS
> create a wrapped PCS taking care of the components shared between the
> new USXGMII PCS and the legacy LynxI PCS.

What is the actual hardware setup here?

From what I can tell, it's something like this:

         .---- LynxI PCS ----.
 MAC ---+                     +--- PEXP --- external
         `--- USXGMII PCS ---'

Where PEXP is the serdes, handled by the drivers/phy layer in the
kernel. This is not an unusual setup, but we don't have the serdes PHY
controlled by the PCS driver.

You seem to be combining the whole lot into one driver, which seems
rather odd.

I would suggest that the serdes PHY is handled in the MAC driver, using
the mac_prepare(), mac_config() and mac_finish() methods, as well as
other parts of the driver:

- when the netdev is opened, call phy_power_on(pextp)
- when the netdev is closed, call phy_power_off(pextp)
- in mac_prepare(), if the interface has changed, call phy_reset(pextp)
- in mac_finish(), if the interface has changed, update your recorded
  interface mode to detect future changes in either mac_prepare() or
  mac_finish(), and call phy_set_mode_ext(pextp, PHY_MODE_ETHERNET,
  interface).

That will move most of what seems to be duplicated between the two PCS
instances out of the PCS driver and to MAC level, and then the PCS parts
become more about just driving the PCS hardware and nothing beyond that.
More specifically, the wrapping's only function then is to deal with the
sgmii reset. What exactly is that reset signal controlling? The reset to
the LynxI PCS or something else?

If you don't do that (and I prefer that you _do_ the above), then the
following comments apply to the code here:

1. the use of phy_power_on() without any calls to phy_power_off().
   These are counted calls, and after the first call to phy_power_on(),
   the only effect will be to increase the enable-counts of any
   associated regulator and the power count. So, basically you're
   missing calls to phy_power_off(). I suggest a call to phy_power_off()
   in the pcs_disable() function.

2. calling phy_power_on() in pcs_config() is entirely unnecessary.
   pcs_config() will not be called unless pcs_enable() has _already_
   been called, so the call to phy_power_on() in the pcs_enable()
   function is entirely sufficient.

With these two fixed, it means that the pextp PHY will be powered up
when one of the pcs_enable() functions is called, and powered down
when one of the pcs_disable() functions is called.

3. the complicated reset sequence, which is basically:
   - phy_reset(pextp)
   - reset_control_assert(sgmii or xfi reset)
   - *sleep* 100-500us (yes, sleep)
   - reset_control_deassert(sgmii or xfi reset)
   - *delay* 10ms (not sleep, but spin wait)
   If we are in a schedulable context (which the usleep_range() suggests
   we are) then why bother sleeping for the short delay, and
   spin-waiting for the longer delay? A bit of consistency seems to be
   needed here.

4. really needs to explain why it's necessary to repeatedly call the
   pcs_config() function at each get_state() if the link is down.

   Note that with the code the way it is, phy_power_on() will be
   repeatedly called, and at some point the "power_count" will overflow
   which would probably be bad. The counting in the regulator core will
   probably also overflow as well. So this is bad.

   Apart from the overflow issue, the only thing I can see that this
   achieves is to call the core of the pcs_config function. In the case
   of the lynxi, calling its pcs_config() repeatedly with the same
   parameters. Looking at pcs-mtk-lynxi.c, I can't see what this would
   achieve.

With the above issues dealt with, from the point of view of the lynxi /
sgmii code, the only things I can see that the wrapping achieves are:

a) when pcs_enable() is called, call phy_power_on(pextp)
b) when pcs_disable() is called, call phy_power_offpextp)
c) when pcs_config() is called, if the interface has changed:
   i)  call phy_reset() and assert/deassert the "sgmii" reset before
       calling the lynxi PCS
   ii) call phy_set_mode_ext(pextp) for the new interface mode after
       calling the lynxi PCS

I haven't picked through the usxgmii code completely, so I'm not
specifically commenting on it, although some of the above applies
there as well.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
