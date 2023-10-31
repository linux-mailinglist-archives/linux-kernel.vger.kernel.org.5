Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D958F7DC747
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 08:28:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343637AbjJaH25 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 03:28:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343693AbjJaH2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 03:28:55 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54C34DB
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 00:28:53 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1qxjBA-0007rN-RG; Tue, 31 Oct 2023 08:28:48 +0100
Received: from [2a0a:edc0:2:b01:1d::c0] (helo=ptx.whiteo.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ore@pengutronix.de>)
        id 1qxjB9-005WBK-7y; Tue, 31 Oct 2023 08:28:47 +0100
Received: from ore by ptx.whiteo.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1qxjB9-00HDPi-56; Tue, 31 Oct 2023 08:28:47 +0100
Date:   Tue, 31 Oct 2023 08:28:47 +0100
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Vladimir Oltean <olteanv@gmail.com>,
        Ante Knezic <ante.knezic@helmholz.de>, conor+dt@kernel.org,
        UNGLinuxDriver@microchip.com, davem@davemloft.net,
        devicetree@vger.kernel.org, edumazet@google.com,
        f.fainelli@gmail.com, krzysztof.kozlowski+dt@linaro.org,
        kuba@kernel.org, linux-kernel@vger.kernel.org, marex@denx.de,
        netdev@vger.kernel.org, pabeni@redhat.com, robh+dt@kernel.org,
        woojung.huh@microchip.com
Subject: Re: [PATCH net-next v4 2/2] net:dsa:microchip: add property to select
Message-ID: <20231031072847.GP3803936@pengutronix.de>
References: <20231024142426.GE3803936@pengutronix.de>
 <20231027063743.28747-1-ante.knezic@helmholz.de>
 <20231030174225.hqhc3afbayi7dmos@skbuf>
 <aad5ac41-3c05-421d-a483-0546b579585c@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aad5ac41-3c05-421d-a483-0546b579585c@lunn.ch>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2023 at 02:00:05AM +0100, Andrew Lunn wrote:
> > So, my opinion is that although what Oleksij would like to see is
> > admirable, I don't think that the REF_CLK direction is a matter of RMII
> > MAC vs PHY role, and thus, we wouldn't need to change "rmii" to "rev-rmii"
> > and cause breakage everywhere. It's just that - a matter of REF_CLK
> > direction. It's true, though, that this is a generic problem and that
> > the generic bindings for RMII that we currently have are under-specified.
> > We could try to devise an extended RMII binding which makes it clear for
> > both the MAC and the PHY who is responsible to drive this signal. You
> > are not attempting that, you are just coming up with yet another
> > vendor-specific MAC property which solves a generic problem. I can't say
> > I am completely opposed to that, either, which is why I haven't really
> > spoken out against it. The PHY maintainers would also have to weigh in,
> > and not all of them are CCed here.
> 
> I would recommend looking around other PHYs and find a property which
> does what you want, and copy it.
> 
> We do have all sorts of properties. There are some to enable the
> REF_CLK out of the PHY. Some to disable the REF_CLK out, some to
> disable it when the link is down, some to indicate what frequency it
> should tick at, etc.
> 
> If you want to go the extra mile, maybe you can make a summary of all
> these properties, and maybe we can produce a guide line for what we
> want the properties to be called going forward.
> 
> > I am afraid that creating a CCF style binding for REF_CLK will be an
> > enormous hammer for a very small nail and will see very limited adoption
> > to other drivers, but I might as well be wrong about it. Compatibility
> > between RMII MACs and PHYs which may or may not be CCF-ready might also
> > be a concern.
> 
> I also don't think using the CCF makes too much sense, except for
> where the SoC provides the lock, and already has a CCF covering it.
> 
> I would also be hesitant to add more dependencies between the MAC and
> the PHY. The DT often has circular dependencies and we have had issues
> with probing being deferred because the core does not always
> understand these circular dependencies.

Heh, this are unsolved problems making me pain in different projects.

Here are some real life examples, which are unsolved in one or another project
and till now didn't went mainline:

1. In scenarios where PHYs require an RMII clock from the MAC, initialization
becomes complex. This is often resolved through bootloader and kernel
modifications. Right now it kind of works and postponed until it will make
real pain :)

2. Complexity increases in designs with multiple PHYs used by different MACs
but connected to one MDIO bus. Same is here, there was already some
regressions but the pain is still not enough for making things right.

3. For some MACs like STMMAC, configuration is challenging without an external
clock from the PHY. For example, VLAN configuration isn't possible with EEE
enabled unless deep power saving states are disabled during register access.
If I remember it correctly, there was floating discussions and patches trying
to address similar issues.

Transferring these issues to KSZ8863, we might face difficulties configuring
STMMAC if KSZ8863, acting as the clock provider, isn't enabled early before MAC
driver probing, a tricky scenario in the DSA framework.

Working on deep sleep states for the KSZ switch driver, I find that dynamic
clock control, potentially offered by CCF, could be quite handy.

Please do not see this answer as a request to Ante for complex rework. It's
more of a red flag notifying that the clocking issue is still unsolved, and
someone (may be me), sooner or later, will have enough motivation to jump into
this wasp nest :)

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
