Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49F837E113F
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 22:51:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbjKDVt2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Nov 2023 17:49:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjKDVt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Nov 2023 17:49:27 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F06BBD69
        for <linux-kernel@vger.kernel.org>; Sat,  4 Nov 2023 14:49:23 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id af79cd13be357-77891c236fcso218572085a.3
        for <linux-kernel@vger.kernel.org>; Sat, 04 Nov 2023 14:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699134561; x=1699739361; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iZ3QfH8tdp9ZKwfs3qPFK2zrxsl4sOz4mzZ2VqGXnJI=;
        b=G6Mcu0sALkOG+/++84fd7R9+ePTTZULibGNGfulbPL/yWvp8eu8LH1iTPQ7z5rYEOt
         TYdiNEg8m9PMn/AAuKCcoPZnHJ82eE/2YB7gf6LuCEycdnBym7TBmfyhmFyVk5mTb1o1
         lCkmvHveyz/+nHuCO8Ps2qdrOf5AjLuq7RgVePfWa/OxbC3LLOcJ8zt60hwA4eBN8nBd
         XUTybeL7sXI/uhzaUmKTsI3Crl/9Nc034GQBhjQ7Q6B91JkBx6ITxnQgCoILVDRkj+7m
         m2CN+UEwruj7hmAfa5dlW3le0Q0uQGpsb4tzAQ/VzFXNOqs67S1zQexPVdcBDS/R5Jv4
         l9Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699134561; x=1699739361;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iZ3QfH8tdp9ZKwfs3qPFK2zrxsl4sOz4mzZ2VqGXnJI=;
        b=idFPMuy5pW0dsTUFS84wtDIb7yDimsRwbytYe+sFzL4bGR1dhsLpuPh4XnP0y725Yx
         65JIfa+R01g3unryWI4cl+DWLusmpf7HxRCd2VgiyJ3ijo8D3J9rFmuoZMaKjID1EmFv
         WPxvumZmiHxxRA4ZRQ/E1eyOdBleBQKWwz2ldMi+4NMBEEMJeCIQzlUFn4LnUMtWtTdK
         U8tCc5SCyBq4BD9INiqgnZ3/cHs14tJKzPJIHWlXR+DvP5OFPcV5KVHYGbHH5gyXVZDv
         dxfu4XMabofi0L3rCFmC99LXe19wdun/NxpMv6RZsDqHg5f7sQSC5HzdTTM5mVg8Zekw
         V2Dw==
X-Gm-Message-State: AOJu0YwMIvK+1NssGyV6kyBTYIt6NJqxVYv8la4jDPFDjRD8EtoENO59
        1bq+CDFRIxSLbO0Wjji7CZrA3hR4wKaJUy0FTJY=
X-Google-Smtp-Source: AGHT+IESw3mGNFjT1qh3+YqBfGbYPjKMVngR6ObxxNg41kO9c5+kZ1Q4L8evEEpilRGomPISEMrKfmyQIuQgbwPXrvs=
X-Received: by 2002:ae9:f719:0:b0:76c:8d5f:5954 with SMTP id
 s25-20020ae9f719000000b0076c8d5f5954mr24457359qkg.70.1699134561562; Sat, 04
 Nov 2023 14:49:21 -0700 (PDT)
MIME-Version: 1.0
References: <20231103131011.1316396-1-lb@semihalf.com> <20231103131011.1316396-12-lb@semihalf.com>
In-Reply-To: <20231103131011.1316396-12-lb@semihalf.com>
From:   jim.cromie@gmail.com
Date:   Sat, 4 Nov 2023 15:48:55 -0600
Message-ID: <CAJfuBxzhz7pBYkfqfPomH4PUzqLPX1nxsev4yrQ2P6m5hyMT+Q@mail.gmail.com>
Subject: Re: [PATCH v1 11/12] dyndbg: write debug logs to trace instance
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
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 3, 2023 at 7:10=E2=80=AFAM =C5=81ukasz Bartosik <lb@semihalf.co=
m> wrote:
>
> When trace is enabled (T flag is set) and trace_dst field is set
> to value greater than 0 (0 is reserved for trace events) then
> debug logs will be written to trace instance pointed by trace_dst
> value, for example when trace_dst value is 2 then debug logs will
> be written to <debugfs>/tracing/instances/dyndbg_inst_2 instance.
> Given trace instance will not be initialized until debug logs are
> requested to be written to it and afer init will persist until
> reboot.
>

