Return-Path: <linux-kernel+bounces-109025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA657881388
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 15:42:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81FAD282B94
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 14:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 346DF481BB;
	Wed, 20 Mar 2024 14:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gTIubWms"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7752747F6B;
	Wed, 20 Mar 2024 14:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710945743; cv=none; b=Wtlqv/NjI3VjWbBg8FYPJeTov6Oq0f+6HTuY9pcHVBQC0gu4YPZCKQuvtZT8vcopfCtQ4y4ce0D4i9k4j84b1YLJoPo9UWopJjXZpTO0RhptGRDWG0pP7yMR90FUntqJA2CQ00p1Ib8qI2yjUtbtNPyvg8o3xTbNCLMpmNsMlVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710945743; c=relaxed/simple;
	bh=ovUrCh8ivPKPBF6OH/SCopVigijIup+Lh212CGR0Tes=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H9syWB3lwkKEHrQFmrU3KDEi0914n/jd5vS0VVDCGhEiVDKjKcRJxquWothb3HkD2Ju1cjBO25sc7zlI5znhULUBY9brSFGVZCxCqg0jiwVd7bPCINlwreZpQ6uJFzwDLW0a15SUgRygyhq1/G18v1OMCh8UizLsByTQuH2V92A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gTIubWms; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A31DBC433C7;
	Wed, 20 Mar 2024 14:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710945743;
	bh=ovUrCh8ivPKPBF6OH/SCopVigijIup+Lh212CGR0Tes=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gTIubWms1oa9XTtUMbASdKDkDuJOG3hO/dFuzHc1lwm7xOKQZqmAJ4zMHnUFC2N7B
	 Uqf/SaCJY58qbKHlMNIdIq5BkV1cA1OsoGqkam4KX9YGQUxYere0uqgF7AlwxAvohb
	 3j42WcY4uTtPM4xfM49AEcSG5u2fFz8rirqJL7zHhfnRNZT9CwfC10S703ol+VyyN7
	 po7y1egF1ccmb+vism+STYHXlyn4NtNlqrKkUFeL02O//gQKLaMGIs8IpymRchRZOI
	 LmLjv0CHiyAhyvkmGY2z+ayo1okcCxNQl54WI6mjGOopv7+IVeSJnJuu7gFqz6E1Ur
	 KcGuLIX5dMQEw==
Date: Wed, 20 Mar 2024 11:42:20 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: "Liang, Kan" <kan.liang@linux.intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Yang Jihong <yangjihong1@huawei.com>,
	James Clark <james.clark@arm.com>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/6] Extra verbose/perf-list details
Message-ID: <Zfr1zCn3lxmu2uc2@x1>
References: <20240308001915.4060155-1-irogers@google.com>
 <89249fc5-6102-45d4-9345-5dd80d06e001@linux.intel.com>
 <CAP-5=fWGhZHnsBWo4=+9PdfaAPNEnx7u40G+BHAWR+4rPC2Udw@mail.gmail.com>
 <CAP-5=fXXACwattr9fEcmxoDfGNNi8zmzrDUc8RjUtuX5sV4M9w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fXXACwattr9fEcmxoDfGNNi8zmzrDUc8RjUtuX5sV4M9w@mail.gmail.com>

On Tue, Mar 19, 2024 at 06:01:35PM -0700, Ian Rogers wrote:
> On Fri, Mar 8, 2024 at 8:34 AM Ian Rogers <irogers@google.com> wrote:
> > On Fri, Mar 8, 2024 at 7:39 AM Liang, Kan <kan.liang@linux.intel.com> wrote:
> >> On 2024-03-07 7:19 p.m., Ian Rogers wrote:
> >> > Add more encoding detail and raw event details in perf list. Add PMU
> >> > name and reverse lookup from config to event name to
> >> > perf_event_attr_fprintf. This makes the verbose output easier to read,
> >> > and the perf list information more specific.
> >> >
> >> > v3. Fix to reverse lookup to ensure or aliases are loaded and if
> >> >     getting the config value fails for an event/alias just continue to
> >> >     the next one.
> >> > v2. Address feedback from Kan Liang, "Raw hardware event descriptor"
> >> >     becomes "Raw event descriptor" add assert to keep term numbers in
> >> >     sync, fix a commit message.
> >> >
> >> > Ian Rogers (6):
> >> >   perf list: Add tracepoint encoding to detailed output
> >> >   perf pmu: Drop "default_core" from alias names
> >> >   perf list: Allow wordwrap to wrap on commas
> >> >   perf list: Give more details about raw event encodings
> >> >   perf tools: Use pmus to describe type from attribute
> >> >   perf tools: Add/use PMU reverse lookup from config to name
> >>
> >> The patch series look good to me.
> >> I verified it on a hybrid machine. The new format is the same as the
> >> advertise.
> >>
> >> Tested-by: Kan Liang <kan.liang@linux.intel.com>
> 
> Ping.

Thanks, applied to perf-tools-next,

- Arnaldo

