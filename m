Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17F418128CC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 08:10:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234344AbjLNHKU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 02:10:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjLNHKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 02:10:18 -0500
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E275FE8
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 23:10:23 -0800 (PST)
Received: by mail-ua1-x92e.google.com with SMTP id a1e0cc1a2514c-7c522ea69e8so2057459241.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 23:10:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702537823; x=1703142623; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e6YKw9xj99N4Ave8AERd2pHwfAAEDsoogtXUYyHnq34=;
        b=bt9zjtDE/Z1Y/c8MqJWk3SFCzUp9GF9Aqx7jBV29gE8kdVxbzCV2dn3/7eyNUE9x/o
         Pey8MmMfKLvjgE0NY0IkJLWHFvuWdyxfupCqU/8EMe9Ds1vKU3EAtk0WdoNo3T/3jpe7
         VUicC30XFuBm70dNYX3jUddeTGrKCLNYuh1hwXMeC3dp5Ql0m23moWpAPrQ8Iqf/n2V8
         ki2dn104SBWd6iTRQdbuZV0P1r5kqMtBtYrcZusZNe244Tu+BqgdpTfd/lUj5YUbQaJf
         ipj4TTa9kAcmlSvP3Kl6GYx30gKlvIqFcCp6ZUEDF2gwSakfO2+uUkKakCFwXcvU3/JU
         Bjuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702537823; x=1703142623;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e6YKw9xj99N4Ave8AERd2pHwfAAEDsoogtXUYyHnq34=;
        b=qNNQbEQ0XTKsRi5080U0JYFM+mIkFOIjPyRKd1WOTDhFw2kz0tOLT2uthufC/E0xm/
         gJ+jKnCzkhSMwsiMyl1nVJO+qMLD4UbI4fvmJk56bcehdXMu2Yq9x6q2Vds29KeFGhqj
         HRVo8DovFYs+tSFWEda6k0/Q2xxg52Kt5Nfl0SwCyRC0NDWTWofF/hYObnaBM6VyO7P2
         eJOG+s5R6TzSAzgYyKsU4Auh1Iyg8Ld7kjtB6JRaAWUenpBL/0UwX54ancHDtQIJFT/6
         xvhY6aJ13G9PT4T9tLcBUB0pDvv85QLt3g/6y8xFC8MGjjUQMba4wYaI33AWy0DvX/6u
         Xtrg==
X-Gm-Message-State: AOJu0YzbuPS2hoJKCmFvGz48sKhSdEfLWqpyEYlAd0zrP1sfKbU6rg0y
        T2rGXWqTrpcXUIH/rIPDmUliQl3kih7muOoA52s=
X-Google-Smtp-Source: AGHT+IHKZ70MEoX2YEdNpSSA4lgCpL5LDRCrIWKi8NLz2E7Q4MO2nMPFiwTzNq5WfIStyoDi2XZROlnfipGPV/emYBY=
X-Received: by 2002:a05:6102:512c:b0:464:77f2:556 with SMTP id
 bm44-20020a056102512c00b0046477f20556mr8134189vsb.40.1702537822757; Wed, 13
 Dec 2023 23:10:22 -0800 (PST)
MIME-Version: 1.0
References: <20231130234048.157509-1-lb@semihalf.com> <20231130234048.157509-10-lb@semihalf.com>
In-Reply-To: <20231130234048.157509-10-lb@semihalf.com>
From:   jim.cromie@gmail.com
Date:   Thu, 14 Dec 2023 00:09:56 -0700
Message-ID: <CAJfuBxwkLZcFBaXLEFeiGywiUtEJThwd5SxnNCfvtLry3XWRbg@mail.gmail.com>
Subject: Re: [PATCH v2 09/15] dyndbg: add trace destination field to _ddebug
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

On Thu, Nov 30, 2023 at 4:41=E2=80=AFPM =C5=81ukasz Bartosik <lb@semihalf.c=
om> wrote:
>
> Add trace destination field (trace_dst) to the _ddebug structure.
> The trace destination field is used to determine output of debug
> logs when +T is set. Setting trace_dst value to TRACE_DST_BITS(63)
> enables output to prdbg and devdbg trace events. Setting trace_dst
> value to a value in range of [0..62] enables output to trace instance.
>

FWIW, I think setting trace_dest =3D 0  maps naturally to global / event bu=
f.
The reason class_id DFLT is 63 is that DRM_UT_CORE is 0,
and DFLT allowed it to remain unchanged.


