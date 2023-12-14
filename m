Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A61B181351F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 16:46:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573878AbjLNPqg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 10:46:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573858AbjLNPqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 10:46:35 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 678FEB2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 07:46:41 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-50bf69afa99so10680905e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 07:46:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google; t=1702568799; x=1703173599; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LOrqYu0o6VMrWH8Qmwulg5xbd5ccp47a1+5AcMLysFE=;
        b=D3OY+EV8Wwb6/q/7DE17EZptI0ai76CDxXKyGLLWg6urPlc0V+KkQoD0lRUcVlMVxH
         FnqxeXAVpRu3lleOHDZ9u0XcZFckBZIlPmnMLfNctcX4t3SGGkLU1aMxRZk02sEjReNm
         qL4+tMyvo0tpdtjJ4gi1Ha86x5wxvxubHDMkz4CJ7CpyDo9O7yqmlp16nJ36EJFp2N0W
         wt9/1ZWiQcUoWZJgJoe+DMGK2knFEFxC49sH+c4/5+cgPKcrq8SMoL75aEKwYPJzBkax
         2n0tLkVGpKAhf/QEWx8iSrSk0RndNGhOaR6EZQZQRF7IOl1ulh4GsnkMRYmZ4hxqbR6k
         noBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702568799; x=1703173599;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LOrqYu0o6VMrWH8Qmwulg5xbd5ccp47a1+5AcMLysFE=;
        b=mX2VEWDsbyf0S3bD3uIsEifHXZhGnfWDplza8qFOw6Vt0qeDNOBv6+ZW8gEFlQOa3b
         kDIvJm7mp8aYDjJr1ZlMcpzU/FmnmpHfPCGFSeIFAyj36/ZF7I2EqR0X1BbZ9KnyZJJr
         tY8xJBX7IL/D7hvQlS+9avRw6m+gl5EJGSFsP1YND5iB6noEUmzVRMHD+KpW8XCI+aGS
         bul1N+DPI2sY2J5O1fHHVOWTROUSLneiNher4Sjf5krK13C9E+lsyh9ZSSz22FIxNNOz
         MX/Ezyvu4n0EPU+D5kQkA9wyDEkOV2B8vxwMeq4pnxrNyv/H9IYJWRBYLd6qp/0/wHf2
         1daw==
X-Gm-Message-State: AOJu0YzoqS9tu9+6hskqQUHxzuFkc2rfdlAsPAaQndEx2RyZmlmRx8iA
        mEsRdqFOfWzhLwlNeQpmwh2NfO2g+SzBTEO/1u4V
X-Google-Smtp-Source: AGHT+IHo2EF92kSZM7sS2idZPzy5HtmmWi3ByE+Iw2wvgFeF+pNzh54jD5sn86xHF0aT33Zi+5rpmDQdqWuv6ATymjw=
X-Received: by 2002:a05:6512:124c:b0:50d:1888:1e4b with SMTP id
 fb12-20020a056512124c00b0050d18881e4bmr6941275lfb.49.1702568799409; Thu, 14
 Dec 2023 07:46:39 -0800 (PST)
MIME-Version: 1.0
References: <20231130234048.157509-1-lb@semihalf.com> <20231130234048.157509-10-lb@semihalf.com>
 <CAJfuBxwkLZcFBaXLEFeiGywiUtEJThwd5SxnNCfvtLry3XWRbg@mail.gmail.com>
In-Reply-To: <CAJfuBxwkLZcFBaXLEFeiGywiUtEJThwd5SxnNCfvtLry3XWRbg@mail.gmail.com>
From:   =?UTF-8?Q?=C5=81ukasz_Bartosik?= <lb@semihalf.com>
Date:   Thu, 14 Dec 2023 16:46:28 +0100
Message-ID: <CAK8ByeLuh9q24+Rm6CttHfF1ATpbbvyk5OUVxF9WRP-av9wr3Q@mail.gmail.com>
Subject: Re: [PATCH v2 09/15] dyndbg: add trace destination field to _ddebug
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

czw., 14 gru 2023 o 08:10 <jim.cromie@gmail.com> napisa=C5=82(a):
>
> On Thu, Nov 30, 2023 at 4:41=E2=80=AFPM =C5=81ukasz Bartosik <lb@semihalf=
.com> wrote:
> >
> > Add trace destination field (trace_dst) to the _ddebug structure.
> > The trace destination field is used to determine output of debug
> > logs when +T is set. Setting trace_dst value to TRACE_DST_BITS(63)
> > enables output to prdbg and devdbg trace events. Setting trace_dst
> > value to a value in range of [0..62] enables output to trace instance.
> >
>
> FWIW, I think setting trace_dest =3D 0  maps naturally to global / event =
buf.
> The reason class_id DFLT is 63 is that DRM_UT_CORE is 0,
> and DFLT allowed it to remain unchanged.
>

I considered trace_dst value 0 to point to trace events but then I
realized that trace instance table (tr.inst) will be 1-based instead
of 0-based and
based on that I reserved trace destination maximum value (63 when
trace_dst width is 6 bits) for trace events. This simplified the
implementation.

