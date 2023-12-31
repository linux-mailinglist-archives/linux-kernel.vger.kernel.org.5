Return-Path: <linux-kernel+bounces-13630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FBD98209B3
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 05:39:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C7AE1F21663
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 04:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B0D117F4;
	Sun, 31 Dec 2023 04:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EEL4F3KZ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEDA6138A;
	Sun, 31 Dec 2023 04:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=IVgiiMZDdOtzhHaKIlJ7lRKAgdbPHW0wrCohBZPxCWA=; b=EEL4F3KZtl41bZZKJ0d3hf/GgY
	r7VdpYBtVMkLrvW9l/yF8ppEMjk34MvQQKY1X0McrXzr6EK1NUdlOMy1ug3pOevIMgVFDkYnKToF7
	9B0GK4VmTlhGrReZYbcTOi81JWqFVZjZfXyk2Fk4cQan1fHl1CxQ9YKuzbYWRPRVMKvkuU9cdQKf8
	aoF/dMkLYxk5W83UmubMnXbFShjk6cySsQZPdbASM30J8uTYPOlm3+MT4gfcN6D8bL3vDVWKNeg2O
	x+9PeQgWFrw62aJ+JSrfehJYAmAXhWesJI+BtE+2Upjl22eUmqj8Z5awHTmwHHdksfwtDn3DWvk6N
	6x0l8DFQ==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rJnbZ-003wt9-1b;
	Sun, 31 Dec 2023 04:39:17 +0000
Message-ID: <4ad2944b-db65-4877-b388-2bcaa23e88ec@infradead.org>
Date: Sat, 30 Dec 2023 20:39:16 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] ring-buffer/Documentation: Add documentation on
 buffer_percent file
Content-Language: en-US
To: Steven Rostedt <rostedt@goodmis.org>, LKML
 <linux-kernel@vger.kernel.org>,
 Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
 linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
References: <20231229122402.537eb252@gandalf.local.home>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20231229122402.537eb252@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/29/23 09:24, Steven Rostedt wrote:
> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> When the buffer_percent file was added to the kernel, the documentation
> should have been updated to document what that file does.
> 
> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> Fixes: 03329f9939781 ("tracing: Add tracefs file buffer_percentage")
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

LGTM. Thanks.
Acked-by: Randy Dunlap <rdunlap@infradead.org>

> ---
> Changes since v2: https://lore.kernel.org/linux-trace-kernel/20231226130149.4685c838@gandalf.local.home
> 
> - s/watermark/water-mark/ (Randy Dunlap)

That comment is backwards. :)
No new patch needed IMO.

> 
> - Added '::' and indented the number list so that it has better
>   formatting (kernel test robot)
> 
>  Documentation/trace/ftrace.rst | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/Documentation/trace/ftrace.rst b/Documentation/trace/ftrace.rst
> index 933e7efb9f1b..917501a2f348 100644
> --- a/Documentation/trace/ftrace.rst
> +++ b/Documentation/trace/ftrace.rst
> @@ -180,6 +180,21 @@ of ftrace. Here is a list of some of the key files:
>  	Only active when the file contains a number greater than 0.
>  	(in microseconds)
>  
> +  buffer_percent:
> +
> +	This is the watermark for how much the ring buffer needs to be filled
> +	before a waiter is woken up. That is, if an application calls a
> +	blocking read syscall on one of the per_cpu trace_pipe_raw files, it
> +	will block until the given amount of data specified by buffer_percent
> +	is in the ring buffer before it wakes the reader up. This also
> +	controls how the splice system calls are blocked on this file::
> +
> +	  0   - means to wake up as soon as there is any data in the ring buffer.
> +	  50  - means to wake up when roughly half of the ring buffer sub-buffers
> +	        are full.
> +	  100 - means to block until the ring buffer is totally full and is
> +	        about to start overwriting the older data.
> +
>    buffer_size_kb:
>  
>  	This sets or displays the number of kilobytes each CPU

-- 
#Randy

