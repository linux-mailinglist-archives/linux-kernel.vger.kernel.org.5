Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D9EE7BC0BB
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 22:50:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233597AbjJFUt6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 16:49:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233558AbjJFUt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 16:49:57 -0400
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F2B2C2
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 13:49:55 -0700 (PDT)
Received: by mail-vs1-xe31.google.com with SMTP id ada2fe7eead31-45271a44cc4so1170132137.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 Oct 2023 13:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696625394; x=1697230194; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/HWI3D+cCfI1nobgtFE3STx3AOmEXU67GbLWlT3pGGA=;
        b=cJkyxAiNRUxD4Weq6e2Ddh4s4cfPS14GZOkMe1Jcl1nF0KiJaqqhdOkQ+t9pCb/mXu
         xem+Gile5ukZOAD7V0TUILn3QCpITNsLWlvEuPSFkacTviYhcq0eype7sRhA1IbiAFsY
         jm1ezHxMJN91rDbyDGykoZ97hvA5fBSi46fD66gaTH+K3Ez4PCkU5AQxLObqnzS34jGP
         YH/ULATqL8YSVXJiCfScCkp3Ir/crG1OTCjTw23WsvyzVwbg7oKBu+PlyF/geRUhZ10G
         jjCkG5InWIN0p6vNTILP7MmQwk/yi4ZV/6cDaQJoiHUS8mn4fyVS3qTGCGIi8HOjr3i2
         paxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696625394; x=1697230194;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/HWI3D+cCfI1nobgtFE3STx3AOmEXU67GbLWlT3pGGA=;
        b=RFKSxKsigmIfiXJpHjA4xjznwwa1uN24AbRPPKzAh0TAz0KJSsVXzQHZolwQJ28QuK
         IWIJ+ybwviJf75xpnolNXYXiJD4aWAoY1XLYeUDWWlul7afNWV4gAQEBbct7XsPyvUv8
         ysbWi6JH9Wfh0Pb7adQYOm1lJuVp6sQCr77VT+tOhYOYIcC8c7aDjpzkUBHFbS/4I0gd
         FtntIiUoINychds6H8IU+2lVRwGKk0aZvziEsPOJRvlSevFm1P8PvqdDNrJ31jQDp5s7
         ebIsv16/1fuwTyD+TKWSkrjls56lMYn1kWMy6WnqCpqy2tID+ckgvCF0Jh0OT6qhwcyJ
         x3Rg==
X-Gm-Message-State: AOJu0YxcGBXYL4Q9pNmxZPt3AXu6Rz//4NjOQFA+HgGcgjCmMxKE3oFF
        tZILSPazz32DSgZYGmO18hrXVPK0i9pZPuoz1yc=
X-Google-Smtp-Source: AGHT+IGminUwO9UPa3NNaqo+wu0syTyw570c9q7wWXH8fbgyqc4J9vkxUSPQd1L3HbAWYyl97ty5O+COShc7cd5Pcqo=
X-Received: by 2002:a67:f44a:0:b0:452:5798:64bc with SMTP id
 r10-20020a67f44a000000b00452579864bcmr10608075vsn.6.1696625394185; Fri, 06
 Oct 2023 13:49:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230915154856.1896062-1-lb@semihalf.com> <CAJfuBxyFYyGCtr5i=P7N=1oX3J=jmdp1VLGLt+z1fAnuvGK2aA@mail.gmail.com>
 <CAK8ByeJBrPEQSgUc91LQO9Krzjh2pauhMTjEC82M8ozayE76Yg@mail.gmail.com>
 <CAJfuBxxmL-GtBgt=033F9UNeLCreFbJh3HrQQN2nYKwR_0uTbg@mail.gmail.com>
 <20231003155810.6df9de16@gandalf.local.home> <CAJfuBxyJyFbFEhRxrtxJ_RazaTODV6Gg64b1aiNEzt6_iE4=Og@mail.gmail.com>
 <CAK8ByeLNc9UbTNG4x=40AxYqjjRCsvBNtNFai0PMveM2X4XCow@mail.gmail.com>
