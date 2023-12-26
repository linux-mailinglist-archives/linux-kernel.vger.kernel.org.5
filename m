Return-Path: <linux-kernel+bounces-11598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B83181E8C3
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 18:51:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21EA91F21957
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 17:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 233714FF64;
	Tue, 26 Dec 2023 17:51:08 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2CFC4F892;
	Tue, 26 Dec 2023 17:51:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B64D0C433C8;
	Tue, 26 Dec 2023 17:51:06 +0000 (UTC)
Date: Tue, 26 Dec 2023 12:51:50 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org, Linux
 Trace Kernel <linux-trace-kernel@vger.kernel.org>, Jonathan Corbet
 <corbet@lwn.net>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] ring-buffer/Documentation: Add documentation on
 buffer_percent file
Message-ID: <20231226125150.62d7521f@gandalf.local.home>
In-Reply-To: <20231226123525.71a6d0fb@gandalf.local.home>
References: <20231226123525.71a6d0fb@gandalf.local.home>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


Jon,

I was about to ask if you can take this through your tree, but then I did a
self edit :-p

On Tue, 26 Dec 2023 12:35:25 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> When the buffer_percent file was added to the kernel, the documentation
> should have been updated to document what that file does.
> 
> Fixes: 03329f9939781 ("tracing: Add tracefs file buffer_percentage")
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  Documentation/trace/ftrace.rst | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/Documentation/trace/ftrace.rst b/Documentation/trace/ftrace.rst
> index 933e7efb9f1b..16eabb00fa55 100644
> --- a/Documentation/trace/ftrace.rst
> +++ b/Documentation/trace/ftrace.rst
> @@ -180,6 +180,21 @@ of ftrace. Here is a list of some of the key files:
>  	Only active when the file contains a number greater than 0.
>  	(in microseconds)
>  
> +  buffer_percent:
> +
> +	This is the water-mark for how much the ring buffer needs to be filled
> +	before a waiter is woken up. That is, if an application call a

							"calls"

> +	blocking read syscall on one of the per_cpu trace_pipe_raw files, it
> +	will block until the given amount of data specified by buffer_percent
> +	is in the ring buffer before it wakes the reader up. This also
> +	controls how splice system calls are blocked on this file.

		"the splice system"

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

Will send a v2.

-- Steve


