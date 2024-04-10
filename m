Return-Path: <linux-kernel+bounces-139303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03A588A012D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 22:21:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 354551C23710
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 20:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC49C181BAE;
	Wed, 10 Apr 2024 20:21:00 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E7E1DFC7;
	Wed, 10 Apr 2024 20:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712780460; cv=none; b=I4SX3AkiCvTx8MFCKUozORiH8KN6dsT5/KRR9eXHpDGtam3xd3zqzh09UHceFfhcYEP+IHxpSn1zA8BtKFqvLqDxnPH4JHQmDR7dS8EJRY9fyGF1XoC1uPn7Zz6eRbyCiM+Co4cmnfJbA/gv7hONLvGSMDBGgQ7gZTXrYp2RVfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712780460; c=relaxed/simple;
	bh=NHRDwWW5UUprKx17r2oT7Bz2q4irLQyN/KXXpfQZsKw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qWUb4grt4qXagE5jSRQOYERAHxe9AdWBZS/94pNBNtAkevP8KWHUpb/08cdC7e/ni/y5+laUO3ibsxd8kmOSqOiHTaxUl2BvPSBI2Lw0R+1Qo6/ofl+EVRjd8J5mxp90eambSe3mUoLRO6CY+DsEk65GjcYF4zu9TgSlera65Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A2FDC433C7;
	Wed, 10 Apr 2024 20:20:59 +0000 (UTC)
Date: Wed, 10 Apr 2024 16:23:36 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Ali Zahraee <ahzahraee@gmail.com>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com, corbet@lwn.net,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, skhan@linuxfoundation.org,
 javier.carrasco.cruz@gmail.com
Subject: Re: [PATCH] Documentation: tracing: update format of sched_wakeup
 in example
Message-ID: <20240410162336.618371dd@gandalf.local.home>
In-Reply-To: <20240314144136.19727-1-ahzahraee@gmail.com>
References: <20240314144136.19727-1-ahzahraee@gmail.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 14 Mar 2024 15:41:36 +0100
Ali Zahraee <ahzahraee@gmail.com> wrote:

> The format of the sched_wakeup event is used as an example in the
> documentation. But the given format is obsolete. This patch updates the
> format in the example to match the current format of this event.
> 
> Signed-off-by: Ali Zahraee <ahzahraee@gmail.com>
> ---
>  Documentation/trace/events.rst | 25 +++++++++++++------------
>  1 file changed, 13 insertions(+), 12 deletions(-)
> 
> diff --git a/Documentation/trace/events.rst b/Documentation/trace/events.rst
> index 759907c20e75..65fe205c95e6 100644
> --- a/Documentation/trace/events.rst
> +++ b/Documentation/trace/events.rst
> @@ -129,24 +129,25 @@ event::
>  	# cat /sys/kernel/tracing/events/sched/sched_wakeup/format
>  
>  	name: sched_wakeup
> -	ID: 60
> +	ID: 70

Really don't need to change that, as it's defined at compile time and may
be different. For example, I have:

 system: sched
 name: sched_wakeup
 ID: 297


>  	format:
>  		field:unsigned short common_type;	offset:0;	size:2;
> +                	signed:0;

Don't line break the fields, as new lines are part of the format.


>  		field:unsigned char common_flags;	offset:2;	size:1;
> -		field:unsigned char common_preempt_count;	offset:3;	size:1;
> -		field:int common_pid;	offset:4;	size:4;
> -		field:int common_tgid;	offset:8;	size:4;
> +                	signed:0;
> +		field:unsigned char common_preempt_count;	offset:3;
> +                	size:1; signed:0;

Again, the above needs to be on one line.

Thanks,

-- Steve

> +		field:int common_pid;	offset:4;	size:4;	signed:1;
>  
> -		field:char comm[TASK_COMM_LEN];	offset:12;	size:16;
> -		field:pid_t pid;	offset:28;	size:4;
> -		field:int prio;	offset:32;	size:4;
> -		field:int success;	offset:36;	size:4;
> -		field:int cpu;	offset:40;	size:4;
> +		field:char comm[16];	offset:8;	size:16;	signed:0;
> +		field:pid_t pid;	offset:24;	size:4;	signed:1;
> +		field:int prio;	offset:28;	size:4;	signed:1;
> +		field:int target_cpu;	offset:32;	size:4;	signed:1;
>  
> -	print fmt: "task %s:%d [%d] success=%d [%03d]", REC->comm, REC->pid,
> -		   REC->prio, REC->success, REC->cpu
> +	print fmt: "comm=%s pid=%d prio=%d target_cpu=%03d", REC->comm, REC->pid,
> +        	        REC->prio, REC->target_cpu
>  
> -This event contains 10 fields, the first 5 common and the remaining 5
> +This event contains 8 fields, the first 4 common and the remaining 4
>  event-specific.  All the fields for this event are numeric, except for
>  'comm' which is a string, a distinction important for event filtering.
>  


