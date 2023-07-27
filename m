Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76DF0764329
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 03:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231259AbjG0BBq convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 26 Jul 2023 21:01:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjG0BBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 21:01:44 -0400
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 640E326B8;
        Wed, 26 Jul 2023 18:01:43 -0700 (PDT)
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-78372b896d0so14658839f.2;
        Wed, 26 Jul 2023 18:01:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690419702; x=1691024502;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H2t9hQTZLQL2fbrtT3/xWkm8UjlYURhLQTybahLPuAo=;
        b=i3byS9s5hmCjKtDlZWYHSN4vKoeFUyWK/83ESQ8ua85nISjw73Rneh1EdO7P6Bfc4X
         E4CIPUDx52O3GFIHY+F2LKVjdB9qJ2In/yWa4ztcGl2efEHKlgIJZJaj1bC6+v7R0MWL
         0zCrgNtHQiZ3li/2DFNmfL6CHt8gsM/Pyy9twp02Kf0MZne6VeYVP4cvlE1yg2WpRf4S
         fzV+z/DAsudCiNdES3DygdDboXG/0nsiP2qWDqPTI6bNn54ax1tYTZ9dZYmHG5Mb0ruz
         wPRvXtDQpGOnxKyUP9kJiY9cAGQqpLQhCUjv2SDUnDP4RfVBh1qt+9N+oC0Srhx76zQK
         RmlA==
X-Gm-Message-State: ABy/qLYxFaxMl65/kQhIIUQEZ+qudpe57KgOEee9KlfPKUAdNyCafdjG
        PiQQOF90+/Pf24k2dOPnmEHANaPqnduTwpEZqIPnZ5SL
X-Google-Smtp-Source: APBJJlGbp6cAWwJPdYfBgAhF8dvXyvhFv78ZZGTsaLix4Ccor+pIv/jZiq14VFzOQTq0vEpBCiwvEcRXD/x59bygrRk=
X-Received: by 2002:a6b:730b:0:b0:787:7700:2b5c with SMTP id
 e11-20020a6b730b000000b0078777002b5cmr3863956ioh.6.1690419702417; Wed, 26 Jul
 2023 18:01:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230726133642.750342-1-namhyung@kernel.org> <CAP-5=fWM9Fhq5WvsBf2n=hGwwwRDt3-mUQ=_qzu8qYGtD1OeWQ@mail.gmail.com>
 <CAM9d7citVc4ad65MLBWxvE-_AbwxO1DQWHf5w+ofSgWnWSx=Fw@mail.gmail.com> <CAP-5=fVbwf9=ZFszgFpb_6Qb003WpZC3_vtO7fB1pL_vH-OhQw@mail.gmail.com>
