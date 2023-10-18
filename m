Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A73857CD3D0
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 08:06:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344419AbjJRGGX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 02:06:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjJRGGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 02:06:21 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EA3DC6
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 23:06:19 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1c9b70b9671so85995ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 23:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697609179; x=1698213979; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v1WMeQoTbai5jcFg/8kPiT+daiwAiiktJJC7VnxF4OU=;
        b=SPa4lMGNoiPN8ba/IOo1l6b6wG1H8bjr2+q8jU8NNNxNSvsboTqevRNtT+OKotsbIU
         SaJR0iLTSOWVnqpUCfGy3CuNN6L1Wn0Gjc8ZCZwQcnKTtThgMefCAdK5hw+6BdG+uveP
         ehLPZ6ehV4FCvtSA7bUJXJUPLwRbzpcSEwCIg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697609179; x=1698213979;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v1WMeQoTbai5jcFg/8kPiT+daiwAiiktJJC7VnxF4OU=;
        b=Fx+WoZO1zP2pmlKPZAN9Yuwzv8RsyrphbABohcvXSApFnuUYdAVVTed99ByRkcYc1v
         aDbazLexTbYfjnVFO1mPU5Bg/Po8PJkcMwHuqDnJrSfD7S5vT7I5vBc9U+Nma70eZuHZ
         5pBkgbFRL56v4y+gvY9LM0L4G0USe6WMmoldGUzXmKAu73ZDEZfA/dMz0/Za84gY99Z8
         YBAdqH4j5A7lGfDawrAwm5gOw5Z3Wa7PxbhVar9qbH/PmOgtCInyzFwqm8Tf2xp8IEy4
         LCJcpbU1QYxGZ7WktJDqUJjvksm+vPymkkIsTz5YU7BvnO+50rBEc65//4jAJiIlAfqC
         pKjw==
X-Gm-Message-State: AOJu0Yy6A3OjrT+cutKYfMjIoGPWngGtLT0+AidyPMA5WJyUHzq+AAYl
        XZa2lZ+SMuKQzgfmXv07YWF29tWyR8Gb2HLoDbI54Q==
X-Google-Smtp-Source: AGHT+IFCmyy+5s6X+xOiaol9ZdDdb7IvXqxzpm7o3kfVB89cGbzx/i5UCG3hHH6rTE4spkcyS1gycWYRMQqcdi75asA=
X-Received: by 2002:a17:902:cecb:b0:1bb:c2b1:9be0 with SMTP id
 d11-20020a170902cecb00b001bbc2b19be0mr173548plg.16.1697609178444; Tue, 17 Oct
 2023 23:06:18 -0700 (PDT)
MIME-Version: 1.0
References: <20231012192552.3900360-1-dianders@chromium.org>
 <20231012122458.v3.5.Ib2affdbfdc2527aaeef9b46d4f23f7c04147faeb@changeid>
 <29f9a2ff1979406489213909b940184f@realtek.com> <CAD=FV=U4rGozXHoK8+ejPgRtyoACy1971ftoatQivqzk2tk5ng@mail.gmail.com>
 <052401da00fa$dacccd90$906668b0$@realtek.com> <CAD=FV=XQswgKZh-JQ6PuKGRmrDMfDmZwM+MUpAcOk1=7Ppjyiw@mail.gmail.com>
 <CAD=FV=Vp_KE_hjWy7bKJbvmqwCQ67jhzfFoV368vB5ZGge=Yzw@mail.gmail.com>
In-Reply-To: <CAD=FV=Vp_KE_hjWy7bKJbvmqwCQ67jhzfFoV368vB5ZGge=Yzw@mail.gmail.com>
From:   Grant Grundler <grundler@chromium.org>
Date:   Tue, 17 Oct 2023 23:06:06 -0700
Message-ID: <CANEJEGuEdGUAUufEHBfxbo_thXbgr8gMFVBaa+pCV_axWO=NGQ@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] r8152: Block future register access if register
 access fails
