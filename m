Return-Path: <linux-kernel+bounces-147548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CD1A8A7614
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 23:07:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 766A31C21C81
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 21:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78A5D5A109;
	Tue, 16 Apr 2024 21:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CzeoyLLt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B585858203;
	Tue, 16 Apr 2024 21:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713301620; cv=none; b=mIaGEOlqNErgGoBtD+cTnzWZGCnMMaE8DuCBX3kr5PzSVNB1dteEYz3snQRPd7S+M+Rkl4nhx+J6NZu2WxVJI2vk0Sb2uDFfJR3bE2Xovj6a50HBdKLPmKomRThMBOHvGjmP7rvafHdpdVSW71Vtn1WYpZmY9E8+XhxGl+4UoqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713301620; c=relaxed/simple;
	bh=ONCP2bFIWRJWPrrlD6FPRHnVB+6rMtOOD9g0rxMYLS4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cM49sC14nunId/6mYG/U2h1gdv4/RMTAW/U7eoQFqIyHn2BKvKuuLSFsvJpK7LdI/Ry3aZ4+nmpZpVm+jXGbtjehXqwTyh09hL/Whc1fSpVkYZAhWMyme+Ti9pQYNba/HrChqS8afJRto3tPdmW5jvsliBJ16Ah7VqwXXkzCslk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CzeoyLLt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0504C113CE;
	Tue, 16 Apr 2024 21:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713301620;
	bh=ONCP2bFIWRJWPrrlD6FPRHnVB+6rMtOOD9g0rxMYLS4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CzeoyLLtjCH92fzH6b6xsKhQn+a0mPTSDmNEcptI0C0Dk3OEejkBSBPyUydBKh3Lw
	 lBRI+0h5X8W0LWggaf7931KHvSIXyzSsZe+x7p/KjF8Kb8bp2fknRjUfmzaisoMSBb
	 jwf+DWNHwpQX2mNcw8KdTwtJU0n7SRRU4kOLknkgVROhi/PUcNlgRzFlgvq+Qyzgo2
	 wCCEFSLq0RrVP5NbtXP6q3mncAKu+gxZmAS/e3Ed3SwDa7DbYwDa48yAKnM1Kg8ajT
	 2wo6G3yHfuDTJi2dwBlgqVWMitw5iQAhvE+yPzgSLYf40kl8qmY8Z3SGh/uIrVZrdC
	 i2cu5EGHWmxbA==
Date: Tue, 16 Apr 2024 18:06:56 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 0/4] perf annotate-data: A couple of small updates
Message-ID: <Zh7ocMW0t4EMNZlO@x1>
References: <20240412183310.2518474-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240412183310.2518474-1-namhyung@kernel.org>

On Fri, Apr 12, 2024 at 11:33:06AM -0700, Namhyung Kim wrote:
> Hello,
> 
> I am working on improving quality of the data type profiling and I
> found some issues.  One is when more than one variables are placed at
> the same location.  Then it should find the correct one based on the
> given info rather than checking the first one and bailing out.  This
> one (patch 2) can go to the perf-tools tree.
> 
> Another issue is use of the stack pointe register when it's not the
> frame base register.  I found a case where rbp is used as the frame
> base but rsp is also used to point some stack variables.  And it
> confuses itself how to interpret the type of the variable.
> 
> I think these are rare cases but it would depends on the code pattern
> and compiler behavior.  Anyway I can see a tiny improvement in my data

Thanks, applied to perf-tools-next,

- Arnaldo
> with this change. :)
 
> Thanks,
> Namhyung
> 
> 
> Namhyung Kim (4):
>   perf annotate-data: Improve debug message with location info
>   perf dwarf-aux: Check pointer offset when checking variables
>   perf dwarf-aux: Check variable address range properly
>   perf annotate-data: Handle RSP if it's not the FB register
> 
>  tools/perf/util/annotate-data.c | 126 +++++++++++++++++++++++++-------
>  tools/perf/util/dwarf-aux.c     |  35 ++++++---
>  2 files changed, 125 insertions(+), 36 deletions(-)
> 
> 
> base-commit: 0ffc8fca5c15a70f32c8aff12c566bbd3991bd0a
> -- 
> 2.44.0.683.g7961c838ac-goog

