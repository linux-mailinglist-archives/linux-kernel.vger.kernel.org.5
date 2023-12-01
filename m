Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA84F80066D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 10:01:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377960AbjLAJBB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 04:01:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377946AbjLAJA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 04:00:58 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F109810F3
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 01:01:03 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-54c4433e98bso968008a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 01:01:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google; t=1701421262; x=1702026062; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YCpoEc5txd9B0aAGLUisasjo07qewG9KF9PIN0PRI4M=;
        b=Hh/ZUUf97uvNDQz22Mv8llEG9ITH/szSdI2mnTz70r94wLxsFpCUzo0zEVh3O1p1QY
         e0DF9iY+OmmFxwrf/Ht1sPPFRZ4HPyR0HNDWT+2NzhJB2Z4uKkkmIwTWbjBNOYlPHonU
         ZZAb2vAmi9Lccek/DOWPOphiQq0Ios79Jm7Ekzx0/djVPLy0MagVZk2JEmxHO7b6+nBq
         Og5XThtvZ8kAGo9Bqk5rK/AZP3qv2BaGGl8u1AOGlo7zPj/gOoPs4wjaC1QymOKpb5B3
         COCn7nqk9xCcJ7tAHmT40j9qN7s/uYKKiOH4T+T822cB030rUokkctMsnGe9HJuXI892
         R/SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701421262; x=1702026062;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YCpoEc5txd9B0aAGLUisasjo07qewG9KF9PIN0PRI4M=;
        b=jVlvw4VScLz1AKDu+f4NfI5povEf0AZ1ELiDwH3ebVfAZX+3I7tQTzKeQdNdLqHnUs
         vtgVoF7IUmOJL0tvbHLKYGA+ajzKGu2EG362bm0ubvszQLXl8/QEIBoJTbj13vkDODaB
         kWJlhCTru58NSZwIp4g61tPckvXdh6zaYoJK4hpfaAGKe1ni6MoJ/NjSRcuPz+bd/1Cl
         YRumPn9tiOmBKiIjYu5d1r/JJfWWGk1gkIO6NEvYmHVitDu0om204j2Uno7BIN2+AQGW
         ZJ4J4wRxyZdT9+IUn9ziM5Eeuj4B1vnZ214YBPMS+Rw45C+7tQT8WCBVlcmp4ioXf+Ps
         LUDw==
X-Gm-Message-State: AOJu0YzI/5p4Ncb7Y9Fsbui1hUM8ymzU2lFP8bcAnslRQScx1Ng0r1+N
        tWY8l+Uid7OXu+RL4FHrjlL2I8OLUXqbCxyiU0Id
X-Google-Smtp-Source: AGHT+IG4LMl+4v53QDuA3OYBfIZ9ikMRJpRqLUkcSrndwUZAcZpLq3c35viOjXzD9wnLKYK4B2OOWRc9fz+h9Zfl7TI=
X-Received: by 2002:a50:d002:0:b0:54c:4fec:f7 with SMTP id j2-20020a50d002000000b0054c4fec00f7mr239230edf.134.1701421262374;
 Fri, 01 Dec 2023 01:01:02 -0800 (PST)
MIME-Version: 1.0
References: <20231130234048.157509-1-lb@semihalf.com> <20231130234048.157509-6-lb@semihalf.com>
 <20231130192554.10da680c@gandalf.local.home>
In-Reply-To: <20231130192554.10da680c@gandalf.local.home>
From:   =?UTF-8?Q?=C5=81ukasz_Bartosik?= <lb@semihalf.com>
Date:   Fri, 1 Dec 2023 10:00:51 +0100
Message-ID: <CAK8ByeK8dGcbxfXghw6=LrhSWLmO0a4XuB8C0nsUc812aoU0Pw@mail.gmail.com>
Subject: Re: [PATCH v2 05/15] tracefs: add __get_str_strip_nl - RFC
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Jason Baron <jbaron@akamai.com>, Jim Cromie <jim.cromie@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Guenter Roeck <groeck@google.com>,
        Yaniv Tzoreff <yanivt@google.com>,
        Benson Leung <bleung@google.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Pekka Paalanen <ppaalanen@gmail.com>,
        Sean Paul <seanpaul@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org,
        upstream@semihalf.com, pmladek@suse.com,
        sergey.senozhatsky@gmail.com, john.ogness@linutronix.de,
        Simon Ser <contact@emersion.fr>
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

