Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32FA676A252
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 23:02:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230510AbjGaVCA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 17:02:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbjGaVB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 17:01:57 -0400
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AED1B198D
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 14:01:55 -0700 (PDT)
Received: by mail-vs1-xe29.google.com with SMTP id ada2fe7eead31-4475ae93951so1767945137.0
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 14:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690837315; x=1691442115;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w9Ajc/Q/aSEzpsarGiqPGNwelTZkyv30EKr6AMXNltw=;
        b=GO23x+eR+N5vMpx8YM5i7HFzlSK4rdXOA60Q+0GZVyOecRyaveDVhYdD9jnsJyEbZR
         T8PO5lGlilZPKuYOO5aV5fFvqT807dBS3bn54+3CE8lhtfg4rd+OxFbGhSDN8dVpLuCV
         H6rweGWZML4rXm3SLHijXyf3q0U+U777wrAlKuHieYlYeQ41aaP3USy4ytA6uRnIlEml
         +UX86b/4uuptDWqqscmN4rYyCFVWupH5UNxRp1iqSfFZJuUZi8kCeeI77UKa7AQRx9Yz
         jZ08i6Y2Eq6VMXUGSM1NRWxwC6Ubhc3zE1Z2iZcDOYbc8c5idePxGCbs6NW6UJZwbDJB
         1QYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690837315; x=1691442115;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w9Ajc/Q/aSEzpsarGiqPGNwelTZkyv30EKr6AMXNltw=;
        b=MhtMWnt7q0vzsfVaZ3as8J5RjfohH/rczuJfpgWYBv0Zmb9v+GMenPIApSdYZ2xlY7
         1JQKO2atMvSfp+UbzuOl+as6perVDq1v89mtIkJhUqszfjSbDGEqAgS+SuJVERP7aqdq
         LX2Y4STRi37VdF6WbDXk1F/MfZ2oQXzs5X1soSZqLUlWpFLNH5P5KmAKFXyveUpNQhDd
         WYpZsZf6p2nD3NEjqeLxk1+YUJ+JyqLwxSJ991sn8bCOsZmYCkX732xdX2VE5iN+HWSa
         2sEUYQl4T7tLEEpEOqVezqEKQMt8VxPRtgOdHqWAFgjSoVyjIfl1uCck1BDCfjOfWEGL
         hyRA==
X-Gm-Message-State: ABy/qLa4ARQ2tvg9fMrdtA7UUcrNDAy8mMV7H6e0A4R4xinvipspXOwB
        yLWQI01VP66rjoTGkbXoISpxze1cG2ozMKPThcs=
X-Google-Smtp-Source: APBJJlEd0qR76K5jXvUgArnEUdFYGsXhZ2QoYVqhqZiyA/CoJcQsSFNAHMHLSPI7Q7hbEFk9x+gYwUrKPE9SugHrLQo=
X-Received: by 2002:a67:e453:0:b0:445:91b:385d with SMTP id
 n19-20020a67e453000000b00445091b385dmr1115282vsm.12.1690837314684; Mon, 31
 Jul 2023 14:01:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230730222134.54547-1-jim.cromie@gmail.com> <87y1iwlc80.fsf@jogness.linutronix.de>
 <ZMeLKTzSWh3kbw8c@alley> <20230731112122.41a76154@gandalf.local.home>
In-Reply-To: <20230731112122.41a76154@gandalf.local.home>
From:   jim.cromie@gmail.com
Date:   Mon, 31 Jul 2023 15:01:28 -0600
Message-ID: <CAJfuBxyLMO2v4CTUWP8Lhy9EmzjZ3BVxhP1w1S4Cb4siEpVWEQ@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] tracefs: add TP_printk_no_nl - RFC
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Petr Mladek <pmladek@suse.com>,
        John Ogness <john.ogness@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        daniel@ffwll.ch, sergey.senozhatsky@gmail.com,
        Simon Ser <contact@emersion.fr>,
        Sean Paul <seanpaul@chromium.org>
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

