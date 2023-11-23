Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 967117F633A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 16:45:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346180AbjKWPpT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 10:45:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346170AbjKWPpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 10:45:16 -0500
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 619DAD7D;
        Thu, 23 Nov 2023 07:45:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=oI9tlHNqD4QxkW24a4pt9udulwJ5LefdDiNx4SbY4Hg=; b=Hxr27Zh+P4/CYTb7GtoRuc+MJN
        0EsLrqRCebyxCuydcI5pp6OYz0n3eEw6REViPI27LDe/zdqyn8LiOFb3+KDoy/sDAZCcSBxs9oA4+
        lrqHcK1v+c/D1Yg3xBpI5movdX/unSXLHfMBrtKHwst9hXboBi7kMatCV3+QMCAOk/4I=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1r6Bt9-0010Z5-Kt; Thu, 23 Nov 2023 16:45:11 +0100
Date:   Thu, 23 Nov 2023 16:45:11 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Lee Jones <lee@kernel.org>
Cc:     Shiji Yang <yangshiji66@outlook.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v4] dt-bindings: leds: add 'internet' and 'signal'
 function definitions
Message-ID: <6d1a0be4-89b3-4c47-8763-4139904cc670@lunn.ch>
References: <TYAP286MB0315F4D71698370875F58F6EBCAAA@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM>
 <20231123112543.GD1243364@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231123112543.GD1243364@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 23, 2023 at 11:25:43AM +0000, Lee Jones wrote:
> Andrew, Florian,
> 
> Thoughts?

Hi Lee

Thanks for forwarding this.

> On Mon, 06 Nov 2023, Shiji Yang wrote:
> 
> > These two types of LEDs are widely used in routers and NICs.

I would disagree with this. Routers and NICs are very generic
terms. The Cisco router i have in the broom closet does not have a
signal strength. It does not even have WiFi. It has no concept of
Internet.

I would drop NIC and add more words to narrow routers down to a more
specific class of routers, probably those found in homes, rented from
an ISP, most don't actually do L3 routing, or at best, just NAT.

> > The 'signal' LED is used to display the wireless signal strength.
> > Usually, there are 3~4 LEDs in one group to indicate the signal
> > strength, similar to the signal icon on a mobile phone.

Maybe signal_strength. And is there any reason these cannot be used on
a 5G modem to indicate 'mobile phone' like signal strength? So
`similar to` is wrong, they could actually be used for that.

At least the word wireless is used, not wifi. So its reasonably
generic. Are there other signal strength indicators for other media?
I've not seen powerline modems have such indicators. And with those
SNR is more important than signal strength.

> > The 'internet' LED can indicate whether the device can access a
> > specific server. It's different from 'wan'. 'wan' usually indicates
> > whether the WAN port is connected to the modem (internet services
> > may still be unavailable). But the 'internet' shows if the device
> > can successfully ping servers such as 8.8.8.8 to detect the internet
> > connection status. When the router is running in AP only mode, we
> > can even connect LAN port to the AC/modem to connect to the internet.
> > In this case, the 'internet' LED should be on. On some routers, both
> > 'internet' and 'wan' are available and can be controlled separately.

I suggest some of this text appears in the header, to make their
meaning clear. Also, document what WAN means. But care is needed,
since these are networking wide concepts, not the very narrow market
of an ISP rented boxes.

    Andrew
