Return-Path: <linux-kernel+bounces-91487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6D28871240
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 02:16:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 872FC1F25BF5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 01:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9891B125C9;
	Tue,  5 Mar 2024 01:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="oGrzNwVG"
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29799111A5;
	Tue,  5 Mar 2024 01:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709601356; cv=none; b=obJb5O7VNy15jz3Qm48BkgTVcWxqvY1jzsB32qfTr6Z3tgrSXwmG9zZVkZ5ritt5IBqGHDDQ1ROIBzw89HV6Yk2txqD9ewgd24l0fGzmas5t850jBoxtite1hvqAYif5dh4YqogYSR6jjBeqCrysMkvxcpWnJ+Gd8i57+ID5CwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709601356; c=relaxed/simple;
	bh=VSnMIxwiLgIVNBm+HqRXuCM3mAW7fERVj+EaPcKobwg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CNt0vW1jp3hY4tcYAyYNsMOYISeuQuPz5rKcSe4YOsntpHB2jOYyNU+NhZTNkGkSOwGw+mlJX5sVGTYMRtGJzkJNgW07jUfvoHUPj67IV2iA9igcvCaEXQPN4SjWWXU2ljvXbKt9uq0ojwnzTfGzrfEOw5MCWrCcRWMq3yKuZow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=oGrzNwVG; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1709601351;
	bh=VSnMIxwiLgIVNBm+HqRXuCM3mAW7fERVj+EaPcKobwg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=oGrzNwVGPUOxVrBhAOadX0/lmwNQUX6R+x5yBg9PpHSU2iR9Rz4LsLxskClmzXG/w
	 hWQE5YogxPzV5kN96xrfSbCoSWdwQldymfh3RDzRCfXbMjz2BIXnctEWzpt2UWU4eJ
	 eBTn9YAl52SpyilqAwucYKd4+KjYlLJk5/UpDGHzT7FaDJm46OZlWTuF9M5yQW0yI5
	 GwCgAzh+10mdm7MwaXmUTZdH4SQmpO60RDYZgolpZxzQlspLxhqh9lRXZQJl13rJtf
	 JLrRxPFSKQdBi7gt3crn2Lv9PSjTH3c9ARWpc6Ob1ZbuANKY/AYOnwNLKpuTm9qN7N
	 tDGz6xsgXkWJw==
Received: from [IPV6:2606:6d00:100:4000:cacb:9855:de1f:ded2] (unknown [IPv6:2606:6d00:100:4000:cacb:9855:de1f:ded2])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4Tpd135BJwzft5;
	Mon,  4 Mar 2024 20:15:51 -0500 (EST)
Message-ID: <469d31a7-f358-4547-bb17-0979b3515924@efficios.com>
Date: Mon, 4 Mar 2024 20:15:57 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tracing: Have trace_marker writes be just half of
 TRACE_SEQ_SIZE
Content-Language: en-US
To: Steven Rostedt <rostedt@goodmis.org>, LKML
 <linux-kernel@vger.kernel.org>,
 Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Sachin Sant <sachinp@linux.ibm.com>
References: <20240304192710.4c99677c@gandalf.local.home>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <20240304192710.4c99677c@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-03-04 19:27, Steven Rostedt wrote:
> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> Since the size of trace_seq's buffer is the max an event can output, have
> the trace_marker be half of the entire TRACE_SEQ_SIZE, which is 4K. That
> will keep writes that has meta data written from being dropped (but
> reported), because the total output of the print event is greater than
> what the trace_seq can hold.

Defining the trace_mark limit in terms of "TRACE_SEQ_SIZE / 2"
seems backwards. It's basically using a define of the maximum
buffer size for the pretty-printing output and defining the maximum
input size of a system call to half of that.

I'd rather see, in a header file shared between tracing mark
write implementation and output implementation:

#define TRACING_MARK_MAX_SIZE	4096

and then a static validation that this input fits within your
pretty printing output in the output implementation file:

BUILD_BUG_ON(TRACING_MARK_MAX_SIZE + sizeof(meta data stuff...) > TRACE_SEQ_SIZE);

This way we clearly document that the tracing mark write
input limit is 4kB, rather than something derived from
the size of an output buffer.

Thanks,

Mathieu

> 
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>   kernel/trace/trace.c | 16 +++++++++++-----
>   1 file changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 8198bfc54b58..d68544aef65f 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -7320,6 +7320,17 @@ tracing_mark_write(struct file *filp, const char __user *ubuf,
>   	if ((ssize_t)cnt < 0)
>   		return -EINVAL;
>   
> +	/*
> +	 * TRACE_SEQ_SIZE is the total size of trace_seq buffer used
> +	 * for output. As the print event outputs more than just
> +	 * the string written, keep it smaller than the trace_seq
> +	 * as it could drop the event if the extra data makes it bigger
> +	 * than what the trace_seq can hold. Half he TRACE_SEQ_SIZE
> +	 * is more than enough.
> +	 */
> +	if (cnt > TRACE_SEQ_SIZE / 2)
> +		cnt = TRACE_SEQ_SIZE / 2;
> +
>   	meta_size = sizeof(*entry) + 2;  /* add '\0' and possible '\n' */
>    again:
>   	size = cnt + meta_size;
> @@ -7328,11 +7339,6 @@ tracing_mark_write(struct file *filp, const char __user *ubuf,
>   	if (cnt < FAULTED_SIZE)
>   		size += FAULTED_SIZE - cnt;
>   
> -	if (size > TRACE_SEQ_BUFFER_SIZE) {
> -		cnt -= size - TRACE_SEQ_BUFFER_SIZE;
> -		goto again;
> -	}
> -
>   	buffer = tr->array_buffer.buffer;
>   	event = __trace_buffer_lock_reserve(buffer, TRACE_PRINT, size,
>   					    tracing_gen_ctx());

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