On Mon, Jul 31, 2023 at 9:21=E2=80=AFAM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> On Mon, 31 Jul 2023 12:21:29 +0200
> Petr Mladek <pmladek@suse.com> wrote:
>
> > > Grepping through the kernel, I am surprised how many messages are
> > > missing the trailing newline when it is obvious they are not intended=
 to
> > > be extended. I consider these bugs.
> >
> > I consider this bug as well.
> >

agreed.
I blame pr_cont()  at least in part.

Note - I have submitted
drm_dbg: add trailing newlines where missing
https://patchwork.freedesktop.org/series/121583/

it appears to have failed - on what look like unrelated failures - pipe etc


> > My understanding is that this patch affects only messages printed to
> > the ftrace buffer so that it does not affect printk() directly.
> >
> > But still. It creates a habit that is bad for printk(). Also relies
> > on the fact that people are aware of this macro and use it. IMHO,
> > it will not work in practice. Or do I miss something?

something like (opposite of) this, used inside pr_debug, would force
all callers to add \n.
#include <assert.h>
#define FAIL_IF_TRAILING_NEWLINE(str) \
 _Static_assert((str[sizeof(str) - 2] !=3D '\n'), "String literal has a
trailing newline")

obviously, Inverted, gentler versions are perhaps better.

>
> I believe that the problem Jim is addressing is that there's printk()
> messages that also go to a tracepoint() function. The tracepoint function
> will add its own '\n' to the message, and now we have two '\n's and this
> causes extra spaces in the output of the ftrace ring buffer.

Yes. only quibble - there arent yet, there could be.
Vincents patch didnt go in, Im trying to get it ready for another submit.

I uncovered this bit on the way,
figured I could turn it into a question, and maybe a little conceptual buy-=
in.

This is a 0 or 1 "\n" problem,
quietly accepting 25 in a row could paper over another problem.
maybe complain-once after 2-3 ?

TP_printk_no_nl   doesnt solve all problems -
it could work for adding DRM.debug trace-events,
cuz the callsites have few of the bad-habits noted above,
*very* few drm_dbg()s without trailing \n. - presuming theyre fixable.

fixing the larger body of pr_debug()s is quite a nuisance,
and if dyndbg -T flag sends them, you'd get the larger varying
population of \n's
So some real-time stripping /adding is needed for some populations of pr_de=
bugs

the no_nl macro would at least allow event-definers
to assert that theyre sending their own.


>
> Perhaps what we should do is to make sure that the output doesn't add mor=
e
> newlines than just one.
>
> Something like this: (totally untested)
>
> diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
> index db575094c498..a1b73ffa1552 100644
> --- a/kernel/trace/trace_output.c
> +++ b/kernel/trace/trace_output.c
> @@ -333,6 +333,8 @@ int trace_output_raw(struct trace_iterator *iter, cha=
r *name,
>
>         trace_seq_printf(s, "%s: ", name);
>         trace_seq_vprintf(s, trace_event_format(iter, fmt), ap);
> +       trace_seq_trim_newlines(s);
> +       trace_seq_putc(s, '\n');
>
>         return trace_handle_return(s);
>  }
> diff --git a/kernel/trace/trace_seq.c b/kernel/trace/trace_seq.c
> index bac06ee3b98b..d4e2049809e3 100644
> --- a/kernel/trace/trace_seq.c
> +++ b/kernel/trace/trace_seq.c
> @@ -221,6 +221,22 @@ void trace_seq_puts(struct trace_seq *s, const char =
*str)
>  }
>  EXPORT_SYMBOL_GPL(trace_seq_puts);
>
> +/**
> + * trace_seq_trim_newlines - remove ending newlines
> + * @s: trace sequence descriptor
> + *
> + * Remove ending newlines from the buffer.
> + */
> +void trace_seq_trim_newlines(struct trace_seq *s)
> +{
> +       if (unlikely(!s->seq.size || !s->seq.len))
> +               return;
> +
> +       while (s->seq.len && s->buffer[s->seq.len - 1] =3D=3D '\n') {
> +               s->seq.len--;
> +       }
> +}
> +
>  /**
>   * trace_seq_putc - trace sequence printing of simple character
>   * @s: trace sequence descriptor
>
>
>
> A similar thing would need to go into libtraceevent.
>
> -- Steve