> Signed-off-by: =C5=81ukasz Bartosik <lb@semihalf.com>
> ---
>  include/linux/dynamic_debug.h | 14 ++++++++++++--
>  lib/dynamic_debug.c           | 28 +++++++++++++++++++---------
>  2 files changed, 31 insertions(+), 11 deletions(-)
>
> diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.=
h
> index 684766289bfc..56f152e75604 100644
> --- a/include/linux/dynamic_debug.h
> +++ b/include/linux/dynamic_debug.h
> @@ -60,9 +60,19 @@ struct _ddebug {
>  #else
>  #define _DPRINTK_FLAGS_DEFAULT 0
>  #endif
> -       struct {
> +       struct dd_ctrl {
>                 unsigned int flags:8;
> -               unsigned unused:24;
> +       /*
> +        * The trace destination field is used to determine output of deb=
ug
> +        * logs when +T is set. Setting trace_dst value to TRACE_DST_MAX(=
63)
> +        * enables output to prdbg and devdbg trace events. Setting trace=
_dst
> +        * value to a value in range of [0..62] enables output to trace
> +        * instance.
> +        */
> +#define TRACE_DST_BITS 6
> +               unsigned int trace_dst:TRACE_DST_BITS;
> +#define TRACE_DST_MAX  ((1 << TRACE_DST_BITS) - 1)
> +               unsigned unused:18;
>         } ctrl;
>  } __attribute__((aligned(8)));
>
> diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
> index f47cb76e0e3d..0dc9ec76b867 100644
> --- a/lib/dynamic_debug.c
> +++ b/lib/dynamic_debug.c
> @@ -80,14 +80,24 @@ module_param(verbose, int, 0644);
>  MODULE_PARM_DESC(verbose, " dynamic_debug/control processing "
>                  "( 0 =3D off (default), 1 =3D module add/rm, 2 =3D >cont=
rol summary, 3 =3D parsing, 4 =3D per-site changes)");
>
> +static inline struct dd_ctrl *get_ctrl(struct _ddebug *desc)
> +{
> +       return &desc->ctrl;
> +}
> +
> +static inline void set_ctrl(struct _ddebug *desc, struct dd_ctrl *ctrl)
> +{
> +       desc->ctrl =3D *ctrl;
> +}
> +
>  static inline unsigned int get_flags(const struct _ddebug *desc)
>  {
>         return desc->ctrl.flags;
>  }
>
> -static inline void set_flags(struct _ddebug *desc, unsigned int val)
> +static inline unsigned int get_trace_dst(const struct _ddebug *desc)
>  {
> -       desc->ctrl.flags =3D val;
> +       return desc->ctrl.trace_dst;
>  }
>
>  /* Return the path relative to source root */
> @@ -190,8 +200,8 @@ static int ddebug_change(const struct ddebug_query *q=
uery,
>  {
>         int i;
>         struct ddebug_table *dt;
> -       unsigned int newflags;
>         unsigned int nfound =3D 0;
> +       struct dd_ctrl nctrl =3D {0};
>         struct flagsbuf fbuf, nbuf;
>         struct ddebug_class_map *map =3D NULL;
>         int __outvar valid_class;
> @@ -257,14 +267,14 @@ static int ddebug_change(const struct ddebug_query =
*query,
>
>                         nfound++;
>
> -                       newflags =3D (get_flags(dp) & modifiers->mask) | =
modifiers->flags;
> -                       if (newflags =3D=3D get_flags(dp))
> +                       nctrl.flags =3D (get_flags(dp) & modifiers->mask)=
 | modifiers->flags;
> +                       if (!memcmp(&nctrl, get_ctrl(dp), sizeof(struct d=
d_ctrl)))
>                                 continue;
>  #ifdef CONFIG_JUMP_LABEL
>                         if (get_flags(dp) & _DPRINTK_FLAGS_ENABLED) {
> -                               if (!(newflags & _DPRINTK_FLAGS_ENABLED))
> +                               if (!(nctrl.flags & _DPRINTK_FLAGS_ENABLE=
D))
>                                         static_branch_disable(&dp->key.dd=
_key_true);
> -                       } else if (newflags & _DPRINTK_FLAGS_ENABLED) {
> +                       } else if (nctrl.flags & _DPRINTK_FLAGS_ENABLED) =
{
>                                 static_branch_enable(&dp->key.dd_key_true=
);
>                         }
>  #endif
> @@ -272,8 +282,8 @@ static int ddebug_change(const struct ddebug_query *q=
uery,
>                                   trim_prefix(dp->filename), dp->lineno,
>                                   dt->mod_name, dp->function,
>                                   ddebug_describe_flags(get_flags(dp), &f=
buf),
> -                                 ddebug_describe_flags(newflags, &nbuf))=
;
> -                       set_flags(dp, newflags);
> +                                 ddebug_describe_flags(nctrl.flags, &nbu=
f));
> +                       set_ctrl(dp, &nctrl);
>                 }
>         }
>         mutex_unlock(&ddebug_lock);
> --
> 2.43.0.rc2.451.g8631bc7472-goog
>