pt., 1 gru 2023 o 01:25 Steven Rostedt <rostedt@goodmis.org> napisa=C5=82(a=
):
>
> On Fri,  1 Dec 2023 00:40:38 +0100
> =C5=81ukasz Bartosik <lb@semihalf.com> wrote:
>
> > From: Jim Cromie <jim.cromie@gmail.com>
> >
> > This variant of __get_str() removes the trailing newline. It is for
> > use by printk/debug-ish events which already have a trailing newline.
> > It is here to support:
> >
> > https://lore.kernel.org/lkml/
> > 20200825153338.17061-1-vincent.whitchurch@axis.com/
>
> Line wrap breakage.
>

I will fix it.

> > which taught dyndbg to send pr_debug() msgs to tracefs, via -x/T flag.
> >
> > It "reused" the include/trace/events/printk.h console event,
> > which does the following:
> >
> >        TP_fast_assign(
> >                /*
> >                 * Each trace entry is printed in a new line.
> >                 * If the msg finishes with '\n', cut it off
> >                 * to avoid blank lines in the trace.
> >                 */
> >                if (len > 0 && (msg[len-1] =3D=3D '\n'))
> >                        len -=3D 1;
> >
> >                memcpy(__get_str(s), msg, len);
> >                __get_str(s)[len] =3D 0;
> >       ),
> >
> > That trim work could be avoided, *if* all pr_debug() callers are
> > known to have no '\n' to strip.  While that's not true for *all*
> > callsites, it is 99+% true for DRM.debug callsites, and can be made
> > true for some subsets of prdbg/dyndbg callsites.
> >
> > WANTED: macros to validate that a literal format-str has or doesn't
> > have a trailing newline, or to provide or trim trailing newline(s?).
> > Should be usable in TP_printk* defns, for use in new event defns.
> >
> > Cc: <rostedt@goodmis.org>
> > Cc: Vincent Whitchurch <vincent.whitchurch@axis.com>
> > Cc: <daniel@ffwll.ch>
> > Cc: <pmladek@suse.com>
> > Cc: <sergey.senozhatsky@gmail.com>
> > Cc: <john.ogness@linutronix.de>
> > Cc: Simon Ser <contact@emersion.fr>
> > Cc: Sean Paul <seanpaul@chromium.org>
> > Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
> > Signed-off-by: =C5=81ukasz Bartosik <lb@semihalf.com>
> > ---
> >  include/trace/stages/stage3_trace_output.h | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/include/trace/stages/stage3_trace_output.h b/include/trace=
/stages/stage3_trace_output.h
> > index c1fb1355d309..92a79bd5c0cd 100644
> > --- a/include/trace/stages/stage3_trace_output.h
> > +++ b/include/trace/stages/stage3_trace_output.h
> > @@ -19,6 +19,15 @@
> >  #undef __get_str
> >  #define __get_str(field) ((char *)__get_dynamic_array(field))
> >
> > +#undef __get_str_strip_nl
> > +#define __get_str_strip_nl(field)                                    \
> > +     ({                                                              \
> > +             char *s =3D __get_str(field);                            =
 \
> > +             size_t len =3D strlen(s);                                =
 \
> > +             if (len && s[len-1] =3D=3D '\n')                         =
   \
> > +                     s[len-1] =3D '\0'; s;                            =
 \
> > +     })
>
> I'd be worried about modifying the string itself as you are doing above.
> That's modifying the source which may have unintended consequences.
>
> That said, there's a trace_seq that is available for stage 3 called "p".
> You can use that:
>
> #define __get_str_strip_nl(field)                                       \
>         ({                                                              \
>                 char *s =3D trace_seq_buffer_ptr(p);                     =
 \
>                 size_t len;                                             \
>                 trace_seq_printf(p, "%s", __get_str(field));            \
>                 trace_seq_putc(p, '\0');                                \
>                 len =3D strlen(s);                                       =
 \
>                 if (len && s[len-1] =3D=3D '\n')                         =
   \
>                         s[len-1] =3D '\0';                               =
 \
>                 s;                                                      \
>         })
>
> -- Steve
>

Thank you Steve. I will update the __get_str_strip_nl macro per your
recommendation.

> > +
> >  #undef __get_rel_dynamic_array
> >  #define __get_rel_dynamic_array(field)                                =
       \
> >               ((void *)__entry +                                      \
>
