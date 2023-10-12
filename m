Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 305667C77F2
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 22:37:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442778AbjJLUhw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 16:37:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442277AbjJLUhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 16:37:50 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 436B5CC;
        Thu, 12 Oct 2023 13:37:48 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-53da72739c3so2421810a12.3;
        Thu, 12 Oct 2023 13:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697143067; x=1697747867; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=80t0/kTAWVKp6hRA+jVPLbz5zbjrQ94G/Dx+h2A/uyY=;
        b=I3pN+xPgyxKtzS1YaG5sSQi6VS++T052KoO6ddEWDLbaDJvWiq2ZUbsFFTR7+5FYx/
         7EY6XhWXhUXt5CWjYPqjXRiBcVOGcaNL+OBhe6bM1ggzKPzaGlwWTqsBH8H3wD0GZhVf
         AYPEVAoyt5/VqZRgTLVKPtoYJnESenuNXpa9lpT0k3zjuOhGYMyTlbzFezPmVsdx144t
         5ux06E6D26jAooEK9y57EU9vj4u5NT5fX2yWL1eSzptsvFNWI6YST9qI8S/mSfWbxbH7
         Lr5/yK6n+i1vFlU7LuRbY4oohANpswKA5ABmgLguPlvtcRFLtIYecwTMy0QS9s9bSM8O
         lvIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697143067; x=1697747867;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=80t0/kTAWVKp6hRA+jVPLbz5zbjrQ94G/Dx+h2A/uyY=;
        b=WDblSqbUdRS+HBCztXvKnAXGk7HK/oIN4x8GsO7WO3pxZzU6/sEcCwnALDIPM+AsQe
         VLfDL6bp6WG15a/B0PpKJ24xjTEkzb1z03/w/3qx8XDOt8I7SbYZbyB1BfawWWmN6P/C
         I0zpmyBfwMOvmbkUAMoAlF7Fu055dfKcGd92IfJZnidR2rG+7WfRFt4n/xOtc8N5VZtz
         OQMQwx+spn3OIGvoAY8BNG2W5kfkytBe5uj1XFgu/5JH8x67cl9WZ5WDvkoOLig6lVb7
         Ipk5yhLdSKPJzWO4nI6Qy3tIygZlmxRX2Ux7/vqrXY4Pj9ANO4kwV8boLKjBtmj+CU3y
         RWNQ==
X-Gm-Message-State: AOJu0Yyq7o77pwh40O48bIJJRNisX7wcaD0/arOYSuBpfoFkmgJvz+cU
        61QaX4vlj+KX/YQ8ljGKziepUltC2fAvbGGKMTE=
X-Google-Smtp-Source: AGHT+IGRhD1uQeuJerO/5llKJCWL2LTviOlu4QQsWeXWdsWAU1y/qnMualk1RmDiaMJqhLNoG1+EFWiogmyYQAmJeio=
X-Received: by 2002:a05:6402:26d1:b0:53d:ec2d:3ee5 with SMTP id
 x17-20020a05640226d100b0053dec2d3ee5mr5246254edd.32.1697143066334; Thu, 12
 Oct 2023 13:37:46 -0700 (PDT)
MIME-Version: 1.0
References: <20231002144149.1325-1-Nicholas.Lowell@gmail.com>
 <20231003223003.675bd888@gandalf.local.home> <CAFEqNJ2=rt5KaDaAah1t8gGbLViW7VZEDq+81drvuWUz4CKR2w@mail.gmail.com>
 <20231004105339.5f948a96@gandalf.local.home>
In-Reply-To: <20231004105339.5f948a96@gandalf.local.home>
From:   Nick Lowell <nicholas.lowell@gmail.com>
Date:   Thu, 12 Oct 2023 16:37:35 -0400
Message-ID: <CAFEqNJ3PE6_u-q41Jw=-p7PrNBLT0Lr_n87WiY_2UctOJrDmZA@mail.gmail.com>
Subject: Re: [PATCH v2] trace: tracing_event_filter: fast path when no
 subsystem filters
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org,
        Nicholas Lowell <nlowell@lexmark.com>
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

On Wed, Oct 4, 2023 at 10:52=E2=80=AFAM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> On Wed, 4 Oct 2023 10:39:33 -0400
> Nick Lowell <nicholas.lowell@gmail.com> wrote:
>
> > > ------------[ cut here ]------------
> > >  WARNING: CPU: 5 PID: 944 at kernel/trace/trace_events_filter.c:2423 =
apply_subsystem_event_filter+0x18c/0x5e0
> > >  Modules linked in:
> > >  CPU: 5 PID: 944 Comm: trace-cmd Not tainted 6.6.0-rc4-test-00009-gff=
7cd7446fe5 #102
> > >  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debi=
an-1.16.2-1 04/01/2014
> > >  RIP: 0010:apply_subsystem_event_filter+0x18c/0x5e0
> > >  Code: 44 24 08 00 00 00 00 48 8b 6d 00 4c 39 f5 75 bc 48 8b 44 24 18=
 4c 8b 60 18 4c 89 e5 45 84 ff 75 14 48 85 ed 0f 84 37 ff ff ff <0f> 0b eb =
