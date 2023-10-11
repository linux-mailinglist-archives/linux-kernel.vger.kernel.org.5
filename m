Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 554227C55D9
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 15:48:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346931AbjJKNsH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 09:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234885AbjJKNsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 09:48:05 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BE6393
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 06:48:03 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-532c81b9adbso11920301a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 06:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google; t=1697032082; x=1697636882; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LqbWCFMQM1sd5S/h6JDyxaKWAY7r73x3RtWoFSTeKQw=;
        b=DtHbSLu/4AsBb/Ge+qFj4XDbK4sn4obpadSKkU7P55ypajIVYNmfwEs2xAOnoJDerE
         DSseCuAO4+ieSDoJhqpTojgY+jNpsRPzBP6eEdecSMyuhHvHlsEGoZMuu+HTpaBxmkpb
         feCKmAaCaNl+UMtYavQVT19PDUsFuNehj/K7S23d86PZESOXRIvwEHp92Hy9fgDR8/u+
         0Up2Z98kDaGmV5ZQknVil9ZuD9oJqKbYK4CWfUSUzjCzWnuZSjV9FPjQb5p45JhGKBjP
         ko3TFizrNP5Us6E51Sx9b1CzXsQkOtONKVNS+EQZxcnKiFVhskkk0bCgu66/zQUpyGsm
         dYcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697032082; x=1697636882;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LqbWCFMQM1sd5S/h6JDyxaKWAY7r73x3RtWoFSTeKQw=;
        b=OS+AqcjEsT7pZtRuY61JfZ+hitqgE+kNOrttjekb5k5THNCgaYVc+pN/K2iqxc4LaC
         +YW/+hIZv2hLHu9m3kp8wF8EeW2kSDm4LLsVrio/7nRPSWW3anKVZoszxv5iciUlP2yw
         uQIRKm7TTNtPusyMSVW/03bQ2jy9oCfkRk+/Qu/9G/QarKXHUQnVOO1l2qyDOEnMIPK7
         rnqIi5Km2mA25C8LKOD95bHcQivr3TQUpYHDqv3rWCJ1/k5xAqVve93AxYl7hBME3yZp
         ob9Q+gGbTm408AbnrY+F3fw8OHbsrsY5obFanFQup0eWWg4LhZxrXYncaoeF4Vogu5Y2
         Rqpw==
X-Gm-Message-State: AOJu0YzFyGIJFjTnJqsLQc2HucLcwLqYhdSulTXwW7R0WCh2pIGb+Xhd
        I9RutJPdvp/pPVCss6JG+2aQkdEUGTd7nGw+FUe/
X-Google-Smtp-Source: AGHT+IHgNbHEOcpAurjKaSZSMx1mMOE4z+0oe+eCAe1sieumbxs8ZeClfi5UXhL+lvQcimRHod92q3Ly3qPCFqSvjnM=
X-Received: by 2002:a05:6402:d53:b0:53d:aa7b:527 with SMTP id
 ec19-20020a0564020d5300b0053daa7b0527mr3092605edb.32.1697032081886; Wed, 11
 Oct 2023 06:48:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230915154856.1896062-1-lb@semihalf.com> <CAJfuBxyFYyGCtr5i=P7N=1oX3J=jmdp1VLGLt+z1fAnuvGK2aA@mail.gmail.com>
 <CAK8ByeJBrPEQSgUc91LQO9Krzjh2pauhMTjEC82M8ozayE76Yg@mail.gmail.com>
 <CAJfuBxxmL-GtBgt=033F9UNeLCreFbJh3HrQQN2nYKwR_0uTbg@mail.gmail.com>
 <20231003155810.6df9de16@gandalf.local.home> <CAJfuBxyJyFbFEhRxrtxJ_RazaTODV6Gg64b1aiNEzt6_iE4=Og@mail.gmail.com>
 <CAK8ByeLNc9UbTNG4x=40AxYqjjRCsvBNtNFai0PMveM2X4XCow@mail.gmail.com>
 <CAJfuBxyRF4q_T8LmHwR=-PKKDDpiFg2nO03uLnL8aGpRyBByKw@mail.gmail.com>
 <CAK8ByeLpkSV6o6gPw8eJVqq5+ynQrSDjemY7mXkO1ZmA0rYKfQ@mail.gmail.com> <CAJfuBxw+ANLwssAGWpkn5PeJb8ZKn4LXQkk2Gfv3aGsSN=S55Q@mail.gmail.com>
In-Reply-To: <CAJfuBxw+ANLwssAGWpkn5PeJb8ZKn4LXQkk2Gfv3aGsSN=S55Q@mail.gmail.com>
From:   =?UTF-8?Q?=C5=81ukasz_Bartosik?= <lb@semihalf.com>
Date:   Wed, 11 Oct 2023 15:47:50 +0200
Message-ID: <CAK8ByeJLeoi3DfP5v6x7whcmuz22nuirS5iGf44wHDiORNbpFA@mail.gmail.com>
Subject: Re: [PATCH v1] dynamic_debug: add support for logs destination
To:     jim.cromie@gmail.com
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Jason Baron <jbaron@akamai.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Guenter Roeck <groeck@google.com>,
        Yaniv Tzoreff <yanivt@google.com>,
        Benson Leung <bleung@google.com>, linux-kernel@vger.kernel.org,
        upstream@semihalf.com,
        Vincent Whitchurch <vincent.whitchurch@axis.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wt., 10 pa=C5=BA 2023 o 18:02 <jim.cromie@gmail.com> napisa=C5=82(a):
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

Even though having +T seems more consistent I would prefer to combine
it with dst_id
because it will give us wider range.

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

Then depending on the value of dst_id (assuming dst_id consumed +T and
one more bit from class_id)  we would have:
dst_id =3D 0 - trace disabled
dst_id =3D 1 - trace events for pr_debug and dev_dbg
dst_id =3D [2..31] - predefined trace instances

The trace instance destinations will be global but this number seems
pretty reasonable and is sufficient from our use case perspective.

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

I see :)

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

What would you recommend to base continuation of development of this featur=
e on,
I mean whether to use one of your private branches you mentioned (in
one of the previous replies)
or latest upstream ?

>
> > Thanks,
> > Lukasz
> >
> > >
> > > > Thanks,
> > > > Lukasz
