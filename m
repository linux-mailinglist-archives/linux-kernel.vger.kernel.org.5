Return-Path: <linux-kernel+bounces-35447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 38DAA839152
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 15:26:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BD931C25AF5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 14:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D53835FB84;
	Tue, 23 Jan 2024 14:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c0AWBGIU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287475FB83;
	Tue, 23 Jan 2024 14:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706019995; cv=none; b=VqBB15dNWo3t59ooYBf6GOrUquIg9gCA2nAiScJ3tAfUst0Zbs9fuyTPWf+jEjvWe6t3IPq2OMvEnn4uJsNVbmWBnI+wGKJGFL40PZ5n0n/NSuyh1sotKKrXNffIwjTpZwrDEJH0LcA4J+k7Tz9Y59SAPMvRv7hIRa+B6vTomjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706019995; c=relaxed/simple;
	bh=VRlTjRTI+L91zd4xjs7D4JUxQ+n7wnWPiRsap+VWKj8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Fva4ZGDgWrRR/m4vTDlYXHfKlClVhBlDyNWkXnEA8BHh1hULwiDv/okPVrdwkPtGuDU4GKnX5HT2EewLwcyZR/E58To85toFl3ojcPicLzFTkhJr0LgIZK7+EPngsxjykyPdsFcvzTJXahnC8KXKV+9xWkQODXr0NVlpOyT5Qac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c0AWBGIU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63EA6C433C7;
	Tue, 23 Jan 2024 14:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706019994;
	bh=VRlTjRTI+L91zd4xjs7D4JUxQ+n7wnWPiRsap+VWKj8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=c0AWBGIUg3WKPW1gvLqfLK3MxWnrIfsYR7bfF++W6TA3mzeMhbNXs/qXx6swrbDNs
	 SMEWW/ytlBhpCu1nH/zdOX2C6ke+RKk73j7tVj3dbDtVymamYeWDjd16yG0n86F1WI
	 lQGiEkQVJ/k8tjnPwmtrSR1gHjSKGW2VhfdVmhSxQ/sedSwwrFdAxmmNKXJT4J0dl4
	 oKT/jDxUcNfVCZPAms/9agAK+4iPOW0yUbYyu6CGPjrtGX2EmqRidWyNSCV13ulse8
	 BTqzmrA/UAVAspLhfLiucD66wCM0iPeJ4m9daicz+nbY/J4DOE9j9SzsZ3Iucl4jai
	 MVgM+6w2xyjkg==
Date: Tue, 23 Jan 2024 23:26:29 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Ye Bin <yebin10@huawei.com>
Cc: <rostedt@goodmis.org>, <mathieu.desnoyers@efficios.com>,
 <linux-trace-kernel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 2/7] tracing/probes: add
 traceprobe_expand_dentry_args() helper
Message-Id: <20240123232629.ddac164019a6bab84b223d96@kernel.org>
In-Reply-To: <20240123092139.3698375-3-yebin10@huawei.com>
References: <20240123092139.3698375-1-yebin10@huawei.com>
	<20240123092139.3698375-3-yebin10@huawei.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Ye,

On Tue, 23 Jan 2024 17:21:34 +0800
Ye Bin <yebin10@huawei.com> wrote:

> Add traceprobe_expand_dentry_args() to expand dentry args. this API is
> prepare to support "%pd" print format for kprobe.
> 
> Signed-off-by: Ye Bin <yebin10@huawei.com>
> ---
>  kernel/trace/trace_probe.c | 36 ++++++++++++++++++++++++++++++++++++
>  kernel/trace/trace_probe.h |  2 ++
>  2 files changed, 38 insertions(+)
> 
> diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
> index 4dc74d73fc1d..cc8bd7ea5341 100644
> --- a/kernel/trace/trace_probe.c
> +++ b/kernel/trace/trace_probe.c
> @@ -1565,6 +1565,42 @@ const char **traceprobe_expand_meta_args(int argc, const char *argv[],
>  	return ERR_PTR(ret);
>  }
>  
> +int traceprobe_expand_dentry_args(int argc, const char *argv[], char *buf,
> +				  int bufsize)
> +{
> +	int i, used, ret;
> +
> +	used = 0;
> +	for (i = 0; i < argc; i++) {
> +		size_t idx;
> +
> +		if (str_has_suffix(argv[i], ":%pd", &idx)) {

Instead of using this, I recommend to use `glob_match("*:%pd", argv[i])`
so that you can simply expand the pattern as `glob_match("*:%p[dD]",...)`
(glob_match means wildcard match like shell does)

Thank you,

> +			char *tmp = kstrdup(argv[i], GFP_KERNEL);
> +			char *equal;
> +
> +			if (!tmp)
> +				return -ENOMEM;
> +
> +			equal = strchr(tmp, '=');
> +			if (equal)
> +				*equal = '\0';
> +			tmp[idx] = '\0';
> +			ret = snprintf(buf + used, bufsize - used,
nb> +				       "%s%s+0x0(+0x%zx(%s)):string",
> +				       equal ? tmp : "", equal ? "=" : "",
> +				       offsetof(struct dentry, d_name.name),
> +				       equal ? equal + 1 : tmp);
> +			kfree(tmp);
> +			if (ret >= bufsize - used)
> +				return -ENOMEM;
> +			argv[i] = buf + used;
> +			used += ret + 1;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
>  void traceprobe_finish_parse(struct traceprobe_parse_context *ctx)
>  {
>  	clear_btf_context(ctx);
> diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
> index 850d9ecb6765..553371a4e0b1 100644
> --- a/kernel/trace/trace_probe.h
> +++ b/kernel/trace/trace_probe.h
> @@ -402,6 +402,8 @@ extern int traceprobe_parse_probe_arg(struct trace_probe *tp, int i,
>  const char **traceprobe_expand_meta_args(int argc, const char *argv[],
>  					 int *new_argc, char *buf, int bufsize,
>  					 struct traceprobe_parse_context *ctx);
> +extern int traceprobe_expand_dentry_args(int argc, const char *argv[], char *buf,
> +					 int bufsize);
>  
>  extern int traceprobe_update_arg(struct probe_arg *arg);
>  extern void traceprobe_free_probe_arg(struct probe_arg *arg);
> -- 
> 2.31.1
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

