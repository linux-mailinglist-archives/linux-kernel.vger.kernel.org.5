Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA72475685A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 17:53:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231871AbjGQPxT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 11:53:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230189AbjGQPxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 11:53:17 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EF2EA4;
        Mon, 17 Jul 2023 08:53:16 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1b895a06484so27916525ad.1;
        Mon, 17 Jul 2023 08:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689609196; x=1692201196;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7HKpP5mcDRv5ySS4JCo6NCH3S1mQJkLAnPgImOv+RPo=;
        b=CDTNYz2M6URSjOeVtrgzuniiP0wvyMOI+rJcwCi45OxdlEfIBIUtLEkQkv3m5UQKoH
         zxDYMbVrfhx4UJYGAg6PpQBkjjANVjNZbf1J/w7YU/cvlqrByRi75/l4UVf/PSjNoKJW
         N28UnmiycbJzi02ySJEPWlBnEIRMBdMjCRzEYwM6ZTxHCJCib+vGdQqzOn33tzZMs6sS
         WVjg6e5iZ3FjIx9d85yECVT7exQN/tveiGFsGx5w8bLM2xfjl7a5HeRqZPkmmktbeI4i
         1yPO/TncgrbDqbbEhXs/tHZhx04g992qbmy+mxslj9UhjZTpCzyH1uUeokCrqb9vEkRk
         mCcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689609196; x=1692201196;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7HKpP5mcDRv5ySS4JCo6NCH3S1mQJkLAnPgImOv+RPo=;
        b=iVYE8RtQ8dQaOXS+9S9uQsxMV2/VFY+d97/LFZEEVvzVqUFtbLBUSjmzvkJawQSbtl
         8ZxDpHRDm5P7x6YQ99cn3oVeHW/COcxult63ZUz/BXfBhoE5JXaVCwoXpRaR0akqkESQ
         aBPr8izhIefCzAA+JBM+2zuVPbpsS7sVRwzHbwEyLElSFvy8+KIaaGqHDkwa2CSRt4Cr
         h+9ed0At/0e8TLsSVcfSrjFbE3Aa4PFPGH7IZks0KnOec1aeI1OGGwQ+rLrEwlRTT0mU
         emiZxt9wipubGsHmrE+eIWWGS0pjWitFMRvEReygaUBxAbyCosrWRfzGeQwKB7H5DjUS
         OM/A==
X-Gm-Message-State: ABy/qLZvsfPWzABAvJf+em8aLaKU/Qexb6quGrlHT00O2d+8nCyywdWv
        V2FeSVoIQJ9OCpJ1xCWTUt8=
X-Google-Smtp-Source: APBJJlGu7WlaB3DZRiAv9zSKrUNcLQujWzb9bbRjWXf758/6NE4SI0+oJTyHCKQbwf4tV5lhYgGW+A==
X-Received: by 2002:a17:902:724b:b0:1b8:b436:c006 with SMTP id c11-20020a170902724b00b001b8b436c006mr10249999pll.12.1689609195574;
        Mon, 17 Jul 2023 08:53:15 -0700 (PDT)
Received: from yoga ([2400:1f00:13:50e2:5893:783e:fde0:1bce])
        by smtp.gmail.com with ESMTPSA id d13-20020a170903230d00b001b694130c05sm79160plh.1.2023.07.17.08.53.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 08:53:15 -0700 (PDT)
From:   Anup Sharma <anupnewsmail@gmail.com>
X-Google-Original-From: Anup Sharma <AnupSharma>
Date:   Mon, 17 Jul 2023 21:23:07 +0530
To:     Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     Ian Rogers <irogers@google.com>,
        Anup Sharma <anupnewsmail@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/6] scripts: python: Add trace end processing and
 JSON output
