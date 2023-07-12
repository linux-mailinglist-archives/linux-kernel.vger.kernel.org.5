Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2F16750FA4
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 19:26:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233265AbjGLR0I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 13:26:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233168AbjGLR0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 13:26:06 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AD9D1FDA
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 10:26:04 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id d75a77b69052e-4036bd4fff1so20711cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 10:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689182763; x=1691774763;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D9sndbKeetjpAVtCfzhlTGiXlOcxcO0n9Fuy0P6FrMY=;
        b=hsscseJOQp9XQr5bKoFXLVxQotsPHhFyUa71rXgiJAQoKNokKl6l5lvMxiqa0B8T9f
         e47EYYfbaB59SrHyY1pyS8WX8qRSQy4tKgh6LVa/S3aAu4IoadoahrleZwW8C/ypgBpq
         jSIKZ2gzDSRpgDEaXLv/oL6dsjx52TS1374BOEgr+j14kuSLKKG9T1OQgU9s81LWtars
         BpcaEtPHYalkgoGmxyy/6MRBTOs3CJ0n3NZk+2As/i5ZuCtU00WSrXbOAMJxVzr24ncG
         BUW6YnG8lwucPUddysnK2x3tzw9TrDeeWtD+y4ttAlghFHkif4GhErZyXhaJWFfKifKi
         Sbhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689182763; x=1691774763;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D9sndbKeetjpAVtCfzhlTGiXlOcxcO0n9Fuy0P6FrMY=;
        b=evrDvCE7SVSYzuTtUHWVx6gtrpTeaiuEI1AAbIxepZyXIyOeXrNdHTBmoz+gpLQzUZ
         yzwdoPIZoMu8gqBXFMaWAi5cBGtVtE8OT8xaJG2VGQYQokBsPuDeEOklTUd0EWoSX6Kb
         6fhVzs2tNTT8W4y5NLYnWdE4YxjPscKdzQGqhzxOYYZUVnz+QIVEzLQ9VbwRYpUyt2kw
         8InkvJ7Pvu9yWJ5kJpvWUdNPw173I/0U9yMYFteyNlF88QIpw+C/gX99YZhw42COBswt
         5SEuj9/3kO69pActGLowItyNL4irk7Lk3brNRroZHJ7thYDP3PAxTnVdot8ds5u6LSQb
         oQGg==
X-Gm-Message-State: ABy/qLaA7hOC6l+yp4nG/dR0ZGrciPC+ZpO3saa/wIfmAFhFJ3jJjSJs
        ZbmQW/SNEfzYYOiQ25iTYqwYn4E72mp2qM0s3iU/QA==
X-Google-Smtp-Source: APBJJlEFr1+xClIimgby3gC8zl116qm8FpS4A4eHM/ieeHa0jSU1ewQYIukYVwFRIjWlvTtZ44Ru+Twa3zG5M+kwguc=
X-Received: by 2002:ac8:7f11:0:b0:3f6:97b4:1a4d with SMTP id
 f17-20020ac87f11000000b003f697b41a4dmr267957qtk.23.1689182762716; Wed, 12 Jul
 2023 10:26:02 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1689024635.git.anupnewsmail@gmail.com> <70fd94954a3872caeef5851607b245394149f4a9.1689024635.git.anupnewsmail@gmail.com>
In-Reply-To: <70fd94954a3872caeef5851607b245394149f4a9.1689024635.git.anupnewsmail@gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 12 Jul 2023 10:25:50 -0700
Message-ID: <CAP-5=fVC8T+GNQYcQi9sAOcV5YUb5zX2D5AwH72aSvL8_Cn3Zw@mail.gmail.com>
Subject: Re: [PATCH v3 3/6] scripts: python: thread sample processing to
 create thread with schemas
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
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 10, 2023 at 4:13=E2=80=AFPM Anup Sharma <anupnewsmail@gmail.com=
> wrote:
>
> The _addThreadSample function is responsible for adding a sample
> to a specific thread. It first checks if the thread exists in
> the thread_map dictionary.
>
> The markers structure defines the schema and data for
> thread markers, including fields such as 'name',
> 'startTime', 'endTime', 'phase', 'category', and 'data'.
>
> The samples structure defines the schema and data for thread
> samples, including fields such as 'stack', 'time', and
> 'responsiveness'.
>
> The frameTable structure defines the schema and data for frame
> information, including fields such as 'location', 'relevantForJS',
> 'innerWindowID', 'implementation', 'optimizations', 'line',
> 'column', 'category', and 'subcategory'.
>
> The purpose of this function is to create a new thread structure
> These structures provide a framework for storing and organizing
> information related to thread markers, samples, frame details,
> and stack information.
>
> The call stack is parsed to include function names and the associated
> DSO, which are requires for creating json schema. Also few libaries
> has been included which will be used in later commit.

