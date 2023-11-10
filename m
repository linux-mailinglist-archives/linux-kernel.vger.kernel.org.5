Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C0427E83C6
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 21:31:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235416AbjKJUbc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 15:31:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235293AbjKJUb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 15:31:28 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B6EC39CF9
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 06:53:18 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-53de0d1dc46so3658251a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 06:53:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google; t=1699627997; x=1700232797; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WMK65tnvwDP0fGwFYzppr4Q02eSPcHCiyzKtBG2lGR4=;
        b=dJHO0Sv+5AL7QC01smRdnnMPO49GYMbXS0ku9L1dEJVX6ANRt2V507DFq1aCZLv4mz
         SLYJctpkyUQhMZ2WkKf0xneHs22HU/b0wBbHzDXffPd0IOeixmZll3bidk96YsTJX7vw
         NGGdZUUlH2oehODByL0+ojprICJZSQQ6LHcjn7Kxc5ZaSaoAFV4RQkuDlVrkqGWP7WhG
         MDuu5c/XSO9Ax2x8fufbBrt+/6e1+y/d7WmpXRC5+DnYdsr2hirPrFSyA7Zrn2wjjKIc
         9rN69uOi1PCJQJ9AMLaeW5MN5t3B9F6/LC9bYg3VuJ2aq9tynMXjdRKAFVBksOCmiYqO
         ZU1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699627997; x=1700232797;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WMK65tnvwDP0fGwFYzppr4Q02eSPcHCiyzKtBG2lGR4=;
        b=rRBjvW0zKLsU6bSrUrhE6tU66LT6AUQTY/d6mmuiv+7X4kVfpedHoIThdfyuxsWOr6
         SDmVbli4Q9/Yunsdt+N9QbRCaI3pSP3WY0CJsAn+lLwj/MGmU6JxOx4du1ynT6UDM5Bt
         QZ3+T8uV7rY6u5JRnHzWsAChWUKKrowFacNFp9n78ulQEeVRCXkMEt+HVrLargaB9R5p
         EXgaTOBbMm7sD1j+Ltd0bBYA5HvTou0rO4uRp7WvvpoOrMlKphfYu6k8ntDqTlei8jy2
         he1HszNVYmL+TAnzoQtFbwAOnOQdkkYsJsLyy5eVRjTr0jDNpJUtwQqPjZKobTDOFI8D
         FS4Q==
X-Gm-Message-State: AOJu0YzYtz5FoCHCbzb6Sb9n8nWFrgJ2zmwt9AAmoOm7oZy8CCEejEQV
        bpZcNgkSyiGs5pfNqkISShmGSWA12qDVC2bv5tjG
X-Google-Smtp-Source: AGHT+IEwixevb7GqE6uUTaNctJtQM1GBdCmj/O3HspG+YB/hQ5qPX7etM5NiUHLStlsNiB8SNBecFLcN2azHSc7WOtM=
X-Received: by 2002:a50:8d12:0:b0:53e:8e2e:2b8f with SMTP id
 s18-20020a508d12000000b0053e8e2e2b8fmr6380682eds.9.1699627996858; Fri, 10 Nov
 2023 06:53:16 -0800 (PST)
MIME-Version: 1.0
References: <20231103131011.1316396-1-lb@semihalf.com> <20231103131011.1316396-12-lb@semihalf.com>
 <CAJfuBxzhz7pBYkfqfPomH4PUzqLPX1nxsev4yrQ2P6m5hyMT+Q@mail.gmail.com>
In-Reply-To: <CAJfuBxzhz7pBYkfqfPomH4PUzqLPX1nxsev4yrQ2P6m5hyMT+Q@mail.gmail.com>
From:   =?UTF-8?Q?=C5=81ukasz_Bartosik?= <lb@semihalf.com>
Date:   Fri, 10 Nov 2023 15:53:05 +0100
Message-ID: <CAK8ByeJ1fYSVaVQz3tERzj_5QNAN4Ggx850pKcAG3vhsoWnS+w@mail.gmail.com>
Subject: Re: [PATCH v1 11/12] dyndbg: write debug logs to trace instance
To:     jim.cromie@gmail.com
Cc:     Jason Baron <jbaron@akamai.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Guenter Roeck <groeck@google.com>,
        Yaniv Tzoreff <yanivt@google.com>,
        Benson Leung <bleung@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Pekka Paalanen <ppaalanen@gmail.com>,
        Sean Paul <seanpaul@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org,
        upstream@semihalf.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sob., 4 lis 2023 o 22:49 <jim.cromie@gmail.com> napisa=C5=82(a):
