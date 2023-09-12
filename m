Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 665C379DA39
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 22:47:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233820AbjILUrk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 16:47:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbjILUri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 16:47:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D45BEE64;
        Tue, 12 Sep 2023 13:47:34 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42FB2C433C8;
        Tue, 12 Sep 2023 20:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694551654;
        bh=VVtwekb5c6SImWXWuWHyxmTmEMM/b8uhPzUHF1OjzCc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UXIi5uB6dxKea+sfVj3+f4RSYhz+XDKjyaolBDqisWYnrhdI6gscakENj8CqP0ctz
         dVqb4WMM9VNUw1dTSdlUkgiGHfi7P+ULq+d0FwJR26/6tBzoWEYvl0D+LBIxp3G7f4
         3na3pQPfOdbhy2OzuJxmbPImk4/Hk2cgkKA884wBLkvBak2xddo/qu1I6IPuiqmnjM
         Htih/LU9503YfJB81p2fi9xtWsB3n1fjk/dKxmQilO7bhhU4rZ4jEYnYEF59BnF5Xb
         z+pKjaCYQKJXo83UczMwh9cfWLWydcWgHmxsqucARU6xKDJyWk5QVD+YOGzlu+cml9
         sH66xoj/BpGrw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id AC4D2403F4; Tue, 12 Sep 2023 17:47:31 -0300 (-03)
Date:   Tue, 12 Sep 2023 17:47:31 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        James Clark <james.clark@arm.com>,
        Gaosheng Cui <cuigaosheng1@huawei.com>,
        Rob Herring <robh@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH v1 1/5] perf parse-events: Remove unused header files
Message-ID: <ZQDOY1z5dEGhpFDM@kernel.org>
References: <20230911170559.4037734-1-irogers@google.com>
 <CAM9d7cg4nc5rpW9jL-RPJP7w4Rg8h7t4A-EkHTE9rWF=Nm6bBQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM9d7cg4nc5rpW9jL-RPJP7w4Rg8h7t4A-EkHTE9rWF=Nm6bBQ@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Sep 11, 2023 at 10:58:18PM -0700, Namhyung Kim escreveu:
> On Mon, Sep 11, 2023 at 10:06 AM Ian Rogers <irogers@google.com> wrote:
> >
> > The fnmatch header is now used in the PMU matching logic in pmu.c.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> 
> Acked-by: Namhyung Kim <namhyung@kernel.org>



Thanks, applied the series.

- Arnaldo

 
> Thanks,
> Namhyung
> 
> > ---
> >  tools/perf/util/parse-events.y | 3 ---
> >  1 file changed, 3 deletions(-)
> >
> > diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
> > index 21bfe7e0d944..ef03728b7ea3 100644
> > --- a/tools/perf/util/parse-events.y
> > +++ b/tools/perf/util/parse-events.y
> > @@ -9,11 +9,8 @@
> >  #define YYDEBUG 1
> >
> >  #include <errno.h>
> > -#include <fnmatch.h>
> > -#include <stdio.h>
> >  #include <linux/compiler.h>
> >  #include <linux/types.h>
> > -#include <linux/zalloc.h>
> >  #include "pmu.h"
> >  #include "pmus.h"
> >  #include "evsel.h"
> > --
> > 2.42.0.283.g2d96d420d3-goog
> >

-- 

- Arnaldo
