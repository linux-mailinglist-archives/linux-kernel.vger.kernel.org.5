Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84AEE7BEE6F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 00:47:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378233AbjJIWrg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 18:47:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231434AbjJIWre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 18:47:34 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2967E9D
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 15:47:33 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-532c81b9adbso8807643a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 15:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google; t=1696891651; x=1697496451; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gCL0ZzsVSPq0hYFWig/UWoVeKTAt3kP1u7QGnx4seIM=;
        b=BQW7u0d7NKQKdj0qqNuHSMsPkQNUv1T3/xBwWFxNYegt2orno4G//oT2gc8VM9bLr2
         yZYaZ+Tr/2qDah9oap1c5zeQPwD57VK+jXp7GqaSKaa2cYCaWpLXRFI6kBy1FwBJajrb
         bNBaGz9i3i9eWBDNoLuQoB1GUSX+aCWGGP1PTzgXb4TrJYCxecK7RX46O//nbgWTdsP3
         oGWuQ1WAoOv8LJHIduIoSkH9Z3LziCAriFWuWF6M/VLSzv65eLs0pAPH9Rdl7KfyzzmM
         R73xwUrIgwOKtxdPt7Aj1lEHnOIgIxBsFjl/So0tj8nKWdzqhw6CJMlKtgoz2pRyWyqs
         cAWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696891651; x=1697496451;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gCL0ZzsVSPq0hYFWig/UWoVeKTAt3kP1u7QGnx4seIM=;
        b=gOefvQ1yVrW3g2KBQnb7lWSFUzYVEqkyvS1qDL35dAfT9fnP1NAHIoRv3J9jVLnwCT
         0H2QRO0laoFH7KeZ0K5sZTf3wfJ1Jo3T8/IAEA4QvqGG8fZQzTzbbRFWodXJlkCux2PT
         ySVv3FaF/bR6F3iq12dAZHJGUXEU95qazpNHOrWa0x8d4ML0KlsweHacYOmE5S5kMcXQ
         4Ewsucj3v47mF4CEmqQrwXdKMTIGWHYOL/1r/0aZDSuqd/hgNtLVzGv92EZ5A1AvQQHU
         QA8mLRxBkbREmV4nzidXHar6Aq0bQJOKGaHdFT6mGlysOoR2hzr/dX5gFUiBg5gKz99m
         SG/A==
X-Gm-Message-State: AOJu0YyBRAdBgzXMM0lf9DRZccZR2EgelLsZS7UYnl58KiMFpJvH0jwT
        dRnaMcOk+96nUg2PIMe6heR86tz5nAth+neuRlnU
X-Google-Smtp-Source: AGHT+IHmDUk2qmwOXsd8TWy6n2mlECCpmhUf6DQd3osKxHJS+OCKV6feHXIwvAw/r07cpeB9iI6nkykO1Ag1dIdoQTo=
X-Received: by 2002:aa7:d846:0:b0:533:12b1:ebe7 with SMTP id
 f6-20020aa7d846000000b0053312b1ebe7mr14941167eds.15.1696891650958; Mon, 09
 Oct 2023 15:47:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230915154856.1896062-1-lb@semihalf.com> <CAJfuBxyFYyGCtr5i=P7N=1oX3J=jmdp1VLGLt+z1fAnuvGK2aA@mail.gmail.com>
 <CAK8ByeJBrPEQSgUc91LQO9Krzjh2pauhMTjEC82M8ozayE76Yg@mail.gmail.com>
 <CAJfuBxxmL-GtBgt=033F9UNeLCreFbJh3HrQQN2nYKwR_0uTbg@mail.gmail.com>
 <20231003155810.6df9de16@gandalf.local.home> <CAJfuBxyJyFbFEhRxrtxJ_RazaTODV6Gg64b1aiNEzt6_iE4=Og@mail.gmail.com>
 <CAK8ByeLNc9UbTNG4x=40AxYqjjRCsvBNtNFai0PMveM2X4XCow@mail.gmail.com> <CAJfuBxyRF4q_T8LmHwR=-PKKDDpiFg2nO03uLnL8aGpRyBByKw@mail.gmail.com>
