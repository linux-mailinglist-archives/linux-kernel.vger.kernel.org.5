Return-Path: <linux-kernel+bounces-139355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3573E8A01CA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 23:12:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 667681C2541D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 21:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CC0A1836D8;
	Wed, 10 Apr 2024 21:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F5q4Ex2y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8FE15AAD6;
	Wed, 10 Apr 2024 21:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712783552; cv=none; b=KoF5zoTrQkHQMjg3ysS5BicVJ/Xil98pzDCFRG1K8O/FAK5ujcrMubU+iDgYUCYCApX+nJZMQhyOxxPUI24gO4bxF7+Y55uYSytMzRdDQ2SIJyrQ6qsx5xsGbIquNawcOybz3Yg4a65P6diADiWM7Q7TY7NEw2gdGgDM2fhTSgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712783552; c=relaxed/simple;
	bh=yXHrm4oNsaREeWD8WzzrWdGYU8kUpgUOMltnXmVE4xc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A1/et5dA8L4Yr2sS4KGN9U69eo5ZHIgwRlJCmNB9PQsMVXwxlwaK2gw1YZqF/6uxEJkZ9IY6qXg3FwNYA0Dm+QDrVUZiiB2CdBr9No3WCanM1rGRvPXaJJ/Go4Rg/BIdLyYqMKJMUOkWdwKlMwarXFEoOnxePDAv2YjEYyMWFpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F5q4Ex2y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9FA1C433C7;
	Wed, 10 Apr 2024 21:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712783552;
	bh=yXHrm4oNsaREeWD8WzzrWdGYU8kUpgUOMltnXmVE4xc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F5q4Ex2yiTcT15xb8oUkn8MGdhGdVeHVlIkb+hKsw36sR45RlkkO5T3uy41AoxG6g
	 cczcy9ZpBgH1D4+7fOblR0qNr7LKpYiZo9WIDEWlHqdzMuMsRmHM3XbOYG56NYvyvO
	 s/vJfOn2Xnm3Epaib+mMwhkhLAfhlV2nm1t/drs3AcAkN0YtD3i+HZgkrQ/x2PUNu9
	 wP0psxHXOphU3UMmmtwb1uZfGKVmePc7mgS+FzMPUK4sDHBhUJvKLXf8QkvizJYdjk
	 g468zSR1uTndXsv6+xCms6V7yBTFm6YhNbJIYo2RB7NV+SKoVj3/brDpr6AmyXDsgV
	 h9/YZVCvawykQ==
Date: Wed, 10 Apr 2024 18:12:29 -0300
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
Message-ID: <ZhcAvddbSEcMXzvH@x1>
References: <20240409235000.1893969-1-namhyung@kernel.org>
 <20240409235000.1893969-4-namhyung@kernel.org>
 <Zhb0raj1yW8JhuFW@x1>
 <Zhb-17CrgZt_PdUH@x1>
 <Zhb_F6hvWrjMcoM1@x1>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zhb_F6hvWrjMcoM1@x1>

On Wed, Apr 10, 2024 at 06:05:27PM -0300, Arnaldo Carvalho de Melo wrote:
> On Wed, Apr 10, 2024 at 06:04:26PM -0300, Arnaldo Carvalho de Melo wrote:
> > On Wed, Apr 10, 2024 at 05:21:01PM -0300, Arnaldo Carvalho de Melo wrote:
> > > On Tue, Apr 09, 2024 at 04:49:57PM -0700, Namhyung Kim wrote:
> > > > Support data type profiling output on TUI.
> > > 
> > > Added the follow to the commit log message, to make reviewing easier.
> > > 
> > > As followup patches I think having the DSO name together with the type
> > > is important, also I think we could have a first menu with all the pairs
> > > of DSO/type, sorted top down by the types with most samples, wdyt?
> > > 
> > > Applied.
> > > 
> > 
> > There is something else here with the static build, checking...
> 
> Probably because of:
> 
> Makefile.config:810: slang not found, disables TUI support. Please install slang-devel, libslang-dev or libslang2-dev
> 
> Fixing...

Trying with:

diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index 6f7104f06c42d98a..458eafe65e4aa16f 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -469,9 +469,11 @@ static void hists__find_annotations(struct hists *hists,
 					goto find_next;
 			}
 
+#ifdef HAVE_SLANG_SUPPORT
 			if (use_browser == 1)
 				key = hist_entry__annotate_data_tui(he, evsel, NULL);
 			else
+#endif
 				key = hist_entry__annotate_data_tty(he, evsel);
 
 			switch (key) {