restating 00 comments -

you can get rid of integer destination ids by adding a new command: open/cl=
ose

$> echo  \
 open kms-instance \;\
 class DRM_UT_KMS -T:kms-instance  # preset-dests-disable-sites \;\
> /proc/dynamic_debug/control

echo "class DRM_UT_KMS +T # enable sites, with the preselected data" >
/proc/dynamic_debug/control

open - assign name to id, reserve it, hide it from user
+T:valid-name # fail command if name wasnt opened

and +T  w/o dest means use existing setting, not just 0 (unless thats
the existing setting)

> Signed-off-by: =C5=81ukasz Bartosik <lb@semihalf.com>
> ---
>  lib/Kconfig.debug   |  1 +
>  lib/dynamic_debug.c | 79 ++++++++++++++++++++++++++++++++++++++++++---
>  2 files changed, 76 insertions(+), 4 deletions(-)
>
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index fa307f93fa2e..9617e92c046d 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -181,6 +181,7 @@ config DYNAMIC_DEBUG_CORE
>         bool "Enable core function of dynamic debug support"
>         depends on PRINTK
>         depends on (DEBUG_FS || PROC_FS)
> +       depends on TRACING
>         help
>           Enable core functional support of dynamic debug. It is useful
>           when you want to tie dynamic debug to your kernel modules with
> diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
> index c5cd28e74a02..541d9d522b3b 100644
> --- a/lib/dynamic_debug.c
> +++ b/lib/dynamic_debug.c
> @@ -36,6 +36,7 @@
>  #include <linux/sched.h>
>  #include <linux/device.h>
>  #include <linux/netdevice.h>
> +#include <linux/trace.h>
>
>  #define CREATE_TRACE_POINTS
>  #include <trace/events/dyndbg.h>
> @@ -81,6 +82,18 @@ module_param(verbose, int, 0644);
>  MODULE_PARM_DESC(verbose, " dynamic_debug/control processing "
>                  "( 0 =3D off (default), 1 =3D module add/rm, 2 =3D >cont=
rol summary, 3 =3D parsing, 4 =3D per-site changes)");
>
> +/*
> + * When trace is enabled (T flag is set) and trace_dst field is set
> + * to value greater than 0 (0 is reserved for trace events) then
> + * debug logs will be written to trace instance pointed by trace_dst
> + * value, for example when trace_dst value is 2 then debug logs will
> + * be written to <debugfs>/tracing/instances/dyndbg_inst_2 instance.
> + * Given trace instance will not be initialized until debug logs are
> + * requested to be written to it and afer init will persist until
> + * reboot.
> + */
> +static struct trace_array *trace_arr[TRACE_DST_MAX];
> +
>  static inline struct dd_ctrl *get_ctrl(struct _ddebug *desc)
>  {
>         return &desc->ctrl;
> @@ -255,6 +268,45 @@ static struct ddebug_class_map *ddebug_find_valid_cl=
ass(struct ddebug_table cons
>         return NULL;
>  }
>
> +static int handle_trace_dst(struct dd_ctrl *ctrl)
> +{
> +#define TRACE_INST_NAME_LEN 16
> +       char instance_name[TRACE_INST_NAME_LEN];
> +       struct trace_array *arr;
> +       int ret =3D -EINVAL;
> +
> +       /* check if trace (T flag) is enabled */
> +       if (!(ctrl->flags & _DPRINTK_FLAGS_TRACE))
> +               return 0;
> +
> +       /* check if trace destination are trace events */
> +       if (!ctrl->trace_dst)
> +               return 0;
> +
> +       /* check if trace instance is already set up */
> +       if (trace_arr[ctrl->trace_dst])
> +               return 0;
> +
> +       snprintf(instance_name, TRACE_INST_NAME_LEN,
> +                "dyndbg_inst_%u", ctrl->trace_dst);
> +       arr =3D trace_array_get_by_name(instance_name);
> +       if (!arr)
> +               goto err;
> +
> +       ret =3D trace_array_init_printk(arr);
> +       if (ret)
> +               goto err_init;
> +
> +       trace_arr[ctrl->trace_dst] =3D arr;
> +       return 0;
> +
> +err_init:
> +       trace_array_put(arr);
> +       trace_array_destroy(arr);
> +err:
> +       return ret;
> +}
> +
>  #define __outvar /* filled by callee */
>  /*
>   * Search the tables for _ddebug's which match the given `query' and
> @@ -338,6 +390,9 @@ static int ddebug_change(const struct ddebug_query *q=
uery,
>                         nctrl.trace_dst =3D modifiers->trace_dst;
>                         if (!memcmp(&nctrl, get_ctrl(dp), sizeof(nctrl)))
>                                 continue;
> +
> +                       if (handle_trace_dst(&nctrl))
> +                               continue;
>  #ifdef CONFIG_JUMP_LABEL
>                         if (get_flags(dp) & _DPRINTK_FLAGS_ENABLED) {
>                                 if (!(nctrl.flags & _DPRINTK_FLAGS_ENABLE=
D))
> @@ -977,8 +1032,8 @@ static DEFINE_PER_CPU(struct ddebug_trace_bufs, ddeb=
ug_trace_bufs);
>  static DEFINE_PER_CPU(int, ddebug_trace_reserve);
>
>  __printf(3, 0)
> -static void ddebug_trace(struct _ddebug *desc, const struct device *dev,
> -                        const char *fmt, va_list args)
> +static void ddebug_trace_event(struct _ddebug *desc, const struct device=
 *dev,
> +                              const char *fmt, va_list args)
>  {
>         struct ddebug_trace_buf *buf;
>         int bufidx;
> @@ -1010,6 +1065,15 @@ static void ddebug_trace(struct _ddebug *desc, con=
st struct device *dev,
>         preempt_enable_notrace();
>  }
>
> +__printf(2, 0)
> +static void ddebug_trace_instance(struct _ddebug *desc, const char *fmt,
> +                                 va_list *args)
> +{
> +       struct va_format vaf =3D { .fmt =3D fmt, .va =3D args};
> +
> +       trace_array_printk(trace_arr[get_trace_dst(desc)], _THIS_IP_, "%p=
V", &vaf);
> +}
> +
>  __printf(2, 3)
>  static void ddebug_printk(struct _ddebug *desc, const char *fmt, ...)
>  {
> @@ -1022,7 +1086,11 @@ static void ddebug_printk(struct _ddebug *desc, co=
nst char *fmt, ...)
>                  * All callers include the KERN_DEBUG prefix to keep the
>                  * vprintk case simple; strip it out for tracing.
>                  */
> -               ddebug_trace(desc, NULL, fmt + strlen(KERN_DEBUG), args);
> +               if (get_trace_dst(desc))
> +                       ddebug_trace_instance(desc, fmt, &args);
> +               else
> +                       ddebug_trace_event(desc, NULL,
> +                                          fmt + strlen(KERN_DEBUG), args=
);
>                 va_end(args);
>         }
>
> @@ -1044,7 +1112,10 @@ static void ddebug_dev_printk(struct _ddebug *desc=
, const struct device *dev,
>                 va_list args;
>
>                 va_start(args, fmt);
> -               ddebug_trace(desc, dev, fmt, args);
> +               if (get_trace_dst(desc))
> +                       ddebug_trace_instance(desc, fmt, &args);
> +               else
> +                       ddebug_trace_event(desc, dev, fmt, args);
>                 va_end(args);
>         }
>
> --
> 2.42.0.869.gea05f2083d-goog
>
