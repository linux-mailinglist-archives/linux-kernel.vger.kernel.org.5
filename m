Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45D71803E91
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 20:41:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232463AbjLDTlM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 14:41:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230299AbjLDTlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 14:41:11 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFB33B6
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 11:41:17 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18A96C433C7;
        Mon,  4 Dec 2023 19:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701718877;
        bh=RXdn7YdWXNah7nltudb7qfhHrrahkAbHAZJ9llIwtKk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=skGr+AUrsXfkqS8yjxDbQcG1zzlrRlu6/XRbuE/W1hpt7mvk3YKmkmqnk0r1w4CcT
         4WN2hCtnHymCJWtSmr2QbG4PbzJRvGlWkXTqiNiYPMQbOHiHiYG4Idp3vhRseXYdpZ
         vo7P6CgJoQPm67QxvSMW4fGwefcYs1WyVhsF80C79Ymr7tmIb6GKKanV9QJorMqULn
         xxosg2gN7/8TkIHIrcFHd5BfGo2Q4KvqMw9xFPl7WO5j0PACRfzCSqgbvvTjxZeSN8
         YrQxgFn9RvTcKWsXSAXY98uzdE4ertHEuBks4tjh9SP6esxgRgOM5qqR7VbML6v9G5
         gQsqAQio3ta+Q==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id D568240094; Mon,  4 Dec 2023 16:41:13 -0300 (-03)
Date:   Mon, 4 Dec 2023 16:41:13 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Ilkka Koskinen <ilkka@os.amperecomputing.com>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 1/3] perf vendor events arm64: AmpereOne: Add missing
 DefaultMetricgroupName fields
Message-ID: <ZW4rWWiMkeLpRPXa@kernel.org>
References: <20231201021550.1109196-1-ilkka@os.amperecomputing.com>
 <20231201021550.1109196-2-ilkka@os.amperecomputing.com>
 <CAP-5=fWr0bmqZjyYiBuMuCD+sPCULmF_q7hU4J8ouvcvwb5Z6w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fWr0bmqZjyYiBuMuCD+sPCULmF_q7hU4J8ouvcvwb5Z6w@mail.gmail.com>
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

Em Mon, Dec 04, 2023 at 11:02:31AM -0800, Ian Rogers escreveu:
> On Thu, Nov 30, 2023 at 6:16 PM Ilkka Koskinen
> <ilkka@os.amperecomputing.com> wrote:
> >
> > AmpereOne metrics were missing DefaultMetricgroupName from metrics with
> > "Default" in group name resulting perf to segfault. Add the missing
> > field to address the issue.
> >
> > Fixes: 59faeaf80d02 ("perf vendor events arm64: Fix for AmpereOne metrics")
> > Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
> 
> Sorry, I just stumbled across this and sent a fix too.
> https://lore.kernel.org/lkml/20231204182330.654255-1-irogers@google.com/
> The patches are identical so I'd suggest taking this one and the first
> patch in my changes.
> 
> Reviewed-by: Ian Rogers <irogers@google.com>

Thanks, applied the series.

- Arnaldo