In-Reply-To: <CAK8ByeLNc9UbTNG4x=40AxYqjjRCsvBNtNFai0PMveM2X4XCow@mail.gmail.com>
From:   jim.cromie@gmail.com
Date:   Fri, 6 Oct 2023 14:49:27 -0600
Message-ID: <CAJfuBxyRF4q_T8LmHwR=-PKKDDpiFg2nO03uLnL8aGpRyBByKw@mail.gmail.com>
Subject: Re: [PATCH v1] dynamic_debug: add support for logs destination
To:     =?UTF-8?Q?=C5=81ukasz_Bartosik?= <lb@semihalf.com>
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
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 4, 2023 at 4:55=E2=80=AFAM =C5=81ukasz Bartosik <lb@semihalf.co=
m> wrote:
>
> wt., 3 pa=C5=BA 2023 o 22:54 <jim.cromie@gmail.com> napisa=C5=82(a):
> >
> > On Tue, Oct 3, 2023 at 1:57=E2=80=AFPM Steven Rostedt <rostedt@goodmis.=
org> wrote:
> > >
> > > On Mon, 2 Oct 2023 14:49:20 -0600
> > > jim.cromie@gmail.com wrote:
> > >
> > > > hi Lukasz,
> > > >
> > > > sorry my kernel-time has been in my own trees.
> > > >
> > > > What I dont understand is why +T is insufficient.
> > > >
>
> We would like to be able to separate debug logs from different
> subsystem (e.g. thunderbolt and usbcore).
> With +T it is not possible because all debug logs will land in the same b=
ucket.
>
> > > > IIUC, tracefs is intended for production use.
> > > > thats why each event can be enabled / disabled
> > > > - to select and minimize whats traced, and not impact the system
> > > >
> > > > and +T  can forward all pr_debugs to trace,
> > > > (by 1-few trace events defined similarly to others)
> > > > or very few, giving yet another selection mechanism
> > > > to choose or eliminate specific pr-debugs and reduce traffic to
> > > > interesting stuff.
> > > >
> > > > Once your debug is in the trace-buf,
> > > > shouldnt user-space be deciding what to do with it ?
> > > > a smart daemon could leverage tracefs to good effect.
> > > >
>
> Yes, a daemon could separate the debug logs but IMHO it is much
> easier to separate logs by sending them directly from a given subsystem
> to a separate trace instance. My proposal allows to configure different
> trace instance as destination for each callsite.
>
> > > > IMO the main value of +T is that it allows feeding existing pr_debu=
gs
> > > > into the place where other trace-data is already integrated and man=
aged.
> > > >
> > > > At this point, I dont see any extra destination handling as prudent=
.
> > > >
> > >
> > >
> > > I'm fine with either approach. I kind of like the creation of the ins=
tance,
> > > as that allows the user to keep this debug separate from other tracin=
g
> > > going on. We are starting to have multiple applications using the tra=
cing
> > > buffer (although most are using instances, which is why I'm trying to=
 make
> > > them lighter weight with the eventfs code).
> > >
> > > -- Steve
> > >
>
> Steve, thanks for commenting from the trace perspective.
>
> >
> >
> > Ok Im starting to grasp that multiple instances are good
> > (and wondering how I didnt notice)
> >
> > What doesnt thrill me is the new _ddebug field, it enlarges the footpri=
nt.
> >
>
> Yes it increases _ddebug structure by a pointer size.
>
> > can you make it go away ?
>
> I implemented my proposal with flexibility in mind so that if someone
> would like to add
> another destination in the future it should be easy to do. I
> understand that adding a pointer
> to the _ddebug structure increases footprint size that's why I also
> added CONFIG_DYNAMIC_DEBUG_DST
> kernel configuration option in order to enable/disable this functionality=
.
>
> > I have some thoughts ..
>
> Please share your thoughts. I'm sure we can come to an agreement how
> to incorporate both +T and my proposal.


So heres what Im thinking:

shrink lineno, get 2-3 bits back.
last I checked largest C file is <32kloc
largest header is ~120kloc, but its a data only,
no pr_debugs will suddenly appear there.

define a dst_id field with 3 bits
0 is for main tracebuf
1-7 is for other instances

then the alt-dest lookup is avoided except when the dst_id field is >0

It might work to put the alt-dst-pointer into the classmaps,
so the destination is used for the entire group of debugs
forex DRM_UT_CORE etc.

But its no better than the dst_id field, which is per-callsite,
and entirely independent of classes.


> Thanks,
> Lukasz
