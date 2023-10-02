Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB9197B5C3E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 22:49:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236063AbjJBUtz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 16:49:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbjJBUtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 16:49:53 -0400
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36A10C6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 13:49:49 -0700 (PDT)
Received: by mail-ua1-x930.google.com with SMTP id a1e0cc1a2514c-7b07719089aso100841241.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 13:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696279788; x=1696884588; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qEKGPpeuD1Kd57c0En6sgAmrxNm3IkBGBJjLUxe3nH4=;
        b=XdlaneMjhLXFp7RtLHrglQkGnYdgcp3+aY7IGJ8AtFBgT0rpkdJWS+nZPkNhvqlGRc
         k424uXTdNx8l1xetYtaUaItZ1CH6xWp0e8OTEo5guTlH1D0BGuWvm9C4xXzEIASYjJ5M
         Qy56Micl4nmIwSBNs+64M4zBESzCuxqZGtofV46NWdJ5/zePjRRuQzLxil/Pex78XhdA
         WCWxxD3uL0lQC0wMiRUsxtI+IDxUgdVWv8lbD27ujDD7tXp1D6gNzVb023BM+XTdkUbk
         JlKvaZMuelTBjeIQ3mehco8+DWvQKbeBs4uC7clgd7O05Xu6wryKdBoNcQLU6LPEA0WD
         RnGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696279788; x=1696884588;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qEKGPpeuD1Kd57c0En6sgAmrxNm3IkBGBJjLUxe3nH4=;
        b=NJ0ZOK1Ewv/D4NFmDcPVDGVlzj/t5cr8s9TtREr1cWj5bbmnN/jUs0O1m5nSDFA5QE
         DieKK7PPWC3Il73olQrD1J8aPp9lim0wzr4uuk7ET3Mq4iW8afiNieeR5X/t6kE+JqGH
         RW+/uZCQE7/7Ol6qQf8W1ait8TIlR5Y0w36+scv24zyNlLYkBpUzlXp+9yn1prkWHhXq
         AP25ROwIi2gdqd6dBOjo1rqDi0cz7XM5yjS4VsC607ZBYKVFI+JYce5ZLJpJJim/Xlwf
         p0hastZtZZybnAR3iN3/IbEg+KuwlNTkOiHaP63VZlhrMohdHfP5ou42fpVSRf3Zxtw+
         b+3w==
X-Gm-Message-State: AOJu0YymbWeIIK+K+8JWvw0jVVkTngTlxkdRLt090E8MdnCxr3bmhsuh
        JZsB/GC7pcqi5wvavrKMmRjt7ghlKXAag1lPPDc=
X-Google-Smtp-Source: AGHT+IG6tcXUJ2WEYpxSeGeIuWu85o8i6O92JZ+f1hznY1Gn73e/c8sT/4ZIpHZqPiQVclfC6FdhCJan0OOf8NtKWNY=
X-Received: by 2002:a05:6122:d22:b0:49d:2a13:58fc with SMTP id
 az34-20020a0561220d2200b0049d2a1358fcmr396218vkb.2.1696279786758; Mon, 02 Oct
 2023 13:49:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230915154856.1896062-1-lb@semihalf.com> <CAJfuBxyFYyGCtr5i=P7N=1oX3J=jmdp1VLGLt+z1fAnuvGK2aA@mail.gmail.com>
 <CAK8ByeJBrPEQSgUc91LQO9Krzjh2pauhMTjEC82M8ozayE76Yg@mail.gmail.com>
In-Reply-To: <CAK8ByeJBrPEQSgUc91LQO9Krzjh2pauhMTjEC82M8ozayE76Yg@mail.gmail.com>
From:   jim.cromie@gmail.com
Date:   Mon, 2 Oct 2023 14:49:20 -0600
Message-ID: <CAJfuBxxmL-GtBgt=033F9UNeLCreFbJh3HrQQN2nYKwR_0uTbg@mail.gmail.com>
Subject: Re: [PATCH v1] dynamic_debug: add support for logs destination
To:     =?UTF-8?Q?=C5=81ukasz_Bartosik?= <lb@semihalf.com>
Cc:     Jason Baron <jbaron@akamai.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Guenter Roeck <groeck@google.com>,
        Yaniv Tzoreff <yanivt@google.com>,
        Benson Leung <bleung@google.com>, linux-kernel@vger.kernel.org,
        upstream@semihalf.com,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Steven Rostedt <rostedt@goodmis.org>
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

