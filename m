Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B30A76424E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 00:57:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbjGZW5S convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 26 Jul 2023 18:57:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbjGZW5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 18:57:15 -0400
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D64EE271D;
        Wed, 26 Jul 2023 15:57:14 -0700 (PDT)
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-7878e573827so11624839f.1;
        Wed, 26 Jul 2023 15:57:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690412234; x=1691017034;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PCmsUfocE9nW+Ujffe8WMtyaTbfPSG5Ra3w/88GS7Cs=;
        b=Y1pGY9gxRxZgx8o/K7Q7Wu7fC+AERx1rMm4PQ27QsCE7apgo1FUm2W4WeHFyuUGpRa
         BLzZc/INEOD7i2RVK78fDDOxM2wuIgvrgsPe8qsF82O59hehZu1vFwxR/GAcoCPiH92u
         euwATkOHp0R267sxXTPUt2AWzo1dCXWRqX76r70QwdWidDS+0HJuJz5XsHblZIhYqUvd
         e4A9NMk795NPmUAiLp5ROq1eOT9bRa5nKU+Zrm8OuZGL5oyeghv2HPcTXW/MnCeI8/S2
         D9HWEc724L8+LvtuYa7cW9yUfR35wh5AjWBA3Iet/dI5BDsF23qFu0nXcZgLkIslxjYE
         A6mg==
X-Gm-Message-State: ABy/qLY6XjMngTS8ESoermipv85ii0GrHk+TtjW7mi+Ej9i1u91RxQGP
        fzLiY56GeLeZ3gy0oN9Z6k+3fmoU6swfMv65NvQ=
X-Google-Smtp-Source: APBJJlHh2gUCZiBJFkBIROZc3Z1R5phzbX2MgRI7IChXg2C2q6TW7eiEAOCTDJz5b3e5CQMyu3m2/tYQ9TdHHFdG4cs=
X-Received: by 2002:a05:6602:42ca:b0:783:63ac:25cf with SMTP id
 ce10-20020a05660242ca00b0078363ac25cfmr3470921iob.7.1690412233786; Wed, 26
 Jul 2023 15:57:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230726133642.750342-1-namhyung@kernel.org> <CAP-5=fWM9Fhq5WvsBf2n=hGwwwRDt3-mUQ=_qzu8qYGtD1OeWQ@mail.gmail.com>
In-Reply-To: <CAP-5=fWM9Fhq5WvsBf2n=hGwwwRDt3-mUQ=_qzu8qYGtD1OeWQ@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 26 Jul 2023 15:57:02 -0700
Message-ID: <CAM9d7citVc4ad65MLBWxvE-_AbwxO1DQWHf5w+ofSgWnWSx=Fw@mail.gmail.com>
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
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ian,

On Wed, Jul 26, 2023 at 8:48 AM Ian Rogers <irogers@google.com> wrote:
>
> On Wed, Jul 26, 2023 at 6:36 AM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > The bison and flex generate C files from the source (.y and .l)
> > files.  When O= option is used, they are saved in a separate directory
> > but the default build rule assumes the .C files are in the source
> > directory.  So it might read invalid file if there are generated files
> > from an old version.  The same is true for the pmu-events files.
> >
> > For example, the following command would cause a build failure:
> >
> >   $ git checkout v6.3
> >   $ make -C tools/perf  # build in the same directory
> >
> >   $ git checkout v6.5-rc2
> >   $ mkdir build  # create a build directory
> >   $ make -C tools/perf O=build  # build in a different directory but it
> >                                 # refers files in the source directory
> >
> > Let's update the build rule to specify those cases explicitly to depend
> > on the files in the output directory.
> >
> > Note that it's not a complete fix and it needs the next patch for the
> > include path too.
> >
> > Fixes: 80eeb67fe577 ("perf jevents: Program to convert JSON file")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  tools/build/Makefile.build  | 8 ++++++++
> >  tools/perf/pmu-events/Build | 4 ++++
> >  2 files changed, 12 insertions(+)
> >
> > diff --git a/tools/build/Makefile.build b/tools/build/Makefile.build
> > index 89430338a3d9..f9396696fcbf 100644
> > --- a/tools/build/Makefile.build
> > +++ b/tools/build/Makefile.build
> > @@ -117,6 +117,14 @@ $(OUTPUT)%.s: %.c FORCE
> >         $(call rule_mkdir)
> >         $(call if_changed_dep,cc_s_c)
> >
> > +$(OUTPUT)%-bison.o: $(OUTPUT)%-bison.c FORCE
> > +       $(call rule_mkdir)
> > +       $(call if_changed_dep,$(host)cc_o_c)
> > +
> > +$(OUTPUT)%-flex.o: $(OUTPUT)%-flex.c FORCE
> > +       $(call rule_mkdir)
> > +       $(call if_changed_dep,$(host)cc_o_c)
> > +
>
> Hi Namhyung,
>
> as we have:
> ```
> $(OUTPUT)%.o: %.c FORCE
>        $(call rule_mkdir)
>        $(call if_changed_dep,$(host)cc_o_c)
> ```
> I'm not sure what the 2 additional rules achieve.

The above rule assumes the .c files are in the source directory
(without $(OUTPUT) prefix).  It caused a trouble when the
flex and bison files are generated in the output directory and
you have an old version of them in the source directory.


>
> >  # Gather build data:
> >  #   obj-y        - list of build objects
> >  #   subdir-y     - list of directories to nest
> > diff --git a/tools/perf/pmu-events/Build b/tools/perf/pmu-events/Build
> > index 150765f2baee..f38a27765604 100644
> > --- a/tools/perf/pmu-events/Build
> > +++ b/tools/perf/pmu-events/Build
> > @@ -35,3 +35,7 @@ $(PMU_EVENTS_C): $(JSON) $(JSON_TEST) $(JEVENTS_PY) $(METRIC_PY) $(METRIC_TEST_L
> >         $(call rule_mkdir)
> >         $(Q)$(call echo-cmd,gen)$(PYTHON) $(JEVENTS_PY) $(JEVENTS_ARCH) $(JEVENTS_MODEL) pmu-events/arch $@
> >  endif
> > +
> > +$(OUTPUT)pmu-events/pmu-events.o: $(PMU_EVENTS_C)
> > +       $(call rule_mkdir)
> > +       $(call if_changed_dep,$(host)cc_o_c)
>
> If we add this, do the Makefile.build changes still need to happen?

The Makefile.build changes are specific to flex and bison files.
So yes, we need this for pmu-events.c to work properly with O=
option.

Thanks,
Namhyung
