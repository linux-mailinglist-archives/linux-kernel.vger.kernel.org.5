Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB6FC7C0131
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 18:07:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233858AbjJJQHp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 12:07:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234005AbjJJQHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 12:07:24 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C223D68
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 09:06:30 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-5a7d9d357faso433487b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 09:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696953989; x=1697558789; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fbrCOjo8oRmVCVVvksHWmUiWXADJntXuH1qYxxdJKdI=;
        b=OsITWeGdCCteCFoZbObhX67YiDRa2YfOi2N1jnY/G1KwlAG9nYejhOQtwLIRUsUUkA
         oB9EF8JXp+Rr50YtVD5SfokRypZIRZWmZAWnDVwrkoOZW3waAqT5h2HyAt+jLyersd6+
         MPs1a86RmHtgns4GNazLKVWXF8Q2XxhhDq2mM55mTLbqVjXnwmWldkXyzN+xR8F4Ogco
         DBB/3jydj+rYP5NXxqXxHjaMM6osmteAwBFACCLRq2l/VkJyVfCZDQNfV181xlYYsbnA
         vSgPz22Vs4s+zSTkS/+jvz1T2iIjPu+e/T4smnuXOCfgQOqSDr6qlXyfDcoqKzs5tLhs
         vKIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696953989; x=1697558789;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fbrCOjo8oRmVCVVvksHWmUiWXADJntXuH1qYxxdJKdI=;
        b=H0+KQfh0jYz57sh6rcni+OD48j4AsZ5i3s6ptzll7ysTGELp0LmV/vr1kZimu9aOAJ
         Jf2gZMdaCUop0AUcPngjjKYkvvI8RvAhj//2slxQ10zbyH3HiTpG35KY578fykillmla
         V38Kguq0oGVdf6HB5eQHzfbhGV0DrEBvjLfEqvpIP8t27rtseDgSOdUU21Sdd/3ETlH1
         LoWhs4oNspavCelbXvbb9vGfWg1RMbHMnui3oKtM/QAsAVIzBMGXlyuekvhkxnqvyPUm
         GuuVhS6GFKGqCJ4mlPJiXG1+urGWZg9hn9gcAXv5kQx/byTmS1OFncBs7AU0KQKfNCK4
         JRng==
X-Gm-Message-State: AOJu0Yyo1MNul4EgAHnv3rjHwZhkBKsninwbmMp4ekrV0gMmNJnxouUG
        nRjkAxy21cS4H+rsEwO6lXaPvGFIr9EyhX6COrq9SyTQ
X-Google-Smtp-Source: AGHT+IEwQFpEfW0CZVuvkm5WP3C8hOeE2KKY1P9SfAqvIAOHozBIC8YPmCFWhk9UUleywqY3kRITrcfiDE84NUrMi60=
X-Received: by 2002:a05:690c:dd2:b0:5a4:f7d3:394e with SMTP id
 db18-20020a05690c0dd200b005a4f7d3394emr25295637ywb.14.1696953989359; Tue, 10
 Oct 2023 09:06:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230915154856.1896062-1-lb@semihalf.com> <CAJfuBxyFYyGCtr5i=P7N=1oX3J=jmdp1VLGLt+z1fAnuvGK2aA@mail.gmail.com>
 <CAK8ByeJBrPEQSgUc91LQO9Krzjh2pauhMTjEC82M8ozayE76Yg@mail.gmail.com>
 <CAJfuBxxmL-GtBgt=033F9UNeLCreFbJh3HrQQN2nYKwR_0uTbg@mail.gmail.com>
 <20231003155810.6df9de16@gandalf.local.home> <CAJfuBxyJyFbFEhRxrtxJ_RazaTODV6Gg64b1aiNEzt6_iE4=Og@mail.gmail.com>
 <CAK8ByeLNc9UbTNG4x=40AxYqjjRCsvBNtNFai0PMveM2X4XCow@mail.gmail.com>
 <CAJfuBxyRF4q_T8LmHwR=-PKKDDpiFg2nO03uLnL8aGpRyBByKw@mail.gmail.com>
 <CAK8ByeLpkSV6o6gPw8eJVqq5+ynQrSDjemY7mXkO1ZmA0rYKfQ@mail.gmail.com> <CAJfuBxw+ANLwssAGWpkn5PeJb8ZKn4LXQkk2Gfv3aGsSN=S55Q@mail.gmail.com>
