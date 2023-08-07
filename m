Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F41C4772D71
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 20:02:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbjHGSCS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 14:02:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjHGSCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 14:02:16 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64689170B
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 11:02:15 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-5231f439968so4601463a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 11:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google; t=1691431332; x=1692036132;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GI8Hutnt26EHj7tuULT6Fix2Lq+EUTecU3vE9W0dfXo=;
        b=lxypjkYz0xj4BrP4ej7Y3x5ckVbmUAkMy+yYAqys8TO2qScWXqIHP9mTEU/Zy+ltwu
         I2aGtdxpPgH6zKiE4MLgmkvq8qG+2FSo6xMRBnsiU9DANkolm+RJPdif4QE023Efysn1
         +MYBexoxMLstHnb8NgQ2uhe/ETP0P1K62f5f8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691431332; x=1692036132;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GI8Hutnt26EHj7tuULT6Fix2Lq+EUTecU3vE9W0dfXo=;
        b=UpegFrMcmB04anL8oS92uDz0uikatn+fepZhB2YFb2GFU5ksqOZatACS2BK6nAF9j1
         K+fynnWQlVeSJknblCERC4jJbpqoTuOIFu8JswFISNVrepdoVUOHAXqozFEeYwunbVrQ
         8XUqFZgf2Zhmmgu44Hk7kwy95rkAg6PXu66bhzI510/aslOXQfMM+Zanf+B3P9g7AcEk
         eyIDsbK8E5v1Ew9MzZtNLyCwMpHlMQ2fhXLAjrsrMla2XC34KssgyspQB3l26do+r22G
         UB7AoACDUtuarmLHn0zTX/JmHeAQIhQx1wGTtofP+DRU0Dp2AKEoQWc+/96z04jLN097
         bfPg==
X-Gm-Message-State: AOJu0YwUtn4huyBHoaU3jUBGvCp/cJQ/kQw4aTp8Gpq7vfP3yPveYj1a
        XUToDU5uiIufB88qgWdF6aqZ1cog26kj8boSmNzmjA==
X-Google-Smtp-Source: AGHT+IG1C5gLEN7sbyvaRaUtSjHslMtvJ90Jnl8Eh3YMXZ3oq2Qnrr165w6xl1zeuWEvq6uXD0SI1lUA+65CK4obTRc=
X-Received: by 2002:a05:6402:517a:b0:522:2f8c:8953 with SMTP id
 d26-20020a056402517a00b005222f8c8953mr8039951ede.39.1691431332079; Mon, 07
 Aug 2023 11:02:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230718000737.49077-1-ivan@cloudflare.com> <CABWYdi2E1XozvwsZwOA80X-YbqLejj_5sxzNAh7w6R93rD5sCw@mail.gmail.com>
 <CAP-5=fUe5JxXK3gPAGcR279xDVmFarotHvb2Gk19u5SAOboGtg@mail.gmail.com>
In-Reply-To: <CAP-5=fUe5JxXK3gPAGcR279xDVmFarotHvb2Gk19u5SAOboGtg@mail.gmail.com>
From:   Ivan Babrou <ivan@cloudflare.com>
Date:   Mon, 7 Aug 2023 11:02:01 -0700
Message-ID: <CABWYdi2MwP1u5V+RCpvSjqazo7rS9h_oZoJN6o0UoWFdSQNOyQ@mail.gmail.com>
Subject: Re: [PATCH] perf script: print cgroup on the same line as comm
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Ian Rogers <irogers@google.com>, linux-perf-users@vger.kernel.org,
        kernel-team@cloudflare.com, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 28, 2023 at 10:57=E2=80=AFAM Ian Rogers <irogers@google.com> wr=
