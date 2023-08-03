Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A631E76F4B0
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 23:39:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231821AbjHCVjI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 17:39:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231129AbjHCVjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 17:39:06 -0400
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CE1730F6;
        Thu,  3 Aug 2023 14:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:Content-Type:Mime-Version:
        References:In-Reply-To:Message-Id:Cc:To:From:Date:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=+c3D1I04CXR8c7DhRfh0Z01N29Lf7zWiuh+iDe/1XJI=; b=iOHf37hTskOO8FjsCPPCe2JIXK
        /vm9ZCMWUKO/eqztrPGsPmN7zpLnfMkojpNL2kck7KCFf5BPXBMZEQ4dX1Gqz9wztCAC0DjmFU0ll
        7g+Lw5MN6tb2VKiDyVka8bentCG6yPIan1rtvz+iaEO1f73b8I/9Irrgy7Ueb8YncygQ=;
Received: from modemcable061.19-161-184.mc.videotron.ca ([184.161.19.61]:45150 helo=pettiford)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1qRg23-0005Hc-NM; Thu, 03 Aug 2023 17:38:56 -0400
Date:   Thu, 3 Aug 2023 17:38:54 -0400
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        jirislaby@kernel.org, jringle@gridpoint.com,
        isaac.true@canonical.com, jesse.sung@canonical.com,
        tomasz.mon@camlingroup.com, l.perczak@camlintechnologies.com,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        stable@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Lech Perczak <lech.perczak@camlingroup.com>
Message-Id: <20230803173854.efdda6d30d88b85ee101ce6b@hugovil.com>
In-Reply-To: <CAL_JsqK-qbz=w2a00EXh_e1XmY1gF1nvxih7AOYXw+VuMXhnmw@mail.gmail.com>
References: <20230721161840.1393996-1-hugo@hugovil.com>
        <20230721161840.1393996-7-hugo@hugovil.com>
        <CAL_JsqJpdhtnZ8FcM7kGWnM+iuDs1fWiCVgf413evbw-o8TZGQ@mail.gmail.com>
        <20230722104724.ef0c5896c239e721794b9fe9@hugovil.com>
        <2023072240-supremacy-shallot-a77f@gregkh>
        <20230724115428.d191186852c0bd0ee0d78398@hugovil.com>
        <CAL_JsqL8rjwONd6UAitKik0U44BKSD6m8zbachgfq0R9oHBW8w@mail.gmail.com>
        <20230731124600.39eb8d5c132f9338c2897543@hugovil.com>
        <CAL_JsqLaF70hNQndXpJfmH1TMGNbA7myQG0GK9fjyKOs63z-3w@mail.gmail.com>
        <20230731144115.14733f0e01f586a7efb91370@hugovil.com>
        <20230803135401.3a11bfb7c2985c1a90a2521b@hugovil.com>
        <CAL_JsqK-qbz=w2a00EXh_e1XmY1gF1nvxih7AOYXw+VuMXhnmw@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 184.161.19.61
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
Subject: Re: [RESEND PATCH v8 06/10] serial: sc16is7xx: fix regression with
 GPIO configuration
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Aug 2023 14:10:30 -0600
Rob Herring <robh+dt@kernel.org> wrote:

