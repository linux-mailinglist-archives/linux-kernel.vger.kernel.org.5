Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B34757E8172
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 19:29:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345980AbjKJS2Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 13:28:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345759AbjKJSZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 13:25:47 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C96DA39CE7
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 06:51:10 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-53de0d1dc46so3653517a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 06:51:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google; t=1699627869; x=1700232669; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BlU5fuUAAXzRyII6mZ8VRiyVHILwlJP0DbHkVOJMbeQ=;
        b=h+Zs3+cowwBXMPtgAEcJa/9lmN+sm9XhtFrQlNuzSX7h3+JHG1OwxfAydQHseKCSkE
         bOsLARcHvqwnLGF99MJuUTFJukzBvIvQ2Z3OzS1cbNbQUgO4txp1JOWQzcW/XsukVljX
         knW3J6bi8kealBdNE3Ws4U5p1t9onziDyr9+e8Chg+9mPwpmt70g/UjFHiWFCxvoCfKd
         crYu96timwJNzi3v+0kpnzVo3jkRDhZY0btZ5FmwxOvWCcWfXxESngZs/3Pe1yI0XmNx
         4A88CiXeCE1XJN8lU8GwpIPDp9ff/vpa6vlElGCZl93MQbAOPT8AEmXnJBWKx9aks89E
         c8Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699627869; x=1700232669;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BlU5fuUAAXzRyII6mZ8VRiyVHILwlJP0DbHkVOJMbeQ=;
        b=mKnA7RH9abC//dtXQyrWhs3RFiposlsBra5ym4Wt1wc1x9tPDJ62qXLElwIf5BzTJJ
         xT2LWF1Ifr1agpyNtHB3+QYyGp3VCkiWcoBtzGSCFWoeqQp3hX7OmUqoKWFyf8abyTYF
         Yu3L3x7dn1ER8P7vLPZ+QIvcEbORZ8qyRmW5T82sMKbIKsxboIk/OPYKDI9x08SC7Whc
         MqzbWSIlq9Jr6wmV61WMUHgsdYmSsrN6hX4P9Xx+3nzYDhHWqGo2DcCPldElzohcIfyJ
         SITicIfIUAhQ6rvyIGiYNUObUuRH/yMZDuWIapUt8NT2dPymkj9B2fYRwoDTS+ySsapQ
         UGgQ==
X-Gm-Message-State: AOJu0YyuA2AHYpt7BwgRY84e2iapjtCPzN3UuyTnEtGkNzbSX99hh1tV
        m8z67otiind2IlPb9/XHqFYdj0mHWENZ5UNDhuQB
X-Google-Smtp-Source: AGHT+IHmy/qXxnVsqUrwt0UHvYdDawc0UVoFc15LekvC0wcMXIiaqsKO8DJvlJYknm4amEcJmaDUY3KdAGGFUo9XJKI=
X-Received: by 2002:a50:8d12:0:b0:53e:8e2e:2b8f with SMTP id
 s18-20020a508d12000000b0053e8e2e2b8fmr6376591eds.9.1699627869203; Fri, 10 Nov
 2023 06:51:09 -0800 (PST)
MIME-Version: 1.0
References: <20231103131011.1316396-1-lb@semihalf.com> <20231103131011.1316396-5-lb@semihalf.com>
 <20231106185513.79411f9a@gandalf.local.home>
In-Reply-To: <20231106185513.79411f9a@gandalf.local.home>
From:   =?UTF-8?Q?=C5=81ukasz_Bartosik?= <lb@semihalf.com>
Date:   Fri, 10 Nov 2023 15:50:58 +0100
Message-ID: <CAK8Bye+eAad4Lx6BWztD4Eax_WLyGB39oV2VFDfL5pGJJTYgcw@mail.gmail.com>
Subject: Re: [PATCH v1 04/12] dyndbg: add 2 trace-events: pr_debug, dev_dbg
To:     Steven Rostedt <rostedt@goodmis.org>,
        Jim Cromie <jim.cromie@gmail.com>
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
        upstream@semihalf.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wt., 7 lis 2023 o 00:55 Steven Rostedt <rostedt@goodmis.org> napisa=C5=82(a=
):
>
> On Fri,  3 Nov 2023 14:10:03 +0100
> =C5=81ukasz Bartosik <lb@semihalf.com> wrote:
>
> > +/* capture pr_debug() callsite descriptor and message */
> > +TRACE_EVENT(prdbg,
> > +         TP_PROTO(const struct _ddebug *desc, const char *text, size_t=
 len),
> > +
> > +         TP_ARGS(desc, text, len),
> > +
> > +         TP_STRUCT__entry(
> > +                     __field(const struct _ddebug *, desc)
> > +                     __dynamic_array(char, msg, len + 1)
> > +                 ),
> > +
> > +         TP_fast_assign(
> > +                     __entry->desc =3D desc;
> > +                     /*
> > +                      * Each trace entry is printed in a new line.
> > +                      * If the msg finishes with '\n', cut it off
> > +                      * to avoid blank lines in the trace.
> > +                      */
> > +                     if (len > 0 && (text[len - 1] =3D=3D '\n'))
> > +                             len -=3D 1;
> > +
> > +                     memcpy(__get_str(msg), text, len);
> > +                     __get_str(msg)[len] =3D 0;
> > +                 ),
> > +
>
>
> > +         TP_printk("%s.%s %s", __entry->desc->modname,
> > +                   __entry->desc->function, __get_str(msg))
> > +);
> > +
>
> That TP_printk() is dangerous. How do you know __entry->desc still exists
> when reading the buffer?
>
> Is the struct _ddebug permanent? Can it be freed? If so, the above can
> easily cause a crash.
>

I assume that we're talking here about the scenario where TP prdbg is
called and before TP_printk runs _ddebug pointer
becomes invalid, is that correct ? If so then I believe this also
applied to __dynamic_pr_debug and other dyndbg functions because there
is also potential for _ddebug pointer to become invalid (in case of
rrmod) before a function dereferences it.

Would it be acceptable to increase reference count of a module and
hold it until at least one callsite in that module is enabled ?
This  would ensure that passed pointer to a _ddebug struct is valid.

> -- Steve