On Mon, Sep 18, 2023 at 1:20=E2=80=AFAM =C5=81ukasz Bartosik <lb@semihalf.c=
om> wrote:
>
> pt., 15 wrz 2023 o 20:02 <jim.cromie@gmail.com> napisa=C5=82(a):
> >
> > On Fri, Sep 15, 2023 at 9:49=E2=80=AFAM =C5=81ukasz Bartosik <lb@semiha=
lf.com> wrote:
> > >

hi Lukasz,

sorry my kernel-time has been in my own trees.

What I dont understand is why +T is insufficient.

IIUC, tracefs is intended for production use.
thats why each event can be enabled / disabled
- to select and minimize whats traced, and not impact the system

and +T  can forward all pr_debugs to trace,
(by 1-few trace events defined similarly to others)
or very few, giving yet another selection mechanism
to choose or eliminate specific pr-debugs and reduce traffic to
interesting stuff.

Once your debug is in the trace-buf,
shouldnt user-space be deciding what to do with it ?
a smart daemon could leverage tracefs to good effect.

IMO the main value of +T is that it allows feeding existing pr_debugs
into the place where other trace-data is already integrated and managed.

At this point, I dont see any extra destination handling as prudent.

Jim





> > > Add support for selection of dynamic debug logs destination.
> > > When enabled it allows to configure destination of each callsite
> > > individually. The option adds a framework (described by struct
> > > ddebug_dst_ops) which provides flexible means to add a new destinatio=
n
> > > for debug logs. On top of the framework support for trace instance as
> > > destination is added. By default destination of debug logs is syslog.
> > > Syslog can be set explicitly by using dst keyword or is selected by
> > > default when dst keyword is omitted, for example:
> >
> > A while back,
> > Cc: Vincent Whitchurch <vincent.whitchurch@axis.com>
> > proposed these patches:
> >       https://lore.kernel.org/lkml/20200825153338.17061-1-vincent.whitc=
hurch@axis.com/
> >
> > his approach adds a single flag, +x or (my pref) +T
> > which sends the pr_debug to tracefs, independent of +p.
> > Steve Rostedt offered feedback on one of the versions,
> > and one could read that as provisional acceptance.
> >
> > Ive worked his patchset since, it is here:
> > https://github.com/jimc/linux/tree/dd-trc-11
> > (it has some unrelated bits too)
> >
> > but it sits atop another patchset:
> > https://lore.kernel.org/lkml/20230911230838.14461-1-jim.cromie@gmail.co=
m/
> > or for git remote add
> > https://github.com/jimc/linux/tree/dd-fix-5i
> >
>
> I looked through the patches you pointed me to. The solution with
> +T/+x is elegant and tailored to specific needs.
> Our rationale to write pr_debug/dev_dbg logs to tracefs is similar to
> Vincent's to aid us in debugging.
> Unfortunately the solution with +T/+x does not cover our use case.
>
> Our use case is different. We experience issues reported by Chromebook
> users which are difficult to reproduce
> that's why we would like to enable debug logs to be written to tracefs
> on productions systems.
> When users experiences an issues and sends us a feedback report the
> debug logs written to tracefs would be
> attached to the feedback report. We would like to write debug logs to
> a separate trace instances based on
> the subsystem/driver. Our initial areas of interest/issues are usbcore
> and thunderbolt drivers/subsystems.
> More may come in the future.
>
> With my proposal this could be achieved for the thunderbolt subsystem
> with the following steps:
> * enable kernel configuration option CONFIG_DYNAMIC_DEBUG_CORE,
> * enable kernel configuration option DYNAMIC_DEBUG_DST and set its
>   operation mode to Static.
> * add the option to the thunderbolt's drivers/thunderbolt/Makefile
> in order to compile in debug logs:
>         CFLAGS_nhi.o :=3D -DDYNAMIC_DEBUG_MODULE
> * compile the kernel and update it on a target device,
> * finally append the entry to the kernel boot command line:
>         thunderbolt.dyndbg=3D"dst trace:thunderbolt =3Dp"
>
> Both the solutions (I mean +x/+T and mine proposal) have pros and cons.
> Maybe both could coexist together, +x/+T by default and this patch as
> configurable option
> which adds more flexibility ?
>
> >
> > syslog and/or tracefs seems sufficient, do you have a 3rd destination ?
> >
>
> I don't have a use case for the third destination, but for example
> adding socket destination to my proposal would be relatively fast and
> easy (that would be for limited use only after a network is up and
> running).
>
> Thanks,
> Lukasz
>
> > thanks