Message-ID: <ZLVj49CufjImBnCf@yoga>
References: <cover.1689024635.git.anupnewsmail@gmail.com>
 <11543b39f97a7e2f9eac76c1233f1b1caa3f2c48.1689024635.git.anupnewsmail@gmail.com>
 <CAP-5=fXT3a4JE6u8zXf3=xFbOGTre3WD63SMPrA_iSVpgHjDVA@mail.gmail.com>
 <CAM9d7cjRhOQfihjg9ddKBmNCkW7CAG3NMWPkJQOAs5MHUxQUuA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM9d7cjRhOQfihjg9ddKBmNCkW7CAG3NMWPkJQOAs5MHUxQUuA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 13, 2023 at 07:31:36PM -0700, Namhyung Kim wrote:
> Hi Anup and Ian,
> 
> On Wed, Jul 12, 2023 at 10:28 AM Ian Rogers <irogers@google.com> wrote:
> >
> > On Mon, Jul 10, 2023 at 4:13 PM Anup Sharma <anupnewsmail@gmail.com> wrote:
> > >
> > > Inside the trace end function the final output will be dumped
> > > to standard output in JSON gecko format. Additionally, constants
> > > such as USER_CATEGORY_INDEX, KERNEL_CATEGORY_INDEX, CATEGORIES, and
> > > PRODUCT are defined to provide contextual information.
> > >
> > > Signed-off-by: Anup Sharma <anupnewsmail@gmail.com>
> >
> > Acked-by: Ian Rogers <irogers@google.com>
> 
> I'm ok with this change too but I think it can be squashed to
> patch 1/6 as I think it'd make it more self-contained.  Of course
> you might change time and thread to have empty values.
> 
> >
> > > ---
> > >  .../scripts/python/firefox-gecko-converter.py | 34 ++++++++++++++++++-
> > >  1 file changed, 33 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/tools/perf/scripts/python/firefox-gecko-converter.py b/tools/perf/scripts/python/firefox-gecko-converter.py
> > > index 0b8a86bdcab1..39818a603265 100644
> > > --- a/tools/perf/scripts/python/firefox-gecko-converter.py
> > > +++ b/tools/perf/scripts/python/firefox-gecko-converter.py
> > > @@ -24,8 +24,40 @@ from Core import *
> > >  thread_map = {}
> > >  start_time = None
> > >
> > > +# Follow Brendan Gregg's Flamegraph convention: orange for kernel and yellow for user
> > > +CATEGORIES = [
> > > +    {'name': 'User', 'color': 'yellow', 'subcategories': ['Other']},
> > > +    {'name': 'Kernel', 'color': 'orange', 'subcategories': ['Other']}
> > > +]
> >
> > A follow up could be to make these command line options, defaulting to
> > orange and yellow.
> 
> Sounds good.

Nice Idea, I have added this in the next version of patch.

> >
> > > +
> > > +# The product name is used by the profiler UI to show the Operating system and Processor.
> > > +PRODUCT = os.popen('uname -op').read().strip()
> 
> I'm not against this but having a command name (or full
> command line) of the target process as a title might be better.
> But I'm not sure if the python scripting engine exposed the info
> (like in perf report --header-only) to the script.

I tried to get the command name or any sort of header information but it seems to
be not exposed to the perf-script-python interface. can anyone confirm
if there is any way to get the command name or any header information from the
perf-script-python interface?

> Thanks,
> Namhyung
> 
> 
> > > +
> > >  def trace_end():
> > > -       pass
> > > +    thread_array = thread_map.values()))
> > > +
> > > +    result = {
> > > +        'meta': {
> > > +            'interval': 1,
> > > +            'processType': 0,
> > > +            'product': PRODUCT,
> > > +            'stackwalk': 1,
> > > +            'debug': 0,
> > > +            'gcpoison': 0,
> > > +            'asyncstack': 1,
> > > +            'startTime': start_time,
> > > +            'shutdownTime': None,
> > > +            'version': 24,
> > > +            'presymbolicated': True,
> > > +            'categories': CATEGORIES,
> > > +            'markerSchema': []
> > > +            },
> > > +        'libs': [],
> > > +        'threads': thread_array,
> > > +        'processes': [],
> > > +        'pausedRanges': []
> > > +    }
> > > +    json.dump(result, sys.stdout, indent=2)
> > >
> > >  def process_event(param_dict):
> > >         global start_time
> > > --
> > > 2.34.1
> > >