In-Reply-To: <CAP-5=fVbwf9=ZFszgFpb_6Qb003WpZC3_vtO7fB1pL_vH-OhQw@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 26 Jul 2023 18:01:30 -0700
Message-ID: <CAM9d7chcrd8mN55yb+oCBi3=AF4-a=oCr66+cv7eaquzx0Kvpw@mail.gmail.com>
Subject: Re: [PATCH 1/2] perf build: Update build rule for generated files
To:     Ian Rogers <irogers@google.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        Anup Sharma <anupnewsmail@gmail.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2023 at 5:36 PM Ian Rogers <irogers@google.com> wrote:
>
> On Wed, Jul 26, 2023 at 3:57 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > Hi Ian,
> >
> > On Wed, Jul 26, 2023 at 8:48 AM Ian Rogers <irogers@google.com> wrote:
> > >
> > > On Wed, Jul 26, 2023 at 6:36 AM Namhyung Kim <namhyung@kernel.org> wrote:
> > > >
> > > > The bison and flex generate C files from the source (.y and .l)
> > > > files.  When O= option is used, they are saved in a separate directory
> > > > but the default build rule assumes the .C files are in the source
> > > > directory.  So it might read invalid file if there are generated files
> > > > from an old version.  The same is true for the pmu-events files.
> > > >
> > > > For example, the following command would cause a build failure:
> > > >
> > > >   $ git checkout v6.3
> > > >   $ make -C tools/perf  # build in the same directory
> > > >
> > > >   $ git checkout v6.5-rc2
> > > >   $ mkdir build  # create a build directory
> > > >   $ make -C tools/perf O=build  # build in a different directory but it
> > > >                                 # refers files in the source directory
> > > >
> > > > Let's update the build rule to specify those cases explicitly to depend
> > > > on the files in the output directory.
> > > >
> > > > Note that it's not a complete fix and it needs the next patch for the
> > > > include path too.
> > > >
> > > > Fixes: 80eeb67fe577 ("perf jevents: Program to convert JSON file")
> > > > Cc: stable@vger.kernel.org
> > > > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > > > ---
> > > >  tools/build/Makefile.build  | 8 ++++++++
> > > >  tools/perf/pmu-events/Build | 4 ++++
> > > >  2 files changed, 12 insertions(+)
> > > >
> > > > diff --git a/tools/build/Makefile.build b/tools/build/Makefile.build
> > > > index 89430338a3d9..f9396696fcbf 100644
> > > > --- a/tools/build/Makefile.build
> > > > +++ b/tools/build/Makefile.build
> > > > @@ -117,6 +117,14 @@ $(OUTPUT)%.s: %.c FORCE
> > > >         $(call rule_mkdir)
> > > >         $(call if_changed_dep,cc_s_c)
> > > >
> > > > +$(OUTPUT)%-bison.o: $(OUTPUT)%-bison.c FORCE
> > > > +       $(call rule_mkdir)
> > > > +       $(call if_changed_dep,$(host)cc_o_c)
> > > > +
> > > > +$(OUTPUT)%-flex.o: $(OUTPUT)%-flex.c FORCE
> > > > +       $(call rule_mkdir)
> > > > +       $(call if_changed_dep,$(host)cc_o_c)
> > > > +
> > >
> > > Hi Namhyung,
> > >
> > > as we have:
> > > ```
> > > $(OUTPUT)%.o: %.c FORCE
> > >        $(call rule_mkdir)
> > >        $(call if_changed_dep,$(host)cc_o_c)
> > > ```
> > > I'm not sure what the 2 additional rules achieve.
> >
> > The above rule assumes the .c files are in the source directory
> > (without $(OUTPUT) prefix).  It caused a trouble when the
> > flex and bison files are generated in the output directory and
> > you have an old version of them in the source directory.
> >
> >
> > >
> > > >  # Gather build data:
> > > >  #   obj-y        - list of build objects
> > > >  #   subdir-y     - list of directories to nest
> > > > diff --git a/tools/perf/pmu-events/Build b/tools/perf/pmu-events/Build
> > > > index 150765f2baee..f38a27765604 100644
> > > > --- a/tools/perf/pmu-events/Build
> > > > +++ b/tools/perf/pmu-events/Build
> > > > @@ -35,3 +35,7 @@ $(PMU_EVENTS_C): $(JSON) $(JSON_TEST) $(JEVENTS_PY) $(METRIC_PY) $(METRIC_TEST_L
> > > >         $(call rule_mkdir)
> > > >         $(Q)$(call echo-cmd,gen)$(PYTHON) $(JEVENTS_PY) $(JEVENTS_ARCH) $(JEVENTS_MODEL) pmu-events/arch $@
> > > >  endif
> > > > +
> > > > +$(OUTPUT)pmu-events/pmu-events.o: $(PMU_EVENTS_C)
> > > > +       $(call rule_mkdir)
> > > > +       $(call if_changed_dep,$(host)cc_o_c)
> > >
> > > If we add this, do the Makefile.build changes still need to happen?
> >
> > The Makefile.build changes are specific to flex and bison files.
> > So yes, we need this for pmu-events.c to work properly with O=
> > option.
>
> Got it, you are right I was confusing the flex/bison with the jevents
> case. Can we get away with a single rule then:
> ```
>  $(OUTPUT)%.o:  $(OUTPUT)%.c FORCE
>         $(call rule_mkdir)
>         $(call if_changed_dep,$(host)cc_o_c)
> ```

Probably, but I wonder if it affects the normal .c files expecting
them in the OUTPUT directory.

Thanks,
Namhyung
