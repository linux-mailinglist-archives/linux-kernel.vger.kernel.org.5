Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FCF076B562
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 15:04:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232757AbjHANEI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 09:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231502AbjHANEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 09:04:06 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18468E6;
        Tue,  1 Aug 2023 06:04:05 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4fe21e7f3d1so6370794e87.3;
        Tue, 01 Aug 2023 06:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690895043; x=1691499843;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ESOJn7ONX5e3KsUtVteD7jAuVQBZSQbe5TvZKAUJyX8=;
        b=IoASiyGxFXMTHGJ9ZFj2Mszo2J4M+dr0WujwXHVx95AifbGPIZa+wlmAMVJ+E4Z3X9
         xUtLx+UJMeM2FeSIw/lmt2vjGe+5YsyJPiloHf7nYuQ5s61oia8YG6isNatrEK7m0i/g
         Llo0n4QBzEfVP2BASzko88jI5McpBAc1jWj7DS2iJUR7oPIA70c0erY6GGRhMCqZufZW
         MdQ/cESX+mo3pI5e66BbYgJksMoqun7Qd7b7Su80A4q3Tls28TEuWgNs6glcBHVygXJO
         vDjZaOTLtycFzNRQ4wgSdwi8S3SiyKy8vYdbjdEMeSnEKtTs8QN119xQ4nxdhs2l3hFq
         b7Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690895043; x=1691499843;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ESOJn7ONX5e3KsUtVteD7jAuVQBZSQbe5TvZKAUJyX8=;
        b=HGdNEB4kVs2zcl73wEgXOHWXirJWvEmVfWrwH9kinFp5Zrl6kqo/IqE+BVfJd+jRkK
         f8DVpRgnos6O14/uPJ9hHhBJq/8gHN9XGb+dhJE2C5Z0xG8sIn+M66Y0byIgveo7EWCr
         4tfw6mK+yaduUsOyfejTlHErJNdUWuUqnAOiPF2sf9bD/DIfPaJMzTBJmwrbSVncLn9Z
         gPAKrGj0OpH5KRug4Gny5SV2yDtWLZF3XHwz8IFLgG0X/RMVnfNAz3QrcyBDpH6rjoU5
         qkig0N4jiKdUx0gHQrtWuW2vV4TbWX4Gp1JP3HhJ8pKpAu6mUZa/UXcCf7unGHQspfUO
         PIQg==
X-Gm-Message-State: ABy/qLatTueFJy5BOAT3gWnWFewkn0KtHwVqKCkobV7j9HW8T03rkcUt
        fTqEL5o3hIEJ0Cmvf62ZUHvM23vZ+ThGlBkRjxs=
X-Google-Smtp-Source: APBJJlFpmDaP7mIbTs7l60A9w0PLxLS6C5KHMw/Q8UTIvkcTJfIJCWAvNWpCa4uyst/3e9LTRwn32e2wxuimvx/vahw=
X-Received: by 2002:a05:6512:20cd:b0:4f8:70d8:28f8 with SMTP id
 u13-20020a05651220cd00b004f870d828f8mr2028017lfr.55.1690895043030; Tue, 01
 Aug 2023 06:04:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230801090124.8050-1-zegao@tencent.com> <20230801090124.8050-4-zegao@tencent.com>
 <20230801113401.GC79828@hirez.programming.kicks-ass.net>
In-Reply-To: <20230801113401.GC79828@hirez.programming.kicks-ass.net>
From:   Ze Gao <zegao2021@gmail.com>
Date:   Tue, 1 Aug 2023 21:03:51 +0800
Message-ID: <CAD8CoPA-cqe+hY8dHjO+6WhcL2VKy2Wq=rYSSkwUqBFRJ4ECWg@mail.gmail.com>
Subject: Re: [RFC PATCH v3 3/6] sched, tracing: add to report task state in
 symbolic chars
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org,
        linux-trace-devel@vger.kernel.org, Ze Gao <zegao@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 1, 2023 at 7:34=E2=80=AFPM Peter Zijlstra <peterz@infradead.org=
> wrote:
>
> On Tue, Aug 01, 2023 at 05:01:21PM +0800, Ze Gao wrote:
> > Internal representations of task state are likely to be changed
> > or ordered, and reporting them to userspace without exporting
> > them as part of API is basically wrong, which can easily break
> > a userspace observability tool as kernel evolves. For example,
> > perf suffers from this and still reports wrong states as of this
> > writing.
> >
> > OTOH, some masqueraded states like TASK_REPORT_IDLE and
> > TASK_REPORT_MAX are also reported inadvertently, which confuses
> > things even more and most userspace tools do not even take them
> > into consideration.
> >
> > So add a new variable in company with the old raw value to
> > report task state in symbolic chars, which are self-explaining
> > and no further translation is needed. Of course this does not
> > break any userspace tool.
> >
> > Note for PREEMPT_ACTIVE, we introduce 'p' to report it and use
> > the old conventions for the rest.
>
> *sigh*... just because userspace if daft, we need to change the kernel?

Hi Peter,

Sorry that I don't quite agree with you on this one.

It's just the design that exporting internal details is fundamentally wrong=
.
And even worse,  I did not see any userspace tool is aware of masqueraded
states like TASK_REPORT_IDLE and TASK_REPORT_MAX and let alone
parse it correctly.  This confused me a lot when I decided to write my own =
bpf
version of sched-latency analysis tool and only after I figured out everyth=
ing
underneath, I started to make things right here.

Again, I mean it's not me that deliberately "breaks" ABI here and I am
never meant
to upset anyone.  My confusion is why did people forget to update in-tree p=
erf
the very last time they decide to rearrange the task state mapping
since we all agree
this is important "ABI" here.  I don't think it's the tool's fault.
And that's my initiative
to request this RFC.

> Why do we need this character anyway, why not just print the state in
> hex and leave it at that? These single character state things are a
> relic, please just let them die.

I believe hex is ok only after having the reported task state mapping
appear in the
uapi headers, otherwise it's still useless to userspace especially for
value like
TASK_REPORT_IDLE and TASK_REPORT_MAX, which need to dig into the
kernel to see what the hell is going on here.

Thoughts?

Regards,
Ze
