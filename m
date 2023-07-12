Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20715750FC0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 19:35:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232165AbjGLRfb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 13:35:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231602AbjGLRf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 13:35:29 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C28D1FD6
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 10:35:28 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-4036bd4fff1so23761cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 10:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689183327; x=1691775327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bUHKr25mKMwzaetspTzJuKob1qSWy270LwGgiT27nos=;
        b=TT7riyt5+IvDbDOfbsoXanuG80TLe5nPyZqepV674ZPQiHmhP0lWm8Ni1ivIJJzy3r
         xKaSEKI9jmuh16/1F45sZqXSOMinTrYaOQbOZsfrxPpmRa61rw5po7nLWJ3tWdm/JFLN
         2Ez6Q9HTMfC59bGFaO02aGX4a09WjWpxLoy4uqw/nZgkE5zAF4g53nHxEdgeqlhRFHsU
         pPCsRPhco0nePVTlwf7cXjBfp2vokXqTmh2Sp4mYvSpnJoVzoHQazn7h4RDpXXq4W0yk
         /DLhStMd3GuUZMYnHbOaETGU9PIgDzirhSQyjeQsE+WDGB6ZKrJxxdxjUC+qqdh/wgIr
         4tcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689183327; x=1691775327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bUHKr25mKMwzaetspTzJuKob1qSWy270LwGgiT27nos=;
        b=Tf+suSbSu/PCyGtBrEmcDIVSX1idv4lwXDKrT3HK+n4VDMtvzpDIrUuYYe3ci5YwN/
         kuMFGjZ451NEsfuaPuZnkQLLBqAIaVGjx1+nK75VgCGDyygTiSYEAC8trX9aza/93VHJ
         L9h2NyDbm0qllvdUyqg+aPyByXmu6GW4JdA/yPl20ZVg0E0x1XnITS9fJ+xjbxtkU8w1
         XeXzqcpl22LQwXIWYGTMP0wNss79aFcXVapLGxLCl16q43nTfNcKYGkxC/cSJ0b+a4qm
         Kvc8Km9fXTiYU8JASpwwF4+0HSvOVE69lP2fO1mzcUFong0Vvd0dju6jletKvHHB6saL
         2LlQ==
X-Gm-Message-State: ABy/qLZUKprYHUdatZjeO2R0PPPa1z9BO4ICpvs+M0ueXUkG83KAkJs9
        8I2X2kVpg/kcmR19+qTkwyPBrc9HO8/3j9sWYmleQi8S8SehwyyBoIA4AQ==
X-Google-Smtp-Source: APBJJlE8YxTv63Dw3FssBBmef8iBVEWuD9nCrCA+1iylTfq5Zt3O2SmJepmIDCk+9XDAzaTKpEVg/a2GkqjHm4/bxOc=
X-Received: by 2002:a05:622a:1994:b0:3ef:5f97:258f with SMTP id
 u20-20020a05622a199400b003ef5f97258fmr328491qtc.16.1689183327385; Wed, 12 Jul
 2023 10:35:27 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1689024635.git.anupnewsmail@gmail.com> <8b80f803ffbed4c84c0c63b3e1dae155a66ac1f2.1689024635.git.anupnewsmail@gmail.com>
In-Reply-To: <8b80f803ffbed4c84c0c63b3e1dae155a66ac1f2.1689024635.git.anupnewsmail@gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 12 Jul 2023 10:35:16 -0700
Message-ID: <CAP-5=fVtfHM0NJ-7ogR1wvu3bUMR+2a1o-ndRPT_-BD1o5xdgg@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] scripts: python: Implement add sample function and
 return finish
To:     Anup Sharma <anupnewsmail@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 10, 2023 at 4:14=E2=80=AFPM Anup Sharma <anupnewsmail@gmail.com=
> wrote:
>
> The addSample function appends a new entry to the 'samples' data structur=
e.
>
> The finish function generates a dictionary containing various profile
> information such as 'tid', 'pid', 'name', 'markers', 'samples',
> 'frameTable', 'stackTable', 'stringTable', 'registerTime',
> 'unregisterTime', and 'processType'.
>
> Signed-off-by: Anup Sharma <anupnewsmail@gmail.com>
> ---
>  .../scripts/python/firefox-gecko-converter.py | 25 +++++++++++++++++++
>  1 file changed, 25 insertions(+)
>
> diff --git a/tools/perf/scripts/python/firefox-gecko-converter.py b/tools=
/perf/scripts/python/firefox-gecko-converter.py
> index 39818a603265..6c934de1f608 100644
> --- a/tools/perf/scripts/python/firefox-gecko-converter.py
> +++ b/tools/perf/scripts/python/firefox-gecko-converter.py
> @@ -106,11 +106,36 @@ def process_event(param_dict):
>                 }
>                 stringTable =3D []
>
> +               def addSample(threadName, stackArray, time):

I think these aren't following general naming conventions:
https://peps.python.org/pep-0008/#function-and-variable-names
So use thread_name, stack_array.

> +                       responsiveness =3D 0
> +                       samples['data'].append([stack, time, responsivene=
ss])
> +
> +               def finish():
> +                       return {
> +                               "tid": tid,
> +                               "pid": pid,
> +                               "name": name,
> +                               "markers": markers,
> +                               "samples": samples,
> +                               "frameTable": frameTable,
> +                               "stackTable": stackTable,
> +                               "stringTable": stringTable,
> +                               "registerTime": 0,
> +                               "unregisterTime": None,
> +                               "processType": 'default'
> +                       }
> +
> +               return {
> +                       "addSample": addSample,
> +                       "finish": finish
> +               }

I think the use of a dictionary here isn't idiomatic. Rather than use
a dictionary I think you can make a class Thread, then have functions
passed self called addSample and finish. So:

class Thread:
  def addSample(self, thread_name: str, stack_array: list[...], time: int):
     responsiveness =3D 0
     self.samples['data'] ...
...
thread.addSample(threadName, stack, time_stamp)

Should samples be its own class here?

Thanks,
Ian

> +
>         def _addThreadSample(pid, tid, threadName, time_stamp, stack):
>                 thread =3D thread_map.get(tid)
>                 if not thread:
>                         thread =3D _createThread(threadName, pid, tid)
>                         thread_map[tid] =3D thread
> +               thread['addSample'](threadName, stack, time_stamp)
>
>         # Extract relevant information from the event parameters. The eve=
nt parameters
>         # are in a dictionary:
> --
> 2.34.1
>
