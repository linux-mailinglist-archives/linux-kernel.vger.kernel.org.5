Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 789CC76E9AA
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 15:12:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236134AbjHCNMO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 09:12:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236089AbjHCNLw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 09:11:52 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B2BF49DB;
        Thu,  3 Aug 2023 06:10:17 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2b9b904bb04so14850421fa.1;
        Thu, 03 Aug 2023 06:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691068159; x=1691672959;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hggt/guN/s0OCe/jOd+7wybtj8ncYfoyjQ4rWZM42+M=;
        b=gthuKanaZgY2Zah5iOoqTulMflqJWdQBygbx8cqeceD5knZlynTaDCKF5pyfiyhvy3
         MvjPa8km8jB4k8osAbSZwgHGHF7yFFhg+lZbAlbXqvVOcYFOCejYmBMycAjEcb/lE8kt
         CTEnU22w25q0iyWHwqKeA8ZEh57FBU3PSUAmQ81643M2UCR/I3DxN8SBKawcMb703avG
         BTYugvKvMElFy+Ton0tj898JLjYRmzsRvqCjPSpDgV41xbrbT/N4+ZXr95i+4Z+IPbS6
         lqEkK84jCqyr2Xdt5/q7DhxUrYHI8u0WQECxBjMjNYBc0xmObQy/nrJ7fjFyKew5SBd+
         rdqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691068159; x=1691672959;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hggt/guN/s0OCe/jOd+7wybtj8ncYfoyjQ4rWZM42+M=;
        b=IKeMvXF/cGxy4/uIKLjsKPr5p8VXSzCtkNrCXmInNMhiuASmmChLEGe8278zcN7c69
         WmhxcAPhyHixmgSjdRMGcqk6FQOHLBcW8Z74B/7hkiBDli1q82qJX9i/wRMUUgHfQ7fb
         7nTY+L85eSs8wAIvMQKb+L+7DiC6A1K1bbOnh+uZY5Vl3Krk2jKqLtGkGrErwhPV5Drv
         HvrVuJfdMzDXxhhc0vrGlVA6MPgNw1WHMDxHyzqU0/UgJSKCsCI4R604eWk8mfPZ5+0G
         O/+11SArgbgOYjZCev40R2dp0vsgvHwugvuIRZaUIkXD2X2s08u0Y1NG3xLK+R3phqrV
         FWlQ==
X-Gm-Message-State: ABy/qLbwCjxETcjAy+c9IprILTyNfTrukXNru9a8FWF6JLBOuewaZRyK
        IZl21/x7+HZLo5GpiIY2jsUEVQWf5JTUmq5efjY=
X-Google-Smtp-Source: APBJJlGJ+LJcKhAAgAOtvbLwC5s6zqQ2uDe4wo0o4+tDavh8h3mqg8TvwQ/lnVregHN/8BY5Z3+0qA/l/wX6GA76Ve0=
X-Received: by 2002:ac2:44d4:0:b0:4fb:93db:fff3 with SMTP id
 d20-20020ac244d4000000b004fb93dbfff3mr6797726lfm.16.1691068159394; Thu, 03
 Aug 2023 06:09:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230803083352.1585-1-zegao@tencent.com> <20230803083352.1585-5-zegao@tencent.com>
 <20230803085909.GH212435@hirez.programming.kicks-ass.net>
In-Reply-To: <20230803085909.GH212435@hirez.programming.kicks-ass.net>
From:   Ze Gao <zegao2021@gmail.com>
Date:   Thu, 3 Aug 2023 21:09:08 +0800
Message-ID: <CAD8CoPCUsTxWuWEaL_ggp4GQYPLiYMbQwJxds9z4EoHxkuc-5g@mail.gmail.com>
Subject: Re: [RFC PATCH v6 4/5] sched, tracing: add to report task state in
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
        linux-trace-kernel@vger.kernel.org, Ze Gao <zegao@tencent.com>
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

On Thu, Aug 3, 2023 at 4:59=E2=80=AFPM Peter Zijlstra <peterz@infradead.org=
> wrote:
>
> On Thu, Aug 03, 2023 at 04:33:51AM -0400, Ze Gao wrote:
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
> >
> > Signed-off-by: Ze Gao <zegao@tencent.com>
> > Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > Acked-by: Ian Rogers <irogers@google.com>
>
> I'm not sure you've actually read any of the things I've written. I hate
> this. Not going to happen.

With all due respect, I'm afraid I've read so much carefully every word
you replied, I am just not fully convinced and still believe this is someth=
ing
needs a fix but apparently you strongly refuse.

So I'm considering giving up this patch and only fixing the surface problem
to make everyone happy.

Thanks for taking your time on this topic.

Regards,
Ze
