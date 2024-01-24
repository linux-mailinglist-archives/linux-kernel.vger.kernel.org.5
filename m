Return-Path: <linux-kernel+bounces-36642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D30683A443
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 09:39:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B6CD1C2368B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 08:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E0AF17980;
	Wed, 24 Jan 2024 08:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="asnp5vqX"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD0C1774E;
	Wed, 24 Jan 2024 08:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706085544; cv=none; b=WvXeGfV4qlkAgGPiyv+2XhTuabIIgiVUSOSUPWZACdHl8R6kChGIyXEihn4JUs0On1lySCVexP1MI2yK9yCi8YwfAeJ3lV4zW3ZvoUPBbR3yS7JvP4ZFOwJbZl2UEe5CKM9h7nU3ML3NpSC9eCSw2pdNHvCUgFjjE+7rth8hmVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706085544; c=relaxed/simple;
	bh=ehSk/KOw6EwCI/rQd4tsmYaL42+ZGGoyWxxF44nf3mU=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EuJyLLhSOts6bKQI91vhs8oltseDIvvGxUi6hIBJvp7iWRx5HwpJ/DTU8IPm1op/ouLP2l/lGq3NDgP4Iua995uj2XKvT3QjknmIztNAj1kDTdOOMfh6Hpu3L+z0fK6jjiGgZDY7MeGdrmFiwuN2iVwsvvqwHkNIAG+Jn3tW/Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=asnp5vqX; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40eacb6067dso35858905e9.1;
        Wed, 24 Jan 2024 00:39:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706085541; x=1706690341; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZgawM6UIZB879asIllB4qg34rmAKLHEiPy/nkyJy3IA=;
        b=asnp5vqXcqqFfTSGyyTeaiaHgoLFhQ3nwWqwvfkCh+0QrMFZkv4FszeF/qL1tkwpcq
         8pwWdx6EP0l85N2RvEV5wSS3O8KnHVnsegecSwIhcPZ9tfgYLb8po70nXQAWFBHh4lfa
         fr3Qm/zOlJAQYidCvijUwisJNr7SjHPfWLjcbVXIJCCwT0zfr1rUQprJ+pNJjFvkNd/F
         n+HJuu0mVlNvNkst6MfCb4PmcIsslJl63VZwntRPG6480NgZBd0LNdekNNhSA+6u5+uk
         PRfY70mN0FoZn3yRfdlRqRidbLKIDUGhiyX3aYbr5j6fQenu+d9aVdp+zlVbEdf/NnHV
         xHAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706085541; x=1706690341;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZgawM6UIZB879asIllB4qg34rmAKLHEiPy/nkyJy3IA=;
        b=MgDFkKyHttaFTy9WnAcSJOHvFMfJjwZwMVhhkmIGnp/pChrSpX8441efo09GLRwrMP
         VW6aEmSj3nVO9wLhmIwaHrILbEJ+zrVlOKPAH2RubhUGj/gqlfyO5CqMnKh2wZpZp/zO
         FQExbSsCSmZgB2pS6WMCpwmt19YGt5sM/b7TucE4KkwYgdl+TicLL750Hd7c2I/nK1gA
         ivvKyHcMXudf6r90o+wfyeHJmJH1MRhiH60BMMRQrAGq2b0S/P8vl01ukh18+bMykA78
         fmDzrDS4zg78AKvC/xuGiLlEwcLYqoHgE9EVzyw9DyrGOi0oSttxgHoS16ZfVlCl7JHl
         oLdg==
X-Gm-Message-State: AOJu0Yz7wlX4TgrrC47gbBls8CLwBQ6L/1GcQSN5NA9/pUiD4VnevXPD
	UlpAJEseTteKFSIiIK5R8AHJeRGhAyHN28AWwkdaLMCqCy8Rd+ex
X-Google-Smtp-Source: AGHT+IEicp6kAZUWVsNFA2XQ0bSqFDDu68KUb3xWtsxsMyBwWLImjacQfs3cRCWXO6Vw/pr6lq5Tsg==
X-Received: by 2002:a05:600c:56d3:b0:40d:8fcd:31aa with SMTP id ju19-20020a05600c56d300b0040d8fcd31aamr728892wmb.327.1706085541182;
        Wed, 24 Jan 2024 00:39:01 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id n21-20020a05600c3b9500b0040eaebc4e8fsm8646371wms.1.2024.01.24.00.39.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 00:39:00 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 24 Jan 2024 09:38:58 +0100
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Ross Zwisler <zwisler@chromium.org>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Shirisha G <shirisha@linux.ibm.com>,
	Kajol Jain <kjain@linux.ibm.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/5] perf test: Make daemon signal test less racy
Message-ID: <ZbDMovjeAZBUSiMn@krava>
References: <20240124043015.1388867-1-irogers@google.com>
 <20240124043015.1388867-6-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240124043015.1388867-6-irogers@google.com>

On Tue, Jan 23, 2024 at 08:30:15PM -0800, Ian Rogers wrote:
> The daemon signal test sends signals and then expects files to be
> written. It was observed on an Intel Alderlake that the signals were
> sent too quickly leading to the 3 expected files not appearing. To
> avoid this send the next signal only after the expected previous file
> has appeared. To avoid an infinite loop the number of retries is
> limited.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> Acked-by: Namhyung Kim <namhyung@kernel.org>

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka

> ---
>  tools/perf/tests/shell/daemon.sh | 34 ++++++++++++++++++++++----------
>  1 file changed, 24 insertions(+), 10 deletions(-)
> 
> diff --git a/tools/perf/tests/shell/daemon.sh b/tools/perf/tests/shell/daemon.sh
> index 4c598cfc5afa..e5fa8d6f9eb1 100755
> --- a/tools/perf/tests/shell/daemon.sh
> +++ b/tools/perf/tests/shell/daemon.sh
> @@ -414,16 +414,30 @@ EOF
>  	# start daemon
>  	daemon_start ${config} test
>  
> -	# send 2 signals
> -	perf daemon signal --config ${config} --session test
> -	perf daemon signal --config ${config}
> -
> -	# stop daemon
> -	daemon_exit ${config}
> -
> -	# count is 2 perf.data for signals and 1 for perf record finished
> -	count=`ls ${base}/session-test/*perf.data* | wc -l`
> -	if [ ${count} -ne 3 ]; then
> +        # send 2 signals then exit. Do this in a loop watching the number of
> +        # files to avoid races. If the loop retries more than 600 times then
> +        # give up.
> +	local retries=0
> +	local signals=0
> +	local success=0
> +	while [ ${retries} -lt 600 ] && [ ${success} -eq 0 ]; do
> +		local files
> +		files=`ls ${base}/session-test/*perf.data* 2> /dev/null | wc -l`
> +		if [ ${signals} -eq 0 ]; then
> +			perf daemon signal --config ${config} --session test
> +			signals=1
> +		elif [ ${signals} -eq 1 ] && [ $files -ge 1 ]; then
> +			perf daemon signal --config ${config}
> +			signals=2
> +		elif [ ${signals} -eq 2 ] && [ $files -ge 2 ]; then
> +			daemon_exit ${config}
> +			signals=3
> +		elif [ ${signals} -eq 3 ] && [ $files -ge 3 ]; then
> +			success=1
> +		fi
> +		retries=$((${retries} +1))
> +	done
> +	if [ ${success} -eq 0 ]; then
>  		error=1
>  		echo "FAILED: perf data no generated"
>  	fi
> -- 
> 2.43.0.429.g432eaa2c6b-goog
> 

