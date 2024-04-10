Return-Path: <linux-kernel+bounces-139360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB4BA8A01DA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 23:20:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 432271F24E42
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 21:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 580281836DB;
	Wed, 10 Apr 2024 21:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VlJbvzav"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975A217BB2F;
	Wed, 10 Apr 2024 21:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712784006; cv=none; b=i8ja+KTdmWcO1ksObBrryfD5G5cRGPj2viXrRLkbJzdRqMwxfxVfCHcZxRdh+QgNpAk/hIOZ/8DA9EsMgCUlTHeexQN3QoPz3zgY3KAI7jOA3WdL6+1ww/GGRfC+hz6JsshJFEuSD5VvlqeM8cbT1SktrPcMcPv5CZOQZMQXOdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712784006; c=relaxed/simple;
	bh=v2Cz9Wk8jw/ZYczMkd/oKHigr2oF7K9PTYeW1J3b/jY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I+hleuZjJoyY3p+qzi5bhjJWf+/t5h+b2xw54cu1KNcJ+T7K+dQS2xs/UHwCw3GdEy4irEMmKDOM0PCM9Kax102/iXi5/O6ilHrq24xqnMplWsBcKx3gsp965NGkz4R6OPWY16RtjHBTv6NNcE3KLw1GbEePjw0NT79rIQ1E564=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VlJbvzav; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6197C433C7;
	Wed, 10 Apr 2024 21:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712784006;
	bh=v2Cz9Wk8jw/ZYczMkd/oKHigr2oF7K9PTYeW1J3b/jY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VlJbvzavJPCW6x09jTi5JLrekSJAB2AgHwndhmpDeyRRtrkTf958Ok21v3eBtuEV8
	 LaO/HC4mIgSPoqX2r8VxQHOQQoQdxafk027FKaZmMgu1qbnES1eiPjYEd26vRpLye+
	 GE/XN12SqHKFhua4G10ASXhQkR122OljOgICyvLKu+MEIa0F147A49+B+pUGhk8bwv
	 P6jG9gQipM4vhld0eKrPf/03Q5BXQm/TaxVBO0t1preNqd6kljQDsaeYl+Zj8ASRLO
	 d0OsaTGn4LWkQMbqemlUTf23AUS9f26xHT1ZZZ8+6W0Rf6Zs+e3gtr/toYFGI5K+V2
	 EN4vB5mGJuHcg==
Date: Wed, 10 Apr 2024 18:20:03 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 3/6] perf annotate-data: Add
 hist_entry__annotate_data_tui()
Message-ID: <ZhcCgzslBmDK4-vn@x1>
References: <20240409235000.1893969-1-namhyung@kernel.org>
 <20240409235000.1893969-4-namhyung@kernel.org>
 <Zhb0raj1yW8JhuFW@x1>
 <Zhb-17CrgZt_PdUH@x1>
 <Zhb_F6hvWrjMcoM1@x1>
 <ZhcAvddbSEcMXzvH@x1>
 <ZhcB2Vh6lAcqPasI@x1>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZhcB2Vh6lAcqPasI@x1>

On Wed, Apr 10, 2024 at 06:17:16PM -0300, Arnaldo Carvalho de Melo wrote:
> On Wed, Apr 10, 2024 at 06:12:32PM -0300, Arnaldo Carvalho de Melo wrote:
> > On Wed, Apr 10, 2024 at 06:05:27PM -0300, Arnaldo Carvalho de Melo wrote:
> > > On Wed, Apr 10, 2024 at 06:04:26PM -0300, Arnaldo Carvalho de Melo wrote:
> > > > On Wed, Apr 10, 2024 at 05:21:01PM -0300, Arnaldo Carvalho de Melo wrote:
> > > > > On Tue, Apr 09, 2024 at 04:49:57PM -0700, Namhyung Kim wrote:
> > > > > > Support data type profiling output on TUI.
> > > > > 
> > > > > Added the follow to the commit log message, to make reviewing easier.
> > > > > 
> > > > > As followup patches I think having the DSO name together with the type
> > > > > is important, also I think we could have a first menu with all the pairs
> > > > > of DSO/type, sorted top down by the types with most samples, wdyt?
> > > > > 
> > > > > Applied.
> > > > > 
> > > > 
> > > > There is something else here with the static build, checking...
> > > 
> > > Probably because of:
> > > 
> > > Makefile.config:810: slang not found, disables TUI support. Please install slang-devel, libslang-dev or libslang2-dev
> > > 
> > > Fixing...
> > 
> > Trying with:
> 
> Not really, I need to check for HAVE_DWARF_SUPPORT as well? Doing that

Attempting with:

⬢[acme@toolbox perf-tools-next]$ git diff
diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index 458eafe65e4aa16f..521ec7e226e29e6b 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -469,7 +469,7 @@ static void hists__find_annotations(struct hists *hists,
                                        goto find_next;
                        }
 
-#ifdef HAVE_SLANG_SUPPORT
+#if defined(HAVE_SLANG_SUPPORT) && defined(HAVE_DWARF_SUPPORT)
                        if (use_browser == 1)
                                key = hist_entry__annotate_data_tui(he, evsel, NULL);
                        else
⬢[acme@toolbox perf-tools-next]$

