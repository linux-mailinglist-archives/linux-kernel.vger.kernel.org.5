Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 424487E533A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 11:22:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235492AbjKHKWz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 05:22:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjKHKWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 05:22:54 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2049E1BD5
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 02:22:52 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEDEDC433C8;
        Wed,  8 Nov 2023 10:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699438971;
        bh=JGmlL0KgwRDqiQzXzq/RBHugjS46fQ4CpIjGxsM+Uuk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jFhpgRSNJqU6Nh/RWEkc0vMD13+y2eepajbN5iM89ys/pfDaFWmWj5dVkKOXe+/b1
         WxBEEH0Xyqt0G5/tNgiZRYNutglEmB377IuXRhsML8UPY4kqUgTBhlpoibaNmf087Z
         aKhdk8hKAtiA/WJVHHLLJ977UOVrb/VqXhwAxK3HgxT3GnlJMjcWdZ9xAbET6hnREJ
         POXWJLjxuNa4e8AOkt3kCNJEsMZhOvtugswmikdfZbnqkwOcXFC+mE33Wobmd8b35c
         pU+cVu82OKmIW7RK5vnyU3UBDRM2Y44Fc0iFBGYtoo5m+53LCUC0IhTvmvVqsYXy3n
         FeuECdMj3bV4Q==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan@kernel.org>)
        id 1r0fio-0007El-0Z;
        Wed, 08 Nov 2023 11:23:42 +0100
Date:   Wed, 8 Nov 2023 11:23:42 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Victor Fragoso <victorffs@hotmail.com>
Cc:     "dcbw@redhat.com" <dcbw@redhat.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] USB: serial: option: add Fibocom L7xx modules
Message-ID: <ZUthrrt4WkYXTTZD@hovoldconsulting.com>
References: <9315051ae981aaad1d46724641defc6e5f79d12b.camel@hotmail.com>
 <8a8d4a7787e9d8b4f7f3c119b057ec4a8a6b1a91.camel@redhat.com>
 <a389548ccffa29ff58f30262410c535bf9137c49.camel@hotmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a389548ccffa29ff58f30262410c535bf9137c49.camel@hotmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 27, 2023 at 05:55:27PM +0000, Victor Fragoso wrote:
> On Thu, 2023-10-26 at 08:49 -0500, Dan Williams wrote:
> > On Thu, 2023-10-26 at 01:24 +0000, Victor Fragoso wrote:
> > > Add support for Fibocom L7xx module series and variants.
> > > 
> > > L716-EU-60 (ECM):

> > > A:  FirstIf#= 0 IfCount= 2 Cls=02(comm.) Sub=06 Prot=00
> > > I:* If#= 0 Alt= 0 #EPs= 1 Cls=02(comm.) Sub=06 Prot=00 Driver=cdc_ether
> > > E:  Ad=87(I) Atr=03(Int.) MxPS=  16 Ivl=32ms
> > > I:  If#= 1 Alt= 0 #EPs= 0 Cls=0a(data ) Sub=00 Prot=00 Driver=cdc_ether
> > > I:* If#= 1 Alt= 1 #EPs= 2 Cls=0a(data ) Sub=00 Prot=00 Driver=cdc_ether
> > > E:  Ad=81(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> > > E:  Ad=01(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> > > I:* If#= 2 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=option
> > > E:  Ad=82(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> > > E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> > > I:* If#= 3 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=option
> > > E:  Ad=83(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> > > E:  Ad=03(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> > > I:* If#= 4 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=option
> > > E:  Ad=84(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> > > E:  Ad=04(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> > > I:* If#= 5 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=option
> > > E:  Ad=85(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> > > E:  Ad=05(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> > > I:* If#= 6 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=42 Prot=01 Driver=usbfs
> > > E:  Ad=86(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> > > E:  Ad=06(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms

> > Also, are you at all able to give hints in the comments about what kind
> > of ports these are? AT? GPS? PPP? etc?  That's usually described in the
> > driver documentation or in the Windows drivers themselves.

> About the hints on comments (AT, PPP, etc) I am not so sure if I should
> add other hints.
> As I've mentioned on the other email to Lars:
> I am a Field Application Enginner at Fibocom Brazil and I am using the
> IDs from our internal and official documentation.
> This IDs will guarantee that can be used on all the variants devices
> from L71x series.
> For example, the 0x2cb7 0x0001 can be used by L716-EU on RNDIS, L716-
> EU-10 on ECM and L710 too. While 19d2 0579 can be used by L716-EU-60 on
> ECM and probably other variants.
> 
> So, to avoid any misunderstand I prefer to keep it simple and mention
> just as L71x series.

For the device entry comment I think you should use the model you've
tested, and if there are multiple modules you can possibly list more
than one if that makes sense.
 
But I think Dan was asking you to say something about what the
individual interfaces are used for. That's better added to the commit
message (i.e. describing which port is which).

Johan
