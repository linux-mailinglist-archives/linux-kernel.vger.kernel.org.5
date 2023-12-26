Return-Path: <linux-kernel+bounces-11656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A577481E978
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 20:43:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F2C72833A7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 19:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDCA31FC1;
	Tue, 26 Dec 2023 19:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ztqRwRly"
X-Original-To: linux-kernel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9AD4C67;
	Tue, 26 Dec 2023 19:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=9U5copr9xDoJG160dopatrz4QWoLK4jdJ0iC5TUWcmE=; b=ztqRwRlybhDpub6IodCHbbzPi6
	qy3cy2/4BA6/kQXhUwl0foKUgdQsutlj/fWmfRjW+GdY6mKD7Jl4ttVHRJnoN2K9lsfmOo2Ga0wfL
	U3DwCwgEE5VNXSVsEEc4IY9q7+fnnHmBCUbvyR9Wh9TUD8IbtwU1bzK3yGNxOhfZww8Oie1zxlJgv
	5hWLFX8kSwFo8cTbdNv3F78SjD4D2gGHwnbwDC3GpZOGZy/VC91sl8p9+i7BvVPFuKKkOvRJk0J8O
	CiGBV0M497hCwIE1o+oVlVWfLLky1Pu+CZghVtuYIElgEczEJ3MsbFVNOj9SrtpYKN+HgPQhyKlaI
	w7KIhhlw==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rIDKK-00DST5-1d;
	Tue, 26 Dec 2023 19:42:56 +0000
Message-ID: <92cedbf6-0313-4ff7-96a7-ddd40506b82e@infradead.org>
Date: Tue, 26 Dec 2023 11:42:54 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ring-buffer/Documentation: Add documentation on
 buffer_percent file
Content-Language: en-US
To: Steven Rostedt <rostedt@goodmis.org>, LKML
 <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org,
 Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
 Jonathan Corbet <corbet@lwn.net>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
References: <20231226130149.4685c838@gandalf.local.home>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20231226130149.4685c838@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/26/23 10:01, Steven Rostedt wrote:
> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> When the buffer_percent file was added to the kernel, the documentation
> should have been updated to document what that file does.
> 
> Fixes: 03329f9939781 ("tracing: Add tracefs file buffer_percentage")
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
> Changes since v1: https://lore.kernel.org/all/20231226123525.71a6d0fb@gandalf.local.home/
> 
> - Fixed some grammar issues.
> 
>  Documentation/trace/ftrace.rst | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/Documentation/trace/ftrace.rst b/Documentation/trace/ftrace.rst
> index 933e7efb9f1b..84b810a6cf76 100644
> --- a/Documentation/trace/ftrace.rst
> +++ b/Documentation/trace/ftrace.rst
> @@ -180,6 +180,21 @@ of ftrace. Here is a list of some of the key files:
>  	Only active when the file contains a number greater than 0.
>  	(in microseconds)
>  
> +  buffer_percent:
> +
> +	This is the water-mark for how much the ring buffer needs to be filled

                    watermark
please

> +	before a waiter is woken up. That is, if an application calls a
> +	blocking read syscall on one of the per_cpu trace_pipe_raw files, it
> +	will block until the given amount of data specified by buffer_percent
> +	is in the ring buffer before it wakes the reader up. This also
> +	controls how the splice system calls are blocked on this file.
> +
> +	0   - means to wake up as soon as there is any data in the ring buffer.
> +	50  - means to wake up when roughly half of the ring buffer sub-buffers
> +	      are full.
> +	100 - means to block until the ring buffer is totally full and is
> +	      about to start overwriting the older data.
> +
>    buffer_size_kb:
>  
>  	This sets or displays the number of kilobytes each CPU

-- 
#Randy
https://people.kernel.org/tglx/notes-about-netiquette
https://subspace.kernel.org/etiquette.html

