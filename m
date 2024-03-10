Return-Path: <linux-kernel+bounces-98077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7B068774C5
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 02:25:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D13BC1C20A7B
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 01:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0189ED8;
	Sun, 10 Mar 2024 01:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gzL89X0M"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED827FB
	for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2024 01:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710033939; cv=none; b=XrSUeJZuHm5HCy283gccDthPeYyIguUf/VXeL5UrJz05kuRl07ZgpsSgHhuZ6LHKkZqF6/tonNyMar1Itf9mE4ocFK5K/OGk7HX85p8x9S0w5wkYTfj0uwSVj5GgFIQYG3h4tyht85Vq18sl2WTmPBFReCNXJv0AN6oeqmR2jBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710033939; c=relaxed/simple;
	bh=G40V4vpPRhyixM7l44qRiTMIVlsMvJ2N4QjvotB9vtg=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=QJM0MHG+vlp0jrLwPI2iBq6oOWI5V5ImShD1Xs62MNIlxZheiJujwZm4eT2ecZlEkzVhng4tNBcdlrO+ooWPos4hR6tvzArFzDIlqydxXn/63mw4p1JMK6bw8ptZwIj0MsXPvi628RaZq/ixv7pTRNy9kpIzN1NEMeDKbrSdd9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gzL89X0M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48667C433C7;
	Sun, 10 Mar 2024 01:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710033938;
	bh=G40V4vpPRhyixM7l44qRiTMIVlsMvJ2N4QjvotB9vtg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gzL89X0MUOzZfAHmgAH2AUvQ1p9AYy6Y7dgcGvWbHWwnzil45oavNvtc97VJli/k7
	 lJzNYz7C+pUylhduMlA6nBjLK57Pl0vXy2fEI5HTLNyGbA9SSj79hFKOs7qKisGkJT
	 asX+hTHA/nRQNx5dSDO4ggnfI8wlkHpNKxt/dOJ309DrId7LCP6HUQc2fkP4e03PgF
	 PB2TLLKSYSb70n1crPU4JiL+2rtTV9+YcsDJGftPdLof0nvgOsrf1XoW4+TUaXw8F9
	 pO3Aeo3KWv37JtusdK7W6RYNsOIFB5DScH6tymFGaxNwyDGImtoSNNWWipzua5P2pS
	 XGw9xjqRwd7mg==
Date: Sun, 10 Mar 2024 10:25:34 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] bootconfig: do not put quotes on cmdline items
 unless necessary
Message-Id: <20240310102534.cf79e09037df23b4f51981b0@kernel.org>
In-Reply-To: <20240308124401.1702046-1-linux@rasmusvillemoes.dk>
References: <20240308124401.1702046-1-linux@rasmusvillemoes.dk>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  8 Mar 2024 13:44:01 +0100
Rasmus Villemoes <linux@rasmusvillemoes.dk> wrote:

> When trying to migrate to using bootconfig to embed the kernel's and
> PID1's command line with the kernel image itself, and so allowing
> changing that without modifying the bootloader, I noticed that
> /proc/cmdline changed from e.g.
> 
>   console=ttymxc0,115200n8 cma=128M quiet -- --log-level=notice
> 
> to
> 
>   console="ttymxc0,115200n8" cma="128M" quiet -- --log-level="notice"
> 
> The kernel parameters are parsed just fine, and the quotes are indeed
> stripped from the actual argv[] given to PID1. However, the quoting
> doesn't really serve any purpose and looks excessive, and might
> confuse some (naive) userspace tool trying to parse /proc/cmdline. So
> do not quote the value unless it contains whitespace.
> 
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> ---
> 
> v2: use strpbrk(, " \t\r\n") instead of a loop doing isspace().
> Technically not quite equivalent, but much more readable, and it's
> quite unlikely anybody has \f or \v or 0xa0 bytes in kernel command
> line arguments. Perhaps \r and \n, and maybe even \t, could also be
> dropped from that list, but those at least have some chance of
> appearing in the wild.
> 
>  init/main.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/init/main.c b/init/main.c
> index e24b0780fdff..3dd630132209 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -324,7 +324,7 @@ static int __init xbc_snprint_cmdline(char *buf, size_t size,
>  {
>  	struct xbc_node *knode, *vnode;
>  	char *end = buf + size;
> -	const char *val;
> +	const char *val, *q;
>  	int ret;
>  
>  	xbc_node_for_each_key_value(root, knode, val) {
> @@ -342,8 +342,9 @@ static int __init xbc_snprint_cmdline(char *buf, size_t size,
>  			continue;
>  		}
>  		xbc_array_for_each_value(vnode, val) {
> -			ret = snprintf(buf, rest(buf, end), "%s=\"%s\" ",
> -				       xbc_namebuf, val);

Can you add a comment that why strpbrk(," \t\r\n") is used here?
Such comment will help when we change how to parse the cmdline options.

Thanks,

> +			q = strpbrk(val, " \t\r\n") ? "\"" : "";
> +			ret = snprintf(buf, rest(buf, end), "%s=%s%s%s ",
> +				       xbc_namebuf, q, val, q);
>  			if (ret < 0)
>  				return ret;
>  			buf += ret;
> -- 
> 2.40.1.1.g1c60b9335d
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