>
> > Signed-off-by: =C5=81ukasz Bartosik <lb@semihalf.com>
> > ---
> >  include/linux/dynamic_debug.h | 14 ++++++++++++--
> >  lib/dynamic_debug.c           | 28 +++++++++++++++++++---------
> >  2 files changed, 31 insertions(+), 11 deletions(-)
> >
> > diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debu=
g.h
> > index 684766289bfc..56f152e75604 100644
> > --- a/include/linux/dynamic_debug.h
> > +++ b/include/linux/dynamic_debug.h
> > @@ -60,9 +60,19 @@ struct _ddebug {
> >  #else
> >  #define _DPRINTK_FLAGS_DEFAULT 0
> >  #endif
> > -       struct {
> > +       struct dd_ctrl {
> >                 unsigned int flags:8;
> > -               unsigned unused:24;
> > +       /*
> > +        * The trace destination field is used to determine output of d=
ebug
> > +        * logs when +T is set. Setting trace_dst value to TRACE_DST_MA=
X(63)
> > +        * enables output to prdbg and devdbg trace events. Setting tra=
ce_dst
> > +        * value to a value in range of [0..62] enables output to trace
> > +        * instance.
> > +        */
> > +#define TRACE_DST_BITS 6
> > +               unsigned int trace_dst:TRACE_DST_BITS;
> > +#define TRACE_DST_MAX  ((1 << TRACE_DST_BITS) - 1)
> > +               unsigned unused:18;
> >         } ctrl;
> >  } __attribute__((aligned(8)));
> >
> > diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
> > index f47cb76e0e3d..0dc9ec76b867 100644
> > --- a/lib/dynamic_debug.c
> > +++ b/lib/dynamic_debug.c
> > @@ -80,14 +80,24 @@ module_param(verbose, int, 0644);
> >  MODULE_PARM_DESC(verbose, " dynamic_debug/control processing "
> >                  "( 0 =3D off (default), 1 =3D module add/rm, 2 =3D >co=
ntrol summary, 3 =3D parsing, 4 =3D per-site changes)");
> >
> > +static inline struct dd_ctrl *get_ctrl(struct _ddebug *desc)
> > +{
> > +       return &desc->ctrl;
> > +}
> > +
> > +static inline void set_ctrl(struct _ddebug *desc, struct dd_ctrl *ctrl=
)
> > +{
> > +       desc->ctrl =3D *ctrl;
> > +}
> > +
> >  static inline unsigned int get_flags(const struct _ddebug *desc)
> >  {
> >         return desc->ctrl.flags;
> >  }
> >
> > -static inline void set_flags(struct _ddebug *desc, unsigned int val)
> > +static inline unsigned int get_trace_dst(const struct _ddebug *desc)
> >  {
> > -       desc->ctrl.flags =3D val;
> > +       return desc->ctrl.trace_dst;
> >  }
> >
> >  /* Return the path relative to source root */
> > @@ -190,8 +200,8 @@ static int ddebug_change(const struct ddebug_query =
*query,
> >  {
> >         int i;
> >         struct ddebug_table *dt;
> > -       unsigned int newflags;
> >         unsigned int nfound =3D 0;
> > +       struct dd_ctrl nctrl =3D {0};
> >         struct flagsbuf fbuf, nbuf;
> >         struct ddebug_class_map *map =3D NULL;
> >         int __outvar valid_class;
> > @@ -257,14 +267,14 @@ static int ddebug_change(const struct ddebug_quer=
y *query,
> >
> >                         nfound++;
> >
> > -                       newflags =3D (get_flags(dp) & modifiers->mask) =
| modifiers->flags;
> > -                       if (newflags =3D=3D get_flags(dp))
> > +                       nctrl.flags =3D (get_flags(dp) & modifiers->mas=
k) | modifiers->flags;
> > +                       if (!memcmp(&nctrl, get_ctrl(dp), sizeof(struct=
 dd_ctrl)))
> >                                 continue;
> >  #ifdef CONFIG_JUMP_LABEL
> >                         if (get_flags(dp) & _DPRINTK_FLAGS_ENABLED) {
> > -                               if (!(newflags & _DPRINTK_FLAGS_ENABLED=
))
> > +                               if (!(nctrl.flags & _DPRINTK_FLAGS_ENAB=
LED))
> >                                         static_branch_disable(&dp->key.=
dd_key_true);
> > -                       } else if (newflags & _DPRINTK_FLAGS_ENABLED) {
> > +                       } else if (nctrl.flags & _DPRINTK_FLAGS_ENABLED=
) {
> >                                 static_branch_enable(&dp->key.dd_key_tr=
ue);
> >                         }
> >  #endif
> > @@ -272,8 +282,8 @@ static int ddebug_change(const struct ddebug_query =
*query,
> >                                   trim_prefix(dp->filename), dp->lineno=
,
> >                                   dt->mod_name, dp->function,
> >                                   ddebug_describe_flags(get_flags(dp), =
&fbuf),
> > -                                 ddebug_describe_flags(newflags, &nbuf=
));
> > -                       set_flags(dp, newflags);
> > +                                 ddebug_describe_flags(nctrl.flags, &n=
buf));
> > +                       set_ctrl(dp, &nctrl);
> >                 }
> >         }
> >         mutex_unlock(&ddebug_lock);
> > --
> > 2.43.0.rc2.451.g8631bc7472-goog
> >
