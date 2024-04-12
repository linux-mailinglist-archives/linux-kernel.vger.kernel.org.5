Return-Path: <linux-kernel+bounces-143263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26E3B8A366A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 21:35:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9E3B1F24EFB
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 19:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8C6C150981;
	Fri, 12 Apr 2024 19:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cpwJTI4i"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 138E584DE1;
	Fri, 12 Apr 2024 19:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712950532; cv=none; b=HtCUgvpQQdSvtX80Cc908yHAo6V5v2uTyetE0GzVCOEzkQtSJTJH/VdSLCrL5PH5W4BHF1oM2bTdU+N7QqEf9MbnWfEfFxdBSQoTjFwpGIeDAsCc+Xzu/SEyfSV3FAObVUu2ml4+ltydjf378VNoVqVBSw+CmFqxCrniMKeTNFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712950532; c=relaxed/simple;
	bh=ofVVy4zferD+RNPrdaRnvyrBwq7zff5WYyjwpk4ktSY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PuukcwaS7oqp2wn9mIdhSBxQA7XtIq/y+HUr4lG+/6UNrF8z56DE3jkb/is6AhEDbgRsag0V2PBPjuxAUmXI7HIGrTW7lS6YaKjgZaLDMSm5XjtOg1DuLU+F0tlgrfKSt+w8NDqU10+hbuIkQ/KDoNhRjXZmUp2/c0jS8uf1Kl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cpwJTI4i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15CC7C113CC;
	Fri, 12 Apr 2024 19:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712950531;
	bh=ofVVy4zferD+RNPrdaRnvyrBwq7zff5WYyjwpk4ktSY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cpwJTI4itTVfMiJUAOaybYNjldBMEvIp9h9tBGn60Kgn9Loqjmt4XdA5pgDeSlzpr
	 UGcd2U1xM+oSLRjKs71liI3qDqECEGzQUwzYZQwMWx4y3zRPvuSBFAjB2QV8mSK21g
	 HUrvb/GII4suEGh113rDQ2KxVXlv07Sa4QllDSSbwCmC+0pgBSnYwd7xejC5rNBqvO
	 6K3EXjyk/9Gh0sFert6VdVwGrqNCsGWBN2Y1qT26TLsZvbB2xvZC8Xx9CbrZeLfjfs
	 JXpeCmDsZtzp71VYw/dqSenJUY+UMKZ2AMv8Thi74mvCIETUmnvuUj6IrUQiU6cPhk
	 /lGx3S6BuF7tA==
Date: Fri, 12 Apr 2024 16:35:28 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] perf list: Esacpe \r in json output
Message-ID: <ZhmNAOqa6dGIQ2y4@x1>
References: <20240410222353.1722840-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240410222353.1722840-1-irogers@google.com>

On Wed, Apr 10, 2024 at 03:23:53PM -0700, Ian Rogers wrote:
> Events like for sapphirerapids have \r in the uncore descriptions. The
> non-escaped versions of this fail json validation the the perf list
> test.

Thanks, applied to perf-tools-next,

- Arnaldo
 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/builtin-list.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/tools/perf/builtin-list.c b/tools/perf/builtin-list.c
> index 02bf608d585e..9333cc64c2ce 100644
> --- a/tools/perf/builtin-list.c
> +++ b/tools/perf/builtin-list.c
> @@ -313,6 +313,9 @@ static void fix_escape_fprintf(FILE *fp, struct strbuf *buf, const char *fmt, ..
>  					case '\n':
>  						strbuf_addstr(buf, "\\n");
>  						break;
> +					case '\r':
> +						strbuf_addstr(buf, "\\r");
> +						break;
>  					case '\\':
>  						fallthrough;
>  					case '\"':
> -- 
> 2.44.0.478.gd926399ef9-goog

