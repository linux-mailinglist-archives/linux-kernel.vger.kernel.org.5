Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41B6F765278
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 13:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231642AbjG0Lcb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 07:32:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232640AbjG0LcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 07:32:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 361A43592;
        Thu, 27 Jul 2023 04:31:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7B6AF61E2F;
        Thu, 27 Jul 2023 11:31:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85A64C433C8;
        Thu, 27 Jul 2023 11:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690457515;
        bh=jAv2xm8xm8vlOThiQFo8mIHkMj+NUOu1NvVJLlhozh8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FmmKSFBAdaqVmu0Mbij36D0w+KKlSOmbEAhoUYZK6DY+gW49UVkGLQoLXkCIQuOUt
         H9gvK7gPiSdkpdmiUtGD0nHzRft7EEW2HN86CVgC/GgWQdRrsXRKg6O6JqOorwtNWP
         WYyuAsHqOQgcOg7D6Ublo516uZBG51+CeeFp55+xDEhbVPupJoGDgPyioR+2RDbtyp
         lLmEAkULimXHETO1xHkMAtfLirsg0kj6LkBji2frRyebd/gid+auq1oVCjSsP+9uFK
         0YGH42rmCHjw1kSCsCHS8SvO3XJOqE3/8UfV5qHsA02zUbNStxgaCPs2umZkVKBJbS
         fouw9+RItvL1A==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id C5F8A40516; Thu, 27 Jul 2023 08:31:52 -0300 (-03)
Date:   Thu, 27 Jul 2023 08:31:52 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        Anup Sharma <anupnewsmail@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] perf build: Update build rule for generated files
Message-ID: <ZMJVqPsj6tKWvvPx@kernel.org>
References: <20230726133642.750342-1-namhyung@kernel.org>
 <CAP-5=fWM9Fhq5WvsBf2n=hGwwwRDt3-mUQ=_qzu8qYGtD1OeWQ@mail.gmail.com>
 <CAM9d7citVc4ad65MLBWxvE-_AbwxO1DQWHf5w+ofSgWnWSx=Fw@mail.gmail.com>
 <CAP-5=fVbwf9=ZFszgFpb_6Qb003WpZC3_vtO7fB1pL_vH-OhQw@mail.gmail.com>
 <CAM9d7chcrd8mN55yb+oCBi3=AF4-a=oCr66+cv7eaquzx0Kvpw@mail.gmail.com>
 <CAP-5=fUPPRVSx9x4riCkkwEAza1N_r5qCxwqmdj0d7CEaKmCdw@mail.gmail.com>
 <CAM9d7cj6hpBbysg5grFWj89J3xTC8pio4juppBKH0ngvXq_n_Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM9d7cj6hpBbysg5grFWj89J3xTC8pio4juppBKH0ngvXq_n_Q@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Jul 26, 2023 at 11:45:44PM -0700, Namhyung Kim escreveu:
