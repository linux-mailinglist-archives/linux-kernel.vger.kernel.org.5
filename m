Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F6B2756838
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 17:43:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231454AbjGQPnq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 11:43:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231421AbjGQPno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 11:43:44 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09E37107;
        Mon, 17 Jul 2023 08:43:42 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-6686c74183cso4746473b3a.1;
        Mon, 17 Jul 2023 08:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689608621; x=1692200621;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wXknWUupf2Lv0cdyZ0Lz4FOv8r0etirYdereLcmpd64=;
        b=ZHbw/dspuC4p797kY6HncNcFtsWRtqtUxFLv4q1/84el8r8LCeN764PG93qQDeyCFA
         98MBnhVTZh/FbGab9+OhbG1h1MPEf6NfouIlhVuvsJY5WWuJkG3EG6q+byWG9bzCdTB6
         hmTTCY2M01vtyQmkjTcsiqPhS1+JCM4kTC3vaoDWDjdLuDwFm+LJdK2eTwxpPELUow+n
         WP2PTZsP2Eecb7SpaYmJREJ+gU0QysupbxFheZU0iZZO8rGbxJxI+eI0AxlQFUVCcaNe
         OYesPVKNbk5SYr6X9T9Fc+3Eloj1SU7gX2FeHhs9AuwSP9crdl7NLFLnVdAkvfkho9LD
         +vLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689608621; x=1692200621;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wXknWUupf2Lv0cdyZ0Lz4FOv8r0etirYdereLcmpd64=;
        b=XEMk89QU/2GWNedaIEvzXa8fJsEIHUmPjLZ1Y7A/ivFxeFiQcqjt9Y8ey/alg2w0oW
         3EO2mPSUS8zrNS0USxm4mFb8Oo5O2Cdm1HU1tgnQmfTg6NRotlcIgk0mQ8RexKybeE/p
         W86Hpppm7C9ZbUhBh5LGSiLCUNRkfd5L2lR04usHLnacQbsYJDetAOJae2BKCK4gR5cf
         axU21GRuPnYLDjf2/hFmzn6pDupKmPQWsJ4UQw+DFXf1frtMlM/sePpMsBzAEUZwTmxI
         W8uLUW+cB6E6klyBgj3clcN3vzL0oG4I49FypRlmrrDfvLsDklIkdGHY+muCP982jSF8
         oirw==
X-Gm-Message-State: ABy/qLYE8TMLpbjyMZeoOkog9J4XBTmuAO1l2LnRzmYxqc1cxLhLprws
        VkgpszEkyRpGe6eVziEAeu0=
X-Google-Smtp-Source: APBJJlEFU+d9kORCP9Vq+lfxaDU/9ToIIBdE785NHxnM5lnUDi85gwGD4W1Ew312PAIs9AH2OQ/D1A==
X-Received: by 2002:a17:90a:8b0c:b0:263:f896:2165 with SMTP id y12-20020a17090a8b0c00b00263f8962165mr11712064pjn.46.1689608621091;
        Mon, 17 Jul 2023 08:43:41 -0700 (PDT)
Received: from yoga ([2400:1f00:13:50e2:5893:783e:fde0:1bce])
        by smtp.gmail.com with ESMTPSA id 21-20020a170902c21500b001b8649e52f8sm26229pll.254.2023.07.17.08.43.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 08:43:40 -0700 (PDT)
From:   Anup Sharma <anupnewsmail@gmail.com>
X-Google-Original-From: Anup Sharma <AnupSharma>
Date:   Mon, 17 Jul 2023 21:13:33 +0530
To:     Ian Rogers <irogers@google.com>
Cc:     Anup Sharma <anupnewsmail@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/6] scripts: python: thread sample processing to
 create thread with schemas
Message-ID: <ZLVhpexb3rQ/dDUo@yoga>
References: <cover.1689024635.git.anupnewsmail@gmail.com>
 <70fd94954a3872caeef5851607b245394149f4a9.1689024635.git.anupnewsmail@gmail.com>
 <CAP-5=fVC8T+GNQYcQi9sAOcV5YUb5zX2D5AwH72aSvL8_Cn3Zw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fVC8T+GNQYcQi9sAOcV5YUb5zX2D5AwH72aSvL8_Cn3Zw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 12, 2023 at 10:25:50AM -0700, Ian Rogers wrote:
> On Mon, Jul 10, 2023 at 4:13 PM Anup Sharma <anupnewsmail@gmail.com> wrote:
> >
> > The _addThreadSample function is responsible for adding a sample
> > to a specific thread. It first checks if the thread exists in
> > the thread_map dictionary.
> >
> > The markers structure defines the schema and data for
> > thread markers, including fields such as 'name',
> > 'startTime', 'endTime', 'phase', 'category', and 'data'.
> >
> > The samples structure defines the schema and data for thread
> > samples, including fields such as 'stack', 'time', and
> > 'responsiveness'.
> >
> > The frameTable structure defines the schema and data for frame
> > information, including fields such as 'location', 'relevantForJS',
> > 'innerWindowID', 'implementation', 'optimizations', 'line',
> > 'column', 'category', and 'subcategory'.
> >
> > The purpose of this function is to create a new thread structure
> > These structures provide a framework for storing and organizing
> > information related to thread markers, samples, frame details,
> > and stack information.
> >
> > The call stack is parsed to include function names and the associated
> > DSO, which are requires for creating json schema. Also few libaries
> > has been included which will be used in later commit.
> 
> nit: s/requires/required.
> nit: I think the "Also few..." statement is out-of-date.

