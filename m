Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07E667E0D7D
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 04:32:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231429AbjKDD11 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 23:27:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjKDD1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 23:27:25 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13CE1D50
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 20:27:22 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id af79cd13be357-77896da2118so155727885a.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Nov 2023 20:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699068441; x=1699673241; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UnxADeMvfp4tO2rOrXNqho+G/iGY5YzCqOEkMVmu49A=;
        b=MYUEmT8LQJG5Tbj2V5p8QMal5prSpg07XIs1NU2rpz6D/dvrQjwSQaKMf5NvxAmR/w
         LBZPA/9ua3HhsRPo7DcaETHVvtwgow1LB/NVw1Nzyaq3US6BSOhWjYYtsjMTubxz0R0V
         S5ZjU+NbX3kw+wuMty8ikVwQVGtnFcatP82rRre9EgG5YlwkOkLMaBNoXsZ59OEAsCLj
         OdCYTTlCBgaZA57zAvz5cUdQmYcaMS00OUXOEp7WliTFWGis1z7pd0mAf2kESnNV6u4T
         RdkKplZu7aT5hQLwySZ/rKsyXGvJAcJYp90aUobLyyg3R45PDZ1kq7QF9XijhCIQVraC
         6JCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699068441; x=1699673241;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UnxADeMvfp4tO2rOrXNqho+G/iGY5YzCqOEkMVmu49A=;
        b=ggl9/cbq+Isu67Fg4QVxpL8LX3h7fN/63gzR8aYnQcsvWcgvSrOgCo0brUCkj7M2RN
         Imu3yGzz9IwYTggxbk+Bm6x7m75o/P/hULvATcehJqJG7ECLxY3SrlzxesWfi/fea6EH
         kLyUtyZjBFbYrqcqBQC8nZCZT45XVEWOlruMyMqGr2hofCJ/CRJVs4MDBAy4RVNkFHv8
         ulPHwXiCm5GkqP8SjhY+b7Y4SH17zVAm2cwnJLMRgw9fcBCol+JnMhsTUN7skW4Xi6uA
         GrBzNyyUAEJ+hlKLbW3V18ZAxbbraq85/zwJS+ZIB+j9+lTcTDnWXRkSETSk9jqzo0PX
         fm2Q==
X-Gm-Message-State: AOJu0YwMP5Dx5iiNs2Tw/7l8m0K/cyaCy25Fcj8PT4kOBkf1zzN+haRs
        ANIkfukY51VIHXJffDqeLDhYY2ohliH9BZD/WVw=
X-Google-Smtp-Source: AGHT+IFyL+/wQ+VXQQopkVnlsl5c8g3t3WnEo7PQ7R1TWm0VefnHK+y2UrF58pn910KINt5MYNN8LZKmjtPsAq/1V6I=
X-Received: by 2002:a05:620a:44c8:b0:775:d42e:3e6f with SMTP id
 y8-20020a05620a44c800b00775d42e3e6fmr27718923qkp.65.1699068441069; Fri, 03
 Nov 2023 20:27:21 -0700 (PDT)
MIME-Version: 1.0
References: <20231103131011.1316396-1-lb@semihalf.com> <20231103131011.1316396-5-lb@semihalf.com>
In-Reply-To: <20231103131011.1316396-5-lb@semihalf.com>
From:   jim.cromie@gmail.com
Date:   Fri, 3 Nov 2023 21:26:54 -0600
Message-ID: <CAJfuBxyBmpOShdS=tZzKyjUPCDD5a-SZFwBKH1XrNHN-0ATecg@mail.gmail.com>
Subject: Re: [PATCH v1 04/12] dyndbg: add 2 trace-events: pr_debug, dev_dbg
To:     =?UTF-8?Q?=C5=81ukasz_Bartosik?= <lb@semihalf.com>
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
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 3, 2023 at 7:10=E2=80=AFAM =C5=81ukasz Bartosik <lb@semihalf.co=
m> wrote:
>
> From: Jim Cromie <jim.cromie@gmail.com>
>
> ddebug_trace() currently issues a single printk:console event.
> Replace that event by adding include/trace/events/dyndbg.h,
> which defines 2 new trace-events: dyndbg:prdbg & dyndbg:devdbg.
>
> These events get the _ddebug descriptor, so they can access the whole
> callsite record: file, line, function, flags.  This allows the
> addition of a dynamic prefix later.
>
> So ddebug_trace() gets 2 new args: the descriptor and the device.
> And its callers: ddebug_printk(), ddebug_dev_printk() upgrade their
> flags param to pass the descriptor itself, and thus also the flags.
>
> Signed-off-by: Jim Cromie <jim.cromie@gmail.com>

