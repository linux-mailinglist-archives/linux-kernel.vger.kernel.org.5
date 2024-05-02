Return-Path: <linux-kernel+bounces-166551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C9E8B9C39
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 16:25:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 774E71F21364
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 14:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24E3613C80D;
	Thu,  2 May 2024 14:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dAzJalcK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67DC4152788;
	Thu,  2 May 2024 14:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714659943; cv=none; b=oDp9MMl5pYqqlkxaXM4809a96sslEckD5/tSokn3GOmiSRfVIXb7NecPBIYlU0OSQwRqfdEj5Uxd6uc+a5iTV4yAR/GmvqGLfHFDwzDnznukxWElb2Mykm71LuqTN8Au88AjQdjZxOfTLa0I/QmStlS+FNgD+4Ko0rpbSoPcyeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714659943; c=relaxed/simple;
	bh=oiao4TXlXK5TsFP1Fh+N2TWYYYhrR0A4blK5ja4oXvk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TqqeLERteZL5AqXYL1DihDlA56+3aX/nnX5eMG8wzNYTKXvr9cXEvxL6HXHqysmHJeVp0tjWJqNlTZ/CQRKaSQxPcS7cI2DpfdO34OSEtEfkZk0MaSudmtpbOlsqP3xSfu4tR1jswNcpPGFdZXRRGamLmiU5xAQPgEagzr6y9iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dAzJalcK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0328C113CC;
	Thu,  2 May 2024 14:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714659942;
	bh=oiao4TXlXK5TsFP1Fh+N2TWYYYhrR0A4blK5ja4oXvk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dAzJalcKX4diwfIOgGoLZvmrhpPg0IYEPC0w/F+BK6OHlU2xuKBZqICiytS/PgQaX
	 UmIjttq9jGIBz6gmTZvawJNepUOFJZ17+y0NnBtY4t8NvDaDV9MxQnsJIfDdfsBXjo
	 X4GqzZMDd1iOQ8dP8kOi1K/s00Va4mSurxUjHkZ70WdAFRHBIHHC7H75p1N1vzwfin
	 4TPfyRfbRYB8QoG1eclrKybT3XkzX/9m7Brc2Z+lkUUte0PgIpxqq16VjnjY++YiFs
	 dJogNYqj2dPInoMbtmon+ivHmao9sByS9CrOAsKihIMzbt4eb1IcavbH8nTv90/hmM
	 3JLC4AgclnWBw==
Date: Thu, 2 May 2024 11:25:38 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCHSET 0/6] perf annotate-data: Small updates in the data
 type profiling (v1)
Message-ID: <ZjOiYjxrdxnw5CuM@x1>
References: <20240502060011.1838090-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240502060011.1838090-1-namhyung@kernel.org>

On Wed, May 01, 2024 at 11:00:05PM -0700, Namhyung Kim wrote:
> Hello,
> 
> This is a mix of bug fixes and optimization in the data type profiling.
> 
> Firstly it now caches global variables and looks them up by address later.
> This will be good for performance as well as improves the success rates
> because some variables are defined in a separate file (compile unit) and
> has no info in the call site for some reason.
> 
> Also it properly checks instructions that use more than one register for
> a memory access like x86 SIB addressing.  And check the type of stack
> variables correctly and discard constant values (without type info).

Applied locally, doing build tests.

- Arnaldo

