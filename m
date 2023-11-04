Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACFD27E0D97
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 04:56:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233372AbjKDDkr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 23:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232346AbjKDDkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 23:40:43 -0400
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com [IPv6:2607:f8b0:4864:20::933])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D837E112
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 20:40:40 -0700 (PDT)
Received: by mail-ua1-x933.google.com with SMTP id a1e0cc1a2514c-7ba962d534eso1183519241.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 Nov 2023 20:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699069240; x=1699674040; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X4P3bYh9Zwqy1aAjUWkGY6076o9yDPQdEiqxwE5TUIc=;
        b=kYG++IzsUeuLJeUjiT6oS+DsGT8kGrGm4M3jxaG3rjYLJEp7HFMS2tMLvHx/xRMoi/
         jm0y++rQTZlGcCq6da6FyoOKtzKz5m1rXJw31xA+Y4BbuJekLyY1zz/vctcN7ZRFDW4q
         AkQ1TmUVgN45P1ErBlbhixvqDKusQ4IAyeY2h2nWjBLTyUHle1c2Ou5tyyuN+CLoe30U
         kHTgdUNxbWgjW2XDJzC6M1EWeXqPbLX2dcNAVGl8+UcJV2+FekE2faNEhwgZ+ZoJYQ/Y
         Rp/IGYENLmfS3PzrSCnHY8WYa68mlPBiyoTyddy4rRjYWH/jmD/bIu5rfKrwzz9Q0Ucb
         fPsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699069240; x=1699674040;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X4P3bYh9Zwqy1aAjUWkGY6076o9yDPQdEiqxwE5TUIc=;
        b=EJSsuF3hqc+jAOLKnsLxk6vK3gvEnKdqMwjsyx7mGusmxIqdo8F07KtNgXqsHTKq8Y
         4TNnLJc7+uwrvx45XT3NyZ5aMfpNwLlsfyOLTSLnSl+j2HlzX0KxwGZlrrbd0t5PH8+O
         iSp5aF5uNRMrZLYJ8h1y3i5arfbX82UfFL0OxDBVnWSNP9s+48jnus6ALN09YDoIsAo2
         6ZZ6xJCXYhPQFehIFAmKUDK7DYYUwSihHG3suFXxA+LFq+JcYl7pLZk5FM3wZYLJOKgm
         lBS2GA2sUVHUy7FKTeZdG4CMzxJOWVeNRc5KwxFKNma0Cl3wb9YCUZNUcY1z75eAIJg2
         //Rg==
X-Gm-Message-State: AOJu0YySdNbwibnMG6qAhQ2gKHakpoKghIxSN+5XXsVAGwCvLP/5WkRr
        iY4h5Tt7Zvmm+8evf4XavFFMSkwLLV32ebfhzYI=
X-Google-Smtp-Source: AGHT+IHz+zeClFbd08BRhD2Yin+mZl+xyvhJonkP9youZ6lLqNo8ot2P+riNI9lW1g0F3fXRRfwYY2NRqupQP5TTYWQ=
X-Received: by 2002:a05:6102:205a:b0:45d:9d27:215e with SMTP id
 q26-20020a056102205a00b0045d9d27215emr2936475vsr.20.1699069239954; Fri, 03
 Nov 2023 20:40:39 -0700 (PDT)
