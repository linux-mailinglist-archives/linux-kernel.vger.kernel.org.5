Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5283812A1F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 09:17:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbjLNIRJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 03:17:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjLNIRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 03:17:07 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A85198
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 00:17:13 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id e9e14a558f8ab-35f71face1bso6844705ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 00:17:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1702541833; x=1703146633; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0xiwwvK2LirL4zExSHvxpuvRjqDqO3bqO7fbrBZ3EcM=;
        b=c7MWWi9VU2U88ZGOkdrkaDYErG60PmNZP2phyVWGBlyfWleRNj4OEPfJmV+7Qfb5Np
         C7dK212NtROuU65TR+CeWYhsjzZBkNnAVgyeoaJXd9sz3TeKrC7AvOoHTtdt6bT5dK5I
         yVp/y/BOzD0wd6zaUtP2/XnESjlgSLL/U1Pko=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702541833; x=1703146633;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0xiwwvK2LirL4zExSHvxpuvRjqDqO3bqO7fbrBZ3EcM=;
        b=JlTAVTNoCpXah+DzwMkMMn7ZA7QpyqUw2EI6uADTVrt8eLulzmmq36Kdb/ISvtN0ez
         uH21ZXWWilp+dXfGKMWUD+iKnnanJG3du1+r/Jphf8vJ/s9rumELCYlhDCwheuHT9wBb
         yANfgj3UKk1MVm8eHpi4gZJL4anjlyZ3ZRLhWTudkiTUnxXuZbChqls++r56+xMeHu8T
         /zV5u3ua1/vle6JcDMoKeu/ZZmAlDAwK3lJLPvDmjn8/pWjPmajQXeokes1SoNRO2wFt
         vlZfBVzmRjw5coIZIft41v0TlSpyKXcUOD6UOh07FmltQZxjtvf4fgfePpyA/iWY4hYX
         +7cg==
X-Gm-Message-State: AOJu0YwmHPchIv70JnVTg9BRTwJSgWNbAQwWBbN1Kr+DlYdNEmtv5bjF
        zx8fsFCZbxHoeWTXfLNB4jVOTH/PNN71VcT5kISgnw==
X-Google-Smtp-Source: AGHT+IHrdEdNIh1ZE4V8Uz5oEN6VNCt2b4c4KjcgUJHbJ9BSJmU75B8kJ8o14rG4f6MA2NZFrfXbTL5ywJ6odbnD88E=
X-Received: by 2002:a05:6e02:1ba7:b0:35f:741a:7900 with SMTP id
 n7-20020a056e021ba700b0035f741a7900mr2960084ili.15.1702541832782; Thu, 14 Dec
 2023 00:17:12 -0800 (PST)
MIME-Version: 1.0
References: <20231207081801.4049075-1-treapking@chromium.org>
 <20231207081801.4049075-5-treapking@chromium.org> <CAD=FV=U6M5rpQXmjC+iGf0BGtiyjRAAcMfo4Fr3pDyYVp3m4aQ@mail.gmail.com>
 <fctpvshu5ychxketsf35jfg2qzi6i3nfup5hy7r7hzmmbpd2j4@xmsik3cycjlj>
 <CAD=FV=V=K9L=bJiNvFJ+K_DHUTPxA4WtukXA+E_VW6uihE8kdQ@mail.gmail.com>
 <cplpgkl5b3nrtdhxauleep6zo2rwic7h7fiwr4wnvrwk6uzxgw@dcgknug2gsaa> <CAD=FV=UiF9d5C=da64dj_JnGWuO_vGUg1hgzXSQd0x+pFpe23w@mail.gmail.com>
In-Reply-To: <CAD=FV=UiF9d5C=da64dj_JnGWuO_vGUg1hgzXSQd0x+pFpe23w@mail.gmail.com>
From:   Pin-yen Lin <treapking@chromium.org>
Date:   Thu, 14 Dec 2023 16:17:01 +0800
Message-ID: <CAEXTbpdjTVteNYMPN_wOwoc9TGuRT-+mugM4pj6tzih_wOU+hg@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] drm/panel-edp: Add some panels with conservative timings
To:     Doug Anderson <dianders@chromium.org>
Cc:     Maxime Ripard <mripard@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org,
        Guenter Roeck <groeck@chromium.org>,
        dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 14, 2023 at 12:23=E2=80=AFAM Doug Anderson <dianders@chromium.o=