>
> On Fri, Nov 3, 2023 at 7:10=E2=80=AFAM =C5=81ukasz Bartosik <lb@semihalf.=
com> wrote:
> >
> > When trace is enabled (T flag is set) and trace_dst field is set
> > to value greater than 0 (0 is reserved for trace events) then
> > debug logs will be written to trace instance pointed by trace_dst
> > value, for example when trace_dst value is 2 then debug logs will
> > be written to <debugfs>/tracing/instances/dyndbg_inst_2 instance.
> > Given trace instance will not be initialized until debug logs are
> > requested to be written to it and afer init will persist until
> > reboot.
> >
>
> restating 00 comments -
>
> you can get rid of integer destination ids by adding a new command: open/=
close
>
> $> echo  \
>  open kms-instance \;\
>  class DRM_UT_KMS -T:kms-instance  # preset-dests-disable-sites \;\
> > /proc/dynamic_debug/control
>

Instead of using above command to preset destination we could preset
destination with open command. I mean last successful
open would preset destination ? What do you think ?

>
> and +T  w/o dest means use existing setting, not just 0 (unless thats
> the existing setting)
>

Sounds good.




> > Signed-off-by: =C5=81ukasz Bartosik <lb@semihalf.com>
> > ---
> >  lib/Kconfig.debug   |  1 +
> >  lib/dynamic_debug.c | 79 ++++++++++++++++++++++++++++++++++++++++++---
> >  2 files changed, 76 insertions(+), 4 deletions(-)
> >
> > diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> > index fa307f93fa2e..9617e92c046d 100644
> > --- a/lib/Kconfig.debug
> > +++ b/lib/Kconfig.debug
> > @@ -181,6 +181,7 @@ config DYNAMIC_DEBUG_CORE
> >         bool "Enable core function of dynamic debug support"
> >         depends on PRINTK
> >         depends on (DEBUG_FS || PROC_FS)
> > +       depends on TRACING
> >         help
> >           Enable core functional support of dynamic debug. It is useful
> >           when you want to tie dynamic debug to your kernel modules wit=
h
> > diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
> > index c5cd28e74a02..541d9d522b3b 100644
> > --- a/lib/dynamic_debug.c
> > +++ b/lib/dynamic_debug.c
> > @@ -36,6 +36,7 @@
> >  #include <linux/sched.h>
> >  #include <linux/device.h>
> >  #include <linux/netdevice.h>
> > +#include <linux/trace.h>
> >
> >  #define CREATE_TRACE_POINTS
> >  #include <trace/events/dyndbg.h>
> > @@ -81,6 +82,18 @@ module_param(verbose, int, 0644);
> >  MODULE_PARM_DESC(verbose, " dynamic_debug/control processing "
> >                  "( 0 =3D off (default), 1 =3D module add/rm, 2 =3D >co=
ntrol summary, 3 =3D parsing, 4 =3D per-site changes)");
> >
> > +/*
> > + * When trace is enabled (T flag is set) and trace_dst field is set
> > + * to value greater than 0 (0 is reserved for trace events) then
> > + * debug logs will be written to trace instance pointed by trace_dst
> > + * value, for example when trace_dst value is 2 then debug logs will
> > + * be written to <debugfs>/tracing/instances/dyndbg_inst_2 instance.
> > + * Given trace instance will not be initialized until debug logs are
> > + * requested to be written to it and afer init will persist until
> > + * reboot.
> > + */
> > +static struct trace_array *trace_arr[TRACE_DST_MAX];
> > +
> >  static inline struct dd_ctrl *get_ctrl(struct _ddebug *desc)
> >  {
> >         return &desc->ctrl;
> > @@ -255,6 +268,45 @@ static struct ddebug_class_map *ddebug_find_valid_=
class(struct ddebug_table cons
> >         return NULL;
> >  }
> >
> > +static int handle_trace_dst(struct dd_ctrl *ctrl)
> > +{
> > +#define TRACE_INST_NAME_LEN 16
> > +       char instance_name[TRACE_INST_NAME_LEN];
> > +       struct trace_array *arr;
> > +       int ret =3D -EINVAL;
> > +
> > +       /* check if trace (T flag) is enabled */
> > +       if (!(ctrl->flags & _DPRINTK_FLAGS_TRACE))
> > +               return 0;
> > +
> > +       /* check if trace destination are trace events */
> > +       if (!ctrl->trace_dst)
> > +               return 0;
> > +
> > +       /* check if trace instance is already set up */
> > +       if (trace_arr[ctrl->trace_dst])
> > +               return 0;
> > +
> > +       snprintf(instance_name, TRACE_INST_NAME_LEN,
> > +                "dyndbg_inst_%u", ctrl->trace_dst);
> > +       arr =3D trace_array_get_by_name(instance_name);
> > +       if (!arr)
> > +               goto err;
> > +
> > +       ret =3D trace_array_init_printk(arr);
> > +       if (ret)
> > +               goto err_init;
> > +
> > +       trace_arr[ctrl->trace_dst] =3D arr;
> > +       return 0;
> > +
> > +err_init:
> > +       trace_array_put(arr);
> > +       trace_array_destroy(arr);
> > +err:
> > +       return ret;
> > +}
> > +
> >  #define __outvar /* filled by callee */
> >  /*
> >   * Search the tables for _ddebug's which match the given `query' and
> > @@ -338,6 +390,9 @@ static int ddebug_change(const struct ddebug_query =
*query,
> >                         nctrl.trace_dst =3D modifiers->trace_dst;
> >                         if (!memcmp(&nctrl, get_ctrl(dp), sizeof(nctrl)=
))
> >                                 continue;
> > +
> > +                       if (handle_trace_dst(&nctrl))
> > +                               continue;
> >  #ifdef CONFIG_JUMP_LABEL
> >                         if (get_flags(dp) & _DPRINTK_FLAGS_ENABLED) {
> >                                 if (!(nctrl.flags & _DPRINTK_FLAGS_ENAB=
LED))
> > @@ -977,8 +1032,8 @@ static DEFINE_PER_CPU(struct ddebug_trace_bufs, dd=
ebug_trace_bufs);
> >  static DEFINE_PER_CPU(int, ddebug_trace_reserve);
> >
> >  __printf(3, 0)
> > -static void ddebug_trace(struct _ddebug *desc, const struct device *de=
v,
> > -                        const char *fmt, va_list args)
> > +static void ddebug_trace_event(struct _ddebug *desc, const struct devi=
ce *dev,
> > +                              const char *fmt, va_list args)
> >  {
> >         struct ddebug_trace_buf *buf;
> >         int bufidx;
> > @@ -1010,6 +1065,15 @@ static void ddebug_trace(struct _ddebug *desc, c=
onst struct device *dev,
> >         preempt_enable_notrace();
> >  }
> >
> > +__printf(2, 0)
> > +static void ddebug_trace_instance(struct _ddebug *desc, const char *fm=
t,
> > +                                 va_list *args)
> > +{
> > +       struct va_format vaf =3D { .fmt =3D fmt, .va =3D args};
> > +
> > +       trace_array_printk(trace_arr[get_trace_dst(desc)], _THIS_IP_, "=
%pV", &vaf);
> > +}
> > +
> >  __printf(2, 3)
> >  static void ddebug_printk(struct _ddebug *desc, const char *fmt, ...)
> >  {
> > @@ -1022,7 +1086,11 @@ static void ddebug_printk(struct _ddebug *desc, =
const char *fmt, ...)
> >                  * All callers include the KERN_DEBUG prefix to keep th=
e
> >                  * vprintk case simple; strip it out for tracing.
> >                  */
> > -               ddebug_trace(desc, NULL, fmt + strlen(KERN_DEBUG), args=
);
> > +               if (get_trace_dst(desc))
> > +                       ddebug_trace_instance(desc, fmt, &args);
> > +               else
> > +                       ddebug_trace_event(desc, NULL,
> > +                                          fmt + strlen(KERN_DEBUG), ar=
gs);
> >                 va_end(args);
> >         }
> >
> > @@ -1044,7 +1112,10 @@ static void ddebug_dev_printk(struct _ddebug *de=
sc, const struct device *dev,
> >                 va_list args;
> >
> >                 va_start(args, fmt);
> > -               ddebug_trace(desc, dev, fmt, args);
> > +               if (get_trace_dst(desc))
> > +                       ddebug_trace_instance(desc, fmt, &args);
> > +               else
> > +                       ddebug_trace_event(desc, dev, fmt, args);
> >                 va_end(args);
> >         }
> >
> > --
> > 2.42.0.869.gea05f2083d-goog
> >