ote:
>
> On Fri, Jul 28, 2023 at 10:42=E2=80=AFAM Ivan Babrou <ivan@cloudflare.com=
> wrote:
> >
> > On Mon, Jul 17, 2023 at 5:07=E2=80=AFPM Ivan Babrou <ivan@cloudflare.co=
m> wrote:
> > >
> > > Commit 3fd7a168bf51 ("perf script: Add 'cgroup' field for output")
> > > added support for printing cgroup path in perf script output.
> > >
> > > It was okay if you didn't want any stacks:
> > >
> > >     $ sudo perf script --comms jpegtran:23f4bf -F comm,tid,cpu,time,c=
group
> > >     jpegtran:23f4bf 3321915 [013] 404718.587488:  /idle.slice/polish.=
service
> > >     jpegtran:23f4bf 3321915 [031] 404718.592073:  /idle.slice/polish.=
service
> > >
> > > With stacks it gets messier as cgroup is printed after the stack:
> > >
> > >     $ perf script --comms jpegtran:23f4bf -F comm,tid,cpu,time,cgroup=
,ip,sym
> > >     jpegtran:23f4bf 3321915 [013] 404718.587488:
> > >                     5c554 compress_output
> > >                     570d9 jpeg_finish_compress
> > >                     3476e jpegtran_main
> > >                     330ee jpegtran::main
> > >                     326e2 core::ops::function::FnOnce::call_once (inl=
ined)
> > >                     326e2 std::sys_common::backtrace::__rust_begin_sh=
ort_backtrace
> > >     /idle.slice/polish.service
> > >     jpegtran:23f4bf 3321915 [031] 404718.592073:
> > >                     8474d jsimd_encode_mcu_AC_first_prepare_sse2.PADD=
ING
> > >                 55af68e62fff [unknown]
> > >     /idle.slice/polish.service
> > >
> > > Let's instead print cgroup on the same line as comm:
> > >
> > >     $ perf script --comms jpegtran:23f4bf -F comm,tid,cpu,time,cgroup=
,ip,sym
> > >     jpegtran:23f4bf 3321915 [013] 404718.587488:  /idle.slice/polish.=
service
> > >                     5c554 compress_output
> > >                     570d9 jpeg_finish_compress
> > >                     3476e jpegtran_main
> > >                     330ee jpegtran::main
> > >                     326e2 core::ops::function::FnOnce::call_once (inl=
ined)
> > >                     326e2 std::sys_common::backtrace::__rust_begin_sh=
ort_backtrace
> > >
> > >     jpegtran:23f4bf 3321915 [031] 404718.592073:  /idle.slice/polish.=
service
> > >                     8474d jsimd_encode_mcu_AC_first_prepare_sse2.PADD=
ING
> > >                 55af68e62fff [unknown]
> > >
> > > Signed-off-by: Ivan Babrou <ivan@cloudflare.com>
> > > Fixes: 3fd7a168bf51 ("perf script: Add 'cgroup' field for output")
>
> This change makes sense to me. Namhyung, wdyt?
>
> Thanks,
> Ian

Hi Namhyung,

This is a really trivial patch and it would be good to get a word from you.

Thanks.

> > > ---
> > >  tools/perf/builtin-script.c | 22 +++++++++++-----------
> > >  1 file changed, 11 insertions(+), 11 deletions(-)
> > >
> > > diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.=
c
> > > index 200b3e7ea8da..517bf25750c8 100644
> > > --- a/tools/perf/builtin-script.c
> > > +++ b/tools/perf/builtin-script.c
> > > @@ -2199,6 +2199,17 @@ static void process_event(struct perf_script *=
script,
> > >         if (PRINT_FIELD(RETIRE_LAT))
> > >                 fprintf(fp, "%16" PRIu16, sample->retire_lat);
> > >
> > > +       if (PRINT_FIELD(CGROUP)) {
> > > +               const char *cgrp_name;
> > > +               struct cgroup *cgrp =3D cgroup__find(machine->env,
> > > +                                                  sample->cgroup);
> > > +               if (cgrp !=3D NULL)
> > > +                       cgrp_name =3D cgrp->name;
> > > +               else
> > > +                       cgrp_name =3D "unknown";
> > > +               fprintf(fp, " %s", cgrp_name);
> > > +       }
> > > +
> > >         if (PRINT_FIELD(IP)) {
> > >                 struct callchain_cursor *cursor =3D NULL;
> > >
> > > @@ -2243,17 +2254,6 @@ static void process_event(struct perf_script *=
script,
> > >         if (PRINT_FIELD(CODE_PAGE_SIZE))
> > >                 fprintf(fp, " %s", get_page_size_name(sample->code_pa=
ge_size, str));
> > >
> > > -       if (PRINT_FIELD(CGROUP)) {
> > > -               const char *cgrp_name;
> > > -               struct cgroup *cgrp =3D cgroup__find(machine->env,
> > > -                                                  sample->cgroup);
> > > -               if (cgrp !=3D NULL)
> > > -                       cgrp_name =3D cgrp->name;
> > > -               else
> > > -                       cgrp_name =3D "unknown";
> > > -               fprintf(fp, " %s", cgrp_name);
> > > -       }
> > > -
> > >         perf_sample__fprintf_ipc(sample, attr, fp);
> > >
> > >         fprintf(fp, "\n");
> > > --
> > > 2.41.0
> > >
> >
> > A friendly bump in case this slipped through the cracks.
