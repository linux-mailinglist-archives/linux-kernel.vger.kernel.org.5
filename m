Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B422C7FA959
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 19:57:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232654AbjK0S5k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 13:57:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230302AbjK0S5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 13:57:38 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C408D59
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 10:57:44 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D479DC433C8;
        Mon, 27 Nov 2023 18:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701111464;
        bh=v6smM2Uc7gxZPOcwWStm5gIhkDbMPrvclde1FyyVbjs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dSJ6tAk0a39JkTu7tqg7ikqxlQ3VVe4KBbi9vXH1uxn9IuZhu5qJmBmAqm2RTpNwf
         kywo3Kt1Ja2ZUZAkefoH+ca4VRdEP/x+W9Y3QeZA6SABHi+rXvqsZZeb4+uo5E0DAA
         cZ04leTlgJTD+hn4xkfMW1JzmJnANzAMP69HkbS8izktN4HhFt1Y3N7qITCuKcS56O
         EDaxsmivEynUd5vNAZLfsWDPNDgkB/XDC+rEqPuNb8VB5GdIIeCOISuhj9dsXNalUd
         kBmnffuf+6FjK6rOzRqEIh+sYykc+LI+zVS7aUKqwU9aq1prj/mRrTdFaNX3QqTai7
         dVAzFP691lu9Q==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 7209340094; Mon, 27 Nov 2023 15:57:41 -0300 (-03)
Date:   Mon, 27 Nov 2023 15:57:41 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     James Clark <james.clark@arm.com>,
        linux-perf-users@vger.kernel.org, irogers@google.com,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Yonghong Song <yhs@fb.com>, Fangrui Song <maskray@google.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf test: Use existing config value for objdump path
Message-ID: <ZWTmpW1bchqiNK94@kernel.org>
References: <20231113102327.695386-1-james.clark@arm.com>
 <CAM9d7cj=nF_Vq7dPkOGvYd1G0nFOffiCoyZQ=hx1hco-0_ZMBw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM9d7cj=nF_Vq7dPkOGvYd1G0nFOffiCoyZQ=hx1hco-0_ZMBw@mail.gmail.com>
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

Em Mon, Nov 20, 2023 at 12:48:38PM -0800, Namhyung Kim escreveu:
> Hello,
> 
> On Mon, Nov 13, 2023 at 2:23 AM James Clark <james.clark@arm.com> wrote:
> >
> > There is already an existing config value for changing the objdump path,
> > so instead of having two values that do the same thing, make perf test
> > use annotate.objdump as well.
> >
> > Signed-off-by: James Clark <james.clark@arm.com>
> 
> Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks, applied to perf-tools-next.

- Arnaldo

 
> Thanks,
> Namhyung
> 
> > ---
> >  tools/perf/Documentation/perf-config.txt | 8 ++------
> >  tools/perf/tests/builtin-test.c          | 2 +-
> >  2 files changed, 3 insertions(+), 7 deletions(-)
> >
> > diff --git a/tools/perf/Documentation/perf-config.txt b/tools/perf/Documentation/perf-config.txt
> > index 16398babd1ef..379f9d7a8ab1 100644
> > --- a/tools/perf/Documentation/perf-config.txt
> > +++ b/tools/perf/Documentation/perf-config.txt
> > @@ -251,7 +251,8 @@ annotate.*::
> >                 addr2line binary to use for file names and line numbers.
> >
> >         annotate.objdump::
> > -               objdump binary to use for disassembly and annotations.
> > +               objdump binary to use for disassembly and annotations,
> > +               including in the 'perf test' command.
> >
> >         annotate.disassembler_style::
> >                 Use this to change the default disassembler style to some other value
> > @@ -722,11 +723,6 @@ session-<NAME>.*::
> >                 Defines new record session for daemon. The value is record's
> >                 command line without the 'record' keyword.
> >
> > -test.*::
> > -
> > -       test.objdump::
> > -               objdump binary to use for disassembly and annotations.
> > -
> >  SEE ALSO
> >  --------
> >  linkperf:perf[1]
> > diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
> > index 113e92119e1d..b8c21e81a021 100644
> > --- a/tools/perf/tests/builtin-test.c
> > +++ b/tools/perf/tests/builtin-test.c
> > @@ -518,7 +518,7 @@ static int run_workload(const char *work, int argc, const char **argv)
> >  static int perf_test__config(const char *var, const char *value,
> >                              void *data __maybe_unused)
> >  {
> > -       if (!strcmp(var, "test.objdump"))
> > +       if (!strcmp(var, "annotate.objdump"))
> >                 test_objdump_path = value;
> >
> >         return 0;
> > --
> > 2.34.1
> >

-- 

- Arnaldo