nit: s/requires/required.
nit: I think the "Also few..." statement is out-of-date.

> Signed-off-by: Anup Sharma <anupnewsmail@gmail.com>
> ---
>  .../scripts/python/firefox-gecko-converter.py | 70 +++++++++++++++++++
>  1 file changed, 70 insertions(+)
>
> diff --git a/tools/perf/scripts/python/firefox-gecko-converter.py b/tools=
/perf/scripts/python/firefox-gecko-converter.py
> index 765f1775cee5..0b8a86bdcab1 100644
> --- a/tools/perf/scripts/python/firefox-gecko-converter.py
> +++ b/tools/perf/scripts/python/firefox-gecko-converter.py
> @@ -21,6 +21,7 @@ sys.path.append(os.environ['PERF_EXEC_PATH'] + \
>  from perf_trace_context import *
>  from Core import *
>

A comment and type information would be useful here. map is another
word for a dictionary, which is somewhat implied. So the information
here is that this data structure will hold something to do with
threads.  Perhaps say, "a map from TID to a Thread." A better variable
name may then be tid_to_thread_map, but as map is implied you could
do: tid_to_thread: Dict[int, Thread].

> +thread_map =3D {}
>  start_time =3D None
>
>  def trace_end():
> @@ -28,6 +29,57 @@ def trace_end():
>
>  def process_event(param_dict):
>         global start_time
> +       global thread_map
> +
> +       def _createThread(name, pid, tid):
> +               markers =3D {
> +                       'schema': {
> +                               'name': 0,
> +                               'startTime': 1,
> +                               'endTime': 2,
> +                               'phase': 3,
> +                               'category': 4,
> +                               'data': 5,
> +                       },
> +                       'data': [],
> +               }
> +               samples =3D {
> +                       'schema': {
> +                               'stack': 0,
> +                               'time': 1,
> +                               'responsiveness': 2,
> +                               },
> +                       'data': [],
> +               }
> +               frameTable =3D {
> +                       'schema': {
> +                               'location': 0,
> +                               'relevantForJS': 1,
> +                               'innerWindowID': 2,
> +                               'implementation': 3,
> +                               'optimizations': 4,
> +                               'line': 5,
> +                               'column': 6,
> +                               'category': 7,
> +                               'subcategory': 8,
> +                       },
> +                       'data': [],
> +               }
> +               stackTable =3D {
> +                       'schema': {
> +                               'prefix': 0,
> +                               'frame': 1,
> +                       },
> +                       'data': [],
> +               }
> +               stringTable =3D []

Is there a missing return here?

> +
> +       def _addThreadSample(pid, tid, threadName, time_stamp, stack):
> +               thread =3D thread_map.get(tid)
> +               if not thread:
> +                       thread =3D _createThread(threadName, pid, tid)
> +                       thread_map[tid] =3D thread
> +
>         # Extract relevant information from the event parameters. The eve=
nt parameters
>         # are in a dictionary:
>         time_stamp =3D (param_dict['sample']['time'] // 1000) / 1000
> @@ -37,3 +89,21 @@ def process_event(param_dict):
>
>         # Assume that start time is the time of the first event.
>         start_time =3D time_stamp if not start_time else start_time
> +
> +       # Parse the callchain of the current sample into a stack array.
> +       if param_dict['callchain']:
> +               stack =3D []
> +               for call in param_dict['callchain']:
> +                       if 'sym' not in call:
> +                               continue
> +                       stack.append(call['sym']['name'] + f' (in {call["=
dso"]})')

Rather than mix an append and an f-string, just have the f-string ie:
stack.append(f'{call["sym"]["name"]} (in {"call["dso"]})')

> +               if len(stack) !=3D 0:
> +                       stack =3D stack[::-1]
> +                       _addThreadSample(pid, tid, thread_name, time_stam=
p, stack)
> +
> +       # During perf record if -g is not used, the callchain is not avai=
lable.
> +       # In that case, the symbol and dso are available in the event par=
ameters.
> +       else:
> +               func =3D param_dict['symbol'] if 'symbol' in param_dict e=
lse '[unknown]'
> +               dso =3D param_dict['dso'] if 'dso' in param_dict else '[u=
nknown]'
> +               _addThreadSample(pid, tid, thread_name, time_stamp, [func=
 + f' (in {dso})'])

Similarly:
f'{func} (in {dso})'

Thanks,
Ian

> --
> 2.34.1
>
