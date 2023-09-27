Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A08DF7B0AD0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 19:06:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbjI0RGV convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 27 Sep 2023 13:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjI0RGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 13:06:19 -0400
X-Greylist: delayed 907 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 27 Sep 2023 10:06:15 PDT
Received: from sender-of-o49.zoho.eu (sender11-of-o53.zoho.eu [31.186.226.239])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAADF95;
        Wed, 27 Sep 2023 10:06:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1695833431; cv=none; 
        d=zohomail.eu; s=zohoarc; 
        b=hotgoDEPYTwzrbPtF5xB3V1zHmZgMpbqYamrkCWowv4aY1gfZVZsIFPlmMs9+i8KCCxQVC7AGrYz42Uj/z/P0mLnvVPDBTI4nZOFV8czeD+LiJnhUAIwFfMaeTmUMaJbsqvR+44LTxjRKwHMkhiZBFGJVDLaUha48S9E8QST5I0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
        t=1695833431; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
        bh=/KrHy5tQAsIei5Iqu5rYZG0GhfjNKeGvw6jsZ0TcLY8=; 
        b=T+nkQv4IoPSVfjqN9+ddTcBlo0Gg7I6YmAmnVvlLFC2TM5OzT3RDFq3yoJHYmgcSsTA2LWdiOtnFk/e8zZeqOlsjPAop+PHfs7Bvu2KTHGY5XS0dju/IlCNRvK0jwjxB/X8qE1WTY5aPFFv2iz5zz8g518QJ3FyUDJ6coSbs3/0=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
        spf=pass  smtp.mailfrom=devnull@uvos.xyz;
        dmarc=pass header.from=<devnull@uvos.xyz>
Received: from [10.0.0.2] (ip-037-201-240-143.um10.pools.vodafone-ip.de [37.201.240.143]) by mx.zoho.eu
        with SMTPS id 1695833428206965.6284300956125; Wed, 27 Sep 2023 18:50:28 +0200 (CEST)
Message-ID: <994d5d7187a96fa48ade9244bcc9bd57465bf487.camel@uvos.xyz>
Subject: Re: droid4 -- weird behaviour when attempting to use usb host
From:   Unknown <devnull@uvos.xyz>
To:     Pavel Machek <pavel@ucw.cz>, Tony Lindgren <tony@atomide.com>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-omap@vger.kernel.org, sre@kernel.org, nekit1000@gmail.com,
        mpartap@gmx.net, merlijn@wizzup.org, martin_rysavy@centrum.cz,
        phone-devel@vger.kernel.org, maemo-leste@lists.dyne.org
Date:   Wed, 27 Sep 2023 18:50:26 +0200
In-Reply-To: <ZRRPsWQiTP21hozK@duo.ucw.cz>
References: <ZRGa+0OFNluV4T5t@localhost> <20230926071415.GW5285@atomide.com>
         <ZRRPsWQiTP21hozK@duo.ucw.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.4 
MIME-Version: 1.0
X-ZohoMailClient: External
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-09-27 at 17:52 +0200, Pavel Machek wrote:
> Hi!
> 
> > > I'm having some fun with usb host. Good news is it works with
> > > externally powered hub... after a while. I get some error
> > > messages
> > > about inability to go host mode, but with enough patience it
> > > eventually does enter host mode and I see my keyboard/mouse.
> > > 
> > > And usually in that process, one of my cpu cores disappear. top
> > > no
> > > longer shows 2 cores, and I was wondering for a while if d4 is
> > > single-core system. It is not, my two cores are back after
> > > reboot.
> > > 
> > > That's with 6.1.9 kernel from leste. Ideas how to debug this
> > > would be
> > > welcome. (Do you use usb host?)
> > 
> > You are using a "proper" non-standard usb micro-b cable that
> > grounds
> > the id pin, right?
> 
> Yes.
> 
> > If not, try with one of those as it allows the hardware to do what
> > it's
> > supposed to do.
> > 
> > And presumably you don't have a hacked usb hub that feeds back the
> > vbus to your phone, right?
> 
> Do have hacked hub. Or more precisely, have device that needs
> external
> power (spinning rust), and hub passes it back to the device.
> 
> I'll retry with a keyboard... but I recall it behaved funny with
> that, too.
> 
> > If you have, that should not be used as the pmic can feed vbus.
> 
> Well, my plan was to use it as a desktop, and external power is
> useful
> that as Droid battery is not that big.
> 
> Best regards,
>                                                                 Pavel

I use usb host quite a bit with xt875, mostly to have a keyboard.
I have noted that several hubs i have don't work reliably, im not sure
why. Its possible that they use or request too mutch power from the
port as cpcap has a pretty small vbus out limit.

All my regular otg adapters work fine however.

I also have a powered hub that works quite well, its item 373697032160
on ebay

