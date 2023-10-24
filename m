Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E9607D5105
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 15:08:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234580AbjJXNIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 09:08:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234457AbjJXNIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 09:08:44 -0400
Received: from mail.helmholz.de (mail.helmholz.de [217.6.86.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1B98133
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 06:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=helmholz.de
        ; s=dkim1; h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date
        :Subject:CC:To:From:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=cBXs12jA7KWFzgQ+tTcAiIjIPBfDlt2cfHoxnkBGFbI=; b=ClMZyH7BRo4K2ENDs428Dr5d++
        zobCebV05RD3zYD010uIQ8S/4mOeMXsRQclv41/AkHt4jlgzejwjie1uISlbInqtfaGifFdjiEUT9
        P+redGQ16yxAjbvI/PWWJfsi440bixH3jAJkOWiDqceRVRfg9xhLr87buuS3L6oRQk5ZNrWia5Tjq
        XO56vG9ZbcjmYe/4ltGOPzWVeIJrDDRTx9/XEjJbav0gqtBo4+1QA9kVGV4tNzIxL1IO/3lJL0hIB
        46Ip2OlmfAyccllHrDF77/wb6CpVuzh5uXffgHQGBoLWKrRkc6SC22nxI1+U/CAzPAYNpHXJhBGON
        0ECoucjw==;
Received: from [192.168.1.4] (port=15909 helo=SH-EX2013.helmholz.local)
        by mail.helmholz.de with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384
        (Exim 4.96)
        (envelope-from <Ante.Knezic@helmholz.de>)
        id 1qvH9A-0002Tm-0H;
        Tue, 24 Oct 2023 15:08:36 +0200
Received: from linuxdev.helmholz.local (192.168.6.7) by
 SH-EX2013.helmholz.local (192.168.1.4) with Microsoft SMTP Server (TLS) id
 15.0.1497.48; Tue, 24 Oct 2023 15:08:35 +0200
From:   Ante Knezic <ante.knezic@helmholz.de>
To:     <o.rempel@pengutronix.de>
CC:     <UNGLinuxDriver@microchip.com>, <andrew@lunn.ch>,
        <ante.knezic@helmholz.de>, <conor+dt@kernel.org>,
        <davem@davemloft.net>, <devicetree@vger.kernel.org>,
        <edumazet@google.com>, <f.fainelli@gmail.com>,
        <krzysztof.kozlowski+dt@linaro.org>, <kuba@kernel.org>,
        <linux-kernel@vger.kernel.org>, <marex@denx.de>,
        <netdev@vger.kernel.org>, <olteanv@gmail.com>, <pabeni@redhat.com>,
        <robh+dt@kernel.org>, <woojung.huh@microchip.com>
Subject: Re: [PATCH net-next v4 2/2] net:dsa:microchip: add property to select
Date:   Tue, 24 Oct 2023 15:08:32 +0200
Message-ID: <20231024130832.13596-1-ante.knezic@helmholz.de>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20231024100915.GC3803936@pengutronix.de>
References: <20231024100915.GC3803936@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.6.7]
X-ClientProxiedBy: SH-EX2013.helmholz.local (192.168.1.4) To
 SH-EX2013.helmholz.local (192.168.1.4)
X-EXCLAIMER-MD-CONFIG: 2ae5875c-d7e5-4d7e-baa3-654d37918933
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Oct 2023 12:09:15 +0200, Oleksij Rampel wrote:

> > As you suggested, it looks like KSZ9897 clocking mode depends on RMII interface
> > mode (with strapping pins), but I don't see this for KSZ8863. The PHY/MAC mode
> > is selected with Register 0x35 bit 7 and the clocking mode is selected via
> > strapping pins EN_REFCLKO and SMTXD32 (and additional register 0xC6 bit 3).
> > I guess its possible for the KSZ8863 to be the clock provider/consumer
> > regardless of PHY/MAC mode?
>
>Register 0x35 bit 7 is for MII mode
>Register 0xC6 bit 3 is for RMII mode
>
>MII != RMII

Yes, right you are. Looks like I got lost in the datasheets...

> > Table 3-5: RMII CLOCK SETTING of KSZ8863 datasheet describes the available
> > clocking modes. If we try to create a relation between KSZ9897 and KSZ8863:
> >
> > KSZ9897 "Normal Mode" is equivalent to KSZ8863 mode described in first column
> > of table 3-5:
> > - EN_REFCLKO = 0, 0xC6(3) = 0 -> external 50Mhz OSC input to REFCLKI and X1
> >   pin directly
> >
> > KSZ9897 "Clock Mode" is equivalent to KSZ8863 mode described in fourth/fifth
> > column (difference is only clock frequency) of table 3-5:
> > - EN_REFCLKO = 1, 0xC6(3) = 1 -> 50/25Mhz on X1 pin, 50/25Mhz RMII clock goes
> >   to REFCLKI internally. REFCLKI can be pulled down by resistor.
> >
> > That leaves us with additional columns 2 and 3 of table 3-5 for KSZ8863, that
> > are similar to KSZ9897 Clock mode, but REFCLKI needs to be fed externally from
> > REFCLKO.
> 
> All of 5 variants described in "Table 3-5: RMII CLOCK SETTING of KSZ8863"
> can be boiled down to two main configurations:
> 
> REFCLKI is used as clock source for internal MAC == Normal Mode or
> RevRMII mode.
> REFCLKI is not used as clock source for internal MAC == Clock Mode or
> RMII mode.
> 
> Variants 1, 2, 3 describe only how can we feed REFCLKI from outside of
> the chip. Even variant 2 and 3 make the switch to be an actually
> physical clock provider, we still need to use REFCLKI and wire it
> outside of the chip which make it practically a Normal Mode or RevRMII mode.

That is correct, I guess its a matter of nomenclature, but how do you 
"tell" the switch whether it has REFCLKI routed externally or not if not by 
setting the 0xC6 bit 3? Is there another way to achieve this?

> > > I already did some work to configure CPU interface, where which can be at least
> > > partially reused for your work:
> > > https://lore.kernel.org/all/20230517121034.3801640-2-o.rempel@pengutronix.de/
> > > (Looks I forgot to complete mainlining for this patch)
> > >
> > > If implanted as described, no new devicetree properties will be needed.
> >
> > I don't quite get how the proposed patch might effect this topic?
> 
> You will need to add ksz8_phylink_mac_link_up() as this patch already
> dose.
> 
> > By setting PHY/MAC mode? As noted, I dont see the same relation between clock and
> > MII mode for KSZ8863 as for KSZ9897?
> 
> I hope current mail will clear it.

I tried your patch but it does not do it for me. As stated, my hw platform does
not have REFCLKI routed externally so a state at column 4/5 is expected.

