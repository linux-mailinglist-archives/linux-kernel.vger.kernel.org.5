Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD6276617E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 03:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232087AbjG1Buy convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 27 Jul 2023 21:50:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbjG1Buw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 21:50:52 -0400
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9194271C;
        Thu, 27 Jul 2023 18:50:49 -0700 (PDT)
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-78362f57500so66675039f.3;
        Thu, 27 Jul 2023 18:50:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690509049; x=1691113849;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RZ42CZmwkz7V9zb1700WU83svJstoQ0Nko3o/ahwyUU=;
        b=D7aKJa8ulgX7FW9BLbOSrpWp9JEz4hRbGLucd5qW0ZVxPmMgoilJX1Z+N1blVxIymZ
         TAlFl7n0ee4It46ku3LbENsTh/imZgyYUAm8WqEhjAiMcKGiHAls27TOT2ZQ2b65Qpys
         otmS5q6/sXf2jUI+Y3Xm2Aq9MsG5ZjZpMcJNWNN0qCGY8aGuKJGFkF+ejts9YYo5JEdi
         d3sYTPlu73LxJxWTaU01XG3y7LffHwH5nbD1L4OvxBCo0JNuBiKYN2n//7R9C/NAS1Uh
         z6xHDkXVrEnDDTPrGUUmbWoAPt/2x48ALTPHxXd8kFHTS7vuPKlS+yaexhKltkhqXyIC
         RdnQ==
X-Gm-Message-State: ABy/qLanrcZGvXUi4TErD1NynQaBD6uEUPRYTexCWhSXHXYTzYS3NPLY
        NDdYkWrkprT5X0nzYs1pOPy8U/aek8MXAViNR9o=
X-Google-Smtp-Source: APBJJlGWMjVCyz4re2uj35Hg2YAK6MtWQODly3WijMsDHAO11WZacBXLOAuxoy6++SrZm+wKo+G+iUmVapMqh4Xvt3s=
X-Received: by 2002:a5d:8595:0:b0:786:463b:2ceb with SMTP id
 f21-20020a5d8595000000b00786463b2cebmr1399822ioj.11.1690509049049; Thu, 27
 Jul 2023 18:50:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230726133642.750342-1-namhyung@kernel.org> <CAP-5=fWM9Fhq5WvsBf2n=hGwwwRDt3-mUQ=_qzu8qYGtD1OeWQ@mail.gmail.com>
 <CAM9d7citVc4ad65MLBWxvE-_AbwxO1DQWHf5w+ofSgWnWSx=Fw@mail.gmail.com>
 <CAP-5=fVbwf9=ZFszgFpb_6Qb003WpZC3_vtO7fB1pL_vH-OhQw@mail.gmail.com>
 <CAM9d7chcrd8mN55yb+oCBi3=AF4-a=oCr66+cv7eaquzx0Kvpw@mail.gmail.com>
 <CAP-5=fUPPRVSx9x4riCkkwEAza1N_r5qCxwqmdj0d7CEaKmCdw@mail.gmail.com>
 <CAM9d7cj6hpBbysg5grFWj89J3xTC8pio4juppBKH0ngvXq_n_Q@mail.gmail.com> <ZMJVqPsj6tKWvvPx@kernel.org>
In-Reply-To: <ZMJVqPsj6tKWvvPx@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 27 Jul 2023 18:50:37 -0700
Message-ID: <CAM9d7cjxxFh7pQ3T=MzWu2=7cKc7dmQHp47jOwnj9u+dOo7tsw@mail.gmail.com>
Subject: Re: [PATCH 1/2] perf build: Update build rule for generated files
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
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
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo,