In-Reply-To: <CAJfuBxw+ANLwssAGWpkn5PeJb8ZKn4LXQkk2Gfv3aGsSN=S55Q@mail.gmail.com>
From:   jim.cromie@gmail.com
Date:   Tue, 10 Oct 2023 10:06:02 -0600
Message-ID: <CAJfuBxy9qn-4i3SteTL1LBbBxPrFM52KkBd=1UhcKV3S_KdQvw@mail.gmail.com>
Subject: Re: [PATCH v1] dynamic_debug: add support for logs destination
To:     Sean Paul <seanpaul@chromium.org>,
        Pekka Paalanen <ppaalanen@gmail.com>,
        Simon Ser <contact@emersion.fr>, lyude@redhat.com
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

since I name-dropped you all,

On Tue, Oct 10, 2023 at 10:01=E2=80=AFAM <jim.cromie@gmail.com> wrote:
>
> On Mon, Oct 9, 2023 at 4:47=E2=80=AFPM =C5=81ukasz Bartosik <lb@semihalf.=
com> wrote:
> >
> > pt., 6 pa=C5=BA 2023 o 22:49 <jim.cromie@gmail.com> napisa=C5=82(a):
> > >
> > > On Wed, Oct 4, 2023 at 4:55=E2=80=AFAM =C5=81ukasz Bartosik <lb@semih=
alf.com> wrote:
> > > >
> > > > wt., 3 pa=C5=BA 2023 o 22:54 <jim.cromie@gmail.com> napisa=C5=82(a)=
:
> > > > >
> > > > > On Tue, Oct 3, 2023 at 1:57=E2=80=AFPM Steven Rostedt <rostedt@go=
odmis.org> wrote:
> > > > > >
> > > > > > On Mon, 2 Oct 2023 14:49:20 -0600
> > > > > > jim.cromie@gmail.com wrote:
> > > > > >
> > > > > > > hi Lukasz,
> > > > > > >
> > > > > > > sorry my kernel-time has been in my own trees.
> > > > > > >
> > > > > > > What I dont understand is why +T is insufficient.
> > > > > > >
> > > >
> > > > We would like to be able to separate debug logs from different
> > > > subsystem (e.g. thunderbolt and usbcore).
> > > > With +T it is not possible because all debug logs will land in the =
same bucket.
> > > >
> > > > > > > IIUC, tracefs is intended for production use.
> > > > > > > thats why each event can be enabled / disabled
> > > > > > > - to select and minimize whats traced, and not impact the sys=
tem
> > > > > > >
> > > > > > > and +T  can forward all pr_debugs to trace,
> > > > > > > (by 1-few trace events defined similarly to others)
> > > > > > > or very few, giving yet another selection mechanism
> > > > > > > to choose or eliminate specific pr-debugs and reduce traffic =
to
> > > > > > > interesting stuff.
> > > > > > >
> > > > > > > Once your debug is in the trace-buf,
> > > > > > > shouldnt user-space be deciding what to do with it ?
> > > > > > > a smart daemon could leverage tracefs to good effect.
> > > > > > >
> > > >
> > > > Yes, a daemon could separate the debug logs but IMHO it is much
> > > > easier to separate logs by sending them directly from a given subsy=
stem
> > > > to a separate trace instance. My proposal allows to configure diffe=
rent
> > > > trace instance as destination for each callsite.
> > > >
> > > > > > > IMO the main value of +T is that it allows feeding existing p=
r_debugs
> > > > > > > into the place where other trace-data is already integrated a=
nd managed.
> > > > > > >
> > > > > > > At this point, I dont see any extra destination handling as p=
rudent.
> > > > > > >
> > > > > >
> > > > > >
> > > > > > I'm fine with either approach. I kind of like the creation of t=
he instance,
> > > > > > as that allows the user to keep this debug separate from other =
tracing
> > > > > > going on. We are starting to have multiple applications using t=
he tracing
> > > > > > buffer (although most are using instances, which is why I'm try=
ing to make
> > > > > > them lighter weight with the eventfs code).
> > > > > >
> > > > > > -- Steve
> > > > > >
> > > >
> > > > Steve, thanks for commenting from the trace perspective.
> > > >
> > > > >
> > > > >
> > > > > Ok Im starting to grasp that multiple instances are good
> > > > > (and wondering how I didnt notice)
> > > > >
> > > > > What doesnt thrill me is the new _ddebug field, it enlarges the f=
ootprint.
> > > > >
> > > >
> > > > Yes it increases _ddebug structure by a pointer size.
> > > >
> > > > > can you make it go away ?
> > > >
> > > > I implemented my proposal with flexibility in mind so that if someo=
ne
> > > > would like to add
> > > > another destination in the future it should be easy to do. I
> > > > understand that adding a pointer
> > > > to the _ddebug structure increases footprint size that's why I also
> > > > added CONFIG_DYNAMIC_DEBUG_DST
> > > > kernel configuration option in order to enable/disable this functio=
nality.
> > > >
> > > > > I have some thoughts ..
> > > >
> > > > Please share your thoughts. I'm sure we can come to an agreement ho=
w
> > > > to incorporate both +T and my proposal.
> > >
> > >
> > > So heres what Im thinking:
> > >
> > > shrink lineno, get 2-3 bits back.
> > > last I checked largest C file is <32kloc
> > > largest header is ~120kloc, but its a data only,
> > > no pr_debugs will suddenly appear there.
> > >
> > > define a dst_id field with 3 bits
> >
> > The dst_id field would be taken into account only when a callsite has
> > T flag set, is that your assumption ?
>
> Im ambivalent about the +T bit itself,
> it could as easily be another "special" value in the 0-2^N range of dst_i=
d
>
> its a use-case tradeoff:
> +T  goes to main tracebuf.
> dst_id>0  goes to separate, pre-registered "flight-recorder"  tracebufs
>
> I'm not sure whether doing both independently is better than having
> 2^(n-1)-1 extra bufs.
>
> Actually, demoting +T to just another dest makes sense -
> theres a large population of pr-debugs, and events like vblank-*
> Nobody will send vblank to syslog on purpose either.
>
>
> either way, dyndbg will need both:
> new trace-events, so that prdbgs can get enabled as a single/few event-ty=
pes
> trace_array_buf writes to flight recorders
>
>
>
>
>
>
>
> > Can one bit be taken from class_id to increase dst_id to 4 bits ?
> > Decreasing class_id length to 5 bits would still leave its range at
> > [0..31]
>
> 31 classes / categories should be enough.
> 64 was convenient, BIT* supported.
>
> > > 0 is for main tracebuf
> > > 1-7 is for other instances
> > >
> >
> > Do you want to leave trace events as originally implemented with +T fla=
g ?
> > If yes then I would like to propose:
> > dst_id =3D 0 - for trace events for pr_debug and dbg_dev logs (default)
> > dst_id =3D 1 - for default trace instance
> > dst_id > 1 - other trace instances
> >
> > > then the alt-dest lookup is avoided except when the dst_id field is >=
0
> > >
> > > It might work to put the alt-dst-pointer into the classmaps,
> > > so the destination is used for the entire group of debugs
> > > forex DRM_UT_CORE etc.
> > >
> >
> > If we store dst pointers for dst_id > 1 in classmaps then is there a fa=
st way
> > to get from callsite (_ddebug) to its corresponding classmap
> > (ddebug_class_map) in order to
> > lookup trace instance destination ?  I ask because I don't see it being=
 possible
> > without adding a new field to the _ddebug structure.
>
> I agree, theres no good enough way, compared to a small dst-id.
> The "muse" was on the grouping aspect it might bring.
>
> > > But its no better than the dst_id field, which is per-callsite,
> > > and entirely independent of classes.
> > >
> this was me agreeing with your point above :-)
>
>
> >
> > I don't have a real life use case to configure different trace
> > instance for each callsite.
> > I just tried to be as much flexible as possible.
> >
>
> Ive come around to agree - I looked back at some old threads
> (that I was a part of, and barely remembered :-}
>
> At least Sean Paul, Lyude, Simon Ser, Pekka Paalanen
> have expressed a desire for a "flight-recorder"
> it'd be hard to say now that 2-3 such buffers would always be enough,
> esp as theres a performance reason for having your own.
>
>
> > Thanks,
> > Lukasz
> >
> > >
> > > > Thanks,
> > > > Lukasz
