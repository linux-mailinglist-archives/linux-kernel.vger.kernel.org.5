Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06805752131
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 14:22:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbjGMMWx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 08:22:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234271AbjGMMWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 08:22:51 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C9302D5F;
        Thu, 13 Jul 2023 05:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=vjuO5R/KxvsMqsY6ylLB1bwZHDgruZucXbpLJVFeYDU=;
        t=1689250939; x=1690460539; b=mKvjJVr/i8ovv/d+lTmhaL2gKpxwIkmD5UG/8hnbjyvNHTB
        miUia7QyZxTWojZ0IninjFs9CA1av/gY7z/gqNY6wkExvZnMeGgidmnNBQf7zwEmUNVHVif0dLMjS
        wFshQMwZfAUWujcj3suK+gimlFTTRH24/b60xDgQARU1SuprKjEVZit+d0oOvvRBZHAhQeRWByW3n
        xCTtGwO2/zoOgCfhUexJmrAKrpia7UrffiNBDWY/vgEvQzRyfY/hAkiyPRIXYqQqq0EHPS/0oi1LW
        0gH0tSlEQ/KHVjcGHkKbuCbgJ+Rv5q0vDltPPhaIfJ6pXp+N9th4dSnEQV2HNS7A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qJvKO-001IDj-0c;
        Thu, 13 Jul 2023 14:21:48 +0200
Message-ID: <42f91f17602fea258fecb443ba81fa573bae1acb.camel@sipsolutions.net>
Subject: Re: [PATCH] USB: disable all RNDIS protocol drivers
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Oliver Neukum <oneukum@suse.com>,
        Enrico Mioso <mrkiko.rs@gmail.com>,
        Jan Engelhardt <jengelh@inai.de>, linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Kalle Valo <kvalo@kernel.org>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Maciej =?UTF-8?Q?=C5=BBenczykowski?= <maze@google.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Andrzej Pietrasiewicz <andrzejtp2010@gmail.com>,
        Jacopo Mondi <jacopo@jmondi.org>,
        =?UTF-8?Q?=C5=81ukasz?= Stelmach <l.stelmach@samsung.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-usb@vger.kernel.org, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org,
        Ilja Van Sprundel <ivansprundel@ioactive.com>,
        Joseph Tartaro <joseph.tartaro@ioactive.com>
Date:   Thu, 13 Jul 2023 14:21:46 +0200
In-Reply-To: <2023071333-wildly-playroom-878b@gregkh>
References: <20221123124620.1387499-1-gregkh@linuxfoundation.org>
         <n9108s34-9rn0-3n8q-r3s5-51r9647331ns@vanv.qr> <ZKM5nbDnKnFZLOlY@rivendell>
         <2023070430-fragment-remember-2fdd@gregkh>
         <e5a92f9c-2d56-00fc-5e01-56e7df8dc1c1@suse.com>
         <6a4a8980912380085ea628049b5e19e38bcd8e1d.camel@sipsolutions.net>
         <2023071222-asleep-vacancy-4cfa@gregkh>
         <2d26c0028590a80e7aa80487cbeffd5ca6e6a5ea.camel@sipsolutions.net>
         <2023071333-wildly-playroom-878b@gregkh>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-07-13 at 07:34 +0200, Greg Kroah-Hartman wrote:
> I wasn't trying to be glib here, sorry if it came across that way.  I'll
> blame the heat...

No worries.

> > All we said is that your statement of "RNDIS is fundamentally unfixable=
"
> > doesn't make a lot of sense. If this were the case, all USB drivers
> > would have to "trust the other side" as well, right?
>=20
> No, well, yes.  See the zillion patches we have had to apply to the
> kernel over the years when someone decided that "usb devices are not to
> be trusted" that syzbot has helped find :)

Sure, I'm well aware of that. But that's also exactly my point - nowhere
has anyone previously suggested that the protocol for any of those
devices is fundamentally broken and the drivers should be removed. We've
fixed those things and moved on.

I can even understand the initial reaction of "oh hey this ancient thing
is probably not used any more, let's just remove it", but even that's a
different reasoning, along the lines of "this has bugs and nobody needs
it". Though that nobody uses it has in fact been proven wrong, which is
pretty much why we're have this discussion at all.

> It's not a DMA issue here, it's a "the protocol allows for buffer
> overflows and does not seem to be able to be verified to prevent this"
> from what I remember (it's been a year since I looked at this last,
> details are hazy.)

If you s/be able to be verified/be verified in the code/ I entirely
believe it, in fact I think it's quite likely given the age of the code
and all. It's just that not being _able_ to verify it seems questionable
to me (and you haven't given any reasons), given that it's USB and you
always have a full buffer in hand when processing it, at a time where
the device can no longer modify it (IOW no TOCTTOU issues either.)

(As an aside, I've wondered about TOCTTOU with PCI, given that IOMMUs
can and will do lazy unmap ... but that's a different discussion.)


> At the time, I didn't see a way that it could be
> fixed, hence this patch.

Yeah I mean, the code isn't great, even if it's not _that_ much, but all
the likely() and things in there don't make it easy to read, and the
buffer size handling seems not immediately clear to me. So I probably
couldn't fix it quickly either, though I haven't even seen the reports.
Maciej seems to think it's fixable, at least. And yeah, we'd want to
actually review/audit that, I suppose.


So if you'd have said something like

   Let's disable the RNDIS driver(s) because there are known exploits
   there, nobody really knows how to fix this, and we need a short-term
   solution until the issues are public and somebody steps up to fix and
   maintain it.

I'd have much less of a problem with that. That's not _great_, but at
least it's honest and realistic. That could give us some time and maybe
then we can get the bug reports public once it's no longer an immediate
threat for all kernels, and go about fixing it with more time, maybe
eventually backporting fixes and reverting the disablement etc.

I guess this is why secret bug reports suck so much :-)

Thanks,
johannes
