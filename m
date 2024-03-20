Return-Path: <linux-kernel+bounces-108911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20E878811D1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 13:47:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1D7D285D4A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 12:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B0803FE44;
	Wed, 20 Mar 2024 12:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C+pEt8aL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7783FE23;
	Wed, 20 Mar 2024 12:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710938812; cv=none; b=fkvXVtgKvCkyEln0HpFkRitpIrFl8kZu8wmj0hIoC5mB64+HNdwfrMeVZ5BTBJxgvPKH9iXsxKWN3DAGkG0JJeu8QyYx0hQ1cK3dEVnzQ2HL3VG1Fa2R2L4yW3E3Ar3nlyZQcUpPxKk40Z5TZJFjavykrSsSyyNROCfuL3HPs8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710938812; c=relaxed/simple;
	bh=/7p8GXU57n2CqgDBwvg1L0/7Jk+R2NftaczecrTwYJE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=cE48WxAmVNXouTBm9GYzSMPcIIVAX3VQJRVg+oZLT0vwXQVgik/JzVyqBBfBGE37vPC67N231smizS6P2DaLDeJZnBqe7WxqoFDEqx4G+9dLWU/d+Jb3T/Mhkv0so9Fcc7o87Dm/B/auUOIKTPUTR2BaXN8Fo6FUuKQidX4VyiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C+pEt8aL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86D05C43390;
	Wed, 20 Mar 2024 12:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710938812;
	bh=/7p8GXU57n2CqgDBwvg1L0/7Jk+R2NftaczecrTwYJE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=C+pEt8aLs3Hd/KuKXxjjepyLmcPVeBXwPeOyFEfpDSc4joKEUKFzxoDelaOyP57pI
	 lkh9HfHFERU2KT5PjtbjQ1l6wuIWu4/SoHtJ23jNau6FqFCLwGVBwlDB13wL8aGFdP
	 WOvbeg4uK9IT4OZkihQ1/g7RXi6qqu6YIBM/EgbRhEKY3V71ANSV9kqWxlc8CY5bh1
	 nmoZ7WrgHRmkowYxGlNHdt7RtsLr55Kse0/IEM/axjuwSItXcqD1tAKHlar/CTQMyc
	 DwuiFwemIUk43lQixezmqQo0fumOV0ZoPjxwALGrCMPZfGmMgLo52XkcIdAVbIhELk
	 /mWtzjPKbLq+g==
Date: Wed, 20 Mar 2024 21:46:48 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Ye Bin <yebin10@huawei.com>
Cc: <rostedt@goodmis.org>, <mathieu.desnoyers@efficios.com>,
 <linux-trace-kernel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 3/8] tracing/probes: support '%pd' type for fprobe
Message-Id: <20240320214648.a805dbd31fef4452b87d70c1@kernel.org>
In-Reply-To: <20240315065540.1181879-4-yebin10@huawei.com>
References: <20240315065540.1181879-1-yebin10@huawei.com>
	<20240315065540.1181879-4-yebin10@huawei.com>
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

BTW, if you have a chance, please squash [1/8] to [3/8] patches
into 1 patch. There is no reason to split these since these are
a local(= the same subsystem) function implementation and callers.

Thank you,

On Fri, 15 Mar 2024 14:55:35 +0800
Ye Bin <yebin10@huawei.com> wrote:

> Support print type '%pd' for print dentry's or file's name.
> 
> Signed-off-by: Ye Bin <yebin10@huawei.com>
> ---
>  kernel/trace/trace_fprobe.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/kernel/trace/trace_fprobe.c b/kernel/trace/trace_fprobe.c
> index 7d2ddbcfa377..988d68e906ad 100644
> --- a/kernel/trace/trace_fprobe.c
> +++ b/kernel/trace/trace_fprobe.c
> @@ -976,6 +976,7 @@ static int __trace_fprobe_create(int argc, const char *argv[])
>  	char gbuf[MAX_EVENT_NAME_LEN];
>  	char sbuf[KSYM_NAME_LEN];
>  	char abuf[MAX_BTF_ARGS_LEN];
> +	char *dbuf = NULL;
>  	bool is_tracepoint = false;
>  	struct tracepoint *tpoint = NULL;
>  	struct traceprobe_parse_context ctx = {
> @@ -1086,6 +1087,10 @@ static int __trace_fprobe_create(int argc, const char *argv[])
>  		argv = new_argv;
>  	}
>  
> +	ret = traceprobe_expand_dentry_args(argc, argv, &dbuf);
> +	if (ret)
> +		goto out;
> +
>  	/* setup a probe */
>  	tf = alloc_trace_fprobe(group, event, symbol, tpoint, maxactive,
>  				argc, is_return);
> @@ -1131,6 +1136,7 @@ static int __trace_fprobe_create(int argc, const char *argv[])
>  	trace_probe_log_clear();
>  	kfree(new_argv);
>  	kfree(symbol);
> +	kfree(dbuf);
>  	return ret;
>  
>  parse_error:
> -- 
> 2.31.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

