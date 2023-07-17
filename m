Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9D5775687F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 17:59:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231718AbjGQP7U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 11:59:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbjGQP7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 11:59:17 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D978DD8;
        Mon, 17 Jul 2023 08:59:16 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-263374f2f17so2446423a91.0;
        Mon, 17 Jul 2023 08:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689609556; x=1692201556;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UvHbtMz36nAYwOqM6y1BD7XGn+T3QzVrtohh3Auo9x0=;
        b=AqylJkL03+2isSpBoKjJFPjXHrvY3UnQ+NrdyeGbO9Z+RIjgH/UsOoHyn9QEjuGtlF
         Vqht2ZB4fMOwaxyudNPQConB7bg5tD7K1LS8o663X9w0VnN0SpgKq47jeNMsrx9aqmwM
         kOXSucuBoRct17bUd4VS4wndJmbmMM8zkZxlTla6xMcs6WSS38Dqgr0qmwkJzxYYi0uf
         dbSmeY1gNX9Po5p5hRGvzWnhXb+I+X1cJEhPdjh9aab1I5AU/3RRMcmq9Nd2VjRarjj2
         SIIvs3cegsF3e0zcuKTQHSDi+0FB7WKGpqsSP+9IhYElDiWHLT6jqjk7OIz8bHqZTpoW
         /J2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689609556; x=1692201556;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UvHbtMz36nAYwOqM6y1BD7XGn+T3QzVrtohh3Auo9x0=;
        b=dXXcVWMJ+yyE0h8USoPAndwsiHJvJXB5RjdgjLYRH079ymeTnY3HWcziNkzBJChna1
         jQZzQKjNddWvEMybFMAoon5E6jhVmK8fGCUdFsetnzalcVAE7r38lcgPvYLx+P4ju1GH
         rVIXsExMrR26IoPiJ6RpM+5QAeTpKfKUlsHfaTsvrwyoJ0M8kaRUhnTl8zP7mfC8q8p/
         H22E/PGSmWiguS9/duUTzJXs8cj3sFLsS0d8/UjPt5s0IW/clm9kDBIvtp0FMAo1/Tow
         +vishimx4fKeA0EgxQ92hsFFr5dDSUwGjK1ACvRYvZwr07rxqHj/TNXeNXzUjVYOUrmQ
         o2Mw==
X-Gm-Message-State: ABy/qLa/15+QZ8J1uvsAcKJsZih3xZqolIqDNLlY6isk40XaZd2fQk4D
        AvkWp8Q2bZ9tx7aKLfGnPK8=
X-Google-Smtp-Source: APBJJlF3aQiHedJIInqcUf06kA0JliXD7cxnpC/bL597/rEOko2Dg6Tt2+tGNA+yMV5eCdWDnwCmqQ==
X-Received: by 2002:a17:90a:38e1:b0:262:e6c6:c2ec with SMTP id x88-20020a17090a38e100b00262e6c6c2ecmr9521732pjb.33.1689609555677;
        Mon, 17 Jul 2023 08:59:15 -0700 (PDT)
Received: from yoga ([2400:1f00:13:50e2:5893:783e:fde0:1bce])
        by smtp.gmail.com with ESMTPSA id j6-20020a17090a840600b002641a9faa01sm5056939pjn.52.2023.07.17.08.59.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 08:59:15 -0700 (PDT)
From:   Anup Sharma <anupnewsmail@gmail.com>
X-Google-Original-From: Anup Sharma <AnupSharma>
Date:   Mon, 17 Jul 2023 21:29:07 +0530
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
Subject: Re: [PATCH v3 5/6] scripts: python: Implement add sample function
 and return finish
Message-ID: <ZLVlS3xHLZFZjRMq@yoga>
References: <cover.1689024635.git.anupnewsmail@gmail.com>
 <8b80f803ffbed4c84c0c63b3e1dae155a66ac1f2.1689024635.git.anupnewsmail@gmail.com>
 <CAP-5=fVtfHM0NJ-7ogR1wvu3bUMR+2a1o-ndRPT_-BD1o5xdgg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fVtfHM0NJ-7ogR1wvu3bUMR+2a1o-ndRPT_-BD1o5xdgg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 12, 2023 at 10:35:16AM -0700, Ian Rogers wrote:
> On Mon, Jul 10, 2023 at 4:14 PM Anup Sharma <anupnewsmail@gmail.com> wrote:
> >
> > The addSample function appends a new entry to the 'samples' data structure.
> >
> > The finish function generates a dictionary containing various profile
> > information such as 'tid', 'pid', 'name', 'markers', 'samples',
> > 'frameTable', 'stackTable', 'stringTable', 'registerTime',
> > 'unregisterTime', and 'processType'.
> >
> > Signed-off-by: Anup Sharma <anupnewsmail@gmail.com>
> > ---
> >  .../scripts/python/firefox-gecko-converter.py | 25 +++++++++++++++++++
> >  1 file changed, 25 insertions(+)
> >
> > diff --git a/tools/perf/scripts/python/firefox-gecko-converter.py b/tools/perf/scripts/python/firefox-gecko-converter.py
> > index 39818a603265..6c934de1f608 100644
> > --- a/tools/perf/scripts/python/firefox-gecko-converter.py
> > +++ b/tools/perf/scripts/python/firefox-gecko-converter.py
> > @@ -106,11 +106,36 @@ def process_event(param_dict):
> >                 }
> >                 stringTable = []
> >
> > +               def addSample(threadName, stackArray, time):
> 
> I think these aren't following general naming conventions:
> https://peps.python.org/pep-0008/#function-and-variable-names
> So use thread_name, stack_array.

Noted. Will fix in v4.

> > +                       responsiveness = 0
> > +                       samples['data'].append([stack, time, responsiveness])
> > +
> > +               def finish():
> > +                       return {
> > +                               "tid": tid,
> > +                               "pid": pid,
> > +                               "name": name,
> > +                               "markers": markers,
> > +                               "samples": samples,
> > +                               "frameTable": frameTable,
> > +                               "stackTable": stackTable,
> > +                               "stringTable": stringTable,
> > +                               "registerTime": 0,
> > +                               "unregisterTime": None,
> > +                               "processType": 'default'
> > +                       }
> > +
> > +               return {
> > +                       "addSample": addSample,
> > +                       "finish": finish
> > +               }
> 
> I think the use of a dictionary here isn't idiomatic. Rather than use
> a dictionary I think you can make a class Thread, then have functions
> passed self called addSample and finish. So:

agreed.

> class Thread:
>   def addSample(self, thread_name: str, stack_array: list[...], time: int):
>      responsiveness = 0
>      self.samples['data'] ...
> ...
> thread.addSample(threadName, stack, time_stamp)
>
> Should samples be its own class here?

I have changed the code to use object oriented approach by taking
reference from simpleperf. I will make class Thread and Sample.

> Thanks,
> Ian
> 
> > +
> >         def _addThreadSample(pid, tid, threadName, time_stamp, stack):
> >                 thread = thread_map.get(tid)
> >                 if not thread:
> >                         thread = _createThread(threadName, pid, tid)
> >                         thread_map[tid] = thread
> > +               thread['addSample'](threadName, stack, time_stamp)
> >
> >         # Extract relevant information from the event parameters. The event parameters
> >         # are in a dictionary:
> > --
> > 2.34.1
> >