> On Wed, Jul 26, 2023 at 9:48 PM Ian Rogers <irogers@google.com> wrote:
> > On Wed, Jul 26, 2023 at 6:01 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > > On Wed, Jul 26, 2023 at 5:36 PM Ian Rogers <irogers@google.com> wrote:
> > > > On Wed, Jul 26, 2023 at 3:57 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > > > > On Wed, Jul 26, 2023 at 8:48 AM Ian Rogers <irogers@google.com> wrote:
> > > > > > On Wed, Jul 26, 2023 at 6:36 AM Namhyung Kim <namhyung@kernel.org> wrote:
> > > > > > > The bison and flex generate C files from the source (.y and .l)
> > > > > > > files.  When O= option is used, they are saved in a separate directory
> > > > > > > but the default build rule assumes the .C files are in the source
> > > > > > > directory.  So it might read invalid file if there are generated files
> > > > > > > from an old version.  The same is true for the pmu-events files.
> > > > > > >
> > > > > > > For example, the following command would cause a build failure:
> > > > > > >
> > > > > > >   $ git checkout v6.3
> > > > > > >   $ make -C tools/perf  # build in the same directory
> > > > > > >
> > > > > > >   $ git checkout v6.5-rc2
> > > > > > >   $ mkdir build  # create a build directory
> > > > > > >   $ make -C tools/perf O=build  # build in a different directory but it
> > > > > > >                                 # refers files in the source directory
> > > > > > >
> > > > > > > Let's update the build rule to specify those cases explicitly to depend
> > > > > > > on the files in the output directory.
> > > > > > >
> > > > > > > Note that it's not a complete fix and it needs the next patch for the
> > > > > > > include path too.
> > > > > > >
> > > > > > > Fixes: 80eeb67fe577 ("perf jevents: Program to convert JSON file")
> > > > > > > Cc: stable@vger.kernel.org
> > > > > > > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > > > > > > ---
> > > > > > >  tools/build/Makefile.build  | 8 ++++++++
> > > > > > >  tools/perf/pmu-events/Build | 4 ++++
> > > > > > >  2 files changed, 12 insertions(+)
> > > > > > >
> > > > > > > diff --git a/tools/build/Makefile.build b/tools/build/Makefile.build
> > > > > > > index 89430338a3d9..f9396696fcbf 100644
> > > > > > > --- a/tools/build/Makefile.build
> > > > > > > +++ b/tools/build/Makefile.build
> > > > > > > @@ -117,6 +117,14 @@ $(OUTPUT)%.s: %.c FORCE
> > > > > > >         $(call rule_mkdir)
> > > > > > >         $(call if_changed_dep,cc_s_c)
> > > > > > >
> > > > > > > +$(OUTPUT)%-bison.o: $(OUTPUT)%-bison.c FORCE
> > > > > > > +       $(call rule_mkdir)
> > > > > > > +       $(call if_changed_dep,$(host)cc_o_c)
> > > > > > > +
> > > > > > > +$(OUTPUT)%-flex.o: $(OUTPUT)%-flex.c FORCE
> > > > > > > +       $(call rule_mkdir)
> > > > > > > +       $(call if_changed_dep,$(host)cc_o_c)
> > > > > > > +
> > > > > >
> > > > > > Hi Namhyung,
> > > > > >
> > > > > > as we have:
> > > > > > ```
> > > > > > $(OUTPUT)%.o: %.c FORCE
> > > > > >        $(call rule_mkdir)
> > > > > >        $(call if_changed_dep,$(host)cc_o_c)
> > > > > > ```
> > > > > > I'm not sure what the 2 additional rules achieve.
> > > > >
> > > > > The above rule assumes the .c files are in the source directory
> > > > > (without $(OUTPUT) prefix).  It caused a trouble when the
> > > > > flex and bison files are generated in the output directory and
> > > > > you have an old version of them in the source directory.
> > > > >
> > > > > > >  # Gather build data:
> > > > > > >  #   obj-y        - list of build objects
> > > > > > >  #   subdir-y     - list of directories to nest
> > > > > > > diff --git a/tools/perf/pmu-events/Build b/tools/perf/pmu-events/Build
> > > > > > > index 150765f2baee..f38a27765604 100644
> > > > > > > --- a/tools/perf/pmu-events/Build
> > > > > > > +++ b/tools/perf/pmu-events/Build
> > > > > > > @@ -35,3 +35,7 @@ $(PMU_EVENTS_C): $(JSON) $(JSON_TEST) $(JEVENTS_PY) $(METRIC_PY) $(METRIC_TEST_L
> > > > > > >         $(call rule_mkdir)
> > > > > > >         $(Q)$(call echo-cmd,gen)$(PYTHON) $(JEVENTS_PY) $(JEVENTS_ARCH) $(JEVENTS_MODEL) pmu-events/arch $@
> > > > > > >  endif
> > > > > > > +
> > > > > > > +$(OUTPUT)pmu-events/pmu-events.o: $(PMU_EVENTS_C)
> > > > > > > +       $(call rule_mkdir)
> > > > > > > +       $(call if_changed_dep,$(host)cc_o_c)
> > > > > >
> > > > > > If we add this, do the Makefile.build changes still need to happen?
> > > > >
> > > > > The Makefile.build changes are specific to flex and bison files.
> > > > > So yes, we need this for pmu-events.c to work properly with O=
> > > > > option.
> > > >
> > > > Got it, you are right I was confusing the flex/bison with the jevents
> > > > case. Can we get away with a single rule then:
> > > > ```
> > > >  $(OUTPUT)%.o:  $(OUTPUT)%.c FORCE
> > > >         $(call rule_mkdir)
> > > >         $(call if_changed_dep,$(host)cc_o_c)
> > > > ```
> > >
> > > Probably, but I wonder if it affects the normal .c files expecting
> > > them in the OUTPUT directory.
> >
> > Hmm.. I think the longer matches may be necessary to trigger the "more
> > specific" ordering:
> > https://www.gnu.org/software/make/manual/html_node/Pattern-Match.html
> >
> > I'm not keen on these extra rules that mirror existing rules, it is a
> > bit cryptic what is going on. I wonder if it would be cleaner just to
> > fail the build if the bogus pmu-events.c exists. For example:
> 
> I prefer just making it build instead of failing.  But not strongly
> against your idea.  It'd be nice to hear what others think.. Arnaldo?

I think that we should just ignore any build files in the source tree
when using 'O=', i.e.:

make -C tools/perf

genereated files (in the source tree) should not be used when, right
after running it, we run:

make -C tools/perf O=/some/build/dir

If we run 'make -C tools/perf' and there is a pmu-events.c, use it if
its timestamp is more recent than the files from which it was generated,
as usual for a make managed build.

- Arnaldo
 
> > ```
> > --- a/tools/perf/pmu-events/Build
> > +++ b/tools/perf/pmu-events/Build
> > @@ -12,6 +12,14 @@ EMPTY_PMU_EVENTS_C = pmu-events/empty-pmu-events.c
> > PMU_EVENTS_C   =  $(OUTPUT)pmu-events/pmu-events.c
> > METRIC_TEST_LOG        =  $(OUTPUT)pmu-events/metric_test.log
> >
> > +ifneq ($(OUTPUT),)
> > +ifneq ($(wildcard pmu-events/pmu-events.c),)
> > +dummy := $(error OUTPUT set but tools/perf/pmu-events/pmu-events.c exists. \
> > +           This can mean the generated version of pmu-events.c is not
> > compiled. \
> > +           Try 'cd tools/perf; make clean; cd -' and then rebuilding.)
> 
> I've tested this and this message is buried in the stream of
> parallel build outputs. :(
> 
> Thanks,
> Namhyung
> 
> 
> > +endif
> > +endif
> > +
> > ifeq ($(JEVENTS_ARCH),)
> > JEVENTS_ARCH=$(SRCARCH)
> > endif
> > ```

-- 

- Arnaldo
