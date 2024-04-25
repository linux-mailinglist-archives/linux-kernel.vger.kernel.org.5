Return-Path: <linux-kernel+bounces-159029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B01F8B2852
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 20:46:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3A241F22180
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 18:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1109149DFD;
	Thu, 25 Apr 2024 18:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mvt0G6ow"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F85F38394;
	Thu, 25 Apr 2024 18:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714070760; cv=none; b=I4yNN1bSMpzuSdYfArjZUCfWu9tBQSYIxwkXeJNG8YKWhBGPfPyt5AATPRa/xOh7tPyCmR8mA9o3eavHwXIfqFmAVV11LyIgMIXSWlt21TfjCYXDCghyCtrxdYyQR21sP5tBVPTHlxKfamKijXoM5XKpkGlMdhJleTLoJDyZKzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714070760; c=relaxed/simple;
	bh=RFfEfAIbVRyPCqcrDodTEdWTYjr+D1deQhNiDeDKVIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qi0C+WVXV6bslMfwtrEcUaIwYMbBKidWcthfWK1Lump6CwZz2ICjfyz5sGYE8jxo0G2MdCJRYzzvhOYnZUb/H7T6tfITPOfOm7dvaDOnZ4qr+oOHHhb8kp8E4ZL/AfZo4lOsOOr1KTkqmallbtkLdEDDNgWUorE+QKlq6HQIzLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mvt0G6ow; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C872CC113CC;
	Thu, 25 Apr 2024 18:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714070759;
	bh=RFfEfAIbVRyPCqcrDodTEdWTYjr+D1deQhNiDeDKVIQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mvt0G6ow2DNaBop94KCHPZDWXbwKxWPhvis+ivoKnyh5ua6ROYWGBrJhVQc7R1ZnH
	 RAImd/kkY1H+c9ypzWY2A3jm9RHjOdkUrP09zrrGKj1TKRHO70+5SJeSAr2WJxIkJf
	 mYetdXiOoej1Gvr5yF+BeXyZ4kubtAEUNLcF3XyRXcTkg4TMpbfgieIaUAw/h7bT8X
	 lJOTKT7h9EDhrmI7LR3/N8FUhC9fHNSuAm7FZIjUNBkaXrhYXjwdWiuVMQDQ2FCyj4
	 caj5gRNNuWOVV/gWpAhkY8gP1oouJ0VzPW/HALrsle89eB8TxhPrlgJ1dbykiPK8df
	 SlS3QSK/+niLA==
Date: Thu, 25 Apr 2024 15:45:53 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] perf build: Pretend scandirat is missing with msan
Message-ID: <Ziqk4a1ApUKHq_bC@x1>
References: <20240320163244.1287780-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240320163244.1287780-1-irogers@google.com>

On Wed, Mar 20, 2024 at 09:32:44AM -0700, Ian Rogers wrote:
> Memory sanitizer lacks an interceptor for scandirat, reporting all
> memory it allocates as uninitialized. Memory sanitizer has a scandir
> interceptor so use the fallback function in this case. This allows
> perf test to run under memory sanitizer.

Thanks, applied to perf-tools-next,

- Arnaldo
 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/Makefile.config | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index 1fe8df97fe88..74e0b17050b5 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -486,7 +486,10 @@ ifdef NO_DWARF
>  endif
>  
>  ifeq ($(feature-scandirat), 1)
> -  CFLAGS += -DHAVE_SCANDIRAT_SUPPORT
> +  # Ignore having scandirat with memory sanitizer that lacks an interceptor.
> +  ifeq ($(filter s% -fsanitize=memory%,$(EXTRA_CFLAGS),),)
> +    CFLAGS += -DHAVE_SCANDIRAT_SUPPORT
> +  endif
>  endif
>  
>  ifeq ($(feature-sched_getcpu), 1)
> -- 
> 2.44.0.291.gc1ea87d7ee-goog