On Thu, Jul 27, 2023 at 4:31 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Wed, Jul 26, 2023 at 11:45:44PM -0700, Namhyung Kim escreveu:
> > On Wed, Jul 26, 2023 at 9:48 PM Ian Rogers <irogers@google.com> wrote:
> > > On Wed, Jul 26, 2023 at 6:01 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > > > On Wed, Jul 26, 2023 at 5:36 PM Ian Rogers <irogers@google.com> wrote:
> > > > > On Wed, Jul 26, 2023 at 3:57 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > > > > > On Wed, Jul 26, 2023 at 8:48 AM Ian Rogers <irogers@google.com> wrote:
> > > > > > > On Wed, Jul 26, 2023 at 6:36 AM Namhyung Kim <namhyung@kernel.org> wrote:
> > > > > > > > The bison and flex generate C files from the source (.y and .l)
> > > > > > > > files.  When O= option is used, they are saved in a separate directory
> > > > > > > > but the default build rule assumes the .C files are in the source
> > > > > > > > directory.  So it might read invalid file if there are generated files
> > > > > > > > from an old version.  The same is true for the pmu-events files.
> > > > > > > >
> > > > > > > > For example, the following command would cause a build failure:
> > > > > > > >
> > > > > > > >   $ git checkout v6.3
> > > > > > > >   $ make -C tools/perf  # build in the same directory
> > > > > > > >
> > > > > > > >   $ git checkout v6.5-rc2
> > > > > > > >   $ mkdir build  # create a build directory
> > > > > > > >   $ make -C tools/perf O=build  # build in a different directory but it
> > > > > > > >                                 # refers files in the source directory
> > > > > > > >
> > > > > > > > Let's update the build rule to specify those cases explicitly to depend
> > > > > > > > on the files in the output directory.
> > > > > > > >
> > > > > > > > Note that it's not a complete fix and it needs the next patch for the
> > > > > > > > include path too.
> > > > > > > >
> > > > > > > > Fixes: 80eeb67fe577 ("perf jevents: Program to convert JSON file")
> > > > > > > > Cc: stable@vger.kernel.org
> > > > > > > > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > > > > > > > ---
> > > > > > > >  tools/build/Makefile.build  | 8 ++++++++
> > > > > > > >  tools/perf/pmu-events/Build | 4 ++++
> > > > > > > >  2 files changed, 12 insertions(+)
> > > > > > > >
> > > > > > > > diff --git a/tools/build/Makefile.build b/tools/build/Makefile.build
> > > > > > > > index 89430338a3d9..f9396696fcbf 100644
> > > > > > > > --- a/tools/build/Makefile.build
> > > > > > > > +++ b/tools/build/Makefile.build
> > > > > > > > @@ -117,6 +117,14 @@ $(OUTPUT)%.s: %.c FORCE
> > > > > > > >         $(call rule_mkdir)
> > > > > > > >         $(call if_changed_dep,cc_s_c)
> > > > > > > >
> > > > > > > > +$(OUTPUT)%-bison.o: $(OUTPUT)%-bison.c FORCE
> > > > > > > > +       $(call rule_mkdir)
> > > > > > > > +       $(call if_changed_dep,$(host)cc_o_c)
> > > > > > > > +
> > > > > > > > +$(OUTPUT)%-flex.o: $(OUTPUT)%-flex.c FORCE
> > > > > > > > +       $(call rule_mkdir)
> > > > > > > > +       $(call if_changed_dep,$(host)cc_o_c)
> > > > > > > > +
> > > > > > >
> > > > > > > Hi Namhyung,
> > > > > > >
> > > > > > > as we have:
> > > > > > > ```
> > > > > > > $(OUTPUT)%.o: %.c FORCE
> > > > > > >        $(call rule_mkdir)
> > > > > > >        $(call if_changed_dep,$(host)cc_o_c)
> > > > > > > ```
> > > > > > > I'm not sure what the 2 additional rules achieve.
> > > > > >
> > > > > > The above rule assumes the .c files are in the source directory
> > > > > > (without $(OUTPUT) prefix).  It caused a trouble when the
> > > > > > flex and bison files are generated in the output directory and
> > > > > > you have an old version of them in the source directory.
> > > > > >
> > > > > > > >  # Gather build data:
> > > > > > > >  #   obj-y        - list of build objects
> > > > > > > >  #   subdir-y     - list of directories to nest
> > > > > > > > diff --git a/tools/perf/pmu-events/Build b/tools/perf/pmu-events/Build
> > > > > > > > index 150765f2baee..f38a27765604 100644
> > > > > > > > --- a/tools/perf/pmu-events/Build
> > > > > > > > +++ b/tools/perf/pmu-events/Build
> > > > > > > > @@ -35,3 +35,7 @@ $(PMU_EVENTS_C): $(JSON) $(JSON_TEST) $(JEVENTS_PY) $(METRIC_PY) $(METRIC_TEST_L
> > > > > > > >         $(call rule_mkdir)
> > > > > > > >         $(Q)$(call echo-cmd,gen)$(PYTHON) $(JEVENTS_PY) $(JEVENTS_ARCH) $(JEVENTS_MODEL) pmu-events/arch $@
> > > > > > > >  endif
> > > > > > > > +
> > > > > > > > +$(OUTPUT)pmu-events/pmu-events.o: $(PMU_EVENTS_C)
> > > > > > > > +       $(call rule_mkdir)
> > > > > > > > +       $(call if_changed_dep,$(host)cc_o_c)
> > > > > > >
> > > > > > > If we add this, do the Makefile.build changes still need to happen?
> > > > > >
> > > > > > The Makefile.build changes are specific to flex and bison files.
> > > > > > So yes, we need this for pmu-events.c to work properly with O=
> > > > > > option.
> > > > >
> > > > > Got it, you are right I was confusing the flex/bison with the jevents
> > > > > case. Can we get away with a single rule then:
> > > > > ```
> > > > >  $(OUTPUT)%.o:  $(OUTPUT)%.c FORCE
> > > > >         $(call rule_mkdir)
> > > > >         $(call if_changed_dep,$(host)cc_o_c)
> > > > > ```
> > > >
> > > > Probably, but I wonder if it affects the normal .c files expecting
> > > > them in the OUTPUT directory.
> > >
> > > Hmm.. I think the longer matches may be necessary to trigger the "more
> > > specific" ordering:
> > > https://www.gnu.org/software/make/manual/html_node/Pattern-Match.html
> > >
> > > I'm not keen on these extra rules that mirror existing rules, it is a
> > > bit cryptic what is going on. I wonder if it would be cleaner just to
> > > fail the build if the bogus pmu-events.c exists. For example:
> >
> > I prefer just making it build instead of failing.  But not strongly
> > against your idea.  It'd be nice to hear what others think.. Arnaldo?
>
> I think that we should just ignore any build files in the source tree
> when using 'O=', i.e.:
>
> make -C tools/perf
>
> genereated files (in the source tree) should not be used when, right
> after running it, we run:
>
> make -C tools/perf O=/some/build/dir
>
> If we run 'make -C tools/perf' and there is a pmu-events.c, use it if
> its timestamp is more recent than the files from which it was generated,
> as usual for a make managed build.

Right, this is what my patch does by adding specific rules for
generated files.  I'll add a comment to describe why it's needed.

Thanks,
Namhyung
