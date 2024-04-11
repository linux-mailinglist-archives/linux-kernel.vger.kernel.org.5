Return-Path: <linux-kernel+bounces-140300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C2FDC8A126D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 13:02:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 294BEB22868
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 11:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BF1C1474BA;
	Thu, 11 Apr 2024 11:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ITt7keUR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A8D13BACD;
	Thu, 11 Apr 2024 11:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712833327; cv=none; b=WlIkJDkPGs6IO7pqlLbFM7Q7h7Obxjb92l/Fa2ndaZlGaPY6ChfI2Q5cNdDQ87DFb922Z7ZHanhaX6s/4g2ctXfUClD1U+s4BidXIjS1ljBVHglOvTEENEyKZ20SH+NAYFkc8XRzlBkwZGGncIXPySufbJIzKPwhCwffv2oK4m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712833327; c=relaxed/simple;
	bh=ozY6hVvMNrGYH6tlZjxx5umvChurNxXOh6R9cmNMYMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l74tiWocR3Ty9DknRE1g8FcWkVs35tPR3U5vS/dLET1yXOZANmjZiHU+xXOA7Wg84NYrjr0pkXtbxZx85EznEEFqMb2G2EEIi1KMrsC055sJLVz21+zxKTKWFNmZVipOVYNHGkq0GY1N4PCe7ej2aookDUcpHEFMa8KpRPw8doo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ITt7keUR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 901FAC433F1;
	Thu, 11 Apr 2024 11:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712833327;
	bh=ozY6hVvMNrGYH6tlZjxx5umvChurNxXOh6R9cmNMYMU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ITt7keURFX8f4Tuy7WWwTF4VLc77ty5YMzo0qcwpMNZxXYZ+kXUODu6BcijHsQz5V
	 qXz5kVKGawoKATUPjJ/c636nJYjPo8JBWXkNNNpn6krY/Hd3lVbteuHlXohb+TBkG5
	 zv9X8c/l/2hhVTdRyqMB+2Gn/ONG11eAHqNLWjP1IwmATlGuH5yd8wPJNJUoxUT6VO
	 nkWUnSh6cgZPFZyse0orJQ5BSaDxb4hjjKjJcS7w5t/BbvUjwP3pckTc7ilq2lhIAl
	 1N/vP01ibLhrNE8LdBdl+cxMlbF99WNKKQBOw4xaqHyRi5OLUH+ZK5XqW49boL8FRC
	 mJ3R9hwOqlKQA==
Date: Thu, 11 Apr 2024 08:02:04 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCHSET 0/7] perf annotate: Add TUI support for data type
 profiling (v2)
Message-ID: <ZhfDLHH98rgl6_4P@x1>
References: <20240411033256.2099646-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240411033256.2099646-1-namhyung@kernel.org>

On Wed, Apr 10, 2024 at 08:32:49PM -0700, Namhyung Kim wrote:
> Hello,
> 
> This is to support interactive TUI browser for type annotation.
> 
> v2 changes:
>  * fix build errors when libslang2 or libdw is missing  (Arnaldo)
>  * update commit messages with examples  (Arnaldo)
>  * skip updating sample histogram for stack canary  (Arnaldo)
>  * add Reviewed-by from Ian

Thanks, applied.

- Arnaldo
  
> Like the normal (code) annotation, it should be able to display the data type
> annotation.  Now `perf annotate --data-type` will show the result in TUI by
> default if it's enabled.  Also `perf report -s type` can show the same output
> using a menu item.
> 
> It's still in a very early stage and supports the basic functionalities only.
> I'll work on more features like in the normal annotation browser later.
> 
> The code is also available at 'perf/annotate-data-tui-v2' branch at
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git
> 
> Thanks,
> Namhyung
> 
> 
> Namhyung Kim (7):
>   perf annotate-data: Skip sample histogram for stack canary
>   perf annotate: Show progress of sample processing
>   perf annotate-data: Add hist_entry__annotate_data_tty()
>   perf annotate-data: Add hist_entry__annotate_data_tui()
>   perf annotate-data: Support event group display in TUI
>   perf report: Add a menu item to annotate data type in TUI
>   perf report: Do not collect sample histogram unnecessarily
> 
>  tools/perf/builtin-annotate.c          | 149 ++++--------
>  tools/perf/builtin-report.c            |   7 +-
>  tools/perf/ui/browsers/Build           |   1 +
>  tools/perf/ui/browsers/annotate-data.c | 312 +++++++++++++++++++++++++
>  tools/perf/ui/browsers/hists.c         |  31 +++
>  tools/perf/util/annotate-data.c        | 113 +++++++++
>  tools/perf/util/annotate-data.h        |  22 ++
>  tools/perf/util/annotate.c             |  12 +-
>  8 files changed, 534 insertions(+), 113 deletions(-)
>  create mode 100644 tools/perf/ui/browsers/annotate-data.c
> 
> 
> base-commit: 9c3e9af74326978ba6f4432bb038e6c80f4f56fd
> -- 
> 2.44.0.478.gd926399ef9-goog

