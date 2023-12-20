Return-Path: <linux-kernel+bounces-7059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 558F481A119
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 15:27:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12525281C66
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 14:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9064C38F9A;
	Wed, 20 Dec 2023 14:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KKoTrNqf"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF19838F8C;
	Wed, 20 Dec 2023 14:27:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E141C433C8;
	Wed, 20 Dec 2023 14:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703082456;
	bh=nlFC8zkxQG9EE7rFcvJAUdFd7Rw1XSe471AsxB7/LcU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KKoTrNqfXiVIirN3QJ7zCFDGB4s+drlDnOMfMaIHXEbMrbFS+6TcZLNfI0X66OROW
	 XkGxVchbkCFsIQrLjEHNqIKM8ncEloTGhMaizSsrcS1R5apynJeMYiSJAkJeK8Kg47
	 RWIlImG4AJF1Ed0QGIQepkT7u69omBTjGHLMQWKLexLe2YFZ/EpNJkt0HFjjg8tA8E
	 hdAtCbvoGTcQmtKnvMFznsrfZKr8HPQ1yl8BBI6pvt+HGRFVN+8iC7prnT4YQywwJU
	 d8iAAjNO8Y4C/ZKn/aiQamddjKnUCe/zMjJlySBuGgE9yN7BR55uZoNRk5nrcPoH+q
	 2v0GetRl6nVjg==
Date: Wed, 20 Dec 2023 23:27:31 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, David Laight
 <David.Laight@ACULAB.COM>
Subject: Re: [PATCH] ring-buffer: Remove stale comment from
 ring_buffer_size()
Message-Id: <20231220232731.879a37f56f7888d4b14bd107@kernel.org>
In-Reply-To: <20231220081028.7cd7e8e2@gandalf.local.home>
References: <20231220081028.7cd7e8e2@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 20 Dec 2023 08:10:28 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> It's been 11 years since the ring_buffer_size() function was updated to
> use the nr_pages from the buffer->buffers[cpu] structure instead of using
> the buffer->nr_pages that no longer exists.
> 
> The comment in the code is more of what a change log should have and is
> pretty much useless for development. It's saying how things worked back in
> 2012 that bares no purpose on today's code. Remove it.
> 
> Link: https://lore.kernel.org/linux-trace-kernel/84d3b41a72bd43dbb9d44921ef535c92@AcuMS.aculab.com/
> 

Looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks,

> Reported-by: David Laight <David.Laight@ACULAB.COM>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  kernel/trace/ring_buffer.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index 173d2595ce2d..7887d61d5b56 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -5122,12 +5122,6 @@ EXPORT_SYMBOL_GPL(ring_buffer_iter_advance);
>   */
>  unsigned long ring_buffer_size(struct trace_buffer *buffer, int cpu)
>  {
> -	/*
> -	 * Earlier, this method returned
> -	 *	buffer->subbuf_size * buffer->nr_pages
> -	 * Since the nr_pages field is now removed, we have converted this to
> -	 * return the per cpu buffer value.
> -	 */
>  	if (!cpumask_test_cpu(cpu, buffer->cpumask))
>  		return 0;
>  
> -- 
> 2.42.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

