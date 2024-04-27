Return-Path: <linux-kernel+bounces-160849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 857FE8B4383
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 03:33:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0D0E1C221CB
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 01:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78F483A1CD;
	Sat, 27 Apr 2024 01:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L+MXjIlX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A1F39FFD
	for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2024 01:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714181566; cv=none; b=m0UfZhV3KYVL0hO+MJYKHiQMEmYIUBSK6pHmPpzzQveV55XUzR4jclv4aDDE+wblB9i9Unj6WEZXxso9+ipxUCoM/HNF5s4Ql4QHBxmMuTjJ1PD0fQVyeKKDUA11pKm8al27Ho8PWybfhVvpEemacastM7AvXz17E6YGHBEDUzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714181566; c=relaxed/simple;
	bh=P0TWaoheW0V5ZLyC+9Db8WEP5TNa1BwAgHHI4VdpbGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tCyOmVzgwpRb4eOBEUwgRTG2TLBtTRRQIqTKR+pMaAZdauGT5P0wtf1HvTpMnxQ5OjwMcc28sJzYu2RfL4KBMpnMOP/p/lIbnvGzc3leVYR2nzEtjVR9NdxEba6c2aeZRWEKOz33f3ESNRpU0bDmn4Fz7gc/qxNImUNw452bOEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L+MXjIlX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3FCAC113CD;
	Sat, 27 Apr 2024 01:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714181566;
	bh=P0TWaoheW0V5ZLyC+9Db8WEP5TNa1BwAgHHI4VdpbGs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L+MXjIlXA5vhRJaWHga8HKdGDzvpnHgZfRrURF7XAUKklqSbNGTkv+0eor0roAomr
	 d+rlVNMDbBYnjxG17tMnVdP0rAXDjDkr9ftNl4T+AD/29o0DbrOnPFquNfEDEYHVeK
	 AfUNhNI2FFDy2cu3rVkZmY02U8glZJoWUOtoyhaAgoNWDqO3FL1K9XTIwMxMbh3vjt
	 o1K7H7V3Q4UhR+Ia4lowjXwYBUXaGAOqjDMSbpq7c9DwIafl37wYoqrp2fdDb743v1
	 oyYmuUkByIIrJdzw62ZpsCo1nL9jG1NJs71n7dwkLmTgFsnf5t5zsEvVnwiwNxvr4C
	 2/My0JZ58IT6g==
Date: Fri, 26 Apr 2024 22:32:43 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	James Clark <james.clark@arm.com>, Jiri Olsa <jolsa@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] perf test: Reintroduce -p/--parallel and make
 -S/--sequential the default
Message-ID: <ZixVuyDSvTETMvi6@x1>
References: <Ziwm18BqIn_vc1vn@x1>
 <CAP-5=fXKsW_cD6=k7yAkNwwdmKqOSMga8Y7o4CwMd+9MOSw0zA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fXKsW_cD6=k7yAkNwwdmKqOSMga8Y7o4CwMd+9MOSw0zA@mail.gmail.com>

On Fri, Apr 26, 2024 at 03:19:22PM -0700, Ian Rogers wrote:
> On Fri, Apr 26, 2024 at 3:12 PM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > We can't default to doing parallel tests as there are tests that compete
> > for the same resources and thus clash, for instance tests that put in
> > place 'perf probe' probes, that clean the probes without regard to other
> > tests needs, ARM64 coresight tests, Intel PT ones, etc.
> >
> > So reintroduce --p/--parallel and make -S/--sequential the default.
> >
> > We need to come up with infrastructure that state which tests can't run
> > in parallel because they need exclusive access to some resource,
> > something as simple as "probes" that would then avoid 'perf probe' tests
> > from running while other such test is running, or make the tests more
> > resilient, till then we can't use parallel mode as default.
> >
> > While at it, document all these options in the 'perf test' man page.
> 
> Looks good to me, LKML?

Right, CCed now.
 
> Reviewed-by: Ian Rogers <irogers@google.com>

Thanks!

- Arnaldo
 
> Thanks,
> Ian
> 
> 
> > Reported-by: Adrian Hunter <adrian.hunter@intel.com>
> > Reported-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > Reported-by: James Clark <james.clark@arm.com>
> > Acked-by: Ian Rogers <irogers@google.com>
> > Cc: Jiri Olsa <jolsa@kernel.org>
> > Cc: Kan Liang <kan.liang@linux.intel.com>
> > Cc: Namhyung Kim <namhyung@kernel.org>
> > Link: https://lore.kernel.org/lkml/
> > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > ---
> >  tools/perf/Documentation/perf-test.txt | 13 ++++++++++++-
> >  tools/perf/tests/builtin-test.c        |  8 +++++++-
> >  2 files changed, 19 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/perf/Documentation/perf-test.txt b/tools/perf/Documentation/perf-test.txt
> > index 951a2f2628727a95..9acb8d1f658890e9 100644
> > --- a/tools/perf/Documentation/perf-test.txt
> > +++ b/tools/perf/Documentation/perf-test.txt
> > @@ -31,9 +31,20 @@ OPTIONS
> >  --verbose::
> >         Be more verbose.
> >
> > +-S::
> > +--sequential::
> > +       Run tests one after the other, this is the default mode.
> > +
> > +-p::
> > +--parallel::
> > +       Run tests in parallel, speeds up the whole process but is not safe with
> > +       the current infrastructure, where some tests that compete for some resources,
> > +       for instance, 'perf probe' tests that add/remove probes or clean all probes, etc.
> > +
> >  -F::
> >  --dont-fork::
> > -       Do not fork child for each test, run all tests within single process.
> > +       Do not fork child for each test, run all tests within single process, this
> > +       sets sequential mode.
> >
> >  --dso::
> >         Specify a DSO for the "Symbols" test.
> > diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
> > index 73f53b02f7334692..c3d84b67ca8e775d 100644
> > --- a/tools/perf/tests/builtin-test.c
> > +++ b/tools/perf/tests/builtin-test.c
> > @@ -40,7 +40,10 @@
> >   */
> >  static bool dont_fork;
> >  /* Don't fork the tests in parallel and wait for their completion. */
> > -static bool sequential;
> > +static bool sequential = true;
> > +/* Do it in parallel, lacks infrastructure to avoid running tests that clash for resources,
> > + * So leave it as the developers choice to enable while working on the needed infra */
> > +static bool parallel;
> >  const char *dso_to_test;
> >  const char *test_objdump_path = "objdump";
> >
> > @@ -536,6 +539,7 @@ int cmd_test(int argc, const char **argv)
> >                     "be more verbose (show symbol address, etc)"),
> >         OPT_BOOLEAN('F', "dont-fork", &dont_fork,
> >                     "Do not fork for testcase"),
> > +       OPT_BOOLEAN('p', "parallel", &parallel, "Run the tests in parallel"),
> >         OPT_BOOLEAN('S', "sequential", &sequential,
> >                     "Run the tests one after another rather than in parallel"),
> >         OPT_STRING('w', "workload", &workload, "work", "workload to run for testing"),
> > @@ -566,6 +570,8 @@ int cmd_test(int argc, const char **argv)
> >
> >         if (dont_fork)
> >                 sequential = true;
> > +       else if (parallel)
> > +               sequential = false;
> >
> >         symbol_conf.priv_size = sizeof(int);
> >         symbol_conf.try_vmlinux_path = true;
> > --
> > 2.44.0
> >

