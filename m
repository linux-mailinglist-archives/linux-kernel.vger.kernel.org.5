Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B64CF80F533
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 19:04:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377074AbjLLSEo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 13:04:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377029AbjLLSEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 13:04:42 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 487B394
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 10:04:49 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5DBEC433C8;
        Tue, 12 Dec 2023 18:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702404288;
        bh=nk//IozMK5UtGAQ/gn7b/tWhhxOCqLkulLRTpbFg1zQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oW+oYDoEzayjqebiyy/C7FhsvKbOlDvGllnGrDnx6jqmjPnx63vvu9RHSIaPJ5qYs
         pG8djXTEAmorTUJFzOi4mft4v07TwgfHvHEpLX5VDbT/p8QkeFe9EBxWlfzparAUz/
         OofwMCMIbZgd88mr/MmmADAaV5bPBadPQGqmPNIRj3D/q7kZVIFPE4BISJUHGOE/Rc
         LX5MFFEklOfJipYZI70Xyp3s4C5eGMog4vH+VatH1C/g59YmJ+9WZJzKUudmijFU9A
         ca3Lee5jIqjBhhDuP7mQcUw5LqfPep6MLc1kLL+W/qlOw2pjishkzUQiCODmHQjOLT
         yNmos7nQPwCwQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id C5850403EF; Tue, 12 Dec 2023 15:04:43 -0300 (-03)
Date:   Tue, 12 Dec 2023 15:04:43 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v1] perf stat: Fix help message for --metric-no-threshold
 option
Message-ID: <ZXigu8c0ee0u4uI/@kernel.org>
References: <20231129223540.2247030-1-irogers@google.com>
 <CAP-5=fXeZpOg7cHDZmTLvQh=FTamvpdw+=q9vcqrUBd9v7ifLQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fXeZpOg7cHDZmTLvQh=FTamvpdw+=q9vcqrUBd9v7ifLQ@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Dec 11, 2023 at 11:39:02AM -0800, Ian Rogers escreveu:
> On Wed, Nov 29, 2023 at 2:36 PM Ian Rogers <irogers@google.com> wrote:
> >
> > Copy-paste error led to help message for metric-no-threshold repeating
> > that of metric-no-merge.
> >
> > Reported-by: Stephane Eranian <eranian@google.com>
> > Fixes: 1fd09e299bdd ("perf metric: Add --metric-no-threshold option")
> > Signed-off-by: Ian Rogers <irogers@google.com>
> 
> Ping. Thanks,
> Ian

This is in perf-tools-next now.

- Arnaldo
 
> > ---
> >  tools/perf/builtin-stat.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> > index a3af805a1d57..c77a3308d3fb 100644
> > --- a/tools/perf/builtin-stat.c
> > +++ b/tools/perf/builtin-stat.c
> > @@ -1255,7 +1255,7 @@ static struct option stat_options[] = {
> >         OPT_BOOLEAN(0, "metric-no-merge", &stat_config.metric_no_merge,
> >                        "don't try to share events between metrics in a group"),
> >         OPT_BOOLEAN(0, "metric-no-threshold", &stat_config.metric_no_threshold,
> > -                      "don't try to share events between metrics in a group  "),
> > +                      "disable adding events for the metric threshold calculation"),
> >         OPT_BOOLEAN(0, "topdown", &topdown_run,
> >                         "measure top-down statistics"),
> >         OPT_UINTEGER(0, "td-level", &stat_config.topdown_level,
> > --
> > 2.43.0.rc1.413.gea7ed67945-goog
> >

-- 

- Arnaldo