let me add:

I have doubts about adding the descriptor to the trace record.
For loadable modules in particular, those descriptors will go away at rmmod=
.

I added it thinking it would support filtering by callsite info.
Its not entirely clear whether it adds any utility, now or potentially.

During dev/hacking, I saw UNSAFE_<mumble> while TP_printk-ing the records,
while banging on it with various hammers (modprobe cycling probably)

maybe on rmmod, they could be "cached"  (or pointers poisoned)
allowing their use until then (and maybe afterwards)


> ---
>  MAINTAINERS                   |  1 +
>  include/trace/events/dyndbg.h | 74 +++++++++++++++++++++++++++++++++++
>  lib/dynamic_debug.c           | 73 +++++++++++++++++-----------------
>  3 files changed, 112 insertions(+), 36 deletions(-)
>  create mode 100644 include/trace/events/dyndbg.h
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index dd5de540ec0b..fd02dc86f1fd 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7320,6 +7320,7 @@ M:        Jason Baron <jbaron@akamai.com>
>  M:     Jim Cromie <jim.cromie@gmail.com>
>  S:     Maintained
>  F:     include/linux/dynamic_debug.h
> +F:     include/trace/events/dyndbg.h
>  F:     lib/dynamic_debug.c
>  F:     lib/test_dynamic_debug.c
>
> diff --git a/include/trace/events/dyndbg.h b/include/trace/events/dyndbg.=
h
> new file mode 100644
> index 000000000000..ccc5bcb070f9
> --- /dev/null
> +++ b/include/trace/events/dyndbg.h
> @@ -0,0 +1,74 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#undef TRACE_SYSTEM
> +#define TRACE_SYSTEM dyndbg
> +
> +#if !defined(_TRACE_DYNDBG_H) || defined(TRACE_HEADER_MULTI_READ)
> +#define _TRACE_DYNDBG_H
> +
> +#include <linux/tracepoint.h>
> +
> +/* capture pr_debug() callsite descriptor and message */
> +TRACE_EVENT(prdbg,
> +           TP_PROTO(const struct _ddebug *desc, const char *text, size_t=
 len),
> +
> +           TP_ARGS(desc, text, len),
> +
> +           TP_STRUCT__entry(
> +                       __field(const struct _ddebug *, desc)
> +                       __dynamic_array(char, msg, len + 1)
> +                   ),
> +
> +           TP_fast_assign(
> +                       __entry->desc =3D desc;
> +                       /*
> +                        * Each trace entry is printed in a new line.
> +                        * If the msg finishes with '\n', cut it off
> +                        * to avoid blank lines in the trace.
> +                        */
> +                       if (len > 0 && (text[len - 1] =3D=3D '\n'))
> +                               len -=3D 1;
> +
> +                       memcpy(__get_str(msg), text, len);
> +                       __get_str(msg)[len] =3D 0;
> +                   ),
> +
> +           TP_printk("%s.%s %s", __entry->desc->modname,
> +                     __entry->desc->function, __get_str(msg))
> +);
> +
> +/* capture dev_dbg() callsite descriptor, device, and message */
> +TRACE_EVENT(devdbg,
> +           TP_PROTO(const struct _ddebug *desc, const struct device *dev=
,
> +                    const char *text, size_t len),
> +
> +           TP_ARGS(desc, dev, text, len),
> +
> +           TP_STRUCT__entry(
> +                       __field(const struct _ddebug *, desc)
> +                       __field(const struct device *, dev)
> +                       __dynamic_array(char, msg, len + 1)
> +                   ),
> +
> +           TP_fast_assign(
> +                       __entry->desc =3D desc;
> +                       __entry->dev =3D (struct device *) dev;
> +                       /*
> +                        * Each trace entry is printed in a new line.
> +                        * If the msg finishes with '\n', cut it off
> +                        * to avoid blank lines in the trace.
> +                        */
> +                       if (len > 0 && (text[len - 1] =3D=3D '\n'))
> +                               len -=3D 1;
> +
> +                       memcpy(__get_str(msg), text, len);
> +                       __get_str(msg)[len] =3D 0;
> +                   ),
> +
> +           TP_printk("%s.%s %s", __entry->desc->modname,
> +                     __entry->desc->function, __get_str(msg))
> +);
> +
> +#endif /* _TRACE_DYNDBG_H */
> +
> +/* This part must be outside protection */
> +#include <trace/define_trace.h>
> diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
> index 016f33c20251..1ed3c4f16f69 100644
> --- a/lib/dynamic_debug.c
> +++ b/lib/dynamic_debug.c
> @@ -36,7 +36,9 @@
>  #include <linux/sched.h>
>  #include <linux/device.h>
>  #include <linux/netdevice.h>
> -#include <trace/events/printk.h>
> +
> +#define CREATE_TRACE_POINTS
> +#include <trace/events/dyndbg.h>
>
>  #include <rdma/ib_verbs.h>
>
> @@ -878,7 +880,9 @@ struct ddebug_trace_bufs {
>  static DEFINE_PER_CPU(struct ddebug_trace_bufs, ddebug_trace_bufs);
>  static DEFINE_PER_CPU(int, ddebug_trace_reserve);
>
> -static void ddebug_trace(const char *fmt, va_list args)
> +__printf(3, 0)
> +static void ddebug_trace(struct _ddebug *desc, const struct device *dev,
> +                        const char *fmt, va_list args)
>  {
>         struct ddebug_trace_buf *buf;
>         int bufidx;
> @@ -897,7 +901,11 @@ static void ddebug_trace(const char *fmt, va_list ar=
gs)
>         buf =3D this_cpu_ptr(ddebug_trace_bufs.bufs) + bufidx;
>
>         len =3D vscnprintf(buf->buf, sizeof(buf->buf), fmt, args);
> -       trace_console(buf->buf, len);
> +
> +       if (!dev)
> +               trace_prdbg(desc, buf->buf, len);
> +       else
> +               trace_devdbg(desc, dev, buf->buf, len);
>
>  out:
>         /* As above. */
> @@ -907,9 +915,9 @@ static void ddebug_trace(const char *fmt, va_list arg=
s)
>  }
>
>  __printf(2, 3)
> -static void ddebug_printk(unsigned int flags, const char *fmt, ...)
> +static void ddebug_printk(struct _ddebug *desc, const char *fmt, ...)
>  {
> -       if (flags & _DPRINTK_FLAGS_TRACE) {
> +       if (desc->flags & _DPRINTK_FLAGS_TRACE) {
>                 va_list args;
>
>                 va_start(args, fmt);
> @@ -917,11 +925,11 @@ static void ddebug_printk(unsigned int flags, const=
 char *fmt, ...)
>                  * All callers include the KERN_DEBUG prefix to keep the
>                  * vprintk case simple; strip it out for tracing.
>                  */
> -               ddebug_trace(fmt + strlen(KERN_DEBUG), args);
> +               ddebug_trace(desc, NULL, fmt + strlen(KERN_DEBUG), args);
>                 va_end(args);
>         }
>
> -       if (flags & _DPRINTK_FLAGS_PRINTK) {
> +       if (desc->flags & _DPRINTK_FLAGS_PRINTK) {
>                 va_list args;
>
>                 va_start(args, fmt);
> @@ -931,19 +939,19 @@ static void ddebug_printk(unsigned int flags, const=
 char *fmt, ...)
>  }
>
>  __printf(3, 4)
> -static void ddebug_dev_printk(unsigned int flags, const struct device *d=
ev,
> +static void ddebug_dev_printk(struct _ddebug *desc, const struct device =
*dev,
>                               const char *fmt, ...)
>  {
>
> -       if (flags & _DPRINTK_FLAGS_TRACE) {
> +       if (desc->flags & _DPRINTK_FLAGS_TRACE) {
>                 va_list args;
>
>                 va_start(args, fmt);
> -               ddebug_trace(fmt, args);
> +               ddebug_trace(desc, dev, fmt, args);
>                 va_end(args);
>         }
>
> -       if (flags & _DPRINTK_FLAGS_PRINTK) {
> +       if (desc->flags & _DPRINTK_FLAGS_PRINTK) {
>                 va_list args;
>
>                 va_start(args, fmt);
> @@ -966,7 +974,7 @@ void __dynamic_pr_debug(struct _ddebug *descriptor, c=
onst char *fmt, ...)
>         vaf.fmt =3D fmt;
>         vaf.va =3D &args;
>
> -       ddebug_printk(descriptor->flags, KERN_DEBUG "%s%pV",
> +       ddebug_printk(descriptor, KERN_DEBUG "%s%pV",
>                       dynamic_emit_prefix(descriptor, buf), &vaf);
>
>         va_end(args);
> @@ -977,7 +985,6 @@ void __dynamic_dev_dbg(struct _ddebug *descriptor,
>                        const struct device *dev, const char *fmt, ...)
>  {
>         struct va_format vaf;
> -       unsigned int flags;
>         va_list args;
>
>         BUG_ON(!descriptor);
> @@ -987,15 +994,14 @@ void __dynamic_dev_dbg(struct _ddebug *descriptor,
>
>         vaf.fmt =3D fmt;
>         vaf.va =3D &args;
> -       flags =3D descriptor->flags;
>
>         if (!dev) {
> -               ddebug_printk(flags, KERN_DEBUG "(NULL device *): %pV",
> -                             &vaf);
> +               ddebug_printk(descriptor, KERN_DEBUG "(NULL device *): %p=
V",
> +                              &vaf);
>         } else {
>                 char buf[PREFIX_SIZE] =3D "";
>
> -               ddebug_dev_printk(flags, dev, "%s%s %s: %pV",
> +               ddebug_dev_printk(descriptor, dev, "%s%s %s: %pV",
>                                   dynamic_emit_prefix(descriptor, buf),
>                                   dev_driver_string(dev), dev_name(dev),
>                                   &vaf);
> @@ -1011,7 +1017,6 @@ void __dynamic_netdev_dbg(struct _ddebug *descripto=
r,
>                           const struct net_device *dev, const char *fmt, =
...)
>  {
>         struct va_format vaf;
> -       unsigned int flags;
>         va_list args;
>
>         BUG_ON(!descriptor);
> @@ -1021,24 +1026,22 @@ void __dynamic_netdev_dbg(struct _ddebug *descrip=
tor,
>
>         vaf.fmt =3D fmt;
>         vaf.va =3D &args;
> -       flags =3D descriptor->flags;
>
>         if (dev && dev->dev.parent) {
>                 char buf[PREFIX_SIZE] =3D "";
>
> -               ddebug_dev_printk(flags, dev->dev.parent,
> -                                  "%s%s %s %s%s: %pV",
> -                                  dynamic_emit_prefix(descriptor, buf),
> -                                  dev_driver_string(dev->dev.parent),
> -                                  dev_name(dev->dev.parent),
> -                                  netdev_name(dev), netdev_reg_state(dev=
),
> -                                  &vaf);
> +               ddebug_dev_printk(descriptor, dev->dev.parent,
> +                                 "%s%s %s %s%s: %pV",
> +                                 dynamic_emit_prefix(descriptor, buf),
> +                                 dev_driver_string(dev->dev.parent),
> +                                 dev_name(dev->dev.parent),
> +                                 netdev_name(dev), netdev_reg_state(dev)=
,
> +                                 &vaf);
>         } else if (dev) {
> -               ddebug_printk(flags, KERN_DEBUG "%s%s: %pV",
> -                              netdev_name(dev), netdev_reg_state(dev), &=
vaf);
> +               ddebug_dev_printk(descriptor, &dev->dev, KERN_DEBUG "%s%s=
: %pV",
> +                                 netdev_name(dev), netdev_reg_state(dev)=
, &vaf);
>         } else {
> -               ddebug_printk(flags, KERN_DEBUG "(NULL net_device): %pV",
> -                              &vaf);
> +               ddebug_printk(descriptor, KERN_DEBUG "(NULL net_device): =
%pV", &vaf);
>         }
>
>         va_end(args);
> @@ -1054,18 +1057,16 @@ void __dynamic_ibdev_dbg(struct _ddebug *descript=
or,
>  {
>         struct va_format vaf;
>         va_list args;
> -       unsigned int flags;
>
>         va_start(args, fmt);
>
>         vaf.fmt =3D fmt;
>         vaf.va =3D &args;
> -       flags =3D descriptor->flags;
>
>         if (ibdev && ibdev->dev.parent) {
>                 char buf[PREFIX_SIZE] =3D "";
>
> -               ddebug_dev_printk(flags, ibdev->dev.parent,
> +               ddebug_dev_printk(descriptor, ibdev->dev.parent,
>                                   "%s%s %s %s: %pV",
>                                   dynamic_emit_prefix(descriptor, buf),
>                                   dev_driver_string(ibdev->dev.parent),
> @@ -1073,10 +1074,10 @@ void __dynamic_ibdev_dbg(struct _ddebug *descript=
or,
>                                   dev_name(&ibdev->dev),
>                                   &vaf);
>         } else if (ibdev) {
> -               ddebug_printk(flags, KERN_DEBUG "%s: %pV",
> -                             dev_name(&ibdev->dev), &vaf);
> +               ddebug_dev_printk(descriptor, &ibdev->dev, KERN_DEBUG "%s=
: %pV",
> +                                 dev_name(&ibdev->dev), &vaf);
>         } else {
> -               ddebug_printk(flags, KERN_DEBUG "(NULL ip_device): %pV", =
&vaf);
> +               ddebug_printk(descriptor, KERN_DEBUG "(NULL ip_device): %=
pV", &vaf);
>         }
>
>         va_end(args);
> --
> 2.42.0.869.gea05f2083d-goog
>
