Return-Path: <linux-kernel+bounces-15767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0CC382317A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 17:48:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFE3D1C23ADC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 16:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DDCE1C280;
	Wed,  3 Jan 2024 16:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bUK7oC2f"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B4F1BDDD;
	Wed,  3 Jan 2024 16:47:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04CC2C433C8;
	Wed,  3 Jan 2024 16:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704300476;
	bh=g0nBuXXj57nubgtYR0YmrNxPgO3LEIFTUI56xOZHs5w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bUK7oC2fzZg5egB/2IYhH45yOvK2l4dYVSEol6A2mrfyfTJEEoQtvWQfUQRwCjmrW
	 o6cwSgoqq9oV0Z1f8kKINMj1Wa/Ui35IztvltF5iHpvObTg3z+7UUThKSFZRb37jiv
	 UCSlyQpp4JykD2zvJUm9kzzQWXOp7NR1/WMthSJu2hH9roqSe2cSDUyGh2QU/oxRef
	 dqlLF6OdaOHXpjx3nweOQT9ZTKsZv9E0F1riq/O1qURpL3pI/xqPnod0QsALeFFkPg
	 7vGi3CFIPVdPCT/6p1BEN1SZN0yG+BgPyg/9qRE+O9+8oTgKwR+VcdS2wdhMjOdrqU
	 oZ8xtGx3+CsIw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id DDB3D403EF; Wed,  3 Jan 2024 13:47:52 -0300 (-03)
Date: Wed, 3 Jan 2024 13:47:52 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	John Garry <john.g.garry@oracle.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Guillaume Endignoux <guillaumee@google.com>
Subject: Re: [PATCH v1] perf stat: Fix hard coded ll miss units
Message-ID: <ZZWPuIjp0xklrcGy@kernel.org>
References: <20231211181242.1721059-1-irogers@google.com>
 <CAP-5=fVWZ7etZq7YBU1HGMnyJ6wsZ3zok9JuS7eWQsTKuqzrAA@mail.gmail.com>
 <cbc91c86-e6ea-4a97-8b61-5594d3cdbc81@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cbc91c86-e6ea-4a97-8b61-5594d3cdbc81@linux.intel.com>
X-Url: http://acmel.wordpress.com

Em Tue, Jan 02, 2024 at 03:01:55PM -0500, Liang, Kan escreveu:
> 
> 
> On 2024-01-02 2:34 p.m., Ian Rogers wrote:
> > On Mon, Dec 11, 2023 at 10:13 AM Ian Rogers <irogers@google.com> wrote:
> >>
> >> Copy-paste error where LL cache misses are reported as l1i.
> >>
> >> Suggested-by: Guillaume Endignoux <guillaumee@google.com>
> >> Fixes: 0a57b910807a ("perf stat: Use counts rather than saved_value")
> >> Signed-off-by: Ian Rogers <irogers@google.com>
> >
> 
> Reviewed-by: Kan Liang <kan.liang@linux.intel.com>

Thanks, applied to perf-tools-next.

- Arnaldo

 
> Thanks,
> Kan
> 
> > Ping. Trivial 1 character fix but no reviews :-(
> > 
> > Thanks,
> > Ian
> > 
> >> ---
> >>  tools/perf/util/stat-shadow.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
> >> index 1c5c3eeba4cf..e31426167852 100644
> >> --- a/tools/perf/util/stat-shadow.c
> >> +++ b/tools/perf/util/stat-shadow.c
> >> @@ -264,7 +264,7 @@ static void print_ll_miss(struct perf_stat_config *config,
> >>         static const double color_ratios[3] = {20.0, 10.0, 5.0};
> >>
> >>         print_ratio(config, evsel, aggr_idx, misses, out, STAT_LL_CACHE, color_ratios,
> >> -                   "of all L1-icache accesses");
> >> +                   "of all LL-cache accesses");
> >>  }
> >>
> >>  static void print_dtlb_miss(struct perf_stat_config *config,
> >> --
> >> 2.43.0.472.g3155946c3a-goog
> >>
> > 

-- 

- Arnaldo

