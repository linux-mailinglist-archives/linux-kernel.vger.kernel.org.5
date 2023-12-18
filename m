Return-Path: <linux-kernel+bounces-4479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EE9C817E0A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 00:23:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E38811F25494
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 23:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F818760B3;
	Mon, 18 Dec 2023 23:23:33 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F1176096;
	Mon, 18 Dec 2023 23:23:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DDE0C433C7;
	Mon, 18 Dec 2023 23:23:31 +0000 (UTC)
Date: Mon, 18 Dec 2023 18:24:28 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH v2] ring-buffer: Add interrupt information to dump of
 data sub-buffer
Message-ID: <20231218182428.4469d2b3@gandalf.local.home>
In-Reply-To: <20231218170106.46fe24a7@gandalf.local.home>
References: <20231218170106.46fe24a7@gandalf.local.home>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 18 Dec 2023 17:01:06 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> @@ -3347,7 +3418,8 @@ static void check_buffer(struct ring_buffer_per_cpu *cpu_buffer,
>  		}
>  	}
>  	if ((full && ts > info->ts) ||
> -	    (!full && ts + info->delta != info->ts)) {
> +	    (!full && ts + info->delta != info->ts) ||
> +		e > 0xfa0) {
>  		/* If another report is happening, ignore this one */
>  		if (atomic_inc_return(&ts_dump) != 1) {
>  			atomic_dec(&ts_dump);

Oops, I accidentally committed the "add this to force a dump" code :-p

Will send a v3 soon.

-- Steve