I apologize. I will ensure to address these in the next version.

> > Signed-off-by: Anup Sharma <anupnewsmail@gmail.com>
> > ---
> >  .../scripts/python/firefox-gecko-converter.py | 70 +++++++++++++++++++
> >  1 file changed, 70 insertions(+)
> >
> > diff --git a/tools/perf/scripts/python/firefox-gecko-converter.py b/tools/perf/scripts/python/firefox-gecko-converter.py
> > index 765f1775cee5..0b8a86bdcab1 100644
> > --- a/tools/perf/scripts/python/firefox-gecko-converter.py
> > +++ b/tools/perf/scripts/python/firefox-gecko-converter.py
> > @@ -21,6 +21,7 @@ sys.path.append(os.environ['PERF_EXEC_PATH'] + \
> >  from perf_trace_context import *
> >  from Core import *
> >
> 
> A comment and type information would be useful here. map is another
> word for a dictionary, which is somewhat implied. So the information
> here is that this data structure will hold something to do with
> threads.  Perhaps say, "a map from TID to a Thread." A better variable
> name may then be tid_to_thread_map, but as map is implied you could
> do: tid_to_thread: Dict[int, Thread].

sure, I will rename this variable to tid_to_thread. However in my case
this needs to be kept a global variable, and I am not sure if I can
specify the data type for this variable since it creates a dependency
loop with the Thread class. I can leave it with just a comment
mentioning the type of key and value or I can write the type as
"Dict[int, Any]" which is not very useful.

> > +thread_map = {}
> >  start_time = None
> >
> >  def trace_end():
> > @@ -28,6 +29,57 @@ def trace_end():
> >
> >  def process_event(param_dict):
> >         global start_time
> > +       global thread_map
> > +
> > +       def _createThread(name, pid, tid):
> > +               markers = {
> > +                       'schema': {
> > +                               'name': 0,
> > +                               'startTime': 1,
> > +                               'endTime': 2,
> > +                               'phase': 3,
> > +                               'category': 4,
> > +                               'data': 5,
> > +                       },
> > +                       'data': [],
> > +               }
> > +               samples = {
> > +                       'schema': {
> > +                               'stack': 0,
> > +                               'time': 1,
> > +                               'responsiveness': 2,
> > +                               },
> > +                       'data': [],
> > +               }
> > +               frameTable = {
> > +                       'schema': {
> > +                               'location': 0,
> > +                               'relevantForJS': 1,
> > +                               'innerWindowID': 2,
> > +                               'implementation': 3,
> > +                               'optimizations': 4,
> > +                               'line': 5,
> > +                               'column': 6,
> > +                               'category': 7,
> > +                               'subcategory': 8,
> > +                       },
> > +                       'data': [],
> > +               }
> > +               stackTable = {
> > +                       'schema': {
> > +                               'prefix': 0,
> > +                               'frame': 1,
> > +                       },
> > +                       'data': [],
> > +               }
> > +               stringTable = []
> 
> Is there a missing return here?

No, I am not returning anything here.

> > +
> > +       def _addThreadSample(pid, tid, threadName, time_stamp, stack):
> > +               thread = thread_map.get(tid)
> > +               if not thread:
> > +                       thread = _createThread(threadName, pid, tid)
> > +                       thread_map[tid] = thread
> > +
> >         # Extract relevant information from the event parameters. The event parameters
> >         # are in a dictionary:
> >         time_stamp = (param_dict['sample']['time'] // 1000) / 1000
> > @@ -37,3 +89,21 @@ def process_event(param_dict):
> >
> >         # Assume that start time is the time of the first event.
> >         start_time = time_stamp if not start_time else start_time
> > +
> > +       # Parse the callchain of the current sample into a stack array.
> > +       if param_dict['callchain']:
> > +               stack = []
> > +               for call in param_dict['callchain']:
> > +                       if 'sym' not in call:
> > +                               continue
> > +                       stack.append(call['sym']['name'] + f' (in {call["dso"]})')
> 
> Rather than mix an append and an f-string, just have the f-string ie:
> stack.append(f'{call["sym"]["name"]} (in {"call["dso"]})')

Thanks for this suggestion. I will make this change.

> > +               if len(stack) != 0:
> > +                       stack = stack[::-1]
> > +                       _addThreadSample(pid, tid, thread_name, time_stamp, stack)
> > +
> > +       # During perf record if -g is not used, the callchain is not available.
> > +       # In that case, the symbol and dso are available in the event parameters.
> > +       else:
> > +               func = param_dict['symbol'] if 'symbol' in param_dict else '[unknown]'
> > +               dso = param_dict['dso'] if 'dso' in param_dict else '[unknown]'
> > +               _addThreadSample(pid, tid, thread_name, time_stamp, [func + f' (in {dso})'])
> 
> Similarly:
> f'{func} (in {dso})'

Noted.

> Thanks,
> Ian
> 
> > --
> > 2.34.1
> >