MIME-Version: 1.0
References: <20231103131011.1316396-1-lb@semihalf.com> <20231103131011.1316396-6-lb@semihalf.com>
In-Reply-To: <20231103131011.1316396-6-lb@semihalf.com>
From:   jim.cromie@gmail.com
Date:   Fri, 3 Nov 2023 21:40:13 -0600
Message-ID: <CAJfuBxwKXRd1vVtpxCOh7_jWrO3CQU0H+3gOvNkYBt-m3V75pw@mail.gmail.com>
Subject: Re: [PATCH v1 05/12] tracefs: add TP_printk_no_nl - RFC
To:     =?UTF-8?Q?=C5=81ukasz_Bartosik?= <lb@semihalf.com>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Jason Baron <jbaron@akamai.com>,
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
> From: Jim Cromie <jim.cromie@gmail.com>
>
> This variant of TP_printk() does *not* add the trailing newline.  It
> is for use by printk/debug-ish events which already have a trailing
> newline.  Its here to support:
>
> https://lore.kernel.org/lkml/
> 20200825153338.17061-1-vincent.whitchurch@axis.com/
> which taught dyndbg to send pr_debug() msgs to tracefs, via -x/T flag.
>
> It "reused" the include/trace/events/printk.h console event,
> which does the following:
>
>         TP_fast_assign(
>                 /*
>                  * Each trace entry is printed in a new line.
>                  * If the msg finishes with '\n', cut it off
>                  * to avoid blank lines in the trace.
>                  */
>                 if ((len > 0) && (text[len-1] =3D=3D '\n'))
>                         len -=3D 1;
>
>                 memcpy(__get_str(msg), text, len);
>                 __get_str(msg)[len] =3D 0;
>         ),
>
> That trim work could be avoided, *iff* all pr_debug() callers are
> known to have no '\n' to strip.  While thats not true for *all*
> callsites, it is 99+% true for DRM.debug callsites, and can be made
> true for some subsets of prdbg/dyndbg callsites.

some or all of DRM.debug messages (that I audited / caught)
were merged by Maxime recently, I;ll go back (later) to see if I missed any=
.

>
> WANTED: macros to validate that a literal format-str has or doesn't
> have a trailing newline, or to provide or trim trailing newline(s?).
> Should be usable in TP_printk* defns, for use in new event defns.

that might be over-optimizing

Steve,
IIRC you considered adding \n where needed.
is there anything gained (conceivably) by not just adding the trailing
\n when "needed" ?
statistically, macros could get us to 99.99+ "compliance"
IIRC - the "needed" seems correct.


>
> Cc: <rostedt@goodmis.org>
> Cc: Vincent Whitchurch <vincent.whitchurch@axis.com>
> Cc: <daniel@ffwll.ch>
> Cc: <pmladek@suse.com>
> Cc: <sergey.senozhatsky@gmail.com>
> Cc: <john.ogness@linutronix.de>
> Cc: Simon Ser <contact@emersion.fr>
> Cc: Sean Paul <seanpaul@chromium.org>
> Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
> ---
>  include/trace/stages/stage3_trace_output.h | 3 +++
>  include/trace/stages/stage7_class_define.h | 3 +++
>  2 files changed, 6 insertions(+)
>
> diff --git a/include/trace/stages/stage3_trace_output.h b/include/trace/s=
tages/stage3_trace_output.h
> index c1fb1355d309..5f5c1374fa10 100644
> --- a/include/trace/stages/stage3_trace_output.h
> +++ b/include/trace/stages/stage3_trace_output.h
> @@ -8,6 +8,9 @@
>  #undef TP_printk
>  #define TP_printk(fmt, args...) fmt "\n", args
>
> +#undef TP_printk_no_nl
> +#define TP_printk_no_nl(fmt, args...) fmt, args
> +
>  #undef __get_dynamic_array
>  #define __get_dynamic_array(field)     \
>                 ((void *)__entry + (__entry->__data_loc_##field & 0xffff)=
)
> diff --git a/include/trace/stages/stage7_class_define.h b/include/trace/s=
tages/stage7_class_define.h
> index bcb960d16fc0..8247e4478f19 100644
> --- a/include/trace/stages/stage7_class_define.h
> +++ b/include/trace/stages/stage7_class_define.h
> @@ -37,3 +37,6 @@
>
>  #undef TP_printk
>  #define TP_printk(fmt, args...) "\"" fmt "\", "  __stringify(args)
> +
> +#undef TP_printk_no_nl
> +#define TP_printk_no_nl(fmt, args...) "\"" fmt "\", "  __stringify(args)
> --
> 2.42.0.869.gea05f2083d-goog
>
