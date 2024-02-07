Return-Path: <linux-kernel+bounces-56622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E05F84CCC2
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 15:29:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3208D1C2551C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 14:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E72E07C6C8;
	Wed,  7 Feb 2024 14:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WjxzIN1t"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F757C08C;
	Wed,  7 Feb 2024 14:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707316181; cv=none; b=uraitFycrI3lOkD+EMvISQ0vIYEateeyqc6lcVxkWw+gy+lSlkX4QWAM76IcGGCSN63H5u9yxAFA2oSTmrNABesfIQZN5zsPDRjCPgIzO2y+X+Q7le/Hx1S6CHQhtbrClwwb2nqN05NHrO63a5dZFYHkb7+efB+vJg8rFL74CCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707316181; c=relaxed/simple;
	bh=R+/WIaoIjD8psMbUkTSxqa/QWW5tlhPideSsKQwZD8w=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=IPsEkIma2Ft5Hh0/NQJhxNI3tMYbZ59Qdf0748299P1pKTxwncof2RD3d/Gj0bfnE8wmS8Ex2Qo3TjLOS+lp/2YILx/SAM1MO3zKGbBk3fwuqmvbd9V+TVbC/5AgADyvjZ5iy4JdlefFXbIsIhWMWtvYnmofQ49oWerfGOsLJuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WjxzIN1t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1531FC43390;
	Wed,  7 Feb 2024 14:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707316180;
	bh=R+/WIaoIjD8psMbUkTSxqa/QWW5tlhPideSsKQwZD8w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WjxzIN1tbdYYh6j4dVl88fHHULYEYh5ctBDtDONlFRdDrWsVUgfSJUjpZmkwe3wfe
	 7AiEfU0njpkprojuCB81YHVgPBKJXZz90TSUblmwkbmmUOKs3LwgmnaTvR2DyZOP6w
	 /TKpRDk5u32+2uQOXHGvMF3ez7tMNZmlGo+HALs8LKrZJ3+gmw6djJwQ4g3lUrzESN
	 oz5JIGjsyMR+anBL7dOdE8TfAG6zMHEM7DGwStXgLpW5RvZFTxrmCznfpuqFiVhJz6
	 eD/oBU5KQt4+pnSOrJBurTv3Odvx6wu8QAUu0vxF2nO0KqUfLSJcMHadGeB/pbGEyO
	 5Ez9qpUf24nUQ==
Date: Wed, 7 Feb 2024 23:29:36 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Ye Bin <yebin10@huawei.com>
Cc: <rostedt@goodmis.org>, <mathieu.desnoyers@efficios.com>,
 <linux-trace-kernel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 1/8] tracing/probes: add
 traceprobe_expand_dentry_args() helper
Message-Id: <20240207232936.f93bbea10f920a263cb963b0@kernel.org>
In-Reply-To: <20240125073923.2252057-2-yebin10@huawei.com>
References: <20240125073923.2252057-1-yebin10@huawei.com>
	<20240125073923.2252057-2-yebin10@huawei.com>
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

On Thu, 25 Jan 2024 15:39:16 +0800
Ye Bin <yebin10@huawei.com> wrote:

> Add traceprobe_expand_dentry_args() to expand dentry args. this API is
> prepare to support "%pd" print format for kprobe.
> 
> Signed-off-by: Ye Bin <yebin10@huawei.com>
> ---
>  kernel/trace/trace_probe.c | 50 ++++++++++++++++++++++++++++++++++++++
>  kernel/trace/trace_probe.h |  2 ++
>  2 files changed, 52 insertions(+)
> 
> diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
> index 4dc74d73fc1d..0c1caf0f474a 100644
> --- a/kernel/trace/trace_probe.c
> +++ b/kernel/trace/trace_probe.c
> @@ -1565,6 +1565,56 @@ const char **traceprobe_expand_meta_args(int argc, const char *argv[],
>  	return ERR_PTR(ret);
>  }
>  
> +/* @buf: *buf must be equal to NULL. Caller must to free *buf */
> +int traceprobe_expand_dentry_args(int argc, const char *argv[], char **buf)
> +{
> +	int i, used, ret;
> +	int bufsize = MAX_DENTRY_ARGS_LEN;

nit: this bufsize is consistent, thus you should use the MAX_DENTRY_ARGS_LEN
     directly. (or add 'const' or maybe you can update bufsize as remaining size)

Thanks,

> +	char *tmpbuf = NULL;
> +
> +	if (*buf)
> +		return -EINVAL;
> +
> +	used = 0;
> +	for (i = 0; i < argc; i++) {
> +		if (glob_match("*:%pd", argv[i])) {
> +			char *tmp;
> +			char *equal;
> +
> +			if (!tmpbuf) {
> +				tmpbuf = kmalloc(bufsize, GFP_KERNEL);
> +				if (!tmpbuf)
> +					return -ENOMEM;
> +			}
> +
> +			tmp = kstrdup(argv[i], GFP_KERNEL);
> +			if (!tmp)
> +				goto nomem;
> +
> +			equal = strchr(tmp, '=');
> +			if (equal)
> +				*equal = '\0';
> +			tmp[strlen(argv[i]) - 4] = '\0';
> +			ret = snprintf(tmpbuf + used, bufsize - used,
> +				       "%s%s+0x0(+0x%zx(%s)):string",
> +				       equal ? tmp : "", equal ? "=" : "",
> +				       offsetof(struct dentry, d_name.name),
> +				       equal ? equal + 1 : tmp);
> +			kfree(tmp);
> +			if (ret >= bufsize - used)
> +				goto nomem;
> +			argv[i] = tmpbuf + used;
> +			used += ret + 1;
> +		}
> +	}
> +
> +	*buf = tmpbuf;
> +	return 0;
> +nomem:
> +	kfree(tmpbuf);
> +	return -ENOMEM;
> +}
> +
>  void traceprobe_finish_parse(struct traceprobe_parse_context *ctx)
>  {
>  	clear_btf_context(ctx);
> diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
> index 850d9ecb6765..5800513439f3 100644
> --- a/kernel/trace/trace_probe.h
> +++ b/kernel/trace/trace_probe.h
> @@ -34,6 +34,7 @@
>  #define MAX_ARRAY_LEN		64
>  #define MAX_ARG_NAME_LEN	32
>  #define MAX_BTF_ARGS_LEN	128
> +#define MAX_DENTRY_ARGS_LEN	256
>  #define MAX_STRING_SIZE		PATH_MAX
>  #define MAX_ARG_BUF_LEN		(MAX_TRACE_ARGS * MAX_ARG_NAME_LEN)
>  
> @@ -402,6 +403,7 @@ extern int traceprobe_parse_probe_arg(struct trace_probe *tp, int i,
>  const char **traceprobe_expand_meta_args(int argc, const char *argv[],
>  					 int *new_argc, char *buf, int bufsize,
>  					 struct traceprobe_parse_context *ctx);
> +extern int traceprobe_expand_dentry_args(int argc, const char *argv[], char **buf);
>  
>  extern int traceprobe_update_arg(struct probe_arg *arg);
>  extern void traceprobe_free_probe_arg(struct probe_arg *arg);
> -- 
> 2.31.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

