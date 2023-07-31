Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CF607692E6
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 12:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232413AbjGaKRl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 06:17:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232218AbjGaKRf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 06:17:35 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2180810D5;
        Mon, 31 Jul 2023 03:17:25 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-52256241c66so9047265a12.1;
        Mon, 31 Jul 2023 03:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690798644; x=1691403444;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CXiGRTcr5MmLzRrYiT9TQhAL1SVOTO+sDF4VeUAvGqs=;
        b=dWqYPSfAO+8WjXGBR5YYcjK33gynP8gxT7yczSDk13JfLzCvBcwdN5TMEoAHG3cY0h
         ejbT4X+GcjZbxqkdupC4xjoxmDxjgUSODZNqXpPe1qXp0oZrh/+mgo2FSvey7Y0rdJIX
         zoMZbSlFPU67M7NOWuH93PSWfV+5VjK2rZ/qFMMLN/Z8gxaJHtnb4Tm9vQutjA6eZHAk
         zknXVWTiHf1xixC7+lnMxOy1u3ypDWIONamq9v6CxoujC44Uzoo/mZQOzV5VWy+DzY2e
         3ltMJ2WDHPTyNzVw5HY2KfgmlHpaT/zqHPHRvhkFxgxPXqWDaSFZnMayWY4iviX8xI2S
         GuJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690798644; x=1691403444;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CXiGRTcr5MmLzRrYiT9TQhAL1SVOTO+sDF4VeUAvGqs=;
        b=OYeQxZtIwm782/TL+wF4m4v91F4KWXqK51BlGyGfsHs7PnYOC5zjmSV6QOvIFCRZ7C
         lRFXyWbH+uo6lwkORizaL0TQ/39ekrVoGVOtZCQM3Xesv4dVAJ564nTxwTY9AWXIMJo9
         nq2rTt3HTN0RJNRimSUKOrf4isHasFHQ8phLLbfEODbrXC3FTEq8fHCqbPzcFbHtwtTC
         FCe7lkbPdCZEpfeZEqugrMlTFogQkg+bBpYkHa5fvJnGSzxW4RXfm0oNXtS4zZ3hNuT1
         9lcB9NjDOu4UnE0j3ociMsFloAhYP+5lhHttuxG5bGyzuUG7N6P6uIcA59UTUVWL03a2
         Sqdg==
X-Gm-Message-State: ABy/qLYMX3zeT1rX9httRXGgyo9NmsvRm609wxsJmcxvbtpdJAtYXHEg
        NW4CWyBgtZwX9AG0sMBxh1lwMI7JDaYkT2TlUMI=
X-Google-Smtp-Source: APBJJlEl1pSOq58OsusTT85TEubZsY4FjctGCi2DSQJkWxlNRpmU0ht7TEycBMzm3AnQw6NJzXstellJAFmIqhHFpYw=
X-Received: by 2002:a05:6402:393:b0:522:3a1d:c233 with SMTP id
 o19-20020a056402039300b005223a1dc233mr11405883edv.11.1690798643969; Mon, 31
 Jul 2023 03:17:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230726121618.19198-1-zegao@tencent.com> <20230726121618.19198-2-zegao@tencent.com>
 <20230731093655.GC29590@hirez.programming.kicks-ass.net>
In-Reply-To: <20230731093655.GC29590@hirez.programming.kicks-ass.net>
From:   Ze Gao <zegao2021@gmail.com>
Date:   Mon, 31 Jul 2023 18:17:12 +0800
Message-ID: <CAD8CoPABfCBmGvg5WnJQ6+=wmz7dNTY=ubd9nahVvzDOvo9t2g@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/3] sched, tracing: add to report task state in
 symbolic chars
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
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

On Mon, Jul 31, 2023 at 5:37=E2=80=AFPM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Wed, Jul 26, 2023 at 08:16:16PM +0800, Ze Gao wrote:
> > Internal representations of task state are likely to be changed or
> > ordered, and reporting them to userspace without exporting them as
> > part of API is not a good choice, which can easily break a userspace
> > observability tool as kernel evolves. For example, perf suffers from
> > this and still reports wrong states by this patch.
> >
> > OTOH, some masqueraded state like TASK_REPORT_IDLE and TASK_REPORT_MAX
> > are also reported inadvertently, which confuses things even more.
> >
> > So add a new variable in company with the old raw value to report task
> > state in symbolic char, which is self-explaining and no further
> > translation is needed, and also report priorities in 'short' to save
> > some buffer space.  Of course this does not break any userspace tool.
> >
> > Note for PREEMPT_ACTIVE, we introduce 'p' to report it and use the old
> > conventions for the rest.
>
> So I really dont much like this. This looses the ability to see the
> actual wait state flags, there could be multiple. Eg, things like
> TASK_FREEZEABLE gets lost completely.

How about adding a new char for each distinct state you want to report
, e.g., 'F' for this for debug purposes ? I don;t think we can lose the
multiple flags just because we choose to report in chars. Still people
can use the old raw value since we do not replace but supplement it here.

Regards,
Ze
