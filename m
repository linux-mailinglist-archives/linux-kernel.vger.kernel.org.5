Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4BBE7E196C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 05:43:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbjKFEng convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 5 Nov 2023 23:43:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbjKFEnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 23:43:35 -0500
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50B99DB;
        Sun,  5 Nov 2023 20:43:32 -0800 (PST)
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-5bbd3eb2f8fso4002441a12.1;
        Sun, 05 Nov 2023 20:43:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699245812; x=1699850612;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6C2jeN2Odetxmw6gVUouX0/vQcl2vGThHkHjs3za6HY=;
        b=hnUR3JNJiiHPJczW84UkZkHBAYJddT3uE+qTGXBj2w5HJKvc5CiOtwUCCLjMUYzq9L
         XZaOVwI4J+vVhEd25TL+A1kVNXa9jyV1nU6vSwHoPd2/EqJHNWyiKfhXFdHrewQuZ345
         KDAaQOBOjp9L5H0Dhhq+Zxh/VTqw9lzNeYY3RemursMzotP19dOzvQk4/+U4aXRmyQlf
         1EClSEPvAq5QfR1a5+MwjxyEoi5+BVAwzovD0VwIleyziGoGBzYHkO+QCy7ZqWVcSdR7
         dihOI00JSM2uO7U+PGd5UyeZpmVsc+0k73gu0wrcZ8L1UVhlIAKv7fLuTX6BWv45ip0M
         j3DQ==
X-Gm-Message-State: AOJu0YxXXMMfSxvE2pgTKN1ZkPG1UBWBtn6JSROhFhWxE8HsQaELx6Xy
        D51Hmwf7yJnIIHPY0HI2jZaym+4CMwkeP/OrOeUCElU3
X-Google-Smtp-Source: AGHT+IGm+zzo14njj0m+cNvE7vTXIneDseu1SyMhMZlFHanWdZ8QlLV/UBwo4tEtRXgD6by0PkfdlEYnI1By0SDi6Is=
X-Received: by 2002:a17:90b:3ec9:b0:27d:1369:515e with SMTP id
 rm9-20020a17090b3ec900b0027d1369515emr13446086pjb.22.1699245811686; Sun, 05
 Nov 2023 20:43:31 -0800 (PST)
MIME-Version: 1.0
References: <20231026062615.3096537-1-namhyung@kernel.org> <5a153604-3e9c-4ae9-b216-64f24199efc4@intel.com>
 <ZTrFxazbxVx5G1N7@kernel.org>
In-Reply-To: <ZTrFxazbxVx5G1N7@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Sun, 5 Nov 2023 20:43:20 -0800
Message-ID: <CAM9d7ch7gnYMOc_nvy5neLdEhsjDZpr1=Obh-UW3=A14J_T68w@mail.gmail.com>
Subject: Re: [PATCH] perf tools: Add -H short option for --hierarchy
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo,

On Thu, Oct 26, 2023 at 1:02 PM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Thu, Oct 26, 2023 at 09:46:02AM +0300, Adrian Hunter escreveu:
> > On 26/10/23 09:26, Namhyung Kim wrote:
> > > I found the hierarchy mode useful, but it's easy to make a typo when
> > > using it.  Let's add a short option for that.
>
> > > Also update the documentation. :)
>
> > Perhaps it would also be possible to support bash-completions for
> > long options
>
> It works:
>
>   # . ~acme/git/linux/tools/perf/perf-completion.sh
>   # perf top --hi<TAB>
>   --hide_kernel_symbols  --hide_user_symbols    --hierarchy
>   #
>
> And:
>
> perf top --hie<ENTER>
>
> works as it is unambiguous (so far).

Thanks for the test!

>
> What we don't have is a way to use hierachy by default, i.e. we should
> have:
>
> perf config top.hierarchy=1
>
> and then:
>
> perf top
>
> would always use the hierarchy view.
>
> tools/perf/Documentation/perf-config.txt has the options that can be
> set, like:
>
> # perf report | head -15
> # To display the perf.data header info, please use --header/--header-only options.
> #
> #
> # Total Lost Samples: 0
> #
> # Samples: 373K of event 'cycles:P'
> # Event count (approx.): 205365133495
> #
> # Overhead  Command          Shared Object                                     Symbol
> # ........  ...............  .................    ...................................
> #
>      3.17%  MediaDe~hine #6  libc.so.6            [.] pthread_mutex_lock@@GLIBC_2.2.5
>      2.31%  swapper          [kernel.vmlinux]     [k] psi_group_change
>      1.87%  MediaSu~sor #10  libc.so.6            [.] pthread_mutex_lock@@GLIBC_2.2.5
>      1.84%  MediaSu~isor #7  libc.so.6            [.] pthread_mutex_lock@@GLIBC_2.2.5
> #
>
> Then:
>
> # perf config report.sort_order=dso
> # perf report | head -15
> # To display the perf.data header info, please use --header/--header-only options.
> #
> #
> # Total Lost Samples: 0
> #
> # Samples: 373K of event 'cycles:P'
> # Event count (approx.): 205365133495
> #
> # Overhead  Shared Object
> # ........  ..............................................
> #
>     59.52%  [kernel.vmlinux]
>     19.79%  libc.so.6
>      8.07%  libxul.so
>      5.25%  libopenh264.so.2.3.1
> #
>
> # cat ~/.perfconfig
> # this file is auto-generated.
> [report]
>         sort_order = dso
> [root@five ~]# perf config report.sort_order
> report.sort_order=dso
> #
>
> Right now 'perf top' has only:
>
> static int perf_top_config(const char *var, const char *value, void *cb __maybe_unused)
> {
>         if (!strcmp(var, "top.call-graph")) {
>                 var = "call-graph.record-mode";
>                 return perf_default_config(var, value, cb);
>         }
>         if (!strcmp(var, "top.children")) {
>                 symbol_conf.cumulate_callchain = perf_config_bool(var, value);
>                 return 0;
>         }
>
>         return 0;
> }
>
> This would be similar to what was done for --no-children on:

Sure, I can add the config option later.  But it's not
compatible with some options that change the output
like --children and --fields.  Maybe it needs to handle
some kind of priority of settings for incompatible one.

Thanks,
Namhyung

>
> https://git.kernel.org/torvalds/c/104ac991bd821773cba6f262f97a4a752ed76dd5
>
> $ git show --pretty=full 104ac991bd821773cba6f262f97a4a752ed76dd5 | head -5
> commit 104ac991bd821773cba6f262f97a4a752ed76dd5
> Author: Namhyung Kim <namhyung@kernel.org>
> Commit: Jiri Olsa <jolsa@kernel.org>
>
>     perf top: Add top.children config option
>
> - Arnaldo