To:     Doug Anderson <dianders@chromium.org>,
        Hayes Wang <hayeswang@realtek.com>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Alan Stern <stern@rowland.harvard.edu>,
        Simon Horman <horms@kernel.org>,
        Edward Hill <ecgh@chromium.org>,
        Laura Nao <laura.nao@collabora.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Grant Grundler <grundler@chromium.org>,
        =?UTF-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_SPF_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 17, 2023 at 11:46=E2=80=AFAM Doug Anderson <dianders@chromium.o=
rg> wrote:
>
> Hi,
>
> On Tue, Oct 17, 2023 at 7:17=E2=80=AFAM Doug Anderson <dianders@chromium.=
org> wrote:
> >
> > Hi,
> >
> > On Tue, Oct 17, 2023 at 6:07=E2=80=AFAM Hayes Wang <hayeswang@realtek.c=
om> wrote:
> > >
> > > Doug Anderson <dianders@chromium.org>
> > > > Sent: Tuesday, October 17, 2023 12:47 AM
> > > [...
> > > > > >  static int generic_ocp_read(struct r8152 *tp, u16 index, u16 s=
ize,
> > > > > > @@ -8265,6 +8353,19 @@ static int rtl8152_pre_reset(struct
> > > > usb_interface
> > > > > > *intf)
> > > > > >         if (!tp)
> > > > > >                 return 0;
> > > > > >
> > > > > > +       /* We can only use the optimized reset if we made it to=
 the end of
> > > > > > +        * probe without any register access fails, which sets
> > > > > > +        * `PROBED_WITH_NO_ERRORS` to true. If we didn't have t=
hat then return
> > > > > > +        * an error here which tells the USB framework to fully=
 unbind/rebind
> > > > > > +        * our driver.
> > > > >
> > > > > Would you stay in a loop of unbind and rebind,
> > > > > if the control transfers in the probe() are not always successful=
?
> > > > > I just think about the worst case that at least one control alway=
s fails in probe().
> > > >
> > > > We won't! :-) One of the first things that rtl8152_probe() does is =
to
> > > > call rtl8152_get_version(). That goes through to
> > > > rtl8152_get_version(). That function _doesn't_ queue up a reset if
> > > > there are communication problems, but it does do 3 retries of the
> > > > read. So if all 3 reads fail then we will permanently fail probe,
> > > > which I think is the correct thing to do.
> > >
> > > The probe() contains control transfers in
> > >         1. rtl8152_get_version()
> > >         2. tp->rtl_ops.init()
> > >
> > > If one of the 3 control transfers in 1) is successful AND
> > > any control transfer in 2) fails,
> > > you would queue a usb reset which would unbind/rebind the driver.
> > > Then, the loop starts.
> > > The loop would be broken, if and only if
> > >         a) all control transfers in 1) fail, OR
> > >         b) all control transfers in 2) succeed.
> > >
> > > That is, the loop would be broken when the fail rate of the control t=
ransfer is high or low enough.
> > > Otherwise, you would queue a usb reset again and again.
> > > For example, if the fail rate of the control transfer is 10% ~ 60%,
> > > I think you have high probability to keep the loop continually.
> > > Would it never happen?
> >
> > Actually, even with a failure rate of 10% I don't think you'll end up
> > with a fully continuous loop, right? All you need is to get 3 failures
> > in a row in rtl8152_get_version() to get out of the loop. So with a
> > 10% failure rate you'd unbind/bind 1000 times (on average) and then
> > (finally) give up. With a 50% failure rate I think you'd only
> > unbind/bind 8 times on average, right? Of course, I guess 1000 loops
> > is pretty close to infinite.
> >
> > In any case, we haven't actually seen hardware that fails like this.
> > We've seen failure rates that are much much lower and we can imagine
> > failure rates that are 100% if we're got really broken hardware. Do
> > you think cases where failure rates are middle-of-the-road are likely?
> >
> > I would also say that nothing we can do can perfectly handle faulty
> > hardware. If we're imagining theoretical hardware, we could imagine
> > theoretical hardware that de-enumerated itself and re-enumerated
> > itself every half second because the firmware on the device crashed or
> > some regulator kept dropping. This faulty hardware would also cause an
> > infinite loop of de-enumeration and re-enumeration, right?
> >
> > Presumably if we get into either case, the user will realize that the
> > hardware isn't working and will unplug it from the system. While the
> > system is doing the loop of trying to enumerate the hardware, it will
> > be taking up a bunch of extra CPU cycles but (I believe) it won't be
> > fully locked up or anything. The machine will still function and be
> > able to do non-Ethernet activities, right? I would say that the worst
> > thing about this state would be that it would stress corner cases in
> > the reset of the USB subsystem, possibly ticking bugs.
> >
> > So I guess I would summarize all the above as:
> >
> > If hardware is broken in just the right way then this patch could
> > cause a nearly infinite unbinding/rebinding of the r8152 driver.
> > However:
> >
> > 1. It doesn't seem terribly likely for hardware to be broken in just th=
is way.
> >
> > 2. We haven't seen hardware broken in just this way.
> >
> > 3. Hardware broken in a slightly different way could cause infinite
> > unbinding/rebinding even without this patch.
> >
> > 4. Infinite unbinding/rebinding of a USB adapter isn't great, but not
> > the absolute worst thing.
> >
> >
> > That all being said, if we wanted to address this we could try two
> > different ways:
> >
> > a) We could add a global in the r8152 driver and limit the number of
> > times we reset. This gets a little ugly because if we have multiple
> > r8152 adapters plugged in then the same global would be used for both,
> > but maybe it's OK?
> >
> > b) We could improve the USB core to somehow prevent usb_reset_device()
> > from running too much on a given device?
> >
> >
> > ...though I would re-emphasize that I don't think this is something we
> > need to address now. If later we actually see a problem we can always
> > address it then.
>
> One other idea occurred to me that we could do, if we cared to solve
> this hypothetical failure case. We could change the code to always
> read the version 4 times on every probe. If one of the transfers fails
> then we could consider that OK. If 2 or more transfers fails then we
> could consider that to be an error. You still might get a _few_
> unbind/bind in this hypothetical failure mode, but I think it would
> catch the problem more quickly.
>
> My probability theory is rusty and I'm sure there's a better way, but
> I think we can just add up all the cases. Assuming a 10% failures and
> 90% success of any transfer:
>
> # Chance of 2 failures:
> .10 * .10 * .90 * .90 +
> .10 * .90 * .10 * .90 +
> .10 * .90 * .90 * .10 +
> .90 * .10 * .90 * .10 +
> .90 * .90 * .10 * .10
>
> # Chance of 3 failures:
> .10 * .10 * .10 * .90 +
> .10 * .10 * .90 * .10 +
> .10 * .90 * .10 * .10 +
> .90 * .10 * .10 * .10
>
> # Chance of 4 failures:
> .10 * .10 * .10 * .10
>
> If I add that up I get about a 4.4% chance of 2 or more failures in 4
> reads. That means if we got into an unbind/bind cycle we'd get out of
> it (on average) in ~23 probes because we'd see enough failures. We
> could likely reduce this further by reading the version 5 or 6 times.
>
> I will note that my measurements showed that a normal probe is ~200
> transfers and also includes a bunch of delays, so reading the version
> a few times wouldn't be a huge deal.
>
>
> In any case, I'm still of the opinion that we don't need to handle this.

Hayes,
As Doug points out the probability is really low of this happening for
an event that is already rare. Doug's patch is a very good step in the
right direction (driver robustness) and I think has been tested by
Chromium OS team enough that it is safe to apply to the upstream tree.
I'm a big fan of taking small steps where we can. We can further
improve on this in the future as needed.

Please add:
Reviewed-by: Grant Grundler <grundler@chromium.org>

cheers,
grant

>
> -Doug
