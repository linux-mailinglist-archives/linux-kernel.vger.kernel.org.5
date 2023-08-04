Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99FD7770BF0
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 00:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbjHDW1m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 18:27:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjHDW1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 18:27:40 -0400
Received: from pandora.armlinux.org.uk (unknown [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC6FE10F0;
        Fri,  4 Aug 2023 15:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=oe3R1YKPMSS61Kql1VVF1wpgWu78Kb9TP4tIQw5QCgw=; b=SomGhhLqgNBWYw3yU37FFm8NyK
        s731vyDc2/mwtHBDHIGN42h/VWqKhR7ykKos0RTCgVNWEeRLTW6cjMRygXWyWOw0tRkaJNoU8ihMt
        joVIvLvs/SLsrlOSbDgQwuDcUf2tUgAXvZ06MdHxlSEi4slkyS8RXcw3xQXQpGACzxue2JTNuaUKE
        8UjyA+Ru1k97X35qsFFUdXPQi408YX9k/nEMxwhC5z9COVi+ma3TUCk9he6zHNWSdYUXob5U+7FAk
        +gTTRgTTtyhAfUAnGBToBl5TlJnE/mL9gLGS99weNkN5FiRMeCGbXfp9pnNeM6Behz7BUwJueWHfK
        JWUbifAw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:47482)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1qS3Gf-0000pF-0M;
        Fri, 04 Aug 2023 23:27:33 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1qS3Ge-0004MT-Q1; Fri, 04 Aug 2023 23:27:32 +0100
Date:   Fri, 4 Aug 2023 23:27:32 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Nick Bowler <nbowler@draconx.ca>
Cc:     Rob Herring <robh@kernel.org>,
        Saravana Kannan <saravanak@google.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        netdev@vger.kernel.org, regressions@lists.linux.dev
Subject: Re: PROBLEM: Broken or delayed ethernet on Xilinx ZCU104 since 5.18
 (regression)
Message-ID: <ZM17VKzDBdm4uMNY@shell.armlinux.org.uk>
References: <CADyTPEzqf8oQAPSFRWJLxAhd-WE4fX2zdoe9Vu6V9hZMn1Yc8g@mail.gmail.com>
 <CAL_JsqLrErF__GGHfanRFCpfbOh6fvz4-aJv32h8OfDjUeZPSg@mail.gmail.com>
 <CADyTPEwgG0=R_b5DNBP0J0auDXu2BNTOwkSUFg-s7pLJUPC+Tg@mail.gmail.com>
 <CADyTPExgjcaUeKiR108geQhr0KwFC0A8qa_n_ST2RxhbSczomQ@mail.gmail.com>
 <CAL_Jsq+N2W0hVN7fUC1rxGL-Hw9B8eQvLgSwyQ3n41kqwDbxyg@mail.gmail.com>
 <CADyTPEyT4NJPrChtvtY=_GePZNeSDRAr9j3KRAk1hkjD=5+i8A@mail.gmail.com>
 <CAL_JsqKGAFtwB+TWc1yKAe_0M4BziEpFnApuWuR3h+Go_=djFg@mail.gmail.com>
 <CADyTPEwY4ydUKGtGNayf+iQSqRVBQncLiv0TpO9QivBVrmOc4g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADyTPEwY4ydUKGtGNayf+iQSqRVBQncLiv0TpO9QivBVrmOc4g@mail.gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 04, 2023 at 05:31:21PM -0400, Nick Bowler wrote:
> On 2023-08-04, Rob Herring <robh@kernel.org> wrote:
> > On Fri, Aug 4, 2023 at 11:52 AM Nick Bowler <nbowler@draconx.ca> wrote:
> >> I don't know about the deferred probe timeout, but I bisected the 6.5-rc4
> >> breakage to this commit:
> >>
> >>   commit c720a1f5e6ee8cb39c28435efc0819cec84d6ee2
> >>   Author: Michal Simek <michal.simek@amd.com>
> >>   Date:   Mon May 22 16:59:48 2023 +0200
> >>
> >>       arm64: zynqmp: Describe TI phy as ethernet-phy-id
> >
> > I don't see anything obviously problematic with that commit. (The
> > #phy-cells property added is wrong as ethernet phys don't use the phy
> > binding, but that should just be ignored). I'd check if the phy probed
> > and has a DT node associated with it.
> 
> I think the answer is "no, the phy was not probed".  Without reverting
> that commit, there is absolutely nothing in /sys/bus/mdio_bus/devices.
> There is no phy device link under /sys/bus/mdio_bus/drivers/"TI DP83867",
> and there is no mdio_bus under /sys/bus/platform/devices/ff0e0000.ethernet.
> 
> When I revert that commit, I can locate the phy device under all these
> locations.
> 
> > fw_devlink tracks parent-child dependencies and maybe changing to
> > parent-grandchild affected that. We don't yet track 'phy-handle'
> > dependencies, but we'd have a circular one here if we did (though that
> > should be handled). Does "fw_devlink=off" help?
> 
> Booting with fw_devlink=off results in no obvious change in behaviour.

I think we need to rewind a tad.

My understanding is that this uses the Cadence macb driver.

In your original message, you said that the ethernet driver wasn't
being bound to the driver.

Since the ethernet driver is responsible for spotting the "mdio"
sub-node and creating the MDIO bus, if the driver isn't being
successfully bound, then the MDIO bus and the PHYs on the bus won't be
created, so you won't find them in /sys/bus/mdio_bus/devices.

Moreover, the Cadence macb driver, and this doesn't care about the
presence of the PHY at probe time, only when the network interface is
brought up. See macb_phylink_connect() which is called from
macb_open().

So, I think that the deferred probing has nothing to do with PHYs, and
that's just a wild goose chase.

I think instead we need to be concentrating on what's going on with
the ethernet driver, and why the ethernet driver is deferring its
probe. Is macb_probe() getting called at all? How far through
macb_probe() do we get before we defer?

I think those are the key questions that need answering.

Maybe, if you can get access to the machine while the driver is
deferring, /sys/kernel/debug/devices_deferred might give some
useful information, but that's just a hope.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