10 e8 4b be fd ff eb b0 4d 85 e4 0f 84 a3 02 00 00 48 8b
> > >  RSP: 0018:ffff9b4941607db8 EFLAGS: 00010286
> > >  RAX: ffff8b2780a77280 RBX: ffff8b2780a77400 RCX: 0000000000000000
> > >  RDX: 0000000000000000 RSI: ffff8b2781c11c38 RDI: ffff8b2781c11c38
> > >  RBP: ffff8b28df449030 R08: ffff8b2781c11c38 R09: 0000000000000000
> > >  R10: ffff8b2781c11c38 R11: 0000000000000000 R12: ffff8b28df449030
> > >  R13: ffffffffaaf64de0 R14: ffffffffaaf66bb8 R15: 0000000000000000
> > >  FS:  00007fd221def3c0(0000) GS:ffff8b28f7d40000(0000) knlGS:00000000=
00000000
> > >  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > >  CR2: 000056117c93e160 CR3: 000000010173a003 CR4: 0000000000170ee0
> > >  Call Trace:
> > >   <TASK>
> > >   ? apply_subsystem_event_filter+0x18c/0x5e0
> > >   ? __warn+0x81/0x130
> > >   ? apply_subsystem_event_filter+0x18c/0x5e0
> > >   ? report_bug+0x191/0x1c0
> > >   ? handle_bug+0x3c/0x80
> > >   ? exc_invalid_op+0x17/0x70
> > >   ? asm_exc_invalid_op+0x1a/0x20
> > >   ? apply_subsystem_event_filter+0x18c/0x5e0
> > >   ? apply_subsystem_event_filter+0x5b/0x5e0
> > >   ? __check_object_size+0x25b/0x2c0
> > >   subsystem_filter_write+0x41/0x70
> > >   vfs_write+0xf2/0x440
> > >   ? kmem_cache_free+0x22/0x350
> > >   ksys_write+0x6f/0xf0
> > >   do_syscall_64+0x3f/0xc0
> > >   entry_SYSCALL_64_after_hwframe+0x6e/0xd8
> > >  RIP: 0033:0x7fd221ee7ae0
> > >
> > > -- Steve
> >
> > Is this just informative indicating that there are issues with how
> > filters are being used or are you saying there is something else I
> > need to do before this patch is approved?
> > What version of trace-cmd is that using?
>
> Not sure if it matters, but the above was with trace-cmd v3.2.
>
> So, I guess we need to look a bit deeper at the change.
>
> > @@ -2411,7 +2418,12 @@ int apply_subsystem_event_filter(struct trace_su=
bsystem_dir *dir,
> >       }
> >
> >       if (!strcmp(strstrip(filter_string), "0")) {
> > -             filter_free_subsystem_preds(dir, tr);
> > +             /* If nothing was freed, we do not need to sync */
> > +             if (!filter_free_subsystem_preds(dir, tr)) {
> > +                     if(!(WARN_ON_ONCE(system->filter)))
> > +                             goto out_unlock;
>
> When do we want to skip the below?
>
> The original version just did the "goto out_unlock" before the
> "system->filter" check, and that would have caused a memory leak, or just
> left the "system->filter" around when unneeded.
>
> In other words, the patch is incorrect in general then.
>
> > +             }
> > +
> >               remove_filter_string(system->filter);
> >               filter =3D system->filter;
> >               system->filter =3D NULL;
>
> I believe, what you really want here is simply:
>
>         bool sync;
>
>         [..]
>
>         if (!strcmp(strstrip(filter_string), "0")) {
> +               sync =3D filter_free_subsystem_preds(dir, tr);
>                 remove_filter_string(system->filter);
>                 filter =3D system->filter;
>                 system->filter =3D NULL;
> -               /* Ensure all filters are no longer used */
> -               tracepoint_synchronize_unregister();
> +               if (sync) {
> +                       /* Ensure all filters are no longer used */
> +                       tracepoint_synchronize_unregister();
> +               }
>                 filter_free_subsystem_filters(dir, tr);
>

I really appreciate the continued feedback.  I was able to reproduce.
I think I'm understanding better but still need some help.
I am actually wondering if remove_filter_string(system->filter) should
also return bool as an OR'd input for sync.
Should it be something like this?

        if (!strcmp(strstrip(filter_string), "0")) {
-               filter_free_subsystem_preds(dir, tr);
-               remove_filter_string(system->filter);
+              bool sync;
+
+              sync =3D filter_free_subsystem_preds(dir, tr);
+              sync =3D sync || remove_filter_string(system->filter);
                filter =3D system->filter;
                system->filter =3D NULL;
-               /* Ensure all filters are no longer used */
-               tracepoint_synchronize_unregister();
+              /* If nothing was freed, we do not need to sync */
+              if(sync) {
+                      /* Ensure all filters are no longer used */
+                      tracepoint_synchronize_unregister();
+              }
                filter_free_subsystem_filters(dir, tr);
                __free_filter(filter);
                goto out_unlock;

> Maybe even pass in "sync" to the filter_free_subsystem_filters() to make
> sure there were nothing to be freed, and do the WARN_ON_ONCE() then.
>
>                 __free_filter(filter);
>                 goto out_unlock;
>         }
>
> -- Steve

I'm not sure if I see the reasoning for the WARN_ON_ONCE() in
filter_free_subsystem_filters()
because it ends up checking the same if(!filter) just like
filter_free_subsystem_preds() did earlier. It doesn't
seem to do anything with system->filter.  I actually wonder if !sync,
could filter_free_subsystem_filters()
be skipped altogether.  Help me if I'm missing something.

Thanks again,
Nick