In-Reply-To: <CAJfuBxyRF4q_T8LmHwR=-PKKDDpiFg2nO03uLnL8aGpRyBByKw@mail.gmail.com>
From:   =?UTF-8?Q?=C5=81ukasz_Bartosik?= <lb@semihalf.com>
Date:   Tue, 10 Oct 2023 00:47:19 +0200
Message-ID: <CAK8ByeLpkSV6o6gPw8eJVqq5+ynQrSDjemY7mXkO1ZmA0rYKfQ@mail.gmail.com>
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
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pt., 6 pa=C5=BA 2023 o 22:49 <jim.cromie@gmail.com> napisa=C5=82(a):
>
> On Wed, Oct 4, 2023 at 4:55=E2=80=AFAM =C5=81ukasz Bartosik <lb@semihalf.=
com> wrote:
> >
> > wt., 3 pa=C5=BA 2023 o 22:54 <jim.cromie@gmail.com> napisa=C5=82(a):
> > >
> > > On Tue, Oct 3, 2023 at 1:57=E2=80=AFPM Steven Rostedt <rostedt@goodmi=
s.org> wrote:
> > > >
> > > > On Mon, 2 Oct 2023 14:49:20 -0600
> > > > jim.cromie@gmail.com wrote:
> > > >
> > > > > hi Lukasz,
> > > > >
> > > > > sorry my kernel-time has been in my own trees.
> > > > >
> > > > > What I dont understand is why +T is insufficient.
> > > > >
> >
> > We would like to be able to separate debug logs from different
> > subsystem (e.g. thunderbolt and usbcore).
> > With +T it is not possible because all debug logs will land in the same=
 bucket.
> >
> > > > > IIUC, tracefs is intended for production use.
> > > > > thats why each event can be enabled / disabled
> > > > > - to select and minimize whats traced, and not impact the system
> > > > >
> > > > > and +T  can forward all pr_debugs to trace,
> > > > > (by 1-few trace events defined similarly to others)
> > > > > or very few, giving yet another selection mechanism
> > > > > to choose or eliminate specific pr-debugs and reduce traffic to
> > > > > interesting stuff.
> > > > >
> > > > > Once your debug is in the trace-buf,
> > > > > shouldnt user-space be deciding what to do with it ?
> > > > > a smart daemon could leverage tracefs to good effect.
> > > > >
> >
> > Yes, a daemon could separate the debug logs but IMHO it is much
> > easier to separate logs by sending them directly from a given subsystem
> > to a separate trace instance. My proposal allows to configure different
> > trace instance as destination for each callsite.
> >
> > > > > IMO the main value of +T is that it allows feeding existing pr_de=
bugs
> > > > > into the place where other trace-data is already integrated and m=
anaged.
> > > > >
> > > > > At this point, I dont see any extra destination handling as prude=
nt.
> > > > >
> > > >
> > > >
> > > > I'm fine with either approach. I kind of like the creation of the i=
nstance,
> > > > as that allows the user to keep this debug separate from other trac=
ing
> > > > going on. We are starting to have multiple applications using the t=
racing
> > > > buffer (although most are using instances, which is why I'm trying =
to make
> > > > them lighter weight with the eventfs code).
> > > >
> > > > -- Steve
> > > >
> >
> > Steve, thanks for commenting from the trace perspective.
> >
> > >
> > >
> > > Ok Im starting to grasp that multiple instances are good
> > > (and wondering how I didnt notice)
> > >
> > > What doesnt thrill me is the new _ddebug field, it enlarges the footp=
rint.
> > >
> >
> > Yes it increases _ddebug structure by a pointer size.
> >
> > > can you make it go away ?
> >
> > I implemented my proposal with flexibility in mind so that if someone
> > would like to add
> > another destination in the future it should be easy to do. I
> > understand that adding a pointer
> > to the _ddebug structure increases footprint size that's why I also
> > added CONFIG_DYNAMIC_DEBUG_DST
> > kernel configuration option in order to enable/disable this functionali=
ty.
> >
> > > I have some thoughts ..
> >
> > Please share your thoughts. I'm sure we can come to an agreement how
> > to incorporate both +T and my proposal.
>
>
> So heres what Im thinking:
>
> shrink lineno, get 2-3 bits back.
> last I checked largest C file is <32kloc
> largest header is ~120kloc, but its a data only,
> no pr_debugs will suddenly appear there.
>
> define a dst_id field with 3 bits

The dst_id field would be taken into account only when a callsite has
T flag set, is that your assumption ?
Can one bit be taken from class_id to increase dst_id to 4 bits ?
Decreasing class_id length to 5 bits would still leave its range at
[0..31]

> 0 is for main tracebuf
> 1-7 is for other instances
>

Do you want to leave trace events as originally implemented with +T flag ?
If yes then I would like to propose:
dst_id =3D 0 - for trace events for pr_debug and dbg_dev logs (default)
dst_id =3D 1 - for default trace instance
dst_id > 1 - other trace instances

> then the alt-dest lookup is avoided except when the dst_id field is >0
>
> It might work to put the alt-dst-pointer into the classmaps,
> so the destination is used for the entire group of debugs
> forex DRM_UT_CORE etc.
>

If we store dst pointers for dst_id > 1 in classmaps then is there a fast w=
ay
to get from callsite (_ddebug) to its corresponding classmap
(ddebug_class_map) in order to
lookup trace instance destination ?  I ask because I don't see it being pos=
sible
without adding a new field to the _ddebug structure.

> But its no better than the dst_id field, which is per-callsite,
> and entirely independent of classes.
>

I don't have a real life use case to configure different trace
instance for each callsite.
I just tried to be as much flexible as possible.

Thanks,
Lukasz

>
> > Thanks,
> > Lukasz
