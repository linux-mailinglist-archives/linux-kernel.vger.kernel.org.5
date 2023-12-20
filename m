Return-Path: <linux-kernel+bounces-6867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00AB7819EB2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 13:11:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB54E2871B2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 12:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A017322323;
	Wed, 20 Dec 2023 12:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DUayH45U"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72CA224C8;
	Wed, 20 Dec 2023 12:11:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3121C433C8;
	Wed, 20 Dec 2023 12:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703074297;
	bh=UyVES0yGOZFSGG4lRjbL3dWPaXBK15e0io0HDwNiXHE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DUayH45UB/QeaU85TH0c4gzPIqbYYcxv2OLxGO8Amzok4xhqVah6ZzkyNvcAS9VLq
	 t5nncSTA3Qls3toti4f/eWO+BuTkKyN5yjJGwNwfErH3XdsWkXJmcqW26P5/7uC4PX
	 zI+945GH79R9IrwqhM4gCcb2yYH0es/WCW3UHv20uAAZopbHxaFK9KGTDJEEgy0Sn0
	 6GudGnuC6w+GsXXnodfvmNkUVFKpIY+PGOqf2eE6Di0+5a2ZlPAOuD28aQ6VHY0m6a
	 S2TAjGIKRsCnGQhY1Uq/LzUViVURAyhQ6uV9yt8NkVIrncNIjy88DL3RyXfKxWtjoW
	 W//47BJZ5UueA==
Date: Wed, 20 Dec 2023 21:11:33 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing/synthetic: fix kernel-doc warnings
Message-Id: <20231220211133.5a1e558134cba721250acf5f@kernel.org>
In-Reply-To: <20231220061226.30962-1-rdunlap@infradead.org>
References: <20231220061226.30962-1-rdunlap@infradead.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 19 Dec 2023 22:12:26 -0800
Randy Dunlap <rdunlap@infradead.org> wrote:

> scripts/kernel-doc warns about using @args: for variadic arguments to
> functions. Documentation/doc-guide/kernel-doc.rst says that this should
> be written as @...: instead, so update the source code to match that,
> preventing the warnings.
> 
> trace_events_synth.c:1165: warning: Excess function parameter 'args' description in '__synth_event_gen_cmd_start'
> trace_events_synth.c:1714: warning: Excess function parameter 'args' description in 'synth_event_trace'
> 

Thanks, this looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: linux-trace-kernel@vger.kernel.org
> ---
>  kernel/trace/trace_events_synth.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff -- a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
> --- a/kernel/trace/trace_events_synth.c
> +++ b/kernel/trace/trace_events_synth.c
> @@ -1137,7 +1137,7 @@ EXPORT_SYMBOL_GPL(synth_event_add_fields
>   * @cmd: A pointer to the dynevent_cmd struct representing the new event
>   * @name: The name of the synthetic event
>   * @mod: The module creating the event, NULL if not created from a module
> - * @args: Variable number of arg (pairs), one pair for each field
> + * @...: Variable number of arg (pairs), one pair for each field
>   *
>   * NOTE: Users normally won't want to call this function directly, but
>   * rather use the synth_event_gen_cmd_start() wrapper, which
> @@ -1695,7 +1695,7 @@ __synth_event_trace_end(struct synth_eve
>   * synth_event_trace - Trace a synthetic event
>   * @file: The trace_event_file representing the synthetic event
>   * @n_vals: The number of values in vals
> - * @args: Variable number of args containing the event values
> + * @...: Variable number of args containing the event values
>   *
>   * Trace a synthetic event using the values passed in the variable
>   * argument list.


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