rg> wrote:
>
> Hi,
>
> On Wed, Dec 13, 2023 at 7:34=E2=80=AFAM Maxime Ripard <mripard@kernel.org=
> wrote:
> >
> > > > > Repeating my comments from v1 here too, since I expect this patch=
 to
> > > > > sit on the lists for a little while:
> > > > >
> > > > >
> > > > > This is OK w/ me, but it will need time on the mailing lists befo=
re
> > > > > landing in case anyone else has opinions.
> > > >
> > > > Generally speaking, I'm not really a fan of big patches that dump
> > > > whatever ChromeOS is doing ...
> > > >
> > > > > Specifical thoughts:
> > > > >
> > > > > * I at least feel fairly confident that this is OK since these pa=
nels
> > > > > essentially booted without _any_ delays back on the old downstrea=
m
> > > > > v4.19 kernel. Presumably the panels just had fairly robust timing
> > > > > controllers and so worked OK, but it's better to get the timing m=
ore
> > > > > correct.
> > > >
> > > > ... especially since you have to rely on the recollection of engine=
ers
> > > > involved at the time and you have no real way to test and make thin=
gs
> > > > clearer anymore, and we have to take patches in that are handwavy "=
trust
> > > > us, it's doing the right thing".
> > > >
> > > > I'd really prefer to have these patches sent as they are found out.
> > >
> > > It's probably not clear enough from the commit message, but this isn'=
t
> > > just a dump from downstream 4.19. What happened was:
> > >
> > > 1. Downstream chromeos-4.19 used the "little white lie" approach. The=
y
> > > all claimed a specific panel's compatible string even though there
> > > were a whole pile of panels out there actually being used. Personally=
,
> > > this was not something I was ever a fan of (and I wasn't personally
> > > involved in this project), but it was the "state of the art" before
> > > the generic panel-edp. Getting out of the "little white lie" situatio=
n
> > > was why I spent so much time on the generic edp-panel solution
> > > upstream.
> > >
> > > 2. These devices have now been uprevved to a newer kernel and I
> > > believe that there were issues seen that necessitated a move to the
> > > proper generic panel-edp code.
> > >
> > > 3. We are now getting field reports from our warning collector about =
a
> > > whole pile of panels that are falling back to the "conservative"
> > > timings, which means that they turn on/off much more slowly than they
> > > should.
> > >
> > > Pin-yen made an attempt to search for panels data sheets that matched
> > > up with the IDs that came in from the field reports but there were
> > > some panels that he just couldn't find.
> > >
> > > So basically we're stuck. Options:
> > >
> > > 1. Leave customers who have these panels stuck with the hardware
> > > behaving worse than it used to. This is not acceptable to me.
> > >
> > > 2. Land Pin-yen's patch as a downstream-only patch in ChromeOS. This
> > > would solve the problem, but it would make me sad. If anyone ever
> > > wants to take these old laptops and run some other Linux distribution
> > > on them (and there are several that target old Chromebooks) then
> > > they'd be again stuck with old timings.
> > >
> > > 3. Land a patch like this one that at least gets us into not such a b=
ad shape.
> > >
> > > While I don't love this patch (and that's why I made it clear that it
> > > needs to spend time on the list), it seems better than the
> > > alternatives. Do you have a proposal for something else? If not, can
> > > you confirm you're OK with #3 given this explanation? ...and perhaps
> > > more details in the commit message?
> >
> > I don't have a specific comment, it was more of a comment about the
> > process itself, if you write down what's above in the commit message ..=
.
>
> Pin-yen: can you take a whack at summarizing some of the above in the
> commit message and sending out a v3?

Sure I'll do that in v3. Sorry for not including enough details in the
original commit message.

Pin-yen
