Return-Path: <linux-kernel+bounces-135491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B343489C6A2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 16:15:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E650C1C21BC4
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 14:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 137D085939;
	Mon,  8 Apr 2024 14:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="agSuONB/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556128564E;
	Mon,  8 Apr 2024 14:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712585738; cv=none; b=aR/qyWSZfb2AWsPnnZn8NWs2crlV7jOyt61LVLq+LLNhrB1cgO3CwFYYBe6svYbkz4/+IovoHqGJafXbLqJsEK7wdpuEw3hCpCm4ohxy570kCrkD/i+9+QJ/zeThCMbzUO+fp1OnRVf9fEeDS+S+vM++xxfUvEcagWgocVtnI34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712585738; c=relaxed/simple;
	bh=uGAyf8hbUzFZhn6hO+6/TbFvwKdd+ftBukqq+4D8pHY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pAENubTFajeuNniX+qZRiNisbbeKqQ91BcPc3I9DMZphulNBVnf1JhI0yvb6BRXLgxdiN72OckzTP3AhKTtdYe/t4FReZwretgF91KT1++PxlYSqYS/Cu+6tt4CED/Ir6PSNF1VqTeGFBBa28CcclyQdTFEdpTpKxbg50xIBNJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=agSuONB/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EE48C433F1;
	Mon,  8 Apr 2024 14:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712585738;
	bh=uGAyf8hbUzFZhn6hO+6/TbFvwKdd+ftBukqq+4D8pHY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=agSuONB/gh4uhRRAvIAMCWT5aX0LpJfs7T7ty2R92xMfaMzyEHDq6Z7uPUOGMweOv
	 xL+t/Gds9o+MDffDujhKtft/1wftFS5tf9FAriGJXHWyVXMckgSIUD1r2ruZ5/RfLj
	 daD/VigkmJmPvtwsF2SvRVgpKy4hdFOADWBG4rcoJcB97qT6mhHTDUWz3kDeT1lsDP
	 uEWq6PwJ7xi/CZlp/j/SD3X6Z1B/9Edz+aLiCCN7ZUsoe1OA/kmHRLCHZrU4JuwUpy
	 fIiI0HstYvm+RlwvSKPdYNSLU2g0Uhjb9aqGfJ7tSB/nN32bH/hA3tvB+pGBKLI7Fx
	 GXy1AxdpaTBjA==
Date: Mon, 8 Apr 2024 11:15:34 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 0/4] perf annotate-data: small random fixes and updates
Message-ID: <ZhP8BgVBDrl-HgEb@x1>
References: <20240405211800.1412920-1-namhyung@kernel.org>
 <CAP-5=fUhngjbL3Q7a3EuBSGdDKg8PFjRzpe5yHTDdeLmz4oWDg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fUhngjbL3Q7a3EuBSGdDKg8PFjRzpe5yHTDdeLmz4oWDg@mail.gmail.com>

On Fri, Apr 05, 2024 at 05:02:20PM -0700, Ian Rogers wrote:
> On Fri, Apr 5, 2024 at 2:18 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > I found some problems in the data type profiling with perf annotate.
> > The patch 1 should go to perf-tools and others can go to perf-tools-next.

> > Namhyung Kim (4):
> >   perf annotate: Make sure to call symbol__annotate2() in TUI
> >   perf annotate-data: Fix global variable lookup
> >   perf annotate-data: Do not delete non-asm lines
> >   perf annotate: Get rid of symbol__ensure_annotate()
> 
> Reviewed-by: Ian Rogers <irogers@google.com>

Applied 2-4 to perf-tools-next,

Thanks,

- Arnaldo