> On Thu, Aug 3, 2023 at 11:54 AM Hugo Villeneuve <hugo@hugovil.com> wrote:
> >
> > On Mon, 31 Jul 2023 14:41:15 -0400
> > Hugo Villeneuve <hugo@hugovil.com> wrote:
> >
> > > On Mon, 31 Jul 2023 12:04:45 -0600
> > > Rob Herring <robh+dt@kernel.org> wrote:
> > >
> > > > On Mon, Jul 31, 2023 at 10:46 AM Hugo Villeneuve <hugo@hugovil.com> wrote:
> > > > >
> > > > > On Mon, 31 Jul 2023 09:31:53 -0600
> > > > > Rob Herring <robh+dt@kernel.org> wrote:
> > > > >
> > > > > > On Mon, Jul 24, 2023 at 9:54 AM Hugo Villeneuve <hugo@hugovil.com> wrote:
> > > > > > >
> > > > > > > On Sat, 22 Jul 2023 17:15:26 +0200
> > > > > > > Greg KH <gregkh@linuxfoundation.org> wrote:
> > > > > > >
> > > > > > > > On Sat, Jul 22, 2023 at 10:47:24AM -0400, Hugo Villeneuve wrote:
> > > > > > > > > On Fri, 21 Jul 2023 13:24:19 -0600
> > > > > > > > > Rob Herring <robh+dt@kernel.org> wrote:
> > > > > > > > >
> > > > > > > > > > On Fri, Jul 21, 2023 at 10:19 AM Hugo Villeneuve <hugo@hugovil.com> wrote:
> > > > > > > > > > >
> > > > > > > > > > > From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > > > > > > > > > >
> > > > > > > > > > > Commit 679875d1d880 ("sc16is7xx: Separate GPIOs from modem control lines")
> > > > > > > > > > > and commit 21144bab4f11 ("sc16is7xx: Handle modem status lines")
> > > > > > > > > > > changed the function of the GPIOs pins to act as modem control
> > > > > > > > > > > lines without any possibility of selecting GPIO function.
> > > > > > > > > >
> > > > > > > > > > Requiring a new DT property is not fixing a kernel regression. You
> > > > > > > > > > should be returning the kernel to original behavior and then have a
> > > > > > > > > > new DT property for new behavior.
> > > > > > > > >
> > > > > > > > > Hi Rob,
> > > > > > > > > please read the entire patch history starting from V1
> > > > > > > > >  and you will understand why this course of action was
> > > > > > > > >  not selected.
> > > > > > > >
> > > > > > > > That's not going to happen, sorry, you need to explain it here, in this
> > > > > > > > patch series, why a specific action is being taken over another one, as
> > > > > > > > no one has time to go dig through past history, sorry.
> > > > > > >
> > > > > > > Hi Rob,
> > > > > > > I initially submitted a patch to revert the kernel to original
> > > > > > > behavior, but it created more problems because the patch was
> > > > > > > unfortunately split in two separate patches, and mixed with other non
> > > > > > > closely-related changes. It was also noted to me that reverting to the
> > > > > > > old behavior would break things for some users.
> > > > > > >
> > > > > > > It was suggested to me by a more experienced kernel developer to
> > > > > > > "suggest a fix, instead of hurrying a revert":
> > > > > > >
> > > > > > >     https://lkml.org/lkml/2023/5/17/758
> > > > > >
> > > > > > Do I have to go read this to decipher the justification and reasoning?
> > > > > > When Greg says "in this patch series", he means in the commit messages
> > > > > > of the patches. You send v9 already and it doesn't have that. The
> > > > > > patchset needs to stand on its own summarizing any relevant prior
> > > > > > discussions.
> > > > > >
> > > > > > I never suggested doing a revert.
> > > > >
> > > > > Hi Rob,
> > > > > I am sorry, but this is exactly what I "deciphered" from your
> > > > > original email.
> > > > >
> > > > > I am trying very hard to understand exactly what you mean, but it is
> > > > > not that obvious for me. If something is not clear in my commit message,
> > > > > I will try to improve it. But before, let's try to focus on making sure
> > > > > I understand more clearly what you want exactly.
> > > > >
> > > > > > Obviously, someone still wants the
> > > > > > new feature.
> > > > >
> > > > > I assume that you refer to the "new feature" as what was added in
> > > > > the commit 679875d1d880 ("sc16is7xx: Separate GPIOs from modem control
> > > > > lines")?
> > > >
> > > > Shrug. It's one of the 2 commits mentioned, I don't know which one
> > > > exactly. Whichever one changed default behavior from use GPIOs to use
> > > > modem ctrl lines.
> > > >
> > > > Reading it again, I *think* this patch is correct. Default behavior is
> > > > restored to use GPIOs. The DT property is needed to enable modem ctrl
> > > > lines.
> > >
> > > Hi,
> > > this is correct.
> > >
> > >
> > > > What's not okay is just saying, these platforms may or may not need an update:
> > > >
> > > >     arm64/boot/dts/freescale/fsl-ls1012a-frdm.dts
> > > >     mips/boot/dts/ingenic/cu1830-neo.dts
> > > >     mips/boot/dts/ingenic/cu1000-neo.dts
> > >
> > > Yes, my bad. I initially mentioned them and hoped to get some
> > > feedback, which I never got, and I kind of forgot about it.
> > >
> > > > You need to figure that out. Have you checked with maintainers of
> > > > these boards? When were they added and by who? At the same time or by
> > > > the same person would be a good indication the platform uses modem
> > > > ctrl lines. Or were these platforms in use before adding modem ctrl
> > > > support? Then they probably use GPIOs or nothing.
> > > >
> > > > If there are platforms which would regress if the modem ctrl feature
> > > > was just reverted, which ones are those?
> > >
> > > Ok, let me do some checks and get back to you on this.
> >
> > Hi Rob,
> > for this board:
> >     arm64/boot/dts/freescale/fsl-ls1012a-frdm.dts
> >
> > it uses a SC16IS740, which doesn't have any GPIOs nor modem
> > control lines, so no DT changes required.
> >
> > For these two Ingenic boards:
> >     mips/boot/dts/ingenic/cu1830-neo.dts
> >     mips/boot/dts/ingenic/cu1000-neo.dts
> >
> > They use a SC16IS752, which has shared modem control lines and GPIOs.
> > Unfortunately, the maintainers have not (yet) responded to my
> > inquiries. Also, I tried to search for schematics or block diagrams on
> > the net but couldn't find anything.
> >
> > These platforms were in use before the patch to add the modem control
> > lines was added. Then like you said they probably use these shared
> > lines as GPIOs or nothing, so no DT changes would be required.
> 
> Okay, that's useful (please add to the commit msg).

I added the information in the cover letter, but I can add it to the
actual patch commit message if you prefer.

> Still, what platform(s) need the modem control feature? Presumably
> that's whatever platform Lech and Tomasz work on. I guess given the
> Reviewed-by they are fine with needing a DT change.

Ok. I have previously also emailed Lech about that, but he has not
responded yet.

Thank you,
Hugo.
