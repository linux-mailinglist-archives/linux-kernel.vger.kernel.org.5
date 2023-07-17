Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3FF3756812
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 17:32:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbjGQPc0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 11:32:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbjGQPcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 11:32:22 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA2F81BCF;
        Mon, 17 Jul 2023 08:32:03 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-676f16e0bc4so2998344b3a.0;
        Mon, 17 Jul 2023 08:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689607922; x=1692199922;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=27Fw7ahUO7Rg3+RjNN9n0/x/pO5L1cy+G+UZ2EeNmrY=;
        b=T5EG4LtPLEU/VLd03iebqbqi7NDNpxzS+O5wgmtwnbVX2PxwK1VkxCRa17vqsFqbPh
         2UcA96rQx0cRwZFe1jJnMqiPWWWeOwVRpFrl4XtzEHtGvXJLG9jEJXkvOdWBYpfcYRQ5
         hdWGbyDoLC4pNUQvvzTd+KeIEPMuatosB3F18YVMFOM8UZYFN4bVaBO8kZEkeNbQNtVa
         dP1SIfkBgDHmXQmI/MM5rLr/rnkkUU0KWhFZmYZyU0x8KTY8Cxawl3J+PMTyViay90/r
         Vf3kzq56eOpZb72kZzZeku2B14XzqDusrhkT1QHnd13Xn5zrh2+hnz2ISV0J7VrAxLkA
         hC3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689607922; x=1692199922;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=27Fw7ahUO7Rg3+RjNN9n0/x/pO5L1cy+G+UZ2EeNmrY=;
        b=B5ajwYrbZ0Ban77vJZigtAuRSA0diVWaeAanQ3HmtfQ10sJVuEW2pAlDuigXZ2p/mD
         nFjTTRlw28uLea3zmpBkMHclfothO9dCy8MjAlvZctnkGEQO5F74i471AlkksYpeNNPO
         np+nZ1q7j0s5J1YPDrMa5lNd9/3QP1KlAMWrjSQK/VOpoN6BeZ1+IMguVl7WmSQBsHIX
         DRKHDyMN7DrZJX7NCL4aAoLjhlMWEkDr0xGKxtD3SxZnDAk5FMNapQAmzajjANQ+CH/h
         RPNHlVqzNENTjeJ/R73B8784fvVHSEm9gvz5vbIIMTBIrOZN94SRmT2SSLnhBlM0sSLa
         gfjg==
X-Gm-Message-State: ABy/qLYc3duwuKohXNDxPYnWsPWYmQWsFwfmKv3pocRqwEF51N0jLNoz
        c31M6a8NxTt8g/G70PnDric=
X-Google-Smtp-Source: APBJJlFOCIct0t0XU+JR1ZAuRio0rXT0p0LipzMJIVcRF6hHr58Q4Bhdk41jKcdQcwrlI8n/pYjwmg==
X-Received: by 2002:a05:6a20:3d8a:b0:133:7fe3:6831 with SMTP id s10-20020a056a203d8a00b001337fe36831mr13489437pzi.57.1689607921926;
        Mon, 17 Jul 2023 08:32:01 -0700 (PDT)
Received: from yoga ([2400:1f00:13:50e2:5893:783e:fde0:1bce])
        by smtp.gmail.com with ESMTPSA id j5-20020a62e905000000b0068338b6667asm9311168pfh.212.2023.07.17.08.31.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 08:32:01 -0700 (PDT)
From:   Anup Sharma <anupnewsmail@gmail.com>
X-Google-Original-From: Anup Sharma <AnupSharma>
Date:   Mon, 17 Jul 2023 21:01:53 +0530
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
Subject: Re: [PATCH v3 2/6] scripts: python: Extact necessary information
 from process event
Message-ID: <ZLVe6Xz1dnFEnaG4@yoga>
References: <cover.1689024635.git.anupnewsmail@gmail.com>
 <ba55bf712cc27494635ca0bb23a21b42529c9327.1689024635.git.anupnewsmail@gmail.com>
 <CAP-5=fUqKZkuODXTez+Dk+RqTmh+NaeRBun65onG-yByUJOnVA@mail.gmail.com>
 <CAP-5=fW0DT+JkU07K8brv2O_T6=hTM3SQMoji0o2rnsF6w+Y_Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fW0DT+JkU07K8brv2O_T6=hTM3SQMoji0o2rnsF6w+Y_Q@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 12, 2023 at 10:03:57AM -0700, Ian Rogers wrote:
> On Wed, Jul 12, 2023 at 10:01 AM Ian Rogers <irogers@google.com> wrote:
> >
> > On Mon, Jul 10, 2023 at 4:10 PM Anup Sharma <anupnewsmail@gmail.com> wrote:
> > >
> > > The script takes in a sample event dictionary(param_dict) and retrieves
> > > relevant data such as time stamp, PID, TID, thread name. Also start time
> > > is defined.
> > >
> > > Signed-off-by: Anup Sharma <anupnewsmail@gmail.com>
> > > ---
> > >  .../perf/scripts/python/firefox-gecko-converter.py  | 13 ++++++++++++-
> > >  1 file changed, 12 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/tools/perf/scripts/python/firefox-gecko-converter.py b/tools/perf/scripts/python/firefox-gecko-converter.py
> > > index 5b342641925c..765f1775cee5 100644
> > > --- a/tools/perf/scripts/python/firefox-gecko-converter.py
> > > +++ b/tools/perf/scripts/python/firefox-gecko-converter.py
> > > @@ -21,8 +21,19 @@ sys.path.append(os.environ['PERF_EXEC_PATH'] + \
> > >  from perf_trace_context import *
> > >  from Core import *
> > >
> >
> > It'd be nice to have a comment here, perhaps:
> > # The time stamp from the first of the time ordered events.
> >

Sure. I will add it.

> > > +start_time = None
> > > +
> > >  def trace_end():
> > >         pass
> > >
> > >  def process_event(param_dict):
> > > -       pass
> > > +       global start_time
> > > +       # Extract relevant information from the event parameters. The event parameters
> > > +       # are in a dictionary:
> > > +       time_stamp = (param_dict['sample']['time'] // 1000) / 1000
> > > +       pid = param_dict['sample']['pid']
> > > +       tid = param_dict['sample']['tid']
> > > +       thread_name = param_dict['comm']
> > > +
> > > +       # Assume that start time is the time of the first event.
> > > +       start_time = time_stamp if not start_time else start_time
> >
> > I appreciate that this is one line, but it takes some getting your
> > head around that start_time is being assigned to itself in the common
> > case. I think this would be more readable as:
> >
> > if not start_time:
> >   start_time = time_stamp

Sure. I will change it.

> I believe the events are guaranteed time ordered in perf script. The
> ordered_event logic handles this, but I likely haven't got a full
> grasp on all the corners of it. You can always assert the behavior
> (comments with guarantees :-) ):
> 
> assert start_time <= time_stamp, "Events aren't time ordered"

I dont think assert is usefull here as start_time will be initialized
and assigned only once for all the process event triggers. So, the
significance of assert is not clear to me.

> Thanks,
> Ian
> 
> > Thanks,
> > Ian
> >
> > > --
> > > 2.34.1
> > >
